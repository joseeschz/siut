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
            $("#studentToGroupTab").load("../content/data-jsp/views-external/item-settings/flange/student-to-groups-flange/student-to-group-flange.jsp");
            $("#studentToGroupConsultTab").load("../content/data-jsp/views-external/item-settings/flange/student-to-groups-flange/student-to-group-consult-flange.jsp");
        });
    </script>
    <div id='jqxTabs'>
        <ul>
            <li class="jqxTabsTitle" dir="studentToGroupAsignation">Asignación</li>
            <li class="jqxTabsTitle" dir="studentToGroupConsult">Consultar</li>
        </ul>
        <div>
            <div class="hidenTab" style="display: none;">
                <div id="studentToGroupTab" style="padding: 20px"></div>
            </div>
        </div>
        <div>
            <div class="hidenTab" style="display: none;">
                <div id="studentToGroupConsultTab" style="padding: 20px"></div> 
            </div>
        </div>
    </div>
<%}else{
    out.print("Pagina no encontrada");
    response.sendRedirect("index.jsp");
}%>