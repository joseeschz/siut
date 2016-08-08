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
        var itemPeriod= null;
        var itemPeriodTemp= null;
        function loadGridStudentsPaid(){
            var dataAdapter = new $.jqx.dataAdapter(loadSourceStudentsPenalityPaymentsHeader());  
            var tooltiprenderer = function (element) {
                $(element).jqxTooltip({position: 'mouse', content: $(element).text() });
            };
            $("#tableDebtsHeader").jqxDataTable({
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
                    $("#tableDebtsHeader").jqxGrid('focus');
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
        function loadDataToForm(data){
            $("#labelEnrollment").text(data.dataEnrollment);
            $("#hidenPkStudent").val(data.dataPkStudent);
            $("#labelStudentName").text(data.dataName);
            $("#labelStudyLevel").text(data.dataNameLevel);
            $("#labelCareer").text(data.dataNameCareer);            
            
            createDropDownPeriodActive('comboActiveYear', '#payPeriodTempFilter');
            itemPeriodTemp = $('#payPeriodTempFilter').jqxDropDownList('getSelectedItem');
            
            $("#dateInput").jqxDateTimeInput({ width: '200px', height: '27px', disabled: true });
            
            var params = {
                dataPkPeriod:itemPeriodTemp.value,
                dataFkStudent : data.dataPkStudent
            };
            popupWindowPay.jqxWindow('open');
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
                                $("#tableDebtsHeader").jqxDataTable('updateBoundData');
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
                    pt_fkPeriod : itemPeriod.value
                }
            };
            return ordersSource;
        }

        
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
            
            
            loadGridStudentsPaid();
        }
        
        function loadDataWindowDetailPayment(dataHeader){
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
                    $("#tableDebtsHeader").jqxGrid('focus');
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
            width: 400,
            height: 650,
            resizable: false, 
            isModal: true, 
            autoOpen: false, 
            modalOpacity: 0.7,
            cancelButton: $("#closeButton"),
            initContent: function() {
                $("#mount").off('click');
                $("#mount").jqxNumberInput({ 
                    disabled: false,
                    min:0,
                    width: 100, 
                    height: 30,
                    symbol: '$', 
                    digits:5,
                    groupSize: 3,
                    spinButtons: true 
                });
                $('#motive').jqxTextArea({ 
                    placeHolder: 'Espesifique el motivo...', 
                    height: 90, 
                    width: 300, 
                    minLength: 1
                });
                $("#statusYes").jqxRadioButton({ width: 50, height: 25, checked: false});
                $("#statusNot").jqxRadioButton({ width: 50, height: 25, checked: true});
                var height = $(popupWindowPay).height();
                $("#register").jqxExpander({ 
                    toggleMode: 'none', 
                    width: 'auto',
                    height: height-70,  
                    showArrow: false 
                });
                $('#validateButton').jqxButton({ 
                    width: 130, 
                    height: 30,
                    disabled : false
                });  
                $('#closeButton').jqxButton({
                    width: '80px',
                    height: 30 
                });                
            }
        });
        $('#validateButton').click(function(){
            var validate = function (){
                return true;
            };
            if(validate){
                $(popupWindowConfirmPayment).jqxWindow('open');
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
         $('#okConfirm').click(function (){
           itemPeriodTemp = $('#payPeriodTempFilter').jqxDropDownList('getSelectedItem');  
            var totalToPayment = $("#mount").val();
            var dataParams = {
                pt_pk_period : itemPeriodTemp.value,
                pt_pk_student : $("#hidenPkStudent").val(),    
                pt_total : totalToPayment
            }; 
            registerPaymentsDetail(dataParams);
        });
        popupWindowPay.on('close', function (event) { 
            $("#removeEnrollment").click();
            clearData();
            $("#paySemesterFilter").off('change');
            $("#payPeriodTempFilter").off('change');
            $("#categoryFilter").off('change');
            $('.checkBox').off('change');
        }); 
        
        $("#tableDebtsHeader").on('contextmenu', function (event) {              
            return false;
        });
        
        $("#tableDebtsHeader").on('rowDoubleClick', function (event) {            
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
        function registerPaymentsDetail(dataParamsHeader){   
            console.log("Begin");
            console.log("---");
            var failsInserted=0;            
            $.ajax({
                url:"../serviceDebt?inserDetail",
                data: dataParamsHeader,
                type: 'POST',
                dataType: 'json',
                async: false,
                beforeSend: function (xhr) {
                    $("#loading").show();
                },
                success: function (data, textStatus, jqXHR) {
                    if(data.Inserted){
                        failsInserted=0;
                        $("#messageValidation").text("");
                    }else{
                        $("#loading").hide();
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    $("#loading").hide();
                }
            });
            
            
            $("#loading").hide();    
            
            if(failsInserted>0){
                $("#messageStatusPayment").text("No fue posible realizar correctamente la operación por favor repita el proceso");
                $("#okConfirm").hide();
                $("#closeButtonConfirm").show();
            }else{
                popupWindowPay.jqxWindow('close');
                $("#messageStatusPayment").text("El proceso fue realizado con exito");               
                $("#closeButtonConfirm").hide();
            }             
            console.log("End");
        }
    });
</script>
<div id='jqxExpanderNewPay'>
    <div>Registrar nueva deuda</div>
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
            <div id="tableDebtsHeader"></div>
        </div>
    </div>
</div>

<div id="popupWindowPay">
    <div>Agregar deuda de alumno</div>
    <div>
        <div id="register">
            <div><h3>Nuevo registro</h3></div>
            <div>
                <table class="register-table" style="width: 100%">
                    <tr>
                        <td>
                            <b><label>MATRÍCULA:</label></b><br>
                            <span id="labelEnrollment"></span>
                            <input type="hidden" id="hidenPkStudent" value=""/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <b><label>NIVEL DE ESTUDIO:</label></b><br>
                            <span id="labelStudyLevel"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <b><label>NOMBRE:</label></b><br>
                            <span id="labelStudentName"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <b><label>CARRERA:</label></b><br>
                            <span id="labelCareer"></span>
                        </td>
                    </tr>
                </table>
                               
                <div style="display: inline-block; margin-right: 5px;">
                    <b><label>PERIODO:</label></b><br>
                    <div id='payPeriodTempFilter'></div>
                </div>       
                
                <div style="display: inline-block; margin-right: 5px;">
                    <b><label id="labelDate">FECHA DE REGISTRO</label></b><br>
                    <div id='dateInput'></div>
                </div>  
                
                <div style="display: inline-block; margin-right: 5px;">
                    <b><label id="labelMount">MONTO DE LA DEUDA</label></b><br>
                    <div id='mount'></div>
                </div>
                
                <div style="display: inline-block; margin-right: 5px;">
                    <b><label id="labelMotive">MOTIVO</label></b><br>
                    <textarea id="motive"></textarea>
                </div>
                <div style="display: inline-block; margin-right: 5px;">
                    <b><label id="labelMotive">LA DEUDA YA FUÉ SALDADA</label></b><br>
                    <div style='margin-top: 10px; display: inline-block' id='statusYes'>SI</div>
                    <div style='margin-top: 10px; display: inline-block' id='statusNot'>NO</div>
                </div>
                <br>                 
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
            <span style="font-size: 22px;" id="messageStatusPayment">Realizar operación ahora</span>
            <div id="loading" style="display: none; float: left;margin-top: 9px;">
                <img style="display: block; float: left;width: 86px;" src="../content/pictures-system/load.GIF">
                <span style="font-size: 18px;color: #5cce34;margin-top: 54px;float: right;">Agregando...</span>
            </div>
        </div>
        <div style="bottom: 20px;position: absolute;right: 20px;">
            <div style="text-align: center;">
                <input type="button" value="SI" id="okConfirm" />
                <input type="button" value="CANCELAR" id="closeButtonConfirm" />
            </div>
        </div>
    </div>
</div>
<div id="popupWindowPaymentDetail">
    <div>Detalles de deudas</div>
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
                <td colspan="2" align="center"><label style="font-size: 18px"><b>CONCEPTOS DE DEUDAS</b></label></td>
            </tr>
            <tr>
                <td colspan="2">
                    <div id="gridPaymentDetail"></div>
                </td>
            </tr>
        </table>
    </div>
</div>