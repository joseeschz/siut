<script type="text/javascript">
    $(document).ready(function () {
        createDropDownPeriod("inscription","#inscriptionFlangePeriodFilter");
        var ordersSource ={
            dataFields: [
                { name: 'id', type:'int'},
                { name: 'dataProgresivNumber', type:'int'},
                { name: 'dataNameCareer', type: 'string' },
                { name: 'dataTop', type: 'int' }
            ],
            root: "__ENTITIES",
            dataType: "json",
            async: false,
            id: 'id',
            url: '../serviceInscriptionsTop?view',
            updateRow: function (rowID, rowData, commit) {
                // synchronize with the server - send update command
                // call commit with parameter true if the synchronization with the server is successful 
                // and with parameter false if the synchronization failed.
                commit(true);
            }
        };
        var dataAdapter = new $.jqx.dataAdapter(ordersSource, {
            loadComplete: function () {
                // data is loaded.
            }
        });
        $("#jqxDataTableInscriptionTop").jqxDataTable({
            width: 300,
            height: 400,
            source: dataAdapter,
            pageable: true,
            editable: true,
            showToolbar: true,
            altRows: true,
            ready: function()
            {
                // called when the DataTable is loaded.         
            },
            pagerButtonsCount: 8,
            toolbarHeight: 35,
            renderToolbar: function(toolBar)
            {
                var toTheme = function (className) {
                    if (theme == "") return className;
                    return className + " " + className + "-" + theme;
                };
                // appends buttons to the status bar.
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
                editButton.find('div:first').addClass(('jqx-icon-edit'));
                editButton.jqxTooltip({ position: 'bottom', content: "Editar"});
                updateButton.jqxButton({ cursor: "pointer", disabled: true, enableDefault: false,  height: 25, width: 25 });
                updateButton.find('div:first').addClass(('jqx-icon-save'));
                updateButton.jqxTooltip({ position: 'bottom', content: "Guardar cambios"});
                cancelButton.jqxButton({ cursor: "pointer", disabled: true, enableDefault: false,  height: 25, width: 25 });
                cancelButton.find('div:first').addClass(('jqx-icon-cancel'));
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
                $("#jqxDataTableInscriptionTop").on('rowSelect', function (event) {
                    var args = event.args;
                    rowIndex = args.index;
                    updateButtons('Select');
                });
                $("#jqxDataTableInscriptionTop").on('rowUnselect', function (event) {
                    updateButtons('Unselect');
                });
                $("#jqxDataTableInscriptionTop").on('rowEndEdit', function (event) {
                    updateButtons('End Edit');
                });
                $("#jqxDataTableInscriptionTop").on('rowBeginEdit', function (event) {
                    updateButtons('Edit');
                });
                cancelButton.click(function (event) {
                    if (!cancelButton.jqxButton('disabled')) {
                        // cancel changes.
                        $("#jqxDataTableInscriptionTop").jqxDataTable('endRowEdit', rowIndex, true);
                    }
                });
                updateButton.click(function (event) {
                    if (!updateButton.jqxButton('disabled')) {
                        // save changes.
                        $("#jqxDataTableInscriptionTop").jqxDataTable('endRowEdit', rowIndex, false);
                    }
                });
                editButton.click(function () {
                    if (!editButton.jqxButton('disabled')) {
                        $("#jqxDataTableInscriptionTop").jqxDataTable('beginRowEdit', rowIndex);
                        updateButtons('edit');
                    }
                });
            },
            columns: [
                { text: 'Carrera', editable: false, dataField: 'dataNameCareer', width: 200 },
                {
                    text: 'Meta o Limite', dataField: 'dataTop', cellsFormat: 'f', cellsAlign: 'right', align: 'right', width: 100, columnType: 'custom',
                    createEditor: function (row, cellValue, editor, width, height) {
                        // create jqxNumberInput editor.
                        editor.jqxNumberInput({ width: 'auto', height: '25px', decimalDigits: 0, inputMode: 'simple', spinButtons: true });
                        editor.val(cellValue);
                    },
                    initEditor: function (row, cellValue, editor) {
                        // set jqxInput editor's initial value.
                        editor.find('input').val(cellValue);
                    },
                    getEditorValue: function (index, value, editor) {
                        // get jqxInput editor's value.
                        return editor.find('input').val();
                    }
                }
            ]
        });
    });
</script>
<div style="float: left; margin-right: 5px;">
    Periodo <br>
    <div id='inscriptionFlangePeriodFilter'></div>
</div><br><br><br>
<div id="jqxDataTableInscriptionTop"></div>