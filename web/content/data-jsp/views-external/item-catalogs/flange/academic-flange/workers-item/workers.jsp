<script type="text/javascript">
    $(document).ready(function () {
        var itemRol = 0;
        function loadSource(fkRol){
            var ordersSource ={
                dataFields: [
                    { name: 'id', type:'int'},
                    { name: 'dataProgresivNumber', type:'int'},
                    { name: 'dataProfession', type: 'string' },
                    { name: 'dataNameWorker', type: 'string' },
                    { name: 'dataPaternName', type: 'string' },
                    { name: 'dataMaternName', type: 'string' },
                    { name: 'dataKeySp', type: 'string' },
                    { name: 'dataTelphoneNumber', type: 'string' },
                    { name: 'dataAddres', type: 'string' },
                    { name: 'dataPhoto', type: 'string' },
                    { name: 'dataUserName', type: 'string' }
                ],
                root: "__ENTITIES",
                dataType: "json",
                async: false,
                id: 'id',
                url: '../serviceWorker?view&&fkRol='+fkRol+'',
                addRow: function (rowID, rowData, position, commit) {
                    // synchronize with the server - send insert command
                    // call commit with parameter true if the synchronization with the server is successful 
                    // and with parameter false if the synchronization failed.
                    // you can pass additional argument to the commit callback which represents the new ID if it is generated from a DB.
                    $("#tableWorkers").jqxDataTable('goToPage', 0);
                },
                deleteRow: function (rowID, commit) {
                    // synchronize with the server - send delete command
                    // call commit with parameter true if the synchronization with the server is successful 
                    // and with parameter false if the synchronization failed.
                    $.ajax({
                        //Send the paramethers to servelt
                        type: "POST",
                        async: false,
                        url: "../serviceWorker?delete",
                        data:{'pkWorker':rowID},
                        beforeSend: function (xhr) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //This is if exits an error with the server internal can do server off, or page not found
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) {
                            commit(true);
                            $("#tableWorkers").jqxDataTable('updateBoundData');
                        }
                    });
                    commit(true);
                }
            };
            return ordersSource;
        };
        createDropDownRol("#workersRolFilter");
        itemRol = $('#workersRolFilter').jqxDropDownList('getSelectedItem');
        itemRol = itemRol.value;
        var dataAdapter = new $.jqx.dataAdapter(loadSource(itemRol));
        $("#tableWorkers").jqxDataTable({
            width: 920,
            height : 350,
            selectionMode: "singleRow",
            localization: getLocalization("es"),
            source: dataAdapter,
            pageable: true,
            editable: false,
            filterable: true,
            showToolbar: true,
            altRows: true,
            pagerButtonsCount: 10,
            toolbarHeight: 35,
            renderToolbar: function(toolBar){
                var theme = "";
                var toTheme = function (className) {
                    if (theme === "") return className;
                    return className + " " + className + "-" + theme;
                };
                // appends buttons to the nameCareerAbreiated bar.
                var container = $("<div style='overflow: hidden; position: relative; height: 100%; width: 100%;'></div>");
                var buttonTemplate = "<div style='float: left; padding: 3px; margin: 2px;'><div style='margin: 4px; width: 16px; height: 16px;'></div></div>";
                var addButton = $(buttonTemplate);
                var editButton = $(buttonTemplate);
                var deleteButton = $(buttonTemplate);
//                var cancelButton = $(buttonTemplate);
//                var updateButton = $(buttonTemplate);
                container.append(addButton);
                container.append(editButton);
                container.append(deleteButton);
//                container.append(cancelButton);
//                container.append(updateButton);
                toolBar.append(container);
                addButton.jqxButton({cursor: "pointer", enableDefault: false,  height: 25, width: 25 });
                addButton.find('div:first').addClass(toTheme('jqx-icon-plus'));
                addButton.jqxTooltip({ position: 'bottom', content: "Agregar"});
                editButton.jqxButton({ cursor: "pointer", disabled: true, enableDefault: false,  height: 25, width: 25 });
                editButton.find('div:first').addClass(toTheme('jqx-icon-edit'));
                editButton.jqxTooltip({ position: 'bottom', content: "Editar"});
                deleteButton.jqxButton({ cursor: "pointer", disabled: true, enableDefault: false,  height: 25, width: 25 });
                deleteButton.find('div:first').addClass(toTheme('jqx-icon-delete'));
                deleteButton.jqxTooltip({ position: 'bottom', content: "Eliminar"});
//                updateButton.jqxButton({ cursor: "pointer", disabled: true, enableDefault: false,  height: 25, width: 25 });
//                updateButton.find('div:first').addClass(toTheme('jqx-icon-save'));
//                updateButton.jqxTooltip({ position: 'bottom', content: "Guardar"});
//                cancelButton.jqxButton({ cursor: "pointer", disabled: true, enableDefault: false,  height: 25, width: 25 });
//                cancelButton.find('div:first').addClass(toTheme('jqx-icon-cancel'));
//                cancelButton.jqxTooltip({ position: 'bottom', content: "Cancelar"});
                var updateButtons = function (action) {
                    switch (action) {
                        case "Select":
                            addButton.jqxButton({ disabled: false });
                            deleteButton.jqxButton({ disabled: false });
                            editButton.jqxButton({ disabled: false });
//                            cancelButton.jqxButton({ disabled: true });
//                            updateButton.jqxButton({ disabled: true });
                            break;
                        case "Unselect":
                            addButton.jqxButton({ disabled: false });
                            deleteButton.jqxButton({ disabled: true });
                            editButton.jqxButton({ disabled: true });
//                            cancelButton.jqxButton({ disabled: true });
//                            updateButton.jqxButton({ disabled: true });
                            break;
                        case "Edit":
                            addButton.jqxButton({ disabled: true });
                            deleteButton.jqxButton({ disabled: true });
                            editButton.jqxButton({ disabled: true });
//                            cancelButton.jqxButton({ disabled: false });
//                            updateButton.jqxButton({ disabled: false });
                            break;
                        case "End Edit":
                            addButton.jqxButton({ disabled: false });
                            deleteButton.jqxButton({ disabled: false });
                            editButton.jqxButton({ disabled: false });
//                            cancelButton.jqxButton({ disabled: true });
//                            updateButton.jqxButton({ disabled: true });
                            break;
                    }
                };
                var rowIndex = null;
                $("#tableWorkers").on('rowSelect', function (event) {
                    var args = event.args;
                    rowIndex = args.index;
                    updateButtons('Select');
                });
                $("#tableWorkers").on('rowUnselect', function (event) {
                    updateButtons('Unselect');
                });
                $("#tableWorkers").on('rowEndEdit', function (event) {
                    updateButtons('End Edit');
                });
                $("#tableWorkers").on('rowBeginEdit', function (event) {
                    updateButtons('Edit');
                });
                addButton.click(function (event) {
                    if (!addButton.jqxButton('disabled')) {
                        // add new empty row.
                        $(".special").show();
                        $("#headTitle").text("Nuevo registro");
                        $('#sendButton').val("Registrar");
                        $("#jqxRegister").jqxWindow('open');
                        updateButtons('Unselect');
                    }
                });
//                cancelButton.click(function (event) {
//                    if (!cancelButton.jqxButton('disabled')) {
//                        // cancel changes.
//                        $("#tableWorkers").jqxDataTable('endRowEdit', rowIndex, true);
//                    }
//                });
//                updateButton.click(function (event) {
//                    if (!updateButton.jqxButton('disabled')) {
//                        // save changes.
//                        $("#tableWorkers").jqxDataTable('endRowEdit', rowIndex, false);
//                    }
//                });
                editButton.click(function () {
                    if (!editButton.jqxButton('disabled')) {
                        var selection = $("#tableWorkers").jqxDataTable('getSelection');
                        var rowData = null;
                        for (var i = 0; i < selection.length; i++) {
                            // get a selected row.
                            rowData = selection[i];
                        }
                        editRow(rowData);
                        updateButtons('edit');
                    }
                });
                deleteButton.click(function () {
                    if (!deleteButton.jqxButton('disabled')) {
                        $("#jqxWindowWarning").jqxWindow('open');
                        $("#ok").click(function (){
                            $("#tableWorkers").unbind("bindingComplete");
                            $("#ok").unbind("click"); 
                            $("#jqxWindowWarning").jqxWindow('close');
                            $("#tableWorkers").jqxDataTable('deleteRow', rowIndex);
                        });
                        updateButtons('delete');
                    }
                });
            },
            ready: function(){
                
            },
            columns: [
                { text: 'NP',filterable: false, editable: false, dataField: 'dataProgresivNumber', width: 35 },
                /*{ text: 'Fotografia',columntype: 'custom', dataField: 'dataPhoto', width: 200,
                    createEditor: function (row, cellvalue, editor, cellText, width, height) {
                        // construct the editor. 
                        editor.jqxFileUpload({
                            autoUpload: false, 
                            width: 150, 
                            accept: 'image/*',
                            uploadUrl: 'imageUpload.php', 
                            fileInputName: 'fileToUpload',
                            browseTemplate: 'success',
                            renderFiles: function (fileName) {
                                var stopIndex = fileName.indexOf('.');
                                var name = fileName.slice(0, stopIndex);
                                var extension = fileName.slice(stopIndex);
                                return name + '<strong>' + extension + '</strong>';
                            },
                            localization: { 
                                browseButton: 'Buscar', 
                                uploadButton: 'Subir',
                                cancelButton: 'Cancelar', 
                                uploadFileTooltip: 'Subir', 
                                cancelFileTooltip: 'Cancelar' 
                            }
                        });
                    },
                    initEditor: function (row, cellvalue, editor, celltext, width, height) {
                        // set the editor's current value. The callback is called each time the editor is displayed.
                    },
                    getEditorValue: function (row, cellvalue, editor) {
                        // return the editor's value.
                        return 1;
                    }
                },*/
                { text: 'Profesión', dataField: 'dataProfession', width: 90,
                    createEditor: function (row, cellvalue, editor, cellText, width, height) {
                        // construct the editor. 
                        $(editor).keyup(function() {
                            $(this).val($(this).val().toUpperCase());
                        });
                    },
                    getEditorValue: function (row, cellvalue, editor) {
                        // return the editor's value.
                        return $(editor).val().toUpperCase();
                    }
                },
                { text: 'Nombre', dataField: 'dataNameWorker', width: 200,
                    createEditor: function (row, cellvalue, editor, cellText, width, height) {
                        // construct the editor. 
                        $(editor).keyup(function() {
                            $(this).val($(this).val().toUpperCase());
                        });
                    },
                    getEditorValue: function (row, cellvalue, editor) {
                        // return the editor's value.
                        return $(editor).val().toUpperCase();
                    }
                },
                { text: 'Apellido Paterno', dataField: 'dataPaternName', width: 130,
                    createEditor: function (row, cellvalue, editor, cellText, width, height) {
                        // construct the editor. 
                        $(editor).keyup(function() {
                            $(this).val($(this).val().toUpperCase());
                        });
                    },
                    getEditorValue: function (row, cellvalue, editor) {
                        // return the editor's value.
                        return $(editor).val().toUpperCase();
                    }
                },
                { text: 'Apellido Materno', dataField: 'dataMaternName', width: 130,
                    createEditor: function (row, cellvalue, editor, cellText, width, height) {
                        // construct the editor. 
                        $(editor).keyup(function() {
                            $(this).val($(this).val().toUpperCase());
                        });
                    },
                    getEditorValue: function (row, cellvalue, editor) {
                        // return the editor's value.
                        return $(editor).val().toUpperCase();
                    }
                },
                { text: 'Clave SP', dataField: 'dataKeySp', width: 100},
                { text: 'Usuario', filterable: false, editable: false, dataField: 'dataUserName', width: 140 },
                { text: 'Telefono', columntype: 'custom', dataField: 'dataTelphoneNumber', width: 120, 
                    createEditor: function (row, cellvalue, editor, cellText, width, height) {
                        // construct the editor. 
                        editor.jqxMaskedInput({ width: 120, height: 26, mask: '(###)###-####'});
                        var valueTel = cellvalue.replace("(","");
                        valueTel = valueTel.replace(")","");
                        valueTel = valueTel.replace("-","");
                        editor.jqxMaskedInput({value: valueTel });
                    },
                    initEditor: function (row, cellvalue, editor, celltext, width, height) {
                        // set the editor's current value. The callback is called each time the editor is displayed.
                        //alert(celltext);
                        var valueTel = editor.jqxMaskedInput('value');
                        editor.jqxMaskedInput({value: valueTel });
                    },
                    getEditorValue: function (row, cellvalue, editor) {
                        // return the editor's value.
                        var valueTel = editor.jqxMaskedInput('value');
                        return valueTel;
                    }
                },
                { text: 'Dirección', dataField: 'dataAddres', width: 340,
                    createEditor: function (row, cellvalue, editor, cellText, width, height) {
                        // construct the editor. 
                        $(editor).keyup(function() {
                            $(this).val($(this).val().toUpperCase());
                        });
                    },
                    getEditorValue: function (row, cellvalue, editor) {
                        // return the editor's value.
                        return $(editor).val().toUpperCase();
                    }
                }
            ]
        });
        var evenRol = false;
        $('#workersRolFilter').click(function (){
            evenRol = true;
        });
        $('#workersRolFilter').on('change',function (event){           
            if(evenRol){
                evenRol = $('#workersRolFilter').jqxDropDownList('getSelectedItem');
                evenRol = evenRol.value;
                $("#tableWorkers").unbind("bindingComplete");
                dataAdapter = new $.jqx.dataAdapter(loadSource(evenRol));
                $("#tableWorkers").jqxDataTable({source: dataAdapter});
                evenRol = false;
                return false;
            }
        });
        $("#jqxRegister").jqxWindow({
            height: 500,
            width: 400,
            theme: theme,
            autoOpen: false,
            isModal: true,
            resizable: false
        });
        $('#sendButton').jqxButton({ width: 70, height: 25 });
        $('#generateData').jqxButton({ width: 60, height: 20 });
        $('#clearData').jqxButton({ width: 60, height: 20 });
        $('#sendDataToMail').jqxCheckBox({ width: 130 });
//        $("#fl_key_sp").jqxNumberInput({ width: 150, height: 25, decimalDigits: 0, spinButtons: false, decimal:0, groupSize: 10, digits: 10, max: '10000000000'});
        $("#fl_telephone_number").jqxMaskedInput({ mask: '(###)###-####', width: 150, height: 25  });
        $('.text-input').jqxInput({height: 25});
        $('#sendButton').on('click', function () {
            $('#registerForm').jqxValidator('validate');
        });
        $("#clearData").click(function (){
            $("#fl_user_name").val("");
            $("#fl_mail").val("");
            $("#fl_password").val("");
        });
        $('#generateData').on('click', function () {
            var name = $("#fl_name").val();
            var patern_name = $("#fl_patern_name").val();
            var matern_name = $("#fl_matern_name").val();
            if(name!=="" && patern_name!=="" && matern_name!==""){
                var userGenerated = generateUser(name, patern_name, matern_name);
                $("#fl_user_name").val(userGenerated);
                $("#fl_mail").val(userGenerated+"@utsem.edu.mx");
                $("#fl_password").val(userGenerated);
            }else{
                $('#registerForm').jqxValidator('validateInput', "#fl_name");
                $('#registerForm').jqxValidator('validateInput', "#fl_patern_name");
                $('#registerForm').jqxValidator('validateInput', "#fl_matern_name");
            }
        });
        function clearFiels(){
            $("#pkWorker").val("");
            $("#fl_name").val("");
            $("#fl_patern_name").val("");
            $("#fl_matern_name").val("");
            $("#fl_profession").val("");
            $('#fl_key_sp').jqxNumberInput('clear');
            $('#fl_telephone_number').jqxMaskedInput('clear');
            $("#fl_address").val("");
            $("#fl_user_name").val("");
        }
        function editRow(rowData){
            $(".special").hide();
            $("#headTitle").text("Editar registro");
            $('#sendButton').val("Guardar");
            $("#jqxRegister").jqxWindow('open');
            $("#pkWorker").val(rowData.id);            
            $("#fl_name").val(rowData.dataNameWorker);            
            $("#fl_patern_name").val(rowData.dataPaternName);
            $("#fl_matern_name").val(rowData.dataMaternName);
            $("#fl_profession").val(rowData.dataProfession);
            $('#fl_key_sp').val(rowData.dataKeySp);
            $('#fl_key_sp').attr('oldValue',$('#fl_key_sp').val());
            $('#fl_telephone_number').val(rowData.dataTelphoneNumber);
            $("#fl_address").val(rowData.dataAddres);
            $("#fl_user_name").val(rowData.dataUserName);
        }
        $('#registerForm').jqxValidator({
            hintType: 'label',
            animationDuration: 0,
            rules: [
                    { input: '#fl_profession', message: 'La profesión es requerida', action: 'keyup, blur', rule: 'required' },
                    { input: '#fl_name', message: 'El nombre es requerido', action: 'keyup, blur', rule: 'required' },
                    { input: '#fl_name', message: 'Solo deben de ser letras', action: 'keyup, blur', rule: 'notNumber' },
                    { input: '#fl_patern_name', message: 'El apellido paterno es requerido', action: 'keyup', rule: 'required' },
                    { input: '#fl_patern_name', message: 'Solo deben de ser letras', action: 'keyup, blur', rule: 'notNumber' },                   
                    { input: '#fl_matern_name', message: 'El apellido materno es requerido', action: 'keyup', rule: 'required' },
                    { input: '#fl_matern_name', message: 'Solo deben de ser letras', action: 'keyup, blur', rule: 'notNumber' },                   
                    { input: '#fl_key_sp', message: 'La clave del servidor público es requerida', action: 'keyup, blur', rule: 'required' },
                    { input: '#fl_key_sp', message: 'Debe de ser númerica', action: 'keyup, blur', rule: 'number' },
                    {
                        input: '#fl_key_sp', message: 'La clave ya esta en uso', action: 'blur', rule: function (input, commit) {
                            // call commit with false, when you are doing server validation and you want to display a validation error on this field. 
                            var key_sp = checkKp(input.val());
                            if($("#sendButton").val()==="Registrar"){
                                if(key_sp==="0"){
                                    return true;
                                }else if(key_sp==="1"){
                                    return false;
                                }else{
                                    console.log("Error "+key_sp);
                                }
                            }else{
                                if(key_sp==="0"){
                                    return true;
                                }else if(key_sp==="1"){
                                    if(input.val()===input.attr('oldValue')){
                                        return true;
                                    }else{
                                        return false;  
                                    }                                    
                                }else{
                                    console.log("Error "+key_sp);
                                }
                            }
                            
                        }
                    },
                    { input: '#fl_telephone_number', message: 'El número de teléfono es requerido', action: 'valuechanged, blur', rule: 'required' },
                    { input: '#fl_telephone_number', message: 'Debe de ser un formato valido', action: 'valuechanged, blur', rule: 'phone' },
                    { input: '#fl_user_name', message: 'El nombre de usuario es requerido', action: 'keyup, blur', rule: 'required' }
               ]
        });
        $('#registerForm').on('validationSuccess', function (event) { 
            itemRol = $('#workersRolFilter').jqxDropDownList('getSelectedItem');
            itemRol = itemRol.value;
            var url = null;
            if($("#sendButton").val()==="Registrar"){
                url="../serviceWorker?insert";
            }else{
                url="../serviceWorker?update&&pkWorker="+$("#pkWorker").val();
            }
            $.ajax({
                //Send the paramethers to servelt
                type: "POST",
                async: false,
                url: url,
                data:{
                    'fkRol':itemRol,
                    'profession':$("#fl_profession").val(),
                    'nameWorker':$("#fl_name").val(),
                    'maternName':$("#fl_matern_name").val(),
                    'paternName':$("#fl_patern_name").val(),
                    'keySp':$("#fl_key_sp").val(),
                    'telephoneNumber':$("#fl_telephone_number").val(),
                    'addres':$("#fl_address").val(),
                    'photo':""
                },
                beforeSend: function (xhr) {
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    //This is if exits an error with the server internal can do server off, or page not found
                    alert("Error interno del servidor");
                },
                success: function (data, textStatus, jqXHR) {
                    $("#tableWorkers").jqxDataTable('updateBoundData');
                    $("#jqxRegister").jqxWindow('close');
                    clearFiels();
                }
            });
        }); 
        function checkKp(value){
            var checkKp = "";
            evenRol = $('#workersRolFilter').jqxDropDownList('getSelectedItem');
            evenRol = evenRol.value;
            $.ajax({
                //Send the paramethers to servelt
                type: "POST",
                async: false,
                url: "../serviceWorker?checkKp",
                data:{
                    'keySp': value
                },
                beforeSend: function (xhr) {
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    //This is if exits an error with the server internal can do server off, or page not found
                    alert("Error interno del servidor");
                },
                success: function (data, textStatus, jqXHR) {
                    checkKp = data;
                }
            });
            return checkKp;
        }
        function generateUser(name, paterName, maternName){
            var user = "";
            evenRol = $('#workersRolFilter').jqxDropDownList('getSelectedItem');
            evenRol = evenRol.value;
            $.ajax({
                //Send the paramethers to servelt
                type: "POST",
                async: false,
                url: "../serviceWorker?generate",
                data:{
                    'nameWorker':name, 
                    'paternName': paterName,
                    'maternName': maternName
                },
                beforeSend: function (xhr) {
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    //This is if exits an error with the server internal can do server off, or page not found
                    alert("Error interno del servidor");
                },
                success: function (data, textStatus, jqXHR) {
                    user = data;
                }
            });
            return user;
        }
    });
