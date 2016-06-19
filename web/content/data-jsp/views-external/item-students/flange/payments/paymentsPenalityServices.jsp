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
                okButton: $('#okWarning'),
                autoOpen: false,
                isModal: true,
                cancelButton: $('#cancelWarning'),
                initContent: function() {
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
            $("#paymentsPenaltyTypesServicesTab").load("../content/data-jsp/views-external/item-students/flange/payments/paymentsPenaltyTypesServices-flange/admin.jsp");
        });
    </script>
    <div id='jqxWindowWarning'>
        <div>Advertencia</div>
        <div>
            <div class="warning" style="position: absolute;"></div>
            <span style="color: olive; width: 70%; position: absolute; right: 20px;">
                <b>¡Estas seguro de borrar este registro!</b>
            </span>
            <div style="float: right; bottom: 10px; right: 20px;  position: absolute;">
                <input type="button" id="okWarning" value="OK" style="margin-right: 10px" />
                <input type="button" id="cancelWarning" value="Cancelar" />
            </div>
        </div>
    </div>
    <div id='jqxTabs'>
        <ul>
            <li class="jqxTabsTitle" dir="payment">Pago de servicios y sanciones</li>
        </ul>
        <div>
            <div class="hidenTab" style="display: none;">
                <div id="paymentsPenaltyTypesServicesTab" style="padding: 20px;"></div>
            </div>
        </div>
    </div>
<%}else{
    out.print("Pagina no encontrada");
    response.sendRedirect("index.jsp");
}%>