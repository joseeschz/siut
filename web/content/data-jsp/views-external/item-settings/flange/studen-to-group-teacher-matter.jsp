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
                draggable: true,
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
            $("#jqxWindowAlert").jqxWindow({
                theme: theme,
                height: 150,
                width: 400,
                resizable: false,
                draggable: true,
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
            $('#jqxTabs').jqxTabs({theme:theme,selectedItem:tabActive||0, width:'99.9%',height:'100%',scrollPosition: 'both', position: 'top',  collapsible: false }); 
            $("#teacherToGroupTab").load("../content/data-jsp/views-external/item-settings/flange/studen-to-group-teacher-matter-flange/studen-to-group-teacher-matter.jsp");
        });
    </script>
    <style>
        .alert-delete{
            color: red;
        }
    </style>
    <div id='jqxWindowWarning'>
        <div>Advertencia</div>
        <div>
            <div class="warning" style="position: absolute;"></div>
            <span style="color: olive; width: 70%; position: absolute; right: 20px;">
                <b>¡Se borrarán estos regitros!</b>
            </span>
            <div id='jqxWidgetResultDelete' style="padding: 5px; font-size: 13px; font-family: Verdana; min-height: 50px; max-height: 50px; overflow: auto; width: 233px; border: 1px solid rgb(119, 150, 112); color: rgb(84, 146, 95); margin-left: 80px; margin-top: 18px;">
                <span class="alert-delete">Sin registros...</span>
            </div>
            <div style="float: right; bottom: 10px; right: 20px;  position: absolute;">
                <input type="button" id="ok" value="OK" style="margin-right: 10px" />
                <input type="button" id="cancel" value="Cancelar" />
            </div>
        </div>
    </div>
    <div id='jqxWindowAlert'>
        <div>Advertencia</div>
        <div>
            <div id="iconWarning" class="warning" style="position: absolute;"></div>
            <span style="color: olive; width: 70%; position: absolute; right: 20px;">
                <b id="messageWarning"></b>
            </span>
            <div style="float: right; bottom: 10px; right: 20px;  position: absolute;">
                <input type="button" id="okWarning" value="OK" style="margin-right: 10px" />
                <input type="button" id="cancelWarning" value="Cancelar" />
            </div>
        </div>
    </div>
    <div id='jqxTabs'>
        <ul>
            <li class="jqxTabsTitle" dir="teacherToGroupAsignation">Asignación</li>
        </ul>
        <div>
            <div class="hidenTab" style="display: none;">
                <div id="teacherToGroupTab" style="padding: 20px"></div>
            </div>
        </div>
    </div>
<%}else{
    out.print("Pagina no encontrada");
    response.sendRedirect("index.jsp");
}%>