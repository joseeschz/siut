<script type="text/javascript">
    $(document).ready(function () {
        $("input").jqxInput({theme:theme, height: '26px' });
        // array which keeps the indexes of the edited rows.
        function loadSource(itemEntity){
            var source;
            source = {   
                url: "../getMunicipality?view&&filtrable="+itemEntity+"&&action=byPk",
                datatype: "json",
                root: "__ENTITIES",
                async: false,
                id: 'id',
                datafields:
                [
                    { name: 'id', type:'int'},
                    { name: 'dataProgresivNumber', type:'int'},
                    { name: 'dataNameMunicipality', type: 'string' },  
                    { name: 'dataFkEntity', type: 'string' },  
                    { name: 'dataNameEntityMunicipality', type: 'string' } 
                ],
                addRow: function (rowID, rowData, position, commit) {
                    // synchronize with the server - send insert command
                    // call commit with parameter true if the synchronization with the server is successful 
                    // and with parameter false if the synchronization failed.
                    // you can pass additional argument to the commit callback which represents the new ID if it is generated from a DB.
                    
                    itemEntity = $('#entityFilterMunicipality').jqxDropDownList('getSelectedItem');
                    if(itemEntity!==undefined){
                        var dataFkEntity = itemEntity.value;
                        $.ajax({
                            //Send the paramethers to servelt
                            type: "POST",
                            async: false,
                            url: "../getMunicipality?insert",
                            data:{"nameMunisipality":"","pkEntity":dataFkEntity},
                            beforeSend: function (xhr) {
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                alert("Error interno del servidor");
                            },
                            success: function (data, textStatus, jqXHR) {
                                commit(true);
                                $("#tableMunicipality").jqxDataTable('updateBoundData');
                                $("#tableMunicipality").jqxDataTable('goToPage', 0);
                                $("#tableMunicipality").jqxDataTable('beginRowEdit', 0);
                            }
                        }); 
                    }
                },
                updateRow: function (rowID, rowData, commit) {
                    // synchronize with the server - send update command
                    // call commit with parameter true if the synchronization with the server is successful 
                    // and with parameter false if the synchronization failed.
                    itemEntity = $('#entityFilterMunicipality').jqxDropDownList('getSelectedItem');
                    if(itemEntity!==undefined){
                        var dataNameMunicipality = rowData.dataNameMunicipality;
                        var dataFkEntity = itemEntity.value;
                        $.ajax({
                            //Send the paramethers to servelt
                            type: "POST",
                            async: false,
                            url: "../getMunicipality?update",
                            data:{"nameMunisipality":dataNameMunicipality,"fkEntity":dataFkEntity,"pkMunicipality":rowID},
                            beforeSend: function (xhr) {
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                //This is if exits an error with the server internal can do server off, or page not found
                                alert("Error interno del servidor");
                            },
                            success: function (data, textStatus, jqXHR) {
                                commit(true);
                                itemEntity = $('#entityFilterLocality').jqxDropDownList('getSelectedItem');
                                if(itemEntity!==undefined){
                                    createDropDownMunicipality(itemEntity.value,'byPk', "#municipalityFilterLocality", true);
                                    itemEntity = $('#entityFilterPreparatory').jqxDropDownList('getSelectedItem');
                                    if(itemEntity!==undefined){
                                        createDropDownMunicipality(itemEntity.value,'byPk', "#municipalityFilterPreparatory", true);
                                    }else{
                                        createDropDownMunicipality(null,'byPk', "#municipalityFilterPreparatory", true);
                                    }                                    
                                }else{
                                    createDropDownMunicipality(null,'byPk', "#municipalityFilterLocality", true);
                                }                                
                            }
                        });
                    }
                },
                deleteRow: function (rowID, commit) {
                    // synchronize with the server - send delete command
                    // call commit with parameter true if the synchronization with the server is successful 
                    // and with parameter false if the synchronization failed.
                    $.ajax({
                        //Send the paramethers to servelt
                        type: "POST",
                        async: false,
                        url: "../getMunicipality?delete",
                        data:{"pkMunicipality": rowID},
                        beforeSend: function (xhr) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //This is if exits an error with the server internal can do server off, or page not found
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) {
                            commit(true);
                            itemEntity = $('#entityFilterLocality').jqxDropDownList('getSelectedItem');
                            if(itemEntity!==undefined){
                                createDropDownMunicipality(itemEntity.value,'byPk', "#municipalityFilterLocality", true);
                                itemEntity = $('#entityFilterPreparatory').jqxDropDownList('getSelectedItem');
                                if(itemEntity!==undefined){
                                    createDropDownMunicipality(itemEntity.value,'byPk', "#municipalityFilterPreparatory", true);
                                }else{
                                    createDropDownMunicipality(null,'byPk', "#municipalityFilterPreparatory", true);
                                }                                    
                            }else{
                                createDropDownMunicipality(null,'byPk', "#municipalityFilterLocality", true);
                            }   
                            $("#tableMunicipality").jqxDataTable('updateBoundData');
                        }
                    });
                }
            };
            return source;
        };
        createDropDownEntity('#entityFilterMunicipality','null', false);
        var dataAdapter = undefined;
        dataAdapter = new $.jqx.dataAdapter(loadSource(null));        
        $("#tableMunicipality").jqxDataTable({
            width: 400,
            height:400,
            theme:theme,
            selectionMode: "singleRow",
            localization: getLocalization("es"),
            pageable: true,
            source: dataAdapter,
            altRows: true,
            sortable: true,
            editable: true,
            filterable: true,
            filterMode: 'advanced',
            showToolbar: true,
            toolbarHeight: 35,
            pagerButtonsCount: 10,
            ready: function(){
                $("[data-id=addMunicipality]").jqxButton({ disabled: true });
            },
            renderToolbar: function(toolBar){ 
                var theme = "";
                var toTheme = function (className) {
                    if (theme === "") return className;
                    return className + " " + className + "-" + theme;
                };
                // appends buttons to the status bar.
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
                addButton.attr("data-id", "addMunicipality");
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
                $("#tableMunicipality").on('rowSelect', function (event) {
                    var args = event.args;
                    rowIndex = args.index;
                    updateButtons('Select');
                });
                $("#tableMunicipality").on('rowUnselect', function (event) {
                    updateButtons('Unselect');
                });
                $("#tableMunicipality").on('rowEndEdit', function (event) {
                    updateButtons('End Edit');
                    return false;
                });
                $("#tableMunicipality").on('rowBeginEdit', function (event) {
                    updateButtons('Edit');
                    return false;
                });
                addButton.click(function (event) {
                    if (!addButton.jqxButton('disabled')) {
                        // add new empty row.
                        $("#tableMunicipality").jqxDataTable('addRow', null, {}, 'first');
                        // select the first row and clear the selection.
                        $("#tableMunicipality").jqxDataTable('clearSelection');
                        //$("#tableMunicipality").jqxDataTable('selectRow', 0);
                        // edit the new row.
                        //$("#tableMunicipality").jqxDataTable('beginRowEdit', 0);
                        updateButtons('add');
                    }
                });
                cancelButton.click(function (event) {
                    if (!cancelButton.jqxButton('disabled')) {
                        // cancel changes.
                        $("#tableMunicipality").jqxDataTable('endRowEdit', rowIndex, true);
                    }
                });
                updateButton.click(function (event) {
                    if (!updateButton.jqxButton('disabled')) {
                        // save changes.
                        $("#tableMunicipality").jqxDataTable('endRowEdit', rowIndex, false);
                    }
                });
                editButton.click(function () {
                    if (!editButton.jqxButton('disabled')) {
                        $("#tableMunicipality").jqxDataTable('beginRowEdit', rowIndex);
                        updateButtons('edit');
                    }
                });
                deleteButton.click(function () {
                    if (!deleteButton.jqxButton('disabled')) {
                        $("#jqxWindowWarning").jqxWindow('open');
                        $("#ok").click(function (event){
                            $("#tableMunicipality").unbind("bindingComplete");
                            $("#ok").unbind("click"); 
                            $("#jqxWindowWarning").jqxWindow('close');
                            $("#tableMunicipality").jqxDataTable('deleteRow', rowIndex);
                        });
                        updateButtons('delete');
                    }
                });
            },
            columns: [
                //{ text: 'id',filterable: false, editable: false, dataField: 'id', width: 10 },
                { text: 'NP',groupable:false, editable:false, filterable: false, sortable:false, dataField: 'dataProgresivNumber', width: 30 },
                { text: 'Municipio', dataField: 'dataNameMunicipality'}
            ]
        }); 
        $('#entityFilterMunicipality').on('change', function (event){
            var args = event.args;
            if (args) {
                var item = args.item;
                if(item.visible){
                    dataAdapter = new $.jqx.dataAdapter(loadSource(item.value));
                    $("#tableMunicipality").jqxDataTable({source: dataAdapter});
                    if(item.value!=="0"){
                        $("[data-id=addMunicipality]").jqxButton({ disabled: false });
                    }else{
                        $("[data-id=addMunicipality]").jqxButton({ disabled: true });
                    }
                }                
            }
        });
    });
</script>
<div>
    <div style="float: left; margin-right: 5px;">
        Estado<br>
        <div id='entityFilterMunicipality'></div>
    </div>
</div>
<br><br><br>
<div id="tableMunicipality" style="float: left;"></div>