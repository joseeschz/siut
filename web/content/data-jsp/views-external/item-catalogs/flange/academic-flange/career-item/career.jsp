<script type="text/javascript">
    $(document).ready(function () {
        var itemLevelStudy = 0;
        function loadSource(fkLevel){
            var ordersSource ={
                dataFields: [
                    { name: 'id', type:'int'},
                    { name: 'dataProgresivNumber', type:'int'},
                    { name: 'dataNameCareer', type: 'string' },
                    { name: 'dataNameCareerAbbreviated', type: 'string' },
                    { name: 'dataStatus', type: 'string' } 
                ],
                root: "__ENTITIES",
                dataType: "json",
                async: false,
                id: 'id',
                url: '../serviceCareer?view&&fkLevel='+fkLevel+'',
                addRow: function (rowID, rowData, position, commit) {
                    // synchronize with the server - send insert command
                    // call commit with parameter true if the synchronization with the server is successful 
                    // and with parameter false if the synchronization failed.
                    // you can pass additional argument to the commit callback which represents the new ID if it is generated from a DB.
                    fkLevel = $('#careerStudyLevelFilter').jqxDropDownList('getSelectedItem');
                    fkLevel = fkLevel.value;
                    $.ajax({
                        //Send the paramethers to servelt
                        type: "POST",
                        async: false,
                        url: "../serviceCareer?insert",
                        data:{'nameCareer':" ", "nameCareerAbbreviated":" ",'status':" ",'fkLevel':fkLevel},
                        beforeSend: function (xhr) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //This is if exits an error with the server internal can do server off, or page not found
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) {
                            commit(true);
                            $("#tableCareer").jqxDataTable('updateBoundData');
                            $("#tableCareer").jqxDataTable('goToPage', 0);
                            $("#tableCareer").jqxDataTable('beginRowEdit', 0);
                        }
                    });
                },
                updateRow: function (rowID, rowData, commit) {
                    // synchronize with the server - send update command
                    // call commit with parameter true if the synchronization with the server is successful 
                    // and with parameter false if the synchronization failed.
                    fkLevel = $('#careerStudyLevelFilter').jqxDropDownList('getSelectedItem');
                    fkLevel = fkLevel.value;
                    var nameCareer = rowData.dataNameCareer;
                    var nameCareerAbbreviated = rowData.dataNameCareerAbbreviated;
                    
                    var status = rowData.dataStatus;
                    
                    $.ajax({
                        //Send the paramethers to servelt
                        type: "POST",
                        async: false,
                        url: "../serviceCareer?update",
                        data:{'pkCareer':rowID,'nameCareer':nameCareer,'nameCareerAbbreviated':nameCareerAbbreviated, 'status':status, 'fkLevel':fkLevel},
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
                        url: "../serviceCareer?delete",
                        data:{'pkCareer':rowID},
                        beforeSend: function (xhr) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //This is if exits an error with the server internal can do server off, or page not found
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) {
                            commit(true);
                            $("#tableCareer").jqxDataTable('updateBoundData');
                        }
                    });
                }
            };
            return ordersSource;
        };
        var dataAdapter;
        createDropDownStudyLevel("#careerStudyLevelFilter", false);
        itemLevelStudy = $('#careerStudyLevelFilter').jqxDropDownList('getSelectedItem');        
        if(itemLevelStudy!==undefined){
            loadTable(itemLevelStudy.value);
        }
        function loadTable(pkLevelStudy){
            dataAdapter = new $.jqx.dataAdapter(loadSource(pkLevelStudy));
            $("#tableCareer").jqxDataTable({
                width: 555,
                height : 300,
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
                    // appends buttons to the nameCareerAbbreviated bar.
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
                    $("#tableCareer").on('rowSelect', function (event) {
                        var args = event.args;
                        rowIndex = args.index;
                        updateButtons('Select');
                    });
                    $("#tableCareer").on('rowUnselect', function (event) {
                        updateButtons('Unselect');
                    });
                    $("#tableCareer").on('rowEndEdit', function (event) {
                        updateButtons('End Edit');
                    });
                    $("#tableCareer").on('rowBeginEdit', function (event) {
                        updateButtons('Edit');
                    });
                    addButton.click(function (event) {
                        if (!addButton.jqxButton('disabled')) {
                            // add new empty row.
                            $("#tableCareer").jqxDataTable('addRow', null, {}, 'first');
                            // select the first row and clear the selection.
                            $("#tableCareer").jqxDataTable('clearSelection');
                            $("#tableCareer").jqxDataTable('selectRow', 0);
                            // edit the new row.
                            //$("#tableCareer").jqxDataTable('beginRowEdit', 0);
                            updateButtons('add');
                        }
                    });
                    cancelButton.click(function (event) {
                        if (!cancelButton.jqxButton('disabled')) {
                            // cancel changes.
                            $("#tableCareer").jqxDataTable('endRowEdit', rowIndex, true);
                        }
                    });
                    updateButton.click(function (event) {
                        if (!updateButton.jqxButton('disabled')) {
                            // save changes.
                            $("#tableCareer").jqxDataTable('endRowEdit', rowIndex, false);
                        }
                    });
                    editButton.click(function () {
                        if (!editButton.jqxButton('disabled')) {
                            $("#tableCareer").jqxDataTable('beginRowEdit', rowIndex);
                            updateButtons('edit');
                        }
                    });
                    deleteButton.click(function () {
                        if (!deleteButton.jqxButton('disabled')) {
                            $("#jqxWindowWarning").jqxWindow('open');
                            $("#ok").click(function (){
                                $("#tableCareer").unbind("bindingComplete");
                                $("#ok").unbind("click"); 
                                $("#jqxWindowWarning").jqxWindow('close');
                                $("#tableCareer").jqxDataTable('deleteRow', rowIndex);
                            });
                            updateButtons('delete');
                        }
                    });
                },
                ready: function(){

                },
                columns: [
                    { text: 'NP',filterable: false, editable: false, dataField: 'dataProgresivNumber', width: 25 },
                    { text: 'Carrera', dataField: 'dataNameCareer', width: 350 ,
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
                    { text: 'Abreviado', dataField: 'dataNameCareerAbbreviated', width: 100 },
                    { text: 'Estatus',  columntype: 'custom', align:'center', cellsAlign:'center', dataField: 'dataStatus',
                        createEditor: function (row, cellvalue, editor, cellText, width, height) {
                            // construct the editor. 
                            if(cellvalue==="Inactiva"){
                                //alert(cellvalue);
                                cellvalue = false;
                            }else{
                                cellvalue = true;
                            }
                            editor.jqxCheckBox({rtl:true, checked: cellvalue});
                        },
                        initEditor: function (row, cellvalue, editor, celltext, width, height) {
                            // set the editor's current value. The callback is called each time the editor is displayed.
                            //alert(celltext);
                            var value = parseInt(cellvalue);
                            if (isNaN(value)) value = 0;
                            editor.jqxSlider('setValue', value);
                        },
                        getEditorValue: function (row, cellvalue, editor) {
                            // return the editor's value.
                            var value;
                            if(!editor.val()){
                                value = "Inactiva";
                            }else{
                                value = "Activa";
                            }
                            return value;
                        }
                    }
                ]
            }); 
        }
        
        $('#careerStudyLevelFilter').on('change',function (event){        
            itemLevelStudy = $('#careerStudyLevelFilter').jqxDropDownList('getSelectedItem');
            if(itemLevelStudy!==undefined){
                dataAdapter = new $.jqx.dataAdapter(loadSource(itemLevelStudy.value));
                $("#tableCareer").jqxDataTable({source: dataAdapter});
            }
        });
    });
</script>
<div style="float: left; margin-right: 5px;">
    Nivel de estudio <br>
    <div id='careerStudyLevelFilter'></div>
</div><br><br><br>
<div id="tableCareer"></div>