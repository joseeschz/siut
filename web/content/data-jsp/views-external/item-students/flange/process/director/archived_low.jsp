<%-- 
    Document   : catalogos
    Created on : 14/02/2015, 09:47:03 AM
    Author     : CARLOS
--%>
<%
if(session.getAttribute("logueado") != null){%>
    <script>
        $(document).ready(function (){
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
            
            $("#jqxWindowError").jqxWindow({
                theme: theme,
                height: 150,
                width: 400,
                resizable: false,
                draggable: true,
                okButton: $('#okError'),
                autoOpen: false,
                isModal: true,
                cancelButton: $('#cancelError'),
                initContent: function () {
                    $('#okError').jqxButton({
                        width: '80px',
                        theme: theme
                    });
                    $('#cancelError').jqxButton({
                        width: '80px',
                        theme: theme
                    });
                    $('#okError').focus();
                }
            });
            
            $("#popupWindowDoc").jqxWindow({ 
                width: 800,
                minWidth: '1200px',
                height: 800,
                minHeight: '850px', 
                resizable: false, 
                isModal: true, 
                autoOpen: false, 
                modalOpacity: 0.7 
            });
            var tabActive;
            var selectedTab = $.cookie('tabActive');
            $('#jqxTabs').on('selected', function (event) { 
                selectedTab = event.args.item;
                $.cookie('tabActive',selectedTab);
            });             
            $('#jqxTabs').jqxTabs({theme:theme,selectedItem:tabActive||0, width:'99.9%',height:'100%',scrollPosition: 'both', position: 'top',  collapsible: false }); 
            $("#transactLowTab").load("../content/data-jsp/views-external/item-students/flange/process/director/archived-flange/index.jsp");
        });
    </script>
    <div id="popupWindowDoc">
        <div>Documento</div>
        <div style="" id="contentPDF"></div>
    </div>
    <div id='jqxWindowError'>
        <div>Advertencia</div>
        <div>
            <div id="iconError" class="warning" style="position: absolute;"></div>
            <span style="color: olive; width: 70%; position: absolute; right: 20px;">
                <b id="messageError"></b>
            </span>
            <div style="float: right; bottom: 10px; right: 20px;  position: absolute;">
                <input type="button" id="okError" value="OK" style="margin-right: 10px" />
                <input type="button" id="cancelError" value="Cancelar" />
            </div>
        </div>
    </div>
    <div id='jqxWindowAlert'>
        <div>Advertencia</div>
        <div>
            <div id="iconWarning" class="warning" style="position: absolute;"></div>
            <span style="color: olive; width: 70%; position: absolute; right: 20px;">
                <b id="messageWarning"></b><b id="studentName"></b><b id="enrollment"></b><b id="period"></b>
            </span>
            <div style="float: right; bottom: 10px; right: 20px;  position: absolute;">
                <input type="button" id="okWarning" value="OK" style="margin-right: 10px" />
                <input type="button" id="cancelWarning" value="Cancelar" />
            </div>
        </div>
    </div>
    <div id='jqxTabs'>
        <ul>
            <li class="jqxTabsTitle" dir="generate-down">Bajas Archivadas</li>
        </ul>
        <div>
            <div class="hidenTab" style="display: none;">
                <div id="transactLowTab" style="padding: 20px;"></div>
            </div>
        </div>
    </div>
<%}else{
    out.print("Pagina no encontrada");
    response.sendRedirect("index.jsp");
}%>