<%
if(session.getAttribute("logueado") == null){%>
    <!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml">
        <head>
        <title>Bienvenido a SIUT</title>
            <meta name="viewport" content="width=device-width"/>
            <meta charset="UTF-8"/>
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <link title="SIUT" rel="icon" type="image/png" href="../content/pictures-system/favicon.png" />
            <link type="text/css" rel="Stylesheet" href="../content/files-jq/jqwidgets-ver3.8.2/jqwidgets/styles/jqx.base.css" />
            <link rel="stylesheet" href="../content/files-css/main-login.css" type="text/css"/>             
        </head>
        <body>
            <center>  
                <div id="stage">
                    <div style="display: none" id="windowBlock">
                        <div id="WindowLoad"></div>
                        <div id="loadingPicture"></div>
                    </div>
                    <span id="loginText" style="font-size: 50px; margin-left: -136px;">LOGIN</span>
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
                            </form><!--/ form-->
                            <div class="links">
                                <a id="dataRemenber" title="Tu contraseña sera enviada a tu correo" class="no-underline" href="#">¿Olvidaste tus datos de acceso?</a>
                            </div>
                        </section><!--/ seccion-->
                    </div>
                </div>
            </center>  
        </body>
        <script type="text/javascript" src="../content/files-jq/jquery-2.0.2.min.js"></script>
        <script type="text/javascript" src="../content/files-jq/jqwidgets-ver3.8.2/jqwidgets/jqxcore.js"></script>
        <script type="text/javascript" src="../content/files-jq/jqwidgets-ver3.8.2/jqwidgets/jqxpasswordinput.js"></script>
        <script type="text/javascript" src="../content/files-jq/jqwidgets-ver3.8.2/jqwidgets/jqxtooltip.js"></script>
        <script type="text/javascript" src="../content/files-jq/jqwidgets-ver3.8.2/jqwidgets/jqxinput.js"></script>
        <script type="text/javascript" src="../content/files-jq/jqwidgets-ver3.8.2/jqwidgets/jqxvalidator.js"></script>
        <script type="text/javascript" src="../content/files-jq/jqwidgets-ver3.8.2/jqwidgets/jqxdraw.js"></script>
        <script type="text/javascript" src="../content/files-jq/jqwidgets-ver3.8.2/jqwidgets/jqxchart.core.js"></script>
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
                                    window.location = "/admin";
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
<%}else{%>
    <!DOCTYPE html>
    <html lang="es">
        <head>
        <title>Bienvenido a SIUT</title>
            <meta charset="UTF-8"/>
            <link title="Bienvenido Home" rel="icon" type="image/png" href="../content/pictures-system/favicon.png" />
            <link rel="stylesheet" href="../content/files-css/main-system.css" type="text/css"/>
            <!-- Bootstrap core CSS -->
            <link href="../content/files-bs/bootstrap-3.2.0-dist/css/bootstrap.min.css" rel="stylesheet"/>
            <!-- jQWidgets CSS -->
            <link href="../content/files-jq/jqwidgets-ver3.8.2/jqwidgets/styles/jqx.base.css" rel="stylesheet"/>
            <link href="../content/files-jq/jqwidgets-ver3.8.2/jqwidgets/styles/jqx.bootstrap.css" rel="stylesheet"/>
            <link href="../content/files-css/clock.css" rel="stylesheet"/>
            <meta http-equiv="Expires" content="0" />
            <meta http-equiv="Pragma" content="no-cache" />
        </head>
        <body data-bind="greenUtsem">
            <div>
                <!-- Fixed column top-->
                <div id="culumna-top">
                    <div id="content-clock">
                        <div id="clock-analogic">	
                            <div id="secA"></div>
                            <div id="hourA"></div>
                            <div id="minA"></div>
                        </div>
                        <div id="clock-digital">
                            <div id="Date"></div>
                            <div class="ul">
                                <div class="li" id="hours"> </div>
                                <div class="li point">:</div>
                                <div class="li" id="min"> </div>
                                <div class="li point">:</div>
                                <div class="li" id="sec"> </div>
                            </div>
                        </div>
                        <div id="triegerCalendar" class="jqx-triangulo_der"></div>
                        <div id="content-caledar">
                            <div id='jqxWidgetCalendar'></div>
                        </div>
                    </div>
                    <div id="aboutSystem" style="width: 70px; position: fixed; text-align: center; font-size: 12px; cursor: pointer; right: 70px; top: 0px;">
                        <img src="../content/pictures-system/about-white.png" width="24px" style="padding: 10px 0 0 0;"/><br>
                        <span>Acerca de...</span>
                    </div>
                    <div id="helpSystem" style="width: 50px; position: fixed; text-align: center; font-size: 12px; cursor: help; right: 10px; top: 0px;">
                        <img src="../content/pictures-system/help2.png" width="24px" style="padding: 10px 0 0 0;"/>
                        <a href="../content/pictures-system/videos/teachers/siut.html" target="blanck"><span>Ayuda</span></a>
                    </div>
                    <div style="margin-left: 10px">
                        <span class="logoSiut">SIUT</span>
                        <h2 style="float: right; margin-right: 300px; color: #fff; margin-top: 20px;">
                            <span> Sistema Integral</span>
                            <b>
                                <span style="text-shadow: 4px 6px 0px #34610A; font-style: italic; font-size: 40px;">
                                    <span style="font-weight: 900; color: green">UT</span>sem
                                </span>
                            </b>
                        </h2>
                        <span style="margin-left: 35px; color: #fff; font-size: 28px; position: fixed; right: 300px; top: 60px;">
                            <div style="color: #fff; font-size: 14px; display: inline;">
                                <div class="btn-group navbar-right" style="">
                                    <img id="picturePerfil" style="cursor: pointer; float: left; margin-right: 15px; color: green; width: 25px; height: 25px;" src="../content/pictures-system/admin.png"/>
                                    <span style="float: left; height: 15px; border-left: 2px solid; width: 15px; margin-top: 8px;"></span>
                                    <b style="font-size: 14px; float: left; margin-top: 5px; margin-right: 5px;"><%out.print(" "+session.getAttribute("logueado"));%></b>
                                    <div  class="jqx-triangulo_inf"type="button" data-toggle="dropdown" aria-expanded="false">
                                        <%--<span class="caret" style="cursor: pointer"></span>--%>
                                    </div>
                                    <br>
                                    <ul class="dropdown-menu" role="menu" style="cursor: default">
                                        <li style="color: #54925F; padding-left: 10px" class="dropdown-header"><span><%out.print(" "+session.getAttribute("userRolName"));%></span> </li>
                                        <li style="cursor: pointer;"><a id="settingsAcount"><img src="../content/pictures-system/settings.acount.png"/> Configurar perfil</a></li>
                                        <li role="presentation" class="divider"></li>
                                        <li style="color: #54925F; padding-left: 10px" class="dropdown-header"><span>Salir</span></li>
                                        <li style="cursor: pointer;"><a id="logOut" href="../login?statusLogin"><img src="../content/pictures-system/logOut.png"/> Cerrar sesión</a></li>
                                    </ul>
                                </div>
                            </div> 
                        </span>
                        <span style="margin-left: 30px; color: #fff; font-size: 12px; position: fixed; right: 172px; top: 65px;">

                        </span>
                    </div>
                </div>
                <!-- Fixed column left -->
                <div id="culumna-left">
                    <div id="menu-despliegue" class="menu-despliegue-left"></div>
                </div>
                <!-- Fixed column bottom -->
                <div id="culumna-bottom">
                    <span style="float: left; margin-left: 20px;">Sistema desarrollado por la Universidad Tecnológica del Sur del Estado de México.</span>
                    <span style="float: right; margin-right: 20px;">siut© copyright 2015.</span>
                    <span style="float: right; margin-right: 20px; display: none">Guardando...<img src="../content/pictures-system/712.GIF"/></span>
                </div> 
                <div id="panel-principal">
                    <div id="jqxSplitter">
                        <div id='jqxWidget'>
                            <div id='jqxExpander'>
                                <div style="width: 100%">
                                    <span>Tareas comunes</span>
                                    <img id="infoImg"  style="cursor: help; float: right; margin-right: 10px" src="../content/pictures-system/about.png" width="20px"/>
                                </div>
                                <div style="overflow: hidden;">
                                    <div style="border: none;" id='jqxTree'></div>
                                </div>
                            </div>
                        </div>
                        <div id="ContentPanel"></div>
                    </div>
                </div>
            </div>
            <div id="load-page-external">
                <div>Cargando modulos...</div>
                <div id="loadExamPreview">
                    <img src="../content/pictures-system/load.GIF" width="60" style="margin-right: 20px" />
                    Procesando scripts y páginas asíncronas etc...
                </div>
            </div>
            <!--En esta parte importo mis archivos de jQuery boostrap y jQuery-UI
            ==================================================-->
            <script type="text/javascript" src="../content/files-jq/jquery-2.0.2.min.js"></script>
            <script type="text/javascript" src="../content/files-jq/jqwidgets-ver3.8.2/scripts/get-theme.js"></script>
            <script type="text/javascript" src="../content/files-jq/jqwidgets-ver3.8.2/jqwidgets/localization.js"></script>
            <script type="text/javascript" src="../content/files-bs/bootstrap-3.2.0-dist/js/bootstrap.min.js"></script>
            <script type="text/javascript" src="../content/files-jq/jquery-ui-1.11.1/jquery-ui.js"></script>
            <script type="text/javascript" src="../content/files-jq/jqwidgets-ver3.8.2/jqwidgets/jqx-all.js"></script>
            <script type="text/javascript" src="../content/files-jq/jqwidgets-ver3.8.2/jqwidgets/globalization/globalize.js"></script> 
            <script type="text/javascript" src="../content/files-jq/jqwidgets-ver3.8.2/jqwidgets/globalization/globalize.cultures.js"></script> 
            <script type="text/javascript" src="../content/files-jq/jquery.cookie.js"></script>
            <script type="text/javascript" src="../content/files-js/make-menu.js" charset="utf-8"></script>
            <script type="text/javascript" src="../content/files-js/make-combo.js"  charset="UTF-8"></script>
            <script type="text/javascript" src="../content/files-js/make-list.js"  charset="UTF-8"></script>
            <script type="text/javascript" src="../content/files-js/make-input.js"  charset="UTF-8"></script>
            <script type="text/javascript" src="../content/files-js/clock.js"  charset="UTF-8"></script>
        </body>
    </html>
<%}%>