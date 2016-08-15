<script>
    $(document).ready(function () {
        var itemLevel = 0;
        var itemCareer = 0;
        var itemPeriod = 0;
        var itemGroup = 0;
        var itemSemester = 0;
        var itemSubjectMatter =0;
        
        var buttonTemplate = "<div style='float: left; padding: 3px; margin: 2px;'><div style='margin: 4px; width: 16px; height: 16px;'></div></div>";
        var exportButton = $(buttonTemplate);
        var container = $("<div class='container' style='overflow: hidden; position: relative; height: 100%; width: 100%;'></div>");
        createDropDownStudyLevelByTeacherTutor("#letterDeliveryLevelFilter",false);
        itemLevel = $('#letterDeliveryLevelFilter').jqxDropDownList('getSelectedItem');
        if(itemLevel!==undefined){
            createDropDownCareerByTeacherTutor( itemLevel.value ,"#letterDeliveryCareerFilter",false);
            itemCareer = $('#letterDeliveryCareerFilter').jqxDropDownList('getSelectedItem');
            createDropDownPeriod("comboActiveYear","#letterDeliveryPeriodFilter");
            itemPeriod = $('#letterDeliveryPeriodFilter').jqxDropDownList('getSelectedItem');
            if(itemPeriod!==undefined){
                createDropDownSemesterByTeacherTutor(itemPeriod.value, itemLevel.value,"#letterDeliverySemesterFilter",false);
                itemSemester = $('#letterDeliverySemesterFilter').jqxDropDownList('getSelectedItem');
                if(itemSemester!==undefined){
                    createDropDownGruopByTeacherTutor(itemPeriod.value, itemSemester.value, "#letterDeliveryGroupFilter",false);
                    itemGroup = $('#letterDeliveryGroupFilter').jqxDropDownList('getSelectedItem');                    
                    if(itemGroup!==undefined || itemGroup!==null){
                        var filtrable = {
                            pkCareer : itemCareer.value,
                            pkSemester : itemSemester.value,
                            pkGroup : itemGroup.value,
                            pkPeriod : itemPeriod.value
                        };
                        createDropDownSubjectMatterByGroup(filtrable, "#letterDeliverySubjectMatterFilter", false);
                        itemSubjectMatter=$('#letterDeliverySubjectMatterFilter').jqxDropDownList('getSelectedItem');
                        if(itemSubjectMatter !==undefined || itemSubjectMatter!==null){
                            loadGridStudents();
                        }else{
                            
                        }                        
                    }
                }else{
                    createDropDownGruopByTeacherTutor(null, null, "#letterDeliveryGroupFilter",false);
                }
            }else{
                createDropDownSemesterByTeacherTutor(null, null,"#letterDeliverySemesterFilter",false);
                createDropDownGruopByTeacherTutor(null, null, "#letterDeliveryGroupFilter",false);
            }
            $('#letterDeliveryLevelFilter').on('change',function (event){  
                itemLevel = $('#letterDeliveryLevelFilter').jqxDropDownList('getSelectedItem');
                if(itemLevel!==undefined){
                    createDropDownCareerByTeacherTutor(itemLevel.value, "#letterDeliveryCareerFilter", true);
                    itemPeriod = $('#letterDeliveryPeriodFilter').jqxDropDownList('getSelectedItem');
                    if(itemPeriod!==undefined){
                        itemCareer = $('#letterDeliveryCareerFilter').jqxDropDownList('getSelectedItem');
                        createDropDownSemesterByTeacherTutor(itemPeriod.value, itemLevel.value,"#letterDeliverySemesterFilter", true);
                        itemSemester = $('#letterDeliverySemesterFilter').jqxDropDownList('getSelectedItem'); 
                    }else{
                        createDropDownSemesterByTeacherTutor(null, null,"#letterDeliverySemesterFilter", true);
                    }
                }else{
                    createDropDownCareerByTeacherTutor(null, "#letterDeliveryCareerFilter", true);
                    createDropDownSemesterByTeacherTutor(null, null,"#letterDeliverySemesterFilter", true);
                }
                
            });
            $('#letterDeliveryCareerFilter').on('change',function (event){  
                var args = event.args;
                if (args) {
                    // index represents the item's index.                      
                    var index = args.index;
                    var item = args.item;
                    // get item's label and value.
                    var label = item.label;
                    var value = item.value;
                    var type = args.type; // keyboard, mouse or null depending on how the item was selected.
                    itemCareer = $('#letterDeliveryCareerFilter').jqxDropDownList('getSelectedItem');
                    itemSemester = $('#letterDeliverySemesterFilter').jqxDropDownList('getSelectedItem');
                    itemGroup = $('#letterDeliveryGroupFilter').jqxDropDownList('getSelectedItem');
                    itemPeriod = $('#letterDeliveryPeriodFilter').jqxDropDownList('getSelectedItem');
                    itemLevel = $('#letterDeliveryLevelFilter').jqxDropDownList('getSelectedItem');
                    createDropDownSemesterByTeacherTutor(itemPeriod.value, itemLevel.value,"#letterDeliverySemesterFilter",true);
                    itemSemester = $('#letterDeliverySemesterFilter').jqxDropDownList('getSelectedItem');
                }                
            });
            $("#letterDeliverySemesterFilter").on('change',function (event){
                var args = event.args;
                if (args) {
                    // index represents the item's index.                      
                    var index = args.index;
                    var item = args.item;
                    // get item's label and value.
                    var label = item.label;
                    var value = item.value;
                    var type = args.type; // keyboard, mouse or null depending on how the item was selected.
                    itemCareer = $('#letterDeliveryCareerFilter').jqxDropDownList('getSelectedItem');
                    itemSemester = $('#letterDeliverySemesterFilter').jqxDropDownList('getSelectedItem');
                    itemGroup = $('#letterDeliveryGroupFilter').jqxDropDownList('getSelectedItem');
                    itemPeriod = $('#letterDeliveryPeriodFilter').jqxDropDownList('getSelectedItem');
                    itemLevel = $('#letterDeliveryLevelFilter').jqxDropDownList('getSelectedItem');
                    createDropDownSemesterByTeacherTutor(itemPeriod.value, itemLevel.value,"#letterDeliverySemesterFilter",true);
                    itemSemester = $('#letterDeliverySemesterFilter').jqxDropDownList('getSelectedItem');
                }
            });
            $("#letterDeliverySubjectMatterFilter").on('change',function (event){  
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
            $("#letterDeliveryGroupFilter").on('change',function (event){  
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
            createDropDownCareerByTeacherTutor(null ,"#letterDeliveryCareerFilter",false);
            createDropDownPeriod("comboActiveYear","#letterDeliveryPeriodFilter");
            createDropDownSemesterByTeacherTutor(null, null,"#letterDeliverySemesterFilter",false);
            createDropDownGruopByTeacherTutor(null, null, "#letterDeliveryGroupFilter",false);
            createDropDownSubjectMatterByGroup({}, "#letterDeliverySubjectMatterFilter", false);
        }
        function loadSource(){
            var valItemCareer=0;
            var valItemGroup=0;
            var valItemSemester=0;
            var valItemPeriod=0;
            var valItemSubjectMatter=0;
            itemCareer = $('#letterDeliveryCareerFilter').jqxDropDownList('getSelectedItem');
            itemSemester = $('#letterDeliverySemesterFilter').jqxDropDownList('getSelectedItem');
            itemGroup = $('#letterDeliveryGroupFilter').jqxDropDownList('getSelectedItem');
            itemPeriod = $('#letterDeliveryPeriodFilter').jqxDropDownList('getSelectedItem');
            itemSubjectMatter = $('#letterDeliverySubjectMatterFilter').jqxDropDownList('getSelectedItem');
            
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
            if(valItemSubjectMatter!==undefined){
                valItemSubjectMatter=itemSubjectMatter.value;
            }  
            var ordersSource ={
                dataFields: [
                    { name: 'dataID', type: 'int' },
                    { name: 'dataPkStudent', type: 'int' },
                    { name: 'dataStudentName', type: 'string' },
                    { name: 'dataEnrollment', type: 'string' },
                    { name: 'dataDeliveryDescription', type: 'string' },
                    { name: 'dataDeliveryStatus', type: 'string' }
                ],
                dataType: "json",
                id: "dataID",
                async: false,
                url: '../serviceStudentsGroup?view=consultGroupStay',
                root:'__ENTITIES',
                data : {
                    fkPeriod : valItemPeriod,
                    fkCareer : valItemCareer,
                    fkSemester : valItemSemester,
                    fkGroup : valItemGroup,
                    fkSubjectMatter : valItemSubjectMatter
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
            $("#tableLetterDeliveryStudentsGroup").jqxGrid({
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
                    $("#tableLetterDeliveryStudentsGroup").jqxGrid('focus');
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
                    { text: 'Alumno', align: 'center', dataField: 'dataStudentName', cellclassname: cellclass, editable: false, filterable: false},
                    { text: 'Descripción',align: 'center', cellsalign : 'center', dataField: 'dataDeliveryDescription', width: 130, cellclassname: cellclass, editable: false },
                    { text: 'Estado', align: 'center', datafield: 'dataDeliveryStatus', threestatecheckbox: true, columntype: 'checkbox', width: 100 }
                ],
                columnsresize: false
            });
            $("#tableLetterDeliveryStudentsGroup").off('cellendedit');
            $("#tableLetterDeliveryStudentsGroup").on('cellendedit', function (event) {
                // event arguments.
                var args = event.args;
                // column data field.
                var dataField = event.args.datafield;
                // row's bound index.
                var rowBoundIndex = event.args.rowindex;
                // cell value
                var value = args.value;
                // cell old value.
                var oldvalue = args.oldvalue;
                // row's data.
                var rowData = $('#tableLetterDeliveryStudentsGroup').jqxGrid('getrowdata', rowBoundIndex);
                var deliveryStatusParam ="";
                if(rowData.dataDeliveryStatus==true){
                    $("#tableLetterDeliveryStudentsGroup").jqxGrid('setcellvaluebyid', rowData.dataID, "dataDeliveryDescription", "Acreditada");
                    deliveryStatusParam="InsertCalSubjectMatterStay";
                }else if(rowData.dataDeliveryStatus==false){
                    deliveryStatusParam="UpdateCalSubjectMatterStay";
                    $("#tableLetterDeliveryStudentsGroup").jqxGrid('setcellvaluebyid', rowData.dataID, "dataDeliveryDescription", "No acreditada");
                }else{
                    $("#tableLetterDeliveryStudentsGroup").jqxGrid('setcellvaluebyid', rowData.dataID, "dataDeliveryDescription", "No entregada");
                    deliveryStatusParam="DeleteCalSubjectMatterStay";
                }
                itemPeriod = $('#letterDeliveryPeriodFilter').jqxDropDownList('getSelectedItem');
                itemSubjectMatter = $('#letterDeliverySubjectMatterFilter').jqxDropDownList('getSelectedItem');
                console.log(rowData)
                $.ajax({
                    //Send the paramethers to servelt
                    type: "POST",
                    async: false,
                    url: "../serviceCalification?"+deliveryStatusParam,
                    data:{
                        'pt_pk_study_level' : itemLevel.value,
                        'pt_pk_student' : rowData.dataPkStudent,
                        'pt_pk_subject_matter' : itemSubjectMatter.value,
                        'pt_pk_period' : itemPeriod.value 
                    },
                    beforeSend: function (xhr) {
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        //This is if exits an error with the server internal can do server off, or page not found
                        alert("Error interno del servidor");
                        $("#tableLetterDeliveryStudentsGroup").jqxGrid('setcellvaluebyid', rowData.dataID, dataField, oldvalue);
                    },
                    success: function (data_result, textStatus, jqXHR) { 
                        console.log(data_result);
                    }
                });  
            });
            $('#tableLetterDeliveryStudentsGroup').off('rowunselect');
            $('#tableLetterDeliveryStudentsGroup').on('rowunselect', function (event){
                // event arguments.
                var args = event.args;
                // row's bound index.
                var rowBoundIndex = args.rowindex;
                // row's data. The row's data object or null(when all rows are being selected or unselected with a single action). If you have a datafield called "firstName", to access the row's firstName, use var firstName = rowData.firstName;
                var rowData = args.row;
                
                if(args){
                    $("#tableLetterDeliveryStudentsGroup").jqxGrid('endcelledit', rowBoundIndex, "dataDown", false);
                }
            });
        }        
        var contextMenu = $("#contextMenu").jqxMenu({ width: 180, autoOpenPopup: false, mode: 'popup'});
        $("#tableLetterDeliveryStudentsGroup").on('contextmenu', function () {
            return false;
        });
        // handle context menu clicks.
        $("#contextMenu").on('itemclick', function (event) {
            var args = event.args;
            var rowindex = $("#tableLetterDeliveryStudentsGroup").jqxGrid('getselectedrowindex');
            var data = $('#tableLetterDeliveryStudentsGroup').jqxGrid('getrowdata', rowindex);
            if ($.trim($(args).text()) === "Llenar Formato"){
                itemPeriod = $('#letterDeliveryPeriodFilter').jqxDropDownList('getSelectedItem');
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
        $("#tableLetterDeliveryStudentsGroup").on('rowclick', function (event) {
            if (event.args.rightclick) {
                var data = $('#tableLetterDeliveryStudentsGroup').jqxGrid('getrowdata', event.args.rowindex);
                $("#tableLetterDeliveryStudentsGroup").jqxGrid('selectrow', event.args.rowindex);
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
            <div id='letterDeliveryMotiveDownFilter'></div>
        </div>
    </div>
</div>
<div style="float: left; margin-right: 5px;">
    Nivel de estudio<br>
    <div id='letterDeliveryLevelFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Carrera <br>
    <div id='letterDeliveryCareerFilter'></div>
</div>
<div id="contentHistoryPeriods" style="display: none; float: right; right: 100px; position: absolute; z-index: 10000;">
    Periodo historial <br>
    <div id='letterDeliveryPeriodHistoryFilter'></div>
</div>
<div style="float: right; margin-right: 5px; display: none">
    Periodo <br>
    <div id='letterDeliveryPeriodFilter'></div>
</div>
<br><br><br>
<div style="float: left; margin-right: 5px;">
    Cuatrimestre<br>
    <div id='letterDeliverySemesterFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Grupo<br>
    <div id='letterDeliveryGroupFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Materia<br>
    <div id='letterDeliverySubjectMatterFilter'></div>
</div>
<div style="float: left; margin-right: 5px" id="tableLetterDeliveryStudentsGroup"></div>
<div id='contextMenu'>
    <ul>
        <li id="noUsed">No en usooo!</li>
    </ul>
</div>