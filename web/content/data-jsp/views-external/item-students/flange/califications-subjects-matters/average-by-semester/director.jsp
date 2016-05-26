<script>
    $(document).ready(function () {
        var itemLevel = 0;
        var itemCareer = 0;
        var itemStudyPlan = 0;
        var itemPeriod = 0;
        var itemGroup = 0;
        var itemSemester = 0;
        
        var buttonTemplate = "<div style='float: left; padding: 3px; margin: 2px;'><div style='margin: 4px; width: 16px; height: 16px;'></div></div>";
        var exportButton = $(buttonTemplate);
        var container = $("<div class='container' style='overflow: hidden; position: relative; height: 100%; width: 100%;'></div>");
        
        createDropDownStudyLevelByDirector("#qualificationsLevelFilter",false);
        itemLevel = $('#qualificationsLevelFilter').jqxDropDownList('getSelectedItem');
        if(itemLevel!==undefined){
            createDropDownPeriod("comboActiveYear","#qualificationsPeriodFilter");
            itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');   
            $('#qualificationsPeriodFilter').jqxDropDownList({width: 180});
            createDropDownCareerByDirector(itemLevel.value ,"#qualificationsCareerFilter",false);
            itemCareer = $('#qualificationsCareerFilter').jqxDropDownList('getSelectedItem');
            if(itemCareer!==undefined){
                createDropDownStudyPlan(itemCareer.value,"#qualificationsStudyPlanFilter",false);
                itemStudyPlan = $('#qualificationsStudyPlanFilter').jqxDropDownList('getSelectedItem');                
                if(itemStudyPlan!==undefined){
                    var filtrableSemester = {
                        pkCareer : itemCareer.value,
                        pkPeriod : itemPeriod.value,
                        pkStudyPlan : itemStudyPlan.value
                    };
                    createDropDownCurrentSemester("#qualificationsSemesterFilter", filtrableSemester,  false);
                    itemSemester = $('#qualificationsSemesterFilter').jqxDropDownList('getSelectedItem');
                    if(itemSemester!==undefined){   
                        var filtrableGroup = {
                            pkCareer : itemCareer.value,
                            pkSemester : itemSemester.value,
                            pkPeriod : itemPeriod.value
                        };
                        createDropDownGruopByCurrentSemester("#qualificationsGroupFilter", filtrableGroup, false);
                        itemGroup = $('#qualificationsGroupFilter').jqxDropDownList('getSelectedItem');                    
                        if(itemGroup!=undefined || itemGroup!=null){
                            var filtrableSubjectMatters = {
                                pkCareer : itemCareer.value,
                                pkSemester : itemSemester.value,
                                pkStudyPlan : itemStudyPlan.value,
                                pkPeriod : itemPeriod.value
                            };
                            if(itemGroup!=undefined || itemGroup!=null){
                                loadGridCalifications();
                            }else{
                                $("#tableQualifications").parent().hide();
                            }
                        } 
                    }else{
                        createDropDownGruopByCurrentSemester("#qualificationsGroupFilter", {}, false);
                        $("#tableQualifications").parent().hide();
                    }
                }else{
                    createDropDownCurrentSemester("#qualificationsSemesterFilter",{},false);
                    createDropDownGruopByCurrentSemester("#qualificationsGroupFilter",{}, false);
                    $("#tableQualifications").parent().hide();
                }
                $('#qualificationsLevelFilter').on('change',function (event){  
                    itemLevel = $('#qualificationsLevelFilter').jqxDropDownList('getSelectedItem');
                    if(itemLevel!=undefined){
                        createDropDownCareerByDirector(itemLevel.value ,"#qualificationsCareerFilter",true);
                        itemCareer = $('#qualificationsCareerFilter').jqxDropDownList('getSelectedItem');
                        if(itemCareer!=undefined || itemCareer!=null){
                            itemSemester = $('#qualificationsSemesterFilter').jqxDropDownList('getSelectedItem'); 
                            if(itemSemester==null || itemSemester==undefined){
                                createDropDownGruopByCurrentSemester("#qualificationsGroupFilter",{}, true);
                                $("#tableQualifications").parent().hide();
                            }
                        }else{
                            createDropDownCurrentSemester("#qualificationsSemesterFilter",{},true);
                            createDropDownGruopByCurrentSemester("#qualificationsGroupFilter",{}, true);
                            $("#tableQualifications").parent().hide();
                        }
                    }else{
                        createDropDownCareerByDirector(null ,"#qualificationsCareerFilter",true);
                        createDropDownCurrentSemester("#qualificationsSemesterFilter",{},true);
                        createDropDownGruopByCurrentSemester("#qualificationsGroupFilter",{}, true); 
                        $("#tableQualifications").parent().hide();
                    }
                });
                $('#qualificationsPeriodFilter').on('change',function (event){  
                    itemLevel = $('#qualificationsLevelFilter').jqxDropDownList('getSelectedItem');
                    if(itemLevel!=undefined){
                        itemCareer = $('#qualificationsCareerFilter').jqxDropDownList('getSelectedItem');
                        itemStudyPlan = $('#qualificationsStudyPlanFilter').jqxDropDownList('getSelectedItem');
                        itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');
                        if(itemCareer!=undefined){                        
                            var filtrableSemester = {
                                pkCareer : itemCareer.value,
                                pkStudyPlan : itemStudyPlan.value,
                                pkPeriod : itemPeriod.value
                            };
                            createDropDownCurrentSemester("#qualificationsSemesterFilter", filtrableSemester, true);
                            itemSemester = $('#qualificationsSemesterFilter').jqxDropDownList('getSelectedItem'); 
                            if(itemSemester==null || itemSemester==undefined){
                                createDropDownGruopByCurrentSemester("#qualificationsGroupFilter",{}, true);
                                $("#tableQualifications").parent().hide();
                            }
                        }else{
                            createDropDownCurrentSemester("#qualificationsSemesterFilter",{},true);
                            createDropDownGruopByCurrentSemester("#qualificationsGroupFilter",{}, true);
                            $("#tableQualifications").parent().hide();
                        }
                    }else{
                        createDropDownCurrentSemester("#qualificationsSemesterFilter",{},true);
                        createDropDownGruopByCurrentSemester("#qualificationsGroupFilter",{}, true);
                        $("#tableQualifications").parent().hide();
                    }
                });
                $('#qualificationsCareerFilter').on('change',function (event){  
                    var args = event.args;
                    if (args) {
                        // index represents the item's index.                      
                        var index = args.index;
                        var item = args.item;
                        // get item's label and value.
                        var label = item.label;
                        var value = item.value;
                        var type = args.type; // keyboard, mouse or null depending on how the item was selected. 
                        itemCareer = $('#qualificationsCareerFilter').jqxDropDownList('getSelectedItem');
                        createDropDownStudyPlan(itemCareer.value,"#qualificationsStudyPlanFilter",true);
                        itemStudyPlan = $('#qualificationsStudyPlanFilter').jqxDropDownList('getSelectedItem');
                        if(itemStudyPlan==null || itemStudyPlan==undefined){
                            createDropDownCurrentSemester("#qualificationsSemesterFilter",{},false);
                            createDropDownGruopByCurrentSemester("#qualificationsGroupFilter",{}, false);
                            $("#tableQualifications").parent().hide();
                        }else{
                            itemSemester = $('#qualificationsSemesterFilter').jqxDropDownList('getSelectedItem');
                            if(itemSemester==null || itemSemester==undefined){
                                createDropDownGruopByCurrentSemester("#qualificationsGroupFilter",{}, true);
                                $("#tableQualifications").parent().hide();
                            }
                        }
                    }                
                });
                $('#qualificationsStudyPlanFilter').on('change',function (event){
                    var args = event.args;
                    if (args) {
                        // index represents the item's index.                      
                        var index = args.index;
                        var item = args.item;
                        // get item's label and value.
                        var label = item.label;
                        var value = item.value;
                        var type = args.type; // keyboard, mouse or null depending on how the item was selected.
                        itemCareer = $('#qualificationsCareerFilter').jqxDropDownList('getSelectedItem');
                        itemStudyPlan = $('#qualificationsStudyPlanFilter').jqxDropDownList('getSelectedItem');
                        itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');
                        var filtrableSemester = {
                            pkCareer : itemCareer.value,
                            pkStudyPlan : itemStudyPlan.value,
                            pkPeriod : itemPeriod.value
                        };
                        createDropDownCurrentSemester("#qualificationsSemesterFilter", filtrableSemester, true);
                        itemSemester = $('#qualificationsSemesterFilter').jqxDropDownList('getSelectedItem');
                        if(itemSemester==null || itemSemester==undefined){
                            createDropDownGruopByCurrentSemester("#qualificationsGroupFilter",{}, true);
                            $("#tableQualifications").parent().hide();
                        }
                    }   
                });
                $("#qualificationsSemesterFilter").on('change',function (event){
                    var args = event.args;
                    if (args) {
                        // index represents the item's index.                      
                        var index = args.index;
                        var item = args.item;
                        // get item's label and value.
                        var label = item.label;
                        var value = item.value;
                        var type = args.type; // keyboard, mouse or null depending on how the item was selected.
                        itemCareer = $('#qualificationsCareerFilter').jqxDropDownList('getSelectedItem');
                        itemStudyPlan = $('#qualificationsStudyPlanFilter').jqxDropDownList('getSelectedItem');
                        itemSemester = $('#qualificationsSemesterFilter').jqxDropDownList('getSelectedItem');
                        itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');
                        var filtrableGroup = {
                            pkCareer : itemCareer.value,
                            pkSemester : itemSemester.value,
                            pkPeriod : itemPeriod.value
                        };
                        createDropDownGruopByCurrentSemester("#qualificationsGroupFilter", filtrableGroup, true);  
                        itemGroup = $('#qualificationsGroupFilter').jqxDropDownList('getSelectedItem');
                    }
                });
                $("#qualificationsGroupFilter").on('change',function (event){  
                    var args = event.args;
                    if (args){
                        // index represents the item's index.                      
                        var index = args.index;
                        var item = args.item;
                        // get item's label and value.
                        var label = item.label;
                        var value = item.value;
                        var type = args.type; // keyboard, mouse or null depending on how the item was selected.    
                        loadGridCalifications();
                    }
                });
            }else{
                createDropDownCareerByDirector(null ,"#qualificationsCareerFilter",false);
                createDropDownCurrentSemester("#qualificationsSemesterFilter",{},false);
                createDropDownGruopByCurrentSemester("#qualificationsGroupFilter",{}, false);
            }     
        }else{
            createDropDownCareerByDirector(null ,"#qualificationsCareerFilter",false);
            createDropDownCurrentSemester("#qualificationsSemesterFilter",{},false);
            createDropDownGruopByCurrentSemester("#qualificationsGroupFilter",{}, false);
        }
        function loadSource(){
            itemCareer = $('#qualificationsCareerFilter').jqxDropDownList('getSelectedItem');
            itemSemester = $('#qualificationsSemesterFilter').jqxDropDownList('getSelectedItem');
            itemGroup = $('#qualificationsGroupFilter').jqxDropDownList('getSelectedItem');
            itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');            
            var ordersSource ={
                dataFields: [
                    { name: 'id', type:'int'},
                    { name: 'dataProgresivNumber', type:'int'},
                    { name: 'dataEnrollment', type: 'string' },
                    { name: 'dataFkStudent', type: 'int' },
                    { name: 'dataStudentName', type: 'string' },
                    { name: 'dataCalificationBe', type: 'double' },
                    { name: 'dataCalificationKnow', type: 'double' },
                    { name: 'dataCalificationDo', type: 'double' },
                    { name: 'dataAvg', type: 'double'}
                ],
                dataType: "json",
                async: false,
                url: '../serviceCalification?tableByAllCalificationsAverage',
                data : {
                    fkCareer : itemCareer.value,
                    fkPeriod : itemPeriod.value,
                    pkSemester : itemSemester.value,
                    fkGroup : itemGroup.value
                }
            };
            return ordersSource;
        }
        function loadGridCalifications(){
            var popoverrender = function (element){
                var desc = $(element.context.innerHTML).children("div").attr("desc");
                var htmlPopover = $('<div><div>'+desc+'</div></div>');
                htmlPopover.jqxPopover({offset: {left: 0, top:0}, width:150, isModal: true, arrowOffsetValue: 10, title: "Nombre", showCloseButton: true, selector: $(element.parent().parent()) });  
            };
            var cellclass = function (row, columnfield, value) {
                return 'grey';
            };
            var aggregates = ['avg'];
            var dataAdapter = new $.jqx.dataAdapter(loadSource(), {
                autoBind: true,
                beforeSend:function (){
                    $("#tableQualifications").jqxGrid('showloadelement');
                },
                beforeLoadComplete:function (){
                    $("#tableQualifications").jqxGrid('hideloadelement');
                },
                downloadComplete: function (data) {                    
                    //dataExternal=data;
                    var columns = data[0].columns;
//                    console.log(data[0].columns);
                    var dataFields = data[1].dataFields;
                    var rows = data[2].rowsCal;
                    var gridAdapter = new $.jqx.dataAdapter({
                        datafields: dataFields,
                        id: 'dataProgresivNumber',
                        localdata: rows
                    });
                    
                    var arr = columns;
                    var str = JSON.stringify(arr);
                    var newArr = JSON.parse(str);
                    for(var i=0;i<newArr.length; i++){
                        if(newArr[i].aggregates){
                            newArr[i].aggregates = eval(newArr[i].aggregates);
                        }
                        if(newArr[i].rendered){
                            newArr[i].rendered = eval(newArr[i].rendered);
                        }  
                        if(newArr[i].cellclassname){
                            newArr[i].cellclassname = eval(newArr[i].cellclassname);
                        }
                    }
                    columns=newArr;
                    $("#tableQualifications").parent().fadeIn();
                    $("#tableQualifications").jqxGrid('beginupdate', true);
                    $("#tableQualifications").jqxGrid({
                        width: 850,
                        height: 450,
                        selectionMode: "multiplerowsextended",
                        localization: getLocalization("es"),
                        source: gridAdapter,
                        pageable: false,
                        editable: false,
                        filterable: false,
//                        showstatusbar: true,
//                        showaggregates: true,
                        toolbarHeight: 35,
                        showToolbar: true,
                        renderToolbar: function(toolBar){
                            var theme = "";
                            var toTheme = function (className) {
                                if (theme === "") return className;
                                return className + " " + className + "-" + theme;
                            };
                            container.append(exportButton);
                            toolBar.append(container);
                            exportButton.jqxButton({cursor: "pointer", disabled: false, enableDefault: false,  height: 25, width: 25 });
                            exportButton.find('div:first').addClass(toTheme('jqx-icon-export'));
                            exportButton.jqxTooltip({ position: 'bottom', content: "Exportar a PDF"});
                            exportButton.attr("id","exportButton");       
                            exportButton.off("click");
                            exportButton.on("click",function (event) {
                                itemLevel = $('#qualificationsLevelFilter').jqxDropDownList('getSelectedItem');
                                itemCareer = $('#qualificationsCareerFilter').jqxDropDownList('getSelectedItem');
                                itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');
                                itemSemester = $('#qualificationsSemesterFilter').jqxDropDownList('getSelectedItem');
                                itemGroup = $('#qualificationsGroupFilter').jqxDropDownList('getSelectedItem');
                                $.ajax({
                                    url: "../content/data-jr/evaluationAllSubjectsIndicators/index.jsp?sessionCalificationsByStudentsAllMattersIndicators",
                                    data: {
                                        "pt_level": itemLevel.value,
                                        "pt_career": itemCareer.value,
                                        "pt_group": itemGroup.value,
                                        "pt_semester": itemSemester.value,
                                        "pt_period": itemPeriod.value
                                    },
                                    type: 'POST',
                                    beforeSend: function (xhr) {
                                    },
                                    success: function (data, textStatus, jqXHR) {
                                        window.open("../content/data-jr/evaluationAllSubjectsIndicators/");
                                    },
                                    error: function (jqXHR, textStatus, errorThrown) {
                                        alert("Error interno del servidor");                
                                    }
                                });
                            });   

                        },
                        ready: function(){
                            $("#tableQualifications").jqxGrid('focus');
                        },
                        columngroups: [
                            { text: 'Calificaciones Acumulado',  name: 'content_acumulated', cellsalign: 'center', align: 'center' },
                            { text: 'Materias', parentgroup: 'content_acumulated', name: 'acumulated', cellsalign: 'center', align: 'center' },
                            { text: 'Calificaciones Regularización', name: 'content_regularization', cellsalign: 'center', align: 'center' },
                            { text: 'Materias', parentgroup: 'content_regularization', name: 'regularization',  cellsalign: 'center', align: 'center'},
                            { text: 'Calificaciones Global', name: 'content_global', cellsalign: 'center', align: 'center' },
                            { text: 'Materias', parentgroup: 'content_global', name: 'global', cellsalign: 'center', align: 'center'},
                            { text: 'Calificaciones Acreditadas', name: 'content_final', cellsalign: 'center', align: 'center' },
                            { text: 'Materias', parentgroup: 'content_final', name: 'final', cellsalign: 'center', align: 'center'}
                        ],
                        columns: columns,
                        columnsresize: false
                    });
                    $("#tableQualifications").jqxGrid('endupdate');                    
                    $('#tableQualifications').jqxGrid('render');
                }
            });    
            
            
        }
    });
