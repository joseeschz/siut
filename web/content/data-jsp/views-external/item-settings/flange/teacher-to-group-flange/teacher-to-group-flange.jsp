<script type="text/javascript">
    $(document).ready(function () {
        var itemLevel = 0;
        var itemCareer = 0;
        var itemPeriod = 0;
        var itemSemester = 0;
        var itemGroup = 0;
        var itemStudyPlan = 0;
        var itemsListTeacher = 0;
        var filtrableSubjectMatters=[];
        var bindingCompleteCareer=true;
        var bindingCompleteSemester = true;
        var bindingCompleteGroup = true;
        var bindingCompleteStudyPlan = true;
        $("#btnBottomAsign").jqxButton({ width: '100'});
        createDropDownStudyLevelByDirector("#teacherToGroupFlangeLevelFilter",false);
        itemLevel = $('#teacherToGroupFlangeLevelFilter').jqxDropDownList('getSelectedItem');
        createDropDownCareerByDirector(itemLevel.value ,"#teacherToGroupFlangeCareerFilter",false);
        itemCareer = $('#teacherToGroupFlangeCareerFilter').jqxDropDownList('getSelectedItem');
        createDropDownPeriod("comboAll","#teacherToGroupFlangePeriodFilter");
        itemPeriod = $('#teacherToGroupFlangePeriodFilter').jqxDropDownList('getSelectedItem');
        createDropDownSemester(itemLevel.value,"#teacherToGroupFlangeSemesterFilter",false);
        itemSemester = $('#teacherToGroupFlangeSemesterFilter').jqxDropDownList('getSelectedItem');
        createDropDownGruop(itemSemester.value,"#teacherToGroupFlangeGroupFilter",false);
        itemGroup = $('#teacherToGroupFlangeGroupFilter').jqxDropDownList('getSelectedItem');
        createDropDownStudyPlan(itemCareer.value,"#subjectMattersStudyPlanFilter",false);
        itemStudyPlan = $('#subjectMattersStudyPlanFilter').jqxDropDownList('getSelectedItem');
        functionFiltrableSubjectMatters(false);
        createLitsBoxTeachers("#listTeacher",false);
        
        itemsListTeacher = $("#listTeacher").jqxListBox('getSelectedItem');
        $("#listTeacher").on('select', function (event){
            var args = event.args;
            if(args){
                itemsListTeacher = args.item;
            }
        });
        function filterableTable(change){
            if(change){
                var pk_career = itemCareer.value;
                var pk_study_plan = itemStudyPlan.value;
                var pk_period = itemPeriod.value;
                var pk_semester = itemSemester.value;
                var pk_group = itemGroup.value;
                $("#tableGroupMatterTeacher").unbind("bindingComplete");
                dataAdapter = new $.jqx.dataAdapter(loadSource(pk_career, pk_study_plan, pk_period, pk_semester, pk_group));
                $("#tableGroupMatterTeacher").jqxDataTable({source: dataAdapter});  
            }
        }
        $('#teacherToGroupFlangeCareerFilter').on('bindingComplete', function (event) {
            bindingCompleteCareer = true;
        });
        $('#teacherToGroupFlangeSemesterFilter').on('bindingComplete', function (event) {
            bindingCompleteSemester = true;
        });
        $('#teacherToGroupFlangeGroupFilter').on('bindingComplete', function (event) {
            bindingCompleteGroup = true;
        });
        $('#subjectMattersStudyPlanFilter').on('bindingComplete', function (event) {
            bindingCompleteStudyPlan = true;
        });
        function functionFiltrableSubjectMatters(update){
            var canFilter = true;
            if(canFilter){
                itemCareer = $('#teacherToGroupFlangeCareerFilter').jqxDropDownList('getSelectedItem');
                itemSemester = $('#teacherToGroupFlangeSemesterFilter').jqxDropDownList('getSelectedItem');
                itemGroup = $('#teacherToGroupFlangeGroupFilter').jqxDropDownList('getSelectedItem');
                itemStudyPlan = $('#subjectMattersStudyPlanFilter').jqxDropDownList('getSelectedItem');
                itemPeriod = $('#teacherToGroupFlangePeriodFilter').jqxDropDownList('getSelectedItem');
                filtrableSubjectMatters[0] = itemCareer.value;
                filtrableSubjectMatters[1] = itemSemester.value;
                filtrableSubjectMatters[2] = itemGroup.value;
                filtrableSubjectMatters[3] = itemStudyPlan.value;
                filtrableSubjectMatters[4] = itemPeriod.value;
                //alert(filtrableSubjectMatters[0]+"--"+filtrableSubjectMatters[1]+"--"+filtrableSubjectMatters[2]+"--"+filtrableSubjectMatters[3]+"--"+filtrableSubjectMatters[4]+"");
                createLitsBoxSubjectMatters(filtrableSubjectMatters,"#listSubjectMatters", update);
                canFilter=false;
            }
        }
        $("#jqxExpander1TeacherToGroupFlange").jqxExpander({ width: 'auto', height: "auto"});
        $("#jqxExpander2TeacherToGroupFlange").jqxExpander({ width: 'auto', height: "auto"});
        var evenLevel=false;
        var evenCareer=false;
        var evenPeriod = false;
        var evenSemester = false;
        var evenGroup=false;
        var evenStudyPlan=false;
        $('#teacherToGroupFlangeLevelFilter').on('click',function (event){  
            evenLevel=true;
        });
        $('#teacherToGroupFlangeLevelFilter').on('keyup',function (event){  
            evenLevel=true;
        });
        $('#teacherToGroupFlangeLevelFilter').on('change',function (event){  
            bindingCompleteCareer=false;
            bindingCompleteSemester=false;
            itemLevel = $('#teacherToGroupFlangeLevelFilter').jqxDropDownList('getSelectedItem');
            createDropDownCareerByDirector(itemLevel.value, "#teacherToGroupFlangeCareerFilter", true);
            createDropDownSemester(itemLevel.value,"#teacherToGroupFlangeSemesterFilter", true);
            if(evenLevel){
                filterableTable(true);
            }
            evenLevel=false;
        });
        $('#teacherToGroupFlangeCareerFilter').on('click',function (event){   
           evenCareer=true; 
        });
        $('#teacherToGroupFlangeCareerFilter').on('keyup',function (event){   
           evenCareer=true; 
        });
        $('#teacherToGroupFlangeCareerFilter').on('change',function (event){
            if(bindingCompleteCareer){
                bindingCompleteStudyPlan = false;
                itemCareer = $('#teacherToGroupFlangeCareerFilter').jqxDropDownList('getSelectedItem');
                createDropDownStudyPlan(itemCareer.value,"#subjectMattersStudyPlanFilter",true);
                if(evenCareer){
                    filterableTable(true);
                }
                evenCareer=false;
            }
        });
        
        $('#teacherToGroupFlangePeriodFilter').on('click',function (event){   
           evenPeriod=true; 
        });
        $('#teacherToGroupFlangePeriodFilter').on('keyup',function (event){   
           evenPeriod=true; 
        });
        $('#teacherToGroupFlangePeriodFilter').on('change',function (event){
            itemPeriod = $('#teacherToGroupFlangePeriodFilter').jqxDropDownList('getSelectedItem');
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
                        $(".jqx-icon-delete").hide();
                        $("#btnBottomAsign").hide();
                    }else{
                        $(".jqx-icon-delete").show();
                        $("#btnBottomAsign").show();
                    }
                }
            });
            functionFiltrableSubjectMatters(true);
            if(evenPeriod){
                filterableTable(true);
            }
            evenPeriod=false;
        });
        
        $("#teacherToGroupFlangeSemesterFilter").on('click',function (){
            evenSemester = true;
        });
        $("#teacherToGroupFlangeSemesterFilter").on('keyup',function (){
            evenSemester = true;
        });
        $("#teacherToGroupFlangeSemesterFilter").on('change',function (){
            if(bindingCompleteSemester){
                bindingCompleteGroup = false;
                itemSemester = $('#teacherToGroupFlangeSemesterFilter').jqxDropDownList('getSelectedItem');
                createDropDownGruop(itemSemester.value,"#teacherToGroupFlangeGroupFilter",true);
                if(evenSemester){
                    filterableTable(true);
                }
                evenSemester=false;
            }
        });
        $("#teacherToGroupFlangeGroupFilter").on('click',function (){
            evenGroup=true;
        });
        $("#teacherToGroupFlangeGroupFilter").on('keyup',function (){
            evenGroup=true;
        });
        $("#teacherToGroupFlangeGroupFilter").on('change',function (){
            if(bindingCompleteGroup){
                itemGroup = $('#teacherToGroupFlangeGroupFilter').jqxDropDownList('getSelectedItem');
                functionFiltrableSubjectMatters(true);
                if(evenGroup){
                    filterableTable(true);
                }
                evenGroup=false;
            }
        });
        
        $("#subjectMattersStudyPlanFilter").on('click',function (){
            evenStudyPlan=true;
        });
        $("#subjectMattersStudyPlanFilter").on('keyup',function (){
            evenStudyPlan=true;
        });
        $("#subjectMattersStudyPlanFilter").on('change',function (){
            if(bindingCompleteStudyPlan){
                itemStudyPlan = $('#subjectMattersStudyPlanFilter').jqxDropDownList('getSelectedItem');
                functionFiltrableSubjectMatters(true);
                if(evenStudyPlan){
                    filterableTable(true);
                }
                evenStudyPlan=false;
            }
        });
        function loadSource(pk_career, pk_study_plan, pk_period, pk_semester, pk_group){
            var ordersSource ={
                dataFields: [
                    { name: 'id', type:'int'},
                    { name: 'dataProgresivNumber', type:'int'},
                    { name: 'dataSemesterName', type: 'string' },
                    { name: 'dataGroupName', type: 'string' },
                    { name: 'dataSubjectMatterName', type: 'string' },
                    { name: 'dataTeacherName', type: 'string' }
                ],
                root: "__ENTITIES",
                dataType: "json",
                id: 'id',
                async: false,
                url: '../serviceGroupMatterTeacher?view&pk_career='+pk_career+'&pk_study_plan='+pk_study_plan+'&pk_period='+pk_period+'&pk_semester='+pk_semester+'&pk_group='+pk_group+'',
                addRow: function (rowID, rowData, position, commit) {
                    // synchronize with the server - send insert command
                    // call commit with parameter true if the synchronization with the server is successful 
                    // and with parameter false if the synchronization failed.
                    // you can pass additional argument to the commit callback which represents the new ID if it is generated from a DB.;
                    var itemsListSubjectMatters = $("#listSubjectMatters").jqxListBox('getSelectedItems');  
                    if (itemsListSubjectMatters.length > 0) {
                        var valueListSubjectMatter = 0;
                        for (var i = 0; i < itemsListSubjectMatters.length; i++) {
                            commit(true);
                            valueListSubjectMatter = itemsListSubjectMatters[i].value;
                            $.ajax({
                                //Send the paramethers to servelt
                                type: "POST",
                                async: false,
                                url: "../serviceGroupMatterTeacher?insert",
                                data:{'fkCareer':itemCareer.value, 'fkPeriod':itemPeriod.value, 'fkSemester':itemSemester.value, 'fkGroup':itemGroup.value,'fkMatter':valueListSubjectMatter,'fkTeacher':itemsListTeacher.value},
                                beforeSend: function (xhr) {
                                },
                                error: function (jqXHR, textStatus, errorThrown) {
                                    //This is if exits an error with the server internal can do server off, or page not found
                                    alert("Error interno del servidor");
                                },
                                success: function (data, textStatus, jqXHR) {
                                    $("#tableGroupMatterTeacher").jqxDataTable('updateBoundData');
                                    functionFiltrableSubjectMatters(true);
                                    $('#tableGroupMatterTeacher').on('bindingComplete', function (event) {
                                        $("#tableGroupMatterTeacher").jqxDataTable('goToPage', 0);
                                    }); 
                                }
                            });
                        }
                    }
                },
                updateRow: function (rowID, rowData, commit) {
                },
                deleteRow: function (rowID, commit) {
                    // synchronize with the server - send delete command
                    // call commit with parameter true if the synchronization with the server is successful 
                    // and with parameter false if the synchronization failed.
                    commit(true);
                    $.ajax({
                        //Send the paramethers to servelt
                        type: "POST",
                        async: false,
                        url: "../serviceGroupMatterTeacher?delete",
                        data:{'pkGroupMatterTeacher':rowID},
                        beforeSend: function (xhr) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //This is if exits an error with the server internal can do server off, or page not found
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) {
                            $("#tableGroupMatterTeacher").jqxDataTable('updateBoundData');
                            functionFiltrableSubjectMatters(true);
                        }
                    });
                }
            };
            return ordersSource;
        }
        var dataAdapter = new $.jqx.dataAdapter(loadSource(itemCareer.value, itemPeriod.value, itemSemester.value, itemGroup.value));
        $("#tableGroupMatterTeacher").jqxDataTable({
            width: 450,
            height:255,
            selectionMode: "singleRow",
            localization: getLocalization("es"),
            source: dataAdapter,
            pageable: true,
            editable: false,
            filterable: true,
            showToolbar: true,
            altRows: true,
            pagerButtonsCount: 10,
            toolbarHeight: 35,
            renderToolbar: function(toolBar){
                var theme = "";
                var toTheme = function (className) {
                    if (theme === "") return className;
                    return className + " " + className + "-" + theme;
                };
                // appends buttons to the status bar.
                var container = $("<div style='overflow: hidden; position: relative; height: 100%; width: 100%;'></div>");
                var buttonTemplate = "<div style='float: left; padding: 3px; margin: 2px;'><div style='margin: 4px; width: 16px; height: 16px;'></div></div>";
                //var editButton = $(buttonTemplate);
                var deleteButton = $(buttonTemplate);
                //var updateButton = $(buttonTemplate);
                //container.append(editButton);
                container.append(deleteButton);
                //container.append(updateButton);
                toolBar.append(container);
                //editButton.jqxButton({ cursor: "pointer", disabled: true, enableDefault: false,  height: 25, width: 25 });
                //editButton.find('div:first').addClass(toTheme('jqx-icon-edit'));
                //editButton.jqxTooltip({ position: 'bottom', content: "Editar"});
                deleteButton.jqxButton({ cursor: "pointer", disabled: true, enableDefault: false,  height: 25, width: 25 });
                deleteButton.find('div:first').addClass(toTheme('jqx-icon-delete'));
                deleteButton.jqxTooltip({ position: 'bottom', content: "Eliminar"});
                //updateButton.jqxButton({ cursor: "pointer", disabled: true, enableDefault: false,  height: 25, width: 25 });
                //updateButton.find('div:first').addClass(toTheme('jqx-icon-save'));
                //updateButton.jqxTooltip({ position: 'bottom', content: "Guardar"});
                var updateButtons = function (action) {
                    switch (action) {
                        case "Select":
                            deleteButton.jqxButton({ disabled: false });
                            //editButton.jqxButton({ disabled: false });
                            //updateButton.jqxButton({ disabled: true });
                            break;
                        case "Unselect":
                            deleteButton.jqxButton({ disabled: true });
                            //editButton.jqxButton({ disabled: true });
                            //updateButton.jqxButton({ disabled: true });
                            break;
                        case "Edit":
                            deleteButton.jqxButton({ disabled: true });
                            //editButton.jqxButton({ disabled: true });
                            //updateButton.jqxButton({ disabled: false });
                            break;
                        case "End Edit":
                            deleteButton.jqxButton({ disabled: false });
                            //editButton.jqxButton({ disabled: false });
                            //updateButton.jqxButton({ disabled: true });
                            break;
                    }
                };
                var rowIndex = null;
                $("#tableGroupMatterTeacher").on('rowSelect', function (event) {
                    var args = event.args;
                    rowIndex = args.index;
                    updateButtons('Select');
                });
                $("#tableGroupMatterTeacher").on('rowUnselect', function (event) {
                    updateButtons('Unselect');
                });
                $("#tableGroupMatterTeacher").on('rowEndEdit', function (event) {
                    updateButtons('End Edit');
                });
                $("#tableGroupMatterTeacher").on('rowBeginEdit', function (event) {
                    updateButtons('Edit');
                });
                /*updateButton.click(function (event) {
                    if (!updateButton.jqxButton('disabled')) {
                        // save changes.
                        $("#tableGroupMatterTeacher").jqxDataTable('endRowEdit', rowIndex, false);
                    }
                });
                editButton.click(function () {
                    if (!editButton.jqxButton('disabled')) {
                        $("#tableGroupMatterTeacher").jqxDataTable('beginRowEdit', rowIndex);
                        updateButtons('edit');
                    }
                });*/
                deleteButton.click(function () {
                    if (!deleteButton.jqxButton('disabled')){
                        $("#jqxWindowWarning").jqxWindow('open');
                        $("#ok").click(function (){
                            $("#ok").unbind("click"); 
                            $("#jqxWindowWarning").jqxWindow('close');
                            $("#tableGroupMatterTeacher").jqxDataTable('deleteRow', rowIndex);
                        });
                        updateButtons('delete');
                    }
                });
            },
            ready: function(){
            },
            columns: [
                { text: 'NP',filterable: false, editable: false, dataField: 'dataProgresivNumber', width: 25 },
                { text: 'Materia', dataField: 'dataSubjectMatterName', width: 250 },
                { text: 'Profesor', dataField: 'dataTeacherName' }
            ]
        }); 
        $("#btnBottomAsign").click(function (){
            $("#tableGroupMatterTeacher").jqxDataTable('addRow', null, {}, 'first');
        });
    });
