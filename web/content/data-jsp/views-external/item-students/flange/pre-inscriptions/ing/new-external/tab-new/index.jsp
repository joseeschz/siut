<script>
$(document).ready(function () {
    var itemPeriod = "";
    var itemLevel="";
    var itemCareer="";
    var itemEntity=0;
    var itemMunicipality=0;
    var itemLocality=0;
    var itemPreparatory=0;
    var enrollment_temp="";
    createDropDownPeriod("inscription","#periodFilter");
    createDropDownStudyLevel("#studyLevel", false);
    itemLevel=$('#studyLevel').jqxDropDownList('getSelectedItem');
    createDropDownCareer(1,"#career",false);
    createDropDownEntity("#entity", "null", false);
    itemEntity = $('#entity').jqxDropDownList('getSelectedItem');
    createDropDownMunicipality(itemEntity.value,'null',"#municipalityFilter",false);
    itemMunicipality=$('#municipalityFilter').jqxDropDownList('getSelectedItem');
    createDropDownLocality(itemMunicipality.value, 'byPk',"#localityFilter",false);
    itemLocality=$('#localityFilter').jqxDropDownList('getSelectedItem');
    createDropDownPreparatory(itemLocality.value, "#preparatoryFilter", false);
    itemPeriod = $('#periodFilter').jqxDropDownList('getSelectedItem');
    itemPeriod = itemPeriod.label;
    $('#periodFilter').on('change',function (event){  
        itemPeriod = $('#periodFilter').jqxDropDownList('getSelectedItem');
        itemPeriod = itemPeriod.label;
        $("#enrollment").val("");
    });
    $('#studyLevel').on('change',function (event){  
        itemLevel = $('#studyLevel').jqxDropDownList('getSelectedItem');
        createDropDownCareer(itemLevel.value,"#career",true);
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
    $('#sendButton').jqxButton({ width: 70, height: 30});
    $('#sendButton').on('click', function () {
        $('#registerForm').jqxValidator('validate');
    });
    $('.text-input').jqxInput();
    $('.text-input').width(130);
    $('#preregister').jqxSwitchButton({
        checked:true, 
        height: 15,
        width: 40,
        theme: theme,
        onLabel:'Si',
        offLabel:'No'
    });
    function generateEnrollment(){
        $("#enrollment").jqxInput({ 
            theme:theme,
            maxLength: 16,
            placeHolder: "Matrícula",
            width: 120, 
            height: 15
        });
    }
    generateEnrollment();
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
            { input: '#enrollment', message: '*', action: 'keyup, blur', rule: 'required', hintRender: render },
            { input: '#name', message: '*', action: 'keyup, blur', rule: 'required', hintRender: render },
            { input: '#matern_name', message: '*', action: 'keyup, blur',rule: 'required', hintRender: render },
            { input: '#patern_name', message: '*', action: 'keyup, blur', rule: 'required', hintRender: render }
        ]
    });
    
    $('#registerForm').on('validationSuccess', function (event) {
        $("#jqxWindowWarningIncriptions").jqxWindow('open');             
    });
    $("#okWarning").click(function (){
        //en el evento submit del fomulario
        itemPreparatory=$('#preparatoryFilter').jqxDropDownList('getSelectedItem');
        itemCareer=$('#career').jqxDropDownList('getSelectedItem');
        var itemFolio = $('#folio').jqxInput('val');
        if($("#enrollment").val()!==""){
            var datos = {
                "enrollment": $("#enrollment").val(),
                "utsemFolio": itemFolio.label,
                "birthCertificate": $("#birthCertificate").val(),
                "hightSchoolCertificate": $("#hightSchoolCertificate").val()
            }; // los datos del alumno
            $.ajax({
                type: "POST",
                async: false,
                url: "../serviceStudent?insertOfPreregister",
                data:datos,
                beforeSend: function (xhr) {
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert("Error interno del servidor");
                },
                success: function (data, textStatus, jqXHR) {
                    if(data==="1"){
                        $("#jqxWindowOk").jqxWindow('open');                        
                    }else if(data==="0"){
                        $("#messageFail").text("El registro no pudo ser inscrito verifique bien los datos, en caso que el problema persita consulte al equipo de desarrolo de este sistema");
                        $("#jqxWindowErrorIncriptions").jqxWindow('open');
                    }else if(data==="2"){
                        $("#messageFail").text("El folio utsem ya está registrado en la tabla de alumnos");
                        $("#jqxWindowErrorIncriptions").jqxWindow('open');
                    }else if(data.indexOf("Duplicate entry")>=0){
                        $("#messageFail").text("La matrícula ya está registrada en la tabla de alumnos");
                        $("#jqxWindowErrorIncriptions").jqxWindow('open');
                    }else{
                        $("#messageFail").text("Ocurrio un error intenta nuevamente y si el problema persite consulte al equipo de desarrollo de este sistema");
                        $("#jqxWindowErrorIncriptions").jqxWindow('open');
                    }                    
                }
            });
        }else{
            alert("Error al generar matrícula");
        }
    });
    $("#ok").click(function (){
        $("#enrollment").val("");
        $("#removeFolio").hide();
        $('#folio').val("");
        $("#name").val("");
        $("#matern_name").val("");
        $("#patern_name").val("");
        $("#birthCertificate").val("");
        $("#hightSchoolCertificate").val("");
        $("#entity").jqxDropDownList('selectIndex', 0);
        $("#jqxWindowOk").jqxWindow('close');
        $('#sendButton').jqxButton({disabled: true});
        createInputFolioUtsem("#folio",true);
    });
    createInputFolioUtsem("#folio",false);
    $("#folio").on('select',function (event){
        var folio="";
        if(event.args){
            var item = event.args.item;
            if(item){
                folio = item.label;
            }
        }
        if(folio.length>=3){
            $.ajax({
                type: "POST",
                url: "../serviceCandidate?selectCandidateByPkCandidate",
                data: {
                    "folioUtsem": folio
                },
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
                    $('#sendButton').jqxButton({disabled: false});
                    loadDataInscription(data);
                }
            }).done(function (){
                $("#loadingPicture").fadeOut("slow");
                
            });
        }
    });
    $('#folio').jqxInput({disabled: false});
    $('#preregister').bind('unchecked', function (event) {
        $('#folio').jqxInput({disabled: false});
        $("#labelFolio").css("color","#000");
        if($('#folio').val()!==""){
            $('#sendButton').jqxButton({disabled: false});
        }        
    });
    $('#preregister').bind('checked', function (event) { 
        $('#folio').jqxInput({disabled: true});
        $("#removeFolio").hide();
        $("#labelFolio").css("color","#878787");
        disableElementsInscription(true);
    }); 
    $("#removeFolio").hide();
    $("#loadingPicture").hide();
    $("#folio").keyup(function (){
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
    disableElementsInscription(true);
    function  disableElementsInscription(status){
        if(status){
            $('#folio').val("");
            $("#name").jqxInput({disabled: status}).val("");
            $("#patern_name").jqxInput({disabled: status}).val("");
            $("#matern_name").jqxInput({disabled: status}).val("");
            $("#loadingPicture").hide();
            $("#career").jqxDropDownList("selectIndex", 0);
            $("#career").jqxDropDownList({disabled: status});
            $("#entity").jqxDropDownList('selectIndex', 0);
            $("#entity").jqxDropDownList({disabled: status});
            $("#municipalityFilter").jqxDropDownList('selectIndex', 0);
            $("#municipalityFilter").jqxDropDownList({disabled: status});
            $("#localityFilter").jqxDropDownList('selectIndex', 0);
            $("#localityFilter").jqxDropDownList({disabled: status});
            $("#preparatoryFilter").jqxDropDownList('selectIndex', 0);
            $("#preparatoryFilter").jqxDropDownList({disabled: status});
            $('#sendButton').jqxButton({disabled: status});
        }
    }
    function loadDataInscription(data){
        itemLevel = $("#studyLevel").jqxDropDownList('getItemByValue', data.dataPkLevelStudy);
        $("#studyLevel").jqxDropDownList('selectItem', itemLevel); 
        itemCareer = $("#career").jqxDropDownList('getItemByValue', data.fk_career);
        $("#career").jqxDropDownList("selectItem", itemCareer);
        itemEntity = $("#entity").jqxDropDownList('getItemByValue', data.fk_entity);
        $("#entity").jqxDropDownList('selectItem', itemEntity);
        itemMunicipality = $("#municipalityFilter").jqxDropDownList('getItemByValue', data.fk_municipality);
        $("#municipalityFilter").jqxDropDownList('selectItem', itemMunicipality);
        itemLocality = $("#localityFilter").jqxDropDownList('getItemByValue', data.fk_locality);
        $("#localityFilter").jqxDropDownList('selectItem', itemLocality);
        itemPreparatory = $("#preparatoryFilter").jqxDropDownList('getItemByValue', data.fk_preparatory);
        $("#preparatoryFilter").jqxDropDownList('selectItem', itemPreparatory);
        $("#name").val(data.fl_name);
        $("#patern_name").val(data.fl_matern_name);
        $("#matern_name").val(data.fl_patern_name);        
    }
});
</script>
<div style="margin-right: 5px;">
    Periodo <br>
    <div id='periodFilter'></div>
