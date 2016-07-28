<script>
$(document).ready(function () {
    var itemPeriod = "";
    var itemTypeFilter = "";
    var itemCareerPreinscription="";
    var itemEntityPreinscription=0;
    var itemMunicipalityPreinscription=0;
    var itemLocalityPreinscription=0;
    var itemPreparatoryPreinscription=0;
    var folioUtsem_temp="";
    createDropDownPeriod("inscription","#periodFilter");
    createDropDownTypePreinscription("#typeFilter");
    createDropDownStudyLevel("#studyLevel", false);
    createDropDownCareer(1,"#career",false);
    createDropDownEntity("#entity", "null", false);
    itemEntityPreinscription = $('#entity').jqxDropDownList('getSelectedItem');
    createDropDownMunicipality(itemEntityPreinscription.value,'null',"#municipalityFilter",false);
    itemMunicipalityPreinscription=$('#municipalityFilter').jqxDropDownList('getSelectedItem');
    createDropDownLocality(itemMunicipalityPreinscription.value, 'byPk',"#localityFilter",false);
    itemLocalityPreinscription=$('#localityFilter').jqxDropDownList('getSelectedItem');
    createDropDownPreparatory(itemLocalityPreinscription.value, "#preparatoryFilter", false);
    itemPeriod = $('#periodFilter').jqxDropDownList('getSelectedItem');
    $('#periodFilter').on('change',function (event){  
        generateFolioUtsem();
    });
    $('#typeFilter').on('change',function (event){ 
        generateFolioUtsem();
    });
    $('#entity').on('change',function (event){  
        var args = event.args;
        if (args) { 
            var item = args.item;
            if(item.visible){
                createDropDownMunicipality(item.value,'xxx',"#municipalityFilter",true);
            }
        }    
    });
    $('#municipalityFilter').on('change',function (event){  
        var args = event.args;
        if (args) { 
            var item = args.item;
            if(item.visible){
                createDropDownLocality(item.value, 'byPk', "#localityFilter",true);  
            }
        }      
    });
    $('#localityFilter').on('change',function (event){  
        var args = event.args;
        if (args) { 
            var item = args.item;
            if(item.visible){
                createDropDownPreparatory(item.value, "#preparatoryFilter", true);
            }
        }   
    });
    $("#register").jqxExpander({theme:theme, toggleMode: 'none', width: '490px', showArrow: false});
    $('#sendButton').jqxButton({ width: 90, height: 30});
    $('#sendButton').on('click', function () {
        $('#registerForm').jqxValidator('validate');
    });
    $('.text-input').jqxInput();
    $('.text-input').width(130);

    function generateFolioUtsem(){
        itemPeriod = $('#periodFilter').jqxDropDownList('getSelectedItem');
        itemPeriod = itemPeriod.value;
        itemTypeFilter = $('#typeFilter').jqxDropDownList('getSelectedItem');
        itemTypeFilter = itemTypeFilter.value;
        $.ajax({
            url: "../serviceCandidate?generateFolioUtsem",
            data: {'period': itemPeriod, "type": itemTypeFilter},
            async: false,
            type: 'POST',
            success: function (data, textStatus, jqXHR) {
                folioUtsem_temp=data;   
                $("#folioUtsem").text(folioUtsem_temp);
            },
            error: function (jqXHR, textStatus, errorThrown) {
                folioUtsem_temp="¡No generada!";           
            }
        });
    }
    generateFolioUtsem();
    var that = this;
    var render = function (message, input) {
        if (that._message) {
            //that._message.remove();
        }
        that._message = $("<span style='color: red;'> "+message+"</span>");
        that._message.appendTo($(input).parent().children("span"));
        return that._message;
    };
    // initialize validator.
    $('#registerForm').jqxValidator({
        rules: [
            { input: '#name', message: '*', action: 'keyup, blur', rule: 'required', hintRender: render },
            { input: '#matern_name', message: '*', action: 'keyup, blur',rule: 'required', hintRender: render },
            { input: '#patern_name', message: '*', action: 'keyup, blur', rule: 'required', hintRender: render }
        ]
    });
    
    $('#registerForm').on('validationSuccess', function (event) {
        //en el evento submit del fomulario
        $("#cancelWarning,#okWarning").jqxButton({disabled: false});
        $("#jqxWindowWarningPre-Incriptions").jqxWindow('open');
    });
    $("#okWarning").click(function (){
        itemPeriod=$('#periodFilter').jqxDropDownList('getSelectedItem');
        var datos = {"folioSystem":folioSystem,"folioUtsem":$("#folioUtsem").text(),"period":itemPeriod.value}; // los datos del 
        $.ajax({
            type: "POST",
            async: false,
            url: "../serviceCandidate?preregister",
            data:datos,
            beforeSend: function (xhr) {

            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert("Error interno del servidor");
            },
            success: function (data, textStatus, jqXHR) {
                $("#jqxWindowOk").jqxWindow('open');
            }
        });
    });
    $("#ok").click(function (){
        generateFolioUtsem();
        $.ajax({
            type: "POST",
            async: false,
            url: "../servicePdf?cedule=session",
            data: {"folioSystem":folioSystem},
            beforeSend: function (xhr) {

            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert("Error interno del servidor");
            },
            success: function (data, textStatus, jqXHR) {
                window.open("/servicePdf?cedule=print");
            }
        });
        disableElementsInscription(true);
        createInputFolioSystem("#folioSystem",false);
        
    });
    createInputFolioSystem("#folioSystem",false);
    var folioSystem="";
    $("#folioSystem").on('select',function (event){        
        if(event.args){
            var item = event.args.item;
            if(item){
                folioSystem = item.label;
            }
        }
        if(folioSystem.length>=3){
            $.ajax({
                type: "POST",
                url: "../serviceCandidate?selectCandidateByPkCandidate",
                data: {"folioSystem": folioSystem},
                async: true,
                dataType: 'json',
                beforeSend: function (xhr) {
                    $("#loadingPicture").show();
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert("Error interno del servidor");
                },
                success: function (data, textStatus, jqXHR) {
                    $("#removeFolio").show();
                    disableElementsInscription(false);
                    loadDataInscription(data);
                }
            }).done(function (){
                $("#loadingPicture").fadeOut("slow");
                
            });
        }
    });
    disableElementsInscription(true);
    $("#removeFolio").hide();
    $("#loadingPicture").hide();
    $("#folioSystem").keyup(function (){
        if($(this).val().length>0){
            $("#removeFolio").show();
        }else{
            $("#removeFolio").hide();
        } 
    });
    $("#removeFolio").click(function (){
        $(this).hide();
        disableElementsInscription(true);
    });
    function  disableElementsInscription(status){
        $('#folioSystem').jqxInput({disabled: !status});
        $('#sendButton').jqxInput({disabled: status});
        if(status){
            $("#removeFolio").hide();
            $('#folioSystem').val("");
            $("#name").val("");
            $("#patern_name").val("");
            $("#matern_name").val("");
            $("#loadingPicture").hide();
            $('#sendButton').jqxInput({disabled: status});
            $("#career").jqxDropDownList("selectIndex", 0);
            $("#entity").jqxDropDownList('selectIndex', 0);
            $("#municipalityFilter").jqxDropDownList('selectIndex', 0);
            $("#localityFilter").jqxDropDownList('selectIndex', 0);
            $("#preparatoryFilter").jqxDropDownList('selectIndex', 0);
            $("#name").jqxInput({disabled: status});
            $("#patern_name").jqxInput({disabled: status});
            $("#matern_name").jqxInput({disabled: status});
            $('#sendButton').jqxInput({disabled: status});
            $("#career").jqxDropDownList({disabled: status});
            $("#entity").jqxDropDownList({disabled: status});
            $("#municipalityFilter").jqxDropDownList({disabled: status});
            $("#localityFilter").jqxDropDownList({disabled: status});
            $("#preparatoryFilter").jqxDropDownList({disabled: status});
        }else{
            $('#sendButton').jqxInput({disabled: status});
        }
    }
    function loadDataInscription(data){ 
        var itemCareerPreinscription1 = $("#career").jqxDropDownList('getItemByValue', data.fk_career);
        $("#career").jqxDropDownList("selectItem", itemCareerPreinscription1);
        var itemEntityPreinscription1 = $("#entity").jqxDropDownList('getItemByValue', data.fk_entity);
        $("#entity").jqxDropDownList('selectItem', itemEntityPreinscription1);
        var itemMunicipalityPreinscription1 = $("#municipalityFilter").jqxDropDownList('getItemByValue', data.fk_municipality);
        $("#municipalityFilter").jqxDropDownList('selectItem', itemMunicipalityPreinscription1);
        var itemLocalityPreinscription1 = $("#localityFilter").jqxDropDownList('getItemByValue', data.fk_locality);
        $("#localityFilter").jqxDropDownList('selectItem', itemLocalityPreinscription1);
        var itemPreparatoryPreinscription1 = $("#preparatoryFilter").jqxDropDownList('getItemByValue', data.fk_preparatory);
        $("#preparatoryFilter").jqxDropDownList('selectItem', itemPreparatoryPreinscription1);
        $("#name").val(data.fl_name);
        $("#patern_name").val(data.fl_matern_name);
        $("#matern_name").val(data.fl_patern_name);        
    }
});
</script>
<div style="margin-right: 5px; float: left">
    Periodo <br>
    <div id='periodFilter'></div>
