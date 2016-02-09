<script type="text/javascript">
    $(document).ready(function () {
        $('#buttonChange').jqxSwitchButton({ height: 15, width: 50,  checked: false, onLabel:'Si', offLabel:'No' });
        $(".successButton").jqxButton({width: 70, template: "success" }).css({"margin-left":"270px"});
        $("#saveRegisterForm3").jqxButton({disabled:true});
        $("#fl_telephone_number").jqxMaskedInput({ mask: '(###)###-####', width: 150, height: 25  });
        $("#fl_password_old").jqxPasswordInput({ disabled:true, height: 27, width: '260px', showStrength: false, showStrengthPosition: "right" });
        $("#fl_password").jqxPasswordInput({disabled:true, height: 27, width: '260px', showStrength: false, showStrengthPosition: "right" });
        $("#fl_password_new_verify").jqxPasswordInput({disabled:true, height: 27, width: '260px', showStrength: false, showStrengthPosition: "right" });
        $("#jqxNavigationBar").jqxNavigationBar({ 
            width: 600, 
            height: 430, 
            animationType:'fade',
            theme: theme
        });
        $('#registerForm1').jqxValidator({
            hintType: 'label',
            animationDuration: 1000,
            rules: [
                { input: '#fl_profession', message: 'La profesión es requerida', action: 'keyup, blur', rule: 'required' },
                { input: '#fl_name_worker', message: 'El nombre es requerido', action: 'keyup, blur', rule: 'required' },
                { input: '#fl_name_worker', message: 'Solo deben de ser letras', action: 'keyup, blur', rule: 'notNumber' },
                { input: '#fl_patern_name', message: 'El apellido paterno es requerido', action: 'keyup', rule: 'required' },
                { input: '#fl_patern_name', message: 'Solo deben de ser letras', action: 'keyup, blur', rule: 'notNumber' },                   
                { input: '#fl_matern_name', message: 'El apellido materno es requerido', action: 'keyup', rule: 'required' },
                { input: '#fl_matern_name', message: 'Solo deben de ser letras', action: 'keyup, blur', rule: 'notNumber' },                   
                { input: '#fl_key_sp', message: 'La clave del servidor público es requerida', action: 'keyup, blur', rule: 'required' },
                { input: '#fl_key_sp', message: 'Debe de ser númerica', action: 'keyup, blur', rule: 'number' },
                {
                    input: '#fl_key_sp', message: 'La clave ya esta en uso', action: 'blur', rule: function (input, commit) {                        
                        var key_sp = 0;
                        var retorna = false;
                        if(input.attr('oldValue')!==input.val()){
                            key_sp = checkKp(input.val());
                            if(key_sp==="0"){
                                retorna = true;
                            }else if(key_sp==="1"){
                                if(input.val()===input.attr('oldValue')){
                                    retorna = true;
                                }else{
                                    retorna = false;  
                                }                                    
                            }else{
                                console.log("Error "+key_sp);
                            }
                        }else{
                            retorna = true;
                        }   
                        return retorna;
                    }
                }
            ],
            onSuccess: function (){
                registerForm = "registerForm1";
                var changes=0;
                $('#'+registerForm+' [data-field="true"]').each(function (){
                    if($(this).attr('oldValue')!==$(this).val()){
                        changes=changes+1;
                    }
                });
                if(changes>0){
                    $('#jqxWindowWarningAcount').jqxWindow("open");                         
                    changes=0;
                }                
            }
        });
        $('#saveRegisterForm').on('click', function () {
            $('#registerForm1').jqxValidator('validate');            
        });
        $('#okWarning').click(function (){
            $('#'+registerForm+' [data-field="true"]').each(function (){
                if($(this).attr('oldValue')!==$(this).val()){
                    var field_name = $(this).attr("id");
                    var field_value = $(this).val();
                    $.ajax({
                        //Send the paramethers to servelt
                        type: "POST",
                        async: false,
                        url: "../serviceWorker?updateField",
                        data:{
                            'field_name' : field_name,
                            'field_value' : field_value
                        },
                        beforeSend: function (xhr) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //This is if exits an error with the server internal can do server off, or page not found
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) {
                            $("#"+field_name).attr('oldValue', field_value);
                        }
                    });
                }
            });
            if(registerForm==="registerForm3"){                
                $("#messageOk").text("Al cambiar la contraseña el sistema cerrará la sesión");
            }else{
                $("#messageOk").text("Los datos fueron modificados correctamente");
            }
            $('#jqxWindowOk').jqxWindow("open");      
        });
        $("#ok").click(function (){
            if(registerForm==="registerForm3"){
                window.location="../login?statusLogin"; 
            }           
        });
        $('#registerForm2').jqxValidator({
            hintType: 'label',
            animationDuration: 0,
            rules: [                
                { input: '#fl_mail', message: 'El correo es requerido', action: 'keyup, blur', rule: 'required' },
                { input: '#fl_mail', message: 'El correo no tiene un formato valido', action: 'keyup', rule: 'email' }
            ],
            onSuccess: function (){   
                registerForm = "registerForm2";              
                var changes=0;
                $('#'+registerForm+' [data-field="true"]').each(function (){
                    if($(this).attr('oldValue')!==$(this).val()){
                        changes=changes+1;
                    }
                });
                if(changes>0){
                    $('#jqxWindowWarningAcount').jqxWindow("open");                         
                    changes=0;
                }  
            }
        });       
        $('#buttonChange').on('checked', function (event) {            
            $("#fl_password_old").jqxPasswordInput({ disabled:true});
            $("#fl_password").jqxPasswordInput({disabled:true});
            $("#fl_password_new_verify").jqxPasswordInput({disabled:true});
            $('#registerForm3').jqxValidator('hide');
            $("#saveRegisterForm3").jqxButton({disabled:true});
            $("#fl_password_old").val("");
            $("#fl_password").val("");
            $("#fl_password_new_verify").val("");
        }); 
        $('#buttonChange').on('unchecked', function (event) { 
            $("#fl_password_old").jqxPasswordInput({ disabled: false});
            $("#fl_password").jqxPasswordInput({disabled: false});
            $("#fl_password_new_verify").jqxPasswordInput({disabled: false});
            $("#saveRegisterForm3").jqxButton({disabled: false});
        }); 
        
        $('#registerForm3').jqxValidator({
            hintType: 'label',
            animationDuration: 0,
            rules: [
                    { input: '#fl_password_old', message: 'La contraseña es requerida', action: 'keyup, blur', rule: 'required' },  
                    { 
                        input: '#fl_password_old', message: 'Contraseña incorrecta', action: 'keyup, blur', rule: function (input, commit){
                            if(old_password !== input.val()){
                                return false;
                            }
                            return true;
                        }
                    },  
                    { input: '#fl_password', message: 'Tu contraseña debe de contener de 4 a 20 caracteres', action: 'keyup, blur', rule: 'length=4,20' },
                    {   
                        input: '#fl_password', message: 'La contraseña no puede ser igual que la anterior', action: 'keyup, blur', rule: function (input, commit){
                            if (input.val() === old_password) {
                                return false;
                            }
                            return true;
                        }
                    },
                    {
                        input: '#fl_password_new_verify', message: 'Las contraseñas no coinsiden', action: 'keyup, focus', rule: function (input, commit) {
                            // call commit with false, when you are doing server validation and you want to display a validation error on this field. 
                            if (input.val() === $('#fl_password').val()) {
                                return true;
                            }
                            return false;
                        }
                    }
            ],
            onSuccess: function (){ 
                registerForm = "registerForm3";
                var changes=0;
                $('#'+registerForm+' [data-field="true"]').each(function (){
                    if($(this).attr('oldValue')!==$(this).val()){
                        changes=changes+1;
                    }
                });
                if(changes>0){
                    $('#jqxWindowWarningAcount').jqxWindow("open");                         
                    changes=0;
                }  
            }
        }); 
        $('#saveRegisterForm3').on('click', function () {
            if($('#buttonChange').jqxSwitchButton('checked')){
                $('#registerForm3').jqxValidator('validate');
            }
        });
        $('#saveRegisterForm2').on('click', function () {
            $('#registerForm2').jqxValidator('validate');
        });
        $('#registerForm4').jqxValidator({
            hintType: 'label',
            animationDuration: 0,
            rules: [
                { input: '#fl_telephone_number', message: 'El número de teléfono es requerido', action: 'keyup, blur', rule: 'required' }
            ],
            onSuccess: function (){  
                registerForm = "registerForm4";
                var changes=0;
                $('#'+registerForm+' [data-field="true"]').each(function (){
                    if($(this).attr('oldValue')!==$(this).val()){
                        changes=changes+1;
                    }
                });
                if(changes>0){
                    $('#jqxWindowWarningAcount').jqxWindow("open");                         
                    changes=0;
                }  
            }
        }); 
        $('#saveRegisterForm4').on('click', function () {
            $('#registerForm4').jqxValidator('validate');
        });
        function checkKp(value){
            var checkKp = "";
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
        function loadDataWorker(){
            $.ajax({
                //Send the paramethers to servelt
                type: "POST",
                async: false,
                url: "../serviceWorker?getData",
                data:{
                },
                beforeSend: function (xhr) {
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    //This is if exits an error with the server internal can do server off, or page not found
                    alert("Error interno del servidor");
                },
                success: function (data, textStatus, jqXHR) {
                    var valueKey = "";
                    $("[data-field='true']").each(function (){
                        valueKey =$(this).attr("id");
                        if($(this).attr("id")==="fl_password"){
                            old_password = data[valueKey];
                        }else{
                            $(this).val(data[valueKey]);
                            $(this).attr('oldValue',data[valueKey]);
                        }                        
                    });
                }
            });
        }
        loadDataWorker();
    });