</script>
<div style="float: left; margin-right: 5px;">
    Nivel de estudio <br>
    <div id='teacherToGroupFlangeLevelFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Carrera <br>
    <div id='teacherToGroupFlangeCareerFilter'></div>
</div>
<div style="float: right; margin-right: 5px;">
    Periodo <br>
    <div id='teacherToGroupFlangePeriodFilter'></div>
</div>
<br><br><br>
<div style="float: left; margin-right: 5px;">
    Cuatrimestre<br>
    <div id='teacherToGroupFlangeSemesterFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Grupo<br>
    <div id='teacherToGroupFlangeGroupFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Plan de estudio<br>
    <div id='subjectMattersStudyPlanFilter'></div>
</div>
<br><br><br><br>
<div id='jqxExpander1TeacherToGroupFlange' style="padding-bottom: 4px; float: left; margin-right: 5px;">
    <div>
        Listas
    </div>
    <div style="padding: 5px">
        <div style="float: left; margin-right: 5px;">
            <b>Materias</b><br>
            <div id="listSubjectMatters"></div>
        </div>
        <div style="float: left; margin-right: 10px;">
            <b>Profesores</b><br>
            <div id="listTeacher"></div>
        </div><br>
        <button style="float: right; margin: 10px 10px 0 0;" id="btnBottomAsign">Asignar</button>
    </div>
</div>
<div id='jqxExpander2TeacherToGroupFlange' style="padding-bottom: 4px; float: left; margin-right: 5px;">
    <div>
        Registros
    </div>
    <div style="padding: 5px">
        <div style="float: left; margin-right: 5px;">
            <div id="tableGroupMatterTeacher"></div>
        </div>
    </div>    
</div>
