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
                    { name: 'dataStudentName', type: 'string' },
                    { name: 'dataStatusRow', type: 'int' },
                    { name: 'dataStatusRowQuestion', type: 'string' }
                ],
                root: "__ENTITIES",
                dataType: "json",
                async: false,
                id: 'id',
                url: '../serviceStudentsGroup?view=insert',
                addRow: function (rowID, rowData, position, commit) {
                },
                updateRow: function (rowID, rowData, commit) {
                },
                deleteRow: function (rowID, commit) {
                }
            };
            return ordersSource;
        }
        $("#jqxWindowAlert").jqxWindow({
            theme: theme,
            height: 150,
            width: 400,
            resizable: false,
            draggable: true,
            okButton: $('#okWarning'),
            autoOpen: false,
            isModal: true,
            cancelButton: $('#cancelWarning'),
            initContent: function () {
                $('#okWarning').jqxButton({
                    width: '80px',
                    theme: theme
                });
                $('#cancelWarning').jqxButton({
                    width: '80px',
                    theme: theme
                });
                $('#okWarning').focus();
            }
        });
        function loadGridStudentGroup(){
            var dataAdapter = new $.jqx.dataAdapter(loadSource());
            
            var cellclass = function (row, columnfield, value) {
                var classTheme="";
                var data = $('#tableStudentGroup').jqxGrid('getrowdata', row);
                if(data.dataStatusRow===0){
                    classTheme="not-exists";
                }else if(data.dataStatusRow===2){
                    classTheme="exist-in-same-group";
                }else if(data.dataStatusRow===3){
                    classTheme="exist-in-diferent-group";
                }else{
                    classTheme="";
                }  
                return classTheme;
            };
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
                    $('#tableStudentGroup').jqxGrid('hidecolumn', 'dataStatusRow');
                    $('#tableStudentGroup').jqxGrid('hidecolumn', 'dataStatusRowQuestion');
                },
                columns: [
                    { text: 'NP',pageable: false, selectionmode:'none', disabled: true, filterable: false, editable: false, dataField: 'dataProgresivNumber', width: 25 },
                    { cellclassname: cellclass, text: 'Matrícula', dataField: 'dataEnrollment', width: 130 },
                    { cellclassname: cellclass, text: 'Alumno', dataField: 'dataStudentName' },
                    { text: 'Estado', dataField: 'dataStatusRow' ,disabled: true, filterable: false, editable: false},
                    { text: 'Pregunta', dataField: 'dataStatusRowQuestion' ,disabled: true, filterable: false, editable: false}
                ]
            });
            
        }
        loadGridStudentGroup();
        
        var indexExternal = 0;
        var reset = true;
        $("#btnBottomAdd").click(function (){
            if(reset){
                for(var d=0;d<50; d++){
                    $("#tableStudentGroup").jqxGrid('setcellvalue', d, "dataStatusRow", "");
                    $("#tableStudentGroup").jqxGrid('setcellvalue', d, "dataStatusRowQuestion", "");
                }
            }
            insertStudentToGroup();
        });
        $("#okWarning").click(function (){
            changeValQuestionCell(indexExternal, "Si");
            indexExternal=0;
            insertStudentToGroup();
        });
        $("#cancelWarning").click(function (){
            changeValQuestionCell(indexExternal, "No");
            indexExternal=0;
            insertStudentToGroup();
        });
        function insertStudentToGroup(){
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
                var valueQuestion = $('#tableStudentGroup').jqxGrid('getcellvalue', i, "dataStatusRowQuestion");
                var url = "";
                if(valueQuestion=="Si"){
                    url = "../serviceStudentsGroup?update";
                }else{
                    url = "../serviceStudentsGroup?insert";
                }
                if(data.dataEnrollment!==""&&data.dataStudentName!==""&&data.dataStatusRowQuestion!=="No"){
                    $.ajax({
                        //Send the paramethers to servelt
                        type: "POST",
                        async: false,
                        url: url,
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
                            if(data.includes("base de datos")){
                                $("#messageWarning").html(data+"<br>Por lo que no será asociado a un grupo...");
                                $("#tableStudentGroup").jqxGrid('setcellvalue', i, "dataStatusRow", "0");
                                $("#okWarning").hide();
                                $("#jqxWindowAlert").jqxWindow('open');
                            }else if(data.includes("Registro Insertado")){
                                $("#tableStudentGroup").jqxGrid('setcellvalue', i, "dataStatusRow", "1");
                                $("#tableStudentGroup").jqxGrid('setcellvalue', i, "dataEnrollment", "");
                                $("#tableStudentGroup").jqxGrid('setcellvalue', i, "dataStudentName", "");
                                $("#tableStudentGroup").jqxGrid('setcellvalue', i, "dataStatusRow", "");
                                $("#tableStudentGroup").jqxGrid('setcellvalue', i, "dataStatusRowQuestion", "");
                            }else if(data.includes("Registro Actualizado")){
                                $("#tableStudentGroup").jqxGrid('setcellvalue', i, "dataStatusRow", "2");
                                $("#tableStudentGroup").jqxGrid('setcellvalue', i, "dataEnrollment", "");
                                $("#tableStudentGroup").jqxGrid('setcellvalue', i, "dataStudentName", "");
                            }else if(data.includes("en este grupo")){
                                $("#tableStudentGroup").jqxGrid('setcellvalue', i, "dataStatusRow", "3");
                                $("#messageWarning").html(data+"<br>Por lo tanto será omitido...");
                            }else if(data.includes("en el grupo")){
                                $("#tableStudentGroup").jqxGrid('setcellvalue', i, "dataStatusRow", "4");
                                $("#messageWarning").html(data+"<br>Desea cambiar el alumno al grupo actual...");
                                $("#okWarning").show();
                                $("#jqxWindowAlert").jqxWindow('open');
                            }
                        }
                    });
                    var value = $('#tableStudentGroup').jqxGrid('getcellvalue', i, "dataStatusRow");
                    
                    if(value==0){
                        indexExternal = i;
                        break;
                    }
                    if(value==2){
                        insertStudentToGroup();
                    }
                    if(value==4){
                        indexExternal = i;
                        break;
                    }
                }
            }
        }
        function changeValQuestionCell(indice, val){
            $("#tableStudentGroup").jqxGrid('setcellvalue', indice, "dataStatusRowQuestion", val);
        }
    });
</script>
<style>
    .not-exists{
        color: red !important;
    }
    .exist-in-same-group{
        color: #026468 !important;
    }
    .exist-in-diferent-group{
        color: gray !important;
    }
</style>
<div id='jqxWindowAlert'>
    <div>Advertencia</div>
    <div>
        <div id="iconWarning" class="warning" style="position: absolute;"></div>
        <span style="color: olive; width: 70%; position: absolute; right: 20px;">
            <b id="messageWarning"></b>
        </span>
        <div style="float: right; bottom: 10px; right: 20px;  position: absolute;">
            <input type="button" id="okWarning" value="OK" style="margin-right: 10px" />
            <input type="button" id="cancelWarning" value="Cancelar" />
        </div>
    </div>
</div>
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