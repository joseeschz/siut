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
                        
            <ol class="breadcrumb">
                <li>
                    <i class="fa fa-dashboard"></i><a class="qualifications" href="#">Principal</a>
                </li>
                <li class="active">
                    <i class="fa fa-bar-chart-o"></i> Calificaciones / Historial
                </li>
            </ol>
        </div>
    </div>
    <!-- /.row -->
    
    <div class="row">
        <div class="col-lg-12">
            <b style="font-size: 28px" class="page-header">Historial de acádemico</b>
           <!--<p class="lead">En el siguiente desglose de actividades puedes ver el progreso de tus calificaciones, también puedes comparar el puntaje que se lleva con el puntaje a obtener.</p>-->
        </div>
    </div>
    <!-- /.row -->
    <div class="row">
        <div id="contains-panels" class="col-lg-12"></div>
    </div>
    <div class="row">
        <div id="contains-panels" class="col-lg-12">
            <div class='panel panel-default'>
                <h1 class='panel-title'></i> <b>PROMEDIO GENERAL:</b><span id="average"></span></h1>
            </div>
        </div>
    </div>
    <!-- /.row -->
    <script>
    $(document).ready(function () {
        var itemsPeriod=0;
        var valItemsPeriod=[];
        createDropDownPeriodActive("comboAllByStudent","#qualificationsPeriod");
        itemsPeriod=$('#qualificationsPeriod').jqxDropDownList('getItems');
        if(itemsPeriod!==undefined){
            if(itemsPeriod.length>0){
                for(var period=0; period<itemsPeriod.length; period++){
                    var containsPanels=$("#contains-panels");
                    var panelDefault=$("<div class='panel panel-default'></div>");
                    var panelHeading=$("<div class='panel-heading'></div>");
                    var panelTitle=$("<h3 style='float: left; margin-left: -10px;' class='panel-title'></i> Panel de materias </h3><h3 style='float: right; font-size: 12px; margin-right: -10px;  margin-top: 4px'><i class='fa fa-clock-o fa-fw'></i><span id='periodLabel"+period+"'></span></h3><br>");
                    var panelBodys=$("<div class='panel-body'></div>");
                    var tableResponsive=$("<div class='table-responsive'></div>");
                    var table=$("<table class=' table-bordered table-hover table-striped'></div>");
                    var thead=$("<thead><tr><th style='width: 500px'>Materias</th><th class='center'>Calificación</th></tr></thead>");
                    var tbody;
                    var tfoot;
                    tbody=$("<tbody id='tbodyMatters"+period+"'></tbody>");
                    tfoot=$("<tfoot id='tfootMatters"+period+"'></tfoot>");
                    thead.appendTo(table);
                    tbody.appendTo(table);
                    tfoot.appendTo(table);
                    table.appendTo(tableResponsive);
                    tableResponsive.appendTo(panelBodys);
                    panelTitle.appendTo(panelHeading);
                    panelHeading.appendTo(panelDefault);
                    panelBodys.appendTo(panelDefault);
                    panelDefault.appendTo(containsPanels);
                    $("#periodLabel"+period).text(itemsPeriod[period].label);
                    $.ajax({
                        type: "POST",
                        dataType: 'json',
                        async: false,
                        url: "../serviceCalification?tableCalMattersStudentHistory",
                        data:{"pkPeriod":itemsPeriod[period].value},
                        beforeSend: function (xhr) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) {
                            var data=data[0];
                            var tbodyMatters = $("#tbodyMatters"+period);
                            tbodyMatters.html("");
                            var tfootMatters = $("#tfootMatters"+period);
                            tfootMatters.html("");
                            var trTbody;
                            var tgTfoot;
                            //alert(data.rows.length);
                            if((data.rows.length)<=0){
                                trTbody= $("<tr><td class='center' colspan='3'>Sin materias por mostrar</td></tr>");
                                tbodyMatters.append(trTbody);
                            }else{
                                for(var i=0; i<data.rows.length; i++){
                                    trTbody=$("<tr><td style='width: 100px;'>"+(data.rows[i].dataNameSubjectMatter)+"</td>"+"<td class='center'>"+(data.rows[i].dataAvg)+"</td></tr>");
                                    if((data.rows[i].dataNameSubjectMatter)!=="Promedio"){
                                        tbodyMatters.append(trTbody);
                                    }
                                }
                                var itemTotalIndice=data.rows.length-1;
                                tgTfoot=$("<tr><th style='text-align: right; width: 100px;'>"+(data.rows[itemTotalIndice].dataNameSubjectMatter)+"</th>"+"<th class='center average'>"+(data.rows[itemTotalIndice].dataAvg)+"</th></tr>");
                                if((data.rows.length)>1){
                                    tfootMatters.append(tgTfoot);   
                                }                          
                            }                       
                        }
                    });
                }
                var average=0;
                var count=0;
                $(".average").each(function (){
                    if(parseFloat($(this).text())!==NaN){
                        count++;
                        average=average+parseFloat($(this).text());
                    }
                });
                $("#average").html("<b> "+(average/count).toFixed(1)+"</b>");
                count=0;
            }            
        }        
    });
    </script>
</div>
<!-- /.container-fluid -->
<%}else{
    response.sendRedirect("../siut/");
}%>
