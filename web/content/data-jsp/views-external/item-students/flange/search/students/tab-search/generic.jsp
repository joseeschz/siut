<script type="text/javascript">
    $(document).ready(function () {
        $('#careerFilter').on('change',function (event){         
            initWidgets(0);            
        });
        $('#periodFilter').on('change',function (event){         
            initWidgets(0);            
        });
        
        var initDataTable = function () {
            var url = "../serviceStudent?selectAllStudents";
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                    { name: 'dataProgresivNumber', type: 'int' },
                    { name: 'dataPkStudent', type: 'string' },
                    { name: 'dataName', type: 'string' },
                    { name: 'dataEnrollment', type: 'string' },
                    { name: 'dataNameCareer', type: 'string' },
                    { name: 'dataNameCareerAbbreviated', type: 'string' },
                    { name: 'dataNameGroup', type: 'string' },
                    { name: 'dataNameSemester', type: 'string' }
                ],
                id: 'dataPkStudent',
                url: url
            };
            var dataAdapter = new $.jqx.dataAdapter(source);
            $("#jqxDataTableSearch").jqxDataTable({
                width: 900,
                height: 500, 
                pageable: false,
                localization: getLocalization("es"),
                source: dataAdapter,
                filterable: true,
                sortable: true,
                columns: [
                    { text: 'N.P', datafield: 'dataProgresivNumber', width: 40, align: "center", cellsalign: "center", resizable: false, sortable: false,  filterable: false },
                    { text: 'Matrícula', datafield: 'dataEnrollment', width: 130, align: "center", cellsalign: "center", resizable: false },
                    { text: 'Nombre', datafield: 'dataName', width: 'auto'}, 
                    { text: 'Carrera', datafield: 'dataNameCareer', width: 'auto', align: "center", filterable: false}, 
                    { text: 'Cuatrimestre Actual', datafield: 'dataNameSemester', width: 150, align: "center", cellsalign: "center", filterable: false},
                    { text: 'Grupo Actual', datafield: 'dataNameGroup', width: 100, align: "center", cellsalign: "center", filterable: false}
                ]
            });
        };

        // create context menu
        var contextMenu = $("#jqxMenuContext").jqxMenu({ 
            width: 200, 
            height: "auto", 
            autoOpenPopup: false, 
            mode: 'popup'
        });
        var popupWindow = $("#popupWindowDoc").jqxWindow({ 
            width: 800,
            minWidth: '1200px',
            height: 800,
            minHeight: '850px', 
            resizable: false, 
            isModal: true, 
            autoOpen: false, 
            modalOpacity: 0.7 
        });

        $("#jqxDataTableSearch").on('contextmenu', function () {
            return false;
        });
        var pt_enrollment=undefined;
        $('#jqxDataTableSearch').on('rowSelect', function (event){
            contextMenu.jqxMenu('close');
        });
        $("#jqxDataTableSearch").on('rowClick', function (event) {
            if (event.args.originalEvent.button==2) {
                $("#jqxDataTableSearch").jqxDataTable('selectRow', event.args.rowindex);
                var row = event.args.row;
                pt_pk_student=row.dataPkStudent;
                pt_enrollment=row.dataEnrollment;
                var scrollTop = $(window).scrollTop();
                var scrollLeft = $(window).scrollLeft();
                contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                return false;
            }
        });
        // handle context menu clicks.
        contextMenu.on('itemclick', function (event) {
            var args = event.args;
            if ($.trim($(args).text()) === "Ficha Informativa") {
                $.ajax({
                    type: "POST",
                    async: false,
                    url: "../../content/data-jr/documentInformativeFiles/index.jsp?documentInformativeFile",
                    data: {"pt_enrollment": pt_enrollment},
                    beforeSend: function (xhr) {
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        alert("Error interno del servidor");
                    },
                    success: function (data, textStatus, jqXHR) {
                        var iframe = $('<iframe style="width: 1185px; height: 810px;">');
                        iframe.attr('src','../../content/data-jr/documentInformativeFiles/index.jsp');
                        $('#contentPDF').html(iframe);
                    }
                });
                popupWindow.jqxWindow('show');
            }           
        });
        // init widgets.
        var initWidgets = function (tab) {
            switch (tab) {
                case 0:
                    initDataTable();
                    break;
            }
        };
        initDataTable();
//        $('#jqxSubTabs').jqxTabs({ width: 750, height: 560,  initTabContent: initWidgets });
    });
</script>
<div style="float: left; margin-right: 5px" id="jqxDataTableSearch"></div>
<div id='jqxMenuContext'>
    <ul>
        <li>Ficha Informativa</li>
    </ul>
</div>
<div id="popupWindowDoc">
    <div>Documento</div>
    <div style="overflow: hidden;" id="contentPDF">
    </div>
</div>