</script>
<style>
    .grey {
        color: black\9;
        background-color: #DADADA;
    }
    grey:not(.jqx-grid-cell-hover):not(.jqx-grid-cell-selected), .jqx-widget .grey:not(.jqx-grid-cell-hover):not(.jqx-grid-cell-selected) {
        color: black;
        background-color: #DADADA;
    }
</style>
<div style="display: inline-block; margin-right: 5px;">
    Nivel de estudio<br>
    <div id='qualificationsLevelFilter'></div>
</div>
<div style="display: inline-block; margin-right: 5px;">
    Carrera <br>
    <div id='qualificationsCareerFilter'></div>
</div>
<div style="display: inline-block; margin-right: 5px;">
    Plan de estudio<br>
    <div id='qualificationsStudyPlanFilter'></div>
</div>
<div style="display: inline-block; margin-right: 5px;">
    Periodo <br>
    <div id='qualificationsPeriodFilter'></div>
</div>
<div style="display: inline-block; margin-right: 5px;">
    Cuatrimestre<br>
    <div id='qualificationsSemesterFilter'></div>
</div>
<div style="display: inline-block; margin-right: 5px;">
    Grupo<br>
    <div id='qualificationsGroupFilter'></div>
</div>
<br><br>
<div style="display: inline-block; margin-right: 5px;">
    <div id="tableQualifications"></div>
</div>
<div id="popover"></div>
<style>
    .texto-vertical {
        writing-mode: vertical-lr;
        transform: rotate(180deg);
    }
</style>