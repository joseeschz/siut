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
        var itemPeriod= null;
        var itemPeriodTemp= null;
        var itemCategoryPayment = null;
        function loadGridStudentsPaid(){
            var dataAdapter = new $.jqx.dataAdapter(loadSourceStudentsPenalityPaymentsHeader());  
            var tooltiprenderer = function (element) {
                $(element).jqxTooltip({position: 'mouse', content: $(element).text() });
            };
            $("#tablePaymentsPenality").jqxDataTable({
                width: 900,
                height: 350,
                selectionMode: "singlerow",
                localization: getLocalization("es"),
                source: dataAdapter,
                pageable: true,
                editable: false,
                altRows: true,
                filterable: true,
//                autorowheight: true,
//                autoheight: false,
                ready: function(){
                    $("#tablePaymentsPenality").jqxGrid('focus');
                },
                columns: [
                    { text: '#', filterable: false, align: 'center', cellsalign: 'center', dataField: 'dataProgresivNumber', width: 40, rendered: tooltiprenderer },
                    { text: 'Matrícula', align: 'center', dataField: 'dataEnrollment', width: 120, rendered: tooltiprenderer },
                    { text: 'Alumno', align: 'center', dataField: 'dataNameStudent', rendered: tooltiprenderer},
                    { text: 'Nivel de estudio', align: 'center', dataField: 'dataNameLevel', cellsalign: 'center', width: 150, rendered: tooltiprenderer},
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
                popupWindowPay.jqxWindow('open');
            }            
        }
        function checkBoxesConcepts(params){
            console.log("Making checkBoxes...");
            var records = undefined;
            var dataAdapter = new $.jqx.dataAdapter(loadSourceStudentPenaltyPaymentsDetail(params.dataPkPeriod, params.dataFkSemester, params.dataFkCategory, params.dataFkStudent), {
                loadComplete: function () {
                    // get data records.
                    records = dataAdapter.records;
                }
            });
            dataAdapter.dataBind();            
            if(records){
                var checkBox = "";
                $("#contentCheckBoxes").html("");
                $("#toPayment").text("$0.00");
                for(var i=0; i<records.length; i++){
                    checkBox = "<tr><td colspan='2' style='width: 70%;'> <div id='checkBox"+records[i].dataPkPaymentPenaltyType+"' class='checkBox'>"+records[i].dataNamePenalty+"</div></td><td colspan='2'>$<span id='mount"+records[i].dataPkPaymentPenaltyType+"'>"+records[i].dataTariff+"</span></td></tr>";
                    $("#contentCheckBoxes").append(checkBox);
                    if(records[i].dataStatusPay==="Yes"){
                        $('#mount'+records[i].dataPkPaymentPenaltyType).addClass("checkBoxChecked");
                        $('#checkBox'+records[i].dataPkPaymentPenaltyType).jqxCheckBox({ disabled:true, checked:true });
                    }else{
                        
                        $('#checkBox'+records[i].dataPkPaymentPenaltyType).jqxCheckBox({ width: 'auto' });
                    }                    
                }
                var totalPaid = 0;
                $(".checkBoxChecked").each(function (){
                    totalPaid = totalPaid + parseFloat($(this).text());
                });
                $("#totalPaid").text("$"+parseFloat(totalPaid).toFixed(2));
                var toPayment = 0;
                $('.checkBox').off('change');
                $('.checkBox').on('change', function (event) {                     
                    var checked = event.args.checked; 
                    var thisID = $(this).attr("id").replace("checkBox","");
                    if(checked){
                        toPayment = toPayment + parseFloat($("#mount"+thisID).text().replace(",",""));
                    }else{
                        toPayment = toPayment - parseFloat($("#mount"+thisID).text().replace(",",""));
                    }
                    $("#toPayment").text("$"+parseFloat(toPayment).toFixed(2));
                });
            }           
        }
        function loadDataToForm(data){
            $("#labelEnrollment").text(data.dataEnrollment);
            $("#labelStudentName").text(data.dataName);
            $("#labelStudyLevel").text(data.dataNameLevel);
            $("#labelCareer").text(data.dataNameCareer);
            $('#referenceNumber').val("");
            
            createDropDownSemester(data.dataPkLevelStudy, '#paySemesterFilter', true);
            itemSemester = $('#paySemesterFilter').jqxDropDownList('getSelectedItem');
            
            createDropDownPeriodActive('comboActiveYear', '#payPeriodTempFilter');
            itemPeriodTemp = $('#payPeriodTempFilter').jqxDropDownList('getSelectedItem');
            
            createDropDownCategoryPayment("#categoryFilter");
            itemCategoryPayment = $('#categoryFilter').jqxDropDownList('getSelectedItem');
            
            var params = {
                dataPkPeriod:itemPeriodTemp.value,
                dataFkSemester:itemSemester.value,
                dataFkStudent : data.dataPkStudent,
                dataFkCategory : itemCategoryPayment.value
            };
            checkBoxesConcepts(params);
            
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
                    itemCategoryPayment = $('#categoryFilter').jqxDropDownList('getSelectedItem');
                    var params = {
                        dataPkPeriod:itemPeriodTemp.value,
                        dataFkSemester:itemSemester.value,
                        dataFkStudent : data.dataPkStudent,
                        dataFkCategory : itemCategoryPayment.value
                    };
                    checkBoxesConcepts(params);
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
                    itemCategoryPayment = $('#categoryFilter').jqxDropDownList('getSelectedItem');
                    var params = {
                        dataPkPeriod:itemPeriodTemp.value,
                        dataFkSemester:itemSemester.value,
                        dataFkStudent : data.dataPkStudent,
                        dataFkCategory : itemCategoryPayment.value
                    };
                    checkBoxesConcepts(params);
                }                
            });
            
            $("#categoryFilter").off('change');
            $("#categoryFilter").on('change',function (event){  
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
                    itemCategoryPayment = $('#categoryFilter').jqxDropDownList('getSelectedItem');
                    var params = {
                        dataPkPeriod:itemPeriodTemp.value,
                        dataFkSemester:itemSemester.value,
                        dataFkStudent : data.dataPkStudent,
                        dataFkCategory : itemCategoryPayment.value
                    };
                    checkBoxesConcepts(params);
                    if(value!=1){
                        $(".referenceNumber").hide();
                    }else{
                        $(".referenceNumber").show();
                    }
                }                
            });
        };
        function clearData(){
            $("#labelEnrollment").text("");
            $("#labelStudentName").text("");
            $("#labelStudyLevel").text("");
            $("#labelCareer").text("");
        }
        
        function loadSourceStudentPenaltyPaymentsDetail(pt_fkPeriod, pt_fkSemester, pt_fkCategory, pt_fkStudent){            
            var ordersSource ={
                dataFields: [
                    { name: 'dataProgresivNumber', type: 'int' },
                    { name: 'dataPkStudentPenaltyPaymentDetail', type: 'int' },
                    { name: 'dataAmountPenalty', type: 'string' },
                    { name: 'dataMotiveJustify', type: 'string' },
                    { name: 'dataReferenceNumber', type: 'string' },
                    { name: 'dataStatusJustify', type: 'string' },
                    { name: 'dataStatusPay', type: 'string' },
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
                    { name: 'dataTariff', type: 'string' }
                ],
                dataType: "json",
                id: "dataPkPaymentPenaltyType",
                async: false,
                root: "__ENTITIES",
                url: '../serviceStudentsPenaltyPaymentsDetail?view=studentsAllStatusPaymentNotPrepaid',
                data : {
                    pt_fkPeriod : pt_fkPeriod ,
                    pt_fkSemester : pt_fkSemester,
                    pt_fkStudent : pt_fkStudent,
                    pt_fkCategory : pt_fkCategory
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
                url: '../serviceStudent?selectStudentConstancy',
                data : {
                    enrollment : enrollment                    
                }
            };
            return ordersSource;
        }
        
        function loadSourceStudentsPenalityPaymentsHeader(){      
            itemPeriod = $('#payPeriodFilter').jqxDropDownList('getSelectedItem'); 
            var ordersSource ={
                dataFields: [
                    { name: 'dataProgresivNumber', type: 'int' },
                    { name: 'dataPkPaymentPanalty', type: 'int' },
                    { name: 'dataDatePayment', type: 'string' },
                    { name: 'dataUnique', type: 'string' },
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
                    pt_status_prepaid : 0
                }
            };
            return ordersSource;
        }
        createDropDownSemester(1, '#paySemesterFilter', false);
        itemSemester = $('#paySemesterFilter').jqxDropDownList('getSelectedItem');

        createDropDownPeriodActive('comboActiveYear', '#payPeriodFilter');
        itemPeriod = $('#payPeriodFilter').jqxDropDownList('getSelectedItem'); 
        
        if(itemPeriod!=null || itemPeriod!= undefined){
            $("#payPeriodFilter").on('change',function (event){  
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
        
        function loadGridDetailPayment(dataHeader){
            itemPeriod = $('#payPeriodFilter').jqxDropDownList('getSelectedItem'); 
            $("#labelEnrollmentDetail").text(dataHeader.dataEnrollment);
            $("#paySemesterFilterDetail").text(dataHeader.dataNameSemester);
            $("#payPeriodTempFilterDetail").text(itemPeriod.label);
            $("#datePayment").text(dataHeader.dataDatePayment);
            var records = undefined;
            var dataAdapter = new $.jqx.dataAdapter(loadSourceStudentPenaltyPaymentsDetail(itemPeriod.value, dataHeader.dataPkSemester, 1, dataHeader.dataPkStudent), {
                loadComplete: function () {
                    // get data records.
                    records = dataAdapter.records;
                }
            });
            dataAdapter.dataBind();
            if(records){
                var checkBox = "";
                $("#contentCheckBoxesDetailGob").html("");
                $("#totalPaidGobDetail").text("$0.00");
                for(var i=0; i<records.length; i++){
                    checkBox = "<tr><td>"+records[i].dataReferenceNumber+"</td><td colspan='2'> <div>"+records[i].dataNamePenalty+"</div></td><td colspan='2'>$<span id='mountGobPaid"+records[i].dataPkPaymentPenaltyType+"'>"+records[i].dataTariff+"</span></td></tr>";
                    if(records[i].dataStatusPay==="Yes"){
                        $("#contentCheckBoxesDetailGob").append(checkBox);
                    }                   
                }
                var totalPaid = 0;
                $(".mountGobPaid").each(function (){
                    totalPaid = totalPaid + parseFloat($(this).text());
                });
                $("#totalPaidGobDetail").text("$"+parseFloat(totalPaid).toFixed(2));
            }       
            
            
            
            var records = undefined;
            var dataAdapter = new $.jqx.dataAdapter(loadSourceStudentPenaltyPaymentsDetail(itemPeriod.value, dataHeader.dataPkSemester, 1, dataHeader.dataPkStudent), {
                loadComplete: function () {
                    // get data records.
                    records = dataAdapter.records;
                }
            });
            dataAdapter.dataBind();
            if(records){
                var checkBox = "";
                $("#contentCheckBoxesDetailUni").html("");
                $("#totalPaidUniDetail").text("$0.00");
                for(var i=0; i<records.length; i++){
                    checkBox = "<tr><td>"+records[i].dataReferenceNumber+"</td><td colspan='2'> <div>"+records[i].dataNamePenalty+"</div></td><td colspan='2'>$<span id='mountUniPaid"+records[i].dataPkPaymentPenaltyType+"'>"+records[i].dataTariff+"</span></td></tr>";
                    if(records[i].dataStatusPay==="Yes"){
                        $("#contentCheckBoxesDetailUni").append(checkBox);
                    }                   
                }
                var totalPaid = 0;
                $(".mountUniPaid").each(function (){
                    totalPaid = totalPaid + parseFloat($(this).text());
                });
                $("#totalPaidUniDetail").text("$"+parseFloat(totalPaid).toFixed(2));
            }         
            
            
            var records = undefined;
            var dataAdapter = new $.jqx.dataAdapter(loadSourceStudentPenaltyPaymentsDetail(itemPeriod.value, dataHeader.dataPkSemester, 1, dataHeader.dataPkStudent), {
                loadComplete: function () {
                    // get data records.
                    records = dataAdapter.records;
                }
            });
            dataAdapter.dataBind();
            if(records){
                var checkBox = "";
                $("#contentCheckBoxesDetailOthers").html("");
                $("#totalPaidOthersDetail").text("$0.00");
                for(var i=0; i<records.length; i++){
                    checkBox = "<tr><td>"+records[i].dataReferenceNumber+"</td><td colspan='2'> <div>"+records[i].dataNamePenalty+"</div></td><td colspan='2'>$<span id='mountOthersPaid"+records[i].dataPkPaymentPenaltyType+"'>"+records[i].dataTariff+"</span></td></tr>";
                    if(records[i].dataStatusPay==="Yes"){
                        $("#contentCheckBoxesDetailOthers").append(checkBox);
                    }                   
                }
                var totalPaid = 0;
                $(".mountOthersPaid").each(function (){
                    totalPaid = totalPaid + parseFloat($(this).text());
                });
                $("#totalPaidOthersDetail").text("$"+parseFloat(totalPaid).toFixed(2));
            }          
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
            width: 650,
            height: 500,
            resizable: false, 
            isModal: true, 
            autoOpen: false, 
            modalOpacity: 0.7,
            keyboardCloseKey: "esc"
        });
        var popupWindowPay = $("#popupWindowPay").jqxWindow({ 
            width: 700,
            minWidth: '800px',
            height: 650,
            minHeight: "750px",
            resizable: false, 
            isModal: true, 
            autoOpen: false, 
            modalOpacity: 0.7,
            keyboardCloseKey: "esc"
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
        $("#tablePaymentsPenality").on('contextmenu', function (event) {           
            return false;
        });
        // handle context menu clicks.
        $("#contextMenu").on('itemclick', function (event) {
            var args = event.args;
            var rowindex = $("#tablePaymentsPenality").jqxGrid('getselectedrowindex');
            var data = $('#tablePaymentsPenality').jqxGrid('getrowdata', rowindex);
            if ($.trim($(args).text()) === "Detalle de pago"){
                popupWindowPaymentDetail.jqxWindow('open');
            }
        });
        $("#tablePaymentsPenality").on('rowDoubleClick', function (event) {            
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
            loadGridDetailPayment(row);
            popupWindowPaymentDetail.jqxWindow('open'); 
        });
        $("#tablePaymentsPenality").on('rowClick', function (event) {
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
        $("#register").jqxExpander({ toggleMode: 'none', width: 'auto', height: 650,  showArrow: false });
        $('#payButton').jqxButton({ width: 130, height: 30 });  
        $('#referenceNumber').jqxNumberInput({width: 235, height: 30, inputMode: 'simple', allowNull: true, spinButtons: false, decimal: 0, digits: 50, max: 9999999999999999999999999999999999999999999999999999999999, decimalDigits: 0, placeHolder:"NÚMERO DE REFERENCIA" });
        
        $('#referenceNumber').keyup(function(){
            if($(this).val()==0){
                $("#messageValidation").text("El número de referencia es requerido");
            }else{
                $("#messageValidation").text("");
            }
        });
        
        
        $("#payButton").click(function (){
            itemCategoryPayment = $('#categoryFilter').jqxDropDownList('getSelectedItem');
            if(itemCategoryPayment.value!=1){
                
            }else{
                var reference = $("#referenceNumber").val();
                if(reference==0){
                    $("#messageValidation").text("El número de referencia es requerido");
                }else{
                    $("#messageValidation").text("");
                    var checked = 0;
                    $(".checkBox").each(function (){
                        if($(this).jqxCheckBox('checked') && !$(this).jqxCheckBox('disabled')){
                            checked = checked +1;
                        }
                    });
                    if(checked>=1){
                        $("#messageValidation").text("");
                    }else{
                        $("#messageValidation").text("Minímo debe de seleccionar un concepto");
                    }                    
                }
            }
            
        });
    });
</script>
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
            <div id='payPeriodFilter'></div>
        </div>
        <div style="display: inline-block; margin-right: 5px;">
            <div id="tablePaymentsPenality"></div>
        </div>
    </div>
</div>

<div id='contextMenu'>
    <ul>
        <li id="paymentDetail">Detalle de pago</li>
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
                        <td><label>MATRÍCULA:</label></td>
                        <td><b id="labelEnrollment"></b></td>
                    </tr>
                    <tr>
                        <td><label>NOMBRE:</label></td>
                        <td><b id="labelStudentName"></b></td>
                    </tr>
                    <tr>
                        <td><label>NIVEL DE ESTUDIO:</label></td>
                        <td><b id="labelStudyLevel"></b></td>
                    </tr>
                    <tr>
                        <td><label>CARRERA:</label></td>
                        <td><b id="labelCareer"></b></td>
                    </tr>
                    <tr>                            
                        <td><label>CUATRIMESTRE:</label></td>
                        <td>
                            <div style="display: inline-block; margin-right: 5px;">
                                <div id='paySemesterFilter'></div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><label>PERIODO:</label></td>
                        <td>
                            <div style="display: inline-block; margin-right: 5px;">
                                <div id='payPeriodTempFilter'></div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><label>CATEGORÍA:</label></td>
                        <td>
                            <div style="display: inline-block; margin-right: 5px;">
                                <div id='categoryFilter'></div>
                            </div>
                        </td>
                    </tr>
                    <tr style="height: 52px;">           
                        <td class="referenceNumber"><label>REFERENCIA:</label></td>
                        <td class="referenceNumber"><div id="referenceNumber" ></div></td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center"><label style="font-size: 18px"><b>CONCEPTOS</b></label></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <table style="width: 100%">
                                <thead>
                                    <td colspan="2" align="center"><b>DESCRIPCIÓN</b></td>
                                    <td colspan="2" align="center"><b>MONTO</b></td>
                                </thead>
                                <tbody id="contentCheckBoxes"></tbody>
                                <thead>
                                    <td align="right"><b>PAGADO</b></td>
                                    <td align="left"><b id="totalPaid"></b></td>
                                    <td align="right"><b>POR PAGAR</b></td>
                                    <td align="left" style="width: 112px;"><b id="toPayment">$0.00</b></td>
                                </thead>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="text-align: center;"><input type="button" value="REGISTRAR PAGO" id="payButton" /></td>
                    </tr>
                    <tr>
                        <td colspan="2" style="text-align: left; font-size: 24px"><span id="messageValidation" style="color: red"></span></td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</div>
<div id="popupWindowPaymentDetail">
    <div>Detalles de pago</div>
    <div>
        <table class="register-table" style="width: 100%">
            <tr>
                <td><label>MATRÍCULA:</label></td>
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
                <td><label>FECHA DE PAGO:</label></td>
                <td><b id="datePayment"></b></td>
            </tr>
            <tr>
                <td colspan="2" align="center"><label style="font-size: 18px"><b>CONCEPTOS</b></label></td>
            </tr>
            <tr>
                <td colspan="2">
                    <label>CATEGORÍA: <b>GOBIERNO</b></label>                    
                    <table style="width: 100%">
                        <thead>
                            <td align="center" style="width:20%"><b>REFERENCIA</b></td>
                            <td colspan="2" align="center" style="width:60%"><b>DESCRIPCIÓN</b></td>
                            <td align="center" style="width:20%"><b>MONTO</b></td>                            
                        </thead>
                        <tbody id="contentCheckBoxesDetailGob"></tbody>
                        <thead>
                            <td colspan="3" align="right"><b>TOTAL</b></td>
                            <td align="left"><b id="totalPaidGobDetail"></b></td>
                        </thead>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <label>CATEGORÍA: <b>UNIVERSIDAD</b></label>                    
                    <table style="width: 100%">
                        <thead>
                            <td colspan="3" align="center" style="width:80%"><b>DESCRIPCIÓN</b></td>
                            <td align="center" style="width:20%"><b>MONTO</b></td>                            
                        </thead>
                        <tbody id="contentCheckBoxesDetailUni"></tbody>
                        <thead>
                            <td colspan="3" align="right"><b>TOTAL</b></td>
                            <td align="left"><b id="totalPaidUniDetail"></b></td>
                        </thead>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <label>CATEGORÍA: <b>OTROS</b></label>                    
                    <table style="width: 100%">
                        <thead>
                            <td colspan="3" align="center" style="width:80%"><b>DESCRIPCIÓN</b></td>
                            <td align="center" style="width:20%"><b>MONTO</b></td>                            
                        </thead>
                        <tbody id="contentCheckBoxesDetailOthers"></tbody>
                        <thead>
                            <td colspan="3" align="right"><b>TOTAL</b></td>
                            <td align="left"><b id="totalPaidOthersDetail"></b></td>
                        </thead>
                    </table>
                </td>
            </tr>
        </table>
        
    </div>
</div>