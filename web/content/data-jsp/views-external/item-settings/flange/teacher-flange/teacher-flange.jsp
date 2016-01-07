<script type="text/javascript">
    $(document).ready(function () {
        var itemRol = 0;
        function loadSource(){
            var ordersSource ={
                dataFields: [
                    { name: 'id', type:'int'},
                    { name: 'dataProgresivNumber', type:'int'},
                    { name: 'dataNameWorker', type: 'string' },
                    { name: 'dataTutor', type: 'string' },
                    { name: 'dataJobFuntional', type: 'string' }
                ],
                root: "__ENTITIES",
                dataType: "json",
                id: 'id',
                async: false,
                url: '../serviceTeacher?view',
                updateRow: function (rowID, rowData, commit) {
                    // synchronize with the server - send update command
                    // call commit with parameter true if the synchronization with the server is successful 
                    // and with parameter false if the synchronization failed.
                    commit(true);
                    $.ajax({
                        //Send the paramethers to servelt
                        type: "POST",
                        async: false,
                        url: "../serviceTeacher?update",
                        data:{'pkWorker':rowID,'tutor':rowData.dataTutor,'jobFuntional':rowData.dataJobFuntional},
                        beforeSend: function (xhr) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //This is if exits an error with the server internal can do server off, or page not found
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) { 
                            //If is updated rechange the drowdown in the other flange...
                        }
                    });
                }
            };
            return ordersSource;
        };
        var dataAdapter = new $.jqx.dataAdapter(loadSource());
        $("#tableTeacher").jqxDataTable({
            width: 500,
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
                // appends buttons to the nameCareerAbreiated bar.
                var container = $("<div style='overflow: hidden; position: relative; height: 100%; width: 100%;'></div>");
                var buttonTemplate = "<div style='float: left; padding: 3px; margin: 2px;'><div style='margin: 4px; width: 16px; height: 16px;'></div></div>";
                var editButton = $(buttonTemplate);
                var cancelButton = $(buttonTemplate);
                var updateButton = $(buttonTemplate);
                container.append(editButton);
                container.append(cancelButton);
                container.append(updateButton);
                toolBar.append(container);
                
                editButton.jqxButton({ cursor: "pointer", disabled: true, enableDefault: false,  height: 25, width: 25 });
                editButton.find('div:first').addClass(toTheme('jqx-icon-edit'));
                editButton.jqxTooltip({ position: 'bottom', content: "Editar"});
                
                updateButton.jqxButton({ cursor: "pointer", disabled: true, enableDefault: false,  height: 25, width: 25 });
                updateButton.find('div:first').addClass(toTheme('jqx-icon-save'));
                updateButton.jqxTooltip({ position: 'bottom', content: "Guardar"});
                cancelButton.jqxButton({ cursor: "pointer", disabled: true, enableDefault: false,  height: 25, width: 25 });
                cancelButton.find('div:first').addClass(toTheme('jqx-icon-cancel'));
                cancelButton.jqxTooltip({ position: 'bottom', content: "Cancelar"});
                var updateButtons = function (action) {
                    switch (action) {
                        case "Select":
                            editButton.jqxButton({ disabled: false });
                            cancelButton.jqxButton({ disabled: true });
                            updateButton.jqxButton({ disabled: true });
                            break;
                        case "Unselect":
                            editButton.jqxButton({ disabled: true });
                            cancelButton.jqxButton({ disabled: true });
                            updateButton.jqxButton({ disabled: true });
                            break;
                        case "Edit":
                            editButton.jqxButton({ disabled: true });
                            cancelButton.jqxButton({ disabled: false });
                            updateButton.jqxButton({ disabled: false });
                            break;
                        case "End Edit":
                            editButton.jqxButton({ disabled: false });
                            cancelButton.jqxButton({ disabled: true });
                            updateButton.jqxButton({ disabled: true });
                            break;
                    }
                };
                var rowIndex = null;
                $("#tableTeacher").on('rowSelect', function (event) {
                    var args = event.args;
                    rowIndex = args.index;
                    updateButtons('Select');
                });
                $("#tableTeacher").on('rowUnselect', function (event) {
                    updateButtons('Unselect');
                });
                $("#tableTeacher").on('rowEndEdit', function (event) {
                    updateButtons('End Edit');
                });
                $("#tableTeacher").on('rowBeginEdit', function (event) {
                    updateButtons('Edit');
                });
                cancelButton.click(function (event) {
                    if (!cancelButton.jqxButton('disabled')) {
                        // cancel changes.
                        $("#tableTeacher").jqxDataTable('endRowEdit', rowIndex, true);
                    }
                });
                updateButton.click(function (event) {
                    if (!updateButton.jqxButton('disabled')) {
                        // save changes.
                        $("#tableTeacher").jqxDataTable('endRowEdit', rowIndex, false);
                    }
                });
                editButton.click(function () {
                    if (!editButton.jqxButton('disabled')) {
                        $("#tableTeacher").jqxDataTable('beginRowEdit', rowIndex);
                        updateButtons('edit');
                    }
                });
            },
            columns: [
                { text: 'NP', editable: false, filterable:false, dataField: 'dataProgresivNumber', width: 30},
                { text: 'Maestro',editable: false, dataField: 'dataNameWorker', width: 240},
                { text: 'Tutor',columntype: 'custom', align:'center', cellsAlign:'center', dataField: 'dataTutor', width: 80,
                    createEditor: function (row, cellvalue, editor, cellText, width, height) {
                        // construct the editor. 
                        if(cellvalue==="No"){
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
                            value = "No";
                        }else{
                            value = "Si";
                        }
                        return value;
                     }
                },
                { text: 'Puesto Funcional',  dataField: 'dataJobFuntional'}
            ]
        });
    });
</script>
<div id="tableTeacher"></div>