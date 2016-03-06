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
                itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');
                itemCareer = $('#qualificationsCareerFilter').jqxDropDownList('getSelectedItem');
                itemLevel = $('#qualificationsLevelFilter').jqxDropDownList('getSelectedItem');
                createDropDownSemesterByTeacher(itemPeriod.value, itemCareer.value,  itemLevel.value,"#qualificationsSemesterFilter",true);
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
                var dataAdapter = new $.jqx.dataAdapter(loadSource());
                $("#tableQualifications").jqxGrid({source: dataAdapter});
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
                root: "__ENTITIES",
                dataType: "json",
                id: 'id',
                async: false,
                url: '../serviceCalification?view=calificationsNow&&fkPeriod='+itemPeriod.value+'&&fkMatter='+itemSubjectMatter.value+'&&fkGroup='+itemGroup.value+''
            };
            return ordersSource;
        }
        function loadTableQualifications(){
        var dataAdapter = new $.jqx.dataAdapter(loadSource());
            $("#tableQualifications").jqxGrid({
                width: 750,
                height: 350,
                selectionMode: "singlerow",
                localization: getLocalization("es"),
                source: dataAdapter,
                pageable: false,
                editable: false,
                filterable: false,
                altRows: true,
                ready: function(){
                    $("#tableQualifications").jqxGrid('focus');
                },
                columngroups: [
                    { text: 'Calificación', align: 'center', name: 'calification' }
                ],
                columns: [
                    { text: '#',  disabled: true, filterable: false, editable: false, dataField: 'dataProgresivNumber', width: 25 },
                    { text: 'Matrícula',disabled: true, align: 'center', dataField: 'dataEnrollment', editable: false, width: 150 },
                    { text: 'Alumno',disabled: true, align: 'center', dataField: 'dataStudentName', editable: false},
                    { text: 'Ser', columngroup: 'calification', parentgroup: 'calification', dataField: 'dataCalificationBe', cellsalign: 'center', align: 'center', width: 60 },
                    { text: 'Saber',columngroup: 'calification', cellsalign: 'center', align: 'center', dataField: 'dataCalificationKnow', width: 60},
                    { text: 'Hacer', columngroup: 'calification', cellsalign: 'center', align: 'center', dataField: 'dataCalificationDo', width: 60},
                    { text: 'Total', columngroup: 'calification', cellsalign: 'center', align: 'center', dataField: 'dataAvg', width: 80}
                ]
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