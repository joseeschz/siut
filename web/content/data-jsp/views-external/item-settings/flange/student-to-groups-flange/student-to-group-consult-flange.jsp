<script type="text/javascript">
    $(document).ready(function () {
        var itemLevel = 0;
        var itemCareer = 0;
        var itemPeriod = 0;
        var itemSemester = 0;
        var itemGroup = 0;
        createDropDownStudyLevelByDirector("#studentToGroupConsultFlangeLevelFilter",false);
        itemLevel = $('#studentToGroupConsultFlangeLevelFilter').jqxDropDownList('getSelectedItem');
        itemLevel = itemLevel.value;
        createDropDownCareerByDirector(itemLevel ,"#studentToGroupConsultFlangeCareerFilter",false);
        createDropDownPeriod("comboAll","#studentToGroupConsultFlangePeriodFilter");
        createDropDownSemester(itemLevel,"#studentToGroupConsultFlangeSemesterFilter",false);
        itemSemester = $('#studentToGroupConsultFlangeSemesterFilter').jqxDropDownList('getSelectedItem');
        itemSemester = itemSemester.value;
        createDropDownGruop(itemSemester,"#studentToGroupConsultFlangeGroupFilter",false);
        createDropDownTutorTeacher("#studentToGroupConsultFlangeTutorFilter",false);
        $("#studentToGroupConsultFlangeTutorFilter").jqxDropDownList({ disabled: true,  selectedIndex: -1}); 
        $('#studentToGroupConsultFlangeLevelFilter').on('change',function (event){  
            itemLevel = $('#studentToGroupConsultFlangeLevelFilter').jqxDropDownList('getSelectedItem');
            itemLevel = itemLevel.value;
            createDropDownCareerByDirector(itemLevel, "#studentToGroupConsultFlangeCareerFilter", true);
            itemCareer = $('#studentToGroupConsultFlangeCareerFilter').jqxDropDownList('getSelectedItem');
            itemCareer = itemCareer.value;
            createDropDownSemester(itemLevel,"#studentToGroupConsultFlangeSemesterFilter", true);
            itemSemester = $('#studentToGroupConsultFlangeSemesterFilter').jqxDropDownList('getSelectedItem');
            itemSemester = itemSemester.value;
            createDropDownGruop(itemSemester,"#studentToGroupConsultFlangeGroupFilter",true);
            filterTable(true);
        });
        $('#studentToGroupConsultFlangeCareerFilter').on('change',function (event){           
            itemCareer = $('#studentToGroupConsultFlangeCareerFilter').jqxDropDownList('getSelectedItem');
            itemCareer = itemCareer.value;
            filterTable(true);
        });
        var evenPeriod = false;
        $('#studentToGroupConsultFlangePeriodFilter').on('click',function (event){   
            evenPeriod=true; 
        });
        $('#studentToGroupConsultFlangePeriodFilter').on('keyup',function (event){   
            evenPeriod=true; 
        });
        $('#studentToGroupConsultFlangePeriodFilter').on('change',function (event){           
            itemPeriod = $('#studentToGroupConsultFlangePeriodFilter').jqxDropDownList('getSelectedItem');
            itemPeriod = itemPeriod.value;
            var periodActive = 0;
            $.ajax({
                //Send the paramethers to servelt
                type: "POST",
                async: false,
                url: "../servicePeriod?view=activePeriodYear",
                beforeSend: function (xhr) {
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    //This is if exits an error with the server internal can do server off, or page not found
                    alert("Error interno del servidor");
                },
                success: function (data, textStatus, jqXHR) {
                    periodActive = data;
                    periodActive = parseInt(periodActive);
                    if(itemPeriod.value<periodActive){
                    }else{
                    }
                }
            });
            if(evenPeriod){
                filterTable(true);
            }
            evenPeriod=false;
        });
        $("#studentToGroupConsultFlangeSemesterFilter").on('change',function (){
            itemSemester = $('#studentToGroupConsultFlangeSemesterFilter').jqxDropDownList('getSelectedItem');
            itemSemester = itemSemester.value;
            createDropDownGruop(itemSemester,"#studentToGroupConsultFlangeGroupFilter",true);
            //filterTable(true);
        });
        var inc=0;
        $("#studentToGroupConsultFlangeGroupFilter").on('change',function (){
            filterTable(true);
        });
        function filterTable(filter){
            if(filter){
                itemCareer = $('#studentToGroupConsultFlangeCareerFilter').jqxDropDownList('getSelectedItem');
                itemCareer = itemCareer.value;
                itemSemester = $('#studentToGroupConsultFlangeSemesterFilter').jqxDropDownList('getSelectedItem');
                itemSemester = itemSemester.value;
                itemGroup = $('#studentToGroupConsultFlangeGroupFilter').jqxDropDownList('getSelectedItem');
                itemGroup = itemGroup.value;
                itemPeriod = $('#studentToGroupConsultFlangePeriodFilter').jqxDropDownList('getSelectedItem');
                itemPeriod = itemPeriod.value;
                
                var dataAdapter = new $.jqx.dataAdapter(loadSource(itemCareer, itemSemester, itemGroup, itemPeriod ));
                $("#tableStudentGroupConsult").jqxGrid({source: dataAdapter});
                
                var dataItem = $('#tableStudentGroupConsult').jqxGrid('getrowdata', 1);
                if(dataItem!==undefined){
                    $("#tutorDiv").fadeIn("slow");
                    var item = $("#studentToGroupConsultFlangeTutorFilter").jqxDropDownList('getItemByValue', dataItem.dataPkTutor);
                    $("#studentToGroupConsultFlangeTutorFilter").jqxDropDownList('selectItem', item );
                }else{
                    $("#tutorDiv").fadeOut("slow");
                }
                
            }
        }
        function loadSource(fk_career, fk_semester, fk_group, fk_period){
            var ordersSource ={
                dataFields: [
                    { name: 'id', type:'int'},
                    { name: 'dataProgresivNumber', type:'int'},
                    { name: 'dataEnrollment', type: 'string' },
                    { name: 'dataStudentName', type: 'string' },
                    { name: 'dataPkTutor', type: 'int' }
                ],
                root: "__ENTITIES",
                dataType: "json",
                async: false,
                id: 'id',
                url: '../serviceStudentsGroup?view=consult&fkCareer='+fk_career+'&fkSemester='+fk_semester+'&fkGroup='+fk_group+'&fkPeriod='+fk_period+''
            };
            return ordersSource;
        }
        itemCareer = $('#studentToGroupConsultFlangeCareerFilter').jqxDropDownList('getSelectedItem');
        itemCareer = itemCareer.value;
        itemSemester = $('#studentToGroupConsultFlangeSemesterFilter').jqxDropDownList('getSelectedItem');
        itemSemester = itemSemester.value;
        itemGroup = $('#studentToGroupConsultFlangeGroupFilter').jqxDropDownList('getSelectedItem');
        itemGroup = itemGroup.value;
        itemPeriod = $('#studentToGroupConsultFlangePeriodFilter').jqxDropDownList('getSelectedItem');
        itemPeriod = itemPeriod.value;
        var dataAdapter = new $.jqx.dataAdapter(loadSource(itemCareer, itemSemester, itemGroup, itemPeriod ));
        $("#tableStudentGroupConsult").jqxGrid({
            width: 500,
            height:300,
            localization: getLocalization("es"),
            selectionmode: 'singlerow',
            pagesizeoptions:['25', '30', '50'],
            pagesize: 25,
            editmode: 'dblclick',
            source: dataAdapter,
            pageable: true,
            editable: false,
            filterable: true,
            altRows: true,
            pagerButtonsCount: 10,
            ready: function(){
                
            },
            columns: [
                { text: 'NP', selectionmode:'none', disabled: true, filterable: false, editable: false, dataField: 'dataProgresivNumber', width: 25 },
                { text: 'Matrícula', dataField: 'dataEnrollment', width: 130 },
                { text: 'Alumno', dataField: 'dataStudentName' }
            ]
        });
    });
</script>
<div style="float: left; margin-right: 5px;">
    Nivel de estudio <br>
    <div id='studentToGroupConsultFlangeLevelFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Carrera <br>
    <div id='studentToGroupConsultFlangeCareerFilter'></div>
</div>
<div style="float: right; margin-right: 5px;">
    Periodo <br>
    <div id='studentToGroupConsultFlangePeriodFilter'></div>
</div>
<br><br><br>
<div style="float: left; margin-right: 5px;">
    Cuatrimestre<br>
    <div id='studentToGroupConsultFlangeSemesterFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Grupo<br>
    <div id='studentToGroupConsultFlangeGroupFilter'></div>
</div>
<div id="tutorDiv" style="float: left; margin-right: 5px; display: none">
    Tutor<br>
    <div id='studentToGroupConsultFlangeTutorFilter'></div>
</div>
<br><br><br>
<div style="float: left; margin-right: 5px;">
    <div id="tableStudentGroupConsult"></div>
</div>