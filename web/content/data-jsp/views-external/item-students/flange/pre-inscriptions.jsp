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
                        width: '180px',
                        theme: theme
                    });
                    $('#ok').focus();
                }
            });
            $('#jqxWindowWarningPre-Incriptions').jqxWindow({
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
            var tabActive;
            var selectedTab = $.cookie('tabActive');
            var loaded0=false;
            var loaded1=false;
            var loaded2=false;
            $('#jqxTabs').on('selected', function (event) { 
                selectedTab = event.args.item;
                $.cookie('tabActive',selectedTab);
                if(selectedTab===0){                    
                    if(!loaded0){
                        //$("#updatePre-IncriptionTab").load("../content/data-jsp/views-external/item-students/flange/pre-inscriptions/update-pre-inscription.jsp");
                        $("#load-page-external").jqxWindow('open');
                        $.ajax({
                            type: "POST",
                            url: "../content/data-jsp/views-external/item-students/flange/pre-inscriptions/update-pre-inscription.jsp",
                            async: true,
                            beforeSend: function (xhr) {
                                $("#updatePre-IncriptionTab").css("display","none");
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                alert("Error interno del servidor");
                            },
                            success: function (data, textStatus, jqXHR) {
                                $("#updatePre-IncriptionTab").html(data);
                                $("#load-page-external").jqxWindow('close');
                            }
                        }).done(function (){
                            $("#updatePre-IncriptionTab").css("display","block");
                        });                        
                        loaded0=true;
                    }                    
                }
                if(selectedTab===1){                    
                    if(!loaded1){
                        $("#newPre-IncriptionTab").load("../content/data-jsp/views-external/item-students/flange/pre-inscriptions/new-pre-inscription.jsp");
                        loaded1=true;
                    }   
                }
                if(selectedTab===2){                    
                    if(!loaded2){
                        $("#allPre-IncriptionTab").load("../content/data-jsp/views-external/item-students/flange/pre-inscriptions/preregisters.jsp");
                        loaded2=true;
                    }
                }
            }); 
            if(selectedTab!==undefined){
                tabActive = selectedTab;
            }else{
                tabActive=0;
            }
            $('#jqxTabs').jqxTabs({theme:theme,selectedItem:tabActive, width:'99.9%',height:'99%',scrollPosition: 'both', position: 'top',  collapsible: false });   
        });
    </script>
    <div id='jqxWindowOk'>
        <div>Bien</div>
        <div>
            <div class="ok" style="position: absolute;"></div>
            <span style="color: olive; width: 70%; position: absolute; right: 20px;">
                <b>Se ha preinscrito correctamente el registro</b>
            </span>
            <div style="float: right; bottom: 10px; right: 20px;  position: absolute;">
                <input type="button" id="ok" value="Exportar a PDF" style="margin-right: 10px" />
            </div>
        </div>
    </div>
    <div id='jqxWindowWarningPre-Incriptions'>
        <div>Advertencia</div>
        <div>
            <div class="warning" style="position: absolute;"></div>
            <span style="color: olive; width: 70%; position: absolute; right: 20px;">
                <b>¡Preincribir registro!</b>
            </span>
            <div style="float: right; bottom: 10px; right: 20px;  position: absolute;">
                <input type="button" id="okWarning" value="OK" style="margin-right: 10px" />
                <input type="button" id="cancelWarning" value="Cancelar" />
            </div>
        </div>
    </div>
    <div id="load-data" style="display: none">
        <div>Cargando datos...</div>
        <div id="loadContent">
            <img src="../content/pictures-system/load.GIF" width="60" style="margin-right: 20px" />
            Precargando información...
        </div>
    </div>
    <div id='jqxTabs'>
        <ul>
            <li class="jqxTabsTitle" dir="update-pre-inscription">Verificar datos</li>
            <li class="jqxTabsTitle" dir="new-pre-inscription">Preinscripción</li>
            <li class="jqxTabsTitle" dir="preregisters">Datos</li>
        </ul>
        <div>
            <div class="hidenTab" style="display: none;">
                <div id="updatePre-IncriptionTab" style="padding: 20px"></div>
            </div>
        </div>
        <div>
            <div class="hidenTab" style="display: none;">
                <div id="newPre-IncriptionTab" style="padding: 20px;"></div>
            </div>
        </div>
        <div>
            <div class="hidenTab" style="display: none;">
                <div id="allPre-IncriptionTab" style="padding: 20px;"></div>
            </div>
        </div>
    </div>
<%}else{
    out.print("Pagina no encontrada");
    response.sendRedirect("index.jsp");
}%>