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
            $('#jqxTabs').jqxTabs({theme:theme,selectedItem:tabActive, width:'99.9%',height:'99%',scrollPosition: 'both', position: 'top',  collapsible: false }); 
            $("#qualificationsTab").load("../content/data-jsp/views-external/item-generate/flange/records-qualifications/records-qualifications-flange/qualifications-average.jsp");
            $("#regulaTab").load("../content/data-jsp/views-external/item-generate/flange/records-qualifications/records-qualifications-flange/qualifications-regula.jsp");
            $("#globlalTab").load("../content/data-jsp/views-external/item-generate/flange/records-qualifications/records-qualifications-flange/qualifications-global.jsp");
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
    
    <div id='jqxTabs'>
        <ul>
            <li class="jqxTabsTitle" dir="update-data">Promedio</li>
            <li class="jqxTabsTitle" dir="regula-data">Regularización</li>
            <li class="jqxTabsTitle" dir="global-data">Global</li>
        </ul>
        <div>
            <div class="hidenTab" style="display: none;">
                <div id="qualificationsTab" style="padding: 20px;"></div>
            </div>
        </div>
        <div>
            <div class="hidenTab" style="display: none;">
                <div id="regulaTab" style="padding: 20px;"></div>
            </div>
        </div>
        <div>
            <div class="hidenTab" style="display: none;">
                <div id="globlalTab" style="padding: 20px;"></div>
            </div>
        </div>
    </div>
<%}else{
    out.print("Pagina no encontrada");
    response.sendRedirect("index.jsp");
}%>