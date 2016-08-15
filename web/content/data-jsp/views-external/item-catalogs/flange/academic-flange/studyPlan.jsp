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
            
            $('#jqxWindowWarningCompetences').jqxWindow({
                theme: theme,
                height: 150,
                width: 350,
                resizable: false,
                draggable: false,
                okButton: $('#okCompetences'),
                autoOpen: false,
                isModal: true,
                cancelButton: $('#cancelCompetences'),
                initContent: function () {
                    $('#okCompetences').jqxButton({
                        width: '80px',
                        theme: theme
                    });
                    $('#cancelCompetences').jqxButton({
                        width: '80px',
                        theme: theme
                    });
                    $('#okCompetences').focus();
                }
            });
            var tabActive;
            var selectedTab = $.cookie('tabActive');
            $('#jqxTabs').on('selected', function (event) { 
                selectedTab = event.args.item;
                $.cookie('tabActive',selectedTab);
            }); 
            $('#jqxTabs').jqxTabs({theme:theme,selectedItem:tabActive||0, width:'99.9%',height:'100%',scrollPosition: 'both', position: 'top',  collapsible: false }); 
            $("#studyPlansTab").load("../content/data-jsp/views-external/item-catalogs/flange/academic-flange/studyPlan-item/studyPlan.jsp");
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
    <div id='jqxWindowWarningCompetences'>
        <div>Advertencia</div>
        <div>
            <div class="warning" style="position: absolute;"></div>
            <span style="color: olive; width: 70%; position: absolute; right: 20px;">
                <b>¡Estas seguro de borrar este registro!</b>
            </span>
            <div style="float: right; bottom: 10px; right: 20px;  position: absolute;">
                <input type="button" id="okCompetences" value="OK" style="margin-right: 10px" />
                <input type="button" id="cancelCompetences" value="Cancelar" />
            </div>
        </div>
    </div>
    <div id='jqxTabs'>
        <ul>
            <li class="jqxTabsTitle" dir="studyPlan">Planes de estudio</li>
        </ul>
        <div>
            <div class="hidenTab" style="display: none;">
                <div id="studyPlansTab" style="padding: 20px"></div>
            </div>
        </div>
    </div>
<%}else{
    out.print("Pagina no encontrada");
    response.sendRedirect("index.jsp");
}%>