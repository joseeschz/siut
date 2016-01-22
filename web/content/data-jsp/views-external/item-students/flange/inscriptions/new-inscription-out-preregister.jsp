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
        generateEnrollment(itemPeriod);
    });
    $('#studyLevel').on('change',function (event){  
        itemLevel = $('#studyLevel').jqxDropDownList('getSelectedItem');
        createDropDownCareer(itemLevel.value,"#career",true);
    });
    $('#entity').on('change',function (event){  
        itemEntity= $('#entity').jqxDropDownList('getSelectedItem');
        createDropDownMunicipality(itemEntity.value,'null',"#municipalityFilter",true);
    });
    $('#municipalityFilter').on('change',function (event){  
        itemMunicipality= $('#municipalityFilter').jqxDropDownList('getSelectedItem');
        createDropDownLocality(itemMunicipality.value, 'byPk', "#localityFilter",true);
        
    });
    $('#localityFilter').on('change',function (event){  
        itemLocality= $('#localityFilter').jqxDropDownList('getSelectedItem');
        createDropDownPreparatory(itemLocality.value, "#preparatoryFilter", true);
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
    function generateEnrollment(param_itemPeriod){
        $.ajax({
            url: "../serviceStudent?generateEnrollment",
            data: {'period':param_itemPeriod},
            async: false,
            type: 'POST',
            success: function (data, textStatus, jqXHR) {
                enrollment_temp=data;   
                $("#enrollment").text(enrollment_temp);
            },
            error: function (jqXHR, textStatus, errorThrown) {
                enrollment_temp="¡No generada!";           
            }
        });
    }
    generateEnrollment(itemPeriod);
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
        itemPreparatory=$('#preparatoryFilter').jqxDropDownList('getSelectedItem');
        itemCareer=$('#career').jqxDropDownList('getSelectedItem');
        var datos = {
            "enrollment":$("#enrollment").text(),
            "nameStudent":$("#name").val(),
            "maternName":$("#matern_name").val(),
            "paternName":$("#patern_name").val(),
            "career":itemCareer.value,
            "fkPreparatory":itemPreparatory.value
        }; // los datos del alumno
        $.ajax({
            type: "POST",
            async: false,
            url: "../serviceStudent?insert",
            data:datos,
            beforeSend: function (xhr) {
            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert("Error interno del servidor");
            },
            success: function (data, textStatus, jqXHR) {
                $("#jqxWindowOk").jqxWindow('open');
                $("#ok").click(function (){
                    generateEnrollment(itemPeriod);
                    $("#name").val("");
                    $("#matern_name").val("");
                    $("#patern_name").val("");
                    $("#ok").unbind("click"); 
                    $("#jqxWindowOk").jqxWindow('close');
                    createInputEnrrollment("#enrollmentUpdate",true);
                });
            }
        });
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
                    disableElementsInscription(false);
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
    function  disableElementsInscription(status){
        if(status){
            $('#folio').val("");
            $("#name").val("");
            $("#patern_name").val("");
            $("#matern_name").val("");
            $("#loadingPicture").hide();
            $("#career").jqxDropDownList("selectIndex", 0);
            $("#entity").jqxDropDownList('selectIndex', 0);
            $("#municipalityFilter").jqxDropDownList('selectIndex', 0);
            $("#localityFilter").jqxDropDownList('selectIndex', 0);
            $("#preparatoryFilter").jqxDropDownList('selectIndex', 0);
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
            <b style="float: left;">Matrícula previa<div id="enrollment"></div></b>
            <b style="float: left; right: 0px; margin-left: 100px;">Preregistrado<div id="preregister" style="margin-top: 2px; margin-left: 55px;"></div></b>
            <div style="float: left; right: 0px; margin-left: 5px;">
                <b style="color: rgb(135, 135, 135);" id="labelFolio">Folio Utsem</b><br>
                <input type="text" id="folio" style="margin: 0px 0px 0px -4px; font-size: 10px;"/>
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
                    <input type="button" value="Registrar" id="sendButton" />
                </div>
            </form>
        </div>
    </div>
</div>