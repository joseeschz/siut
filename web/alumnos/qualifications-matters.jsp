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
            <ol class="breadcrumb">
                <li>
                    <i class="fa fa-dashboard"></i><a class="qualifications" href="#">Principal</a>
                </li>
                <li class="active">
                    <i class="fa fa-bar-chart-o"></i> Calificaciones / Materias
                </li>
            </ol>
        </div>
    </div>
    <!-- /.row -->
    
    <div class="row">
        <div class="col-lg-12">
           <b style="font-size: 28px" class="page-header">Lista de materias</b>
           <!--<p class="lead">En el siguiente desglose de actividades puedes ver el progreso de tus calificaciones, también puedes comparar el puntaje que se lleva con el puntaje a obtener.</p>-->
        </div>
    </div>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-12">
           <div class="panel panel-default">
               <div class="panel-heading">
                   <h3 style="" class="panel-title"><i class="fa fa-clock-o fa-fw"></i> Panel de materias</h3>
               </div>
               <div class="panel-body">
                   <div class="table-responsive">
                       <table class="table-bordered table-hover table-striped">
                           <thead>
                               <tr>
                                   <th style="width: 500px">Materias</th>
                                   <th class="center">Calificación</th>
                               </tr>
                           </thead>
                           <tbody id="tbodyMatters"></tbody>
                           <tfoot id="tfootMatters"></tfoot>
                       </table>
                   </div>
               </div>
           </div>
        </div>
    </div>
    <!-- /.row -->
    <script>
    $(document).ready(function () {
        var itemPeriod=0;
        createDropDownPeriodActive("comboActiveYear","#qualificationsPeriod");
        itemPeriod=$('#qualificationsPeriod').jqxDropDownList('getSelectedItem');
        if(itemPeriod!==undefined){
            $("#periodLabel").text(itemPeriod.label);
            $.ajax({
                type: "POST",
                dataType: 'json',
                async: false,
                url: "../serviceCalification?tableCalMattersStudent",
                beforeSend: function (xhr) {
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert("Error interno del servidor");
                },
                success: function (data, textStatus, jqXHR) {
                    var data=data[0];
                    var tbodyMatters = $("#tbodyMatters");
                    tbodyMatters.html("");
                    var tfootMatters = $("#tfootMatters");
                    tfootMatters.html("");
                    var trTbody;
                    var tgTfoot;
                    if((data.rows.length-1)===0){
                        trTbody= $("<tr><td class='center' colspan='3'>Sin materias por mostrar</td></tr>");
                        tbodyMatters.append(trTbody);
                    }else{
                        for(var i=0; i<data.rows.length-1; i++){
                            trTbody=$("<tr><td>"+(data.rows[i].dataNameSubjectMatter)+"</td>"+"<td class='center'>"+(data.rows[i].dataAvg)+"</td></tr>");
                            tbodyMatters.append(trTbody);
                        }
                        var itemTotalIndice=data.rows.length-1;
                        tgTfoot=$("<tr><th style='text-align: right;'>"+(data.rows[itemTotalIndice].dataNameSubjectMatter)+"</th>"+"<th class='center'>"+(data.rows[itemTotalIndice].dataAvg)+"</th></tr>");
                        tfootMatters.append(tgTfoot);                               
                    }                       
                }
            });
        }
    });
    </script>
</div>
<!-- /.container-fluid -->
<%}else{
    response.sendRedirect("../siut/");
}%>
