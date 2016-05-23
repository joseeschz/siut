<script type="text/javascript">
    $(document).ready(function () {
        var itemLevel = 0;
        var itemCareer = 0;
        function loadSource(fkCareer){
            var ordersSource ={
                dataFields: [
                    { name: 'id', type:'int'},
                    { name: 'dataProgresivNumber', type:'int'},
                    { name: 'dataNameStudyPlan', type: 'string' }
                ],
                root: "__ENTITIES",
                dataType: "json",
                async: false,
                id: 'id',
                url: '../serviceStudyPlan?view&&fkCareer='+fkCareer+'',
                addRow: function (rowID, rowData, position, commit) {
                    // synchronize with the server - send insert command
                    // call commit with parameter true if the synchronization with the server is successful 
                    // and with parameter false if the synchronization failed.
                    // you can pass additional argument to the commit callback which represents the new ID if it is generated from a DB.
                    itemCareer = $('#studyPlanCareerFilter').jqxDropDownList('getSelectedItem');
                    $.ajax({
                        //Send the paramethers to servelt
                        type: "POST",
                        async: false,
                        url: "../serviceStudyPlan?insert",
                        data:{'nameStudyPlan':" ",'fkCareer':itemCareer.value},
                        beforeSend: function (xhr) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //This is if exits an error with the server internal can do server off, or page not found
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) {
                            commit(true);
                            $("#tableStudyPlan").jqxDataTable('updateBoundData');
                            $("#tableStudyPlan").jqxDataTable('goToPage', 0);
                            $("#tableStudyPlan").jqxDataTable('beginRowEdit', 0);
                        }
                    });
                },
                updateRow: function (rowID, rowData, commit) {
                    // synchronize with the server - send update command
                    // call commit with parameter true if the synchronization with the server is successful 
                    // and with parameter false if the synchronization failed.
                    itemCareer = $('#studyPlanCareerFilter').jqxDropDownList('getSelectedItem');
                    var dataNameStudyPlan = rowData.dataNameStudyPlan;
                    $.ajax({
                        //Send the paramethers to servelt
                        type: "POST",
                        async: false,
                        url: "../serviceStudyPlan?update",
                        data:{'pkStudyPlan':rowID,'nameStudyPlan':dataNameStudyPlan,'fkCareer': itemCareer.value},
                        beforeSend: function (xhr) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //This is if exits an error with the server internal can do server off, or page not found
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) { 
                            //If is updated rechange the drowdown in the other flange...
                            commit(true);
                            createDropDownStudyPlan(itemCareer.value,"#subjectMattersStudyPlanFilter",true);
                        }
                    });
                },
                deleteRow: function (rowID, commit) {
                    // synchronize with the server - send delete command
                    // call commit with parameter true if the synchronization with the server is successful 
                    // and with parameter false if the synchronization failed.
                    itemCareer = $('#studyPlanCareerFilter').jqxDropDownList('getSelectedItem');
                    $.ajax({
                        //Send the paramethers to servelt
                        type: "POST",
                        async: false,
                        url: "../serviceStudyPlan?delete",
                        data:{'pkStudyPlan':rowID},
                        beforeSend: function (xhr) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //This is if exits an error with the server internal can do server off, or page not found
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) {
                            commit(true);
                            createDropDownStudyPlan(itemCareer.value,"#subjectMattersStudyPlanFilter",true);
                            $("#tableStudyPlan").jqxDataTable('updateBoundData');
                        }
                    });
                }
            };
            return ordersSource;
        };
        var dataAdapter;
        createDropDownStudyLevel("#studyPlanLevelFilter", false);
        itemLevel = $('#studyPlanLevelFilter').jqxDropDownList('getSelectedItem');
        if(itemLevel!==undefined){
            createDropDownCareer(itemLevel.value, "#studyPlanCareerFilter", false);
            itemCareer = $('#studyPlanCareerFilter').jqxDropDownList('getSelectedItem');
            if(itemCareer!==undefined){
                loadTable(itemCareer.value);
            }
        }else{
            createDropDownCareer(null, "#studyPlanCareerFilter", false);
        }
        function loadTable(pkCareer){
            dataAdapter = new $.jqx.dataAdapter(loadSource(pkCareer));
            $("#tableStudyPlan").jqxDataTable({
                width: 405,
                height : 200,
                selectionMode: "singleRow",
                localization: getLocalization("es"),
                source: dataAdapter,
                pageable: true,
                editable: true,
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
                    // appends buttons to the nameCareerAbreiated bar.
                    var container = $("<div style='overflow: hidden; position: relative; height: 100%; width: 100%;'></div>");
                    var buttonTemplate = "<div style='float: left; padding: 3px; margin: 2px;'><div style='margin: 4px; width: 16px; height: 16px;'></div></div>";
                    var addButton = $(buttonTemplate);
                    var editButton = $(buttonTemplate);
                    var deleteButton = $(buttonTemplate);
                    var cancelButton = $(buttonTemplate);
                    var updateButton = $(buttonTemplate);
                    container.append(addButton);
                    container.append(editButton);
                    container.append(deleteButton);
                    container.append(cancelButton);
                    container.append(updateButton);
                    toolBar.append(container);
                    addButton.jqxButton({cursor: "pointer", enableDefault: false,  height: 25, width: 25 });
                    addButton.find('div:first').addClass(toTheme('jqx-icon-plus'));
                    addButton.jqxTooltip({ position: 'bottom', content: "Agregar"});
                    editButton.jqxButton({ cursor: "pointer", disabled: true, enableDefault: false,  height: 25, width: 25 });
                    editButton.find('div:first').addClass(toTheme('jqx-icon-edit'));
                    editButton.jqxTooltip({ position: 'bottom', content: "Editar"});
                    deleteButton.jqxButton({ cursor: "pointer", disabled: true, enableDefault: false,  height: 25, width: 25 });
                    deleteButton.find('div:first').addClass(toTheme('jqx-icon-delete'));
                    deleteButton.jqxTooltip({ position: 'bottom', content: "Eliminar"});
                    updateButton.jqxButton({ cursor: "pointer", disabled: true, enableDefault: false,  height: 25, width: 25 });
                    updateButton.find('div:first').addClass(toTheme('jqx-icon-save'));
                    updateButton.jqxTooltip({ position: 'bottom', content: "Guardar"});
                    cancelButton.jqxButton({ cursor: "pointer", disabled: true, enableDefault: false,  height: 25, width: 25 });
                    cancelButton.find('div:first').addClass(toTheme('jqx-icon-cancel'));
                    cancelButton.jqxTooltip({ position: 'bottom', content: "Cancelar"});
                    var updateButtons = function (action) {
                        switch (action) {
                            case "Select":
                                addButton.jqxButton({ disabled: false });
                                deleteButton.jqxButton({ disabled: false });
                                editButton.jqxButton({ disabled: false });
                                cancelButton.jqxButton({ disabled: true });
                                updateButton.jqxButton({ disabled: true });
                                break;
                            case "Unselect":
                                addButton.jqxButton({ disabled: false });
                                deleteButton.jqxButton({ disabled: true });
                                editButton.jqxButton({ disabled: true });
                                cancelButton.jqxButton({ disabled: true });
                                updateButton.jqxButton({ disabled: true });
                                break;
                            case "Edit":
                                addButton.jqxButton({ disabled: true });
                                deleteButton.jqxButton({ disabled: true });
                                editButton.jqxButton({ disabled: true });
                                cancelButton.jqxButton({ disabled: false });
                                updateButton.jqxButton({ disabled: false });
                                break;
                            case "End Edit":
                                addButton.jqxButton({ disabled: false });
                                deleteButton.jqxButton({ disabled: false });
                                editButton.jqxButton({ disabled: false });
                                cancelButton.jqxButton({ disabled: true });
                                updateButton.jqxButton({ disabled: true });
                                break;
                        }
                    };
                    var rowIndex = null;
                    $("#tableStudyPlan").on('rowSelect', function (event) {
                        var args = event.args;
                        rowIndex = args.index;
                        updateButtons('Select');
                    });
                    $("#tableStudyPlan").on('rowUnselect', function (event) {
                        updateButtons('Unselect');
                    });
                    $("#tableStudyPlan").on('rowEndEdit', function (event) {
                        updateButtons('End Edit');
                    });
                    $("#tableStudyPlan").on('rowBeginEdit', function (event) {
                        updateButtons('Edit');
                    });
                    addButton.click(function (event) {
                        if (!addButton.jqxButton('disabled')) {
                            // add new empty row.
                            $("#tableStudyPlan").jqxDataTable('addRow', null, {}, 'first');
                            // select the first row and clear the selection.
                            $("#tableStudyPlan").jqxDataTable('clearSelection');
                            $("#tableStudyPlan").jqxDataTable('selectRow', 0);
                            // edit the new row.
                            //$("#tableStudyPlan").jqxDataTable('beginRowEdit', 0);
                            updateButtons('add');
                        }
                    });
                    cancelButton.click(function (event) {
                        if (!cancelButton.jqxButton('disabled')) {
                            // cancel changes.
                            $("#tableStudyPlan").jqxDataTable('endRowEdit', rowIndex, true);
                        }
                    });
                    updateButton.click(function (event) {
                        if (!updateButton.jqxButton('disabled')) {
                            // save changes.
                            $("#tableStudyPlan").jqxDataTable('endRowEdit', rowIndex, false);
                        }
                    });
                    editButton.click(function () {
                        if (!editButton.jqxButton('disabled')) {
                            $("#tableStudyPlan").jqxDataTable('beginRowEdit', rowIndex);
                            updateButtons('edit');
                        }
                    });
                    deleteButton.click(function () {
                        if (!deleteButton.jqxButton('disabled')) {
                            $("#jqxWindowWarning").jqxWindow('open');
                            $("#ok").click(function (){
                                $("#tableStudyPlan").unbind("bindingComplete");
                                $("#ok").unbind("click"); 
                                $("#jqxWindowWarning").jqxWindow('close');
                                $("#tableStudyPlan").jqxDataTable('deleteRow', rowIndex);
                            });
                            updateButtons('delete');
                        }
                    });
                },
                ready: function(){

                },
                columns: [
                    { text: 'NP',filterable: false, editable: false, dataField: 'dataProgresivNumber', width: 25 },
                    { text: 'Plan de estudio', dataField: 'dataNameStudyPlan',
                        createEditor: function (row, cellvalue, editor, cellText, width, height) {
                            // construct the editor. 
                            $(editor).keyup(function() {
                                $(this).val($(this).val().toUpperCase());
                            });
                        },
                        getEditorValue: function (row, cellvalue, editor) {
                            // return the editor's value.
                            return $(editor).val().toUpperCase();
                        }
                    }
                ]
            }); 
        }
        $('#studyPlanLevelFilter').on('change',function (event){    
            itemLevel = $('#studyPlanLevelFilter').jqxDropDownList('getSelectedItem');
            if(itemLevel!==undefined){
                createDropDownCareer(itemLevel.value, "#studyPlanCareerFilter", true);
                itemCareer = $('#studyPlanCareerFilter').jqxDropDownList('getSelectedItem');
            }else{
                createDropDownCareer(null, "#studyPlanCareerFilter", true);
            }
        });
        $('#studyPlanCareerFilter').on('change',function (event){      
            itemCareer = $('#studyPlanCareerFilter').jqxDropDownList('getSelectedItem');
            if(itemCareer.value){
                dataAdapter = new $.jqx.dataAdapter(loadSource(itemCareer.value));
                $("#tableStudyPlan").jqxDataTable({source: dataAdapter});
            }          
        });
    });
</script>
<div style="float: left; margin-right: 5px;">
    Nivel de estudio <br>
    <div id='studyPlanLevelFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Carrera <br>
    <div id='studyPlanCareerFilter'></div>
</div><br><br><br>
<div id="tableStudyPlan"></div>