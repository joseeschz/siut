<script type="text/javascript">
    $(document).ready(function () {
        var initDataTable = function () {
            var url = "../serviceCandidate?selectCandidatesInscription";
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                    { name: 'fl_folioSystem_temp_system', type: 'string' },
                    { name: 'fl_utsem_folioSystem', type: 'string' },
                    { name: 'fl_register_date', type: 'string' },
                    { name: 'fl_name', type: 'string' },
                    { name: 'fl_career', type: 'string' }
                ],
                id: 'id',
                url: url
            };
            var dataAdapter = new $.jqx.dataAdapter(source);
            $("#jqxDataTablePreregisters").jqxDataTable({
                width: 748,
                height: 521, 
                pageable: true,
                localization: getLocalization("es"),
                source: dataAdapter,
                filterable: true,
                columns: [
                    { text: 'Nombre', datafield: 'fl_name', width: 'auto', filterable: false },
                    { text: 'Carrera', datafield: 'fl_career', width: 120,cellsalign: 'center' },
                    { text: 'Fecha registro', datafield: 'fl_register_date', width: 120, resizable: false, filterable: false },
                    { text: 'Folio Utsem', datafield: 'fl_utsem_folioSystem', width: 110, resizable: false},
                    { text: 'Folio Sistema', datafield: 'fl_folioSystem_temp_system', width: 110, resizable: false }
                ]
            });
        };
        // create context menu
        var contextMenu = $("#jqxMenuContext").jqxMenu({ 
            width: 150, 
            height: 65, 
            autoOpenPopup: false, 
            mode: 'popup'
        });
        contextMenu.jqxMenu('disable', 'options', true); 
        // initialize the popup window and buttons.
        var popupWindow = $("#popupWindowCedule").jqxWindow({ 
            width: 800,
            minWidth: '1200px',
            height: 800,
            minHeight: '850px', 
            resizable: false, 
            isModal: true, 
            autoOpen: false, 
            modalOpacity: 0.7 
        });
        $("#jqxDataTablePreregisters").on('contextmenu', function () {
            return false;
        });
        var fl_folioSystem_temp_system=undefined;
        $('#jqxDataTablePreregisters').on('rowSelect', function (event){
            contextMenu.jqxMenu('close');
        });
        $('#jqxDataTablePreregisters').on('rowDoubleClick', function (event){
            var row = event.args.row;
            fl_folioSystem_temp_system=row.fl_folioSystem_temp_system;
            $.ajax({
                type: "POST",
                async: true,
                url: "../servicePdf?cedule=session",
                data: {"folioSystem": fl_folioSystem_temp_system},
                beforeSend: function (xhr) {
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert("Error interno del servidor");
                },
                success: function (data, textStatus, jqXHR) {
                    var iframe = $('<iframe style="width: 1185px; height: 810px;">');
                    iframe.attr('src','../servicePdf?cedule=print');
                    $('#contentPDF').html(iframe);
                }
            });
            popupWindow.jqxWindow('show');
        });
        $("#jqxDataTablePreregisters").on('rowClick', function (event) {
            if (event.args.originalEvent.button==2) {
                $("#jqxDataTablePreregisters").jqxDataTable('selectRow', event.args.rowindex);
                var row = event.args.row;
                fl_folioSystem_temp_system=row.fl_folioSystem_temp_system;
                var scrollTop = $(window).scrollTop();
                var scrollLeft = $(window).scrollLeft();
                contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                return false;
            }
        });
        // handle context menu clicks.
        contextMenu.on('itemclick', function (event) {
            var args = event.args;
            if ($.trim($(args).text()) === "Generar Cédula") {
                $.ajax({
                    type: "POST",
                    async: false,
                    url: "../servicePdf?cedule=session",
                    data: {"folioSystem": fl_folioSystem_temp_system},
                    beforeSend: function (xhr) {
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        alert("Error interno del servidor");
                    },
                    success: function (data, textStatus, jqXHR) {
                        var iframe = $('<iframe style="width: 1185px; height: 810px;">');
                        iframe.attr('src','../servicePdf?cedule=print');
                        $('#contentPDF').html(iframe);
                    }
                });
                popupWindow.jqxWindow('show');
            }
        });

        initDataTable();
    });
</script>
<div id="jqxDataTablePreregisters"></div>
<div id='jqxMenuContext'>
    <ul>
        <li id="options"><span>Opciones</span></li>
        <li type='separator'></li>
        <li>Generar Cédula</li>
    </ul>
</div>
<div id="popupWindowCedule">
    <div>Cédula</div>
    <div style="overflow: hidden;" id="contentPDF">
    </div>
</div>