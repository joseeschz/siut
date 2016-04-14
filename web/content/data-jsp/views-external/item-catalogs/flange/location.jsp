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
            $('#jqxTabs').jqxTabs({theme:theme,selectedItem:tabActive||0, width:'99.9%',height:'100%',scrollPosition: 'both', position: 'top',  collapsible: false }); 
            $("#entityTab").load("../content/data-jsp/views-external/item-catalogs/flange/location-flange/entity.jsp");
            $("#municipalityTab").load("../content/data-jsp/views-external/item-catalogs/flange/location-flange/municipality.jsp");
            $("#localityTab").load("../content/data-jsp/views-external/item-catalogs/flange/location-flange/locality.jsp");
            $("#preparatoryTab").load("../content/data-jsp/views-external/item-catalogs/flange/location-flange/preparatory.jsp");
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
            <li class="jqxTabsTitle" dir="entity">Estados</li>
            <li class="jqxTabsTitle" dir="municipality">Municipios</li>
            <li class="jqxTabsTitle" dir="locality">Localidades</li>
            <li class="jqxTabsTitle" dir="preparatory">Preparatorias</li>
        </ul>
        <div>
            <div class="hidenTab" style="display: none;">
                <div id="entityTab" style="padding: 20px"></div>
            </div>
        </div>
        <div>
            <div class="hidenTab" style="display: none;">
                <div id="municipalityTab" style="padding: 20px"></div>
            </div>
        </div>
        <div>
            <div class="hidenTab" style="display: none;">
                <div id="localityTab" style="padding: 20px"></div>
            </div>
        </div>
        <div>
            <div class="hidenTab" style="display: none;">
                <div id="preparatoryTab" style="padding: 20px"></div>
            </div>
        </div>
    </div>
<%}else{
    out.print("Pagina no encontrada");
    response.sendRedirect("index.jsp");
}%>