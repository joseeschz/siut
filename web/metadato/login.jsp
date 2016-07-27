<%
    String vertion = "jqwidgets-ver4.0.0";
    if(session.getAttribute("logueadoStudent") == null){%>
        <!DOCTYPE html>
        <html xmlns="http://www.w3.org/1999/xhtml" manifest="file.manifest">
            <head>
            <title>Login SIUT</title>
                <meta name="viewport" content="width=device-width"/>
                <meta charset="UTF-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1">
                    <link title="SIUT" rel="icon" type="image/png" href="../../content/pictures-system/favicon.png" />
                <link type="text/css" rel="Stylesheet" href="../content/files-jq/<%out.print(vertion);%>/jqwidgets/styles/jqx.base.css" />
                <link rel="stylesheet" href="../content/files-css/main-login.css" type="text/css"/>  
                <!--<link rel="stylesheet" href="../content/files-css/main-login-new-register.css" type="text/css"/>-->     
                <link type="text/css" rel="Stylesheet" href="../content/files-jq/<%out.print(vertion);%>/jqwidgets/styles/jqx.theme-utsem.css" />
                <script type="text/javascript" src="../content/files-jq/jquery-2.0.2.min.js"></script>
                <script>
                     $.ajax({
                        type: "GET",
                        url: "../serviceStudent?selectLoginStudent&&statusLogin=logged",
                        dataType: 'json',
                        async: false,
                        beforeSend: function (xhr) {
                            console.log("Checking session of out cache...");
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) {
                            if(data.status){
                                window.location = "/metadato/module.jsp";
                            }
                        }
                    });
                </script>
                <script>
                    // Check if a new cache is available on page load.
                    window.addEventListener('load', function(e) {
                        window.applicationCache.addEventListener('updateready', function(e) {
                            if (window.applicationCache.status == window.applicationCache.UPDATEREADY) {
                                // Browser downloaded a new app cache.
                                // Swap it in and reload the page to get the new hotness.
                                console.log("Updating cache...");
                                window.applicationCache.swapCache();
                                window.location.reload();
                            } else {
                                // Manifest didn't changed. Nothing new to server.
                            }
                        }, false);
                    }, false);
                </script>
            </head>
            <body>
                <center>  
                    <div id="stage">
                        <div style="display: none" id="windowBlock">
                            <div id="WindowLoad"></div>
                            <div id="loadingPicture"></div>
                        </div>
                        <span id="loginText" style="font-size: 35px; line-height: normal;">METADATO</span><br><br>  
                        <span id="MessageError" style="display: none; position:absolute; color: red; font-size: 18px; right: 20px; top: 90px">Error datos incorrectos</span>
                        <div id="intro" style="display: block;">
                            <section>
                                <form id="formLogin" method="post" >
                                    <input type="hidden" name="statusLogin" value="in"/>
                                    <div id="tmm-form-wizard" class="form-login substrate">
                                        <div style="position: relative; height: 70px;">
                                            <div class="label-row">
                                                <label for="env">Matrícula</label>
                                            </div>
                                            <div class="input-row">
                                                <input title="Ingresa tu matrícula para poder ingresar" name="userName" type="text" id="nameUser"autofocus="" placeholder="UTSXXS-00XXXX">
                                            </div>
                                        </div>
                                        <div style="position: relative; height: 70px;">
                                            <div class="label-row">
                                                <label for="password">Contraseña</label>
                                            </div>
                                            <div class="input-row">
                                                <input title="Ingresa tu contraseña para poder ingresar" name="password" type="password" id="password" placeholder="Contraseña">
                                            </div>
                                        </div>
                                    </div>
                                    <!--<div class="description">Inicia sesión para completar tu registro.</div>-->  
                                    <div class="description" id="rememberPass" style="cursor: pointer; text-decoration: underline; font-size: 18px; text-align: right;">No recuerdo mi contraseña</div>
                                    <div class="button-row">
                                        <input type="submit" id="buttonGetStarted" class="button" value="Ingresar" />
                                    </div>

                                </form><!--/ form-->
                            </section><!--/ seccion-->
                            <a title="Información requerida" style="color: rgb(66, 79, 89); text-decoration: none; position: absolute; right: 20px; bottom: 2px;" href="../content/files-pdf/metadata.pdf" download="Documento piloto de metadato.pdf"><img src="../content/pictures-system/pdf.png"></a>
                        </div>
                    </div>
                    <div id="stage" class="rememberPass" style="display: none">
                        <div style="display: none" id="windowBlockRemember">
                            <div id="WindowLoad"></div>
                            <div id="loadingPicture"></div>
                        </div>
                        <span id="MessageError" style="display: none; position:absolute; color: red; font-size: 18px; right: 20px; top: 90px">Error datos incorrectos</span>
                        <div id="intro" style="display: block;">
                            <section>
                                <form id="formLoginRemember" method="post" >
                                    <div id="tmm-form-wizard" class="form-login substrate">
                                        <div style="position: relative; height: 70px;">
                                            <div class="label-row">
                                                <label for="env">Matrícula</label>
                                            </div>
                                            <div class="input-row">
                                                <input title="Ingresa tu matrícula para poder ingresar" name="enrollment" type="text" id="enrollment"autofocus="" placeholder="UTSXXS-00XXXX">
                                            </div>
                                        </div>
                                        <div style="position: relative; height: 70px;">
                                            <div class="label-row">
                                                <label for="password">Correo</label>
                                            </div>
                                            <div class="input-row">
                                                <input title="Ingresa tu contraseña para poder ingresar" name="mail" type="text"  id="mail" placeholder="Correo">
                                            </div>
                                        </div>
                                    </div><br>
                                    <div class="description">Indica tu matrícula y correo.</div>                                    
                                    <div class="button-row">
                                        <input type="submit" id="buttonRemember" class="button" value="Recordar" />
                                    </div>
                                    <div class="description" id="back" style="cursor: pointer; text-decoration: underline; font-size: 18px; text-align: right;">Regresar</div>
                                </form><!--/ form-->
                            </section><!--/ seccion-->
                        </div>
                    </div>
                </center>  
                <div id='jqxwindow' style="display: none">
                    <div>Mensaje</div>
                    <div style="padding: 20px">
                        <span id="message"></span>
                        <br><br>
                        <div style="text-align: center">
                            <input type="button" id="okMessage" value="Aceptar" style="margin-right: 10px" />
                        </div>
                    </div>
                </div>
            </body>
            <script type="text/javascript" src="../content/files-jq/<%out.print(vertion);%>/jqwidgets/localization.js"></script>
            <script type="text/javascript" src="../content/files-jq/<%out.print(vertion);%>/jqwidgets/jqxcore.js"></script>
            <script type="text/javascript" src="../content/files-jq/<%out.print(vertion);%>/jqwidgets/jqxpasswordinput.js"></script>
            <script type="text/javascript" src="../content/files-jq/<%out.print(vertion);%>/jqwidgets/jqxtooltip.js"></script>
            <script type="text/javascript" src="../content/files-jq/<%out.print(vertion);%>/jqwidgets/jqxinput.js"></script>
            <script type="text/javascript" src="../content/files-jq/<%out.print(vertion);%>/jqwidgets/jqxvalidator.js"></script>
            <script type="text/javascript" src="../content/files-jq/<%out.print(vertion);%>/jqwidgets/jqxwindow.js"></script>
            <script type="text/javascript" src="../content/files-jq/<%out.print(vertion);%>/jqwidgets/jqxbuttons.js"></script>
            <script type="text/javascript">
                $(document).ready(function (){
                    $("#jqxwindow").jqxWindow({
                        height: 130,
                        width: 350,
                        theme: 'greenUtsem',
                        autoOpen: false,
                        isModal: true,
                        showCloseButton: true,
                        resizable: false,
                        position: "center",
                        okButton: $('#okMessage'),
                        initContent: function () {
                            $('#okMessage').jqxButton({
                                width: '65px',
                                theme: 'greenUtsem'
                            });
                            $('#okMessage').focus();
                        }
                    });
                    $("#password").jqxPasswordInput({width: '260px', showStrength: false, showStrengthPosition: "right" });
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
                    $("#formLoginRemember").jqxValidator({
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
                                input: "#mail", 
                                message: "El correo es necesario!", 
                                action: 'keyup, blur', 
                                rule: 'required' 
                            },
                            {   
                                input: "#mail", 
                                message: "El correo parece ser incorrecto", 
                                action: 'keyup, blur', 
                                rule: 'email' 
                            }
                        ]
                    });
                    $("#buttonGetStarted").click(function (){
                        $('#formLogin').jqxValidator('validate');
                        return false;
                    });
                    $("#buttonRemember").click(function (){
                        $('#formLoginRemember').jqxValidator('validate');
                        return false;
                    });
                    $('#formLogin').submit(function (){
                        $('#formLogin').jqxValidator('validate');
                    });
                    $('#formLoginRemember').submit(function (){
                        $('#formLoginRemember').jqxValidator('validate');
                    });
                    $('#formLogin').on('validationSuccess', function (event) {
                        //en el evento submit del fomulario
                        var datos = $("#formLogin").serialize(); // los datos del 
                        $.ajax({
                            type: "POST",
                            dataType: 'json',
                            async: true,
                            url: "../serviceStudent?selectLoginStudent=in&&typeLogin=metadata",
                            data:datos,
                            beforeSend: function (xhr) {
                                $("#windowBlock").fadeIn("slow");
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                alert("Error interno del servidor");
                                $("#windowBlock").fadeOut("slow");
                            },
                            success: function (data, textStatus, jqXHR) {
                                if(data.statusLogin==="logeado"){
                                    setTimeout(function(){
                                        $("#windowBlock").fadeOut("slow");
                                        window.location = "/metadato/";
                                    }, 2000);
                                }else if(data.statusLogin==="notExit"){
                                    $("#windowBlock").fadeOut("slow");
                                    $("#MessageError").fadeIn("slow");
                                }
                            }
                        });
                    });
                    $('#formLoginRemember').on('validationSuccess', function (event) {
                        //en el evento submit del fomulario
                        var datos = $("#formLoginRemember").serialize(); // los datos del 
                        $.ajax({
                            type: "POST",
                            async: true,
                            url: "../serviceMail?rememberPassword",
                            data:datos,
                            beforeSend: function (xhr) {
                                $("#windowBlockRemember").fadeIn("slow");
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                alert("Error interno del servidor");
                                $("#windowBlockRemember").fadeOut("slow");
                            },
                            success: function (data, textStatus, jqXHR) {
                                console.log(data.statusSendMail)
                                if(data.statusSendMail==="Success"){
                                    $("#message").text("Se envió correctamente el recordatorio al correo, favor de revisar...");  
                                }else if(data.statusSendMail==="EmailNotFountForEnrrollment"){
                                    $("#message").text("Lo sentimos los datos no fueron ingresados de forma correcta favor de verificar...");  
                                }else if(data.statusSendMail==="FailConnectionNetwork"){
                                    $("#message").text("Lamentamos que estemos teniendo problemas de conexión favor de intentar mas tarde.");  
                                }else{
                                    $("#message").text("Al parecer el correo que ingreso no es correcto, intenta corregir este problema.");  
                                }
                                $("#jqxwindow").jqxWindow("open");
                                $("#windowBlockRemember").fadeOut("slow");
                            }
                        });
                    });
                    $("#rememberPass").click(function (){
                        $("#stage").fadeOut("slow");
                        setTimeout(function(){
                            $(".rememberPass").fadeIn("slow");
                        },700);                        
                    });
                    $("#back").click(function (){
                        $(".rememberPass").fadeOut("slow");
                        setTimeout(function(){
                            $("#stage").fadeIn("slow");
                        },700);     
                    });
                });
            </script>
        </html>
    <%}else{
        response.sendRedirect("/module.jsp");
    }%>