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
                    $("#exportButton").jqxButton({disabled: false});
                    var item = $("#studentToGroupConsultFlangeTutorFilter").jqxDropDownList('getItemByValue', dataItem.dataPkTutor);
                    $("#studentToGroupConsultFlangeTutorFilter").jqxDropDownList('selectItem', item );
                }else{
                    $("#exportButton").jqxButton({disabled: true});
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
                url: '../serviceStudentsGroup?view=consult&fkCareer='+fk_career+'&fkSemester='+fk_semester+'&fkGroup='+fk_group+'&fkPeriod='+fk_period+'',
                deleterow: function (rowid, commit) {
                    // synchronize with the server - send delete command
                    // call commit with parameter true if the synchronization with the server was successful 
                    // and with parameter false if the synchronization has failed.
                    console.log(rowid);
                    for(var i=0; i<rowid.length; i++){
                        $.ajax({
                            //Send the paramethers to servelt
                            type: "POST",
                            async: false,
                            url: "../serviceStudentsGroup?delete",
                            data:{
                                'pkGroupByStudent': rowid[i]
                            },
                            beforeSend: function (xhr) {
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                //This is if exits an error with the server internal can do server off, or page not found
                                alert("Error interno del servidor");
                            },
                            success: function (data_result, textStatus, jqXHR) { 
                                commit(true);
                            }
                        });      
                    }             
                }
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
            selectionmode: 'multiplerowsextended',
            pagesizeoptions:['25', '30', '50'],
            pagesize: 25,
            editmode: 'dblclick',
            source: dataAdapter,
            pageable: true,
            editable: false,
            filterable: true,
            altRows: true,
            showtoolbar: true,
            pagerButtonsCount: 10,
            toolbarheight: 35,
            rendertoolbar: function(toolBar){
                var theme = "";
                var toTheme = function (className) {
                    if (theme === "") return className;
                    return className + " " + className + "-" + theme;
                };
                // appends buttons to the status bar.
                var container = $("<div style='overflow: hidden; position: relative; height: 100%; width: 100%;'></div>");
                var buttonTemplate = "<div style='float: left; padding: 3px; margin: 2px;'><div style='margin: 4px; width: 16px; height: 16px;'></div></div>";
   
   
                var deleteButton = $(buttonTemplate);
                var exportButton = $(buttonTemplate);
                
                container.append(deleteButton);
                container.append(exportButton);
                toolBar.append(container);
                
                deleteButton.jqxButton({ cursor: "pointer", disabled: true, enableDefault: false,  height: 25, width: 25 });
                deleteButton.find('div:first').addClass(toTheme('jqx-icon-delete'));
                deleteButton.jqxTooltip({ position: 'bottom', content: "Quitar del grupo"});
                
                exportButton.jqxButton({cursor: "pointer", disabled: true, enableDefault: false,  height: 25, width: 25 });
                exportButton.find('div:first').addClass(toTheme('jqx-icon-export'));
                exportButton.jqxTooltip({ position: 'bottom', content: "Exportar a pdf"});
                exportButton.attr("id","exportButton");
                
                var updateButtons = function (action) {
                    switch (action) {
                        case "Select":
                            deleteButton.jqxButton({ disabled: false });
                            break;
                        case "Unselect":
                            deleteButton.jqxButton({ disabled: true });
                            break;
                    }
                };
                var selectedrowindexes = null;
                $("#tableStudentGroupConsult").on('rowselect', function (event) {
                    updateButtons('Select');
                });
                $("#tableStudentGroupConsult").on('rowunselect', function (event) {
                    updateButtons('Unselect');
                });
                
                deleteButton.click(function () {
                    var rowIDs = new Array();
                    if (!deleteButton.jqxButton('disabled')) {
                        $("#jqxWidgetResultDelete").html("");
                        selectedrowindexes = $('#tableStudentGroupConsult').jqxGrid('selectedrowindexes'); 
                        
                        for(var i=0; i<selectedrowindexes.length; i++){
                            var rowid = $('#tableStudentGroupConsult').jqxGrid('getrowid', i);
                            rowIDs.push(rowid);
                            var data = $('#tableStudentGroupConsult').jqxGrid('getrowdatabyid', rowid);
                            $("#jqxWidgetResultDelete").html($("#jqxWidgetResultDelete").html()+"<span class='alert-delete'>"+data.dataEnrollment+"...</span><br>");
                        }
                        $("#jqxWindowWarning").jqxWindow('open');
                        $("#ok").click(function (){
                            $("#ok").unbind("click"); 
                            $("#jqxWindowWarning").jqxWindow('close');
                            $("#tableStudentGroupConsult").jqxGrid('deleterow', rowIDs);
                            updateButtons('Unselect');
                            rowIDs=null;
                        });
                        updateButtons('delete');
                    }
                });
                exportButton.click(function (){
                    itemCareer = $('#studentToGroupConsultFlangeCareerFilter').jqxDropDownList('getSelectedItem');
                    itemSemester= $('#studentToGroupConsultFlangeSemesterFilter').jqxDropDownList('getSelectedItem'); 
                    itemGroup = $('#studentToGroupConsultFlangeGroupFilter').jqxDropDownList('getSelectedItem');
                    itemPeriod = $('#studentToGroupConsultFlangePeriodFilter').jqxDropDownList('getSelectedItem');
                    $.ajax({
                        url: "../content/data-jr/studentsByGroup/index.jsp?sessionStudentsByGroup",
                        data: {
                            "pt_career": itemCareer.value,
                            "pt_semester": itemSemester.value,
                            "pt_group": itemGroup.value,
                            "pt_period": itemPeriod.value
                        },
                        type: 'POST',
                        beforeSend: function (xhr) {
                        },
                        success: function (data, textStatus, jqXHR) {
                            window.open("../content/data-jr/studentsByGroup");
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            alert("Error interno del servidor");                
                        }
                    });
                });
            },
            ready: function(){
            },
            columns: [
                { text: 'NP', selectionmode:'none', disabled: true, filterable: false, editable: false, dataField: 'dataProgresivNumber', width: 25 },
                { text: 'Matrícula', dataField: 'dataEnrollment', width: 130 },
                { text: 'Alumno', dataField: 'dataStudentName' }
            ]
        });
        $('#jqxWindowWarning').jqxWindow({
            theme: theme,
            height: 150,
            width: 350,
            resizable: false,
            draggable: true,
            okButton: $('#ok'),
            autoOpen: false,
            isModal: true,
            cancelButton: $('#cancel'),
            initContent: function () {
                $('#ok').jqxButton({
                    width: '80px',
                    theme: theme
                });
                $('#cancel').jqxButton({
                    width: '80px',
                    theme: theme
                });
                $('#ok').focus();
            }
        });
    });
</script>
<style>
    .alert-delete{
        color: red;
    }
</style>
<div id='jqxWindowWarning'>
    <div>Advertencia</div>
    <div>
        <div class="warning" style="position: absolute;"></div>
        <span style="color: olive; width: 70%; position: absolute; right: 20px;">
            <b>¡Se borrarán estos regitros!</b>
        </span>
        <div id='jqxWidgetResultDelete' style="padding: 5px; font-size: 13px; font-family: Verdana; min-height: 50px; max-height: 50px; overflow: auto; width: 233px; border: 1px solid rgb(119, 150, 112); color: rgb(84, 146, 95); margin-left: 80px; margin-top: 18px;">
            <span class="alert-delete">Sin registros...</span>
        </div>
        <div style="float: right; bottom: 10px; right: 20px;  position: absolute;">
            <input type="button" id="ok" value="OK" style="margin-right: 10px" />
            <input type="button" id="cancel" value="Cancelar" />
        </div>
    </div>
</div>
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