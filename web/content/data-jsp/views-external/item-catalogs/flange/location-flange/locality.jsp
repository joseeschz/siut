<script type="text/javascript">
    $(document).ready(function () {
        $("input").jqxInput({theme:theme,height: '26px' });
        // array which keeps the indexes of the edited rows.
        function loadSource (itemMunicipality) {
            var source = {   
                url:"../getLocality?view&&filtrable="+itemMunicipality+"&&action=byPk",
                datatype: "json",
                root: "__ENTITIES",
                async: false,
                id: 'id',
                datafields:
                [
                    { name: 'id', type:'int'},
                    { name: 'dataProgresivNumber', type:'int'},
                    { name: 'dataNameLocality', type: 'string' },  
                    { name: 'dataFkEntity', type: 'string' },  
                    { name: 'dataFkMunicipality', type: 'string' },  
                    { name: 'dataNameMunicipality', type: 'string' } 

                ],
                addRow: function (rowID, rowData, position, commit) {
                    // synchronize with the server - send insert command
                    // call commit with parameter true if the synchronization with the server is successful 
                    // and with parameter false if the synchronization failed.
                    // you can pass additional argument to the commit callback which represents the new ID if it is generated from a DB.
                    
                    itemMunicipality = $('#municipalityFilterLocality').jqxDropDownList('getSelectedItem');
                    var dataFkMunicipality= itemMunicipality.value;
                    $.ajax({
                        //Send the paramethers to servelt
                        type: "POST",
                        async: false,
                        url: "../getLocality?insert",
                        data:{"nameLocality":"","pkMunicipality":dataFkMunicipality},
                        beforeSend: function (xhr) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //This is if exits an error with the server internal can do server off, or page not found
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) {
                            commit(true);
                            $("#tableLocality").jqxDataTable('updateBoundData');
                            $("#tableLocality").jqxDataTable('goToPage', 0);
                            $("#tableLocality").jqxDataTable('beginRowEdit', 0); 
                        }
                    });
                },
                updateRow: function (rowID, rowData, commit) {
                    // synchronize with the server - send update command
                    // call commit with parameter true if the synchronization with the server is successful 
                    // and with parameter false if the synchronization failed.
                    
                    itemMunicipality = $('#municipalityFilterLocality').jqxDropDownList('getSelectedItem');
                    var dataNameLocality = rowData.dataNameLocality;
                    var dataFkMunicipality= itemMunicipality.value;
                    $.ajax({
                        //Send the paramethers to servelt
                        type: "POST",
                        async: false,
                        url: "../getLocality?update",
                        data:{"nameLocality":dataNameLocality,"fkMunicipality":dataFkMunicipality,"pkLocality":rowID},
                        beforeSend: function (xhr) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //This is if exits an error with the server internal can do server off, or page not found
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) {
                            commit(true);
                            itemMunicipality = $('#municipalityFilterPreparatory').jqxDropDownList('getSelectedItem');
                            if(itemMunicipality!==undefined){
                                createDropDownLocality(itemMunicipality.value, "byPk", "#localityFilterPreparatory", true);
                            }else{
                                createDropDownLocality(null, "byPk", "#localityFilterPreparatory", true);
                            }      
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
                        url: "../getLocality?delete",
                        data:{"pkLocality": rowID},
                        beforeSend: function (xhr) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //This is if exits an error with the server internal can do server off, or page not found
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) {
                            commit(true);
                            itemMunicipality = $('#municipalityFilterPreparatory').jqxDropDownList('getSelectedItem');
                            if(itemMunicipality!==undefined){
                                createDropDownLocality(itemMunicipality.value, "byPk", "#localityFilterPreparatory", true);
                            }else{
                                createDropDownLocality(null, "byPk", "#localityFilterPreparatory", true);
                            } 
                            $("#tableLocality").jqxDataTable('updateBoundData');
                        }
                    });
                }
            };
            return source;
        }
        var dataAdapter = undefined;
        
        createDropDownEntity('#entityFilterLocality','null',false);
        createDropDownMunicipality(null, 'byPk', "#municipalityFilterLocality", false);
        dataAdapter = new $.jqx.dataAdapter(loadSource(null));
        // initialize jqxDataTable
        // appends buttons to the status bar.
        var containerLocality = $("<div style='overflow: hidden; position: relative; float:left; height: 100%; width: 40%;'></div>");
        var buttonTemplateLocality = "<div style='float: left; padding: 3px; margin: 2px;'><div style='margin: 4px; width: 16px; height: 16px;'></div></div>";
        var addButtonLocality = $(buttonTemplateLocality);
        var deleteButtonLocality = $(buttonTemplateLocality);
        var cancelButtonLocality = $(buttonTemplateLocality);
        var updateButtonLocality = $(buttonTemplateLocality);
        containerLocality.append(addButtonLocality);
        containerLocality.append(deleteButtonLocality);
        containerLocality.append(cancelButtonLocality);
        containerLocality.append(updateButtonLocality);
        $("#tableLocality").jqxDataTable({
            width: 400,
            height:400,
            theme:theme,
            selectionMode: "singleRow",
            localization: getLocalization("es"),
            source: dataAdapter,
            pageable: true,
            editable:true,
            altRows: true,
            sortable: true,
            filterable: true,
            filterMode: 'advanced',
            showToolbar: true,
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
                addButton.attr("data-id", "addLocality");
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
                $("#tableLocality").on('rowSelect', function (event) {
                    var args = event.args;
                    rowIndex = args.index;
                    updateButtons('Select');
                });
                $("#tableLocality").on('rowUnselect', function (event) {
                    updateButtons('Unselect');
                });
                $("#tableLocality").on('rowEndEdit', function (event) {
                    updateButtons('End Edit');
                });
                $("#tableLocality").on('rowBeginEdit', function (event) {
                    updateButtons('Edit');
                });
                addButton.click(function (event) {
                    if (!addButton.jqxButton('disabled')) {
                        // add new empty row.
                        $("#tableLocality").jqxDataTable('addRow', null, {}, 'first');
                        // select the first row and clear the selection.
                        $("#tableLocality").jqxDataTable('clearSelection');
                        $("#tableLocality").jqxDataTable('selectRow', 0);
                        // edit the new row.
                        //$("#tableLocality").jqxDataTable('beginRowEdit', 0);
                        updateButtons('add');
                    }
                });
                cancelButton.click(function (event) {
                    if (!cancelButton.jqxButton('disabled')) {
                        // cancel changes.
                        $("#tableLocality").jqxDataTable('endRowEdit', rowIndex, true);
                    }
                });
                updateButton.click(function (event) {
                    if (!updateButton.jqxButton('disabled')) {
                        // save changes.
                        $("#tableLocality").jqxDataTable('endRowEdit', rowIndex, false);
                    }
                });
                editButton.click(function () {
                    if (!editButton.jqxButton('disabled')) {
                        $("#tableLocality").jqxDataTable('beginRowEdit', rowIndex);
                        updateButtons('edit');
                    }
                });
                deleteButton.click(function () {
                    if (!deleteButton.jqxButton('disabled')) {
                        $("#jqxWindowWarning").jqxWindow('open');
                        $("#ok").click(function (){
                            $("#tableLocality").unbind("bindingComplete");
                            $("#ok").unbind("click"); 
                            $("#jqxWindowWarning").jqxWindow('close');
                            $("#tableLocality").jqxDataTable('deleteRow', rowIndex);
                        });
                        updateButtons('delete');
                    }
                });
            },
            ready: function(){
                $("[data-id=addLocality]").jqxButton({ disabled: true });
            },
            columns:[
                { text: 'NP',groupable:false,editable:false, filterable: false, sortable:false, dataField: 'dataProgresivNumber', width:30 },
                { text: 'Localidad', datafield: 'dataNameLocality' }
            ]
        });
        $('#entityFilterLocality').on('change',function (event){  
            var args = event.args;
            if (args) { 
                var item = args.item;
                if(item.visible){
                    createDropDownMunicipality(item.value, 'byPk', "#municipalityFilterLocality", true);
                }
            }
        });
        
        $('#municipalityFilterLocality').on('change', function (event){
            var args = event.args;
            if (args) {
                var item = args.item;
                if(item.visible){
                    dataAdapter = new $.jqx.dataAdapter(loadSource(item.value));
                    $("#tableLocality").jqxDataTable({source: dataAdapter});
                    if(item.value!=="0"){
                        $("[data-id=addLocality]").jqxButton({ disabled: false });
                    }else{
                        $("[data-id=addLocality]").jqxButton({ disabled: true });
                    }
                }
            }           
        });   
        
    });
</script>
<div style="float: left; margin-right: 5px;">
    Estado <br>
    <div id='entityFilterLocality'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Municipio<br>
    <div id='municipalityFilterLocality'></div>
</div>
<br><br><br>
<div id="tableLocality" style="float: left;"></div>