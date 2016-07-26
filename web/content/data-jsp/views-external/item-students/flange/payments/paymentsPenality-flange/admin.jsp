<style type="text/css">
    .text-input
    {
        height: 21px;
        width: 150px;
    }
    .register-table
    {
        margin-top: 10px;
        margin-bottom: 10px;
    }
    .register-table td, 
    .register-table tr
    {
        margin: 0px;
        padding: 6px;
        border-spacing: 0px;
        border-collapse: collapse;
        font-family: Verdana;
        font-size: 12px;
    }
    h3 
    {
        display: inline-block;
        margin: 0px;
    }
</style>
<script>
    $(document).ready(function () {
        var itemSemester = null;
        var itemCategoryMasterHeader = null;
        var itemFormatHeader = null;
        var itemPeriod= null;
        var itemPeriodTemp= null;
        var itemCategoryMaster = null;
        var itemFormatPayment = null;
        function loadGridStudentsPaid(){
            var dataAdapter = new $.jqx.dataAdapter(loadSourceStudentsPenalityPaymentsHeader());  
            var tooltiprenderer = function (element) {
                $(element).jqxTooltip({position: 'mouse', content: $(element).text() });
            };
            $("#tablePaymentsPenalityHeader").jqxDataTable({
                width: 900,
                height: 350,
                selectionMode: "singlerow",
                localization: getLocalization("es"),
                source: dataAdapter,
                pageable: true,
                editable: false,
                altRows: true,
                filterable: true,
                ready: function(){
                    $("#tablePaymentsPenalityHeader").jqxGrid('focus');
                },
                columns: [
                    { text: '#', filterable: false, align: 'center', cellsalign: 'center', dataField: 'dataProgresivNumber', width: 40, rendered: tooltiprenderer },
                    { text: 'Matrícula', align: 'center', dataField: 'dataEnrollment', width: 120, rendered: tooltiprenderer },
                    { text: 'Alumno', align: 'center', dataField: 'dataNameStudent', width: 250, rendered: tooltiprenderer},
                    { text: 'Nivel de estudio', align: 'center', dataField: 'dataNameLevel', cellsalign: 'center', width: 150, rendered: tooltiprenderer},
                    { text: 'Fecha de Recibido', align: 'center', cellsalign: 'center', dataField: 'dataDatePayment', width: 130, rendered: tooltiprenderer},
                    { text: 'Carrera', align: 'center', dataField: 'dataNameCareer', width: 350, rendered: tooltiprenderer}
                ],
                columnsResize: false
            });
        }    
        
        function payConcept(params){
            console.log("Opening Window");
            var records = undefined;
            var dataAdapter = new $.jqx.dataAdapter(loadSourceStudentInfo(params.enrollment), {
                loadComplete: function () {
                    // get data records.
                    records = dataAdapter.records;
                }
            });
            dataAdapter.dataBind();            
            if(records){
                loadDataToForm(records[0]);                
            }            
        }
        function createGridConcepts(params){
            console.log("Making Grid Concepts...");
            var records = undefined;
            var dataAdapter = new $.jqx.dataAdapter(loadSourceStudentPenaltyPaymentsDetail(params.dataPkPeriod, params.dataFkSemester, params.dataFkCategoryMaster, params.dataFkFormatType, params.dataFkStudent), {
                loadComplete: function () {
                    // get data records.
                    records = dataAdapter.records;
                }
            });    
            itemFormatPayment = $('#paymentsPenaltytypeFormatHeaderFilter').jqxDropDownList('getSelectedItem');
            if(itemFormatPayment.value==1){
                $("#labelDate").text("FECHA DE RECIBIDO");
            }else{
                $("#labelDate").text("FECHA DE PAGO");
            }
            var cellbeginedit = function (row, datafield, columntype, value) {
                itemFormatPayment = $('#paymentsPenaltytypeFormatHeaderFilter').jqxDropDownList('getSelectedItem');
                if(itemFormatPayment.value==1){
                    var data = $('#contentDinamic').jqxGrid('getrowdata', row);
                    if(data.dataPkTypeConcept==1){
                        if(data.dataStatusPayFlag==="RECIBIDO" || data.dataStatusPayFlag==="PAGADO") {
                            return false;
                        }else{
                            if(data.dataStatusPayFlag==="NO" && datafield==="dataReferenceNumber") {
                                return false;
                            }
                            if(datafield==="dataCant" ){
                                return false;
                            }
                        }

                    }else{
                        if(data.dataStatusPayFlag==="NO" && (datafield==="dataReferenceNumber" || datafield==="dataCant")) {
                            return false;
                        }else{
                            if(data.dataStatusPayFlag==="SI" && datafield==="dataStatusPayFlag"){
                                return true;
                            }
                        }
                    }
                }else{
                    var data = $('#contentDinamic').jqxGrid('getrowdata', row);
                    if(data.dataPkTypeConcept==1){
                        if(data.dataStatusPayFlag==="RECIBIDO" || data.dataStatusPayFlag==="PAGADO") {
                            return false;
                        }else{
                            if(data.dataStatusPayFlag==="NO" && (datafield==="dataReferenceNumber" || datafield==="dataCant")) {
                                return false;
                            }
                            if(data.dataStatusPayFlag==="SI" && datafield==="dataReferenceNumber") {
                                return false;
                            }
                            if(datafield==="dataCant" ){
                                return false;
                            }
                        }
                    }else{
                        if(data.dataStatusPayFlag==="NO" && (datafield==="dataReferenceNumber" || datafield==="dataCant")) {
                            return false;
                        }else{
                            if(data.dataStatusPayFlag==="SI" && (datafield==="dataReferenceNumber")){
                                return false;
                            }
                            if(data.dataStatusPayFlag==="SI" && datafield==="dataStatusPayFlag"){
                                return true;
                            }
                        }
                    }
                }                
            };
            var cellsrenderer = function (row, column, value, defaultHtml) {
                var data = $('#contentDinamic').jqxGrid('getrowdata', row);
                itemFormatPayment = $('#paymentsPenaltytypeFormatHeaderFilter').jqxDropDownList('getSelectedItem');
                if(data.dataPkTypeConcept==1){
                    if(data.dataStatusPayFlag==="RECIBIDO" || data.dataStatusPayFlag==="PAGADO") {
                        var element = $(defaultHtml);
                        element.css('color', '#6b6bff');
                        return element[0].outerHTML;
                    }else{
                        if(column==="dataCant"){
                            var element = $(defaultHtml);
                            element.css('color', '#969696');
                            return element[0].outerHTML;
                        }
                        if(data.dataStatusPayFlag==="NO" && (column==="dataStatusPayFlag" || column==="dataReferenceNumber" || column==="dataNamePenalty" || column==="dataTariff" || column==="dataSubTotal") ) {
                            var element = $(defaultHtml);
                            element.css('color', '#04BD00');
                            return element[0].outerHTML;
                        }
                        if(itemFormatPayment.value==2){
                            if(data.dataStatusPayFlag==="SI" && (column==="dataReferenceNumber")){
                                var element = $(defaultHtml);
                                element.css('color', '#969696');
                                return element[0].outerHTML;
                            }
                        }
                    }                    
                }else{
                    if(data.dataStatusPayFlag==="NO" && (column==="dataStatusPayFlag" || column==="dataReferenceNumber" || column==="dataNamePenalty" || column==="dataTariff" || column==="dataCant" || column==="dataSubTotal") ) {
                        var element = $(defaultHtml);
                        element.css('color', '#04BD00');
                        return element[0].outerHTML;
                    }
                    if(itemFormatPayment.value==2){
                        if(data.dataStatusPayFlag==="SI" && (column==="dataReferenceNumber")){
                            var element = $(defaultHtml);
                            element.css('color', '#969696');
                            return element[0].outerHTML;
                        }
                    }
                }                
                return defaultHtml;
            };
            var tooltiprenderer = function (element) {
                $(element).jqxTooltip({position: 'mouse', content: $(element).text() });
            };
            $(popupWindowPay).off('keydown');
            $("#cashReceived").off('change');
            $("#cashReceived").off('focusout');
            setTimeout(function (){
                $("#cashReceived").jqxNumberInput({disabled: true, spinButtons: true });
            },200);
            
            $("#validateButton").jqxButton({disabled: true});
            $("#totalToPay").text("$0.00");
            $('#cashReceived').jqxNumberInput('clear');
            $("#changeReturn").text("$_.__");
            
            var statusLabelText = "";
            itemFormatPayment = $('#paymentsPenaltytypeFormatHeaderFilter').jqxDropDownList('getSelectedItem');
            var heightGrid = 0;
            if(itemFormatPayment.value==1){
                statusLabelText = ("ESTADO DE RECIBIDO");
                heightGrid = 253;
            }else{
                statusLabelText = ("ESTADO DE PAGO");
                heightGrid = 200;
            }
            $("#contentDinamic").jqxGrid({
                width: 900,
                height : heightGrid,
                source: dataAdapter,
                editable: true,
                clipboard: false,
                selectionmode: 'singlecell',
                editmode: 'selectedcell',
                columns: [
                    { text: statusLabelText, datafield: 'dataStatusPayFlag', align:"center", cellsalign:"center", columntype: 'custom', width: 150, cellbeginedit: cellbeginedit, cellsrenderer: cellsrenderer, tooltiprenderer:tooltiprenderer,
                        createeditor: function (row, cellvalue, editor, cellText, width, height) {
                            var value;
                            if(cellvalue==="SI"){
                                value = true;
                            }else{
                                value = false;
                            }
                            editor.jqxSwitchButton({ 
                                height: height, 
                                width: width,  
                                checked: false,
                                onLabel:'SI',
                                offLabel:'NO'
                            });
                        },
                        initeditor: function (row, cellvalue, editor, celltext, pressedkey) {
                            // set the editor's current value. The callback is called each time the editor is displayed.
                            if(cellvalue==="SI"){
                                editor.jqxSwitchButton({ checked: true});
                            }else{
                                editor.jqxSwitchButton({ checked: false});
                            }
                        },
                        geteditorvalue: function (row, cellvalue, editor) {
                            // return the editor's value.
                            var valueEditor = editor.val();
                            if(valueEditor){
                                return "SI";
                            }else{
                                return "NO";
                            }                            
                        }
                    },
                    { text: 'REFERENCIA', columntype: 'textbox', align:"center", cellsalign:"center", datafield: 'dataReferenceNumber', width: 240, cellbeginedit: cellbeginedit, cellsrenderer: cellsrenderer, tooltiprenderer:tooltiprenderer ,
                        validation: function (cell, value) {
                            var data = $('#contentDinamic').jqxGrid('getrowdata', cell.row);
                            if (data.dataStatusPayFlag==="SI" && value==="") {
                                return { 
                                    result: false, 
                                    message: "Si estado de pago es SI debes de establecer una referencia" 
                                };
                            }
                            return true;
                        }
                    },
                    { text: 'CONCEPTO DESCRIPCIÓN', editable: false, align:"center", datafield: 'dataNamePenalty', cellsrenderer: cellsrenderer, tooltiprenderer:tooltiprenderer },
                    { text: 'MONTO', editable: false, align:"center", datafield: 'dataTariff', width: 80,  cellsformat: 'c2', cellsalign:"right", cellsrenderer: cellsrenderer,  tooltiprenderer:tooltiprenderer},
                    { text: 'CANTIDAD', datafield: 'dataCant', align:"center", width: 75, cellsalign:"center", cellbeginedit: cellbeginedit, cellsrenderer: cellsrenderer, tooltiprenderer:tooltiprenderer, columntype: 'numberinput',
                        validation: function (cell, value) {
                            if (value <= 0) {
                                return { result: false, message: "La cantidad debe de ser mayor a 0" };
                            }
                            return true;
                        },
                        createeditor: function (row, cellvalue, editor) {
                            editor.jqxNumberInput({ decimalDigits: 0, digits: 3, min:1, max:50 });
                        }
                    },
                    { text: 'SUBTOTAL', editable: false, align:"center", datafield: 'dataSubTotal', width: 80, cellsformat: 'c2', columntype: 'numberinput', cellsrenderer: cellsrenderer, tooltiprenderer:tooltiprenderer  }
                ]
            });  
            itemFormatPayment = $('#paymentsPenaltytypeFormatHeaderFilter').jqxDropDownList('getSelectedItem');
            if(itemFormatPayment.value==1){
                $("#conditionalPayment").hide();
            }else{
                $("#conditionalPayment").show();
            }
            popupWindowPay.jqxWindow('open');
            $("#contentDinamic").off('cellvaluechanged');
            $("#contentDinamic").on('cellvaluechanged', function (event) {
                // event arguments.
                var args = event.args;
                // column data field.
                var datafield = event.args.datafield;
                // row's bound index.
                var rowBoundIndex = args.rowindex;
                // new cell value.
                var value = args.newvalue;
                // old cell value.
                var oldvalue = args.oldvalue;
                itemFormatPayment = $('#paymentsPenaltytypeFormatHeaderFilter').jqxDropDownList('getSelectedItem'); 
                
                if(datafield==="dataCant"){
                    var valueDataTariff = $('#contentDinamic').jqxGrid('getcellvalue', rowBoundIndex, "dataTariff");
                    var valueTemp = parseFloat(value*valueDataTariff);
                    $("#contentDinamic").jqxGrid('setcellvalue', rowBoundIndex, "dataSubTotal", valueTemp);
                }
                if(datafield==="dataStatusPayFlag" && value==="NO"){
                    $("#contentDinamic").jqxGrid('setcellvalue', rowBoundIndex, "dataReferenceNumber", "");
                    $("#contentDinamic").jqxGrid('setcellvalue', rowBoundIndex, "dataCant", 0);
                }
                if(datafield==="dataStatusPayFlag" && value==="SI"){
                    if(itemFormatPayment.value==1){                        
                        $("#contentDinamic").jqxGrid('begincelledit', rowBoundIndex, "dataReferenceNumber");
                    }else{
                        $("#contentDinamic").jqxGrid('setcellvalue', rowBoundIndex, "dataReferenceNumber", "-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-");
                    }
                    $("#contentDinamic").jqxGrid('setcellvalue', rowBoundIndex, "dataCant", 1);
                    
                }
                var rows = $('#contentDinamic').jqxGrid('getrows');
                var yesStatus = 0;
                var totalToPayment = 0;
                for(var i=0; i<rows.length;i++){
                    if(rows[i].dataStatusPayFlag==="SI"){
                        yesStatus = yesStatus+1;
                        totalToPayment = totalToPayment + parseFloat(rows[i].dataSubTotal);
                    }
                }
                if(yesStatus>0){
                    $("#cashReceived").jqxNumberInput({disabled: false});
                    $("#validateButton").jqxButton({disabled:false});
                    $("#totalToPay").text("$"+parseFloat(totalToPayment).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,'));
                }else{
                    $("#cashReceived").jqxNumberInput({disabled: true});
                    $("#validateButton").jqxButton({disabled: true});
                }
            });
            var rowCellFlagSwitch = undefined;
            function onEventKeyUp(){
                $("#contentDinamic").on("keyup", function (event){
                    if(rowCellFlagSwitch){
                        if((event.keyCode && event.keyCode==37)  || (event.which && event.which==37)){
                            $("#customeditorcontentDinamicdataStatusPayFlag_"+rowCellFlagSwitch).jqxSwitchButton('check');
                        }
                        if((event.keyCode && event.keyCode==39)  || (event.which && event.which==39)){
                            $("#customeditorcontentDinamicdataStatusPayFlag_"+rowCellFlagSwitch).jqxSwitchButton('uncheck');
                        }
                    }
                });
            }
            $("#contentDinamic").off("keyup");
            onEventKeyUp();
            $("#contentDinamic").off('cellbeginedit');
            $("#contentDinamic").on('cellbeginedit', function (event) {
                // event arguments.
                var args = event.args;
                // column data field.
                var dataField = event.args.datafield;
                // row's bound index.
                var rowBoundIndex = event.args.rowindex;
                // cell value
                var value = args.value;
                // row's data.
                var rowData = args.row;
                rowCellFlagSwitch = rowBoundIndex;
                onEventKeyUp();
            });
            $("#contentDinamic").off('cellendedit');
            $("#contentDinamic").on('cellendedit', function (event) {
                // event arguments.
                var args = event.args;
                // column data field.
                var dataField = event.args.datafield;
                // row's bound index.
                var rowBoundIndex = event.args.rowindex;
                // cell value
                var value = args.value;
                // row's data.
                var rowData = args.row;
                rowCellFlagSwitch = undefined;
                $("#contentDinamic").off("keyup");
            });  
            
            $("#cashReceived").off('focusout');
            $("#cashReceived").on('change', function (event){
                validateChangeReturn();
            });
            $("#cashReceived").off('focusout');
            $("#cashReceived").focusout(function (event){
                validateChangeReturn();
            });
            $("#validateButton").off('click');
            $("#validateButton").click(function (){
                if(!$("#validateButton").jqxButton('disabled')){
                    itemFormatPayment = $('#paymentsPenaltytypeFormatHeaderFilter').jqxDropDownList('getSelectedItem');
                    
                    var rows = $('#contentDinamic').jqxGrid('getrows');
                    var referenceStatus = 0;
                    for(var i=0; i<rows.length;i++){
                        if(rows[i].dataStatusPayFlag==="SI"){    
                            if(rows[i].dataReferenceNumber==="" || rows[i].dataReferenceNumber==null){
                                referenceStatus = referenceStatus+1;
                                $("#contentDinamic").jqxGrid('begincelledit', i, "dataReferenceNumber");
                                break;
                            }
                        }
                    }
                    if(referenceStatus==0){
                        $('#okConfirm').jqxButton({width: 130});
                        $("#okConfirm").val("SI");
                        $("#okConfirm").show();
                        $("#closeButtonConfirm").show();                        
                        if(itemFormatPayment.value==1){                            
                            $("#messageStatusPayment").text("Recibir formatos ahora");
                            popupWindowConfirmPayment.jqxWindow('open');
                        }else{
                            if(validateChangeReturn()){
                                $("#messageStatusPayment").text("Realizar pago ahora");
                                popupWindowConfirmPayment.jqxWindow('open');
                            }
                        }
                            
                    }
                }            
            });
            $("#okConfirm").off('click');
            $("#okConfirm").on('click', function (){
                if(!$("#okConfirm").jqxButton('disabled')){
                    if($(this).val()==="SALIR"){
                        popupWindowConfirmPayment.jqxWindow('close');
                        popupWindowPay.jqxWindow('close');
                        loadGridStudentsPaid();
                    }else if($(this).val()==="GENERAR COMPROBANTE Y SALIR" ){
                        var pt_pk_student_payment_penality = $(this).attr("pt_pk_student_payment_penality");
                        popupWindowPay.jqxWindow('close');
                        popupWindowConfirmPayment.jqxWindow('close');
                        loadGridStudentsPaid();
                        generateReport(pt_pk_student_payment_penality);                        
                    }else if($(this).val()==="SI" ){
                        registerPaymentsHeader();
                    }                    
                }        
            });
            var validateChangeReturn = function (){
                var validate = false;
                var value = parseFloat($("#cashReceived").val());
                var totalToPayment = $("#totalToPay").text().replace("$","");
                var totalToPayment =  totalToPayment.replace(",","");
                totalToPayment = parseFloat(totalToPayment);
                if(totalToPayment>value){
                    $('#cashReceived').jqxTooltip({ content: '<span style="color:red">El monto ingresado no puede ser menor al total</span>' });
                    $('#cashReceived').off('click');
                    $("#cashReceived").jqxTooltip('open');
                    $("#changeReturn").text("$_.__");
                }else{
                    $("#cashReceived").jqxTooltip('close');
                    var change = value - totalToPayment;
                    $("#changeReturn").text("$"+parseFloat(change).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,'));
                    validate=true;
                }
                return validate;
            };
        }
        function loadDataToForm(data){
            $("#labelEnrollment").text(data.dataEnrollment);
            $("#hidenPkStudent").val(data.dataPkStudent);
            $("#labelStudentName").text(data.dataName);
            $("#labelStudyLevel").text(data.dataNameLevel);
            $("#labelCareer").text(data.dataNameCareer);
            
            createDropDownSemester(data.dataPkLevelStudy, '#paySemesterFilter', true);
            itemSemester = $('#paySemesterFilter').jqxDropDownList('getSelectedItem');
            
            createDropDownPeriodActive('comboActiveYear', '#payPeriodTempFilter');
            itemPeriodTemp = $('#payPeriodTempFilter').jqxDropDownList('getSelectedItem');
            
            $("#dateInput").jqxDateTimeInput({ width: '200px', height: '27px', disabled: true });
            
            createDropDownCategoryMasterPayment("#paymentsPenaltyCategoryMasterHeaderFilter");
            itemCategoryMaster = $('#paymentsPenaltyCategoryMasterHeaderFilter').jqxDropDownList('getSelectedItem');
            
            createDropDownFormatPayment("#paymentsPenaltytypeFormatHeaderFilter");
            itemFormatPayment = $('#paymentsPenaltytypeFormatHeaderFilter').jqxDropDownList('getSelectedItem'); 
            
            var params = {
                dataPkPeriod:itemPeriodTemp.value,
                dataFkSemester:itemSemester.value,
                dataFkStudent : data.dataPkStudent,
                dataFkCategoryMaster : itemCategoryMaster.value,
                dataFkFormatType : itemFormatPayment.value
            };
            createGridConcepts(params);
            
            $("#paySemesterFilter").off('change');
            $("#paySemesterFilter").on('change', function (event){  
                var args = event.args;
                if (args){
                    // index represents the item's index.                      
                    var index = args.index;
                    var item = args.item;
                    // get item's label and value.
                    var label = item.label;
                    var value = item.value;
                    var type = args.type; // keyboard, mouse or null depending on how the item was selected.  
                    itemSemester = $('#paySemesterFilter').jqxDropDownList('getSelectedItem');
                    itemPeriodTemp = $('#payPeriodTempFilter').jqxDropDownList('getSelectedItem');
                    itemCategoryMaster = $('#paymentsPenaltyCategoryMasterHeaderFilter').jqxDropDownList('getSelectedItem');
                    itemFormatPayment = $('#paymentsPenaltytypeFormatHeaderFilter').jqxDropDownList('getSelectedItem');
                    var params = {
                        dataPkPeriod:itemPeriodTemp.value,
                        dataFkSemester:itemSemester.value,
                        dataFkStudent : data.dataPkStudent,
                        dataFkCategoryMaster : itemCategoryMaster.value,
                        dataFkFormatType : itemFormatPayment.value
                    };
                    createGridConcepts(params);
                }                
            });
            $("#payPeriodTempFilter").off('change');
            $("#payPeriodTempFilter").on('change',function (event){  
                var args = event.args;
                if (args){
                    // index represents the item's index.                      
                    var index = args.index;
                    var item = args.item;
                    // get item's label and value.
                    var label = item.label;
                    var value = item.value;
                    var type = args.type; // keyboard, mouse or null depending on how the item was selected.  
                    itemSemester = $('#paySemesterFilter').jqxDropDownList('getSelectedItem');
                    itemPeriodTemp = $('#payPeriodTempFilter').jqxDropDownList('getSelectedItem');
                    itemCategoryMaster = $('#paymentsPenaltyCategoryMasterHeaderFilter').jqxDropDownList('getSelectedItem');
                    itemFormatPayment = $('#paymentsPenaltytypeFormatHeaderFilter').jqxDropDownList('getSelectedItem');
                    var params = {
                        dataPkPeriod:itemPeriodTemp.value,
                        dataFkSemester:itemSemester.value,
                        dataFkStudent : data.dataPkStudent,
                        dataFkCategoryMaster : itemCategoryMaster.value,
                        dataFkFormatType : itemFormatPayment.value
                    };
                    createGridConcepts(params);
                }                
            });
            
            $("#paymentsPenaltyCategoryMasterHeaderFilter").off('change');
            $("#paymentsPenaltyCategoryMasterHeaderFilter").on('change', function (event){  
                var args = event.args;
                if (args){
                    // index represents the item's index.                      
                    var index = args.index;
                    var item = args.item;
                    // get item's label and value.
                    var label = item.label;
                    var value = item.value;
                    var type = args.type; // keyboard, mouse or null depending on how the item was selected.  
                    itemSemester = $('#paySemesterFilter').jqxDropDownList('getSelectedItem');
                    itemPeriodTemp = $('#payPeriodTempFilter').jqxDropDownList('getSelectedItem');
                    itemCategoryMaster = $('#paymentsPenaltyCategoryMasterHeaderFilter').jqxDropDownList('getSelectedItem');
                    itemFormatPayment = $('#paymentsPenaltytypeFormatHeaderFilter').jqxDropDownList('getSelectedItem');
                    var params = {
                        dataPkPeriod:itemPeriodTemp.value,
                        dataFkSemester:itemSemester.value,
                        dataFkStudent : data.dataPkStudent,
                        dataFkCategoryMaster : itemCategoryMaster.value,
                        dataFkFormatType : itemFormatPayment.value
                    };
                    createGridConcepts(params);
                }                
            });
            
            $("#paymentsPenaltytypeFormatHeaderFilter").off('change');
            $("#paymentsPenaltytypeFormatHeaderFilter").on('change', function (event){  
                var args = event.args;
                if (args){
                    // index represents the item's index.                      
                    var index = args.index;
                    var item = args.item;
                    // get item's label and value.
                    var label = item.label;
                    var value = item.value;
                    var type = args.type; // keyboard, mouse or null depending on how the item was selected.  
                    itemSemester = $('#paySemesterFilter').jqxDropDownList('getSelectedItem');
                    itemPeriodTemp = $('#payPeriodTempFilter').jqxDropDownList('getSelectedItem');
                    itemCategoryMaster = $('#paymentsPenaltyCategoryMasterHeaderFilter').jqxDropDownList('getSelectedItem');
                    itemFormatPayment = $('#paymentsPenaltytypeFormatHeaderFilter').jqxDropDownList('getSelectedItem');
                    var params = {
                        dataPkPeriod:itemPeriodTemp.value,
                        dataFkSemester:itemSemester.value,
                        dataFkStudent : data.dataPkStudent,
                        dataFkCategoryMaster : itemCategoryMaster.value,
                        dataFkFormatType : itemFormatPayment.value
                    };
                    createGridConcepts(params);
                }                
            });
        };
        function clearData(){
            $("#labelEnrollment").text("");
            $("#labelStudentName").text("");
            $("#labelStudyLevel").text("");
            $("#labelCareer").text("");
        }
        
        function loadSourceStudentPenaltyPaymentsPaidDetailByHeader(pk_student_payment_penality_header){            
            var ordersSource ={
                dataFields: [
                    { name: 'dataProgresivNumber', type: 'int' },
                    { name: 'dataPkStudentPenaltyPaymentDetail', type: 'int' },
                    { name: 'dataAmountPenalty', type: 'double' },
                    { name: 'dataMotiveJustify', type: 'string' },
                    { name: 'dataReferenceNumber', type: 'string' },
                    { name: 'dataStatusJustify', type: 'string' },
                    { name: 'dataStatusPay', type: 'string' },
                    { name: 'dataPkTypeConcept', type: 'string' },
                    { name: 'dataPkTypeFormat', type: 'string' },
                    { name: 'dataUnique', type: 'string' },
                    { name: 'dataPkStudent', type: 'int' },
                    { name: 'dataPkSemester', type: 'int' },
                    { name: 'dataNameSemester', type: 'string' },
                    { name: 'dataPkPeriod', type: 'int' },
                    { name: 'dataNamePeriod', type: 'string' },
                    { name: 'dataPkStudentPaymentPenalty', type: 'int' },
                    { name: 'dataPkPaymentPenaltyType', type: 'int' },
                    { name: 'dataPkCategory', type: 'int' },
                    { name: 'dataNamePenalty', type: 'string' },
                    { name: 'dataTariff', type: 'double' }
                ],
                dataType: "json",
                id: "dataPkStudentPenaltyPaymentDetail",
                async: false,
                root: "__ENTITIES",
                url: '../serviceStudentsPenaltyPaymentsDetail?view=viewHeader',
                data : {
                    pk_student_payment_penality_header : pk_student_payment_penality_header                  
                },
                deleteRow: function (rowID, commit) {
                    // synchronize with the server - send delete command
                    // call commit with parameter true if the synchronization with the server is successful 
                    // and with parameter false if the synchronization failed.
                    $.ajax({
                        //Send the paramethers to servelt
                        type: "POST",
                        async: false,
                        url: "../serviceStudentsPenaltyPaymentsDetail?delete",
                        data:{
                            'pt_pk_student_penality_payment_detail':rowID
                        },
                        beforeSend: function (xhr) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //This is if exits an error with the server internal can do server off, or page not found
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) {
                            var rows = $("#gridPaymentDetail").jqxDataTable('getRows');
                            if(rows.length==1){
                                $("#tablePaymentsPenalityHeader").jqxDataTable('updateBoundData');
                                commit(true);
                                $("#gridPaymentDetail").jqxDataTable('updateBoundData');
                                popupWindowPaymentDetail.jqxWindow('close');
                            }else{
                                commit(true);
                                $("#gridPaymentDetail").jqxDataTable('updateBoundData');
                            }
                        }
                    });
                }
            };
            return ordersSource;
        }
        
        function loadSourceStudentPenaltyPaymentsDetail(pt_fkPeriod, pt_fkSemester, pt_fkCategoryMaster, pt_fkTypeFormat, pt_fkStudent){            
            var ordersSource ={
                dataFields: [
                    { name: 'dataProgresivNumber', type: 'int' },
                    { name: 'dataPkStudentPenaltyPaymentDetail', type: 'int' },
                    { name: 'dataAmountPenalty', type: 'number' },
                    { name: 'dataMotiveJustify', type: 'string' },
                    { name: 'dataReferenceNumber', type: 'string' },
                    { name: 'dataStatusJustify', type: 'string' },
                    { name: 'dataStatusPay', type: 'string' },
                    { name: 'dataStatusPayFlag', type: 'string' },
                    { name: 'dataCant', type: 'int' },
                    { name: 'dataPkTypeConcept', type: 'string' },
                    { name: 'dataNameConcept', type: 'string' },
                    { name: 'dataPkTypeFormat', type: 'string' },
                    { name: 'dataNameFormat', type: 'string' },
                    { name: 'dataUnique', type: 'string' },
                    { name: 'dataPkStudent', type: 'int' },
                    { name: 'dataPkSemester', type: 'int' },
                    { name: 'dataNameSemester', type: 'string' },
                    { name: 'dataPkPeriod', type: 'int' },
                    { name: 'dataNamePeriod', type: 'string' },
                    { name: 'dataPkStudentPaymentPenalty', type: 'int' },
                    { name: 'dataPkPaymentPenaltyType', type: 'int' },
                    { name: 'dataPkCategory', type: 'int' },
                    { name: 'dataNamePenalty', type: 'string' },
                    { name: 'dataTariff', type: 'number' },
                    { name: 'dataSubTotal', type: 'number' }
                ],
                dataType: "json",
                id: "dataPkPaymentPenaltyType",
                async: false,
                root: "__ENTITIES",
                url: '../serviceStudentsPenaltyPaymentsDetail?view',
                data : {
                    pt_fkPeriod : pt_fkPeriod ,
                    pt_fkSemester : pt_fkSemester,
                    pt_fkStudent : pt_fkStudent,
                    pt_fkCategoryMaster : pt_fkCategoryMaster,
                    pt_fkTypeFormat : pt_fkTypeFormat
                }
            };
            return ordersSource;
        }
        
        function loadSourceStudentInfo(enrollment){            
            var ordersSource ={
                dataFields: [
                    { name: 'dataProgresivNumber', type: 'int' },
                    { name: 'dataPkStudent', type: 'string' },
                    { name: 'dataEnrollment', type: 'string' },
                    { name: 'dataName', type: 'string' },
                    { name: 'dataPkLevelStudy', type: 'int' },
                    { name: 'dataNameLevel', type: 'string' },
                    { name: 'dataPkCareer', type: 'int' },
                    { name: 'dataNameCareer', type: 'string' }
                ],
                dataType: "json",
                id: "dataPkStudent",
                async: false,
                url: '../serviceStudent?selectStudentPayment',
                data : {
                    enrollment : enrollment                    
                }
            };
            return ordersSource;
        }
        
        function loadSourceStudentsPenalityPaymentsHeader(){      
            itemPeriod = $('#payPeriodHeaderFilter').jqxDropDownList('getSelectedItem'); 
            itemCategoryMasterHeader = $('#categoryMasterHeaderFilter').jqxDropDownList('getSelectedItem'); 
            itemFormatHeader = $('#typeFormatHeaderFilter').jqxDropDownList('getSelectedItem'); 
            var ordersSource ={
                dataFields: [
                    { name: 'dataProgresivNumber', type: 'int' },
                    { name: 'dataPkPaymentPanalty', type: 'int' },
                    { name: 'dataDatePayment', type: 'string' },
                    { name: 'dataUnique', type: 'string' },
                    { name: 'dataPkCaregoryPayment', type: 'int' },
                    { name: 'dataPkTypeConcept', type: 'int' },
                    { name: 'dataPkTypeFormat', type: 'int' },
                    { name: 'dataStatusPayment', type: 'string' },
                    { name: 'dataPkStudent', type: 'int' },
                    { name: 'dataNameStudent', type: 'string' },
                    { name: 'dataEnrollment', type: 'string' },
                    { name: 'dataPkStudyLevel', type: 'int' },
                    { name: 'dataNameLevel', type: 'string' },
                    { name: 'dataPkCareer', type: 'int' },
                    { name: 'dataNameAbbreviated', type: 'string' },
                    { name: 'dataNameCareer', type: 'string' },
                    { name: 'dataPkSemester', type: 'int' },
                    { name: 'dataNameSemester', type: 'string' },
                    { name: 'dataPkPeriod', type: 'int' },
                    { name: 'dataNamePeriod', type: 'string' }
                ],
                dataType: "json",
                root: "__ENTITIES",
                id: "dataPkPaymentPanalty",
                async: false,
                url: '../serviceStudentsPenaltyPayments?view',
                data : {
                    pt_fkPeriod : itemPeriod.value,
                    pt_fkTypeFormat : itemFormatHeader.value,
                    pt_fkCategoryMaster : itemCategoryMasterHeader.value
                }
            };
            return ordersSource;
        }
        createDropDownSemester(1, '#paySemesterFilter', false);
        itemSemester = $('#paySemesterFilter').jqxDropDownList('getSelectedItem');

        createDropDownPeriodActive('comboActiveYear', '#payPeriodHeaderFilter');
        itemPeriod = $('#payPeriodHeaderFilter').jqxDropDownList('getSelectedItem'); 
        
        createDropDownCategoryMasterPayment("#categoryMasterHeaderFilter");
        itemCategoryMasterHeader = $('#categoryMasterHeaderFilter').jqxDropDownList('getSelectedItem'); 
        
        createDropDownFormatPayment("#typeFormatHeaderFilter");
        itemFormatPayment = $('#typeFormatHeaderFilter').jqxDropDownList('getSelectedItem'); 
        
        if(itemPeriod!=null || itemPeriod!= undefined){
            $("#payPeriodHeaderFilter").on('change',function (event){  
                var args = event.args;
                if (args){
                    // index represents the item's index.                      
                    var index = args.index;
                    var item = args.item;
                    // get item's label and value.
                    var label = item.label;
                    var value = item.value;
                    var type = args.type; // keyboard, mouse or null depending on how the item was selected.  
                    loadGridStudentsPaid();
                }                
            });
            
            $("#typeFormatHeaderFilter").on('change',function (event){  
                var args = event.args;
                if (args){
                    // index represents the item's index.                      
                    var index = args.index;
                    var item = args.item;
                    // get item's label and value.
                    var label = item.label;
                    var value = item.value;
                    var type = args.type; // keyboard, mouse or null depending on how the item was selected.                      
                    if(value==1){
                        $("#contextMenu").jqxMenu('disable', 'printDetail', true);
                    }else{
                        $("#contextMenu").jqxMenu('disable', 'printDetail', false);
                    }
                    loadGridStudentsPaid();
                }                
            });
            
            $("#categoryMasterHeaderFilter").on('change',function (event){  
                var args = event.args;
                if (args){
                    // index represents the item's index.                      
                    var index = args.index;
                    var item = args.item;
                    // get item's label and value.
                    var label = item.label;
                    var value = item.value;
                    var type = args.type; // keyboard, mouse or null depending on how the item was selected.                      
                    if(value==1){
                        $("#contextMenu").jqxMenu('disable', 'printDetail', true);
                    }else{
                        $("#contextMenu").jqxMenu('disable', 'printDetail', false);
                    }
                    loadGridStudentsPaid();
                }                
            });
            loadGridStudentsPaid();
        }
        
        function loadDataWindowDetailPayment(dataHeader){
            itemPeriod = $('#payPeriodHeaderFilter').jqxDropDownList('getSelectedItem'); 
            $("#labelEnrollmentDetail").text(dataHeader.dataEnrollment);
            $("#paySemesterFilterDetail").text(dataHeader.dataNameSemester);
            $("#payPeriodTempFilterDetail").text(itemPeriod.label);
            $("#datePayment").text(dataHeader.dataDatePayment); 
            loadGridDetailFUDPPayment(dataHeader);
            popupWindowPaymentDetail.jqxWindow('open'); 
        }
        var rendertoolbar = function(toolBar){
            var theme = "";
            var toTheme = function (className) {
                if (theme === "") return className;
                return className + " " + className + "-" + theme;
            };
            // appends buttons to the status bar.
            var container = $("<div style='overflow: hidden; position: relative; height: 100%; width: 100%;'></div>");
            var buttonTemplate = "<div style='float: left; padding: 3px; margin: 2px;'><div style='margin: 4px; width: 16px; height: 16px;'></div></div>";

            var deleteButton = $(buttonTemplate);
            container.append(deleteButton);
            toolBar.append(container);
            
            deleteButton.jqxButton({ cursor: "pointer", disabled: true, enableDefault: false,  height: 25, width: 25 });
            deleteButton.find('div:first').addClass(toTheme('jqx-icon-delete'));
            deleteButton.jqxTooltip({ position: 'bottom', content: "Eliminar"});
            
            var updateButtons = function (action) {
                switch (action) {
                    case "Select":
                        deleteButton.jqxButton({ disabled: false });
                        break;
                    case "Unselect":
                        deleteButton.jqxButton({ disabled: true });
                        break;
                    case "Edit":
                        deleteButton.jqxButton({ disabled: true });
                        break;
                    case "End Edit":
                        deleteButton.jqxButton({ disabled: false });
                        break;
                }
            };
            var rowIndex = null;
            $("#gridPaymentDetail").on('rowSelect', function (event) {
                var args = event.args;
                rowIndex = args.index;
                updateButtons('Select');
            });
            $("#gridPaymentDetail").on('rowUnselect', function (event) {
                updateButtons('Unselect');
            });
            $("#gridPaymentDetail").on('rowEndEdit', function (event) {
                updateButtons('End Edit');
            });
            $("#gridPaymentDetail").on('rowBeginEdit', function (event) {
                updateButtons('Edit');
            });
            deleteButton.click(function () {
                if (!deleteButton.jqxButton('disabled')) {
                    $("#jqxWindowWarning").jqxWindow('open');
                    $("#okWarning").click(function (){
                        $("#okWarning").unbind("click"); 
                        $("#jqxWindowWarning").jqxWindow('close');
                        $("#gridPaymentDetail").jqxDataTable('deleteRow', rowIndex);
                    });
                    updateButtons('delete');
                }
            });
        };
        function loadGridDetailFUDPPayment(dataHeader){   
            var dataAdapter = new $.jqx.dataAdapter(loadSourceStudentPenaltyPaymentsPaidDetailByHeader(dataHeader.dataPkPaymentPanalty));  
            var tooltiprenderer = function (element) {
                $(element).jqxTooltip({position: 'mouse', content: $(element).text() });
            };
            $("#gridPaymentDetail").jqxDataTable('clear');
            $("#gridPaymentDetail").jqxDataTable({
                width: 710,
                height: 250,
                selectionMode: "singlerow",
                localization: getLocalization("es"),
                source: dataAdapter,
                renderToolbar : rendertoolbar,
                showToolbar: true,
                toolbarHeight: 35,
                pageable: true,
                editable: false,
                altRows: true,
                filterable: false,
                ready: function(){
                    $("#tablePaymentsPenalityHeader").jqxGrid('focus');
                },
                columns: [
                    { text: '#', filterable: false, align: 'center', cellsalign: 'center', dataField: 'dataProgresivNumber', width: 40, rendered: tooltiprenderer },
                    { text: 'REFERENCIA', align: 'center', dataField: 'dataReferenceNumber', width: 260, rendered: tooltiprenderer },
                    { text: 'DESCRIPCIÓN', align: 'center', dataField: 'dataNamePenalty', rendered: tooltiprenderer},
                    { text: 'MONTO', align: 'center', dataField: 'dataTariff', cellsformat: 'C2', cellsalign: 'right', width: 80, rendered: tooltiprenderer}
                ],
                columnsResize: false
            });
        }
        $("#removeEnrollment").hide();
        var enrollmentRecord_temp;
        createInputEnrrollment("#enrollmentRecord",false);
        $("#enrollmentRecord").on('select',function (event){
            var enrollment="";
            var pkStudent;
            if(event.args){
                var item = event.args.item;
                if(item){
                    pkStudent = item.value;
                    enrollment = item.label;
                    enrollmentRecord_temp=enrollment;
                }
            }
            if(enrollment.length>=3){
                $("#removeEnrollment").show();
                var params = {
                    pkStudent : pkStudent,
                    enrollment : enrollment
                };
                payConcept(params);
            }
        });
        $("#removeEnrollment").click(function (){
            $(this).hide();
            $('#enrollmentRecord').val("");
        });
        var popupWindowReport = $("#popupWindowCedule").jqxWindow({ 
            width: 800,
            minWidth: '1200px',
            height: 800,
            minHeight: '850px', 
            resizable: false, 
            isModal: true, 
            autoOpen: false, 
            modalOpacity: 0.7 
        });
        var popupWindowPaymentDetail = $("#popupWindowPaymentDetail").jqxWindow({ 
            width: 750,
            height: 500,
            resizable: false, 
            isModal: true, 
            autoOpen: false, 
            modalOpacity: 0.7,
            keyboardCloseKey: "esc"
        });
        var height = $(window).height();
        var popupWindowPay = $("#popupWindowPay").jqxWindow({ 
            width: 700,
            minWidth: '950px',
            height: 650,
            minHeight: (height-250)+"px",
            resizable: false, 
            isModal: true, 
            autoOpen: false, 
            modalOpacity: 0.7,
            cancelButton: $("#closeButton"),
            initContent: function() {
                $("#cashReceived").jqxTooltip({  
                    position: 'left', 
                    name: 'Validación',
                    trigger: 'click'
                });
                $("#cashReceived").off('click');
                $("#cashReceived").jqxNumberInput({ 
                    disabled: true,
                    min:0,
                    width: 100, 
                    height: 30,
                    symbol: '$', 
                    digits:5,
                    groupSize: 3,
                    spinButtons: true 
                });
                var height = $(popupWindowPay).height();
                $("#register").jqxExpander({ 
                    toggleMode: 'none', 
                    width: 'auto',
                    height: height-80,  
                    showArrow: false 
                });
                $('#validateButton').jqxButton({ 
                    width: 130, 
                    height: 30,
                    disabled : true
                });  
                $('#closeButton').jqxButton({
                    width: '80px',
                    height: 30 
                });                
            }
        });
        var popupWindowConfirmPayment = $("#popupWindowConfirmPayment").jqxWindow({ 
            width: 300,
            height: 200,
            resizable: false, 
            isModal: true, 
            autoOpen: false, 
            modalOpacity: 0.7,
            showCloseButton: false,
            keyboardCloseKey: '',
            cancelButton: $("#closeButtonConfirm"),
            initContent: function() {
                $('#okConfirm').jqxButton({ 
                    width: 130, 
                    height: 30
                });  
                $('#closeButtonConfirm').jqxButton({
                    width: '80px',
                    height: 30 
                });                
            }
        });
        popupWindowPay.on('close', function (event) { 
            $("#removeEnrollment").click();
            clearData();
            $("#paySemesterFilter").off('change');
            $("#payPeriodTempFilter").off('change');
            $("#categoryFilter").off('change');
            $('.checkBox').off('change');
        }); 
        
        var contextMenu = $("#contextMenu").jqxMenu({ width: 200, autoOpenPopup: false, mode: 'popup'});
        $("#contextMenu").jqxMenu('disable', 'printDetail', true);
        $("#tablePaymentsPenalityHeader").on('contextmenu', function (event) {              
            return false;
        });
        // handle context menu clicks.
        $("#contextMenu").on('itemclick', function (event) {
            var args = event.args;
            if ($.trim($(args).text()) === "Detalle de pago"){
                var rowData = null;
                var selection = $("#tablePaymentsPenalityHeader").jqxDataTable('getSelection');
                for (var i = 0; i < selection.length; i++) {
                    // get a selected row.
                    rowData = selection[i];
                }
                loadDataWindowDetailPayment(rowData);      
            }
            if ($.trim($(args).text()) === "Generar comprobante"){
                var rowData = null;
                var selection = $("#tablePaymentsPenalityHeader").jqxDataTable('getSelection');
                for (var i = 0; i < selection.length; i++) {
                    // get a selected row.
                    rowData = selection[i];
                }
                generateReport(rowData.dataPkPaymentPanalty)    
            }
        });
        $("#tablePaymentsPenalityHeader").on('rowDoubleClick', function (event) {            
            // event args.
            var args = event.args;
            // row data.
            var row = args.row;
            // row index.
            var index = args.index;
            // row's data bound index.
            var boundIndex = args.boundIndex; 
            // row key.
            var key = args.key;
            // data field
            var dataField = args.dataField;
            // original double click event.
            var clickEvent = args.originalEvent;
            loadDataWindowDetailPayment(row);            
        });
        $("#tablePaymentsPenalityHeader").on('rowClick', function (event) {
            // event args.
            var args = event.args;
            // row data.
            var row = args.row;
            // row index.
            var index = args.index;
            // row's data bound index.
            var boundIndex = args.boundIndex; 
            // row key.
            var key = args.key;
            // data field
            var dataField = args.dataField;
            // original click event.
            var clickEvent = args.originalEvent;
            if (event.args.originalEvent.button==2) {                
                var scrollTop = $(window).scrollTop();
                var scrollLeft = $(window).scrollLeft();
                contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                return false;
            }
        });
        
        $("#jqxExpanderNewPay").jqxExpander({ 
            width: 'auto',
            height: 80,
            showArrow: false,
            toggleMode: "none"
        });
        $("#jqxExpanderRows").jqxExpander({ 
            width: 'auto',
            height: 450,
            showArrow: false,
            toggleMode: "none"
        });     
        function registerPaymentsHeader(){            
            itemSemester = $('#paySemesterFilter').jqxDropDownList('getSelectedItem');
            itemPeriodTemp = $('#payPeriodTempFilter').jqxDropDownList('getSelectedItem'); 
            itemCategoryMaster = $('#paymentsPenaltyCategoryMasterHeaderFilter').jqxDropDownList('getSelectedItem');
            itemFormatPayment = $('#paymentsPenaltytypeFormatHeaderFilter').jqxDropDownList('getSelectedItem'); 
            var totalToPayment = $("#totalToPay").text().replace("$","");
            var totalToPayment =  totalToPayment.replace(",","");
            var dataParams = {
                pt_pk_period : itemPeriodTemp.value,
                pt_pk_semester : itemSemester.value,
                pt_pk_student : $("#hidenPkStudent").val(),
                pt_pk_category_master : itemCategoryMaster.value,
                pt_fk_type_format :  itemFormatPayment.value,       
                pt_total : totalToPayment
            };
            $.ajax({
                url:"../serviceStudentsPenaltyPayments?insert&&commit=true",
                data: dataParams,
                type: 'POST',
                dataType: 'json',
                async: false,
                beforeSend: function (xhr) {
                    $("#loading").show();
                },
                success: function (data, textStatus, jqXHR) {
                    if(data.Inserted){
                        $("#messageValidation").text("");
                        dataParams.pt_pk_student_payment_penality = data.Inserted;
                        $("#okConfirm").attr("pt_pk_student_payment_penality", data.Inserted);    
                        registerPaymentsDetail(dataParams);
                    }else{
                        $("#okConfirm").removeAttr("pt_pk_student_payment_penality"); 
                        $("#messageValidation").text("Lo sentimos ocurrio un error al procesar su pago");
                        $("#validateButton").jqxButton({disabled: false});
                        $("#cashReceived").jqxNumberInput({disabled: false});
                        $("#loading").hide();
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    $("#loading").hide();
                }
            });
        }
        var insertConcept = function (dataParamsHeader, dataParamsDetail){
            var dataAppendsParams = new Array();
            var dataToAppend = function () {
                dataParamsHeader.pt_pk_payment_penality_type = dataParamsDetail.pk_payment_penality_type;
                dataParamsHeader.pt_pk_category_payment = dataParamsDetail.pk_category_payment;
                dataParamsHeader.pt_pk_type_concept = dataParamsDetail.pk_type_concept;
                dataParamsHeader.pt_pk_type_format = dataParamsDetail.pk_type_format;                   
                dataParamsHeader.pt_reference_number = dataParamsDetail.reference;
                dataParamsHeader.pt_amount_penality = dataParamsDetail.amount;
                return dataParamsHeader;
            };

            dataAppendsParams.push(dataToAppend());
            var statusInsert = null;
            console.log(dataAppendsParams[0]);
            $.ajax({
                url:"../serviceStudentsPenaltyPaymentsDetail?insert",
                data: dataAppendsParams[0],
                type: 'POST',
                dataType: 'json',
                async: false,
                beforeSend: function (xhr) {
                    $("#loading").show();
                },
                success: function (data, textStatus, jqXHR) {
                    statusInsert = data.status;
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    $("#loading").hide();
                }
            });
            return statusInsert;
        };
        function registerPaymentsDetail(dataParamsHeader){   
            console.log("Begin");
            console.log("---");
            var dataRows = $('#contentDinamic').jqxGrid('getrows');
            var failsInserted = 0;
            for(var i=0; i<dataRows.length; i++){                
                if(dataRows[i].dataStatusPayFlag==="SI"){
                    var dataParamsDetail = {
                        pk_payment_penality_type : dataRows[i].dataPkPaymentPenaltyType,
                        pk_category_payment : dataRows[i].dataPkCategory,
                        pk_type_concept : dataRows[i].dataPkTypeConcept,
                        pk_type_format : dataRows[i].dataPkTypeFormat,
                        reference : dataRows[i].dataReferenceNumber,
                        cant : dataRows[i].dataCant,
                        amount : dataRows[i].dataTariff
                    };
                    for(var i2=0; i2<dataParamsDetail.cant; i2++){
                        if(insertConcept(dataParamsHeader, dataParamsDetail)==="Success"){
                            console.log("Success");                            
                        }else{
                            failsInserted=failsInserted+1;
                        }
                    }
                    console.log(failsInserted);
                }
            }
            $("#loading").hide();    
            $("#validateButton").jqxButton({disabled: false});
            $("#cashReceived").jqxNumberInput({disabled: false});
            
            itemFormatPayment = $('#paymentsPenaltytypeFormatHeaderFilter').jqxDropDownList('getSelectedItem'); 
            if(failsInserted>0){
                $("#messageStatusPayment").text("No fue posible realizar correctamente la operación por favor repita el proceso");
                $("#okConfirm").hide();
                $("#closeButtonConfirm").show();
                commitBack(dataParamsHeader.pt_pk_student_payment_penality);
            }else{
                popupWindowPay.jqxWindow('close');
                $("#messageStatusPayment").text("El proceso fue realizado con exito");
                if(itemFormatPayment.value==1){
                    $('#okConfirm').jqxButton({ 
                        width: 130
                    });
                    $("#okConfirm").val("SALIR");
                }else{
                    $('#okConfirm').jqxButton({ 
                        width: 230
                    });  
                    $("#okConfirm").val("GENERAR COMPROBANTE Y SALIR");                    
                }                
                $("#closeButtonConfirm").hide();
            }             
            console.log("End");
        }
        function commitBack(pt_pk_students_penalty_payment){
            $.ajax({
                type: "POST",
                async: false,
                url: "../serviceStudentsPenaltyPayments?insert&&commit=false",
                data: {
                    pt_pk_students_penalty_payment : pt_pk_students_penalty_payment
                },
                beforeSend: function (xhr) {
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert("Error interno del servidor");
                },
                success: function (data, textStatus, jqXHR) {
                   console.log(data);
                }
            });
        }
        function generateReport(pt_pk_student_payment_penalty){
            $.ajax({
                type: "POST",
                async: true,
                url: "../content/data-jr/formatsPaymenents/index.jsp?formatsPaymenents=session",
                data: {"pt_pk_student_payment_penalty": pt_pk_student_payment_penalty},
                beforeSend: function (xhr) {
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert("Error interno del servidor");
                },
                success: function (data, textStatus, jqXHR) {
                    var iframe = $('<iframe style="width: 1185px; height: 810px;">');
                    iframe.attr('src','../content/data-jr/formatsPaymenents/');
                    $('#contentPDF').html(iframe);
                }
            });
            $("#okConfirm").removeAttr("pt_pk_student_payment_penality"); 
            popupWindowReport.jqxWindow('show');
        }
    });
</script>
<div id="popupWindowCedule">
    <div>Comprobante de pago</div>
    <div style="overflow: hidden;" id="contentPDF">
    </div>
</div>
<div id='jqxExpanderNewPay'>
    <div>Registrar nuevo pago</div>
    <div>
        <div style="display: inline-block; width: 316px; height: 28px; position: relative;">
            <div style="float: left;">
                <span>Matrícula</span>
                <br>
                <input type="text" id="enrollmentRecord" style="width: 140px; height: 26px" class="text-input" />
                <span id="removeEnrollment" style="cursor: pointer; font-size: 16px; position: absolute; right: 135px; top: 21px; display: block;">X</span>
            </div>
        </div>
    </div>
</div>
<br>
<div id='jqxExpanderRows'>
    <div>Registros</div>
    <div>
        <div style="display: inline-block; margin-right: 5px;">
            Periodo <br>
            <div id='payPeriodHeaderFilter'></div>
        </div>
        <div style="display: inline-block; margin-right: 5px;">
            Categoría Principal <br>
            <div id='categoryMasterHeaderFilter'></div>
        </div>
        <div style="display: inline-block; margin-right: 5px;">
            Formato <br>
            <div id='typeFormatHeaderFilter'></div>
        </div>
        <div style="display: inline-block; margin-right: 5px;">
            <div id="tablePaymentsPenalityHeader"></div>
        </div>
    </div>
</div>

<div id='contextMenu'>
    <ul>
        <li id="paymentDetail">Detalle de pago</li>
        <li id="printDetail">Generar comprobante</li>
    </ul>
</div>
<div id="popupWindowPay">
    <div>Pagar</div>
    <div>
        <div id="register">
            <div><h3>Registrar conceptos de pago</h3></div>
            <div>
                <table class="register-table" style="width: 100%">
                    <tr>
                        <td style="width: 85px; text-align: right;"><b><label>MATRÍCULA:</label></b></td>
                        <td style="width: 155px;">
                            <span id="labelEnrollment"></span>
                            <input type="hidden" id="hidenPkStudent" value=""/>
                        </td>
                        <td style="width: 150px;"><b><label>NIVEL DE ESTUDIO:</label></b></td>
                        <td><span id="labelStudyLevel"></span></td>
                    </tr>
                    <tr>
                        <td style="text-align: right;"><b><label>NOMBRE:</label></b></td>
                        <td><span id="labelStudentName"></span></td>
                        <td style="text-align: right;"><b><label>CARRERA:</label></b></td>
                        <td><span id="labelCareer"></span></td>
                    </tr>
                </table>
                <div style="display: inline-block; margin-right: 5px;">
                    <b><label>CUATRIMESTRE:</label></b><br>
                    <div id='paySemesterFilter'></div>
                </div>                
                <div style="display: inline-block; margin-right: 5px;">
                    <b><label>PERIODO:</label></b><br>
                    <div id='payPeriodTempFilter'></div>
                </div>       
                <div style="display: inline-block; margin-right: 5px;">
                    <b><label>CATEGORIA PRINCIPAL:</label></b><br>
                    <div id='paymentsPenaltyCategoryMasterHeaderFilter'></div>
                </div>
                <div style="display: inline-block; margin-right: 5px;">
                    <b><label>FORMATO:</label></b><br>
                    <div id='paymentsPenaltytypeFormatHeaderFilter'></div>
                </div>
                <div style="display: inline-block; margin-right: 5px;">
                    <b><label id="labelDate">FECHA DE RECIBIDO:</label></b><br>
                    <div id='dateInput'></div>
                </div>  
                <br>
                <br>
                <div id="contentDinamic"></div>               
                <div id="conditionalPayment">
                    <br>
                    <div style="float: right; margin-right: 15px;font-size: 30px;width: 340px;text-align: right;">
                        <b style="float: left"><span>TOTAL:</span></b><span style="float: right" id="totalToPay">$0.00</span>
                    </div>
                    <br>
                    <br>
                    <br>
                    <div style="float: right;margin-right: 15px;font-size: 20px;width: 255px;text-align: right;">
                        <b><span>EFECTIVO RECIBIDO</span></b><div id="cashReceived" style="float: right"></div>
                        <div id="popoverValidate">
                            <div id="messageValidationCash">
                            </div>
                        </div>
                    </div>
                    <br>
                    <br>
                    <br>
                    <br>
                    <div style="float: right; margin-right: 15px;font-size: 30px;width: 340px;text-align: right;">
                        <b style="float: left"><span>CAMBIO:</span></b><span style="float: right" id="changeReturn">$_.__</span>
                    </div>
                </div>               
            </div>
        </div>
        <div class="conditionalHiden">
            <div style="text-align: center;">
                <input type="button" value="VALIDAR DATOS" id="validateButton" />
                <input type="button" value="SALIR" id="closeButton" />
            </div>
        </div>
        <div class="conditionalHiden">
            <div style="text-align: left; font-size: 24px"><span id="messageValidation" style="color: red"></span></div>
        </div>
    </div>
</div>
<div id="popupWindowConfirmPayment">
    <div>Confirmar</div>
    <div>
        <div>
            <span style="font-size: 22px;" id="messageStatusPayment">Realizar pago ahora</span>
            <div id="loading" style="display: none; float: left;margin-top: 9px;">
                <img style="display: block; float: left;width: 86px;" src="../content/pictures-system/load.GIF">
                <span style="font-size: 18px;color: #5cce34;margin-top: 54px;float: right;">Realizando pago...</span>
            </div>
        </div>
        <div style="bottom: 20px;position: absolute;right: 20px;">
            <div style="text-align: center;">
                <input type="button" value="PAGAR AHORA" id="okConfirm" />
                <input type="button" value="CANCELAR" id="closeButtonConfirm" />
            </div>
        </div>
    </div>
</div>
<div id="popupWindowPaymentDetail">
    <div>Detalles de pago</div>
    <div>
        <table class="register-table" style="width: 100%">
            <tr>
                <td style="width: 20%"><label>MATRÍCULA:</label></td>
                <td><b id="labelEnrollmentDetail"></b></td>
            </tr>
            <tr>      
                <td><label>CUATRIMESTRE:</label></td>
                <td><b id="paySemesterFilterDetail"></b></td>
            </tr>
            <tr>
                <td><label>PERIODO:</label></td>
                <td><b id="payPeriodTempFilterDetail"></b></td>
            </tr>
            <tr>
                <td><label>FECHA DE RECIBIDO:</label></td>
                <td><b id="datePayment"></b></td>
            </tr>          
            <tr>
                <td colspan="2" align="center"><label style="font-size: 18px"><b>CONCEPTOS</b></label></td>
            </tr>
            <tr>
                <td colspan="2">
                    <div id="gridPaymentDetail"></div>
                </td>
            </tr>
        </table>
    </div>
</div>