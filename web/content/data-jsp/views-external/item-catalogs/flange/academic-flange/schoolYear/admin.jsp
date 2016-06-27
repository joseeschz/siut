<script type="text/javascript">
    $(document).ready(function () {  
        var ordersSource ={
            dataFields: [
                { name: 'id', type:'int'},
                { name: 'dataProgresivNumber', type:'int'},
                { name: 'dataPkSchoolYear', type: 'string' },
                { name: 'dataUnique', type: 'string' },
                { name: 'dataSchoolYearName', type: 'string' } ,
                { name: 'dataYearBegin', type: 'string' } ,
                { name: 'dataYearEnd', type: 'string' } ,
                { name: 'dataActive', type: 'int' } 
            ],
            root: "__ENTITIES",
            dataType: "json",
            async: false,
            id: 'dataPkSchoolYear',
            url: '../serviceSchoolYear?view',
            deleteRow: function (rowID, commit) {
                // synchronize with the server - send delete command
                // call commit with parameter true if the synchronization with the server is successful 
                // and with parameter false if the synchronization failed.
                $.ajax({
                    //Send the paramethers to servelt
                    type: "POST",
                    async: false,
                    url: "../serviceSchoolYear?delete",
                    data:{
                        'pt_pkSchoolYear':rowID
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
        var windowAddSchoolYear = $('#jqxWindowAddSchoolYear').jqxWindow({
            theme: theme,
            height: 190,
            width: 230,
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
            var dataAdapter = new $.jqx.dataAdapter(ordersSource);
            $("#tableSchoolYear").jqxDataTable({
                width: 400,
                height : 500,
                selectionMode: "singleRow",
                localization: getLocalization("es"),
                source: dataAdapter,
                pageable: false,
                editable: true,
                filterable: true,
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
                    $("#tableSchoolYear").on('rowSelect', function (event) {
                        var args = event.args;
                        rowIndex = args.index;
                        updateButtons('Select');
                    });
                    $("#tableSchoolYear").on('rowUnselect', function (event) {
                        updateButtons('Unselect');
                    });
                    $("#tableSchoolYear").on('rowEndEdit', function (event) {
                        updateButtons('End Edit');
                    });
                    $("#tableSchoolYear").on('rowBeginEdit', function (event) {
                        updateButtons('Edit');
                    });
                    addButton.click(function (event) {
                        if (!addButton.jqxButton('disabled')) {
                            windowAddSchoolYear.jqxWindow('open');
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
                                $("#tableSchoolYear").jqxDataTable('deleteRow', rowIndex);
                            });
                            updateButtons('delete');
                        }
                    });
                },
                columns: [
                    { text: 'NP',filterable: false, editable: false, dataField: 'dataProgresivNumber', width: 25 },
                    { text: 'Ciclo Escolar', dataField: 'dataSchoolYearName', editable: false},
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
        loadTable();
        $('#tableSchoolYear').on('cellValueChanged', function (event) {
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
            console.log(args)
            $.ajax({
                //Send the paramethers to servelt
                type: "POST",
                async: false,
                url: "../serviceSchoolYear?update",
                data:{
                    'pkSchoolYear': rowKey,
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
        function createDropDownYear(){
            var sourceYear =[
                {"dataNameYear":"2000","dataValueYear":"2000"},
                {"dataNameYear":"2001","dataValueYear":"2001"},
                {"dataNameYear":"2002","dataValueYear":"2002"},
                {"dataNameYear":"2003","dataValueYear":"2003"},
                {"dataNameYear":"2004","dataValueYear":"2004"},
                {"dataNameYear":"2005","dataValueYear":"2005"},
                
                {"dataNameYear":"2006","dataValueYear":"2006"},
                {"dataNameYear":"2007","dataValueYear":"2007"},
                {"dataNameYear":"2008","dataValueYear":"2008"},
                {"dataNameYear":"2009","dataValueYear":"2009"},
                {"dataNameYear":"2010","dataValueYear":"2010"},
                {"dataNameYear":"2011","dataValueYear":"2011"},
                
                {"dataNameYear":"2012","dataValueYear":"2012"},
                {"dataNameYear":"2013","dataValueYear":"2013"},
                {"dataNameYear":"2014","dataValueYear":"2014"},
                {"dataNameYear":"2015","dataValueYear":"2015"},
                {"dataNameYear":"2016","dataValueYear":"2016"},
                {"dataNameYear":"2017","dataValueYear":"2017"},
                
                {"dataNameYear":"2018","dataValueYear":"2018"},
                {"dataNameYear":"2019","dataValueYear":"2019"},
                {"dataNameYear":"2020","dataValueYear":"2020"},
                {"dataNameYear":"2021","dataValueYear":"2021"},
                {"dataNameYear":"2022","dataValueYear":"2022"},
                {"dataNameYear":"2023","dataValueYear":"2023"},
                
                {"dataNameYear":"2024","dataValueYear":"2024"},
                {"dataNameYear":"2025","dataValueYear":"2025"},
                {"dataNameYear":"2026","dataValueYear":"2026"},
                {"dataNameYear":"2027","dataValueYear":"2027"},
                {"dataNameYear":"2028","dataValueYear":"2028"},
                {"dataNameYear":"2029","dataValueYear":"2029"}
            ];
            $("#yearBegin").jqxDropDownList({
                theme: theme,
                filterable: false, 
                autoDropDownHeight: false,
                placeHolder: "SELECCIONAR",
                selectedIndex: 0, 
                source: sourceYear, 
                displayMember: "dataNameYear", 
                valueMember: "dataValueYear",
                dropDownHeight: 123,
                height: 26, 
                width: 80                
            }).css("display","inline-block");
            
            $('#yearBegin').on('change', function (event){     
                var args = event.args;
                if (args) {
                    // index represents the item's index.                      
                    var index = args.index;
                    var item = args.item;
                    // get item's label and value.
                    var label = item.label;
                    var value = item.value;
                    var type = args.type; // keyboard, mouse or null depending on how the item was selected.
                    $("#yearEnd").text(parseInt(value)+1);
                    var item = $("#yearBegin").jqxDropDownList('getSelectedItem'); 
                    var yearBegin = item.value;
                    var yearEnd = $("#yearEnd").text();
                    if(validate(yearBegin+"-"+yearEnd)){
                        $("#validationStatus").hide();
                    }else{
                        $("#validationStatus").show();
                    }
                } 
            });
        };
        createDropDownYear();
        $("#okAdd").click(function (){
            var item = $("#yearBegin").jqxDropDownList('getSelectedItem'); 
            var yearBegin = item.value;
            var yearEnd = $("#yearEnd").text();
            if(validate(yearBegin+"-"+yearEnd)){
                var data = {
                    dataYearBegin : yearBegin,
                    dataYearEnd : yearEnd
                };
                insert(data);
                $("#validationStatus").hide();
                windowAddSchoolYear.jqxWindow('close');
                
            }else{
                $("#validationStatus").show();
            }          
        });
        function validate(compare){
            var result = false;
            console.log(compare);
            var rows = $("#tableSchoolYear").jqxDataTable('getView');            
            for (var i = 0; i < rows.length; i++) {
                // get a row.
                var rowData = rows[i];
                if(rowData.dataUnique===compare){
                    result = false;
                    break;
                }else{
                    result = true;
                }
            }
            return result;
        }
        function insert(data){
            $.ajax({
                //Send the paramethers to servelt
                type: "POST",
                async: false,
                url: "../serviceSchoolYear?insert",
                data:{
                    pt_year_begin: data.dataYearBegin,
                    pt_year_end: data.dataYearEnd
                },
                beforeSend: function (xhr) {
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    //This is if exits an error with the server internal can do server off, or page not found
                    alert("Error interno del servidor");
                },
                success: function (data, textStatus, jqXHR) {
                    $("#tableSchoolYear").jqxDataTable('updateBoundData');
                }
            });
        }
    });
</script>
<div id='jqxWindowAddSchoolYear'>
    <div>Agregar</div>
    <div>
        <div>
            <div style="display: inline-block; margin-right: 5px;">
                <span>Año inicio</span><br>
                <div id="yearBegin" class="year"></div>
            </div>
            <div style="display: inline-block; margin-right: 5px;">
                <span>Año fin</span><br>
                <div id="yearEnd" class="year" style="font-size: 28px; color: rgb(150, 216, 101);">2001</div>
            </div>
            <br>
            <div style="margin-right: 5px;">
                <span>Status</span><br>
                <label>Activo <input type="radio" name="status" /></label>
                <label>Inactivo <input type="radio" name="status" checked /></label>
            </div>
            <div style="margin-right: 5px;">
                <span id="validationStatus" style="display: none; color: red;">El Ciclo seleccionado ya existe</span>
            </div>
        </div>
        <div style="float: right; bottom: 10px; right: 20px;  position: absolute;">
            <input type="button" id="okAdd" value="Agregar" style="margin-right: 10px" />
            <input type="button" id="cancelAdd" value="Cancelar" />
        </div>
    </div>
</div>
<div id="tableSchoolYear"></div>