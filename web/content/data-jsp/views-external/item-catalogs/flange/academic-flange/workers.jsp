<script type="text/javascript">
    $(document).ready(function () {
        var itemRol = 0;
        function loadSource(fkRol){
            var ordersSource ={
                dataFields: [
                    { name: 'id', type:'int'},
                    { name: 'dataProgresivNumber', type:'int'},
                    { name: 'dataNameWorker', type: 'string' },
                    { name: 'dataMaternName', type: 'string' },
                    { name: 'dataPaternName', type: 'string' },
                    { name: 'dataKeySp', type: 'string' },
                    { name: 'dataTelphoneNumber', type: 'string' },
                    { name: 'dataAddres', type: 'string' },
                    { name: 'dataPhoto', type: 'string' },
                    { name: 'dataUserName', type: 'string' }
                ],
                root: "__ENTITIES",
                dataType: "json",
                async: false,
                id: 'id',
                url: '../serviceWorker?view&&fkRol='+fkRol+'',
                addRow: function (rowID, rowData, position, commit) {
                    // synchronize with the server - send insert command
                    // call commit with parameter true if the synchronization with the server is successful 
                    // and with parameter false if the synchronization failed.
                    // you can pass additional argument to the commit callback which represents the new ID if it is generated from a DB.
                    itemRol = $('#workersRolFilter').jqxDropDownList('getSelectedItem');
                    itemRol = itemRol.value;
                    $.ajax({
                        //Send the paramethers to servelt
                        type: "POST",
                        async: false,
                        url: "../serviceWorker?insert",
                        data:{'fkRol':itemRol,'nameWorker':"",'maternName':"",'paternName':"",'keySp':"",'telphoneNumber':"",'addres':"",'photo':""},
                        beforeSend: function (xhr) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //This is if exits an error with the server internal can do server off, or page not found
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) {
                            commit(true);
                            $("#tableWorkers").jqxDataTable('updateBoundData');
                            $("#tableWorkers").jqxDataTable('goToPage', 0);
                            $("#tableWorkers").jqxDataTable('beginRowEdit', 0);
                        }
                    });
                },
                updateRow: function (rowID, rowData, commit) {
                    // synchronize with the server - send update command
                    // call commit with parameter true if the synchronization with the server is successful 
                    // and with parameter false if the synchronization failed.
                    itemRol = $('#workersRolFilter').jqxDropDownList('getSelectedItem');
                    itemRol = itemRol.value;
                    var nameWorker = rowData.dataNameWorker;
                    var maternName = rowData.dataMaternName;
                    var paternName = rowData.dataPaternName;
                    var keySp = rowData.dataKeySp;
                    var telephoneNumber = rowData.dataTelphoneNumber;
                    var addres = rowData.dataAddres;
                    var photo = rowData.dataPhoto;
                    $.ajax({
                        //Send the paramethers to servelt
                        type: "POST",
                        async: false,
                        url: "../serviceWorker?update",
                        data:{'pkWorker':rowID,'fkRol':itemRol,'nameWorker':nameWorker,'maternName':maternName,'paternName':paternName,'keySp':keySp,'telephoneNumber':telephoneNumber,'addres':addres,'photo':photo},
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
                        url: "../serviceWorker?delete",
                        data:{'pkWorker':rowID},
                        beforeSend: function (xhr) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //This is if exits an error with the server internal can do server off, or page not found
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) {
                            commit(true);
                            $("#tableWorkers").jqxDataTable('updateBoundData');
                        }
                    });
                }
            };
            return ordersSource;
        };
        createDropDownRol("#workersRolFilter");
        itemRol = $('#workersRolFilter').jqxDropDownList('getSelectedItem');
        itemRol = itemRol.value;
        var dataAdapter = new $.jqx.dataAdapter(loadSource(itemRol));
        $("#tableWorkers").jqxDataTable({
            width: 920,
            height : 350,
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
                $("#tableWorkers").on('rowSelect', function (event) {
                    var args = event.args;
                    rowIndex = args.index;
                    updateButtons('Select');
                });
                $("#tableWorkers").on('rowUnselect', function (event) {
                    updateButtons('Unselect');
                });
                $("#tableWorkers").on('rowEndEdit', function (event) {
                    updateButtons('End Edit');
                });
                $("#tableWorkers").on('rowBeginEdit', function (event) {
                    updateButtons('Edit');
                });
                addButton.click(function (event) {
                    if (!addButton.jqxButton('disabled')) {
                        // add new empty row.
                        $("#tableWorkers").jqxDataTable('addRow', null, {}, 'first');
                        // select the first row and clear the selection.
                        $("#tableWorkers").jqxDataTable('clearSelection');
                        $("#tableWorkers").jqxDataTable('selectRow', 0);
                        // edit the new row.
                        //$("#tableWorkers").jqxDataTable('beginRowEdit', 0);
                        updateButtons('add');
                    }
                });
                cancelButton.click(function (event) {
                    if (!cancelButton.jqxButton('disabled')) {
                        // cancel changes.
                        $("#tableWorkers").jqxDataTable('endRowEdit', rowIndex, true);
                    }
                });
                updateButton.click(function (event) {
                    if (!updateButton.jqxButton('disabled')) {
                        // save changes.
                        $("#tableWorkers").jqxDataTable('endRowEdit', rowIndex, false);
                    }
                });
                editButton.click(function () {
                    if (!editButton.jqxButton('disabled')) {
                        $("#tableWorkers").jqxDataTable('beginRowEdit', rowIndex);
                        updateButtons('edit');
                    }
                });
                deleteButton.click(function () {
                    if (!deleteButton.jqxButton('disabled')) {
                        $("#jqxWindowWarning").jqxWindow('open');
                        $("#ok").click(function (){
                            $("#tableWorkers").unbind("bindingComplete");
                            $("#ok").unbind("click"); 
                            $("#jqxWindowWarning").jqxWindow('close');
                            $("#tableWorkers").jqxDataTable('deleteRow', rowIndex);
                        });
                        updateButtons('delete');
                    }
                });
            },
            ready: function(){
                
            },
            columns: [
                { text: 'NP',filterable: false, editable: false, dataField: 'dataProgresivNumber', width: 35 },
                /*{ text: 'Fotografia',columntype: 'custom', dataField: 'dataPhoto', width: 200,
                    createEditor: function (row, cellvalue, editor, cellText, width, height) {
                        // construct the editor. 
                        editor.jqxFileUpload({
                            autoUpload: false, 
                            width: 150, 
                            accept: 'image/*',
                            uploadUrl: 'imageUpload.php', 
                            fileInputName: 'fileToUpload',
                            browseTemplate: 'success',
                            renderFiles: function (fileName) {
                                var stopIndex = fileName.indexOf('.');
                                var name = fileName.slice(0, stopIndex);
                                var extension = fileName.slice(stopIndex);
                                return name + '<strong>' + extension + '</strong>';
                            },
                            localization: { 
                                browseButton: 'Buscar', 
                                uploadButton: 'Subir',
                                cancelButton: 'Cancelar', 
                                uploadFileTooltip: 'Subir', 
                                cancelFileTooltip: 'Cancelar' 
                            }
                        });
                    },
                    initEditor: function (row, cellvalue, editor, celltext, width, height) {
                        // set the editor's current value. The callback is called each time the editor is displayed.
                    },
                    getEditorValue: function (row, cellvalue, editor) {
                        // return the editor's value.
                        return 1;
                    }
                },*/
                { text: 'Nombre', dataField: 'dataNameWorker', width: 130,
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
                },
                { text: 'Apellido Materno', dataField: 'dataMaternName', width: 130,
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
                },
                { text: 'Apellido Paterno', dataField: 'dataPaternName', width: 130,
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
                },
                { text: 'Clave SP', dataField: 'dataKeySp', width: 100},
                { text: 'Usuario', filterable: false, editable: false, dataField: 'dataUserName', width: 140 },
                { text: 'Telefono', columntype: 'custom', dataField: 'dataTelphoneNumber', width: 120, 
                    createEditor: function (row, cellvalue, editor, cellText, width, height) {
                        // construct the editor. 
                        editor.jqxMaskedInput({ width: 120, height: 26, mask: '(###)###-####'});
                        var valueTel = cellvalue.replace("(","");
                        valueTel = valueTel.replace(")","");
                        valueTel = valueTel.replace("-","");
                        editor.jqxMaskedInput({value: valueTel });
                    },
                    initEditor: function (row, cellvalue, editor, celltext, width, height) {
                        // set the editor's current value. The callback is called each time the editor is displayed.
                        //alert(celltext);
                        var valueTel = editor.jqxMaskedInput('value');
                        editor.jqxMaskedInput({value: valueTel });
                    },
                    getEditorValue: function (row, cellvalue, editor) {
                        // return the editor's value.
                        var valueTel = editor.jqxMaskedInput('value');
                        return valueTel;
                    }
                },
                { text: 'Dirección', dataField: 'dataAddres', width: 340,
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
        var evenRol = false;
        $('#workersRolFilter').click(function (){
            evenRol = true;
        });
        $('#workersRolFilter').on('change',function (event){           
            if(evenRol){
                evenRol = $('#workersRolFilter').jqxDropDownList('getSelectedItem');
                evenRol = evenRol.value;
                $("#tableWorkers").unbind("bindingComplete");
                dataAdapter = new $.jqx.dataAdapter(loadSource(evenRol));
                $("#tableWorkers").jqxDataTable({source: dataAdapter});
                evenRol = false;
                return false;
            }
        });
    });
</script>
<div style="float: left; margin-right: 5px;">
    Rol de usuario<br>
    <div id='workersRolFilter'></div>
</div><br><br><br>
<div id="tableWorkers"></div>