<script>
    $(document).ready(function () {
        var itemPeriod = 0;
        createDropDownPeriod("comboActiveYear","#generateDownPeriodFilter");
        itemPeriod = $('#generateDownPeriodFilter').jqxDropDownList('getSelectedItem');
        if(itemPeriod!==undefined){
            loadGridStudents();                
            
            $('#generateDownPeriodFilter').on('change',function (event){  
                var args = event.args;
                if (args) {
                    // index represents the item's index.                      
                    var index = args.index;
                    var item = args.item;
                    // get item's label and value.
                    var label = item.label;
                    var value = item.value;
                    var type = args.type; // keyboard, mouse or null depending on how the item was selected.
                    itemPeriod = $('#generateDownPeriodFilter').jqxDropDownList('getSelectedItem');
                    if(itemPeriod!==undefined){
                        loadGridStudents();              
                    }
                }                
            });
        }else{
            createDropDownPeriod("comboActiveYear","#generateDownPeriodFilter");
        }
        function loadSource(){
            var valItemPeriod=0;
            itemPeriod = $('#generateDownPeriodFilter').jqxDropDownList('getSelectedItem');
            if(itemPeriod!==undefined){
                valItemPeriod=itemPeriod.value;
            }            
            var ordersSource ={
                dataFields: [
                    { name: 'dataPkLowStundet', type: 'int' },
                    { name: 'dataPkStudent', type: 'int' },
                    { name: 'dataName', type: 'string' },
                    { name: 'dataEnrollment', type: 'string' },
                    { name: 'dataCareer', type: 'string' },
                    { name: 'dataSemester', type: 'string' },
                    { name: 'dataGroup', type: 'string' },
                    { name: 'dataDown', type: 'string' }
                ],
                dataType: "json",
                id: "dataPkLowStundet",
                async: false,
                url: '../serviceLowOfStudent?selectStudentsLowsTempsES',
                data : {
                    fkPeriod : valItemPeriod           
                },
                updaterow: function (rowid, rowdata, commit) {
                    // synchronize with the server - send update command
                    // call commit with parameter true if the synchronization with the server is successful 
                    // and with parameter false if the synchronization failder.
                    itemPeriod = $('#generateDownPeriodFilter').jqxDropDownList('getSelectedItem');
                    var statusDown;
                    if(rowdata.dataDown==="Si"){
                        statusDown="authorizateLow";
                    }else{
                        statusDown="removeLow";
                    }
                    if(statusDown==="authorizateLow"){                 
                        $("#messageWarning").text("Estas seguro de aprobar baja para el alumno ");
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
                                url: "../serviceLowOfStudent?update",
                                data:{
                                    'pt_pk_low_student': rowid,
                                    'pt_field_name' : 'fl_authorization_es',
                                    'pt_field_value' : 1
                                },
                                beforeSend: function (xhr) {
                                },
                                error: function (jqXHR, textStatus, errorThrown) {
                                    //This is if exits an error with the server internal can do server off, or page not found
                                    alert("Error interno del servidor");
                                    commit(false);
                                },
                                success: function (data_result, textStatus, jqXHR) { 
                                    loadGridStudents();
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
                        $("#messageWarning").text("Estas seguro de cancelar el proceso de la baja para el alumno ");
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
                                url: "../serviceLowOfStudent?update",
                                data:{
                                    'pt_pk_low_student': rowid,
                                    'pt_field_name' : 'fl_authorization_es',
                                    'pt_field_value' : 0
                                },
                                beforeSend: function (xhr) {
                                },
                                error: function (jqXHR, textStatus, errorThrown) {
                                    //This is if exits an error with the server internal can do server off, or page not found
                                    alert("Error interno del servidor");
                                    commit(false);
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
            $("#tableRequestLows").jqxGrid({
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
                    $("#tableRequestLows").jqxGrid('focus');
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
                    { text: 'Carrera', align: 'center', cellsalign: 'center', dataField: 'dataCareer', width: 100, cellclassname: cellclass, editable: false, filterable: false},
                    { text: 'Cuatrimestre', align: 'center', cellsalign: 'center', dataField: 'dataSemester', width: 100, cellclassname: cellclass, editable: false, filterable: false},
                    { text: 'Grupo', align: 'center', cellsalign: 'center', dataField: 'dataGroup', width: 100, cellclassname: cellclass, editable: false, filterable: false},
                    { text: 'Autorizar Baja', align: 'center', cellsalign: 'center', dataField: 'dataDown', createeditor: createGridEditor, initeditor: initGridEditor, geteditorvalue: gridEditorValue, columntype: 'custom', width: 120, cellclassname: cellclass, editable: true, filterable: true}
                ],
                columnsresize: false
            });
            $('#tableRequestLows').off('rowunselect');
            $('#tableRequestLows').on('rowunselect', function (event){
                // event arguments.
                var args = event.args;
                // row's bound index.
                var rowBoundIndex = args.rowindex;
                // row's data. The row's data object or null(when all rows are being selected or unselected with a single action). If you have a datafield called "firstName", to access the row's firstName, use var firstName = rowData.firstName;
                var rowData = args.row;
                
                if(args){
                    $("#tableRequestLows").jqxGrid('endcelledit', rowBoundIndex, "dataDown", false);
                }
            });
        }        
        var contextMenu = $("#contextMenu").jqxMenu({ width: 180, autoOpenPopup: false, mode: 'popup'});
        $("#tableRequestLows").on('contextmenu', function () {
            return false;
        });
        // handle context menu clicks.
        $("#contextMenu").on('itemclick', function (event) {
            var args = event.args;
            var rowindex = $("#tableRequestLows").jqxGrid('getselectedrowindex');
            var data = $('#tableRequestLows').jqxGrid('getrowdata', rowindex);
            if ($.trim($(args).text()) === "Llenar Formato"){
                itemPeriod = $('#generateDownPeriodFilter').jqxDropDownList('getSelectedItem');
                $.ajax({
                    //Send the paramethers to servelt
                    type: "POST",
                    async: false,
                    url: "../content/data-jsp/views-external/item-students/flange/process/tutoring/transact-flange/low.jsp",
                    data: {
                        'pt_pk_low_student' : data.dataPkLowStundet, 
                        'pt_pk_student': data.dataPkStudent,
                        'pt_pk_period': itemPeriod.value
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
            if ($.trim($(args).text()) === "Imprimir Formato"){
                $.ajax({
                    type: "POST",
                    async: false,
                    url: "../../content/data-jr/documentRegistedLowStudent/index.jsp?sessionLowReport",
                    data: {
                        'pt_pk_student': data.dataPkStudent,
                        'pt_pk_period': itemPeriod.value
                    },
                    beforeSend: function (xhr) {
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        alert("Error interno del servidor");
                    },
                    success: function (data, textStatus, jqXHR) {
                        var iframe = $('<iframe style="width: 1185px; height: 810px;">');
                        iframe.attr('src','../../content/data-jr/documentRegistedLowStudent/index.jsp');
                        $('#contentPDF').html(iframe);
                        $("#popupWindowDoc").jqxWindow('show');
                    }
                });                
            }
        });
        $("#tableRequestLows").on('rowclick', function (event) {
            if (event.args.rightclick) {
                var data = $('#tableRequestLows').jqxGrid('getrowdata', event.args.rowindex);
                $("#tableRequestLows").jqxGrid('selectrow', event.args.rowindex);
                if(data.dataDown==="Si"){
                    $("#contextMenu").jqxMenu('disable', 'authorizate', false);
                }else{
                    $("#contextMenu").jqxMenu('disable', 'authorizate', true);
                }   
                if(data.dataStatusES==="Autorizada"){
                    $("#contextMenu").jqxMenu('disable', 'print', false);
                }else{
                    $("#contextMenu").jqxMenu('disable', 'print', true);
                }
                var scrollTop = $(window).scrollTop();
                var scrollLeft = $(window).scrollLeft();
//                contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
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
<div style="float: right; margin-right: 5px;">
    Periodo <br>
    <div id='generateDownPeriodFilter'></div>
</div>
<br><br><br>
<div style="float: left; margin-right: 5px" id="tableRequestLows"></div>
<div id='contextMenu'>
    <ul>
        <li id="authorizate">Llenar Formato</li>
        <li id="print">Imprimir Formato</li>
    </ul>
</div>