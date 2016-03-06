<%-- 
    Document   : catalogos
    Created on : 14/02/2015, 09:47:03 AM
    Author     : CARLOS
--%>
<%
if(session.getAttribute("logueado") != null){%>
    <script>
        $(document).ready(function (){
            $('#jqxWindowOk').jqxWindow({
                theme: theme,
                height: 100,
                width: 350,
                resizable: false,
                draggable: false,
                okButton: $('#ok'),
                autoOpen: false,
                isModal: true,
                initContent: function () {
                    $('#ok').jqxButton({
                        width: '80px',
                        theme: theme
                    });
                    $('#ok').focus();
                }
            });
            $('#jqxWindowWarningActivities').jqxWindow({
                theme: theme,
                height: 150,
                width: 400,
                resizable: false,
                draggable: false,
                okButton: $('#okWarning'),
                autoOpen: false,
                isModal: true,
                cancelButton: $('#cancelWarning'),
                initContent: function () {
                    $('#okWarning').jqxButton({
                        width: '80px',
                        theme: theme
                    });
                    $('#cancelWarning').jqxButton({
                        width: '80px',
                        theme: theme
                    });
                    $('#okWarning').focus();
                }
            });
            var tabActive;
            var selectedTab = $.cookie('tabActive');
            $('#jqxTabs').on('selected', function (event) { 
                selectedTab = event.args.item;
                $.cookie('tabActive',selectedTab);
            }); 
            if(selectedTab!==undefined){
                tabActive = selectedTab;
            }else{
                tabActive=0;
            }
            $('#jqxTabs').jqxTabs({theme:theme,selectedItem:tabActive, width:'99.9%',height:'100%',scrollPosition: 'both', position: 'top',  collapsible: false }); 
            $("#newActivityTab").load("../content/data-jsp/views-external/item-adjustment/flange/work/activities-flange/valorate-activities.jsp");
//            $("#stadisticsTab").load("../content/data-jsp/views-external/item-adjustment/flange/work/activities-flange/stadistics-activities.jsp");
        });
    </script>
    <div id='jqxWindowOk'>
        <div id="titleOk">Bien</div>
        <div>
            <div id="pictureOk" class="ok" style="position: absolute;"></div>
            <span style="color: olive; width: 70%; position: absolute; right: 20px;">
                <b id="messageOk">Se ha guardo correctamente el registro</b>
            </span>
            <div style="float: right; bottom: 10px; right: 20px;  position: absolute;">
                <input type="button" id="ok" value="OK" style="margin-right: 10px" />
            </div>
        </div>
    </div>
    <div id='jqxWindowWarningActivities'>
        <div>Advertencia</div>
        <div>
            <div id="iconWarning" class="warning" style="position: absolute;"></div>
            <span style="color: olive; width: 70%; position: absolute; right: 20px;">
                <b id="messageWarning">¡Actualizar este registro!</b>
            </span>
            <div style="float: right; bottom: 10px; right: 20px;  position: absolute;">
                <input type="button" id="okWarning" value="OK" style="margin-right: 10px" />
                <input type="button" id="cancelWarning" value="Cancelar" />
            </div>
        </div>
    </div>
    <div id='jqxTabs'>
        <ul>
            <li class="jqxTabsTitle" dir="valorate-activities">Valorar actividades</li>
            <!--<li class="jqxTabsTitle" dir="stadistics-activities">Estadisticas</li>-->
        </ul>
        <div>
            <div class="hidenTab" style="display: none;">
                <div id="newActivityTab" style="padding: 20px;"></div>
            </div>
        </div>
<!--        <div>
            <div class="hidenTab" style="display: none;">
                <div id="stadisticsTab" style="padding: 20px"></div>
            </div>
        </div>-->
    </div>
<%}else{
    out.print("Pagina no encontrada");
    response.sendRedirect("index.jsp");
}%>