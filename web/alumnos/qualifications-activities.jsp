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
                    <div style="float: right; margin-bottom: 5px; display: none">
                        <div id='qualificationsScaleEvaluationFilter'></div>
                    </div>
                    <div class="panel-body"> 
                        <div class="tablesActivities1 table-responsive"></div>
                    </div>
<!--                    <div class="panel-body">     
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
                        </div>-->
                        <div id="footDetails" visible="false">
<!--                             <div class="text-right">
                                 <a href="#">Ver todas las actividades <i class="fa fa-arrow-circle-right"></i></a>
                             </div>-->
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
                }else{
                    createDropDownScaleEvaluationBloquedStudent("#qualificationsScaleEvaluationFilter", null, false);
                }
            });
            $('#qualificationsScaleEvaluationFilter').on('change',function (event){  
                if(event.args){
                    loadActivities();
                }                   
            });
            loadActivities();    
            function loadSourceActivities(scaleEvaluation){
                var ordersSource=[];
                var valItemSubjectMatter=0;
                itemSubjectMatters=$('#qualificationsListSubjectMatters').jqxDropDownList('getSelectedItem');
                if(itemSubjectMatters!==undefined){
                    valItemSubjectMatter=itemSubjectMatters.value;
                }
                $.ajax({
                    type:"POST",
                    dataType: "json",
                    async: false,
                    url: "../serviceActivitiesCalByStudents?listActivities",
                    data: {"pkMatter": valItemSubjectMatter, "pkScale": scaleEvaluation},
                    success: function (data, textStatus, jqXHR) {
                        ordersSource=data;
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        alert("Error interno en el servidor");
                    }
                });
                return ordersSource;
            }
            function loadActivities(){
                var valItemsScaleEvaluation=[];
                var existActivities=0;
                var ordersSource=[];
                itemsScaleEvaluation = $("#qualificationsScaleEvaluationFilter").jqxDropDownList('getItems'); 
                if(itemSubjectMatters!==undefined){
                    if(itemSubjectMatters.label==="Estadia"){
                        $(".panel-default").fadeIn();
                        $(".panel-default").html("No disponible para esta materia");
                    }else{
                        $(".panel-default").fadeIn();
                        if(itemsScaleEvaluation!==undefined){
                            var table="";
                            var thead="";
                            var tbody="";
                            var tfoot="";
                            var trOnTbody="";
                            valItemsScaleEvaluation=itemsScaleEvaluation;
                            $(".tablesActivities1").html("");      
                            for(var it=0; it<itemsScaleEvaluation.length; it++){
                                table=$('<table class="table-bordered table-hover table-striped" border="1"></table>');
                                thead=$('<thead><tr><th align="left" colspan="5">'+valItemsScaleEvaluation[it].label+'</th></tr><tr><th align="center" width="85%" rowspan="2">Actividad</th><th align="center" colspan="2">Valor</th><th align="center" colspan="2">Calificación</th></tr><tr><th align="center" title="Real">#</th><th align="center" title="Porcentaje">%</th><th align="center" title="Real">R</th><th align="center" title="Equivalente">E</th></tr></thead>');
                                tbody=$('<tbody></tbody>');
                                ordersSource=loadSourceActivities(valItemsScaleEvaluation[it].value);
                                var subtotalScale=0;
                                var subtotalScaleObtanied=0;
                                var anyActivity=0;
                                var totalPercent=0;
                                var totalEquivalent="N/A";
                                for(var ia=0; ia<ordersSource.items.length; ia++){
                                    existActivities=existActivities+1;
                                    anyActivity=anyActivity+1;
                                    
                                    //totalEquivalent=totalEquivalent+ordersSource.items[ia].dataValueObtaniedEquivalent;
                                    
                                    if(ordersSource.items[ia].dataNameActivity==="Subtotal"){
                                        totalPercent=totalPercent+((ordersSource.items[ia].dataValueActivity*100)/ordersSource.items[ia].dataMaxValueScale);
                                        tfoot=$('<tfoot><tr><th align="right">Subtotal</th><th align="center" class="subtotalValueActivity">'+ordersSource.items[ia].dataValueActivity+'</th><th align="center">'+totalPercent+'%</th><th align="center" class="subtotalValueObtanied">'+ordersSource.items[ia].dataValueObtanied+'</th><th align="center">'+totalEquivalent+'</th></tr></tfoot>');
                                    }else{
                                        var dataValueObtaniedEquivalent = parseFloat(ordersSource.items[ia].dataValueObtaniedEquivalent).toFixed(1);
                                        trOnTbody=$('<tr><td>'+ordersSource.items[ia].dataNameActivity+'</td><td align="center">'+ordersSource.items[ia].dataValueActivity+'</td><td align="center">'+((ordersSource.items[ia].dataValueActivity*100)/ordersSource.items[ia].dataMaxValueScale)+'%</td><td align="center">'+ordersSource.items[ia].dataValueObtanied+'</td><td align="center">'+dataValueObtaniedEquivalent+'</td></tr>');
                                        trOnTbody.appendTo(tbody); 
                                        subtotalScale=subtotalScale+parseFloat(ordersSource.items[ia].dataValueActivity);
                                        subtotalScaleObtanied=subtotalScaleObtanied+parseFloat(ordersSource.items[ia].dataValueObtanied);
                                    }
                                }                    
                                var equivalent=(subtotalScaleObtanied*10/subtotalScale).toFixed(2);
                                if(isNaN(subtotalScale)){
                                    subtotalScale=0;
                                }
                                if(isNaN(subtotalScaleObtanied)){
                                    subtotalScaleObtanied=0;
                                }
                                if(isNaN(subtotalScaleObtanied)){
                                    subtotalScaleObtanied=0;
                                }
                                if(isNaN(equivalent)){
                                    equivalent=0;
                                }                                
                                if(anyActivity===0){
                                    trOnTbody=$('<tr><td colspan="5">Este saber no cuenta con actividades evaluadas</td></tr>');
                                    trOnTbody.appendTo(tbody); 
                                }else{
                                    table.append(tfoot);
                                    anyActivity=0;
                                }

                                table.append(thead);
                                table.append(tbody);
                                
                                $(".tablesActivities1").append(table);
                                $(".tablesActivities1").append("<br>");
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
                            $("#subtotalValueObtaniedNow").text((subtotalValueObtaniedNow)); 
                            var totalValueActivityNow=0;
                            $(".subtotalValueActivity").each(function (){
                                totalValueActivityNow=totalValueActivityNow+parseFloat($(this).text());
                            });
                            $("#totalValueActivityNow").text((totalValueActivityNow).toFixed(2)+" -> 10"); 
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
