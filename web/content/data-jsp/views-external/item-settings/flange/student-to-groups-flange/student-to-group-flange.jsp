<script type="text/javascript">
    $(document).ready(function () {
        var itemLevel = 0;
        var itemCareer = 0;
        var itemPeriod = 0;
        var itemSemester = 0;
        var itemGroup = 0;
        var itemTeacher = 0;
        $("#btnBottomAdd").jqxButton({ width: '100'});
        createDropDownStudyLevelByDirector("#studentToGroupFlangeLevelFilter",false);
        itemLevel = $('#studentToGroupFlangeLevelFilter').jqxDropDownList('getSelectedItem');
        itemLevel = itemLevel.value;
        createDropDownCareerByDirector(itemLevel ,"#studentToGroupFlangeCareerFilter",false);
        createDropDownPeriod("comboActiveYear","#studentToGroupFlangePeriodFilter");
        createDropDownSemester(itemLevel,"#studentToGroupFlangeSemesterFilter",false);
        itemSemester = $('#studentToGroupFlangeSemesterFilter').jqxDropDownList('getSelectedItem');
        itemSemester = itemSemester.value;
        createDropDownGruop(itemSemester,"#studentToGroupFlangeGroupFilter",false);
        createDropDownTutorTeacher("#studentToGroupFlangeTutorFilter",false);
        $('#studentToGroupFlangeLevelFilter').on('change',function (event){  
            itemLevel = $('#studentToGroupFlangeLevelFilter').jqxDropDownList('getSelectedItem');
            itemLevel = itemLevel.value;
            createDropDownCareerByDirector(itemLevel, "#studentToGroupFlangeCareerFilter", true);
            itemCareer = $('#studentToGroupFlangeCareerFilter').jqxDropDownList('getSelectedItem');
            itemCareer = itemCareer.value;
            createDropDownSemester(itemLevel,"#studentToGroupFlangeSemesterFilter", true);
            itemSemester = $('#studentToGroupFlangeSemesterFilter').jqxDropDownList('getSelectedItem');
            itemSemester = itemSemester.value;
            createDropDownGruop(itemSemester,"#studentToGroupFlangeGroupFilter",true);
            
        });
        $('#studentToGroupFlangeCareerFilter').on('change',function (event){           
            itemCareer = $('#studentToGroupFlangeCareerFilter').jqxDropDownList('getSelectedItem');
            itemCareer = itemCareer.value;
        });
        var evenPeriod = false;
        $('#studentToGroupFlangePeriodFilter').on('click',function (event){   
            evenPeriod=true; 
        });
        $('#studentToGroupFlangePeriodFilter').on('keyup',function (event){   
            evenPeriod=true; 
        });
        $('#studentToGroupFlangePeriodFilter').on('change',function (event){           
            itemPeriod = $('#studentToGroupFlangePeriodFilter').jqxDropDownList('getSelectedItem');
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
            }
            evenPeriod=false;
        });
        $("#studentToGroupFlangeSemesterFilter").on('change',function (){
            itemSemester = $('#studentToGroupFlangeSemesterFilter').jqxDropDownList('getSelectedItem');
            itemSemester = itemSemester.value;
            createDropDownGruop(itemSemester,"#studentToGroupFlangeGroupFilter",true);
        });
        function loadSource(){
            var ordersSource ={
                dataFields: [
                    { name: 'id', type:'int'},
                    { name: 'dataProgresivNumber', type:'int'},
                    { name: 'dataEnrollment', type: 'string' },
                    { name: 'dataStudentName', type: 'string' }
                ],
                root: "__ENTITIES",
                dataType: "json",
                async: false,
                id: 'id',
                url: '../serviceStudentsGroup?view=insert',
                addRow: function (rowID, rowData, position, commit) {
                    // synchronize with the server - send insert command
                    // call commit with parameter true if the synchronization with the server is successful 
                    // and with parameter false if the synchronization failed.
                    // you can pass additional argument to the commit callback which represents the new ID if it is generated from a DB.
                    
                },
                updateRow: function (rowID, rowData, commit) {
                    // synchronize with the server - send update command
                    // call commit with parameter true if the synchronization with the server is successful 
                    // and with parameter false if the synchronization failed.
                    /*commit(true);
                    var nameEntity = rowData.dataNameEntity;
                    $.ajax({
                        //Send the paramethers to servelt
                        type: "POST",
                        url: "../serviceGroupMatterTeacher?update",
                        data:{'pkEntity':rowID,'nameEntity':nameEntity},
                        beforeSend: function (xhr) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //This is if exits an error with the server internal can do server off, or page not found
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) { 
                            //If is updated rechange the drowdown in the other flange...
                            createDropDownEntity('#entityFilterMunicipality', true);
                            createDropDownEntity('#entityFilterLocality', true);
                            createDropDownEntity('#entityFilterPreparatory', true);
                        }
                    });*/
                },
                deleteRow: function (rowID, commit) {
                    // synchronize with the server - send delete command
                    // call commit with parameter true if the synchronization with the server is successful 
                    // and with parameter false if the synchronization failed.
                    /*commit(true);
                    $.ajax({
                        //Send the paramethers to servelt
                        type: "POST",
                        url: "../serviceGroupMatterTeacher?delete",
                        data:{'pkEntity':rowID},
                        beforeSend: function (xhr) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //This is if exits an error with the server internal can do server off, or page not found
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) {
                            $("#tableStudentGroup").jqxDataTable('updateBoundData');
                        }
                    });*/
                }
            };
            return ordersSource;
        }
        var dataAdapter = new $.jqx.dataAdapter(loadSource());
        $("#tableStudentGroup").jqxGrid({
            width: 500,
            height:300,
            selectionMode: "multiplecellsadvanced",
            localization: getLocalization("es"),
            pagesizeoptions:['25', '30', '50'],
            pagesize: 25,
            editmode: 'dblclick',
            source: dataAdapter,
            pageable: false,
            editable: true,
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
        $("#btnBottomAdd").click(function (){
            itemCareer = $('#studentToGroupFlangeCareerFilter').jqxDropDownList('getSelectedItem');
            itemCareer = itemCareer.value;
            itemSemester = $('#studentToGroupFlangeSemesterFilter').jqxDropDownList('getSelectedItem');
            itemSemester = itemSemester.value;
            itemGroup = $('#studentToGroupFlangeGroupFilter').jqxDropDownList('getSelectedItem');
            itemGroup = itemGroup.value;
            itemTeacher = $('#studentToGroupFlangeTutorFilter').jqxDropDownList('getSelectedItem');
            itemTeacher = itemTeacher.value;
            itemPeriod = $('#studentToGroupFlangePeriodFilter').jqxDropDownList('getSelectedItem');
            itemPeriod = itemPeriod.value;
            for (var i = 0; i < 50; i++) {
                var data = $('#tableStudentGroup').jqxGrid('getrowdata', i);
                if(data.dataEnrollment!==""&&data.dataStudentName!==""){
                    $.ajax({
                        //Send the paramethers to servelt
                        type: "POST",
                        async: false,
                        url: "../serviceStudentsGroup?insert",
                        data:{
                            'enrollment': data.dataEnrollment,
                            'fkCareer': itemCareer,
                            'fkSemester': itemSemester,
                            'fkGroup': itemGroup,
                            'fkPeriod': itemPeriod,
                            'fkTutor': itemTeacher
                        },
                        beforeSend: function (xhr) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //This is if exits an error with the server internal can do server off, or page not found
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) { 
                            if(data==="Not Exits"){
                                alert(data);
                            }else if(data==="Registro Insertado"){
                                $("#tableStudentGroup").jqxGrid('setcellvalue', i, "dataEnrollment", "");
                                $("#tableStudentGroup").jqxGrid('setcellvalue', i, "dataStudentName", "");
                            }else if(data==="Registro Actualizado"){
                                alert(data);
                            }
                        }
                    });
                }
            }
        });
    });
</script>
<div style="float: left; margin-right: 5px;">
    Nivel de estudio<br>
    <div id='studentToGroupFlangeLevelFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Carrera <br>
    <div id='studentToGroupFlangeCareerFilter'></div>
</div>
<div style="float: right; margin-right: 5px;">
    Periodo <br>
    <div id='studentToGroupFlangePeriodFilter'></div>
</div>
<br><br><br>
<div style="float: left; margin-right: 5px;">
    Cuatrimestre<br>
    <div id='studentToGroupFlangeSemesterFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Grupo<br>
    <div id='studentToGroupFlangeGroupFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Tutor<br>
    <div id='studentToGroupFlangeTutorFilter'></div>
</div>
<br><br><br>
<div style="float: left; margin-right: 5px;">
    <div id="tableStudentGroup"></div>
</div>
<button style=" margin: 10px 10px 0 0;" id="btnBottomAdd">Agregar</button>