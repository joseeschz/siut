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
                        <i class="fa fa-bar-chart-o"></i> Calificaciones / Actividades
                    </li>
                </ol>
            </div>
        </div>
        <!-- /.row -->

        <div class="row">
            <div class="col-lg-12">
                <div>
                    <b>Materia:</b>
                    <div id="qualificationsListSubjectMatters"></div><br>
                </div>
            </div>

            <div class="col-lg-12">
               <b style="font-size: 28px" class="page-header">Lista de actividades</b>
               <!--<p class="lead">En el siguiente desglose de actividades puedes ver el progreso de tus calificaciones, también puedes comparar el puntaje que se lleva con el puntaje a obtener.</p>-->
            </div>
        </div>
        <!-- /.row -->
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default" style="display: none">
                   <div class="panel-heading">
                       <h3 style="" class="panel-title"><i class="fa fa-clock-o fa-fw"></i> Panel de Actividades</h3>
                   </div>
                   <div class="panel-body">
                        <div style="float: right; margin-bottom: 5px; display: none">
                            <div id='qualificationsScaleEvaluationFilter'></div>
                        </div>
                       <b id="nameScale0"></b>
                       <div class="table-responsive">
                           <table class="table-bordered table-hover table-striped">
                               <thead>
                                   <tr>
                                       <th style="width: 300px">Actividad</th>
                                       <th class="center">Obtenido</th>
                                       <th class="center">Valor</th>
                                   </tr>
                               </thead>
                               <tbody id="tbodyActivities0"></tbody>
                               <tfoot id="tfootActivities0"></tfoot>
                           </table>
                       </div>
                       <b id="nameScale1"></b>
                       <div class="table-responsive">
                           <table class="table-bordered table-hover table-striped">
                               <thead>
                                   <tr>
                                       <th style="width: 300px">Actividad</th>
                                       <th class="center">Obtenido</th>
                                       <th class="center">Valor</th>
                                   </tr>
                               </thead>
                               <tbody id="tbodyActivities1"></tbody>
                               <tfoot id="tfootActivities1"></tfoot>
                           </table>
                       </div>
                       <b id="nameScale2"></b>
                       <div class="table-responsive">
                           <table class="table-bordered table-hover table-striped">
                               <thead>
                                   <tr>
                                       <th style="width: 300px">Actividad</th>
                                       <th class="center">Obtenido</th>
                                       <th class="center">Valor</th>
                                   </tr>
                               </thead>
                               <tbody id="tbodyActivities2"></tbody>
                               <tfoot id="tfootActivities2"></tfoot>
                           </table>
                       </div>
                       <div id="footDetails" visible="false">
                            <div class="text-right">
                                <a href="#">Ver todas las actividades <i class="fa fa-arrow-circle-right"></i></a>
                            </div>
                            <b id="name">TOTAL ACUMULADO</b>
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover table-striped">
                                    <thead>
                                        <tr>
                                            <th class="center">Calificación</th>
                                            <th class="center">De</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <th class="center" id="subtotalValueObtaniedNow"></th>
                                            <th class="center" id="totalValueActivityNow"></th>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                       </div>
                   </div>
               </div>
            </div>
        </div>
        <!-- /.row -->
        <script>
        $(document).ready(function () {
            var itemPeriod=0;
            var itemSubjectMatters=0;
            var itemsScaleEvaluation=0;
            createDropDownPeriodActive("comboActiveYear","#qualificationsPeriod");
            itemPeriod=$('#qualificationsPeriod').jqxDropDownList('getSelectedItem');
            if(itemPeriod!==undefined){
                $("#periodLabel").text(itemPeriod.label);
            }else{
                $("#periodLabel").text("SIN DEFINIR");
            }
            createDropDownSubjectMatterByStudent("#qualificationsListSubjectMatters", false);
            itemSubjectMatters=$('#qualificationsListSubjectMatters').jqxDropDownList('getSelectedItem');
            if(itemSubjectMatters!==undefined){
                createDropDownScaleEvaluationBloquedStudent("#qualificationsScaleEvaluationFilter", itemSubjectMatters.value, false);
                itemsScaleEvaluation = $("#qualificationsScaleEvaluationFilter").jqxDropDownList('getItems'); 
            }else{
                createDropDownScaleEvaluationBloquedStudent("#qualificationsScaleEvaluationFilter", null, false);
            }

            $('#qualificationsListSubjectMatters').on('change',function (event){  
                itemSubjectMatters=$('#qualificationsListSubjectMatters').jqxDropDownList('getSelectedItem');
                if(itemSubjectMatters!==undefined){
                    createDropDownScaleEvaluationBloquedStudent("#qualificationsScaleEvaluationFilter", itemSubjectMatters.value, true);
                    loadActivities();   
                }else{
                    createDropDownScaleEvaluationBloquedStudent("#qualificationsScaleEvaluationFilter", null, false);
                }
            });
            $('#qualificationsScaleEvaluationFilter').on('change',function (event){  
                loadActivities();   
            });
            loadActivities();        
            function loadActivities(){
                var valItemsScaleEvaluation=[];
                var existActivities=0;
                itemsScaleEvaluation = $("#qualificationsScaleEvaluationFilter").jqxDropDownList('getItems'); 
                if(itemSubjectMatters!==undefined){
                    if(itemSubjectMatters.label==="Estadia"){
                        $(".panel-default").fadeIn();
                        $(".panel-default").html("No disponible para esta materia");
                    }else{
                        $(".panel-default").fadeIn();
                        if(itemsScaleEvaluation!==undefined){
                            if(itemsScaleEvaluation.length>0){
                                valItemsScaleEvaluation=itemsScaleEvaluation;
                                for(var it=0; it<valItemsScaleEvaluation.length; it++){
                                    $("#nameScale"+it).text(valItemsScaleEvaluation[it].label);
                                    $.ajax({
                                        type: "POST",
                                        dataType: 'json',
                                        async: false,
                                        url: "../serviceActivitiesCalByStudents?listActivities",
                                        data: {"pkMatter": itemSubjectMatters.value, "pkScale": valItemsScaleEvaluation[it].value},
                                        beforeSend: function (xhr) {
                                        },
                                        error: function (jqXHR, textStatus, errorThrown) {
                                            alert("Error interno del servidor");
                                        },
                                        success: function (data, textStatus, jqXHR) {                        
                                            var tbodyActivities = $("#tbodyActivities"+it);
                                            tbodyActivities.html("");
                                            var tfootActivities = $("#tfootActivities"+it);
                                            tfootActivities.html("");
                                            var trTbody;
                                            var tgTfoot;
                                            if((data.items.length-1)===0){
                                                trTbody= $("<tr><td class='center' colspan='3'>Sin actividades registradas por mostrar</td></tr>");
                                                tbodyActivities.append(trTbody);
                                            }else{
                                                existActivities=existActivities+1;
                                                for(var i=0; i<data.items.length-1; i++){
                                                    trTbody=$("<tr><td>"+data.items[i].dataNameActivity+"</td>"+"<td class='center'>"+data.items[i].dataValueObtanied+"</td>"+"<td class='center'>"+data.items[i].dataValueActivity+"</td></tr>");
                                                    tbodyActivities.append(trTbody);
                                                }
                                                var itemTotalIndice=data.items.length-1;
                                                tgTfoot=$("<tr><th style='text-align: right;'>"+(data.items[itemTotalIndice].dataNameActivity)+"</th>"+"<th class='center subtotalValueObtanied'>"+data.items[itemTotalIndice].dataValueObtanied+"</th>"+"<td class='center subtotalValueActivity'>"+data.items[itemTotalIndice].dataValueActivity+"</td></tr>");
                                                tfootActivities.append(tgTfoot);                               
                                            }                        
                                        }
                                    });
                                }
                            }else{
                                var tbodyActivities = $("#tbodyActivities0, #tbodyActivities1, #tbodyActivities2");
                                tbodyActivities.html("");
                                var tfootActivities = $("#tfootActivities0, #tfootActivities1, #tfootActivities2");
                                tfootActivities.html("");
                                var trTbody;
                                var tgTfoot;
                                trTbody= $("<tr><td class='center' colspan='3'>Sin actividades registradas por mostrar</td></tr>");
                                tbodyActivities.append(trTbody);
                                tgTfoot=$("<tr><th style='text-align: right;'>Subtotal</th>"+"<th class='center subtotalValueObtanied'>0</th>"+"<td class='center subtotalValueActivity'>0</td></tr>");
                                tfootActivities.append(tgTfoot);   
                            }

                            if(existActivities>=1){
                                $("#footDetails").fadeIn("slow");
                                existActivities=0;
                            }else{
                                $("#footDetails").fadeOut("slow");
                            }
                            var subtotalValueObtaniedNow=0;
                            $(".subtotalValueObtanied").each(function (){
                                subtotalValueObtaniedNow=subtotalValueObtaniedNow+parseFloat($(this).text());
                            });
                            $("#subtotalValueObtaniedNow").text((subtotalValueObtaniedNow).toFixed(1)); 
                            var totalValueActivityNow=0;
                            $(".subtotalValueActivity").each(function (){
                                totalValueActivityNow=totalValueActivityNow+parseFloat($(this).text());
                            });
                            $("#totalValueActivityNow").text((totalValueActivityNow).toFixed(1)+" -> 10.0"); 
                        }
                    }
                }
            }        
        });
        </script>
    </div>
<!-- /.container-fluid -->
<%}else{
    response.sendRedirect("../siut/");
}%>
