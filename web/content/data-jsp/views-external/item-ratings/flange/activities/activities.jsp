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
            $('#jqxTabs').jqxTabs({theme:theme,selectedItem:tabActive||0, width:'99.9%',height:'100%',scrollPosition: 'both', position: 'top',  collapsible: false });
            $('#averageTab').load('../content/data-jsp/views-external/item-ratings/flange/activities/activities-flange/evaluate-average.jsp');
//            $('#regularizationTab').load('../content/data-jsp/views-external/item-ratings/flange/activities/activities-flange/evaluate-regularization.jsp');
//            $('#globalTab').load('../content/data-jsp/views-external/item-ratings/flange/activities/activities-flange/evaluate-global.jsp');
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
    </script>
    <div id='jqxWindowMissingTeachers'>
        <div>
            <div>
                <div id="iconWarning" class="warning" style="position: absolute; width: 20px; height: 20px;"></div> 
                <span style="margin-left: 30px">El sistema no puede evaluar a esté alumno</span>
            </div>
        </div>
        <div>
            <span style="color: olive; width: 310px;">
                <b style="" id="message"></b>
            </span>
            <div style="margin-top: 4px;" id="listTeacher"></div>
            <div id="iconWarning" class="warning" style="position: absolute; right: 40px; top: 85px;"></div> 
            <div style="float: right; bottom: 10px; right: 20px;  position: absolute;">
                <input type="button" id="okWarningTeachers" value="OK" style="margin-right: 10px" />
                <input type="button" id="cancelWarningTeachers" value="Cancelar" />
            </div>
        </div>
    </div>
    <div id='jqxTabs'>
        <ul>
            <li class="jqxTabsTitle" dir="average-cal">Actividades Programadas</li>
        </ul>
        <div>
            <div class="hidenTab" style="display: none;">
                <div id="averageTab" style="padding: 20px;"></div>
            </div>
        </div>
    </div>
<%}else{
    out.print("Pagina no encontrada");
    response.sendRedirect("index.jsp");
}%>