</script>
<style>
    textarea {
        resize: none;
    }
</style>
<div style="float: left; margin-right: 5px;">
    Rol de usuario<br>
    <div id='workersRolFilter'></div>
</div><br><br><br>
<div id="tableWorkers"></div>
<div id='jqxRegister'>
    <div>
        <div id="headTitle">Nuevo registro</div> 
    </div>
    <div>
        <form id="registerForm" action="./">
            <table class="register-table">
                <tr>
                    <td>Profesión</td>
                    <td><input type="text" id="fl_profession" class="text-input" placeholder="Ing, Lic, Mti, etc..." /></td>
                </tr>
                <tr>
                    <td>Nombre</td>
                    <td><input type="text" id="fl_name" class="text-input" /></td>
                </tr>
                <tr>
                    <td>Apellido paterno</td>
                    <td><input type="text" id="fl_patern_name" class="text-input" /></td>
                </tr>
                <tr>
                    <td>Apellido materno</td>
                    <td><input type="text" id="fl_matern_name" class="text-input" /></td>
                </tr>
                <tr>
                    <td>Clave Servidor Público</td>
                    <td><input type="text" id="fl_key_sp" class="text-input" /></td>
                </tr>
                <tr>
                    <td>Teléfono</td>
                    <td><div id="fl_telephone_number"></div></td>
                </tr>
                <tr>
                    <td>Dirección</td>
                    <td><textarea id="fl_address"></textarea></td>
                </tr>
                <tr class="special">
                    <td colspan="2" align="center"><h5 style="color: rgb(52, 97, 10);">Datos de acceso<h5><hr style="margin: 6px 0;"></td>
                </tr>
                <tr class="special">
                    <td colspan="2" align="right"><input style="font-size: 10px;" type="button" value="Generar" id="generateData" /></td>
                </tr>
                <tr class="special">
                    <td>Usuario</td>
                    <td><input type="text" readonly="" id="fl_user_name" disabled="" class="text-input" /></td>
                </tr>
                <tr class="special">
                    <td colspan="2" align="right"><input style="font-size: 10px;" type="button" value="Limpiar" id="clearData" /></td>
                </tr>
                <tr class="special">
                    <td colspan="2" align="center"><hr style="margin: 6px 0;"></td>
                </tr>
                <tr class="special">
                    <td colspan="2" style="padding: 5px;"><div id="sendDataToMail" style="margin-left: 50px;">Enviar datos al correo</div></td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: center;">
                        <input type="hidden" value="" id="pkWorker" />
                        <input type="button" value="Registrar" id="sendButton" />
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>