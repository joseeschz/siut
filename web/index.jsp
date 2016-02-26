<%
    if(session.getAttribute("logueadoStudent") == null){%>
    <!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml">
        <head>
        <title>Login SIUT</title>
            <meta name="viewport" content="width=device-width"/>
            <meta charset="UTF-8"/>
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <link title="SIUT" rel="icon" type="image/png" href="content/pictures-system/favicon.png" />
            <link rel="stylesheet" href="content/files-css/normalize.css" type="text/css"/>
            <link rel="stylesheet" href="content/files-css/aboutaccounts.css" type="text/css"/>
            <link rel="stylesheet" href="content/files-css/main.css" type="text/css"/>
        </head>
        <body>
            <div id="stage" style="display: block;">
                <div style="display: none" id="windowBlock">
                    <div id="WindowLoad"></div>
                    <div id="loadingPicture"></div>
                </div>
                <div id="intro" style="display: block;">
                    <header>
                        <span id="loginText">LOGIN</span>
                        <div id="logo-lock" class="fade-down-logo" title="Login" style="opacity: 1;"></div> 
                        <span id="logoSiut">SIUT</span>
                    </header>
                    <section>
                        <form id="formLogin"  method="post" role="form">
                            <div id="tmm-form-wizard" class="form-login substrate">
                                <input type="hidden" name="statusLogin" value="in"/>
                                <div class="label-row">
                                    <label for="env">Matrícula</label>
                                </div>
                                <div class="input-row">
                                    <input title="Ingresa tu matrícula para poder ingresar" name="enrollment" type="text" id="nameUser" autofocus="" placeholder="UTSXXS-00XXXX">
                                </div>
                                <br><br>
                                <div class="label-row">
                                    <label for="password">Password</label>
                                </div>
                                <div class="input-row">
                                    <input title="Ingresa tu contraseña para poder ingresar" class="password" type="password" required="" id="password" autofocus="" name="password" placeholder="Contraseña">
                                </div>
                                <div>
                                    <label id="error"></label>
                                </div>
                            </div>
                            <br>
                            <div class="description">Inicia sesión para ver tus avances.</div>
                            <div class="button-row">
                                <input type="submit" id="sendButton" class="button" value="Ingresar" />
                            </div>
                        </form><!--/ form-->
                        <form id="formLoginValidate" style="display: none"  method="post" role="form">
                            <div id="tmm-form-wizard" class="form-login substrate">
                                <input type="hidden" name="statusLogin" value="in"/>
                                <div class="label-row">
                                    <label for="env">Matrícula</label>
                                </div>
                                <div class="input-row">
                                    <input disabled="" title="Matrícula" name="enrollment" type="text" id="enrollment" autofocus="" placeholder="UTSXXS-00XXXX">
                                </div>
                                <br><br>
                                <div class="label-row">
                                    <label for="email">Correo</label>
                                </div>
                                <div class="input-row">
                                    <input disabled="" title="Correo electrónico" class="email" type="text" required="" id="email" autofocus="" name="email" placeholder="Correo electrónico">
                                        <input title="Ingresa tu contraseña para poder ingresar" class="password" type="hidden" required="" id="passwordHidden" autofocus="" name="password" placeholder="Contraseña">
                                </div>
                                <div>
                                    <label id="error"></label>
                                </div>
                            </div>
                            <br>
                                <div class="">Valida tu correo, si no cuentas con un correo asociado a esta cuenta favor de asociarlo en el <a style="color: #fff" href="metadato/"> metadato.</a></div>
                            <div class="button-row">
                                <input type="submit" id="sendButtonValidate" class="button" value="Validar" />
                            </div>
                        </form><!--/ form-->
                        <div class="links">
                        </div>
                    </section><!--/ seccion-->
                </div>
            </div>  
        </body>
        <script type="text/javascript" src="content/files-jq/jquery-2.0.2.min.js"></script>
        <script type="text/javascript" src="content/files-jq/jqwidgets-ver3.8.2/jqwidgets/localization.js"></script>
        <script type="text/javascript" src="content/files-jq/jqwidgets-ver3.8.2/jqwidgets/jqxcore.js"></script>
        <script type="text/javascript" src="content/files-jq/jqwidgets-ver3.8.2/jqwidgets/jqxpasswordinput.js"></script>
        <script type="text/javascript" src="content/files-jq/jqwidgets-ver3.8.2/jqwidgets/jqxtooltip.js"></script>
        <script type="text/javascript" src="content/files-jq/jqwidgets-ver3.8.2/jqwidgets/jqxinput.js"></script>
        <script type="text/javascript" src="content/files-jq/jqwidgets-ver3.8.2/jqwidgets/jqxvalidator.js"></script>
        <script type="text/javascript" src="content/files-jq/jquery-migrate-1.3.0.min.js"></script>
        <link type="text/css" rel="Stylesheet" href="content/files-jq/jqwidgets-ver3.8.2/jqwidgets/styles/jqx.theme-utsem.css" />
        <script type="text/javascript">
            $(document).ready(function (){
//                jQuery.each( jQuery.browser, function( i, val ) {
//                    $( "<div>" + i + " : <span>" + val + "</span>" )
//                    .appendTo( document.body );
//                });
//                console.log(window.opera);
//                if ($.browser.opera) {
//                    $("body").children().css({"display":"none"});
//                    $("body").append("<h1>Esté sistema no es compatible con este navegador :(");
//                }
                $("#password, #nameUser").focusin(function (){
                    $("#MessageError").fadeOut("slow");
                });
                $("#formLogin").jqxValidator({
                    hintType: 'label',
                    animationDuration: 0,
                    rules: [
                        {
                            input: "#nameUser", 
                            message: "Este campo es requerido!", 
                            action: 'keyup, blur', 
                            rule: "required"
                        },
                        {   
                            input: "#password", 
                            message: "La contraseña es necesaria!", 
                            action: 'keyup, blur', 
                            rule: 'required' 
                        }
                    ]
                });
                $("#sendButton").click(function (){
                    $('#formLogin').jqxValidator('validate');
                    return false;
                });
                $('#formLogin').submit(function (){
                    $('#formLogin').jqxValidator('validate');
                });
                $('#formLogin').on('validationSuccess', function (event) {
                    //en el evento submit del fomulario
                    var datos = $("#formLogin").serialize(); // los datos del 
                    $.ajax({
                        type: "POST",
                        url: "serviceStudent?selectLoginStudent",
                        data: datos,
                        beforeSend: function (xhr) {
                            $("#windowBlock").fadeIn("slow");
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            alert("Error interno del servidor");
                            $("#windowBlock").fadeOut("slow");
                        },
                        success: function (data, textStatus, jqXHR) {
                            if(data==="notMailActive"){
                                ActivateMail(datos);
                            }else if(data==="logeado"){
                                setTimeout(function(){
                                    $("#windowBlock").fadeOut("slow");
                                    window.location = "alumnos/";
                                }, 2000);
                            }else if(data==="notExit"){
                                $("#windowBlock").fadeOut("slow");
                                $("#MessageError").fadeIn("slow");
                                alert("Verifica tus datos");
                            }
                        }
                    });
                });
                function ActivateMail(datas){                    
                    $.ajax({
                        type: "POST",
                        url: "activeMail?selectLoginStudent",
                        data: datas,
                        beforeSend: function (xhr) {
                            $("#windowBlock").fadeIn("slow");
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            alert("Error interno del servidor");
                            $("#windowBlock").fadeOut("slow");
                        },
                        success: function (data, textStatus, jqXHR) {
                            $("#windowBlock").fadeOut("slow");
                            $("#enrollment").val($("#nameUser").val());
                            $("#email").val(data);
                            $("#passwordHidden").val($("#password").val());
                            $("#formLogin").hide();
                            $("#formLoginValidate").show();
                            
                        }
                    });
                }
                $("#formLoginValidate").jqxValidator({
                    hintType: 'label',
                    animationDuration: 0,
                    rules: [
                        {
                            input: "#enrollment", 
                            message: "Este campo es requerido!", 
                            action: 'keyup, blur', 
                            rule: "required"
                        },
                        {   
                            input: "#email", 
                            message: "El correo es necesario!", 
                            action: 'keyup, blur', 
                            rule: 'required' 
                        },
                        {   
                            input: "#email", 
                            message: "El correo no tiene un formato valido!", 
                            action: 'keyup, blur', 
                            rule: 'email' 
                        }
                    ]
                });
                $("#sendButtonValidate").click(function (){
                    $('#formLoginValidate').jqxValidator('validate');
                    return false;
                });
                $('#formLoginValidate').submit(function (){
                    $('#formLoginValidate').jqxValidator('validate');
                });
                $('#formLoginValidate').on('validationSuccess', function (event) {
                    //en el evento submit del fomulario
                    var datos = $("#formLoginValidate").serialize(); // los datos del 
                    $.ajax({
                        type: "POST",
                        url: "serviceMail?validateMail",
                        data: {
                            "userName": $("#enrollment").val(),
                            "email": $("#email").val(),
                            "password" : $("#password").val(),
                            "statusLogin":"in"
                        },
                        beforeSend: function (xhr) {
                            $("#windowBlock").fadeIn("slow");
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            alert("Error interno del servidor");
                            $("#windowBlock").fadeOut("slow");
                        },
                        success: function (data, textStatus, jqXHR) {
                            console.log(datos);
                            $("#windowBlock").fadeOut("slow");
                        }
                    });
                });
            });
        </script>
    </html>
<%}else{
    response.sendRedirect("alumnos/");
}%>