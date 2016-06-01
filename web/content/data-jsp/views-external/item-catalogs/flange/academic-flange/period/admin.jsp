<script type="text/javascript">
    $(document).ready(function () {  
        var itemSchoolYear = null;
        createDropDownSchoolYear("#schoolYearFilter");
        itemSchoolYear = $('#schoolYearFilter').jqxDropDownList('getSelectedItem');
        if(itemSchoolYear!=undefined || itemSchoolYear!=null){
            loadTable();
            $('#schoolYearFilter').on('change', function (event){     
                var args = event.args;
                if (args) {
                    // index represents the item's index.                      
                    var index = args.index;
                    var item = args.item;
                    // get item's label and value.
                    var label = item.label;
                    var value = item.value;
                    var type = args.type; // keyboard, mouse or null depending on how the item was selected.
                    loadTable();
                } 
            });
        }
        var windowAddPeriod = $('#jqxWindowAddPeriod').jqxWindow({
            theme: theme,
            height: 220,
            width: 240,
            resizable: false,
            draggable: true,
            autoOpen: false,
            isModal: true,
            cancelButton: $('#cancelAdd'),
            initContent: function () {
                $('#okAdd').jqxButton({
                    width: '80px',
                    theme: theme
                });
                $('#cancelAdd').jqxButton({
                    width: '80px',
                    theme: theme
                });
                $('#okAdd').focus();
            }
        });
        function loadTable(){
            itemSchoolYear = $('#schoolYearFilter').jqxDropDownList('getSelectedItem');
            var ordersSource ={
                dataFields: [
                    { name: 'dataProgresivNumber', type:'int'},
                    { name: 'dataPkPeriod', type: 'string' },
                    { name: 'dataUnique', type: 'string' },
                    { name: 'dataNamePeriod', type: 'string' } ,
                    { name: 'dataNamePeriodAbbreviated', type: 'string' } ,
                    { name: 'dataActive', type: 'int' } ,
                    { name: 'dataYearActive', type: 'int' },
                    { name: 'dataYear', type: 'string' } ,
                    { name: 'dataPeriodType', type: 'string' } ,
                    { name: 'dataFkSchoolYear', type: 'int' }
                ],
                root: "__ENTITIES",
                data : {
                  fkSchoolYear: itemSchoolYear.value 
                },
                dataType: "json",
                async: false,
                id: 'dataPkPeriod',
                url: '../servicePeriod?view=all',
                deleteRow: function (rowID, commit) {
                    // synchronize with the server - send delete command
                    // call commit with parameter true if the synchronization with the server is successful 
                    // and with parameter false if the synchronization failed.
                    $.ajax({
                        //Send the paramethers to servelt
                        type: "POST",
                        async: false,
                        url: "../servicePeriod?delete",
                        data:{
                            'pt_pkPeriod':rowID
                        },
                        beforeSend: function (xhr) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //This is if exits an error with the server internal can do server off, or page not found
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) {
                            if(data.indexOf('foreign')>=0){
                                $("#ok").hide();
                                $("#message").text("¡Registros de entidades diferentes dependen de este registro, por lo que no es posible borrarlo!");
                                $("#jqxWindowWarning").jqxWindow('open');

                            }else{
                                commit(true);
                            }                        
                        }
                    });
                }
            };
            var dataAdapter = new $.jqx.dataAdapter(ordersSource);
            $("#tablePeriod").jqxDataTable({
                width: 400,
                height: 152,
                selectionMode: "singleRow",
                localization: getLocalization("es"),
                source: dataAdapter,
                pageable: false,
                editable: true,
                filterable: false,
                showToolbar: true,
                altRows: true,
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
                    container.append(deleteButton);
                    toolBar.append(container);
                    addButton.jqxButton({cursor: "pointer", enableDefault: false,  height: 25, width: 25 });
                    addButton.find('div:first').addClass(toTheme('jqx-icon-plus'));
                    addButton.jqxTooltip({ position: 'bottom', content: "Agregar"});
                    deleteButton.jqxButton({ cursor: "pointer", disabled: true, enableDefault: false,  height: 25, width: 25 });
                    deleteButton.find('div:first').addClass(toTheme('jqx-icon-delete'));
                    deleteButton.jqxTooltip({ position: 'bottom', content: "Eliminar"});

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
                        }
                    };
                    var rowIndex = null;
                    $("#tablePeriod").on('rowSelect', function (event) {
                        var args = event.args;
                        rowIndex = args.index;
                        updateButtons('Select');
                        if(args.row.dataActive==="Activo"){
                            updateButtons('Unselect');
                        }
                    });
                    $("#tablePeriod").on('rowUnselect', function (event) {
                        
                        updateButtons('Unselect');
                    });
                    $("#tablePeriod").on('rowEndEdit', function (event) {
                        updateButtons('End Edit');
                    });
                    $("#tablePeriod").on('rowBeginEdit', function (event) {
                        updateButtons('Edit');
                    });
                    addButton.click(function (event) {
                        if (!addButton.jqxButton('disabled')) {
                            $("#validationStatus").hide();
                            windowAddPeriod.jqxWindow('open');
                        }
                    });
                    deleteButton.click(function () {
                        $("#ok").show();
                        if (!deleteButton.jqxButton('disabled')) {
                            $("#message").text("¡Estas seguro de borrar este registro!");
                            $("#jqxWindowWarning").jqxWindow('open');
                            $("#ok").off("click");
                            $("#ok").on("click", function (){
                                $("#jqxWindowWarning").jqxWindow('close');
                                $("#tablePeriod").jqxDataTable('deleteRow', rowIndex);
                            });
                            updateButtons('delete');
                        }
                    });
                },
                columns: [
                    { text: 'NP',filterable: false, editable: false, dataField: 'dataProgresivNumber', width: 25 },
                    { text: 'Perido Escolar', dataField: 'dataNamePeriod', editable: false},
                    { text: 'Estatus',  columntype: 'custom', align:'center', cellsalign:'center', dataField: 'dataActive', width: 80,
                        createEditor: function (row, cellvalue, editor, cellText, width, height) {
                            // construct the editor. 
                            if(cellvalue==="Inactivo"){
                                //alert(cellvalue);
                                cellvalue = false;
                            }else{
                                cellvalue = true;
                            }
                            editor.jqxCheckBox({rtl:true, checked: cellvalue});
                            editor.children().css({"margin-right": "30px","margin-top":"7px"});
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
                                value = "Inactivo";
                            }else{
                                value = "Activo";
                            }
                            return value;
                         }
                    }
                ]
            }); 
        }
        $('#tablePeriod').on('cellValueChanged', function (event) {
            // event args.
            var args = event.args;
            // cell value.
            var value = args.value;
            // old cell value.
            var oldValue = args.oldValue;
            // row data.
            var row = args.row;
            // row index.
            var index = args.index;
            // row's data bound index.
            var boundIndex = args.boundIndex;
            // row key.
            var rowKey = args.key;
            // column data field.
            var dataField = args.dataField;
            var status = value;
            if(status==="Inactivo"){
                status=0;
            }else{
                status=1;
            }
            $.ajax({
                //Send the paramethers to servelt
                type: "POST",
                async: false,
                url: "../servicePeriod?update",
                data:{
                    'pkPeriod': rowKey,
                    'pt_active':status
                },
                beforeSend: function (xhr) {
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    //This is if exits an error with the server internal can do server off, or page not found
                    alert("Error interno del servidor");
                },
                success: function (data, textStatus, jqXHR) { 
                    //If is updated rechange the drowdown in the other flange...
                    loadTable();
                }
            });
        });
        $("#okAdd").click(function (){
            var itemSchoolYear = $("#schoolYearFilter").jqxDropDownList('getSelectedItem'); 
            var itemPeriodType = $("#periodTypeFilter").jqxDropDownList('getSelectedItem'); 
            var year = parseInt(itemSchoolYear.originalItem.dataYearBegin);
            
            if(validate(itemPeriodType.label+" "+year)){
                var data = {
                    dataYear : year,
                    dataPeriodType : itemPeriodType.value,
                    dataFkSchoolYear : itemSchoolYear.value
                };
                insert(data);
                $("#validationStatus").hide();
                windowAddPeriod.jqxWindow('close');
                
            }else{
                $("#validationStatus").show();
            }          
        });
        function createDropDownPeriodType(){
            var sourceYear =[
                {"dataPeriodType":"Enero-Abril","dataValuePeriodType":"1"},
                {"dataPeriodType":"Mayo-Agosto","dataValuePeriodType":"2"},
                {"dataPeriodType":"Septiembre-Diciembre","dataValuePeriodType":"3"}
            ];
            $("#periodTypeFilter").jqxDropDownList({
                theme: theme,
                filterable: false, 
                autoDropDownHeight: false,
                placeHolder: "SELECCIONAR",
                selectedIndex: 0, 
                source: sourceYear, 
                displayMember: "dataPeriodType", 
                valueMember: "dataValuePeriodType",
                dropDownHeight: 80,
                height: 26, 
                width: 200                
            }).css("display","inline-block");
            var item = $("#schoolYearFilter").jqxDropDownList('getSelectedItem');
            var year = item.originalItem.dataYearBegin;
            $("#year").text(parseInt(year));
            $('#periodTypeFilter').on('change', function (event){     
                var args = event.args;
                if (args) {
                    // index represents the item's index.                      
                    var index = args.index;
                    var item = args.item;
                    // get item's label and value.
                    var label = item.label;
                    var value = item.value;
                    var type = args.type; // keyboard, mouse or null depending on how the item was selected.
                    var item = $("#schoolYearFilter").jqxDropDownList('getSelectedItem');
                    var year = item.originalItem.dataYearBegin;
                    $("#year").text(parseInt(year));
                    if(validate(label+" "+parseInt(year))){
                        $("#validationStatus").hide();
                    }else{
                        $("#validationStatus").show();
                    }
                } 
            });
        };
        createDropDownPeriodType();
        function validate(compare){
            var result = false;
            var rows = $("#tablePeriod").jqxDataTable('getView');  
            if(rows.length<=0){
                result = true;
            }else{
                for (var i = 0; i < rows.length; i++) {
                    // get a row.
                    var rowData = rows[i];
                    if(rowData.dataNamePeriod===compare){
                        result = false;
                        break;
                    }else{
                        result = true;
                    }
                }
            }
            return result;
        }
        function insert(data){
            $.ajax({
                //Send the paramethers to servelt
                type: "POST",
                async: false,
                url: "../servicePeriod?insert",
                data:{
                    pt_year: data.dataYearBegin,
                    pt_period_type: data.dataPeriodType,
                    pt_fk_school_year : data.dataFkSchoolYear
                },
                beforeSend: function (xhr) {
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    //This is if exits an error with the server internal can do server off, or page not found
                    alert("Error interno del servidor");
                },
                success: function (data, textStatus, jqXHR) {
                    $("#tablePeriod").jqxDataTable('updateBoundData');
                }
            });
        }
    });
