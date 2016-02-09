<script type="text/javascript">
    $(document).ready(function () {
        var itemLevel = 0;
        var itemCareer = 0;
        var itemPeriod = 0;
        createDropDownStudyLevel("#levelFilter",false);
        itemLevel = $('#levelFilter').jqxDropDownList('getSelectedItem');
        if(itemLevel!==undefined){
            createDropDownCareer( itemLevel.value ,"#careerFilter",false);
            createDropDownPeriod("inscription","#periodFilter");
        }else{
            createDropDownCareer( null ,"#careerFilter",false);
        }        
        $('#levelFilter').on('change',function (event){  
            itemLevel = $('#levelFilter').jqxDropDownList('getSelectedItem');
            createDropDownCareer( itemLevel.value ,"#careerFilter", true);
        });
        $('#careerFilter').on('change',function (event){         
            initWidgets(0);            
        });
        $('#periodFilter').on('change',function (event){         
            initWidgets(0);            
        });
        
        var initDataTable = function () {
            itemPeriod = $('#periodFilter').jqxDropDownList('getSelectedItem');
            itemCareer = $('#careerFilter').jqxDropDownList('getSelectedItem');
            var url = "../serviceStudent?selectStudents";
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                    { name: 'pk_student', type: 'string' },
                    { name: 'fl_enrollment', type: 'string' },
                    { name: 'fl_folio_utsem', type: 'string' },
                    { name: 'fl_name', type: 'string' }
                ],
                id: 'id',
                url: url,
                data :{
                    "pt_period":itemPeriod.value,
                    "pt_career":itemCareer.value
                }
            };
            var dataAdapter = new $.jqx.dataAdapter(source);
            $("#jqxDataTableEnrolled").jqxDataTable({
                width: 748,
                height: 500, 
                pageable: true,
                localization: getLocalization("es"),
                source: dataAdapter,
                filterable: true,
                columns: [
                    { text: 'Matrícula', datafield: 'fl_enrollment', width: 180, resizable: false },
                    { filterable: false, text: 'Nombre', datafield: 'fl_name', width: 'auto'},
                    { filterable: false, text: 'Folio Utsem', datafield: 'fl_folio_utsem', width: 110, resizable: false}                    
                ]
            });
        };
        var initChart = function () {
            var source =
            {
                datatype: "csv",
                datafields: [
                    { name: 'Carrera' },
                    { name: 'goal' },
                    { name: 'progress' }
                ],
                url: '../gdp_dept_2010.txt'
            };
            var dataAdapter = new $.jqx.dataAdapter(source, { 
                async: false, 
                autoBind: true, 
                loadError: function (xhr, status, error) { 
                    alert('Error loading "' + source.url + '" : ' + error); 
                } 
            });
            var settings = {
                title: "Metas y Progresos",
                description: "Preinscripsiones UTsem",
                showLegend: true,
                enableAnimations: true,
                padding: { left: 5, top: 5, right: 5, bottom: 5 },
                titlePadding: { left: 0, top: 0, right: 0, bottom: 10 },
                source: dataAdapter,
                xAxis:
                {
                    position: 'top',
                    dataField: 'Carrera',
                    gridLines: { visible: true }
                },
                colorScheme: 'scheme05',
                seriesGroups:
                    [
                        {
                            type: 'column',
                            columnsGapPercent: 50,
                            valueAxis:
                            {
                                title: { text: 'Rangos con tope de registro' }
                            },
                            series: [
                                {
                                    dataField: 'goal',
                                    displayText: 'Metas',
                                    labels: {
                                        visible: true,
                                        verticalAlignment: 'top',
                                        offset: { x: -10, y: -20 }
                                    },
                                    formatFunction: function (value) {
                                        return Math.round(value) + 'MR';
                                    }
                                },
                                {
                                    dataField: 'progress',
                                    displayText: 'Progreso',
                                    labels: { 
                                        visible: true,
                                        verticalAlignment: 'top',
                                        offset: { x: 10, y: -20 }
                                    },
                                    formatFunction: function (value) {
                                        return Math.round(value) + 'RP';
                                    }
                                }
                            ]
                        }
                    ]
            };
            // setup the chart
            $('#jqxChart').jqxChart(settings);
        };
        // create context menu
        var contextMenu = $("#jqxMenuContext").jqxMenu({ 
            width: 200, 
            height: 130, 
            autoOpenPopup: false, 
            mode: 'popup'
        });
