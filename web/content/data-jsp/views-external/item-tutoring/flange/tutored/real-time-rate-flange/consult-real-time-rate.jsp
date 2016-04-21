<script>
    $(document).ready(function () {
        var itemLevel = 0;
        var itemCareer = 0;
        var itemPeriod = 0;
        var itemGroup = 0;
        var itemSemester = 0;
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
                itemCareer = $('#qualificationsCareerFilter').jqxDropDownList('getSelectedItem');
            });
            $("#qualificationsSemesterFilter").on('change',function (){
                itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');
                if(itemPeriod!==null){
                    itemSemester = $('#qualificationsSemesterFilter').jqxDropDownList('getSelectedItem');
                    if(itemSemester!==undefined){
                        createDropDownGruopByTeacherTutor(itemPeriod.value, itemSemester.value, "#qualificationsGroupFilter",true);
                    }else{
                        createDropDownGruopByTeacherTutor(null, null, "#qualificationsGroupFilter",true);
                    }
                }else{
                    createDropDownGruopByTeacherTutor(null, null, "#qualificationsGroupFilter",true);
                }
            });
            $("#qualificationsGroupFilter").on('change',function (){  
                loadDataAdapter();
            });
            loadDataAdapter();
        }else{
            createDropDownCareerByTeacher(null ,"#qualificationsCareerFilter",false);
            createDropDownPeriod("comboActiveYear","#qualificationsPeriodFilter");
            createDropDownSemesterByTeacher(null, null,"#qualificationsSemesterFilter",false);
            createDropDownGruopByTeacher(null, null, "#qualificationsGroupFilter",false);
        }
        function loadSource(){
            var valItemCareer=0;
            var valItemGroup=0;
            var valItemPeriod=0;
            itemCareer = $('#qualificationsCareerFilter').jqxDropDownList('getSelectedItem');
            itemGroup = $('#qualificationsGroupFilter').jqxDropDownList('getSelectedItem');
            itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');
            if(itemCareer!==undefined){
                valItemCareer=itemCareer.value;
            }
            if(itemGroup!==undefined){
                valItemGroup=itemGroup.value;
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
                url: '../serviceCalification?table&&fkPeriod='+valItemPeriod+'&&fkGroup='+valItemGroup+'&&fkCareer='+valItemCareer+''
            };
            return ordersSource;
        }
        var dataExternal;
        function loadDataAdapter(){
            var dataAdapter = new $.jqx.dataAdapter(loadSource(), {
                autoBind: true,
                beforeSend:function (){
                    $("#tableQualifications").jqxGrid('showloadelement');
                },
                beforeLoadComplete:function (){
                    $("#tableQualifications").jqxGrid('hideloadelement');
                },
                downloadComplete: function (data) {
                    dataExternal=data;
                    var columns = data[0].columns;
                    var rows = data[1].rows;
                    var gridAdapter = new $.jqx.dataAdapter({
                        dataFields: [
                            { name: 'dataProgresivNumber', type:'int'},
                            { name: 'dataEnrollment', type: 'string' },
                            { name: 'dataFkStudent', type: 'int' },
                            { name: 'dataStudentName', type: 'string' }
                        ],
                        id: 'id',
                        localdata: rows
                    });
                    $("#tableQualifications").jqxGrid('beginupdate', true);
                    $("#tableQualifications").jqxGrid({
                        source: gridAdapter,
                        columns: columns,
                        width: 900,
                        height: 350,
                        ready:function(){
                            var rows2 = dataExternal[1].rows;
                            var rowsCal2 = dataExternal[2].rowsCal;
                            if(rows2.length===0){
                                $("#tableQualificationsDescription").hide();
                                $("#tableQualifications").hide();
                            }else{
                                loadTableDescription();
                                $("#tableQualificationsDescription").fadeIn("slow");
                                $("#tableQualifications").fadeIn("slow");
                                for(var i1=0; i1<rows2.length; i1++){
                                    var dataRow = $('#tableQualifications').jqxGrid('getrowdata', i1);
                                    for(var i2=0; i2<rowsCal2.length; i2++){
                                        if(dataRow.dataFkStudent===rowsCal2[i2].dataFkStudent){
                                            $("#tableQualifications").jqxGrid('setcellvalue', i1, rowsCal2[i2].dataNameMatter, rowsCal2[i2].dataCalMatters);
                                        }
                                    }
                                } 
                            }
                        },
                        columnsresize: false
                    });
                    $("#tableQualifications").jqxGrid('endupdate');
                }
            });    
            
        }
        $("#tableQualifications").on("bindingcomplete", function (event) {
            var rows2 = dataExternal[1].rows;
            var rowsCal2 = dataExternal[2].rowsCal;
            if(rows2.length===0){
                $("#tableQualificationsDescription").hide();
                $("#tableQualifications").hide();
            }else{
                loadTableDescription();
                $("#tableQualificationsDescription").fadeIn("slow");
                $("#tableQualifications").fadeIn("slow");
                for(var i1=0; i1<rows2.length; i1++){
                    var dataRow2 = $('#tableQualifications').jqxGrid('getrowdata', i1);
                    for(var i2=0; i2<rowsCal2.length; i2++){
                        if(dataRow2.dataFkStudent===rowsCal2[i2].dataFkStudent){
                            $("#tableQualifications").jqxGrid('setcellvalue', i1, rowsCal2[i2].dataNameMatter, rowsCal2[i2].dataCalMatters);
                        }
                    }
                } 
            }
        }); 
        
        function loadSourceDescription(){
            var valItemCareer=0;
            var valItemGroup=0;
            var valItemPeriod=0;
            itemCareer = $('#qualificationsCareerFilter').jqxDropDownList('getSelectedItem');
            itemGroup = $('#qualificationsGroupFilter').jqxDropDownList('getSelectedItem');
            itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');
            if(itemCareer!==undefined){
                valItemCareer=itemCareer.value;
            }
            if(itemGroup!==undefined){
                valItemGroup=itemGroup.value;
            }
            if(itemPeriod!==undefined){
                valItemPeriod=itemPeriod.value;
            }            
            var ordersSourceDescription ={
                dataFields: [
                    { name: 'text', type:'string'},
                    { name: 'textExtends', type: 'string' }
                ],
                dataType: "json",
                root:'columns',
                async: false,
                url: '../serviceCalification?tableDescription&&fkPeriod='+valItemPeriod+'&&fkGroup='+valItemGroup+'&&fkCareer='+valItemCareer+''
            };
            return ordersSourceDescription;
        }
        function loadTableDescription(){
            var dataAdapterDescription = new $.jqx.dataAdapter(loadSourceDescription());
            $("#tableQualificationsDescription").jqxGrid({
                source: dataAdapterDescription,
                columns: [
                    { text: 'Nombre', align: 'center', dataField: 'text', width: 70 },
                    { text: 'Descripción',align: 'center', dataField: 'textExtends', width: 300 }
                ],
                width: 250,
                height: 250
            });
        }
        var theme = "";
        var toTheme = function (className) {
            if (theme === "") return className;
            return className + " " + className + "-" + theme;
        };
        var container = $("<div style='overflow: hidden; position: relative; height: 100%; width: 100%;'></div>");
        var buttonTemplate = "<div style='float: left; padding: 3px; margin: 2px;'><div style='margin: 4px; width: 16px; height: 16px;'></div></div>";
        var exportButton = $(buttonTemplate);
        container.append(exportButton);
        $("#exporPDF").append(container);
        exportButton.jqxButton({cursor: "pointer", disabled: false, enableDefault: false,  height: 25, width: 25 });
        exportButton.find('div:first').addClass(toTheme('jqx-icon-export'));
        exportButton.jqxTooltip({ position: 'bottom', content: "Exportar a PDF"});
        exportButton.attr("id","exportButton");       
        exportButton.click(function (event) {
            itemCareer = $('#qualificationsCareerFilter').jqxDropDownList('getSelectedItem');
            itemGroup = $('#qualificationsGroupFilter').jqxDropDownList('getSelectedItem');
            itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');
            itemLevel = $('#qualificationsLevelFilter').jqxDropDownList('getSelectedItem');
            itemSemester = $('#qualificationsSemesterFilter').jqxDropDownList('getSelectedItem');
            $.ajax({
                url: "../content/data-jr/studentsEvaluation/index.jsp?sessionCalificationsByStudents",
                data: {
                    "pt_level": itemLevel.value,
                    "pt_career": itemCareer.value,
                    "pt_group": itemGroup.value,
                    "pt_semester": itemSemester.value,
                    "pt_matter": null,
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
<div id="exporPDF"></div>
<br><br><br>
<div style="float: left; margin-right: 5px" id="tableQualifications"></div>
<div style="float: left" id="tableQualificationsDescription"></div>