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
            $('#jqxWindowWarningEnrollment').jqxWindow({
                theme: theme,
                height: 100,
                width: 350,
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
            $('#jqxWindowWarningEnrollmentNew').jqxWindow({
                theme: theme,
                height: 220,
                width: 450,
                resizable: false,
                okButton: $('#okWarningNew'),
                autoOpen: false,
                isModal: true,
                cancelButton: $('#cancelWarningNew'),
                initContent: function () {
                    $('#okWarningNew').jqxButton({
                        width: '80px',
                        theme: theme
                    });
                    $('#cancelWarningNew').jqxButton({
                        width: '80px',
                        theme: theme
                    });
                    $('#okWarningNew').focus();
                }
            });
            $('#jqxWindowErrorEnrollment').jqxWindow({
                theme: theme,
                height: 150,
                width: 350,
                resizable: false,
                draggable: false,
                okButton: $('#okError'),
                autoOpen: false,
                isModal: true,
                initContent: function () {
                    $('#okError').jqxButton({
                        width: '80px',
                        theme: theme
                    });
                    $('#okError').focus();
                }
            });
            var tabActive;
            var selectedTab = $.cookie('tabActive');
            $('#jqxTabs').on('selected', function (event) { 
                selectedTab = event.args.item;
                $.cookie('tabActive',selectedTab);
            }); 
            $('#jqxTabs').jqxTabs({theme:theme,selectedItem:tabActive||0, width:'99.9%',height:'99%',scrollPosition: 'both', position: 'top',  collapsible: false }); 
            $("#newEnrollmentTab").load("../content/data-jsp/views-external/item-students/flange/adjustment/enrollment/tab-new/index.jsp");
        });
    </script>
    <div id='jqxWindowOk'>
        <div>Bien</div>
        <div>
            <div class="ok" style="position: absolute;"></div>
            <span style="color: olive; width: 70%; position: absolute; right: 20px;">
                <b>Se ha realizado correctamente el registro</b>
            </span>
            <div style="float: right; bottom: 10px; right: 20px;  position: absolute;">
                <input type="button" id="ok" value="OK" style="margin-right: 10px" />
            </div>
        </div>
    </div>
    <div id='jqxWindowWarningEnrollment'>
        <div>Advertencia</div>
        <div>
            <div class="warning" style="position: absolute;"></div>
            <span style="color: olive; width: 70%; position: absolute; right: 20px;">
                <b>¡Inscribir este registro!</b>
            </span>
            <div style="float: right; bottom: 10px; right: 20px;  position: absolute;">
                <input type="button" id="okWarning" value="OK" style="margin-right: 10px" />
                <input type="button" id="cancelWarning" value="Cancelar" />
            </div>
        </div>
    </div>
    <div id='jqxWindowWarningEnrollmentNew'>
        <div>Advertencia</div>
        <div>
            <div class="warning" style="position: absolute;"></div>
            <span style="color: olive; width: 70%; position: absolute; right: 20px;">
                <b>Esta matrícula <span id="enrollmentTemp"></span> se registrará con los siguientes datos...</b>
                <br>
                <br>
                <b>Nombre del alumno:</b>
                <br>
                <b id="studentNameTemp"></b>
                <br>
                <b>Carrera:</b>
                <br>
                <b id="nameCareerTemp"></b>
            </span>
            <div style="float: right; bottom: 10px; right: 20px;  position: absolute;">
                <input type="button" id="okWarningNew" value="OK" style="margin-right: 10px" />
                <input type="button" id="cancelWarningNew" value="Cancelar" />
            </div>
        </div>
    </div>
    <div id='jqxWindowErrorEnrollment'>
        <div>Error</div>
        <div>
            <div class="fail" style="position: absolute;"></div>
            <span style="color: olive; width: 70%; position: absolute; right: 20px;">
                <b id="messageFail"></b>
            </span>
            <div style="float: right; bottom: 10px; right: 20px;  position: absolute; text-align: center">
                <input type="button" id="okError" value="OK" style="margin-right: 10px" />
            </div>
        </div>
    </div>
    <div id='jqxTabs'>
        <ul>
            <li class="jqxTabsTitle" dir="new-enrollment">Matrícula</li>
        </ul>
        <div>
            <div class="hidenTab" style="display: none;">
                <div id="newEnrollmentTab" style="padding: 20px"></div>
            </div>
        </div>
    </div>
<%}else{
    out.print("Pagina no encontrada");
    response.sendRedirect("index.jsp");
}%>