//        contextMenu.jqxMenu('disable', 'options', true); 
//        contextMenu.jqxMenu('disable', 'add', true); 
//        contextMenu.jqxMenu('disable', 'generate', true); 
        // initialize the popup window and buttons.
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
        var popupWindowExpedient = $("#popupWindowExpedient").jqxWindow({ 
            width: 860,
            minWidth: '1050px',
            height: 525,
            resizable: false, 
            isModal: true, 
            autoOpen: false, 
            modalOpacity: 0.7 
        });
        $("#jqxDataTableEnrolled").on('contextmenu', function () {
            return false;
        });
        var pt_pk_student=undefined;
        var pt_enrollment=undefined;
        $('#jqxDataTableEnrolled').on('rowSelect', function (event){
            contextMenu.jqxMenu('close');
        });
        $('#jqxDataTableEnrolled').on('rowDoubleClick', function (event){
            var row = event.args.row;
            pt_pk_student=row.pk_student;
            $.ajax({
                type: "POST",
                async: false,
                url: "../content/data-jsp/views-external/item-students/flange/inscriptions/enrolled/tab-enrolled/expedient.jsp",
                data: {"pt_pk_student": pt_pk_student},
                beforeSend: function (xhr) {
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert("Error interno del servidor");
                },
                success: function (data, textStatus, jqXHR) {
                    $('#contentExpedient').html(data);
                }
            });
            popupWindowExpedient.jqxWindow('show');
            
        });
        $("#jqxDataTableEnrolled").on('rowClick', function (event) {
            if (event.args.originalEvent.button==2) {
                $("#jqxDataTableEnrolled").jqxDataTable('selectRow', event.args.rowindex);
                var row = event.args.row;
                pt_pk_student=row.pk_student;
                pt_enrollment=row.fl_enrollment;
                var scrollTop = $(window).scrollTop();
                var scrollLeft = $(window).scrollLeft();
                contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                return false;
            }
        });
        // handle context menu clicks.
        contextMenu.on('itemclick', function (event) {
            var args = event.args;
            if ($.trim($(args).text()) === "Expediente") {
                $.ajax({
                    type: "POST",
                    async: false,
                    url: "../../content/data-jr/expedientDigital/index.jsp?sessionExpedientDigital",
                    data: {"pt_pk_student": pt_pk_student},
                    beforeSend: function (xhr) {
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        alert("Error interno del servidor");
                    },
                    success: function (data, textStatus, jqXHR) {
                        var iframe = $('<iframe style="width: 1185px; height: 810px;">');
                        iframe.attr('src','../../content/data-jr/expedientDigital/index.jsp');
                        $('#contentPDF').html(iframe);
                    }
                });
                popupWindow.jqxWindow('show');
            }
            if ($.trim($(args).text()) === "Cédula") {
                $.ajax({
                    type: "POST",
                    async: false,
                    url: "../../content/data-jr/documentRegister/index.jsp?sessionCedule",
                    data: {"pt_enrollment": pt_enrollment},
                    beforeSend: function (xhr) {
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        alert("Error interno del servidor");
                    },
                    success: function (data, textStatus, jqXHR) {
                        var iframe = $('<iframe style="width: 1185px; height: 810px;">');
                        iframe.attr('src','../../content/data-jr/documentRegister/index.jsp');
                        $('#contentPDF').html(iframe);
                    }
                });
                popupWindow.jqxWindow('show');
            }
            if ($.trim($(args).text()) === "Cotejo de documentos") {
                $.ajax({
                    type: "POST",
                    async: false,
                    url: "../../content/data-jr/documentsAgreement/index.jsp?SessionDocumentsAgreement",
                    data: {"pt_pk_student": pt_pk_student},
                    beforeSend: function (xhr) {
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        alert("Error interno del servidor");
                    },
                    success: function (data, textStatus, jqXHR) {
                        var iframe = $('<iframe style="width: 1185px; height: 810px;">');
                        iframe.attr('src','../../content/data-jr/documentsAgreement/index.jsp');
                        $('#contentPDF').html(iframe);
                    }
                });
                popupWindow.jqxWindow('show');
            }
            if ($.trim($(args).text()) === "Carta compromiso") {
                $.ajax({
                    type: "POST",
                    async: false,
                    url: "../../content/data-jr/letterCommitment/index.jsp?sessionLetterCommitment",
                    data: {"pt_pk_student": pt_pk_student},
                    beforeSend: function (xhr) {
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        alert("Error interno del servidor");
                    },
                    success: function (data, textStatus, jqXHR) {
                        var iframe = $('<iframe style="width: 1185px; height: 810px;">');
                        iframe.attr('src','../../content/data-jr/letterCommitment/index.jsp');
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
                case 1:
                    initChart();
                    break;
            }
        };
        $('#jqxSubTabs').jqxTabs({ width: 750, height: 560,  initTabContent: initWidgets });
    });
</script>
<div style="float: left; margin-right: 5px;">
    Nivel de estudio<br>
    <div id='levelFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Carrera <br>
    <div id='careerFilter'></div>
</div>
<div style="float: right; margin-right: 5px;">
    Periodo <br>
    <div id='periodFilter'></div>
</div>
<div id='jqxSubTabs'>
    <ul style="margin: 0px;">
        <li style="margin-left: 10px;">
            Registros
        </li>
<!--        <li>
            Gráfica
        </li>-->
    </ul>
    <div style="overflow: hidden;">
        <div id="jqxDataTableEnrolled"></div>
    </div>
<!--    <div style="overflow: hidden;">
        <div style="border:none; width: 720px; height: 500px;" id="jqxChart"></div>
    </div>-->
</div>
<div id='jqxMenuContext'>
    <ul>
        <li>Expediente</li>
        <li>Cédula</li>
        <li>Carta compromiso</li>
        <li>Cotejo de documentos</li>
    </ul>
</div>
<div id="popupWindowExpedient">
    <div>Expediente</div>
    <div style="overflow: hidden;" id="contentExpedient">
    </div>
</div>
<div id="popupWindowDoc">
    <div>Documento</div>
    <div style="overflow: hidden;" id="contentPDF">
    </div>
</div>