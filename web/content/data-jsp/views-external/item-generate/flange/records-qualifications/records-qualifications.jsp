<%-- 
    Document   : catalogos
    Created on : 14/02/2015, 09:47:03 AM
    Author     : CARLOS
--%>
<%
if(session.getAttribute("logueado") != null){%>
    <script>
        $(document).ready(function (){
            $('#jqxWindowWarningCalications').jqxWindow({
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
            
            $('#jqxWindowMissingTeachers').jqxWindow({
                theme: theme,
                height: 225,
                width: 450,
                resizable: false,
                draggable: false,
                okButton: $('#okWarningTeachers'),
                autoOpen: false,
                isModal: true,
                cancelButton: $('#cancelWarningTeachers'),
                initContent: function () {
                    $('#okWarningTeachers').jqxButton({
                        width: '80px',
                        theme: theme
                    });
                    $('#cancelWarningTeachers').jqxButton({
                        width: '80px',
                        theme: theme
                    });
                    $('#okWarningTeachers').focus();
                }
            });
            var tabActive;
            var selectedTab = $.cookie('tabActive');
            $('#jqxTabs').on('selected', function (event) { 
                selectedTab = event.args.item;
                $.cookie('tabActive',selectedTab);
            }); 
            $('#jqxTabs').jqxTabs({theme:theme,selectedItem:tabActive||0, width:'99.9%',height:'100%',scrollPosition: 'both', position: 'top',  collapsible: false }); 
            $("#qualificationsTab").load("../content/data-jsp/views-external/item-generate/flange/records-qualifications/records-qualifications-flange/qualifications-average.jsp");
//            $("#regulaTab").load("../content/data-jsp/views-external/item-generate/flange/records-qualifications/records-qualifications-flange/qualifications-regula.jsp");
//            $("#globlalTab").load("../content/data-jsp/views-external/item-generate/flange/records-qualifications/records-qualifications-flange/qualifications-global.jsp");
//            $('#jqxTabs').jqxTabs('disableAt', 1);
//            $('#jqxTabs').jqxTabs('disableAt', 2);
        });
    </script>
    <div id='jqxWindowWarningCalications'>
        <div>Advertencia</div>
        <div>
            <div id="iconWarning" class="warning" style="position: absolute;"></div>
            <input type="hidden" id="typeEval" />
            <span style="color: olive; width: 70%; position: absolute; right: 20px;">
                <b id="messageWarning"></b>
            </span>
            <div style="float: right; bottom: 10px; right: 20px;  position: absolute;">
                <input type="button" id="okWarning" value="OK" style="margin-right: 10px" />
                <input type="button" id="cancelWarning" value="Cancelar" />
            </div>
        </div>
    </div>
    
    <div id='jqxWindowMissingTeachers'>
        <div>
            <div>
                <div id="iconWarning" class="warning" style="position: absolute; width: 20px; height: 20px;"></div> 
                <span style="margin-left: 30px"> Ups... No puedes generar el reporte</span>
            </div>
        </div>
        <div>
            <span style="color: olive; width: 310px; position: absolute;">
                <b style="display: inline-block;" id="message">Mestros que faltan por cerrar regularización</b>
                <div style="margin-top: 4px;" id="listTeacher"></div>
            </span>
            <div id="iconWarning" class="warning" style="position: absolute; right: 40px; top: 85px;"></div> 
            <div style="float: right; bottom: 10px; right: 20px;  position: absolute;">
                <input type="button" id="okWarningTeachers" value="OK" style="margin-right: 10px" />
                <input type="button" id="cancelWarningTeachers" value="Cancelar" />
            </div>
        </div>
    </div>
    
    <div id='jqxTabs'>
        <ul>
            <li class="jqxTabsTitle" dir="update-data">Reporte</li>
        </ul>
        <div>
            <div class="hidenTab" style="display: none;">
                <div id="qualificationsTab" style="padding: 20px;"></div>
            </div>
        </div>
    </div>
<%}else{
    out.print("Pagina no encontrada");
    response.sendRedirect("index.jsp");
}%>