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
            $('#jqxTabs').jqxTabs({theme:theme,selectedItem:tabActive||0, width:'99.9%',height:'99%',scrollPosition: 'both', position: 'top',  collapsible: false }); 
            $("#goalsInscriptionsTab").load("../content/data-jsp/views-external/item-settings/flange/inscription-top-flange/inscription-top.jsp");
        });
    </script>
    <div id='jqxTabs'>
        <ul>
            <li class="jqxTabsTitle" dir="goalsInscriptions">Metas inscripciónes</li>
        </ul>
        <div>
            <div class="hidenTab" style="display: none;">
                <div id="goalsInscriptionsTab" style="padding: 20px"></div>
            </div>
        </div>
    </div>
<%}else{
    out.print("Pagina no encontrada");
    response.sendRedirect("index.jsp");
}%>