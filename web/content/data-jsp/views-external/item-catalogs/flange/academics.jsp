<%-- 
    Document   : catalogos
    Created on : 14/02/2015, 09:47:03 AM
    Author     : CARLOS
--%>
<%
if(session.getAttribute("logueado") != null){%>
    <script>
        $(document).ready(function (){
            $('#jqxWindowWarning').jqxWindow({
                theme: theme,
                height: 150,
                width: 350,
                resizable: false,
                draggable: false,
                okButton: $('#ok'),
                autoOpen: false,
                isModal: true,
                cancelButton: $('#cancel'),
                initContent: function () {
                    $('#ok').jqxButton({
                        width: '80px',
                        theme: theme
                    });
                    $('#cancel').jqxButton({
                        width: '80px',
                        theme: theme
                    });
                    $('#ok').focus();
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
            $("#studyLevelTab").load("../content/data-jsp/views-external/item-catalogs/flange/academic-flange/studyLevel.jsp");
            $("#careersTab").load("../content/data-jsp/views-external/item-catalogs/flange/academic-flange/career.jsp");
            $("#studyPlansTab").load("../content/data-jsp/views-external/item-catalogs/flange/academic-flange/studyPlan.jsp");
            $("#subjectMattersTab").load("../content/data-jsp/views-external/item-catalogs/flange/academic-flange/subjectMatters.jsp");
            $("#groupsTab").load("../content/data-jsp/views-external/item-catalogs/flange/academic-flange/groups.jsp");            
            $("#workersTab").load("../content/data-jsp/views-external/item-catalogs/flange/academic-flange/workers.jsp");
        });
    </script>
    <div id='jqxWindowWarning'>
        <div>Advertencia</div>
        <div>
            <div class="warning" style="position: absolute;"></div>
            <span style="color: olive; width: 70%; position: absolute; right: 20px;">
                <b>¡Estas seguro de borrar este registro sabiendo que todo elemento dependiente de este se perderá!</b>
            </span>
            <div style="float: right; bottom: 10px; right: 20px;  position: absolute;">
                <input type="button" id="ok" value="OK" style="margin-right: 10px" />
                <input type="button" id="cancel" value="Cancelar" />
            </div>
        </div>
    </div>
    <div id='jqxTabs'>
        <ul>
            <li class="jqxTabsTitle" dir="studyLevel">Niveles de estudio</li>
            <li class="jqxTabsTitle" dir="career">Carreras</li>
            <li class="jqxTabsTitle" dir="studyPlan">Planes de estudio</li>
            <li class="jqxTabsTitle" dir="subjectMatters">Materias</li>
            <li class="jqxTabsTitle" dir="groups">Grupos</li>            
            <li class="jqxTabsTitle" dir="workers">Usuarios</li>
        </ul>
        <div>
            <div class="hidenTab" style="display: none;">
                <div id="studyLevelTab" style="padding: 20px"></div>
            </div>
        </div>
        <div>
            <div class="hidenTab" style="display: none;">
                <div id="careersTab" style="padding: 20px"></div>
            </div>
        </div>
        <div>
            <div class="hidenTab" style="display: none;">
                <div id="studyPlansTab" style="padding: 20px"></div>
            </div>
        </div>
        <div>
            <div class="hidenTab" style="display: none;">
                <div id="subjectMattersTab" style="padding: 20px"></div>
            </div>
        </div>
        <div>
            <div class="hidenTab" style="display: none;">
                <div id="groupsTab" style="padding: 20px"></div>
            </div>
        </div>
        <div>
            <div class="hidenTab" style="display: none;">
                <div id="workersTab" style="padding: 20px"></div>
            </div>
        </div>
    </div>
<%}else{
    out.print("Pagina no encontrada");
    response.sendRedirect("index.jsp");
}%>