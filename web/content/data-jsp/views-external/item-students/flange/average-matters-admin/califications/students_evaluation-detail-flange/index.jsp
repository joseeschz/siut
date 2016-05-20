<script>
    $(document).ready(function () {
        var itemLevel = 0;
        var itemCareer = 0;
        var itemStudyPlan = 0;
        var itemPeriod = 0;
        var itemGroup = 0;
        var itemSemester = 0;
        var itemSubjectMatter = 0;
        var itemTypeEvaluation = 0;
        
        var buttonTemplate = "<div style='float: left; padding: 3px; margin: 2px;'><div style='margin: 4px; width: 16px; height: 16px;'></div></div>";
        var lockButton = $(buttonTemplate);
        var unlockButton = $(buttonTemplate);
        var showButton = $(buttonTemplate);
        var exportButton = $(buttonTemplate);
        var infoButton = $(buttonTemplate);
        var infoElaborateDate = $('<div style="float: left; margin-right: 5px;">Fecha de Elaboración<br><div class="calendarInput" id="datePrint"></div><span>DD-MM-AAAA</span></div>');
        var container = $("<div class='container' style='overflow: hidden; position: relative; height: 100%; width: 100%;'></div>");
        
        createDropDownStudyLevel("#qualificationsLevelFilter",false);
        itemLevel = $('#qualificationsLevelFilter').jqxDropDownList('getSelectedItem');
        if(itemLevel!==undefined){
            createDropDownPeriod("comboActiveYear","#qualificationsPeriodFilter");
            itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');   
            $('#qualificationsPeriodFilter').jqxDropDownList({width: 180});
            createDropDownCareer(itemLevel.value ,"#qualificationsCareerFilter",false);
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
                            createDropDownSubjectMatterByCurrentSemester("#qualificationsSubjectMatterFilter", filtrableSubjectMatters, false);
                            $("#qualificationsSubjectMatterFilter").jqxDropDownList({width: 330});
                            itemSubjectMatter = $('#qualificationsSubjectMatterFilter').jqxDropDownList('getSelectedItem');
                            if(itemSubjectMatter!=undefined || itemSubjectMatter!=null){   
                                itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');
                                itemSubjectMatter=$('#qualificationsSubjectMatterFilter').jqxDropDownList('getSelectedItem');  
                                itemGroup = $('#qualificationsGroupFilter').jqxDropDownList('getSelectedItem');
                                var data = {
                                    "fkGroup":itemGroup.value,
                                    "fkMatter":itemSubjectMatter.value,
                                    "fkPeriod":itemPeriod.value
                                };
                                createDropDownEvaluationType("#qualificationsCalEvaluationType", data, false);
                                if(itemTypeEvaluation!=undefined || itemTypeEvaluation!=null){
                                    loadGridCalifications();
                                }else{
                                    $("#tableQualifications").parent().hide();
                                }
                            }else{
                                createDropDownEvaluationType("#qualificationsCalEvaluationType",{}, false);
                                $("#tableQualifications").parent().hide();
                            }
                        }else{
                            createDropDownSubjectMatterByCurrentSemester("#qualificationsSubjectMatterFilter", {}, false);
                            $("#qualificationsSubjectMatterFilter").jqxDropDownList({width: 330});
                            createDropDownEvaluationType("#qualificationsCalEvaluationType",{}, false);
                            $("#tableQualifications").parent().hide();
                        } 
                    }else{
                        createDropDownGruopByCurrentSemester("#qualificationsGroupFilter", {}, false);
                        createDropDownSubjectMatterByCurrentSemester("#qualificationsSubjectMatterFilter", {}, false);
                        $("#qualificationsSubjectMatterFilter").jqxDropDownList({width: 330});
                        createDropDownEvaluationType("#qualificationsCalEvaluationType",{}, false);
                        $("#tableQualifications").parent().hide();
                    }
                }else{
                    createDropDownCurrentSemester("#qualificationsSemesterFilter",{},false);
                    createDropDownGruopByCurrentSemester("#qualificationsGroupFilter",{}, false);
                    createDropDownSubjectMatterByCurrentSemester("#qualificationsSubjectMatterFilter", {}, false);
                    $("#qualificationsSubjectMatterFilter").jqxDropDownList({width: 330});
                    createDropDownEvaluationType("#qualificationsCalEvaluationType", {}, false);  
                    $("#tableQualifications").parent().hide();
                }
                $('#qualificationsLevelFilter').on('change',function (event){  
                    itemLevel = $('#qualificationsLevelFilter').jqxDropDownList('getSelectedItem');
                    if(itemLevel!=undefined){
                        createDropDownCareer(itemLevel.value ,"#qualificationsCareerFilter",true);
                        itemCareer = $('#qualificationsCareerFilter').jqxDropDownList('getSelectedItem');
                        if(itemCareer!=undefined || itemCareer!=null){
                            itemSemester = $('#qualificationsSemesterFilter').jqxDropDownList('getSelectedItem'); 
                            if(itemSemester==null || itemSemester==undefined){
                                createDropDownGruopByCurrentSemester("#qualificationsGroupFilter",{}, true);
                                createDropDownSubjectMatterByCurrentSemester("#qualificationsSubjectMatterFilter", {}, true);
                                createDropDownEvaluationType("#qualificationsCalEvaluationType", {}, true); 
                                $("#tableQualifications").parent().hide();
                            }else{
                                itemGroup = $('#qualificationsGroupFilter').jqxDropDownList('getSelectedItem');
                                if(itemGroup==null || itemGroup==undefined){
                                    createDropDownSubjectMatterByCurrentSemester("#qualificationsSubjectMatterFilter", {}, true);
                                    createDropDownEvaluationType("#qualificationsCalEvaluationType", {}, true); 
                                    $("#tableQualifications").parent().hide();
                                }else{
                                    itemSubjectMatter = $('#qualificationsSubjectMatterFilter').jqxDropDownList('getSelectedItem');
                                    if(itemSubjectMatter==null || itemSubjectMatter==undefined){
                                        createDropDownEvaluationType("#qualificationsCalEvaluationType", {}, true); 
                                        $("#tableQualifications").parent().hide();
                                    }
                                }
                            }
                        }else{
                            createDropDownCurrentSemester("#qualificationsSemesterFilter",{},true);
                            createDropDownGruopByCurrentSemester("#qualificationsGroupFilter",{}, true);
                            createDropDownSubjectMatterByCurrentSemester("#qualificationsSubjectMatterFilter", {}, true);
                            createDropDownEvaluationType("#qualificationsCalEvaluationType", {}, true); 
                            $("#tableQualifications").parent().hide();
                        }
                    }else{
                        createDropDownCareer(null ,"#qualificationsCareerFilter",true);
                        createDropDownCurrentSemester("#qualificationsSemesterFilter",{},true);
                        createDropDownGruopByCurrentSemester("#qualificationsGroupFilter",{}, true);
                        createDropDownSubjectMatterByCurrentSemester("#qualificationsSubjectMatterFilter", {}, true);
                        createDropDownEvaluationType("#qualificationsCalEvaluationType", {}, true); 
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
                                createDropDownSubjectMatterByCurrentSemester("#qualificationsSubjectMatterFilter", {}, true);
                                createDropDownEvaluationType("#qualificationsCalEvaluationType", {}, true); 
                                $("#tableQualifications").parent().hide();
                            }else{
                                itemGroup = $('#qualificationsGroupFilter').jqxDropDownList('getSelectedItem');
                                if(itemGroup==null || itemGroup==undefined){
                                    createDropDownSubjectMatterByCurrentSemester("#qualificationsSubjectMatterFilter", {}, true);
                                    createDropDownEvaluationType("#qualificationsCalEvaluationType", {}, true); 
                                    $("#tableQualifications").parent().hide();
                                }else{
                                    itemSubjectMatter = $('#qualificationsSubjectMatterFilter').jqxDropDownList('getSelectedItem');
                                    if(itemSubjectMatter==null || itemSubjectMatter==undefined){
                                        createDropDownEvaluationType("#qualificationsCalEvaluationType", {}, true); 
                                        $("#tableQualifications").parent().hide();
                                    }
                                }
                            }
                        }else{
                            createDropDownCurrentSemester("#qualificationsSemesterFilter",{},true);
                            createDropDownGruopByCurrentSemester("#qualificationsGroupFilter",{}, true);
                            createDropDownSubjectMatterByCurrentSemester("#qualificationsSubjectMatterFilter", {}, true);
                            createDropDownEvaluationType("#qualificationsCalEvaluationType", {}, true); 
                            $("#tableQualifications").parent().hide();
                        }
                    }else{
                        createDropDownCurrentSemester("#qualificationsSemesterFilter",{},true);
                        createDropDownGruopByCurrentSemester("#qualificationsGroupFilter",{}, true);
                        createDropDownSubjectMatterByCurrentSemester("#qualificationsSubjectMatterFilter", {}, true);
                        createDropDownEvaluationType("#qualificationsCalEvaluationType", {}, true); 
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
                            createDropDownSubjectMatterByCurrentSemester("#qualificationsSubjectMatterFilter", {}, false);
                            createDropDownEvaluationType("#qualificationsCalEvaluationType", {}, false);  
                            $("#tableQualifications").parent().hide();
                        }else{
                            itemSemester = $('#qualificationsSemesterFilter').jqxDropDownList('getSelectedItem');
                            if(itemSemester==null || itemSemester==undefined){
                                createDropDownGruopByCurrentSemester("#qualificationsGroupFilter",{}, true);
                                createDropDownSubjectMatterByCurrentSemester("#qualificationsSubjectMatterFilter", {}, true);
                                createDropDownEvaluationType("#qualificationsCalEvaluationType", {}, true); 
                                $("#tableQualifications").parent().hide();
                            }else{
                                itemGroup = $('#qualificationsGroupFilter').jqxDropDownList('getSelectedItem');
                                if(itemGroup==null || itemGroup==undefined){
                                    createDropDownSubjectMatterByCurrentSemester("#qualificationsSubjectMatterFilter", {}, true);
                                    createDropDownEvaluationType("#qualificationsCalEvaluationType", {}, true); 
                                    $("#tableQualifications").parent().hide();
                                }else{
                                    itemSubjectMatter = $('#qualificationsSubjectMatterFilter').jqxDropDownList('getSelectedItem');
                                    if(itemSubjectMatter==null || itemSubjectMatter==undefined){
                                        createDropDownEvaluationType("#qualificationsCalEvaluationType", {}, true);
                                        $("#tableQualifications").parent().hide();
                                    }
                                }
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
                            createDropDownSubjectMatterByCurrentSemester("#qualificationsSubjectMatterFilter", {}, true);
                            createDropDownEvaluationType("#qualificationsCalEvaluationType", {}, true); 
                            $("#tableQualifications").parent().hide();
                        }else{
                            itemGroup = $('#qualificationsGroupFilter').jqxDropDownList('getSelectedItem');
                            if(itemGroup==null || itemGroup==undefined){
                                createDropDownSubjectMatterByCurrentSemester("#qualificationsSubjectMatterFilter", {}, true);
                                createDropDownEvaluationType("#qualificationsCalEvaluationType", {}, true); 
                                $("#tableQualifications").parent().hide();
                            }else{
                                itemSubjectMatter = $('#qualificationsSubjectMatterFilter').jqxDropDownList('getSelectedItem');
                                if(itemSubjectMatter==null || itemSubjectMatter==undefined){
                                    createDropDownEvaluationType("#qualificationsCalEvaluationType", {}, true); 
                                    $("#tableQualifications").parent().hide();
                                }
                            }
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
                        if(itemGroup==null || itemGroup==undefined){
                            createDropDownSubjectMatterByCurrentSemester("#qualificationsSubjectMatterFilter", {}, true);
                            createDropDownEvaluationType("#qualificationsCalEvaluationType", {}, true); 
                            $("#tableQualifications").parent().hide();
                        }else{
                            itemSubjectMatter = $('#qualificationsSubjectMatterFilter').jqxDropDownList('getSelectedItem');
                            if(itemSubjectMatter==null || itemSubjectMatter==undefined){
                                createDropDownEvaluationType("#qualificationsCalEvaluationType", {}, true); 
                                $("#tableQualifications").parent().hide();
                            }
                        }
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
                        itemCareer = $('#qualificationsCareerFilter').jqxDropDownList('getSelectedItem');
                        itemStudyPlan = $('#qualificationsStudyPlanFilter').jqxDropDownList('getSelectedItem');
                        itemSemester = $('#qualificationsSemesterFilter').jqxDropDownList('getSelectedItem');
                        itemGroup = $('#qualificationsGroupFilter').jqxDropDownList('getSelectedItem');
                        itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');     
                        
                        var filtrableSubjectMatters = {
                            pkCareer : itemCareer.value,
                            pkSemester : itemSemester.value,
                            pkStudyPlan : itemStudyPlan.value,
                            pkPeriod : itemPeriod.value
                        };
                        createDropDownSubjectMatterByCurrentSemester("#qualificationsSubjectMatterFilter", filtrableSubjectMatters, true);
                        itemSubjectMatter = $('#qualificationsSubjectMatterFilter').jqxDropDownList('getSelectedItem');
                        if(itemSubjectMatter==null || itemSubjectMatter==undefined){
                            createDropDownEvaluationType("#qualificationsCalEvaluationType", {}, true); 
                            $("#tableQualifications").parent().hide();
                        }
                    }
                });
                $("#qualificationsSubjectMatterFilter").on('change',function (event){  
                    var args = event.args;
                    if (args){
                        // index represents the item's index.                      
                        var index = args.index;
                        var item = args.item;
                        // get item's label and value.
                        var label = item.label;
                        var value = item.value;
                        var type = args.type; // keyboard, mouse or null depending on how the item was selected.  
                        itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');
                        itemSubjectMatter=$('#qualificationsSubjectMatterFilter').jqxDropDownList('getSelectedItem');  
                        itemGroup = $('#qualificationsGroupFilter').jqxDropDownList('getSelectedItem');
                        var data = {
                            "fkGroup":itemGroup.value,
                            "fkMatter":itemSubjectMatter.value,
                            "fkPeriod":itemPeriod.value
                        };
                        createDropDownEvaluationType("#qualificationsCalEvaluationType", data, true);
                    }                
                });
                $("#qualificationsCalEvaluationType").on('change',function (event){ 
                    var args = event.args;
                    if (args) {
                        loadGridCalifications();
                    }
                }); 
            }else{
                createDropDownCareer(null ,"#qualificationsCareerFilter",false);
                createDropDownCurrentSemester("#qualificationsSemesterFilter",{},false);
                createDropDownGruopByCurrentSemester("#qualificationsGroupFilter",{}, false);
                createDropDownSubjectMatterByCurrentSemester("#qualificationsSubjectMatterFilter", {}, false);
                createDropDownEvaluationType("#qualificationsCalEvaluationType", {}, false);
            }     
        }else{
            createDropDownCareer(null ,"#qualificationsCareerFilter",false);
            createDropDownCurrentSemester("#qualificationsSemesterFilter",{},false);
            createDropDownGruopByCurrentSemester("#qualificationsGroupFilter",{}, false);
            createDropDownSubjectMatterByCurrentSemester("#qualificationsSubjectMatterFilter", {}, false);
            createDropDownEvaluationType("#qualificationsCalEvaluationType", {}, false); 
        }
        function loadSource(){
            itemCareer = $('#qualificationsCareerFilter').jqxDropDownList('getSelectedItem');
            itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');
            itemSubjectMatter=$('#qualificationsSubjectMatterFilter').jqxDropDownList('getSelectedItem');  
            itemGroup = $('#qualificationsGroupFilter').jqxDropDownList('getSelectedItem');
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
                url: '../serviceCalification?tableByAllActivities&&fkCareer='+itemCareer.value+'&&fkPeriod='+itemPeriod.value+'&&fkMatter='+itemSubjectMatter.value+'&&fkGroup='+itemGroup.value+''
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
                        dataFields: dataFields,
                        id: 'dataProgresivNumber',
                        localdata: rows
                    });
                    
                    var arr = columns;
                    var str = JSON.stringify(arr);
                    var newArr = JSON.parse(str);
                    for(var i=0;i<newArr.length; i++){
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
                        altRows: true,
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
                            exportButton.click(function (event) {
                                itemLevel = $('#qualificationsLevelFilter').jqxDropDownList('getSelectedItem');
                                itemCareer = $('#qualificationsCareerFilter').jqxDropDownList('getSelectedItem');
                                itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');
                                itemSemester = $('#qualificationsSemesterFilter').jqxDropDownList('getSelectedItem');
                                itemSubjectMatter=$('#qualificationsSubjectMatterFilter').jqxDropDownList('getSelectedItem'); 
                                itemGroup = $('#qualificationsGroupFilter').jqxDropDownList('getSelectedItem');
                                $.ajax({
                                    url: "../content/data-jr/studentsEvaluation/index.jsp?sessionCalificationsByStudents",
                                    data: {
                                        "pt_level": itemLevel.value,
                                        "pt_career": itemCareer.value,
                                        "pt_group": itemGroup.value,
                                        "pt_semester": itemSemester.value,
                                        "pt_matter": itemSubjectMatter.value,
                                        "pt_period": itemPeriod.value
                                    },
                                    type: 'POST',
                                    beforeSend: function (xhr) {
                                    },
                                    success: function (data, textStatus, jqXHR) {
                                        window.open("../content/data-jr/studentsEvaluation/");
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
                            { text: 'Ser',  name: 'content_be', cellsalign: 'center', align: 'center' },
                            { text: 'Actividades', parentgroup: 'content_be', name: 'be', cellsalign: 'center', align: 'center' },
                            { text: 'Saber', name: 'content_know', cellsalign: 'center', align: 'center' },
                            { text: 'Actividades', parentgroup: 'content_know', name: 'know',  cellsalign: 'center', align: 'center'},
                            { text: 'Hacer', name: 'content_do', cellsalign: 'center', align: 'center' },
                            { text: 'Actividades', parentgroup: 'content_do', name: 'do', cellsalign: 'center', align: 'center'}
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
<div style="display: inline-block; margin-right: 5px;">
    Materia<br>
    <div id='qualificationsSubjectMatterFilter'></div>
</div>
<div style="display: inline-block; margin-right: 5px;">
    Tipo<br>
    <div id='qualificationsCalEvaluationType'></div>
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