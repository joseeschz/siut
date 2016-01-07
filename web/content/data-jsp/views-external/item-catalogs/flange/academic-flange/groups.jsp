<script type="text/javascript">
    $(document).ready(function () {
        var itemLevel = 0;
        var itemSemester = 0;
        function loadSource(fkSemester){
            var ordersSource ={
                dataFields: [
                    { name: 'id', type:'int'},
                    { name: 'dataProgresivNumber', type:'int'},
                    { name: 'dataNameGroup', type: 'string' }
                ],
                root: "__ENTITIES",
                dataType: "json",
                async: false,
                id: 'id',
                url: '../serviceGroup?view&&fkSemester='+fkSemester,
                addRow: function (rowID, rowData, position, commit) {
                    // synchronize with the server - send insert command
                    // call commit with parameter true if the synchronization with the server is successful 
                    // and with parameter false if the synchronization failed.
                    // you can pass additional argument to the commit callback which represents the new ID if it is generated from a DB.
                    commit(true);
                    itemSemester = $('#groupsSemesterFilter').jqxDropDownList('getSelectedItem');
                    $.ajax({
                        //Send the paramethers to servelt
                        type: "POST",
                        async: false,
                        url: "../serviceGroup?insert",
                        data:{'fkSemester': itemSemester.value},
                        beforeSend: function (xhr) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //This is if exits an error with the server internal can do server off, or page not found
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) {
                            $("#tableGoup").jqxDataTable('updateBoundData');
                            $("#tableGoup").jqxDataTable('goToPage', 0);
                            $("#tableGoup").jqxDataTable('beginRowEdit', 0);
                        }
                    });
                },
                updateRow: function (rowID, rowData, commit) {
                    // synchronize with the server - send update command
                    // call commit with parameter true if the synchronization with the server is successful 
                    // and with parameter false if the synchronization failed.
                    itemSemester = $('#groupsSemesterFilter').jqxDropDownList('getSelectedItem');
                    $.ajax({
                        //Send the paramethers to servelt
                        type: "POST",
                        async: false,
                        url: "../serviceGroup?update",
                        data:{'pkGroup':rowID, 'nameGroup':rowData.dataNameGroup,'fkSemester':itemSemester.value},
                        beforeSend: function (xhr) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //This is if exits an error with the server internal can do server off, or page not found
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) { 
                            //If is updated rechange the drowdown in the other flange...
                            commit(true);
                        }
                    });
                },
                deleteRow: function (rowID, commit) {
                    // synchronize with the server - send delete command
                    // call commit with parameter true if the synchronization with the server is successful 
                    // and with parameter false if the synchronization failed.
                    $.ajax({
                        //Send the paramethers to servelt
                        type: "POST",
                        async: false,
                        url: "../serviceGroup?delete",
                        data:{'pkGroup':rowID},
                        beforeSend: function (xhr) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //This is if exits an error with the server internal can do server off, or page not found
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) {
                            commit(true);
                            $("#tableGoup").jqxDataTable('updateBoundData');
                        }
                    });
                }
            };
            return ordersSource;
        };
        var dataAdapter;
        createDropDownStudyLevel("#groupLevelFilter", false);
        itemLevel = $('#groupLevelFilter').jqxDropDownList('getSelectedItem');
        if(itemLevel!==undefined){
            createDropDownSemester(itemLevel.value, "#groupsSemesterFilter", false);
            itemSemester = $('#groupsSemesterFilter').jqxDropDownList('getSelectedItem');
            loadTable(itemSemester.value);
        }else{
            createDropDownSemester(null, "#groupsSemesterFilter", false);
        }
        function loadTable(pkSemester){
            dataAdapter = new $.jqx.dataAdapter(loadSource(pkSemester));
            $("#tableGoup").jqxDataTable({
                width: 250,
                height : 350,
                selectionMode: "singleRow",
                localization: getLocalization("es"),
                source: dataAdapter,
                pageable: true,
                editable: true,
                filterable: true,
                showToolbar: true,
                altRows: true,
                pagerButtonsCount: 2,
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
                    $("#tableGoup").on('rowSelect', function (event) {
                        var args = event.args;
                        rowIndex = args.index;
                        updateButtons('Select');
                    });
                    $("#tableGoup").on('rowUnselect', function (event) {
                        updateButtons('Unselect');
                    });
                    $("#tableGoup").on('rowEndEdit', function (event) {
                        updateButtons('End Edit');
                    });
                    $("#tableGoup").on('rowBeginEdit', function (event) {
                        updateButtons('Edit');
                    });
                    addButton.click(function (event) {
                        if (!addButton.jqxButton('disabled')) {
                            // add new empty row.
                            $("#tableGoup").jqxDataTable('addRow', null, {}, 'first');
                            // select the first row and clear the selection.
                            $("#tableGoup").jqxDataTable('clearSelection');
                            $("#tableGoup").jqxDataTable('selectRow', 0);
                            // edit the new row.
                            //$("#tableGoup").jqxDataTable('beginRowEdit', 0);
                            updateButtons('add');
                        }
                    });
                    cancelButton.click(function (event) {
                        if (!cancelButton.jqxButton('disabled')) {
                            // cancel changes.
                            $("#tableGoup").jqxDataTable('endRowEdit', rowIndex, true);
                        }
                    });
                    updateButton.click(function (event) {
                        if (!updateButton.jqxButton('disabled')) {
                            // save changes.
                            $("#tableGoup").jqxDataTable('endRowEdit', rowIndex, false);
                        }
                    });
                    editButton.click(function () {
                        if (!editButton.jqxButton('disabled')) {
                            $("#tableGoup").jqxDataTable('beginRowEdit', rowIndex);
                            updateButtons('edit');
                        }
                    });
                    deleteButton.click(function () {
                        if (!deleteButton.jqxButton('disabled')) {
                            $("#jqxWindowWarning").jqxWindow('open');
                            $("#ok").click(function (){
                                $("#tableGoup").unbind("bindingComplete");
                                $("#ok").unbind("click"); 
                                $("#jqxWindowWarning").jqxWindow('close');
                                $("#tableGoup").jqxDataTable('deleteRow', rowIndex);
                            });
                            updateButtons('delete');
                        }
                    });
                },
                ready: function(){

                },
                columns: [
                    { text: 'NP',filterable: false, editable: false, dataField: 'dataProgresivNumber', width: 35 },
                    { text: 'Grupo', dataField: 'dataNameGroup'}
                ]
            }); 
        }
        $('#groupLevelFilter').on('change',function (event){   
            itemLevel = $('#groupLevelFilter').jqxDropDownList('getSelectedItem');
            if(itemLevel!==undefined){
                createDropDownSemester(itemLevel.value, "#groupsSemesterFilter", true);
                itemSemester = $('#groupsSemesterFilter').jqxDropDownList('getSelectedItem');
            }
        });
        $("#groupsSemesterFilter").on('change',function (){
            itemSemester = $('#groupsSemesterFilter').jqxDropDownList('getSelectedItem');
            if(itemSemester!==undefined){
                dataAdapter = new $.jqx.dataAdapter(loadSource(itemSemester.value));
                $("#tableGoup").jqxDataTable({source: dataAdapter});
            }
        });
    });
</script>
<div style="float: left; margin-right: 5px;">
    Nivel de estudio <br>
    <div id='groupLevelFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Cuatrimestre<br>
    <div id='groupsSemesterFilter'></div>
</div><br><br><br>
<div id="tableGoup"></div>