</div>
<div id="formNewInscription" style="margin-top: 5px;">
    <div id="register">
        <div style="padding-left: 15px;">
            <div style="float: left; right: 0px; margin-left: 5px;">
                <b style="color: rgb(135, 135, 135);" id="labelFolio">Folio Utsem</b><br>
                <input type="text" id="folio" style="margin: 0px 0px 0px -4px; font-size: 10px;"/>
                <span id="removeFolio" style="cursor: pointer; font-size: 10px; position: relative; right: 20px;">X</span>
            </div>
            <div style="float: left; right: 0px; margin-left: 5px;">
                <b style="color: rgb(135, 135, 135);" id="labelEnrollment">Matrícula previa</b><br>
                <input type="text" id="enrollment" style="margin: 0px 0px 0px -4px; font-size: 10px;"/>
            </div>
            <b style="float: left; right: 0px; margin-left: 100px; display: none">Preregistrado<div id="preregister" style="margin-top: 2px; margin-left: 55px;"></div></b>
            
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
                <div style="float: left; margin-right: 5px;">
                    <span>Número de acta de nacimiento</span> <br>
                    <input type="text" id="birthCertificate" class="text-input" />
                </div>
                <div style="float: left; margin-right: 5px;">
                    <span>Número de certificado de bachillerato</span> <br>
                    <input type="text" id="hightSchoolCertificate" class="text-input" />
                </div>
                <div style="float: left; margin: 20px; margin-left: 175px;">
                    <input type="button" value="Registrar" id="sendButton" />
                </div>
            </form>
        </div>
    </div>
</div>