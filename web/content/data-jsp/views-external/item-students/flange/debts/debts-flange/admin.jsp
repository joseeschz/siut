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
        function loadSourceDebtsHeader(){      
            var ordersSource ={
                dataFields: [
                    { name: 'dataProgresivNumber', type: 'int' },
                    { name: 'dataPkDebt', type: 'int' },
                    { name: 'dataPkStudent', type: 'int' },
                    { name: 'dataName', type: 'string' },
                    { name: 'dataEnrollment', type: 'string' },
                    { name: 'dataCareer', type: 'string' },
                    { name: 'dataStudyLevel', type: 'string' }
                ],
                dataType: "json",
                id: "dataPkDebt",
                async: false,
                url: '../serviceDebt?selectDebts',
                data : {
                    
                }
            };
            return ordersSource;
        }
        
        function loadGridDebtsStudents(){
            var dataAdapter = new $.jqx.dataAdapter(loadSourceDebtsHeader());  
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
                    { text: 'Alumno', align: 'center', dataField: 'dataName', width: 250, rendered: tooltiprenderer},
                    { text: 'Nivel de estudio', align: 'center', dataField: 'dataStudyLevel', cellsalign: 'center', width: 150, rendered: tooltiprenderer},
                    { text: 'Carrera', align: 'center', dataField: 'dataCareer', width: 350, rendered: tooltiprenderer}
                ],
                columnsResize: false
            });
        }    
        loadGridDebtsStudents();
        
        function registerDebt(params){
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
            $("#motive").val("");
            $("#mount").val(0);
        }
        
        function loadSourceDebtDetailByHeader(pk_debt){            
            var ordersSource ={
                dataFields: [
                    { name: 'dataProgresivNumber', type: 'int' },
                    { name: 'dataPkDebtDetail', type: 'int' },
                    { name: 'dataPkStudent', type: 'int' },
                    { name: 'dataRowDate', type: 'string' },
                    { name: 'dataMount', type: 'number' },
                    { name: 'dataFkDebt', type: 'int' },
                    { name: 'dataMotive', type: 'string' },
                    { name: 'dataPeriod', type: 'string' },
                    { name: 'dataPkPeriod', type: 'int' },
                    { name: 'dataStatusNowDebt', type: 'boolean' }                    
                ],
                dataType: "json",
                id: "dataPkDebtDetail",
                url: '../serviceDebt?selectDetailDebts',
                data : {
                    pt_pk_debt_detail : pk_debt                  
                },
                deleterow: function (rowID, commit) {
                    // synchronize with the server - send delete command
                    // call commit with parameter true if the synchronization with the server is successful 
                    // and with parameter false if the synchronization failed.
                    $.ajax({
                        //Send the paramethers to servelt
                        type: "POST",
                        async: false,
                        url: "../serviceDebt?delete",
                        data:{
                            'pt_pk_debt_detail':rowID[0]
                        },
                        beforeSend: function (xhr) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //This is if exits an error with the server internal can do server off, or page not found
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) {
                            var rows = $("#gridDebtDetail").jqxGrid('getrows');
                            if(rows.length==1){
                                $("#tableDebtsHeader").jqxGrid('updateBoundData');
                                commit(true);
                                $("#gridDebtDetail").jqxGrid('updateBoundData');
                                popupWindowPaymentDetail.jqxWindow('close');
                            }else{
                                commit(true);
                                $("#gridDebtDetail").jqxGrid('updateBoundData');
                            }
                        }
                    });
                },
                updaterow: function (rowid, rowdata, commit) {
                    // synchronize with the server - send update command
                    // call commit with parameter true if the synchronization with the server was successful 
                    // and with parameter false if the synchronization has failed.
                    $.ajax({
                        //Send the paramethers to servelt
                        type: "POST",
                        async: false,
                        url: "../serviceDebt?update",
                        data:rowdata,
                        beforeSend: function (xhr) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //This is if exits an error with the server internal can do server off, or page not found
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) {
                            var rows = $("#gridDebtDetail").jqxGrid('getrows');
                            if(rows.length==1){
                                commit(true);
                            }else{
                                commit(true);
                            }
                        }
                    });
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
        
        function loadDataWindowDetailPayment(dataHeader){
            $("#labelEnrollmentDetail").text(dataHeader.dataEnrollment);
            $("#labelNameStudent").text(dataHeader.dataName); 
            loadGridDetailDebt(dataHeader);
            popupWindowPaymentDetail.jqxWindow('open'); 
        }
        var container = $("<div style='overflow: hidden; position: relative; height: 100%; width: 100%;'></div>");
        var buttonTemplate = "<div style='float: left; padding: 3px; margin: 2px;'><div style='margin: 4px; width: 16px; height: 16px;'></div></div>";

        var deleteButton = $(buttonTemplate);
        var rendertoolbar = function(toolBar){
            $('#gridDebtDetail').jqxGrid('clearselection');
            var theme = "";
            var toTheme = function (className) {
                if (theme === "") return className;
                return className + " " + className + "-" + theme;
            };
            // appends buttons to the status bar.
            
            container.append(deleteButton);
            toolBar.append(container);
            
            deleteButton.jqxButton({ cursor: "pointer", disabled: true, enableDefault: true,  height: 25, width: 25 });
            deleteButton.find('div:first').addClass(toTheme('jqx-icon-delete'));
            deleteButton.jqxTooltip({ position: 'bottom', content: "Eliminar"});
            
            var rowIndex = null;
            $("#gridDebtDetail").on('rowunselect', function (event) {
                deleteButton.jqxButton({ disabled: true });  
            });
            $("#gridDebtDetail").on('rowselect');
            $("#gridDebtDetail").on('rowselect', function (event) {
                var args = event.args;
                rowIndex = args.index;
                $(deleteButton).jqxButton({ disabled: false });    
            });
            $("#gridDebtDetail").off('rowunselect');
            
            $("#gridDebtDetail").off('rowendedit');
            $("#gridDebtDetail").on('rowendedit', function (event) {
            });
            $("#gridDebtDetail").off('rowbeginedit');
            $("#gridDebtDetail").on('rowbeginedit', function (event) {
                
            });
            deleteButton.off('click');
            deleteButton.click(function () {
                if (!deleteButton.jqxButton('disabled')) {
                    $("#jqxWindowWarning").jqxWindow('open');
                    $("#okWarning").off('click');
                    $("#okWarning").click(function (){
                        $("#jqxWindowWarning").jqxWindow('close');
                        var rowindex = $('#gridDebtDetail').jqxGrid('getselectedrowindex');
                        var data = $('#gridDebtDetail').jqxGrid('getrowdata', rowindex);
                        var rowIDs = new Array();
                        rowIDs.push(data.dataPkDebtDetail);
                        $("#gridDebtDetail").jqxGrid('deleterow', rowIDs);
                        $('#gridDebtDetail').jqxGrid('clearselection');
                    });
                    $("#cancelWarning").off('click');
                    $("#cancelWarning").click(function (){
                        $("#jqxWindowWarning").jqxWindow('close');
                        $('#gridDebtDetail').jqxGrid('clearselection');
                    });
                    deleteButton.jqxButton({ disabled: true }); 
                }
            });
        };
        function loadGridDetailDebt(dataHeader){   
            var dataAdapter = new $.jqx.dataAdapter(loadSourceDebtDetailByHeader(dataHeader.dataPkDebt));  
            var tooltiprenderer = function (element) {
                $(element).jqxTooltip({position: 'mouse', content: $(element).text() });
            };
            $("#gridDebtDetail").jqxGrid('clear');
            $("#gridDebtDetail").jqxGrid({
                width: 710,
                height: 250,
                selectionMode: "singlerow",
                localization: getLocalization("es"),
                source: dataAdapter,
                rendertoolbar : rendertoolbar,
                showtoolbar: true,
                toolbarheight: 35,
                pageable: true,
                editable: true,
                altRows: true,
                filterable: false,
                ready: function(){
                    $("#gridDebtDetail").jqxGrid('focus');
                },
                columns: [
                    { editable: false, text: '#', filterable: false, align: 'center', cellsalign: 'center', datafield: 'dataProgresivNumber', width: 40, rendered: tooltiprenderer },
                    { text: 'MOTIVO', align: 'center', datafield: 'dataMotive',  rendered: tooltiprenderer },
                    { editable: false, text: 'PERIODO', align: 'center', datafield: 'dataPeriod', width: 180, rendered: tooltiprenderer},                    
                    { text: 'MONTO', columntype: 'numberinput', align: 'center', datafield: 'dataMount', cellsformat: 'C2', cellsalign: 'right', width: 80, rendered: tooltiprenderer},
                    { text: 'ESTADO DE PAGO', align: 'center', columntype: 'checkbox', datafield: 'dataStatusNowDebt', width: 160, rendered: tooltiprenderer}
                ]
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
                registerDebt(params);
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
            width: 400,
            height: 680,
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
                    height: 70, 
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
                if($("#mount").val()>=1){
                    $("#messageValidation").text("");
                    if($("#motive").val()!==""){
                        $("#messageValidation").text("");
                    }else{
                        $("#messageValidation").text("Debe de especificar el motivo");
                        return false;
                    }
                }else{
                    $("#messageValidation").text("El monto debe de ser mayor a $1.00");
                    return false;
                }
                return true;
            };
            if(validate()){
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
            var status_debt=0;
            if($("#statusYes").val()){
                status_debt=1;
            }
            var dataParams = {
                pt_pk_period : itemPeriodTemp.value,
                pt_pk_student : $("#hidenPkStudent").val(),    
                pt_motive : $("#motive").val(),
                pt_total : totalToPayment,
                pt_debt_status : status_debt
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
            $.ajax({
                url:"../serviceDebt?insert",
                data: dataParamsHeader,
                type: 'POST',
                dataType: 'json',
                async: false,
                beforeSend: function (xhr) {
                    $("#loading").show();
                },
                success: function (data, textStatus, jqXHR) {
                    $(popupWindowConfirmPayment).jqxWindow('close');
                    $(popupWindowPay).jqxWindow('close');
                    if(data.Inserted){
                        $("#messageValidation").text("");
                    }else{
                        $("#loading").hide();
                    }                    
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert("Error interno del servidor");
                    $(popupWindowConfirmPayment).jqxWindow('close');
                    $("#loading").hide();
                }
            });           
            
            $("#loading").hide();            
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
                <div class="conditionalHiden" style="display: inline-block">
                    <div style="text-align: left; font-size: 15px"><span id="messageValidation" style="color: red"></span></div>
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
                <td style="width: 20%"><label>NOMBRE:</label></td>
                <td><b id="labelNameStudent"></b></td>
            </tr>         
            <tr>
                <td colspan="2" align="center"><label style="font-size: 18px"><b>CONCEPTOS DE DEUDAS</b></label></td>
            </tr>
            <tr>
                <td colspan="2">
                    <div id="gridDebtDetail"></div>
                </td>
            </tr>
        </table>
    </div>
</div>