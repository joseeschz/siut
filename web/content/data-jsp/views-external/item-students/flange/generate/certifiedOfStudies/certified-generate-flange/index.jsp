<script>
    $(document).ready(function () {
        var itemLevel = 0;
        var itemCareer = 0;
        var itemPeriod = 0;
        createDropDownStudyLevel("#generateCertifiedLevelFilter",false);
        itemLevel = $('#generateCertifiedLevelFilter').jqxDropDownList('getSelectedItem');
        if(itemLevel!==undefined){
            createDropDownCareer( itemLevel.value ,"#generateCertifiedCareerFilter",false);
            itemCareer = $('#generateCertifiedCareerFilter').jqxDropDownList('getSelectedItem');
            createDropDownPeriod("comboActiveYear","#generateCertifiedPeriodFilter");
            itemPeriod = $('#generateCertifiedPeriodFilter').jqxDropDownList('getSelectedItem');
            if(itemPeriod!==undefined){
                if(itemCareer!==undefined){
                    loadGridStudents();
                }                
            }
            $('#generateCertifiedLevelFilter').on('change',function (event){  
                itemLevel = $('#generateCertifiedLevelFilter').jqxDropDownList('getSelectedItem');
                if(itemLevel!==undefined){
                    createDropDownCareer(itemLevel.value, "#generateCertifiedCareerFilter", true);
                    itemCareer = $('#generateCertifiedCareerFilter').jqxDropDownList('getSelectedItem');
                }else{
                    createDropDownCareer(null, "#generateCertifiedCareerFilter", true);
                }
                
            });
            $('#generateCertifiedCareerFilter').on('change',function (event){  
                var args = event.args;
                if (args) {
                    // index represents the item's index.                      
                    var index = args.index;
                    var item = args.item;
                    // get item's label and value.
                    var label = item.label;
                    var value = item.value;
                    var type = args.type; // keyboard, mouse or null depending on how the item was selected.
                    itemCareer = $('#generateCertifiedCareerFilter').jqxDropDownList('getSelectedItem');
                    itemPeriod = $('#generateCertifiedPeriodFilter').jqxDropDownList('getSelectedItem');
                    if(itemPeriod!==undefined){
                        if(itemCareer!==undefined){
                            loadGridStudents();
                        }                
                    }
                }                
            });
            $('#generateCertifiedPeriodFilter').on('change',function (event){  
                var args = event.args;
                if (args) {
                    // index represents the item's index.                      
                    var index = args.index;
                    var item = args.item;
                    // get item's label and value.
                    var label = item.label;
                    var value = item.value;
                    var type = args.type; // keyboard, mouse or null depending on how the item was selected.
                    itemCareer = $('#generateCertifiedCareerFilter').jqxDropDownList('getSelectedItem');
                    itemPeriod = $('#generateCertifiedPeriodFilter').jqxDropDownList('getSelectedItem');
                    if(itemPeriod!==undefined){
                        if(itemCareer!==undefined){
                            loadGridStudents();
                        }                
                    }
                }                
            });
        }else{
            createDropDownCareer(null ,"#generateCertifiedCareerFilter",false);
            createDropDownPeriod("comboActiveYear","#generateCertifiedPeriodFilter");
        }
        function loadSource(){
            var valItemCareer=0;
            var valItemPeriod=0;
            itemCareer = $('#generateCertifiedCareerFilter').jqxDropDownList('getSelectedItem');
            itemPeriod = $('#generateCertifiedPeriodFilter').jqxDropDownList('getSelectedItem');
            
            if(itemCareer!==undefined){
                valItemCareer=itemCareer.value;
            }
            if(itemPeriod!==undefined){
                valItemPeriod=itemPeriod.value;
            }            
            var ordersSource ={
                dataFields: [
                    { name: 'dataPkCertifiedOfStudy', type: 'int' },
                    { name: 'dataPkStudent', type: 'int' },
                    { name: 'dataName', type: 'string' },
                    { name: 'dataEnrollment', type: 'string' },
                    { name: 'dataDateRecivedES', type: 'date' }
                ],
                dataType: "json",
                id: "dataPkCertifiedOfStudy",
                async: false,
                url: '../serviceStudent?selectStudentsLetterDelivered',
                data : {
                    fkPeriod : valItemPeriod,
                    fkCareer : valItemCareer                 
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
            $("#tableCertified").jqxGrid({
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
                    $("#tableCertified").jqxGrid('focus');
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
                    { text: 'Fecha de Expedición', align: 'center', cellsalign: 'center', dataField: 'dataDateRecivedES', columntype: 'datetimeinput', cellsformat: 'd/M/yyyy', width: 150, cellclassname: cellclass, editable: true, filterable: false}
                ],
                columnsresize: false
            });
            $("#tableCertified").off('cellvaluechanged');
            $("#tableCertified").on('cellvaluechanged', function (event) {
                var args = event.args;
                var value = event.args.value;
                var dd = value.getDate();
                var mm = value.getMonth()+1;//January is 0!
                var yyyy = value.getFullYear(); 
                // @param row index.
                var rowData = $('#tableCertified').jqxGrid('getrowdata', args.rowindex);
                $.ajax({
                    //Send the paramethers to servelt
                    type: "POST",
                    async: false,
                    url: "../serviceStudent?updateDateLetterDelivery",
                    data:{
                        'pk_certified_of_study': rowData.dataPkCertifiedOfStudy,
                        'pt_field_value': yyyy+"/"+mm+"/"+dd
                    },
                    beforeSend: function (xhr) {
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        //This is if exits an error with the server internal can do server off, or page not found
                        alert("Error interno del servidor");
                    },
                    success: function (data_result, textStatus, jqXHR) { 
                        console.log(data_result);

                    }
                }); 
            });
            $('#tableCertified').off('rowunselect');
            $('#tableCertified').on('rowunselect', function (event){
                // event arguments.
                var args = event.args;
                // row's bound index.
                var rowBoundIndex = args.rowindex;
                // row's data. The row's data object or null(when all rows are being selected or unselected with a single action). If you have a datafield called "firstName", to access the row's firstName, use var firstName = rowData.firstName;
                var rowData = args.row;
                
                if(args){
                    $("#tableCertified").jqxGrid('endcelledit', rowBoundIndex, "dataCertified", false);
                }
            });
        }        
        var contextMenu = $("#contextMenu").jqxMenu({ width: 180, autoOpenPopup: false, mode: 'popup'});
        $("#tableCertified").on('contextmenu', function () {
            return false;
        });
        // handle context menu clicks.
        $("#contextMenu").on('itemclick', function (event) {
            var args = event.args;
            var rowindex = $("#tableCertified").jqxGrid('getselectedrowindex');
            var data = $('#tableCertified').jqxGrid('getrowdata', rowindex);
            itemCareer = $('#generateCertifiedCareerFilter').jqxDropDownList('getSelectedItem');
            if ($.trim($(args).text()) === "Imprimir Certificado"){
                $.ajax({
                    type: "POST",
                    async: false,
                    url: "../../content/data-jr/certifiedOfStudies/index.jsp?sessionCertifiedReport",
                    data: {
                        'pt_enrollment': data.dataEnrollment,
                        'pt_pk_career': itemCareer.value
                    },
                    beforeSend: function (xhr) {
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        alert("Error interno del servidor");
                    },
                    success: function (data, textStatus, jqXHR) {
                        var iframe = $('<iframe style="width: 1185px; height: 810px;">');
                        iframe.attr('src','../../content/data-jr/certifiedOfStudies/index.jsp');
                        $('#contentPDF').html(iframe);
                        $("#popupWindowDoc").jqxWindow('show');
                    }
                });                
            }
        });
        $("#tableCertified").on('rowclick', function (event) {
            if (event.args.rightclick) {
                var data = $('#tableCertified').jqxGrid('getrowdata', event.args.rowindex);
                $("#tableCertified").jqxGrid('selectrow', event.args.rowindex);
                var scrollTop = $(window).scrollTop();
                var scrollLeft = $(window).scrollLeft();
                if(data.dataDateRecivedES===""){
                    $("#contextMenu").jqxMenu('disable', 'generateCertified', true);
                }else{
                    $("#contextMenu").jqxMenu('disable', 'generateCertified', false);
                }
                contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                return false;
            }
        });
        
        $("#popupWindowMotiveCertified").jqxWindow({ 
            width: 400,
            height: 350, 
            resizable: false, 
            isModal: true, 
            autoOpen: false, 
            modalOpacity: 0.7 
        });
    });
</script>
<div id="popupWindowMotiveCertified">
    <div>Detalle de baja</div>
    <div style="overflow: hidden;" id="contentPDF">
        <div style="float: left; margin-right: 5px;">
            Motivo<br>
            <div id='generateCertifiedMotiveCertifiedFilter'></div>
        </div>
    </div>
</div>
<div style="float: left; margin-right: 5px;">
    Nivel de estudio<br>
    <div id='generateCertifiedLevelFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Carrera <br>
    <div id='generateCertifiedCareerFilter'></div>
</div>
<div style="float: right; margin-right: 5px;">
    Periodo <br>
    <div id='generateCertifiedPeriodFilter'></div>
</div>
<br><br><br>
<div style="float: left; margin-right: 5px" id="tableCertified"></div>
<div id='contextMenu'>
    <ul>
        <li id="generateCertified">Imprimir Certificado</li>
    </ul>
</div>