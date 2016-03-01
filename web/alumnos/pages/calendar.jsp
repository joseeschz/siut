<%
    if(session.getAttribute("logueadoStudent") != null){%>
    <div class="container-fluid">
        <!-- Page Heading -->
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header principal">
                    Calificaciones
                </h1>
                <div style="display: none">
                    <div id="qualificationsPeriod"></div>
                </div>
                <div style="text-align: right">
                    <b id="periodLabel"></b>
                </div> 
                <br>
                <ol class="breadcrumb">
                    <li>
                        <i class="fa fa-dashboard"></i><a class="qualifications" href="#">Principal</a>
                    </li>
                    <li class="active">
                        <i class="fa fa-fw fa-edit"></i> Calendario
                    </li>
                </ol>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div>
                    <b>Calendario ciclo escolar 2014-2015</b>
                </div>
            </div>
            <div class="col-lg-12">
                <img src="pictures/calendar-2014-2015.png"/>
            </div>
        </div>
    </div>
<!-- /.container-fluid -->
<%}else{
    response.sendRedirect("../siut/");
}%>
