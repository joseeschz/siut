<%
String vertion = "jqwidgets-ver4.0.0";
if(session.getAttribute("logueado") == null){%>
    <!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml" manifest="file.manifest">
        <head>
            <title>Bienvenido a SIUT</title>
            <meta name="viewport" content="width=device-width"/>
            <meta charset="UTF-8"/>
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <link title="SIUT" rel="icon" type="image/png" href="../content/pictures-system/favicon.png" />
            <link type="text/css" rel="Stylesheet" href="../content/files-jq/<%out.print(vertion);%>/jqwidgets/styles/jqx.base.css" />
            <link rel="stylesheet" href="../content/files-css/main-login.css" type="text/css"/>
            <script>                
                // Check if a new cache is available on page load.
                window.addEventListener('load', function(e) {
                    window.applicationCache.addEventListener('updateready', function(e) {
                        
                        if (window.applicationCache.status == window.applicationCache.UPDATEREADY) {
                            // Browser downloaded a new app cache.
                            // Swap it in and reload the page to get the new hotness.
                            window.applicationCache.swapCache();
                            window.location.reload();
                        } else {
                            // Manifest didn't changed. Nothing new to server.
                        }
                    }, false);

                }, false);
            </script>
            <script type="text/javascript" src="../content/files-jq/jquery-2.0.2.min.js"></script>
            <script>
                 $.ajax({
                    type: "GET",
                    url: "../login?statusLogin=logged",
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
                            window.location = "/admin/system.jsp";
                        }
                    }
                });
            </script>
        </head>
        <body>
            <center>  
                <div id="stage">
                    <div style="display: none" id="windowBlock">
                        <div id="WindowLoad"></div>
                        <div id="loadingPicture"></div>
                    </div>
                    <span id="loginText" style="font-size: 50px; margin-left: -140px;">LOGIN</span>
                    <div id="logo-lock" class="fade-down-logo" title="Login" style="opacity: 1;"></div> 
                    <span id="logoSiut">SIUT</span>
                    <span id="MessageError" style="display: none; position:absolute; color: red; font-size: 22px; right: 30px; top: 100px">Error datos incorrectos</span>
                    <div id="intro" style="display: block;">
                        <section>
                            <form id="formLogin" method="post" >
                                <div id="tmm-form-wizard" class="form-login substrate">
                                    <div style="position: relative; height: 80px;">
                                        <div class="label-row">
                                            <label for="email">E-mail</label>
                                        </div>
                                        <div class="input-row">
                                            <input title="Ingresa tu correo para poder ingresar" name="userName" type="text" id="nameUser"autofocus="" placeholder="Nombre de usuario">
                                        </div>
                                    </div>
                                    <div style="position: relative; height: 80px;">
                                        <div class="label-row">
                                            <label for="password">Password</label>
                                        </div>
                                        <div class="input-row">
                                            <input title="Ingresa tu contraseña para poder ingresar" name="password" type="password" id="password" placeholder="Contraseña">
                                        </div>
                                    </div>
                                </div>
                                <div class="description">Inicia sesión para administrar tus actividades.</div>
                                <div class="button-row">
                                    <input type="submit" id="buttonGetStarted" class="button" value="Ingresar" />
                                </div>
                            </form>
                            <div class="links">
                                <a id="dataRemenber" title="Tu contraseña sera enviada a tu correo" class="no-underline" href="#">¿Olvidaste tus datos de acceso?</a>
                            </div>
                        </section>
                    </div>
                </div>
                
            </center>  
        </body>
        
        <script type="text/javascript" src="../content/files-jq/<%out.print(vertion);%>/jqwidgets/jqxcore.js"></script>
        <script type="text/javascript" src="../content/files-jq/<%out.print(vertion);%>/jqwidgets/jqxpasswordinput.js"></script>
        <script type="text/javascript" src="../content/files-jq/<%out.print(vertion);%>/jqwidgets/jqxinput.js"></script>
        <script type="text/javascript" src="../content/files-jq/<%out.print(vertion);%>/jqwidgets/jqxvalidator.js"></script>
        <script type="text/javascript">
            $(document).ready(function (){   
                window.location.hash="";
                window.location.hash=""; //chrome
                window.onhashchange=function(){window.location.hash="";};
                //window.location.href.replace( /#.*/, "");
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
                $("#buttonGetStarted").click(function (){
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
                        url: "../login?statusLogin=in",
                        data:datos,
                        beforeSend: function (xhr) {
                            $("#windowBlock").fadeIn("slow");
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            alert("Error interno del servidor");
                            $("#windowBlock").fadeOut("slow");
                        },
                        success: function (data, textStatus, jqXHR) {
                            if(data==="logeado"){
                                setTimeout(function(){
                                    $("#windowBlock").fadeOut("slow");
                                    window.location = "/admin/system.jsp";
                                }, 2000);
                            }else if(data==="notExit"){
                                $("#windowBlock").fadeOut("slow");
                                $("#MessageError").fadeIn("slow");
                            }
                        }
                    });
                });
            });
        </script>
    </html>
<%}else{
    response.sendRedirect("/admin/system.jsp");
}%>