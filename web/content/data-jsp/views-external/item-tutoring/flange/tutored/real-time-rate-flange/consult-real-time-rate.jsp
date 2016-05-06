<script>
    $(document).ready(function () {
        var itemLevel = 0;
        var itemCareer = 0;
        var itemPeriod = 0;
        var itemGroup = 0;
        var itemSemester = 0;
        var itemSubjectMatter = 0;
        var itemEvaluationType = 0;
        var buttonTemplate = "<div style='float: left; padding: 3px; margin: 2px;'><div style='margin: 4px; width: 16px; height: 16px;'></div></div>";
        var exportButton = $(buttonTemplate);
        var container = $("<div class='container' style='overflow: hidden; position: relative; height: 100%; width: 100%;'></div>");
        createDropDownStudyLevelByTeacherTutor("#qualificationsLevelFilter",false);
        itemLevel = $('#qualificationsLevelFilter').jqxDropDownList('getSelectedItem');
        if(itemLevel!==undefined){
            createDropDownCareerByTeacherTutor( itemLevel.value ,"#qualificationsCareerFilter",false);
            itemCareer = $('#qualificationsCareerFilter').jqxDropDownList('getSelectedItem');
            createDropDownPeriod("comboActiveYear","#qualificationsPeriodFilter");
            itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');
            if(itemPeriod!==undefined){
                createDropDownSemesterByTeacherTutor(itemPeriod.value, itemLevel.value,"#qualificationsSemesterFilter",false);
                itemSemester = $('#qualificationsSemesterFilter').jqxDropDownList('getSelectedItem');
                if(itemSemester!==undefined){
                    createDropDownGruopByTeacherTutor(itemPeriod.value, itemSemester.value, "#qualificationsGroupFilter",false);
                    itemGroup = $('#qualificationsGroupFilter').jqxDropDownList('getSelectedItem');
                    var filtrable = {
                        pkCareer : itemCareer.value,
                        pkSemester : itemSemester.value,
                        pkGroup : itemGroup.value,
                        pkPeriod : itemPeriod.value
                    };
                    createDropDownSubjectMatterByGroup(filtrable, "#qualificationsSubjectMatterFilter", false);
                    itemSubjectMatter = $('#qualificationsSubjectMatterFilter').jqxDropDownList('getSelectedItem');
                    if(itemSubjectMatter!==undefined){
                        var data = {
                            "fkGroup":itemGroup.value,
                            "fkMatter":itemSubjectMatter.value,
                            "fkPeriod":itemPeriod.value
                        }; 
                        createDropDownEvaluationType("#qualificationsEvaluationTypeFilter", data);                        
                        itemEvaluationType = $('#qualificationsEvaluationTypeFilter').jqxDropDownList('getSelectedItem');
                        if(itemEvaluationType!==undefined || itemEvaluationType!==null){
                            loadGridCalifications();
                        }
                    }else{
                        createDropDownEvaluationTypeBloqued("#qualificationsEvaluationTypeFilter", null, null, false);
                    }
                }else{
                    createDropDownGruopByTeacherTutor(null, null, "#qualificationsGroupFilter",false);
                }
            }else{
                createDropDownSemesterByTeacherTutor(null, null,"#qualificationsSemesterFilter",false);
                createDropDownGruopByTeacherTutor(null, null, "#qualificationsGroupFilter",false);
            }
            $('#qualificationsLevelFilter').on('change',function (event){  
                itemLevel = $('#qualificationsLevelFilter').jqxDropDownList('getSelectedItem');
                if(itemLevel!==undefined){
                    createDropDownCareerByTeacher(itemLevel.value, "#qualificationsCareerFilter", true);
                    itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');
                    if(itemPeriod!==undefined){
                        itemCareer = $('#qualificationsCareerFilter').jqxDropDownList('getSelectedItem');
                        createDropDownSemesterByTeacher(itemPeriod.value, itemLevel.value,"#qualificationsSemesterFilter", true);
                        itemSemester = $('#qualificationsSemesterFilter').jqxDropDownList('getSelectedItem'); 
                    }else{
                        createDropDownSemesterByTeacher(null, null,"#qualificationsSemesterFilter", true);
                    }
                }else{
                    createDropDownCareerByTeacher(null, "#qualificationsCareerFilter", true);
                    createDropDownSemesterByTeacher(null, null,"#qualificationsSemesterFilter", true);
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
                    itemSemester = $('#qualificationsSemesterFilter').jqxDropDownList('getSelectedItem');
                    itemGroup = $('#qualificationsGroupFilter').jqxDropDownList('getSelectedItem');
                    itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');
                    itemLevel = $('#qualificationsLevelFilter').jqxDropDownList('getSelectedItem');
                    createDropDownSemesterByTeacherTutor(itemPeriod.value, itemLevel.value,"#qualificationsSemesterFilter",true);
                    itemSemester = $('#qualificationsSemesterFilter').jqxDropDownList('getSelectedItem');
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
                    itemSemester = $('#qualificationsSemesterFilter').jqxDropDownList('getSelectedItem');
                    itemGroup = $('#qualificationsGroupFilter').jqxDropDownList('getSelectedItem');
                    itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');
                    itemLevel = $('#qualificationsLevelFilter').jqxDropDownList('getSelectedItem');
                    createDropDownSemesterByTeacherTutor(itemPeriod.value, itemLevel.value,"#qualificationsSemesterFilter",true);
                    itemSemester = $('#qualificationsSemesterFilter').jqxDropDownList('getSelectedItem');
                }
            });
            $("#qualificationsGroupFilter").on('change',function (event){  
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
                    itemSemester = $('#qualificationsSemesterFilter').jqxDropDownList('getSelectedItem');
                    itemGroup = $('#qualificationsGroupFilter').jqxDropDownList('getSelectedItem');
                    itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');
                    var filtrable = {
                        pkCareer : itemCareer.value,
                        pkSemester : itemSemester.value,
                        pkGroup : itemGroup.value,
                        pkPeriod : itemPeriod.value
                    };
                    createDropDownSubjectMatterByGroup(filtrable, "#qualificationsSubjectMatterFilter", true);
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
                    itemCareer = $('#qualificationsCareerFilter').jqxDropDownList('getSelectedItem');
                    itemSemester = $('#qualificationsSemesterFilter').jqxDropDownList('getSelectedItem');
                    itemGroup = $('#qualificationsGroupFilter').jqxDropDownList('getSelectedItem');
                    itemSubjectMatter = $('#qualificationsSubjectMatterFilter').jqxDropDownList('getSelectedItem');
                    itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');
                    var data = {
                        "fkGroup":itemGroup.value,
                        "fkMatter":itemSubjectMatter.value,
                        "fkPeriod":itemPeriod.value
                    }; 
                    createDropDownEvaluationType("#qualificationsEvaluationTypeFilter", data);
                    itemEvaluationType = $('#qualificationsEvaluationTypeFilter').jqxDropDownList('getSelectedItem');
                    loadGridCalifications();
                }                
            });
            var valueOld = 0;
            $("#qualificationsEvaluationTypeFilter").on('change',function (event){  
                var args = event.args;
                if (args) {
                    // index represents the item's index.                      
                    var index = args.index;
                    var item = args.item;
                    // get item's label and value.
                    var label = item.label;
                    var value = item.value;
                    var type = args.type; // keyboard, mouse or null depending on how the item was selected.
                    if(valueOld!=value){
                        valueOld=value;
                        loadGridCalifications();
                    }      
                }                
            });
        }else{
            createDropDownCareerByTeacher(null ,"#qualificationsCareerFilter",false);
            createDropDownPeriod("comboActiveYear","#qualificationsPeriodFilter");
            createDropDownSemesterByTeacher(null, null,"#qualificationsSemesterFilter",false);
            createDropDownGruopByTeacher(null, null, "#qualificationsGroupFilter",false);
        }
        function loadSource(){
            var valItemCareer=0;
            var valItemGroup=0;
            var valItemSubjectMatter=0;
            var valitemEvaluationType=0;
            var valItemPeriod=0;
            itemCareer = $('#qualificationsCareerFilter').jqxDropDownList('getSelectedItem');
            itemGroup = $('#qualificationsGroupFilter').jqxDropDownList('getSelectedItem');
            itemSubjectMatter = $('#qualificationsSubjectMatterFilter').jqxDropDownList('getSelectedItem');
            itemEvaluationType = $('#qualificationsEvaluationTypeFilter').jqxDropDownList('getSelectedItem');
            itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');
            
            if(itemCareer!==undefined){
                valItemCareer=itemCareer.value;
            }
            if(itemGroup!==undefined){
                valItemGroup=itemGroup.value;
            }
            if(itemSubjectMatter!==undefined){
                valItemSubjectMatter=itemSubjectMatter.value;
            }
            if(itemEvaluationType!==undefined){
                valitemEvaluationType=itemEvaluationType.value;
            }
            if(itemPeriod!==undefined){
                valItemPeriod=itemPeriod.value;
            }            
            var ordersSource ={
                dataFields: [
                    { name: 'dataProgresivNumber', type:'int'},
                    { name: 'dataEnrollment', type: 'string' },
                    { name: 'dataStudentName', type: 'string' }
                ],
                dataType: "json",
                async: false,
                url: '../serviceCalification?table',
                data : {
                    fkPeriod : valItemPeriod,
                    fkGroup : valItemGroup,
                    fkSubjectMatter : valItemSubjectMatter,
                    fkEvaluationType: valitemEvaluationType,
                    fkCareer : valItemCareer
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
            var toolbarfunc = function (toolbar) {
                var themeRenderToolbar = "";
                var toTheme = function (className) {
                    if (themeRenderToolbar === "") return className;
                    return className + " " + className + "-" + themeRenderToolbar;
                }; 
                container.append(exportButton);
                toolbar.append(container);
                var me = this;   
                
                exportButton.jqxButton({cursor: "pointer", disabled: false, enableDefault: false,  height: 25, width: 25 });
                exportButton.find('div:first').addClass(toTheme('jqx-icon-export'));
                exportButton.jqxTooltip({ position: 'bottom', content: "Exportar a PDF"});
                exportButton.attr("id","exportButton"); 
                
                exportButton.off("click");
                exportButton.click(function (event) {
                    itemCareer = $('#qualificationsCareerFilter').jqxDropDownList('getSelectedItem');
                    itemGroup = $('#qualificationsGroupFilter').jqxDropDownList('getSelectedItem');
                    itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');
                    itemLevel = $('#qualificationsLevelFilter').jqxDropDownList('getSelectedItem');
                    itemSubjectMatter = $('#qualificationsSubjectMatterFilter').jqxDropDownList('getSelectedItem');
                    itemSemester = $('#qualificationsSemesterFilter').jqxDropDownList('getSelectedItem');
                    itemEvaluationType = $('#qualificationsEvaluationTypeFilter').jqxDropDownList('getSelectedItem');
                    $.ajax({
                        url: "../content/data-jr/studentsEvaluationAllSubjects/index.jsp?sessionCalificationsByStudentsAllMatters",
                        data: {
                            "pt_level": itemLevel.value,
                            "pt_career": itemCareer.value,
                            "pt_semester": itemSemester.value,
                            "pt_group": itemGroup.value,                            
                            "pt_matter": itemSubjectMatter.value,
                            "pt_evaluation_type" : itemEvaluationType.value,
                            "pt_period": itemPeriod.value
                        },
                        type: 'POST',
                        beforeSend: function (xhr) {
                        },
                        success: function (data, textStatus, jqXHR) {
                            window.open("../../content/data-jr/studentsEvaluationAllSubjects/");
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            alert("Error interno del servidor");                
                        }
                    });
                });  
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
                        renderToolbar: toolbarfunc,
                        ready: function(){
                            $("#tableQualifications").jqxGrid('focus');
                        },
                        columngroups: [
//                            { text: 'M1',  name: 'subject_matter', cellsalign: 'center', align: 'center' },
                            { text: 'Ser',  /*parentgroup: 'subject_matter',*/  name: 'content_be', cellsalign: 'center', align: 'center' },
                            { text: 'Saber', /*parentgroup: 'subject_matter',*/  name: 'content_know', cellsalign: 'center', align: 'center' },
                            { text: 'Hacer', /*parentgroup: 'subject_matter',*/  name: 'content_do', cellsalign: 'center', align: 'center' },
                            { text: 'Total', /*parentgroup: 'subject_matter',*/  name: 'content_total', cellsalign: 'center', align: 'center' }
                            
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
<div style="float: left; margin-right: 5px;">
    Nivel de estudio<br>
    <div id='qualificationsLevelFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Carrera <br>
    <div id='qualificationsCareerFilter'></div>
</div>
<div id="contentHistoryPeriods" style="display: none; float: right; right: 100px; position: absolute; z-index: 10000;">
    Periodo historial <br>
    <div id='qualificationsPeriodHistoryFilter'></div>
</div>
<div style="float: right; margin-right: 5px; display: none">
    Periodo <br>
    <div id='qualificationsPeriodFilter'></div>
</div>
<br><br><br>
<div style="float: left; margin-right: 5px;">
    Cuatrimestre<br>
    <div id='qualificationsSemesterFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Grupo<br>
    <div id='qualificationsGroupFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Materia<br>
    <div id='qualificationsSubjectMatterFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Tipo<br>
    <div id='qualificationsEvaluationTypeFilter'></div>
</div>
<div id="exporPDF"></div>
<br><br>
<div style="float: left; margin-right: 5px" id="tableQualifications"></div>