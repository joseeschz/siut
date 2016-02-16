<script>
    $(document).ready(function () {
        var itemLevel = 0;
        var itemCareer = 0;
        var itemPeriod = 0;
        var itemGroup = 0;
        var itemSemester = 0;
        var itemSubjectMatter = 0;
        createDropDownStudyLevelByTeacher("#qualificationsLevelFilter",false);
        itemLevel = $('#qualificationsLevelFilter').jqxDropDownList('getSelectedItem');
        if(itemLevel!==undefined){
            createDropDownCareerByTeacher( itemLevel.value ,"#qualificationsCareerFilter",false);
            itemCareer = $('#qualificationsCareerFilter').jqxDropDownList('getSelectedItem');
            createDropDownPeriod("comboActiveYear","#qualificationsPeriodFilter");
            itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');
            createDropDownSemesterByTeacher(itemPeriod.value, itemCareer.value,  itemLevel.value,"#qualificationsSemesterFilter",false);
            itemSemester = $('#qualificationsSemesterFilter').jqxDropDownList('getSelectedItem');
            createDropDownSubjectMatterByTeacher(itemPeriod.value, itemCareer.value, itemSemester.value, null, "#qualificationsSubjectMatterFilter", false);
            itemSubjectMatter=$('#qualificationsSubjectMatterFilter').jqxDropDownList('getSelectedItem'); 
            createDropDownGruopByTeacherMattter(itemPeriod.value, itemSemester.value, itemSubjectMatter.value, "#qualificationsGroupFilter",false);
            itemGroup = $('#qualificationsGroupFilter').jqxDropDownList('getSelectedItem');
            $('#qualificationsLevelFilter').on('change',function (event){  
                itemLevel = $('#qualificationsLevelFilter').jqxDropDownList('getSelectedItem');
                createDropDownCareerByTeacher(itemLevel.value, "#qualificationsCareerFilter", true);
                itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');
                createDropDownSemesterByTeacher(itemPeriod.value, itemCareer.value,  itemLevel.value,"#qualificationsSemesterFilter", true);   
            });
            $('#qualificationsCareerFilter').on('change',function (event){           
                itemCareer = $('#qualificationsCareerFilter').jqxDropDownList('getSelectedItem');
            });
            $("#qualificationsSemesterFilter").on('change',function (){
                itemCareer = $('#qualificationsCareerFilter').jqxDropDownList('getSelectedItem');
                itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');
                itemSemester = $('#qualificationsSemesterFilter').jqxDropDownList('getSelectedItem');
                createDropDownSubjectMatterByTeacher(itemPeriod.value, itemCareer.value, itemSemester.value, null, "#qualificationsSubjectMatterFilter", true);
            });
            $("#qualificationsSubjectMatterFilter").on('change',function (){  
                itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');
                itemSemester = $('#qualificationsSemesterFilter').jqxDropDownList('getSelectedItem');
                itemSubjectMatter=$('#qualificationsSubjectMatterFilter').jqxDropDownList('getSelectedItem'); 
                createDropDownGruopByTeacherMattter(itemPeriod.value, itemSemester.value, itemSubjectMatter.value, "#qualificationsGroupFilter",true);
                itemGroup = $('#qualificationsGroupFilter').jqxDropDownList('getSelectedItem');
            });
            $("#qualificationsGroupFilter").on('change',function (){  
                loadTableQualifications();
            });
            loadTableQualifications();
        }else{
            createDropDownCareerByTeacher(null ,"#qualificationsCareerFilter",false);
            createDropDownPeriod("comboActiveYear","#qualificationsPeriodFilter");
            createDropDownSemesterByTeacher(null, null, null,"#qualificationsSemesterFilter",false);
            createDropDownSubjectMatterByTeacher(null, null, null, null, "#qualificationsSubjectMatterFilter", false);
            createDropDownGruopByTeacherMattter(null, null, null, "#qualificationsGroupFilter",false);
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
        function loadTableQualifications(){
            var popoverrender = function (element){
                var desc = $(element.context.innerHTML).children("div").attr("desc");
                var htmlPopover = $('<div><div>'+desc+'</div></div>');
                htmlPopover.jqxPopover({offset: {left: 0, top:0}, width:150, isModal: true, arrowOffsetValue: 10, title: "Nombre", showCloseButton: true, selector: $(element.parent().parent()) });  
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
                    }
                    columns=newArr;
                    $("#tableQualifications").jqxGrid('beginupdate', true);
                    $("#tableQualifications").jqxGrid({
                        width: 850,
                        height: 450,
                        selectionMode: "singlerow",
                        localization: getLocalization("es"),
                        source: gridAdapter,
                        pageable: false,
                        editable: false,
                        filterable: false,
                        altRows: true,
                        ready: function(){
                            $("#tableQualifications").jqxGrid('focus');
//                            var rows2 = dataExternal[1].rows;
//                            var rowsCal2 = dataExternal[2].rowsCal;
//                            if(rows2.length===0){
//                                $("#tableQualificationsDescription").hide();
//                                $("#tableQualifications").hide();
//                            }else{
//                                loadTableDescription();
//                                $("#tableQualificationsDescription").fadeIn("slow");
//                                $("#tableQualifications").fadeIn("slow");
//                                for(var i1=0; i1<rows2.length; i1++){
//                                    var dataRow = $('#tableQualifications').jqxGrid('getrowdata', i1);
//                                    for(var i2=0; i2<rowsCal2.length; i2++){
//                                        if(dataRow.dataFkStudent===rowsCal2[i2].dataFkStudent){
//                                            $("#tableQualifications").jqxGrid('setcellvalue', i1, rowsCal2[i2].dataNameMatter, rowsCal2[i2].dataCalMatters);
//                                        }
//                                    }
//                                } 
//                            }
                            
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
    Materia<br>
    <div id='qualificationsSubjectMatterFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Grupo<br>
    <div id='qualificationsGroupFilter'></div>
</div>
<br><br><br>
<div id="tableQualifications"></div>
<div id="popover"></div>
<style>
    .texto-vertical {
        writing-mode: vertical-lr;
        transform: rotate(180deg);
    }
</style>