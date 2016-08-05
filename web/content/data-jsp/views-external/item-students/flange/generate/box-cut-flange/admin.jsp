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
        var itemPeriodTemp= null;
        
        function loadSourceBoxCutHeader(){      
            var ordersSource ={
                dataFields: [
                    { name: 'dataProgresivNumber', type: 'int' },
                    { name: 'dataPkBoxCute', type: 'int' },
                    { name: 'dataDateBegin', type: 'string' },
                    { name: 'dataDateEnd', type: 'string' },
                    { name: 'dataDateRow', type: 'string' },
                    { name: 'dataNumber', type: 'string' }
                ],
                dataType: "json",
                root: "__ENTITIES",
                id: "dataPkBoxCute",
                async: false,
                url: '../serviceBoxCut?view',
                data : {
                }
            };
            return ordersSource;
        }
        
        function loadGridBoxCutHeader(){
            var dataAdapter = new $.jqx.dataAdapter(loadSourceBoxCutHeader());  
            var tooltiprenderer = function (element) {
                $(element).jqxTooltip({position: 'mouse', content: $(element).text() });
            };
            $("#tableBoxCuteHeader").jqxDataTable({
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
                    $("#tableBoxCuteHeader").jqxGrid('focus');
                },
                columns: [
                    { text: '#', filterable: false, align: 'center', cellsalign: 'center', dataField: 'dataProgresivNumber', width: 40, rendered: tooltiprenderer },
                    { text: 'Corte Número', align: 'center', dataField: 'dataNumber', rendered: tooltiprenderer },
                    { text: 'De', align: 'center', dataField: 'dataDateBegin', cellsalign: 'center', width: 250, rendered: tooltiprenderer},
                    { text: 'Hasta', align: 'center', dataField: 'dataDateEnd', cellsalign: 'center', width: 250, rendered: tooltiprenderer},
                    { text: 'Fecha de Realizado', align: 'center', cellsalign: 'center', dataField: 'dataDateRow', width: 230, rendered: tooltiprenderer}
                ],
                columnsResize: false
            });
        }    
        loadGridBoxCutHeader();
        
        function newBoxCute(params){
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
        function createGridNominationBills(params){
            console.log("Making Grid Nomination Bills...");
            
        }
        function loadDataToForm(data){
            createGridNominationBills(params);
        };
        function clearData(){
            
        }
        
        function loadSourceStudentPenaltyBoxCutePaidDetailByHeader(pk_student_payment_penality_header){            
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
                url: '../serviceStudentsPenaltyBoxCuteDetail?view=viewHeader',
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
                        url: "../serviceStudentsPenaltyBoxCuteDetail?delete",
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
                                $("#tableBoxCuteHeader").jqxDataTable('updateBoundData');
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
        
        
        var contextMenu = $("#contextMenu").jqxMenu({ width: 200, autoOpenPopup: false, mode: 'popup'});
        $("#tableBoxCuteHeader").on('contextmenu', function (event) {              
            return false;
        });
        // handle context menu clicks.
        $("#contextMenu").on('itemclick', function (event) {
            var args = event.args;
            if ($.trim($(args).text()) === "Generar Reporte"){
                var rowData = null;
                var selection = $("#tableBoxCuteHeader").jqxDataTable('getSelection');
                for (var i = 0; i < selection.length; i++) {
                    // get a selected row.
                    rowData = selection[i];
                }
                generateReport(rowData.dataPkBoxCute);    
            }
        });
        $("#tableBoxCuteHeader").on('rowDoubleClick', function (event) {            
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
            generateReport(row.dataPkBoxCute);           
        });
        $("#tableBoxCuteHeader").on('rowClick', function (event) {
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
        $("#jqxExpanderRows").jqxExpander({ 
            width: 'auto',
            height: 450,
            showArrow: false,
            toggleMode: "none"
        });     
        function registerBoxCuteHeader(){            
            itemPeriodTemp = $('#payPeriodTempFilter').jqxDropDownList('getSelectedItem'); 
            var totalToPayment = $("#totalToPay").text().replace("$","");
            var totalToPayment =  totalToPayment.replace(",","");
            var dataParams = {
                pt_pk_period : itemPeriodTemp.value,
                pt_total : totalToPayment
            };
            $.ajax({
                url:"../serviceStudentsPenaltyBoxCute?insert&&commit=true",
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
                        registerBoxCuteDetail(dataParams);
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
                url:"../serviceStudentsPenaltyBoxCuteDetail?insert",
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
        function registerBoxCuteDetail(dataParamsHeader){   
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
                url: "../serviceStudentsPenaltyBoxCute?insert&&commit=false",
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
        function generateReport(pt_pk_box_cut){
            $.ajax({
                type: "POST",
                async: true,
                url: "../content/data-jr/boxCutReport/index.jsp?boxCut",
                data: {"pt_pk_box_cut": pt_pk_box_cut},
                beforeSend: function (xhr) {
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert("Error interno del servidor");
                },
                success: function (data, textStatus, jqXHR) {
                    var iframe = $('<iframe style="width: 1185px; height: 810px;">');
                    iframe.attr('src','../content/data-jr/boxCutReport/');
                    $('#contentPDF').html(iframe);
                }
            });
            popupWindowReport.jqxWindow('show');
        }
    });
</script>
<div id="popupWindowCedule">
    <div>Comprobante de pago</div>
    <div style="overflow: hidden;" id="contentPDF">
    </div>
</div>
<br>
<div id='jqxExpanderRows'>
    <div>Registros</div>
    <div>
        <div style="display: inline-block; margin-right: 5px;">
            <div id="tableBoxCuteHeader"></div>
        </div>
    </div>
</div>

<div id='contextMenu'>
    <ul>
        <li id="printDetail">Generar Reporte</li>
    </ul>
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