</script>
<div id='jqxWindowAddPeriod'>
    <div>Agregar</div>
    <div>
        <div>
            <div style="display: inline-block; margin-right: 5px;">
                <span>Periodo en</span><br>
                <div id="periodTypeFilter"></div>
            </div>
            <br>
            <div style="display: inline-block; margin-right: 5px;">
                <span>Año</span><br>
                <div id="year" class="year" style="font-size: 28px; color: rgb(150, 216, 101);">2001</div>
            </div>
            <div style="margin-right: 5px;">
                <span>Status</span><br>
                <label>Activo <input type="radio" disabled="" name="status" /></label>
                <label>Inactivo <input type="radio" disabled="" name="status" checked /></label>
            </div>
            <div style="margin-right: 5px;">
                <span id="validationStatus" style="display: none; color: red;">El periodo seleccionado ya existe</span>
            </div>
        </div>
        <div style="float: right; bottom: 10px; right: 20px;  position: absolute;">
            <input type="button" id="okAdd" value="Agregar" style="margin-right: 10px" />
            <input type="button" id="cancelAdd" value="Cancelar" />
        </div>
    </div>
</div>
<div style="display: inline-block; margin-right: 5px;">
    <span>Siclo Escolar</span><br>
    <div id="schoolYearFilter"></div>
</div>
<div id="tablePeriod"></div>