<script>
    $(document).ready(function () {
        var itemPeriod = 0;
        $("#removeEnrollment").hide();
        loadGridStudents("");
        var enrollmentRecord_temp;
        createInputEnrrollment("#enrollmentRecord",false);
        $("#enrollmentRecord").on('select',function (event){
            var enrollment="";
            var pkStudent;
            if(event.args){
                var item = event.args.item;
                if(item){
                    pkStudent = item.value;
                    enrollment = item.label;
                    enrollmentRecord_temp=enrollment;
                }
            }
            if(enrollment.length>=3){
                $("#removeEnrollment").show();
                loadGridStudents(enrollmentRecord_temp);
            }
        });
        $("#removeEnrollment").click(function (){
            $(this).hide();
            loadGridStudents("");
            $('#enrollmentRecord').val("");
        });
        var popupWindow = $("#popupWindowConstancy").jqxWindow({ 
            width: 800,
            minWidth: '1200px',
            height: 800,
            minHeight: '850px', 
            resizable: false, 
            isModal: true, 
            autoOpen: false, 
            modalOpacity: 0.7 
        });
        function loadSource(enrollment){            
            var ordersSource ={
                dataFields: [
                    { name: 'dataProgresivNumber', type: 'int' },
                    { name: 'dataPkStudent', type: 'string' },
                    { name: 'dataEnrollment', type: 'string' },
                    { name: 'dataName', type: 'string' },
                    { name: 'dataPkLevelStudy', type: 'int' },
                    { name: 'dataNameLevel', type: 'string' },
                    { name: 'dataPkCareer', type: 'int' },
                    { name: 'dataNameCareer', type: 'string' }
                ],
                dataType: "json",
                id: "dataPkStudent",
                async: false,
                url: '../serviceStudent?selectStudentConstancy',
                data : {
                    enrollment : enrollment                    
                }
            };
            return ordersSource;
        }
        
        function loadGridStudents(enrollment){
            var dataAdapter = new $.jqx.dataAdapter(loadSource(enrollment));  
            var tooltiprenderer = function (element) {
                $(element).jqxTooltip({position: 'mouse', content: $(element).text() });
            };
            $("#tableGenerateRecord").jqxGrid({
                width: 900,
                height: 450,
                selectionMode: "singlerow",
                localization: getLocalization("es"),
                source: dataAdapter,
                pageable: false,
                editable: false,
                altRows: true,
                autorowheight: true,
                autoheight: true,
                ready: function(){
                    $("#tableGenerateRecord").jqxGrid('focus');
                },
                columns: [
                    { text: '#', align: 'center', cellsalign: 'center', dataField: 'dataProgresivNumber', width: 10, rendered: tooltiprenderer },
                    { text: 'Matrícula', align: 'center', dataField: 'dataEnrollment', width: 120, rendered: tooltiprenderer },
                    { text: 'Alumno', align: 'center', dataField: 'dataName', rendered: tooltiprenderer},
                    { text: 'Nivel de estudio', align: 'center', dataField: 'dataNameLevel', cellsalign: 'center', width: 150, rendered: tooltiprenderer},
                    { text: 'Carrera', align: 'center', dataField: 'dataNameCareer', width: 350, rendered: tooltiprenderer}
                ],
                columnsresize: false
            });
            $('#tableGenerateRecord').off('rowunselect');
            $('#tableGenerateRecord').on('rowunselect', function (event){
                // event arguments.
                var args = event.args;
                // row's bound index.
                var rowBoundIndex = args.rowindex;
                // row's data. The row's data object or null(when all rows are being selected or unselected with a single action). If you have a datafield called "firstName", to access the row's firstName, use var firstName = rowData.firstName;
                var rowData = args.row;
                if(args){
                    $("#tableGenerateRecord").jqxGrid('endcelledit', rowBoundIndex, "dataDown", false);
                }
            });
        }        
        var contextMenu = $("#contextMenu").jqxMenu({ width: 250, autoOpenPopup: false, mode: 'popup'});
        $("#tableGenerateRecord").on('contextmenu', function () {
            return false;
        });
        // handle context menu clicks.
        $("#contextMenu").on('itemclick', function (event) {
            var args = event.args;
            var rowindex = $("#tableGenerateRecord").jqxGrid('getselectedrowindex');
            var data = $('#tableGenerateRecord').jqxGrid('getrowdata', rowindex);
            if ($.trim($(args).text()) === "Contancia Simple"){
                $.ajax({
                    type: "POST",
                    async: false,
                    url: "../content/data-jr/constancySimple/index.jsp?constancySimple",
                    data: {
                        "pt_enrollment": data.dataEnrollment
                    },
                    beforeSend: function (xhr) {
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        alert("Error interno del servidor");
                    },
                    success: function (data, textStatus, jqXHR) {                        
                        var iframe = $('<iframe style="width: 1185px; height: 810px;">');
                        iframe.attr('src','../content/data-jr/constancySimple/');
                        $('#contentPDF').html(iframe);
                        popupWindow.jqxWindow('open');
                    }
                });               
            }else if ($.trim($(args).text()) === "Contancia con Calificaciones"){
                $.ajax({
                    type: "POST",
                    async: false,
                    url: "../content/data-jr/constancyRecordsCalifications/index.jsp?constancyRecordsCalifications",
                    data: {
                        "pt_enrollment": data.dataEnrollment
                    },
                    beforeSend: function (xhr) {
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        alert("Error interno del servidor");
                    },
                    success: function (data, textStatus, jqXHR) {                        
                        var iframe = $('<iframe style="width: 1185px; height: 810px;">');
                        iframe.attr('src','../content/data-jr/constancyRecordsCalifications/');
                        $('#contentPDF').html(iframe);
                        popupWindow.jqxWindow('open');
                    }
                });      
            }
        });
        $("#tableGenerateRecord").on('rowclick', function (event) {
            if (event.args.rightclick) {                
                $("#tableGenerateRecord").jqxGrid('selectrow', event.args.rowindex);                
                var scrollTop = $(window).scrollTop();
                var scrollLeft = $(window).scrollLeft();
                contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                return false;
            }
        });
    });
</script>
<div style="display: inline-block; width: 316px; height: 28px; position: relative;">
    <div style="float: left;">
        <span>Matrícula</span>
        <br>
        <input type="text" id="enrollmentRecord" style="width: 140px; height: 26px" class="text-input" />
        <span id="removeEnrollment" style="cursor: pointer; font-size: 16px; position: absolute; right: 135px; top: 21px; display: block;">X</span>
    </div>
</div>
<br>
<br>
<div style="display: inline-block; margin-right: 5px;">
    <div id="tableGenerateRecord"></div>
</div>

<div id='contextMenu'>
    <ul>
        <li id="constancySimple">Contancia Simple</li>
        <li id="constancyCalifications">Contancia con Calificaciones</li>
    </ul>
</div>
<div id="popupWindowConstancy">
    <div>Documento</div>
    <div style="overflow: hidden;" id="contentPDF">
    </div>
</div>