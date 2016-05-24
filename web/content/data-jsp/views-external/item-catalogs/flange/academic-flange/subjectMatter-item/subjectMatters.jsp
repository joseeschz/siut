<script type="text/javascript">
    $(document).ready(function () {
        var itemLevel = 0;
        var itemCareer = 0;
        var itemSemester = 0;
        var itemStudyPlan = 0;
        function loadSource(pkCareer, pkSemester, pkStudyPlan){
            var ordersSource ={
                dataFields: [
                    { name: 'id', type:'int'},
                    { name: 'dataProgresivNumber', type:'int'},
                    { name: 'dataNameSubjectMatter', type: 'string' },
                    { name: 'dataIntegradora', type: 'string' },
                    { name: 'dataCantHous', type: 'int' } 
                ],
                root: "__ENTITIES",
                dataType: "json",
                async: false,
                id: 'id',
                url: '../serviceSubjectMatter?view&&pkCareer='+pkCareer+'&&pkSemester='+pkSemester+'&&pkStudyPlan='+pkStudyPlan+'',
                addRow: function (rowID, rowData, position, commit) {
                    // synchronize with the server - send insert command
                    // call commit with parameter true if the synchronization with the server is successful 
                    // and with parameter false if the synchronization failed.
                    // you can pass additional argument to the commit callback which represents the new ID if it is generated from a DB.
                    itemSemester = $('#subjectMattersSemesterFilter').jqxDropDownList('getSelectedItem');
                    itemStudyPlan = $('#subjectMattersStudyPlanFilter').jqxDropDownList('getSelectedItem');
                    $.ajax({
                        //Send the paramethers to servelt
                        type: "POST",
                        async: false,
                        url: "../serviceSubjectMatter?insert",
                        data:{
                            'fkSemester':itemSemester.value,
                            'nameSubjectMatter':"",
                            'integradora':"0",
                            'fkStudyPlan':itemStudyPlan.value,
                            'cantHours': "0"
                        },
                        beforeSend: function (xhr) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //This is if exits an error with the server internal can do server off, or page not found
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) {
                            commit(true);
                            $("#tableSubjectMatters").jqxDataTable('updateBoundData');
                            $("#tableSubjectMatters").jqxDataTable('goToPage', 0);
                            $("#tableSubjectMatters").jqxDataTable('beginRowEdit', 0);
                        }
                    });
                },
                updateRow: function (rowID, rowData, commit) {
                    // synchronize with the server - send update command
                    // call commit with parameter true if the synchronization with the server is successful 
                    // and with parameter false if the synchronization failed.
                    itemSemester = $('#subjectMattersSemesterFilter').jqxDropDownList('getSelectedItem');
                    itemStudyPlan = $('#subjectMattersStudyPlanFilter').jqxDropDownList('getSelectedItem');
                    var nameSubjectMatter = rowData.dataNameSubjectMatter;
                    var integradora = rowData.dataIntegradora;
                    var cantHours = rowData.dataCantHous;
                    $.ajax({
                        //Send the paramethers to servelt
                        type: "POST",
                        async: false,
                        url: "../serviceSubjectMatter?update",
                        data:{
                            'pkSubjectMatter':rowID,
                            'nameSubjectMatter':nameSubjectMatter,
                            'integradora':integradora,
                            'fkSemester':itemSemester.value,
                            'fkStudyPlan':itemStudyPlan.value,
                            'cantHours':cantHours
                        },
                        beforeSend: function (xhr) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //This is if exits an error with the server internal can do server off, or page not found
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) { 
                          //integradora  //If is updated rechange the drowdown in the other flange...
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
                        url: "../serviceSubjectMatter?delete",
                        data:{'pkSubjectMatter':rowID},
                        beforeSend: function (xhr) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //This is if exits an error with the server internal can do server off, or page not found
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) {
                            commit(true);
                            $("#tableSubjectMatters").jqxDataTable('updateBoundData');
                        }
                    });
                }
            };
            return ordersSource;
        };
        var dataAdapter;
        createDropDownStudyLevel("#subjectMattersLevelFilter", false);
        itemLevel = $('#subjectMattersLevelFilter').jqxDropDownList('getSelectedItem');
        if(itemLevel!==undefined){
            createDropDownCareer(itemLevel.value, "#subjectMattersCareerFilter", false);
            createDropDownSemester(itemLevel.value,"#subjectMattersSemesterFilter", false);
            itemSemester = $('#subjectMattersSemesterFilter').jqxDropDownList('getSelectedItem');
            itemCareer = $('#subjectMattersCareerFilter').jqxDropDownList('getSelectedItem');
            if(itemCareer!==undefined){
                createDropDownStudyPlan(itemCareer.value,"#subjectMattersStudyPlanFilter",false);
                itemStudyPlan = $('#subjectMattersStudyPlanFilter').jqxDropDownList('getSelectedItem');
                if(itemStudyPlan!==undefined){
                    loadTable(itemCareer.value, itemSemester.value, itemStudyPlan.value);
                }                
            }else{
                createDropDownStudyPlan(null,"#subjectMattersStudyPlanFilter",false);
            }
        }else{
            createDropDownCareer(null, "#subjectMattersCareerFilter", false);
            createDropDownSemester(null,"#subjectMattersSemesterFilter", false);
            createDropDownStudyPlan(null,"#subjectMattersStudyPlanFilter",false);
        }
        function loadTable(pkCareer, pkSemester, pkStudyPlan){
            dataAdapter = new $.jqx.dataAdapter(loadSource(pkCareer, pkSemester, pkStudyPlan));
            $("#tableSubjectMatters").jqxDataTable({
                width: 600,
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
                    $("#tableSubjectMatters").on('rowSelect', function (event) {
                        var args = event.args;
                        rowIndex = args.index;
                        updateButtons('Select');
                    });
                    $("#tableSubjectMatters").on('rowUnselect', function (event) {
                        updateButtons('Unselect');
                    });
                    $("#tableSubjectMatters").on('rowEndEdit', function (event) {
                        updateButtons('End Edit');
                    });
                    $("#tableSubjectMatters").on('rowBeginEdit', function (event) {
                        updateButtons('Edit');
                    });
                    addButton.click(function (event) {
                        if (!addButton.jqxButton('disabled')) {
                            // add new empty row.
                            $("#tableSubjectMatters").jqxDataTable('addRow', null, {}, 'first');
                            // select the first row and clear the selection.
                            $("#tableSubjectMatters").jqxDataTable('clearSelection');
                            $("#tableSubjectMatters").jqxDataTable('selectRow', 0);
                            // edit the new row.
                            //$("#tableSubjectMatters").jqxDataTable('beginRowEdit', 0);
                            updateButtons('add');
                        }
                    });
                    cancelButton.click(function (event) {
                        if (!cancelButton.jqxButton('disabled')) {
                            // cancel changes.
                            $("#tableSubjectMatters").jqxDataTable('endRowEdit', rowIndex, true);
                        }
                    });
                    updateButton.click(function (event) {
                        if (!updateButton.jqxButton('disabled')) {
                            // save changes.
                            $("#tableSubjectMatters").jqxDataTable('endRowEdit', rowIndex, false);
                        }
                    });
                    editButton.click(function () {
                        if (!editButton.jqxButton('disabled')) {
                            $("#tableSubjectMatters").jqxDataTable('beginRowEdit', rowIndex);
                            updateButtons('edit');
                        }
                    });
                    deleteButton.click(function () {
                        if (!deleteButton.jqxButton('disabled')) {
                            $("#jqxWindowWarning").jqxWindow('open');
                            $("#ok").click(function (){
                                $("#tableSubjectMatters").unbind("bindingComplete");
                                $("#ok").unbind("click"); 
                                $("#jqxWindowWarning").jqxWindow('close');
                                $("#tableSubjectMatters").jqxDataTable('deleteRow', rowIndex);
                            });
                            updateButtons('delete');
                        }
                    });
                },
                ready: function(){

                },
                columns: [
                    { text: 'NP',filterable: false, editable: false, dataField: 'dataProgresivNumber', width: 35 },
                    { text: 'Materia', dataField: 'dataNameSubjectMatter',
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
                    { text: 'Integradora', columntype: 'custom', align:'center', cellsAlign:'center',  width: 130, dataField: 'dataIntegradora',
                        createEditor: function (row, cellvalue, editor, cellText, width, height) {
                            // construct the editor. 
                            if(cellvalue==="No"){
                                //alert(cellvalue);
                                cellvalue = false;
                            }else{
                                cellvalue = true;
                            }
                            editor.jqxCheckBox({checked: cellvalue});
                            $(".jqx-checkbox-default").parent().css({"left": "63px", "position": "relative", "top": "7px"});
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
                    { text: 'Cantidad de Horas', columntype: 'custom', align:'center', width: 150, cellsAlign:'center', dataField: 'dataCantHous',
                        createEditor: function (row, cellvalue, editor, cellText, width, height) {
                            // construct the editor. 
                            editor.jqxNumberInput({ decimalDigits: 0, inputMode: 'simple',  width: width, height: height, spinButtons: true });
                        },
                        initEditor: function (row, cellvalue, editor, celltext, width, height) {
                            // set the editor's current value. The callback is called each time the editor is displayed.
                            //alert(celltext);
                            editor.jqxNumberInput({ decimal: parseInt(cellvalue)});
                        }
                    }
                ]
            });
        }
        $('#subjectMattersLevelFilter').on('change',function (event){  
            itemLevel = $('#subjectMattersLevelFilter').jqxDropDownList('getSelectedItem');
            if(itemLevel!==undefined){
                createDropDownCareer(itemLevel.value, "#subjectMattersCareerFilter", true);
                itemCareer = $('#subjectMattersCareerFilter').jqxDropDownList('getSelectedItem');
            }else{
                createDropDownCareer(null, "#subjectMattersCareerFilter", true);
                createDropDownSemester(null,"#subjectMattersSemesterFilter", true);
                createDropDownStudyPlan(null,"#subjectMattersStudyPlanFilter",true);
            }            
        });
        
        $('#subjectMattersCareerFilter').on('change',function (event){     
            itemCareer = $('#subjectMattersCareerFilter').jqxDropDownList('getSelectedItem');
            if(itemCareer!==undefined){
                createDropDownSemester(itemLevel.value,"#subjectMattersSemesterFilter", true);
                itemSemester = $('#subjectMattersSemesterFilter').jqxDropDownList('getSelectedItem');             
            }else{
                createDropDownSemester(null,"#subjectMattersSemesterFilter", true);
            }
        });        
        $("#subjectMattersSemesterFilter").on('change',function (){
            itemCareer = $('#subjectMattersCareerFilter').jqxDropDownList('getSelectedItem');
            if(itemCareer!==undefined){
                itemSemester = $('#subjectMattersSemesterFilter').jqxDropDownList('getSelectedItem');    
                if(itemSemester!==undefined){
                    createDropDownStudyPlan(itemCareer.value,"#subjectMattersStudyPlanFilter",true);
                    itemStudyPlan = $('#subjectMattersStudyPlanFilter').jqxDropDownList('getSelectedItem');                    
                }else{
                    createDropDownStudyPlan(null,"#subjectMattersStudyPlanFilter",true);
                }
            }
        });
        $("#subjectMattersStudyPlanFilter").on('change',function (){
            itemCareer = $('#subjectMattersCareerFilter').jqxDropDownList('getSelectedItem');
            if(itemCareer!==undefined){
                itemSemester = $('#subjectMattersSemesterFilter').jqxDropDownList('getSelectedItem');
                if(itemSemester!==undefined){
                    itemStudyPlan = $('#subjectMattersStudyPlanFilter').jqxDropDownList('getSelectedItem');
                    if(itemStudyPlan!==undefined){
                        dataAdapter = new $.jqx.dataAdapter(loadSource(itemCareer.value, itemSemester.value, itemStudyPlan.value));
                        $("#tableSubjectMatters").jqxDataTable({source: dataAdapter});
                    }                    
                }                
            }            
        });
    });
</script>
<div style="float: left; margin-right: 5px;">
    Nivel de estudio <br>
    <div id='subjectMattersLevelFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Carrera <br>
    <div id='subjectMattersCareerFilter'></div>
</div>
<br><br><br>
<div style="float: left; margin-right: 5px;">
    Cuatrimestre <br>
    <div id='subjectMattersSemesterFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Plan de estudio<br>
    <div id='subjectMattersStudyPlanFilter'></div>
</div>
<br><br><br>
<div id="tableSubjectMatters"></div>