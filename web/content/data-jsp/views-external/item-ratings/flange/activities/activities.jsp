<%-- 
    Document   : catalogos
    Created on : 14/02/2015, 09:47:03 AM
    Author     : CARLOS
--%>
<%
if(session.getAttribute("logueado") != null){%>
    <script>
        $(document).ready(function (){
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
            $('#averageTab').load('../content/data-jsp/views-external/item-ratings/flange/activities/activities-flange/evaluate-average.jsp');
//            $('#regularizationTab').load('../content/data-jsp/views-external/item-ratings/flange/activities/activities-flange/evaluate-regularization.jsp');
//            $('#globalTab').load('../content/data-jsp/views-external/item-ratings/flange/activities/activities-flange/evaluate-global.jsp');
        });
    </script>
    <div id='jqxTabs'>
        <ul>
            <li class="jqxTabsTitle" dir="average-cal">Actividades Programadas</li>
            <li class="jqxTabsTitle" dir="regula-cal">Regularización</li>
            <li class="jqxTabsTitle" dir="global-cal">Global</li>
        </ul>
        <div>
            <div class="hidenTab" style="display: none;">
                <div id="averageTab" style="padding: 20px;"></div>
            </div>
        </div>
        <div>
            <div class="hidenTab" style="display: none;">
                <div id="regularizationTab" style="padding: 20px;"></div>
            </div>
        </div>
        <div>
            <div class="hidenTab" style="display: none;">
                <div id="globalTab" style="padding: 20px;"></div>
            </div>
        </div>
    </div>
<%}else{
    out.print("Pagina no encontrada");
    response.sendRedirect("index.jsp");
}%>