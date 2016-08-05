<script>
    $(document).ready(function () {
        var itemLevel = 0;
        var itemCareer = 0;
        var itemPeriod = 0;
        var itemGroup = 0;
        var itemSemester = 0;
        var buttonTemplate = "<div style='float: left; padding: 3px; margin: 2px;'><div style='margin: 4px; width: 16px; height: 16px;'></div></div>";
        var exportButton = $(buttonTemplate);
        var container = $("<div class='container' style='overflow: hidden; position: relative; height: 100%; width: 100%;'></div>");
        createDropDownStudyLevelByTeacherTutor("#generateDownLevelFilter",false);
        itemLevel = $('#generateDownLevelFilter').jqxDropDownList('getSelectedItem');
        if(itemLevel!==undefined){
            createDropDownCareerByTeacherTutor( itemLevel.value ,"#generateDownCareerFilter",false);
            itemCareer = $('#generateDownCareerFilter').jqxDropDownList('getSelectedItem');
            createDropDownPeriod("comboActiveYear","#generateDownPeriodFilter");
            itemPeriod = $('#generateDownPeriodFilter').jqxDropDownList('getSelectedItem');
            if(itemPeriod!==undefined){
                createDropDownSemesterByTeacherTutor(itemPeriod.value, itemLevel.value,"#generateDownSemesterFilter",false);
                itemSemester = $('#generateDownSemesterFilter').jqxDropDownList('getSelectedItem');
                if(itemSemester!==undefined){
                    createDropDownGruopByTeacherTutor(itemPeriod.value, itemSemester.value, "#generateDownGroupFilter",false);
                    itemGroup = $('#generateDownGroupFilter').jqxDropDownList('getSelectedItem');
                    if(itemGroup!==undefined || itemGroup!==null){
                        loadGridStudents();
                    }
                }else{
                    createDropDownGruopByTeacherTutor(null, null, "#generateDownGroupFilter",false);
                }
            }else{
                createDropDownSemesterByTeacherTutor(null, null,"#generateDownSemesterFilter",false);
                createDropDownGruopByTeacherTutor(null, null, "#generateDownGroupFilter",false);
            }
            $('#generateDownLevelFilter').on('change',function (event){  
                itemLevel = $('#generateDownLevelFilter').jqxDropDownList('getSelectedItem');
                if(itemLevel!==undefined){
                    createDropDownCareerByTeacher(itemLevel.value, "#generateDownCareerFilter", true);
                    itemPeriod = $('#generateDownPeriodFilter').jqxDropDownList('getSelectedItem');
                    if(itemPeriod!==undefined){
                        itemCareer = $('#generateDownCareerFilter').jqxDropDownList('getSelectedItem');
                        createDropDownSemesterByTeacher(itemPeriod.value, itemLevel.value,"#generateDownSemesterFilter", true);
                        itemSemester = $('#generateDownSemesterFilter').jqxDropDownList('getSelectedItem'); 
                    }else{
                        createDropDownSemesterByTeacher(null, null,"#generateDownSemesterFilter", true);
                    }
                }else{
                    createDropDownCareerByTeacher(null, "#generateDownCareerFilter", true);
                    createDropDownSemesterByTeacher(null, null,"#generateDownSemesterFilter", true);
                }
                
            });
            $('#generateDownCareerFilter').on('change',function (event){  
                var args = event.args;
                if (args) {
                    // index represents the item's index.                      
                    var index = args.index;
                    var item = args.item;
                    // get item's label and value.
                    var label = item.label;
                    var value = item.value;
                    var type = args.type; // keyboard, mouse or null depending on how the item was selected.
                    itemCareer = $('#generateDownCareerFilter').jqxDropDownList('getSelectedItem');
                    itemSemester = $('#generateDownSemesterFilter').jqxDropDownList('getSelectedItem');
                    itemGroup = $('#generateDownGroupFilter').jqxDropDownList('getSelectedItem');
                    itemPeriod = $('#generateDownPeriodFilter').jqxDropDownList('getSelectedItem');
                    itemLevel = $('#generateDownLevelFilter').jqxDropDownList('getSelectedItem');
                    createDropDownSemesterByTeacherTutor(itemPeriod.value, itemLevel.value,"#generateDownSemesterFilter",true);
                    itemSemester = $('#generateDownSemesterFilter').jqxDropDownList('getSelectedItem');
                }                
            });
            $("#generateDownSemesterFilter").on('change',function (event){
                var args = event.args;
                if (args) {
                    // index represents the item's index.                      
                    var index = args.index;
                    var item = args.item;
                    // get item's label and value.
                    var label = item.label;
                    var value = item.value;
                    var type = args.type; // keyboard, mouse or null depending on how the item was selected.
                    itemCareer = $('#generateDownCareerFilter').jqxDropDownList('getSelectedItem');
                    itemSemester = $('#generateDownSemesterFilter').jqxDropDownList('getSelectedItem');
                    itemGroup = $('#generateDownGroupFilter').jqxDropDownList('getSelectedItem');
                    itemPeriod = $('#generateDownPeriodFilter').jqxDropDownList('getSelectedItem');
                    itemLevel = $('#generateDownLevelFilter').jqxDropDownList('getSelectedItem');
                    createDropDownSemesterByTeacherTutor(itemPeriod.value, itemLevel.value,"#generateDownSemesterFilter",true);
                    itemSemester = $('#generateDownSemesterFilter').jqxDropDownList('getSelectedItem');
                }
            });
            $("#generateDownGroupFilter").on('change',function (event){  
                var args = event.args;
                if (args) {
                    // index represents the item's index.                      
                    var index = args.index;
                    var item = args.item;
                    // get item's label and value.
                    var label = item.label;
                    var value = item.value;
                    var type = args.type; // keyboard, mouse or null depending on how the item was selected.
                    loadGridStudents();
                }
            });
        }else{
            createDropDownCareerByTeacher(null ,"#generateDownCareerFilter",false);
            createDropDownPeriod("comboActiveYear","#generateDownPeriodFilter");
            createDropDownSemesterByTeacher(null, null,"#generateDownSemesterFilter",false);
            createDropDownGruopByTeacher(null, null, "#generateDownGroupFilter",false);
        }
        function loadSource(){
            var valItemCareer=0;
            var valItemGroup=0;
            var valItemSemester=0;
            var valItemPeriod=0;
            itemCareer = $('#generateDownCareerFilter').jqxDropDownList('getSelectedItem');
            itemSemester = $('#generateDownSemesterFilter').jqxDropDownList('getSelectedItem');
            itemGroup = $('#generateDownGroupFilter').jqxDropDownList('getSelectedItem');
            itemPeriod = $('#generateDownPeriodFilter').jqxDropDownList('getSelectedItem');
            
            if(itemCareer!==undefined){
                valItemCareer=itemCareer.value;
            }
            if(itemGroup!==undefined){
                valItemGroup=itemGroup.value;
            }
            if(valItemSemester!==undefined){
                valItemSemester=itemSemester.value;
            }
            if(itemPeriod!==undefined){
                valItemPeriod=itemPeriod.value;
            }            
            var ordersSource ={
                dataFields: [
                    { name: 'dataPkStudent', type: 'int' },
                    { name: 'dataName', type: 'string' },
                    { name: 'dataEnrollment', type: 'string' },
                    { name: 'dataDown', type: 'string' }
                ],
                dataType: "json",
                id: "dataPkStudent",
                async: false,
                url: '../serviceStudent?selectStudentsCareerSemesterGroup',
                data : {
                    fkPeriod : valItemPeriod,
                    fkCareer : valItemCareer,
                    fkSemester : valItemSemester,
                    fkGroup : valItemGroup                    
                },
                updaterow: function (rowid, rowdata, commit) {
                    // synchronize with the server - send update command
                    // call commit with parameter true if the synchronization with the server is successful 
                    // and with parameter false if the synchronization failder.
                    itemPeriod = $('#generateDownPeriodFilter').jqxDropDownList('getSelectedItem');
                    var statusDown;
                    if(rowdata.dataDown==="Si"){
                        statusDown="generateDown";
                    }else{
                        statusDown="removeDown";
                    }
                    if(statusDown==="generateDown"){                 
                        $("#messageWarning").text("Estas seguro de generar baja para el alumno ");
                        $("#studentName").text(rowdata.dataName);
                        $("#enrollment").text(" con matrícula "+rowdata.dataEnrollment);
                        $("#period").text(" en el periodo "+itemPeriod.label);
                        $("#jqxWindowAlert").jqxWindow('open');              
                        $('#okWarning').off("click");
                        $('#okWarning').on("click",function (){
                            $("#jqxWindowAlert").jqxWindow('close'); 
                            $.ajax({
                                //Send the paramethers to servelt
                                type: "POST",
                                async: false,
                                url: "../serviceStudent?"+statusDown,
                                data:{
                                    'fkStudent': rowdata.dataPkStudent
                                },
                                beforeSend: function (xhr) {
                                },
                                error: function (jqXHR, textStatus, errorThrown) {
                                    //This is if exits an error with the server internal can do server off, or page not found
                                    alert("Error interno del servidor");
                                },
                                success: function (data_result, textStatus, jqXHR) { 
                                    commit(true);
                                    console.log(data_result);
                                }
                            });  
                        });
                        $('#cancelWarning').off("click");
                        $('#cancelWarning').on("click",function (){                            
                            $("#jqxWindowAlert").jqxWindow('close'); 
                            commit(false);
                        });
                    }else{
                        $("#messageWarning").text("Estas seguro de cancelar la baja para el alumno ");
                        $("#studentName").text(rowdata.dataName);
                        $("#enrollment").text(" con matrícula "+rowdata.dataEnrollment);
                        $("#period").text(" en el periodo "+itemPeriod.label);
                        $("#jqxWindowAlert").jqxWindow('open');              
                        $('#okWarning').off("click");
                        $('#okWarning').on("click",function (){
                            $("#jqxWindowAlert").jqxWindow('close'); 
                            $.ajax({
                                //Send the paramethers to servelt
                                type: "POST",
                                async: false,
                                url: "../serviceStudent?"+statusDown,
                                data:{
                                    'fkStudent': rowdata.dataPkStudent
                                },
                                beforeSend: function (xhr) {
                                },
                                error: function (jqXHR, textStatus, errorThrown) {
                                    //This is if exits an error with the server internal can do server off, or page not found
                                    alert("Error interno del servidor");
                                },
                                success: function (data_result, textStatus, jqXHR) { 
                                    commit(true);
                                    console.log(data_result);
                                }
                            });  
                        });
                        $('#cancelWarning').off("click");
                        $('#cancelWarning').on("click",function (){                            
                            $("#jqxWindowAlert").jqxWindow('close'); 
                            commit(false);
                        });
                    }
                    
                    
                }
            };
            return ordersSource;
        }
        
        function loadGridStudents(){
            var popoverrender = function (element){
                var desc = $(element.context.innerHTML).children("div").attr("desc");
                var htmlPopover = $('<div><div>'+desc+'</div></div>');
                htmlPopover.jqxPopover({offset: {left: 0, top:0}, width:150, isModal: true, arrowOffsetValue: 10, title: "Nombre", showCloseButton: true, selector: $(element.parent().parent()) });  
            };
             var cellclass = function (row, columnfield, value) {
                return 'grey';
            };
            var createGridEditor = function(row, cellValue, editor, cellText, width, height){
                // construct the editor.
                var element = $('<div tabIndex=0 style="position: absolute; top: 50%; left: 50%; margin-top: -7px; margin-left: -10px;"></div>');
                editor.append(element);
                element.jqxCheckBox({ animationShowDelay: 0, animationHideDelay: 0, width: 18, height: 18 });
            };
            var initGridEditor = function (row, cellValue, editor, cellText, width, height) {
                // set the editor's current value. The callback is called each time the editor is displayed.
                var checkBoxHTMLElement = editor.find('div:first');
                checkBoxHTMLElement.jqxCheckBox({ checked: cellValue.toString() == "Si" });
            };
            var gridEditorValue = function (row, cellValue, editor) {
                var checkBoxHTMLElement = editor.find('div:first');
                var value;
                if(checkBoxHTMLElement.val()){
                    value="Si";
                }else{
                    value="No";
                }
                return value;
            };
            var dataAdapter = new $.jqx.dataAdapter(loadSource());  
            $("#tableGenerateDown").jqxGrid({
                width: 850,
                height: 450,
                selectionMode: "singlerow",
                localization: getLocalization("es"),
                source: dataAdapter,
                editmode: 'dblclick',
                pageable: false,
                editable: true,
                filterable: true,
                altRows: true,
                ready: function(){
                    $("#tableGenerateDown").jqxGrid('focus');
                },
                columns: [
                    {
                        text: '#', sortable: false, filterable: false, editable: false,
                        groupable: false, draggable: false, resizable: false,
                        datafield: '', columntype: 'number', width: 10,
                        cellsrenderer: function (row, column, value) {
                            return "<div style='margin:4px;'>" + (value + 1) + "</div>";
                        }
                    },
                    { text: 'Matrícula',align: 'center', dataField: 'dataEnrollment', width: 120, cellclassname: cellclass, editable: false },
                    { text: 'Alumno', align: 'center', dataField: 'dataName', cellclassname: cellclass, editable: false, filterable: false},
                    { text: 'Baja', align: 'center', cellsalign: 'center', dataField: 'dataDown', createeditor: createGridEditor, initeditor: initGridEditor, geteditorvalue: gridEditorValue, columntype: 'custom', width: 70, cellclassname: cellclass, editable: true, filterable: true}
                ],
                columnsresize: false
            });
            $('#tableGenerateDown').off('rowunselect');
            $('#tableGenerateDown').on('rowunselect', function (event){
                // event arguments.
                var args = event.args;
                // row's bound index.
                var rowBoundIndex = args.rowindex;
                // row's data. The row's data object or null(when all rows are being selected or unselected with a single action). If you have a datafield called "firstName", to access the row's firstName, use var firstName = rowData.firstName;
                var rowData = args.row;
                if(args){
                    $("#tableGenerateDown").jqxGrid('endcelledit', rowBoundIndex, "dataDown", false);
                }
            });
        }        
        var contextMenu = $("#contextMenu").jqxMenu({ width: 180, autoOpenPopup: false, mode: 'popup'});
        $("#tableGenerateDown").on('contextmenu', function () {
            return false;
        });
        // handle context menu clicks.
        $("#contextMenu").on('itemclick', function (event) {
            var args = event.args;
            var rowindex = $("#tableGenerateDown").jqxGrid('getselectedrowindex');
            if ($.trim($(args).text()) === "Llenar Formato"){
                $.ajax({
                    //Send the paramethers to servelt
                    type: "POST",
                    async: false,
                    url: "../content/data-jsp/views-external/item-students/flange/process/tutoring/transact-flange/low.jsp",
                    data: {
                        'fkStudentLow': 0
                    },
                    beforeSend: function (xhr) {
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        //This is if exits an error with the server internal can do server off, or page not found
                        alert("Error interno del servidor");
                    },
                    success: function (data_result, textStatus, jqXHR) { 
                        $("#contentPDF").html(data_result);
                        $("#popupWindowDoc").jqxWindow('open');
                    }
                });  
            }
        });
        $("#tableGenerateDown").on('rowclick', function (event) {
            if (event.args.rightclick) {
                var data = $('#tableGenerateDown').jqxGrid('getrowdata', event.args.rowindex);
                $("#tableGenerateDown").jqxGrid('selectrow', event.args.rowindex);
                if(data.dataDown==="Si"){
                    $("#contextMenu").jqxMenu('disable', 'generate', false);
                }else{
                    $("#contextMenu").jqxMenu('disable', 'generate', true);
                }                
                var scrollTop = $(window).scrollTop();
                var scrollLeft = $(window).scrollLeft();
                contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                return false;
            }
        });
        
        $("#popupWindowMotiveDown").jqxWindow({ 
            width: 400,
            height: 350, 
            resizable: false, 
            isModal: true, 
            autoOpen: false, 
            modalOpacity: 0.7 
        });
    });
</script>
<div id="popupWindowMotiveDown">
    <div>Detalle de baja</div>
    <div style="overflow: hidden;" id="contentPDF">
        <div style="float: left; margin-right: 5px;">
            Motivo<br>
            <div id='generateDownMotiveDownFilter'></div>
        </div>
    </div>
</div>
<div style="float: left; margin-right: 5px;">
    Nivel de estudio<br>
    <div id='generateDownLevelFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Carrera <br>
    <div id='generateDownCareerFilter'></div>
</div>
<div id="contentHistoryPeriods" style="display: none; float: right; right: 100px; position: absolute; z-index: 10000;">
    Periodo historial <br>
    <div id='generateDownPeriodHistoryFilter'></div>
</div>
<div style="float: right; margin-right: 5px; display: none">
    Periodo <br>
    <div id='generateDownPeriodFilter'></div>
</div>
<br><br><br>
<div style="float: left; margin-right: 5px;">
    Cuatrimestre<br>
    <div id='generateDownSemesterFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Grupo<br>
    <div id='generateDownGroupFilter'></div>
</div>
<div style="float: left; margin-right: 5px" id="tableGenerateDown"></div>
<div id='contextMenu'>
    <ul>
        <li id="generate">Llenar Formato</li>
    </ul>
</div>