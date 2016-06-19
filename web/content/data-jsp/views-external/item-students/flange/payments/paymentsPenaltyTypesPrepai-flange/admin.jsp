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
        var itemCategoryPaymentDetail = null;
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
            if(records.length>0){                
                $(".conditionalHiden").show();
                $("#conceptsTitle").text("CONCEPTOS");
                $("#messageValidation").text("");
                var checkBox = "";
                $("#contentCheckBoxes").html("");
                $("#toPayment").text("$0.00");
                for(var i=0; i<records.length; i++){
                    checkBox = "<tr><td colspan='2' style='width: 70%;'> <div id='checkBox"+records[i].dataPkPaymentPenaltyType+"' class='checkBox'>"+records[i].dataNamePenalty+"</div></td><td colspan='2'>$<span id='mount"+records[i].dataPkPaymentPenaltyType+"'>"+parseFloat(records[i].dataTariff).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,');+"</span></td></tr>";
                    $("#contentCheckBoxes").append(checkBox);
                    if(records[i].dataStatusPay==="Yes"){
                        $('#mount'+records[i].dataPkPaymentPenaltyType).addClass("checkBoxChecked");
                        $('#checkBox'+records[i].dataPkPaymentPenaltyType).jqxCheckBox({ disabled:true, checked:true });
                    }else{
                        
                        $('#checkBox'+records[i].dataPkPaymentPenaltyType).jqxCheckBox({ width: 'auto' });
                    }                    
                }
                var totalPaid = 0;
                var totalChecked = 0;
                $(".checkBoxChecked").each(function (){
                    totalChecked = totalChecked+1;
                    totalPaid = totalPaid + parseFloat($(this).text().replace(",",""));
                });
                if(totalChecked==records.length){
                    $("#conceptsTitle").text("TODOS LOS CONCEPTOS PAGADOS PARA LAS CONDICIONES SELECCIONADAS");
                    $("#payButton").jqxButton({disabled: true});
                    $('#referenceNumber').jqxInput({disabled: true});
                }else{
                    $("#conceptsTitle").text("CONCEPTOS");
                    $("#payButton").jqxButton({disabled: false});
                    $('#referenceNumber').jqxInput({disabled: false});
                }
                $("#totalPaid").text("$"+parseFloat(totalPaid).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,'));
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
                    $("#toPayment").text("$"+parseFloat(toPayment).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,'));
                });
            }else{
                $(".conditionalHiden").hide();
                $("#conceptsTitle").text("NO HAY CONCEPTOS QUE PAGAR PARA LAS CONDICIONES SELECCIONADAS");
                $("#messageValidation").text("");
            }           
        }
        function loadDataToForm(data){
            $("#labelEnrollment").text(data.dataEnrollment);
            $("#hidenPkStudent").val(data.dataPkStudent);
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
        
        function loadSourceStudentPenaltyPaymentsPaidDetail(pt_fkPeriod, pt_fkSemester, pt_fkCategory, pt_fkStudent){            
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
                id: "dataPkStudentPenaltyPaymentDetail",
                async: false,
                root: "__ENTITIES",
                url: '../serviceStudentsPenaltyPaymentsDetail?view',
                data : {
                    pt_fkPeriod : pt_fkPeriod ,
                    pt_fkSemester : pt_fkSemester,
                    pt_fkStudent : pt_fkStudent,
                    pt_fkCategory : pt_fkCategory,
                    pt_statusPrepaid : 1
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
                                $("#tablePaymentsPenality").jqxDataTable('updateBoundData');
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
                url: '../serviceStudentsPenaltyPaymentsDetail?view',
                data : {
                    pt_fkPeriod : pt_fkPeriod ,
                    pt_fkSemester : pt_fkSemester,
                    pt_fkStudent : pt_fkStudent,
                    pt_fkCategory : pt_fkCategory,
                    pt_statusPrepaid : 1
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
                    pt_status_prepaid : 1
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
        
        function loadDataWindowDetailPayment(dataHeader){
            itemPeriod = $('#payPeriodFilter').jqxDropDownList('getSelectedItem'); 
            $("#labelEnrollmentDetail").text(dataHeader.dataEnrollment);
            $("#paySemesterFilterDetail").text(dataHeader.dataNameSemester);
            $("#payPeriodTempFilterDetail").text(itemPeriod.label);
            $("#datePayment").text(dataHeader.dataDatePayment);
            createDropDownCategoryPayment("#categoryDetailFilter");
            itemCategoryPaymentDetail = $('#categoryDetailFilter').jqxDropDownList('getSelectedItem');   
            
            if(itemCategoryPaymentDetail.value==1){
                loadGridDetailGobPayment(dataHeader);
            }else if(itemCategoryPaymentDetail.value==2){
                loadGridDetailUniPayment(dataHeader);
            }else{
                loadGridDetailOthersPayment(dataHeader);
            }
            
            $("#categoryDetailFilter").off('change');
            $("#categoryDetailFilter").on('change',function (event){  
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
                        loadGridDetailGobPayment(dataHeader);
                    }else if(value==2){
                        loadGridDetailUniPayment(dataHeader);
                    }else{
                        loadGridDetailOthersPayment(dataHeader);
                    }
                }                
            });     
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
        function loadGridDetailGobPayment(dataHeader){            
            var dataAdapter = new $.jqx.dataAdapter(loadSourceStudentPenaltyPaymentsPaidDetail(itemPeriod.value, dataHeader.dataPkSemester, 1, dataHeader.dataPkStudent),{
                beforeLoadComplete: function (records) {
                    var recordsR = new Array();
                    for(var i=0; i<records.length; i++){
                        if(records[i].dataStatusPay==="Yes"){
                            recordsR.push(records[i]);
                        }
                    }
                    return recordsR;
                }
            });  
            var tooltiprenderer = function (element) {
                $(element).jqxTooltip({position: 'mouse', content: $(element).text() });
            };
            $("#gridPaymentDetail").jqxDataTable('clear');
            $("#gridPaymentDetail").jqxDataTable({
                width: "auto",
                height: 180,
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
                    $("#tablePaymentsPenality").jqxGrid('focus');
                },
                columns: [
                    { text: '#', filterable: false, align: 'center', cellsalign: 'center', dataField: 'dataProgresivNumber', width: 40, rendered: tooltiprenderer },
                    { text: 'REFERENCIA', align: 'center', dataField: 'dataReferenceNumber', width: 260, rendered: tooltiprenderer },
                    { text: 'DESCRIPCIÓN', align: 'center', dataField: 'dataNamePenalty', width: 300, rendered: tooltiprenderer},
                    { text: 'MONTO', align: 'center', dataField: 'dataTariff', cellsformat: 'C2', cellsalign: 'right', width: 110, rendered: tooltiprenderer}
                ],
                columnsResize: false
            });
        }
        function loadGridDetailUniPayment(dataHeader){            
            var dataAdapter = new $.jqx.dataAdapter(loadSourceStudentPenaltyPaymentsPaidDetail(itemPeriod.value, dataHeader.dataPkSemester, 2, dataHeader.dataPkStudent),{
                beforeLoadComplete: function (records) {
                    var recordsR = new Array();
                    for(var i=0; i<records.length; i++){
                        if(records[i].dataStatusPay==="Yes"){
                            recordsR.push(records[i]);
                        }
                    }
                    return recordsR;
                }
            });  
            var tooltiprenderer = function (element) {
                $(element).jqxTooltip({position: 'mouse', content: $(element).text() });
            };
            $("#gridPaymentDetail").jqxDataTable('clear');
            $("#gridPaymentDetail").jqxDataTable({
                width: "auto",
                height: 180,
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
                    $("#tablePaymentsPenality").jqxGrid('focus');
                },
                columns: [
                    { text: '#', filterable: false, align: 'center', cellsalign: 'center', dataField: 'dataProgresivNumber', width: 40, rendered: tooltiprenderer },
                    { text: 'DESCRIPCIÓN', align: 'center', dataField: 'dataNamePenalty', width: 560, rendered: tooltiprenderer},
                    { text: 'MONTO', align: 'center', dataField: 'dataTariff', cellsformat: 'C2', cellsalign: 'right', width: 110, rendered: tooltiprenderer}
                ],
                columnsResize: false
            });
        }
        function loadGridDetailOthersPayment(dataHeader){            
            var dataAdapter = new $.jqx.dataAdapter(loadSourceStudentPenaltyPaymentsPaidDetail(itemPeriod.value, dataHeader.dataPkSemester, 3, dataHeader.dataPkStudent),{
                beforeLoadComplete: function (records) {
                    var recordsR = new Array();
                    for(var i=0; i<records.length; i++){
                        if(records[i].dataStatusPay==="Yes"){
                            recordsR.push(records[i]);
                        }
                    }
                    return recordsR;
                }
            });  
            var tooltiprenderer = function (element) {
                $(element).jqxTooltip({position: 'mouse', content: $(element).text() });
            };
            $("#gridPaymentDetail").jqxDataTable('clear');
            $("#gridPaymentDetail").jqxDataTable({
                width: "auto",
                height: 180,
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
                    $("#tablePaymentsPenality").jqxGrid('focus');
                },
                columns: [
                    { text: '#', filterable: false, align: 'center', cellsalign: 'center', dataField: 'dataProgresivNumber', width: 40, rendered: tooltiprenderer },
                    { text: 'DESCRIPCIÓN', align: 'center', dataField: 'dataNamePenalty', width: 560, rendered: tooltiprenderer},
                    { text: 'MONTO', align: 'center', dataField: 'dataTariff', cellsformat: 'C2', cellsalign: 'right', width: 110, rendered: tooltiprenderer}
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
        var popupWindowPay = $("#popupWindowPay").jqxWindow({ 
            width: 700,
            minWidth: '800px',
            height: 650,
            minHeight: "750px",
            resizable: false, 
            isModal: true, 
            autoOpen: false, 
            modalOpacity: 0.7,
            cancelButton: $("#closeButton"),
            initContent: function() {
                $("#register").jqxExpander({ 
                    toggleMode: 'none', 
                    width: 'auto',
                    height: 680,  
                    showArrow: false 
                });
                $('#referenceNumber').jqxInput({
                    width: 235, 
                    height: 30,  
                    placeHolder:"NÚMERO DE REFERENCIA" 
                });
                $('#payButton').jqxButton({ 
                    width: 130, 
                    height: 30 
                });  
                $('#closeButton').jqxButton({
                    width: '80px',
                    height: 30 
                });                
            },
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
            if ($.trim($(args).text()) === "Detalle de pago"){
                var rowData = null;
                var selection = $("#tablePaymentsPenality").jqxDataTable('getSelection');
                for (var i = 0; i < selection.length; i++) {
                    // get a selected row.
                    rowData = selection[i];
                }
                loadDataWindowDetailPayment(rowData);      
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
            loadDataWindowDetailPayment(row);            
        });
        $("#tablePaymentsPenality").on('rowClick', function (event) {
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
        
        $('#referenceNumber').keyup(function(){
            if($(this).val()==0){
                $("#messageValidation").text("El número de referencia es requerido");
            }else{
                $("#messageValidation").text("");
            }
        });        
        
        $("#payButton").click(function (){
            if(!$("#payButton").jqxButton('disabled')){
                itemCategoryPayment = $('#categoryFilter').jqxDropDownList('getSelectedItem');
                if(itemCategoryPayment.value!=1){
                    $("#messageValidation").text("");
                    var checked = 0;
                    $(".checkBox").each(function (){
                        if($(this).jqxCheckBox('checked') && !$(this).jqxCheckBox('disabled')){
                            checked = checked +1;
                        }
                    });
                    if(checked>=1){
                        $("#payButton").jqxButton({disabled: true});
                        registerPaymentsHeader();
                        $("#messageValidation").text("");
                    }else{
                        $("#messageValidation").text("Minímo debe de seleccionar un concepto");
                    }    
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
                            $("#payButton").jqxButton({disabled: true});
                            registerPaymentsHeader();
                            $("#messageValidation").text("");
                        }else{
                            $("#messageValidation").text("Minímo debe de seleccionar un concepto");
                        }                    
                    }
                }
            }            
        });
        
        function registerPaymentsHeader(){            
            itemSemester = $('#paySemesterFilter').jqxDropDownList('getSelectedItem');
            itemPeriodTemp = $('#payPeriodTempFilter').jqxDropDownList('getSelectedItem');            
            var dataParams = {
                pt_pk_period : itemPeriodTemp.value,
                pt_pk_semester : itemSemester.value,
                pt_pk_student : $("#hidenPkStudent").val(),
                pt_status_prepaid : 1,
                pt_status_payment : 1
            };
            $.ajax({
                url:"../serviceStudentsPenaltyPayments?insert",
                data: dataParams,
                type: 'POST',
                dataType: 'json',
                async: true,
                beforeSend: function (xhr) {
                    $("#loading").show();
                },
                success: function (data, textStatus, jqXHR) {
                    if(data.Inserted){
                        $("#messageValidation").text("");
                        dataParams.pt_pk_student_payment_penality = data.Inserted;
                        registerPaymentsDetail(dataParams);
                    }else{
                        $("#messageValidation").text("Lo sentimos ocurrio un error al procesar su pago");
                        $("#payButton").jqxButton({disabled: false});
                        $("#loading").hide();
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    $("#loading").hide();
                }
            });
        }
        function registerPaymentsDetail(dataParams){   
            console.log("Begin");
            itemCategoryPayment = $('#categoryFilter').jqxDropDownList('getSelectedItem');
            var dataAppendsParams = new Array();
            var insertConcept = function (pk_payment_penality_type){
                var dataToAppend = function () {
                    dataParams.pt_pk_payment_penality_type = pk_payment_penality_type;
                    dataParams.pt_pk_category_payment = itemCategoryPayment.value;
                    dataParams.pt_reference_number = $("#referenceNumber").val();
                    return dataParams;
                };
                dataAppendsParams.push(dataToAppend());
                var statusInsert = null;
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
                        console.log(data);
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        $("#loading").hide();
                    }
                });
                return statusInsert;
            };
                
            $(".checkBox").each(function (){
                if(!$(this).jqxCheckBox('disabled')){
                    if($(this).jqxCheckBox('checked')){
                        var pk_payment_penality_type = parseInt($(this).attr('id').replace("checkBox",""));
                        if(insertConcept(pk_payment_penality_type)==="Success"){
                            $(this).jqxCheckBox({disabled: true});
                            console.log("Concept Inserted");
                        }else{
                            $(this).jqxCheckBox({checked: false});
                            console.log("Concept Not Inserted");
                        }
                    }
                }
            });
            $("#loading").hide();    
            $("#payButton").jqxButton({disabled: false});
            itemSemester = $('#paySemesterFilter').jqxDropDownList('getSelectedItem');
            itemPeriodTemp = $('#payPeriodTempFilter').jqxDropDownList('getSelectedItem');
            itemCategoryPayment = $('#categoryFilter').jqxDropDownList('getSelectedItem');
            
            var params = {
                dataPkPeriod:itemPeriodTemp.value,
                dataFkSemester:itemSemester.value,
                dataFkStudent : dataParams.pt_pk_student,
                dataFkCategory : itemCategoryPayment.value
            };
            checkBoxesConcepts(params);
            $("#referenceNumber").val("");
            loadGridStudentsPaid();
            console.log("End");
        }
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
                        <td style="width: 155px;"><label>MATRÍCULA:</label></td>
                        <td colspan="2">
                            <b id="labelEnrollment"></b>
                            <input type="hidden" id="hidenPkStudent" value=""/>
                        </td>
                    </tr>
                    <tr>
                        <td><label>NOMBRE:</label></td>
                        <td colspan="2"><b id="labelStudentName"></b></td>
                    </tr>
                    <tr>
                        <td><label>NIVEL DE ESTUDIO:</label></td>
                        <td colspan="2"><b id="labelStudyLevel"></b></td>
                    </tr>
                    <tr>
                        <td><label>CARRERA:</label></td>
                        <td colspan="2"><b id="labelCareer"></b></td>
                    </tr>
                    <tr>                            
                        <td><label>CUATRIMESTRE:</label></td>
                        <td style="width: 270px;">
                            <div style="display: inline-block; margin-right: 5px;">
                                <div id='paySemesterFilter'></div>
                            </div>
                        </td>
                        <td rowspan="3" style="text-align: center;">
                            <img id="loading" style="display: none" src="../content/pictures-system/load.GIF">
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
                        <td colspan="2" class="referenceNumber"><input type="text" id="referenceNumber"/></td>
                    </tr>
                    <tr>
                        <td colspan="3" align="center"><label style="font-size: 18px"><b id="conceptsTitle">CONCEPTOS</b></label></td>
                    </tr>
                    <tr class="conditionalHiden">
                        <td colspan="3">
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
                    <tr class="conditionalHiden">
                        <td colspan="3" style="text-align: center;">
                            <input type="button" value="REGISTRAR PAGO" id="payButton" />
                            <input type="button" value="SALIR" id="closeButton" />
                        </td>
                    </tr>
                    <tr class="conditionalHiden">
                        <td colspan="3" style="text-align: left; font-size: 24px"><span id="messageValidation" style="color: red"></span></td>
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
                <td><label>FECHA DE PAGO:</label></td>
                <td><b id="datePayment"></b></td>
            </tr>            
            <tr>
                <td><label>CATEGORÍA:</label></td>
                <td>
                    <div style="display: inline-block; margin-right: 5px;">
                        <div id='categoryDetailFilter'></div>
                    </div>
                </td>
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