</div>
<div style="margin-right: 5px; float: left">
    Tipo de Inscripción <br>
    <div id='typeFilter'></div>
</div>
<br>
<br>
<br>
<div id="formNewInscription">
    <div id="register">
        <div style="padding-left: 15px;">
            <b style="float: left;">Folio Utsem <div id="folioUtsem"></div></b>
            <div style="float: left; right: 0px; margin-left: 260px;">
                <b id="labelFolio">Folio Sistema</b><br>
                <input type="text" id="folioSystem" style="margin: 0px 0px 0px 0px; font-size: 10px;"/>
                <span id="removeFolio" style="cursor: pointer; font-size: 10px; position: relative; right: 20px;">X</span>
            </div>
        </div>
        <div style="overflow: hidden; position: relative">
            <form id="registerForm" style="padding: 15px;">
                <div style="float: left; margin-right: 5px;">
                    <span>Nombre</span> <br>
                    <input type="text" id="name" class="text-input" />
                </div>
                <div style="float: left; margin-right: 5px;">
                    <span>Apellido Paterno</span><br>
                    <input type="text" id="patern_name" class="text-input" />
                </div>
                <div style="float: left; margin-right: 5px;">
                    <span>Apellido Materno</span> <br>
                    <input type="text" id="matern_name" class="text-input" />
                </div>
                <div style="float: left; margin-right: 5px; display: none">
                    <span>Nivel</span> <br>
                    <div id="studyLevel"></div>
                </div>
                <div style="float: left; margin-right: 5px;">
                    <span>Carrera TSU</span> <br>
                    <div id="career"></div>
                </div>
                <img id="loadingPicture" style="right: 20px; top: 75px; position: absolute;" width="85" src="../content/pictures-system/load.GIF"/>
                <div style="float: left; margin-right: 5px;">
                    <span>Estado</span> <br>
                    <div id="entity"></div>
                </div>
                <div style="float: left; margin-right: 5px;">
                    <span>Municipio</span> <br>
                    <div id="municipalityFilter"></div>
                </div>
                <div style="float: left; margin-right: 5px;">
                    <span>Localidad</span> <br>
                    <div id="localityFilter"></div>
                </div>
                <div style="float: left; margin-right: 5px;">
                    <span>Preparatoria</span> <br>
                    <div id="preparatoryFilter"></div>
                </div>
                <div style="float: left; margin: 20px; margin-left: 175px;">
                    <input type="button" value="Preinscribir" id="sendButton" />
                </div>
            </form>
        </div>
    </div>
</div>