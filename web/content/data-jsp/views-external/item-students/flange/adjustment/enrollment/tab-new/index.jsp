<script>
$(document).ready(function () {
    $("#removeEnrollment").hide();
    $("#loadingPictureRegister").hide();
    var itemLevel="";
    var itemCareer="";
    var itemEntity=0;
    var itemMunicipality=0;
    var itemLocality=0;
    var itemPreparatory=0;
    createDropDownStudyLevel("#studyLevelRegister",false);
    itemLevel=$('#studyLevelRegister').jqxDropDownList('getSelectedItem');
    createDropDownCareer(itemLevel.value,"#careerRegister",false);
    createDropDownEntity("#entityRegister",'null', false);
    itemEntity = $('#entityRegister').jqxDropDownList('getSelectedItem');
    createDropDownMunicipality(itemEntity.value, 'null',"#municipalityFilterRegister",false);
    itemMunicipality=$('#municipalityFilterRegister').jqxDropDownList('getSelectedItem');
    createDropDownLocality(itemMunicipality.value, 'byPk',"#localityFilterRegister",false);
    itemLocality=$('#localityFilterRegister').jqxDropDownList('getSelectedItem');
    createDropDownPreparatory(itemLocality.value,"#preparatoryFilterRegister", false);
    $('#studyLevelRegister').on('change',function (event){  
        var args = event.args;
        if (args) { 
            var item = args.item;
            if(item.visible){
                createDropDownCareer(item.value,"#careerRegister",true);
            }
        }  
    });
    $('#entityRegister').on('change',function (event){
        var args = event.args;
        if (args) { 
            var item = args.item;
            if(item.visible){
                createDropDownMunicipality(item.value, 'null',"#municipalityFilterRegister",true);
            }
        }      
    });
    $('#municipalityFilterRegister').on('change',function (event){  
        var args = event.args;
        if (args) { 
            var item = args.item;
            if(item.visible){
                createDropDownLocality(item.value, 'byPk',"#localityFilterRegister",true);
            }
        }  
    });
    $('#localityFilterRegister').on('change',function (event){  
        var args = event.args;
        if (args) { 
            var item = args.item;
            if(item.visible){
                createDropDownPreparatory(item.value, "#preparatoryFilterRegister", true);
            }
        }          
    });
    $("#registerRegister").jqxExpander({theme:theme, toggleMode: 'none', width: '490px', showArrow: false});
    $('#sendButtonRegister').jqxButton({ width: 80, height: 30});
    $('#sendButtonRegister').on('click', function () {
        $('#registerRegisterFormRegister').jqxValidator('validate');
    });
    $('.text-input').jqxInput({theme:theme});
    $('#nameRegister').jqxInput({disabled:true});
    $('#matern_nameRegister').jqxInput({disabled:true});
    $('#patern_nameRegister').jqxInput({disabled:true});
    $('.text-input').width(130);
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
    $('#registerRegisterFormRegister').jqxValidator({
        rules: [
            { input: '#nameRegister', message: '*', action: 'keyup, blur', rule: 'required', hintRender: render },
            { input: '#matern_nameRegister', message: '*', action: 'keyup, blur',rule: 'required', hintRender: render },
            { input: '#patern_nameRegister', message: '*', action: 'keyup, blur', rule: 'required', hintRender: render }
        ]
    });
    $('#registerRegisterFormRegister').on('validationSuccess', function (event) {
        itemCareer=$('#careerRegister').jqxDropDownList('getSelectedItem');
        var enrollment = $("#enrollmentRegister").val().toUpperCase(); 
        var studenName = $("#nameRegister").val()+" "+$("#patern_nameRegister").val()+" "+$("#matern_nameRegister").val();
        $("#enrollmentTemp").text(enrollment);
        $("#studentNameTemp").text(studenName);
        $("#nameCareerTemp").text(itemCareer.label);
        $("#jqxWindowWarningEnrollmentNew").jqxWindow('open');
    });
    $("#okWarningNew").click(function (){
        //en el evento submit del fomulario
        itemPreparatory=$('#preparatoryFilterRegister').jqxDropDownList('getSelectedItem');
        itemCareer=$('#careerRegister').jqxDropDownList('getSelectedItem');
        var enrollment = $("#enrollmentRegister").val().toUpperCase(); 
        var datos = {
            "enrollment": enrollment,
            "nameStudent":$("#nameRegister").val(),
            "maternName":$("#matern_nameRegister").val(),
            "paternName":$("#patern_nameRegister").val(),
            "career":itemCareer.value,
            "fkPreparatory":itemPreparatory.value
        }; // los datos del 
        $.ajax({
            type: "POST",
            url: "../serviceStudent?insert",
            data:datos,
            async: false,
            beforeSend: function (xhr) {
            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert("Error interno del servidor");
            },
            success: function (data, textStatus, jqXHR) {
                if(data==="Datos Guardados"){
                    $("#enrollmentRegister").val("");
                    disableElements(true);
                    $('#jqxWindowOk').jqxWindow('open');
                }else{
                    $("#messageFail").html("La matrícula ingrsada es correcta pero estamos teniendo conflictos favor de intentar mas tarde...!");
                    $("#jqxWindowErrorEnrollment").jqxWindow("open");
                    $("#okError").focus();
                }                
            }
        });
        $("#jqxWindowWarningEnrollmentNew").jqxWindow('close');
    });
    $("#removeEnrollment").click(function (){
        $(this).hide();
        $(validateButton).show();
        disableElements(true);
    });
    disableElements(true);
    function disableElements(status){
        $("#studyLevelRegister").jqxDropDownList({disabled: status}); 
        $("#careerRegister").jqxDropDownList({disabled: status});
        $("#entityRegister").jqxDropDownList({disabled: status});
        $("#municipalityFilterRegister").jqxDropDownList({disabled: status});
        $("#localityFilterRegister").jqxDropDownList({disabled: status});
        $("#preparatoryFilterRegister").jqxDropDownList({disabled: status});
        $('#enrollmentRegister').jqxInput({disabled: !status});
        $('#nameRegister').jqxInput({disabled: status});
        $('#matern_nameRegister').jqxInput({disabled: status});
        $('#patern_nameRegister').jqxInput({disabled: status});
        $('#sendButtonRegister').jqxButton({disabled: status});
        if(status){
            $("#nameRegister").val("");
            $("#patern_nameRegister").val("");
            $("#matern_nameRegister").val("");  
            $("#loadingPictureRegister").hide();
            $("#careerRegister").jqxDropDownList("selectIndex", 0);
            $("#entityRegister").jqxDropDownList('selectIndex', 0);
            $("#municipalityFilterRegister").jqxDropDownList('selectIndex', 0);
            $("#localityFilterRegister").jqxDropDownList('selectIndex', 0);
            $("#preparatoryFilterRegister").jqxDropDownList('selectIndex', 0);
        }else{
            $(validateButton).hide();
        }
    }
    var validateEnrollment = function(enrollment){
        var result = true;
        var enrollmentTemp = enrollment.toUpperCase();
        var ordersSource = {
            url: "../serviceStudent?consultAllEnrollments",
            async: false,
            datatype: "json",
            root: "__ENTITIES",
            datafields: [
                { name: 'id' },
                { name: 'dataNameEnrollment' }
            ]
        };
        var dataAdapter = new $.jqx.dataAdapter(ordersSource, {
            autoBind: true,
            beforeSend:function (){
                $("#loadingPictureRegister").show();
            },
            beforeLoadComplete:function (){
                
            },
            downloadComplete: function (data) {  
                var enrollments = data[0]["__ENTITIES"];
                for(var i=0; i<enrollments.length; i++){
                    if(enrollments[i].dataNameEnrollment===enrollmentTemp){
                        result = false;
                    }
                }
                $("#loadingPictureRegister").hide();
            }
        });
        return result;
    };
    var buttonTemplate = "<div style='float: left; padding: 1px; margin: 1px;'><div style='margin: 4px; width: 16px; height: 16px;'></div></div>";
    var validateButton = $(buttonTemplate); 
    validateButton.jqxButton({cursor: "pointer", enableDefault: true,  height: 16, width: 16 });
    validateButton.find('div:first').addClass(('jqx-icon-validate'));
    validateButton.jqxTooltip({ position: 'bottom', content: "Validar"});
    validateButton.attr("id","validateButton");
    $("#enrollmentRegister").keypress(function (event){
        var enrollment = $("#enrollmentRegister").val();        
        if(enrollment.length>=3){
            if(event.which==13){
                $(validateButton).click();
            }
        }        
    });
    $("#content-button").append(validateButton);
    $(validateButton).click(function (){       
        var enrollment = $("#enrollmentRegister").val();        
        if(enrollment.length>=3){
             if(validateEnrollment(enrollment)){
                $("#removeEnrollment").show();
                disableElements(false);
            }else{
                $("#messageFail").html("Esta matrícula no puede ser registrada por que ya existe...!");
                $("#jqxWindowErrorEnrollment").jqxWindow("open");
                $("#okError").focus();
                disableElements(true);
            }     
        }
           
    });
});
</script>
<br>
<div id="formRegisterInscription">
    <div id="registerRegister">
        <div style="padding-left: 15px;">
            <b>Dar de alta matrícula</b>            
        </div>
        <div style="overflow: hidden; position: relative;">
            <form id="registerRegisterFormRegister" style="padding: 15px;">
                <div style="float: left; margin-right: 5px;">
                    <span>Matrícula</span><br>
                    <input type="text" id="enrollmentRegister" style="width: 140px; height: 16px" class="text-input" />
                    <span id="removeEnrollment" style="cursor: pointer;font-size: 16px;position: relative;right: 20px;top: 2px;">X</span>
                </div>
                <div style="float: left; margin-right: 5px; margin-left: 20px; margin-top: 12px;">
                    <div id="content-button" style="cursor: pointer;font-size: 16px;position: relative;right: 20px;top: 2px;"></div>
                </div>
                <br>
                <br>
                <br>
                <div style="float: left; margin-right: 5px;">
                    <span>Nombre</span> <br>
                    <input disabled="" type="text" id="nameRegister" class="text-input" />
                </div>
                <div style="float: left; margin-right: 5px;">
                    <span>Apellido Paterno</span><br>
                    <input disabled type="text" id="patern_nameRegister" class="text-input" />
                </div>
                <div style="float: left; margin-right: 5px;">
                    <span>Apellido Materno</span> <br>
                    <input disabled type="text" id="matern_nameRegister" class="text-input" />
                </div>
                <div style="float: left; margin-right: 5px;">
                    <span>Nivel</span> <br>
                    <div id="studyLevelRegister"></div>
                </div>
                <div style="float: left; margin-right: 5px;">
                    <span>Carrera</span> <br>
                    <div id="careerRegister"></div>
                </div>
                <img id="loadingPictureRegister" style="right: 20px; top: 110px; position: absolute;" width="85" src="../content/pictures-system/load.GIF"/>
                <div style="float: left; margin-right: 5px;">
                    <span>Estado</span> <br>
                    <div id="entityRegister"></div>
                </div>
                <div style="float: left; margin-right: 5px;">
                    <span>Municipio</span> <br>
                    <div id="municipalityFilterRegister"></div>
                </div>
                <div style="float: left; margin-right: 5px;">
                    <span>Localidad</span> <br>
                    <div id="localityFilterRegister"></div>
                </div>
                <div style="float: left; margin-right: 5px;">
                    <span>Preparatoria</span> <br>
                    <div id="preparatoryFilterRegister"></div>
                </div>
                <div style="float: left; margin: 20px; margin-left: 175px;">
                    <input type="button" value="Registrar" id="sendButtonRegister" />
                </div>
            </form>
        </div>
    </div>
</div>