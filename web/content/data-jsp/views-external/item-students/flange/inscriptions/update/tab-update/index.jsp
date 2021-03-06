<script>
$(document).ready(function () {
    $("#removeEnrollment").hide();
    $("#loadingPictureUpdate").hide();
    var itemLevel="";
    var itemCareer="";
    var itemEntity=0;
    var itemMunicipality=0;
    var itemLocality=0;
    var itemPreparatory=0;
    var enrollmentUpdate_temp="";
    createDropDownStudyLevel("#studyLevelUpdate",false);
    itemLevel=$('#studyLevelUpdate').jqxDropDownList('getSelectedItem');
    createDropDownCareer(itemLevel.value,"#careerUpdate",false);
    createDropDownEntity("#entityUpdate",'null', false);
    itemEntity = $('#entityUpdate').jqxDropDownList('getSelectedItem');
    createDropDownMunicipality(itemEntity.value, 'null',"#municipalityFilterUpdate",false);
    itemMunicipality=$('#municipalityFilterUpdate').jqxDropDownList('getSelectedItem');
    createDropDownLocality(itemMunicipality.value, 'byPk',"#localityFilterUpdate",false);
    itemLocality=$('#localityFilterUpdate').jqxDropDownList('getSelectedItem');
    createDropDownPreparatory(itemLocality.value,"#preparatoryFilterUpdate", false);
    $('#studyLevelUpdate').on('change',function (event){  
        var args = event.args;
        if (args) { 
            var item = args.item;
            if(item.visible){
                createDropDownCareer(item.value,"#careerUpdate",true);
            }
        }  
    });
    $('#entityUpdate').on('change',function (event){
        var args = event.args;
        if (args) { 
            var item = args.item;
            if(item.visible){
                createDropDownMunicipality(item.value, 'null',"#municipalityFilterUpdate",true);
            }
        }      
    });
    $('#municipalityFilterUpdate').on('change',function (event){  
        var args = event.args;
        if (args) { 
            var item = args.item;
            if(item.visible){
                createDropDownLocality(item.value, 'byPk',"#localityFilterUpdate",true);
            }
        }  
    });
    $('#localityFilterUpdate').on('change',function (event){  
        var args = event.args;
        if (args) { 
            var item = args.item;
            if(item.visible){
                createDropDownPreparatory(item.value, "#preparatoryFilterUpdate", true);
            }
        }          
    });
    $("#registerUpdate").jqxExpander({theme:theme, toggleMode: 'none', width: '490px', showArrow: false});
    $('#sendButtonUpdate').jqxButton({ width: 80, height: 30});
    $('#sendButtonUpdate').on('click', function () {
        $('#registerUpdateFormUpdate').jqxValidator('validate');
    });
    $('.text-input').jqxInput({theme:theme});
    $('#nameUpdate').jqxInput({disabled:true});
    $('#matern_nameUpdate').jqxInput({disabled:true});
    $('#patern_nameUpdate').jqxInput({disabled:true});
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
    $('#registerUpdateFormUpdate').jqxValidator({
        rules: [
            { input: '#nameUpdate', message: '*', action: 'keyup, blur', rule: 'required', hintRender: render },
            { input: '#matern_nameUpdate', message: '*', action: 'keyup, blur',rule: 'required', hintRender: render },
            { input: '#patern_nameUpdate', message: '*', action: 'keyup, blur', rule: 'required', hintRender: render }
        ]
    });
    $('#registerUpdateFormUpdate').on('validationSuccess', function (event) {
        $("#jqxWindowWarningIncriptionsUpdate").jqxWindow('open');
    });
    $("#okWarningUpdate").click(function (){
        //en el evento submit del fomulario
        itemPreparatory=$('#preparatoryFilterUpdate').jqxDropDownList('getSelectedItem');
        itemCareer=$('#careerUpdate').jqxDropDownList('getSelectedItem');
        var datos = {
            "enrollmentUpdate":enrollmentUpdate_temp,
            "nameUpdateStudent":$("#nameUpdate").val(),
            "maternNameUpdate":$("#matern_nameUpdate").val(),
            "paternNameUpdate":$("#patern_nameUpdate").val(),
            "careerUpdate":itemCareer.value,
            "fkPreparatoryUpdate":itemPreparatory.value,
            "birthCertificate" : $("#birthCertificate").val(),
            "hightSchoolCertificate" : $("#hightSchoolCertificate").val()
        }; // los datos del 
        $.ajax({
            type: "POST",
            url: "../serviceStudent?update",
            data:datos,
            async: false,
            beforeSend: function (xhr) {
            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert("Error interno del servidor");
            },
            success: function (data, textStatus, jqXHR) {
                $('#jqxWindowOk').jqxWindow('open');
            }
        });
        $("#okWarningUpdate").jqxWindow('close');
    });
    createInputEnrrollment("#enrollmentUpdate",false);
    $("#enrollmentUpdate").on('select',function (event){
        var enrollment="";
        var pkStudent;
        if(event.args){
            var item = event.args.item;
            if(item){
                pkStudent = item.value;
                enrollment = item.label;
                enrollmentUpdate_temp=enrollment;
            }
        }
        if(enrollment.length>=3){
            $.ajax({
                type: "POST",
                url: "../serviceStudent?selectStudent",
                data: {"enrollment":enrollment},
                async: true,
                dataType: 'json',
                beforeSend: function (xhr) {
                    $("#loadingPictureUpdate").show();
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert("Error interno del servidor");
                },
                success: function (data, textStatus, jqXHR) {
                    $("#removeEnrollment").show();
                    disableElements(false);
                    loadData(data);
                }
            }).done(function (){
                $("#loadingPictureUpdate").fadeOut("slow");
                
            });
        }
    });
    $("#removeEnrollment").click(function (){
        $(this).hide();
        disableElements(true);
    });
    disableElements(true);
    function  disableElements(status){
        $("#studyLevelUpdate").jqxDropDownList({disabled: status}); 
        $("#careerUpdate").jqxDropDownList({disabled: status});
        $("#entityUpdate").jqxDropDownList({disabled: status});
        $("#municipalityFilterUpdate").jqxDropDownList({disabled: status});
        $("#localityFilterUpdate").jqxDropDownList({disabled: status});
        $("#preparatoryFilterUpdate").jqxDropDownList({disabled: status});
        $('#enrollmentUpdate').jqxInput({disabled: !status});
        $('#nameUpdate').jqxInput({disabled: status});
        $('#matern_nameUpdate').jqxInput({disabled: status});
        $('#patern_nameUpdate').jqxInput({disabled: status});
        $('#sendButtonUpdate').jqxButton({disabled: status});
        $("#birthCertificate").jqxInput({disabled: status});
        $("#hightSchoolCertificate").jqxInput({disabled: status});
        if(status){
            $('#enrollmentUpdate').val("");
            $("#nameUpdate").val("");
            $("#patern_nameUpdate").val("");
            $("#matern_nameUpdate").val("");
            $("#birthCertificate").val("");
            $("#hightSchoolCertificate").val("");   
            $("#loadingPictureUpdate").hide();
            $("#careerUpdate").jqxDropDownList("selectIndex", 0);
            $("#entityUpdate").jqxDropDownList('selectIndex', 0);
            $("#municipalityFilterUpdate").jqxDropDownList('selectIndex', 0);
            $("#localityFilterUpdate").jqxDropDownList('selectIndex', 0);
            $("#preparatoryFilterUpdate").jqxDropDownList('selectIndex', 0);
        }
    }
    function loadData(data){
        if(data.dataModify=="0"){
            $("#careerUpdate").jqxDropDownList({disabled: true});
        }else{
            $("#careerUpdate").jqxDropDownList({disabled: false});
        }
        itemLevel = $("#studyLevelUpdate").jqxDropDownList('getItemByValue', data.dataPkLevelStudy);
        $("#studyLevelUpdate").jqxDropDownList('selectItem', itemLevel); 
        itemCareer = $("#careerUpdate").jqxDropDownList('getItemByValue', data.dataFkCareer);
        $("#careerUpdate").jqxDropDownList("selectItem", itemCareer);
        itemEntity = $("#entityUpdate").jqxDropDownList('getItemByValue', data.dataPkEntity);
        $("#entityUpdate").jqxDropDownList('selectItem', itemEntity);
        itemMunicipality = $("#municipalityFilterUpdate").jqxDropDownList('getItemByValue', data.dataPkMunicipality);
        $("#municipalityFilterUpdate").jqxDropDownList('selectItem', itemMunicipality);
        itemLocality = $("#localityFilterUpdate").jqxDropDownList('getItemByValue', data.dataPkLocality);
        $("#localityFilterUpdate").jqxDropDownList('selectItem', itemLocality);
        itemPreparatory = $("#preparatoryFilterUpdate").jqxDropDownList('getItemByValue', data.dataFkPreparatory);
        $("#preparatoryFilterUpdate").jqxDropDownList('selectItem', itemPreparatory);
        $("#nameUpdate").val(data.dataName);
        $("#patern_nameUpdate").val(data.dataPaternName);
        $("#matern_nameUpdate").val(data.dataMaternName);     
        $("#birthCertificate").val(data.dataBirthCertificate);
        $("#hightSchoolCertificate").val(data.dataHightSchoolCertificate);         
    }
});
</script>
<br>
<div id="formUpdateInscription">
    <div id="registerUpdate">
        <div style="padding-left: 15px;">
            <b>Editar registro</b>
            <div style="float: right; width: 316px; height: 28px; position: relative;">
                <div style="float: right;">
                    <span>Matr�cula</span>
                    <input type="text" id="enrollmentUpdate" style="width: 140px; height: 26px" class="text-input" />
                    <span id="removeEnrollment" style="cursor: pointer; font-size: 16px; position: absolute; right: 6px; top: 4px; display: block;">X</span>
                </div>
            </div>
        </div>
        <div style="overflow: hidden; position: relative;">
            <form id="registerUpdateFormUpdate" style="padding: 15px;">
                <div style="float: left; margin-right: 5px;">
                    <span>Nombre</span> <br>
                    <input disabled="" type="text" id="nameUpdate" class="text-input" />
                </div>
                <div style="float: left; margin-right: 5px;">
                    <span>Apellido Paterno</span><br>
                    <input disabled type="text" id="patern_nameUpdate" class="text-input" />
                </div>
                <div style="float: left; margin-right: 5px;">
                    <span>Apellido Materno</span> <br>
                    <input disabled type="text" id="matern_nameUpdate" class="text-input" />
                </div>
                <div style="float: left; margin-right: 5px; display: none">
                    <span>Nivel</span> <br>
                    <div id="studyLevelUpdate"></div>
                </div>
                <div style="float: left; margin-right: 5px;">
                    <span>Carrera</span> <br>
                    <div id="careerUpdate"></div>
                </div>
                <img id="loadingPictureUpdate" style="right: 20px; top: 75px; position: absolute;" width="85" src="../content/pictures-system/load.GIF"/>
                <div style="float: left; margin-right: 5px;">
                    <span>Estado</span> <br>
                    <div id="entityUpdate"></div>
                </div>
                <div style="float: left; margin-right: 5px;">
                    <span>Municipio</span> <br>
                    <div id="municipalityFilterUpdate"></div>
                </div>
                <div style="float: left; margin-right: 5px;">
                    <span>Localidad</span> <br>
                    <div id="localityFilterUpdate"></div>
                </div>
                <div style="float: left; margin-right: 5px;">
                    <span>Preparatoria</span> <br>
                    <div id="preparatoryFilterUpdate"></div>
                </div>
                <div style="float: left; margin-right: 5px;">
                    <span>N�mero de acta de nacimiento</span> <br>
                    <input type="text" id="birthCertificate" class="text-input" />
                </div>
                <div style="float: left; margin-right: 5px;">
                    <span>N�mero de certificado de bachillerato</span> <br>
                    <input type="text" id="hightSchoolCertificate" class="text-input" />
                </div>
                <div style="float: left; margin: 20px; margin-left: 175px;">
                    <input type="button" value="Actualizar" id="sendButtonUpdate" />
                </div>
            </form>
        </div>
    </div>
</div>