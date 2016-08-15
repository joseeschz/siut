<%
String vertion = "jqwidgets-ver4.0.0";
if(session.getAttribute("logueado") == null){
    response.sendRedirect("/admin/login.jsp");
}else{%>
    <!DOCTYPE html>
    <html lang="es" manifest="file.manifest">
        <head>
        <title>Bienvenido a SIUT</title>
            <meta charset="UTF-8"/>
            <link title="Bienvenido Home" rel="icon" type="image/png" href="../content/pictures-system/favicon.png" />
            <link rel="stylesheet" href="../content/files-css/main-system.css" type="text/css"/>
<!--             Bootstrap core CSS 
            <link href="../content/files-bs/bootstrap-3.2.0-dist/css/bootstrap.min.css" rel="stylesheet"/>-->
            <!-- jQWidgets CSS -->
            <link href="../content/files-jq/<%out.print(vertion);%>/jqwidgets/styles/jqx.base.css" rel="stylesheet"/>
            <link href="../content/files-jq/<%out.print(vertion);%>/jqwidgets/styles/jqx.bootstrap.css" rel="stylesheet"/>
            <link href="../content/files-css/clock.css" rel="stylesheet"/>
            <script type="text/javascript" src="../content/files-jq/jquery-2.0.2.min.js"></script>
            <script>
                setInterval(function (){
                    logged();
                },300000);
                function logged(){
                    $.ajax({
                        type: "GET",
                        url: "../login?statusLogin=logged",
                        dataType: 'json',
                        async: true,
                        beforeSend: function (xhr) {
                            console.log("Checking session of out cache...");
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.log("Server is low");
                        },
                        success: function (data, textStatus, jqXHR) {
                             if(!data.status){
                                 window.location = "/admin/login.jsp";
                             }
                        }
                    });
                }
                logged();
            </script>
            <script>
                // Check if a new cache is available on page load.
                window.addEventListener('load', function(e) {
                    window.applicationCache.addEventListener('updateready', function(e) {
                        
                        if (window.applicationCache.status == window.applicationCache.UPDATEREADY) {
                            // Browser downloaded a new app cache.
                            // Swap it in and reload the page to get the new hotness.
                            console.log("Loading new version...");
                            window.applicationCache.swapCache();
                            window.location.reload();
                        } else {
                            // Manifest didn't changed. Nothing new to server.
                        }
                    }, false);

                }, false);
            </script>            
        </head>
        <body data-bind="greenUtsem">
            <div>
                <!-- Fixed column top-->
                <div id="culumna-top" class="">
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
                        <a href="../content/pictures-system/videos/teachers/siut.html" target="blanck"><span style="color: #fff">Ayuda</span></a>
                    </div>
                    <div style="margin-left: 10px">
                        <span class="logoSiut">SIUT</span>
                        <h2 style="float: right; margin-right: 300px; color: #fff; margin-top: 10px;">
                            <span> Sistema Integral</span>
                            <b>
                                <span style="text-shadow: 4px 6px 0px rgb(102, 102, 102); font-style: italic; font-size: 40px;">
                                    <span style="font-weight: 900; color: rgb(0, 119, 10)">UT</span>sem
                                </span>
                            </b>
                        </h2>
                        <span style="margin-left: 35px; color: #fff; font-size: 28px; position: fixed; right: 300px; top: 60px;">
                            <div style="color: #fff; font-size: 14px; display: inline;">
                                <div class="btn-group navbar-right" style="">
                                    <img id="picturePerfil" style="cursor: pointer; float: left; margin-right: 15px; color: green; width: 25px; height: 25px;" src="../content/pictures-system/admin.png"/>
                                    <span style="float: left; height: 15px; border-left: 2px solid; width: 15px; margin-top: 8px;"></span>
                                    <b id="caret" style="font-size: 14px; float: left; margin-top: 5px; margin-right: 5px;"><%out.print(" "+session.getAttribute("logueado"));%></b>
                                    <div class="jqx-triangulo_inf" type="button" data-toggle="dropdown" aria-expanded="false"></div>
                                    <div id="popover">
                                        <div> 
                                            <div id='jqxMenuOptions'>
                                                <ul style="display: none">
                                                    <li id="userName"><span><%out.print(" "+session.getAttribute("userName"));%></span> </li>
                                                    <li><span id="settingsAcount"><img src="../content/pictures-system/settings.acount.png"/> Configurar perfil</span></li>
                                                    <li style="width: 180px"  type='separator'></li>
                                                    <li style="width: 30px" id="close"><span>Salir</span></li>
                                                    <li><a id="logOut" href="../login?statusLogin"><img src="../content/pictures-system/logOut.png"> Cerrar sesión</a></li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div> 
                        </span>
                    </div>
                </div>
                <!-- Fixed column left -->
                <div id="culumna-left" class="">
                    <div id="menu-despliegue" class="menu-despliegue-left"></div>
                </div>
                <!-- Fixed column bottom -->
                <div id="culumna-bottom" class="">
                    <span style="float: left; margin-left: 20px;">Sistema desarrollado por la Universidad Tecnológica del Sur del Estado de México.</span>
                    <span style="float: right; margin-right: 20px;">siut© copyright 2015. Versión 1.0.1.1</span>
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
                    <span>Procesando scripts y páginas asíncronas etc...</span>
                </div>
            </div>
            <!--En esta parte importo mis archivos de jQuery boostrap y jQuery-UI
            ==================================================-->
            
            <script type="text/javascript" src="../content/files-jq/<%out.print(vertion);%>/scripts/get-theme.js" charset="UTF-8"></script>
            <script type="text/javascript" src="../content/files-jq/<%out.print(vertion);%>/jqwidgets/localization.js" charset="UTF-8"></script>
            <!--<script type="text/javascript" src="../content/files-bs/bootstrap-3.2.0-dist/js/bootstrap.min.js"></script>-->
            <!--<script type="text/javascript" src="../content/files-jq/jquery //-ui-1.11.1/jquery-ui.js"></script>-->
            <script type="text/javascript" src="../content/files-jq/<%out.print(vertion);%>/jqwidgets/jqx-all.js" charset="UTF-8"></script>
            <script type="text/javascript" src="../content/files-jq/<%out.print(vertion);%>/jqwidgets/globalization/globalize.js" charset="UTF-8"></script> 
            <script type="text/javascript" src="../content/files-jq/<%out.print(vertion);%>/jqwidgets/globalization/globalize.cultures.js" charset="UTF-8"></script> 
            <script type="text/javascript" src="../content/files-jq/jquery.cookie.js"></script>
            <script type="text/javascript" src="../content/files-js/make-menu.js" charset="UTF-8"></script>
            <script type="text/javascript" src="../content/files-js/make-combo.origin.js"  charset="UTF-8"></script>
            <script type="text/javascript" src="../content/files-js/make-list.js"  charset="UTF-8"></script>
            <script type="text/javascript" src="../content/files-js/make-input.js"  charset="UTF-8"></script>
            <script type="text/javascript" src="../content/files-js/clock.js"  charset="UTF-8"></script>
        </body>
    </html>
<%}%>