</script>
<style>
    .columTop{
        background-color: #BEF298; 
        height: 50px; 
        width: 650px; 
        border: 1px solid rgb(165, 159, 159);
    }
    .columBody{
        width: 630px; 
        height: 430px; 
        border: 1px solid rgb(165, 159, 159);
        border-top: none;
        padding-top: 5px;
        padding: 10px
    }
    list-group{
        padding-left:0;
        margin-bottom:10px
    }
    .list-group-item{
        position:relative;
        display:block;
        padding:2px 2px;
        margin-bottom:-1px;
        background-color:#fff;
        border:1px solid #ddd
    }
    .indicator{
        font-weight: bolder;
        color: rgb(119, 150, 112);
        width: 140px; 
        text-align: right;
    }
</style>
<div class="" style="padding: 5px 5px 5px 20px;">
    <div class="columTop">
        <img style="float: left" src="../content/pictures-system/aboutUser.png" width="45px"/>
        <h3 style="color: #586951; margin-bottom: -5px; float: left">Datos de la cuenta</h3>
    </div>
    <div class="columBody">
        <div id='jqxNavigationBar'>
            <!--Header-->
            <div>Información personal</div>
            <!--Content-->
            <div>
                <form id="registerForm1" action="./">
                    <ul class="list-group" style="margin-left: 0px">
                        <li class="list-group-item">
                            <table>
                                <tr>
                                    <td class="indicator">Profesión</td>
                                    <td><input type="text" id="fl_profession" data-field="true" class="text-input" placeholder="Ing, Lic, Mti, etc..." /></td>
                                </tr>
                            </table>
                        </li>
                        <li class="list-group-item">
                            <table>
                                <tr>
                                    <td class="indicator">Nombre</td>
                                    <td><input type="text" id="fl_name_worker" data-field="true" class="text-input" placeholder="Nombre"/></td>
                                </tr>
                            </table>
                        </li>
                        <li class="list-group-item">
                            <table>
                                <tr>
                                    <td class="indicator">Apellido paterno</td>
                                    <td><input type="text" id="fl_patern_name" data-field="true" class="text-input" placeholder="Apellido paterno"/></td>
                                </tr>
                            </table>
                        </li>
                        <li class="list-group-item">
                            <table>
                                <tr>
                                    <td class="indicator">Apellido materno</td>
                                    <td><input type="text" id="fl_matern_name" data-field="true" class="text-input" placeholder="Apellido materno"/></td>
                                </tr>
                            </table>
                        </li>
                        <li class="list-group-item">
                            <table>
                                <tr>
                                    <td class="indicator">Clave Servidor Público</td>
                                    <td><input type="text" id="fl_key_sp" data-field="true" class="text-input" placeholder="Clave Servidor Público"/></td>
                                </tr>
                            </table>
                        </li>
                        <li class="list-group-item" style="height: 24px;">
                            <div class="successButton" id="saveRegisterForm">Guardar</div>                    
                        </li>
                    </ul>
                </form>
            </div>
            <!--Header-->
            <div>Datos de acceso</div>
            <!--Content-->
            <div>
                <form id="registerForm2" style="margin: 0px;">
                    <ul class="list-group" style="margin-left: 0px">
                        <li class="list-group-item">
                            <table>
                                <tr>
                                    <td class="indicator">Usuario</td>
                                    <td><input type="text" readonly="" id="fl_user_name" data-field="true" disabled="" class="text-input"/></td>
                                </tr>   
                            </table>
                        </li>
                        <li class="list-group-item">
                            <table>
                                <tr>
                                    <td class="indicator">Correo</td>
                                    <td><input type="text" id="fl_mail" data-field="true" class="text-input" placeholder="alguno@gmail.com"/></td>
                                </tr>   
                            </table>
                        </li>
                        <li class="list-group-item" style="height: 24px;">
                            <div class="successButton" id="saveRegisterForm2">Guardar</div>                       
                        </li>
                    </ul>
                </form>
                <form id="registerForm3">
                    <ul  class="list-group"  style="margin-left: 0px">
                        <li class="list-group-item">
                            <table>
                                <tr>
                                    <td class="indicator">Contraseña actual</td>
                                    <td><input type="password" id="fl_password_old" class="text-input"  placeholder="*****"/></td>
                                </tr>
                            </table>
                            <div style="right: 10px;position: absolute;top:0px;">
                                <span style="text-align: right">Cambiar</span><div id="buttonChange"></div>
                            </div>
                        </li>
                        <li class="list-group-item">
                            <table>
                                <tr>
                                    <td class="indicator">Nueva contraseña</td>
                                    <td><input type="password" id="fl_password" data-field="true" class="text-input"  placeholder="*****"/></td>
                                </tr>
                            </table>
                        </li>
                        <li class="list-group-item">
                            <table>
                                <tr>
                                    <td class="indicator">Confirmar nueva contraseña</td>
                                    <td><input type="password" id="fl_password_new_verify"  class="text-input"  placeholder="*****"/></td>
                                </tr>
                            </table>
                        </li>
                        <li class="list-group-item" style="height: 24px;">
                            <div class="successButton" id="saveRegisterForm3">Cambiar</div>                       
                        </li>
                    </ul>
                </form>
            </div>
            <!--Header-->
            <div>Forma de contacto</div>
            <!--Content-->
            <div>
                <form id="registerForm4" action="./">
                    <ul class="list-group" style="margin-left: 0px">
                        <li class="list-group-item">
                            <table>
                                <tr>
                                    <td class="indicator">Teléfono</td>
                                    <td><div id="fl_telephone_number" data-field="true"></div></td>
                                </tr>   
                            </table>
                        </li>
                        <li class="list-group-item">
                            <table>
                                <tr>
                                    <td class="indicator">Dirección</td>
                                    <td><td><textarea id="fl_addres" data-field="true"></textarea></td></td>
                                </tr>   
                            </table>
                        </li>                        
                        <li class="list-group-item" style="height: 24px;">
                            <div class="successButton" id="saveRegisterForm4">Guardar</div>                         
                        </li>
                    </ul>
                </form>
            </div>
        </div>
    </div>
</div>