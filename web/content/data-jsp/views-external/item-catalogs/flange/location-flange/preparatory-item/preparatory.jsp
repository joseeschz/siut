<script type="text/javascript">
    $(document).ready(function () {
        $("input").jqxInput({theme:theme,height: '26px' });
        // array which keeps the indexes of the edited rows.
        var itemEntity = 1;
        var itemMunicipality = 1;
        var itemLocality = 1;
        function loadSource (itemLocality){
            var sourcePreparatory = {   
                url:"../getPreparatory?view&&filtrable="+itemLocality+"",
                datatype: "json",
                root: "__ENTITIES",
                async: false,
                id: 'id',
                datafields:
                [
                    { name: 'id', type:'int'},
                    { name: 'dataProgresivNumber', type:'int'},
                    { name: 'dataFkEntity', type: 'int' },  
                    { name: 'dataFkMunicipality', type: 'int' },  
                    { name: 'dataFkLocality', type: 'int' },  
                    { name: 'dataAltitude', type: 'string' },  
                    { name: 'dataAltitudeMsnm', type: 'string' },
                    { name: 'dataAndStreet', type: 'string' },
                    { name: 'dataBetweenStreet', type: 'string' },
                    { name: 'dataCct', type: 'string' },
                    { name: 'dataControl', type: 'string' },
                    { name: 'dataDomicile', type: 'string' },
                    { name: 'dataLatitude', type: 'string' },
                    { name: 'dataLatitudeGms', type: 'string' },
                    { name: 'dataLongitude', type: 'string' },
                    { name: 'dataLongitudeGms', type: 'string' },
                    { name: 'dataNameEntity', type: 'string' },
                    { name: 'dataNameLocality', type: 'string' },
                    { name: 'dataNameMunicipality', type: 'string' },
                    { name: 'dataNamePreparatory', type: 'string' }               
                ],
                addRow: function (rowID, rowData, position, commit) {
                    // synchronize with the server - send insert command
                    // call commit with parameter true if the synchronization with the server is successful 
                    // and with parameter false if the synchronization failed.
                    // you can pass additional argument to the commit callback which represents the new ID if it is generated from a DB.
                    
                    itemLocality = $('#localityFilterPreparatory').jqxDropDownList('getSelectedItem');
                    if(itemLocality!==undefined){
                        var fk_locality = itemLocality.value; 
                        $.ajax({
                            //Send the paramethers to servelt
                            type: "POST",
                            async: false,
                            url: "../getPreparatory?insert",
                            data:{"fk_locality":fk_locality, "andStreet":"","betweenStreet":"","cct":"","control":"","domicile":"","namePreparatory":""},
                            beforeSend: function (xhr) {
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                //This is if exits an error with the server internal can do server off, or page not found
                                alert("Error interno del servidor");
                            },
                            success: function (data, textStatus, jqXHR) {
                                commit(true);
                                $("#tablePreparatory").jqxDataTable('updateBoundData');
                                $("#tablePreparatory").jqxDataTable('goToPage', 0);
                                $("#tablePreparatory").jqxDataTable('beginRowEdit', 0);
                            }
                        });
                    }
                },
                updateRow: function (rowID, rowData, commit) {
                    // synchronize with the server - send update command
                    // call commit with parameter true if the synchronization with the server is successful 
                    // and with parameter false if the synchronization failed.
                    itemLocality = $('#localityFilterPreparatory').jqxDropDownList('getSelectedItem');
                    var fk_locality = itemLocality.value; 
                    var andStreet = rowData.dataAndStreet;
                    var betweenStreet = rowData.dataBetweenStreet;
                    var cct = rowData.dataCct;
                    var control = rowData.dataControl;
                    var domicile = rowData.dataDomicile;
                    var namePreparatory = rowData.dataNamePreparatory;
                    $.ajax({
                        //Send the paramethers to servelt
                        type: "POST",
                        async: false,
                        url: "../getPreparatory?update",
                        data:{"pk_preparatory":rowID,"fk_locality":fk_locality, "andStreet":andStreet,"betweenStreet":betweenStreet,"cct":cct,"control":control,"domicile":domicile,"namePreparatory":namePreparatory},
                        beforeSend: function (xhr) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //This is if exits an error with the server internal can do server off, or page not found
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) {
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
                        url: "../getPreparatory?delete",
                        data:{"pkPreparatory": rowID},
                        beforeSend: function (xhr) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //This is if exits an error with the server internal can do server off, or page not found
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) {
                            commit(true);
                            $("#tablePreparatory").jqxDataTable('updateBoundData');
                        }
                    });
                }
            };
            return sourcePreparatory;
        }
        // initialize jqxDataTable
        var rowIndex = null;
        var dataAdapter = null;
        createDropDownEntity('#entityFilterPreparatory','null', false);
        createDropDownMunicipality(null, 'byPk', "#municipalityFilterPreparatory", false);
        createDropDownLocality(null, 'byPk', "#localityFilterPreparatory", false);
        dataAdapter = new $.jqx.dataAdapter(loadSource(null));
        
        $("#tablePreparatory").jqxDataTable({
            width: 1000,
            height:400,
            theme:theme,
            selectionMode: "singleRow",
            localization: getLocalization("es"),
            source: dataAdapter,
            pageable: true,
            altRows: true,
            sortable: true,
            editable:true,
            filterable: true,
            filterMode: 'advanced',
            showToolbar: true,
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
                addButton.attr("data-id", "addPreparatory");
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
                $("#tablePreparatory").on('rowSelect', function (event) {
                    var args = event.args;
                    rowIndex = args.index;
                    updateButtons('Select');
                });
                $("#tablePreparatory").on('rowUnselect', function (event) {
                    alert();
                    updateButtons('Unselect');
                });
                $("#tablePreparatory").on('rowEndEdit', function (event) {
                    updateButtons('End Edit');
                });
                $("#tablePreparatory").on('rowBeginEdit', function (event) {
                    updateButtons('Edit');
                });
                addButton.click(function (event) {
                    if (!addButton.jqxButton('disabled')) {
                        // add new empty row.
                        $("#tablePreparatory").jqxDataTable('addRow', null, {}, 'first');
                        // select the first row and clear the selection.
                        $("#tablePreparatory").jqxDataTable('clearSelection');
                        $("#tablePreparatory").jqxDataTable('selectRow', 0);
                        // edit the new row.
                        //$("#tablePreparatory").jqxDataTable('beginRowEdit', 0);
                        updateButtons('add');
                    }
                });
                cancelButton.click(function (event) {
                    if (!cancelButton.jqxButton('disabled')) {
                        // cancel changes.
                        $("#tablePreparatory").jqxDataTable('endRowEdit', rowIndex, true);
                    }
                });
                updateButton.click(function (event) {
                    if (!updateButton.jqxButton('disabled')) {
                        // save changes.
                        $("#tablePreparatory").jqxDataTable('endRowEdit', rowIndex, false);
                    }
                });
                editButton.click(function () {
                    if (!editButton.jqxButton('disabled')) {
                        $("#tablePreparatory").jqxDataTable('beginRowEdit', rowIndex);
                        updateButtons('edit');
                    }
                });
                deleteButton.click(function () {
                    if (!deleteButton.jqxButton('disabled')) {
                        $("#jqxWindowWarning").jqxWindow('open');
                        $("#ok").click(function (){
                            $("#tablePreparatory").unbind("bindingComplete");
                            $("#ok").unbind("click"); 
                            $("#jqxWindowWarning").jqxWindow('close');
                            $("#tablePreparatory").jqxDataTable('deleteRow', rowIndex);
                        });
                        updateButtons('delete');
                    }
                });
            },
            ready: function(){
                $("[data-id=addPreparatory]").jqxButton({ disabled: true });
            },
            columns: [
                { text: 'NP',groupable:false, filterable: false,editable:false, sortable:false, dataField: 'dataProgresivNumber', width: 30 },
                { text: 'Preparatoria', dataField: 'dataNamePreparatory', width: 350 },
                { text: 'CCT', dataField: 'dataCct', width: 100 },
                { text: 'Control', dataField: 'dataControl', width: 80 },
                { text: 'Domicilio',filterable: false, dataField: 'dataDomicile', width: 150 },
                { text: 'Entre Calle',filterable: false, dataField: 'dataBetweenStreet', width: 150 },
                { text: 'Y calle',filterable: false, dataField: 'dataAndStreet'}
            ]
        });
        $('#entityFilterPreparatory').on('change', function (event){
            var args = event.args;
            if (args) {
                var item = args.item;
                if(item.visible){
                    createDropDownMunicipality(item.value, 'byPk', "#municipalityFilterPreparatory", true);  
                }                
            }
        });  
        
        $('#municipalityFilterPreparatory').on('change', function (event){   
            var args = event.args;
            if (args) {
                var item = args.item;
                if(item.visible){
                    createDropDownLocality(item.value, 'byPk', "#localityFilterPreparatory", true);
                }                
            }
        });  
        $('#localityFilterPreparatory').on('change', function (event){
            var args = event.args;
            if (args) {
                var item = args.item;
                if(item.visible){
                    dataAdapter = new $.jqx.dataAdapter(loadSource(item.value));
                    $("#tablePreparatory").jqxDataTable({source: dataAdapter});
                    if(item.value!=="0"){
                        $("[data-id=addPreparatory]").jqxButton({ disabled: false });
                    }else{
                        $("[data-id=addPreparatory]").jqxButton({ disabled: true });
                    }
                }                
            }
        });
    });
</script>
<div style="float: left; margin-right: 5px;">
    Estado <br>
    <div id='entityFilterPreparatory'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Municipio<br>
    <div id='municipalityFilterPreparatory'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Localidad<br>
    <div id='localityFilterPreparatory'></div>
</div>
<br><br><br>
<div id="tablePreparatory" style="float: left;"></div>
