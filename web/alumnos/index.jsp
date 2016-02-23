<%
    if(session.getAttribute("logueadoStudent") != null){%>
<!DOCTYPE html>
<html lang="ES">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>SIUT-alumnos</title>
        <link title="Bienvenido" rel="icon" type="image/png" href="../content/pictures-system/favicon.png" />
        <link href="../content/files-jq/jqwidgets-ver3.8.2/jqwidgets/styles/jqx.base.css" rel="stylesheet"/>
        <link href="../content/files-jq/jqwidgets-ver3.8.2/jqwidgets/styles/jqx.bootstrap.css" rel="stylesheet"/>
        <link href="css/bootstrap.minP.css" rel="stylesheet">
        <link href="css/sb-admin.css" rel="stylesheet">
        <link href="css/plugins/morris.css" rel="stylesheet">
        <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <div id="wrapper">
           <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                        <span class="sr-only">Navegación</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <span id="logoSiut">SIUT</span>
                    <ul class="nav navbar-left top-nav">
                        <li class="dropdown" style="margin-left: 100px;">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-envelope"></i> <b class="caret"></b></a>
                            <ul class="dropdown-menu message-dropdown">
                                <li class="message-preview">
                                    <a href="#">
                                        <div class="media">
                                            <span class="pull-left">
                                                <img class="media-object" src="http://placehold.it/50x50" alt="">
                                            </span>
                                            <div class="media-body">
                                                <h5 class="media-heading"><strong><%out.print(session.getAttribute("logueadoStudent"));%></strong>
                                                </h5>
                                                <p class="small text-muted"><i class="fa fa-clock-o"></i> Ayer a las 4:32 PM</p>
                                                <p>Hola...</p>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                                <li class="message-preview">
                                    <a href="#">
                                        <div class="media">
                                            <span class="pull-left">
                                                <img class="media-object" src="http://placehold.it/50x50" alt="">
                                            </span>
                                            <div class="media-body">
                                                <h5 class="media-heading"><strong><%out.print(session.getAttribute("logueadoStudent"));%></strong>
                                                </h5>
                                                <p class="small text-muted"><i class="fa fa-clock-o"></i> Ayer a las 4:32 PM</p>
                                                <p>Hola...</p>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                                <li class="message-preview">
                                    <a href="#">
                                        <div class="media">
                                            <span class="pull-left">
                                                <img class="media-object" src="http://placehold.it/50x50" alt="">
                                            </span>
                                            <div class="media-body">
                                                <h5 class="media-heading"><strong><%out.print(session.getAttribute("logueadoStudent"));%></strong>
                                                </h5>
                                                <p class="small text-muted"><i class="fa fa-clock-o"></i> Ayer a las 4:32 PM</p>
                                                <p>Hola...</p>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                            </ul>
                            <div class="dropdown-menu" id="emails">
                                <footer>
                                    <li class="message-footer">
                                        <a href="#">Leer todos los correos</a>
                                    </li>
                                </footer>
                            </div>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-bell"></i> <b class="caret"></b></a>
                            <ul class="dropdown-menu alert-dropdown">
                                <li>
                                    <a href="#">No hay actividades pendiestes <span class="label label-default"></span></a>
                                </li>
                                <li class="divider"></li>
                                <li>
                                    <a href="#">Ver todo</a>
                                </li>
                            </ul>
                        </li>
                        <li class="dropdown" id="optionsUser">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> <%out.print(session.getAttribute("logueadoStudent"));%> <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li>
                                    <a href="#"><i class="fa fa-fw fa-user"></i> Perfil</a>
                                </li>
                                <li>
                                    <a href="#"><i class="fa fa-fw fa-envelope"></i> Correos</a>
                                </li>
                                <li>
                                    <a href="#"><i class="fa fa-fw fa-gear"></i> Ajustes</a>
                                </li>
                                <li class="divider"></li>
                                <li>
                                    <a href="../serviceStudent?selectLoginStudent&statusLogin"><i class="fa fa-fw fa-power-off"></i> Cerrar sesión</a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
                
                <div class="collapse navbar-collapse navbar-ex1-collapse">
                    <ul class="nav navbar-nav side-nav">
                        <li class="active">
                            <a href="#" myhref="principal"><i class="fa fa-fw fa-dashboard"></i> Principal</a>
                        </li>
                        <li>
                            <a href="javascript:;" data-target="#califications" data-toggle="collapse">
                                <i class="fa fa-fw fa-bar-chart-o"></i> Calificaciones <i class="fa fa-fw fa-caret-down"></i>
                            </a>
                            <ul id="califications" class="collapse">
                                <li>
                                    <a data-toggle="collapse" data-target=".navbar-ex1-collapse" href="#" myhref="qualifications-activities">
                                        <span class="loadingLinks"></span>Por actividades
                                    </a>
                                </li>
                                <li>
                                    <a data-toggle="collapse" data-target=".navbar-ex1-collapse" href="#" myhref="qualifications-matters">
                                        <span class="loadingLinks"></span>Por materias
                                    </a>
                                </li>
                                <li>
                                    <a data-toggle="collapse" data-target=".navbar-ex1-collapse" href="#" myhref="qualifications-history">
                                        <span class="loadingLinks"></span>Historial acádemico
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a data-toggle="collapse" data-target=".navbar-ex1-collapse" href="#" myhref="horary"><i class="fa fa-fw fa-table"></i> Horario</a>
                        </li>
                        <li>
                            <a data-toggle="collapse" data-target=".navbar-ex1-collapse" href="#" myhref="calendar"><i class="fa fa-fw fa-edit"></i> Calendario</a>
                        </li>
                        <li>
                            <a href="javascript:;" class="publications" data-toggle="collapse" data-target="#demo"><i class="fa fa-fw fa-arrows-v"></i> Publicaciones <i class="fa fa-fw fa-caret-down"></i></a>
                            <ul id="demo" class="collapse">
                                <li>
                                    <a data-toggle="collapse" data-target=".navbar-ex1-collapse" href="#" myhref="scholarships">Becas</a>
                                </li>
                                <li>
                                    <a data-toggle="collapse" data-target=".navbar-ex1-collapse" href="#" myhref="cultures-deportives">Deportivas culturales</a>
                                </li>
                                <li>
                                    <a data-toggle="collapse" data-target=".navbar-ex1-collapse" href="#" myhref="academics">Académicos</a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a data-toggle="collapse" data-target=".navbar-ex1-collapse" href="" myhref="email"><i class="fa fa-fw fa-empire"></i> Correo</a>
                        </li>
                    </ul>
                </div>
            </nav>

            <div id="page-wrapper" style="min-height: 650px">
                <div id="windowBlock">
                    <div id="WindowLoad">
                        <div id="loadingPicture"></div> 
                    </div>    
                </div>
                <div id="load-data"></div>
            </div>
        </div>
        
        <!-- /#wrapper -->
        <!-- jQuery -->
        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script type="text/javascript" src="../content/files-jq/jqwidgets-ver3.8.2/jqwidgets/localization.js"></script>
        <script type="text/javascript" src="../content/files-jq/jquery-ui-1.11.1/jquery-ui.js"></script>
        <script type="text/javascript" src="../content/files-jq/jqwidgets-ver3.8.2/jqwidgets/jqx-all.js"></script>
        <script type="text/javascript" src="../content/files-jq/jqwidgets-ver3.8.2/jqwidgets/globalization/globalize.js"></script> 
        <script type="text/javascript" src="../content/files-jq/jqwidgets-ver3.8.2/jqwidgets/globalization/globalize.cultures.js"></script> 
        <script type="text/javascript" src="../content/files-jq/jqwidgets-ver3.8.2/scripts/get-theme.js"></script>
        <script type="text/javascript" src="../content/files-jq/jquery.cookie.js"></script>
        <script type="text/javascript" src="../content/files-js/make-combo.js"  charset="UTF-8"></script>
        <script type="text/javascript" src="../content/files-js/make-list.js"  charset="UTF-8"></script>
        <script>
            $(document).ready(function (){
                window.location.hash="";
                window.location.hash=""; //chrome
                window.onhashchange=function(){window.location.hash="";};
                var itemClickedId;
                var itemClickedIdOld;
                var dirCookie = $.cookie('dirApp');
                if(dirCookie!==undefined){
                    $("#load-data").load(dirCookie+".jsp");
                }else{
                    $("#load-data").load("principal.jsp"); 
                }
                $("a").click(function (){
                    if($(this).attr("myhref")){
                        var myhref=$(this).attr("myhref");
                        itemClickedIdOld=$.cookie('dirApp');
                        itemClickedId=myhref;
                        if(itemClickedIdOld!==itemClickedId){
                            $.cookie('dirApp', myhref);
                            $.ajax({
                                async: false,
                                type: 'POST',
                                url: $(this).attr("myhref")+".jsp",
                                beforeSend: function (xhr) {     
                                    $("#windowBlock, a[myhref='"+myhref+"'] span.loadingLinks").show();
                                },
                                success: function (data, textStatus, jqXHR) {
                                    $("#load-data").html(data);
                                    $("#windowBlock, .loadingLinks").hide();
                                },
                                error: function (jqXHR, textStatus, errorThrown) {
                                    alert("Error interno del servidor");
                                    $("#windowBlock, .loadingLinks").hide();
                                }
                            });
                        }
                    }
                });
            });
        </script>
    </body>
</html>
<%}else{
    response.sendRedirect("../");
}%>
