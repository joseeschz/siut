<script>
$(document).ready(function () {
    $("#removeEnrollment").hide();
    $("#loadingPictureUpdate").hide();
    var itemLevel="";
    var itemCareer="";
    var pkStudent;
    createDropDownStudyLevel("#studyLevelUpdate",false);
    itemLevel=$('#studyLevelUpdate').jqxDropDownList('getSelectedItem');
    createDropDownCareer(itemLevel.value,"#careerUpdate",false);
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
        itemCareer=$('#careerUpdate').jqxDropDownList('getSelectedItem');
        var datos = {
            "pkStudent": pkStudent,
            "field_name":"fl_authorized_access_preregister_ing",
            "field_value":"1"
        }; // los datos del 
        $.ajax({
            type: "POST",
            url: "../serviceStudent?updateField",
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
        if(event.args){
            var item = event.args.item;
            if(item){
                pkStudent = item.value;
                enrollment = item.label;
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
        $('#enrollmentUpdate').jqxInput({disabled: !status});
        $('#nameUpdate').jqxInput({disabled: status});
        $('#matern_nameUpdate').jqxInput({disabled: status});
        $('#patern_nameUpdate').jqxInput({disabled: status});
        $('#sendButtonUpdate').jqxButton({disabled: status});
        if(status){
            pkStudent=null;
            $('#enrollmentUpdate').val("");
            $("#nameUpdate").val("");
            $("#patern_nameUpdate").val("");
            $("#matern_nameUpdate").val(""); 
            $("#loadingPictureUpdate").hide();
            $("#careerUpdate").jqxDropDownList("selectIndex", 0);
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
        $("#nameUpdate").val(data.dataName);
        $("#patern_nameUpdate").val(data.dataPaternName);
        $("#matern_nameUpdate").val(data.dataMaternName);            
    }
});
</script>
<br>
<div id="formUpdateInscription">
    <div id="registerUpdate">
        <div style="padding-left: 15px;">
            <b>Autorizar registro</b>
            <div style="float: right; width: 316px; height: 28px; position: relative;">
                <div style="float: right;">
                    <span>Matrícula</span>
                    <input type="text" id="enrollmentUpdate" style="width: 140px; height: 26px" class="text-input" />
                    <span id="removeEnrollment" style="cursor: pointer; font-size: 16px; position: absolute; right: 6px; top: 4px; display: block;">X</span>
                </div>
            </div>
        </div>
        <div style="overflow: hidden; position: relative;">
            <form id="registerUpdateFormUpdate" style="padding: 15px;">
                <div style="float: left; margin-right: 5px;">
                    <span>Nombre</span> <br>
                    <input disabled="" type="text" id="nameUpdate" readonly="" class="text-input" />
                </div>
                <div style="float: left; margin-right: 5px;">
                    <span>Apellido Paterno</span><br>
                    <input disabled type="text" id="patern_nameUpdate" readonly="" class="text-input" />
                </div>
                <div style="float: left; margin-right: 5px;">
                    <span>Apellido Materno</span> <br>
                    <input disabled type="text" id="matern_nameUpdate" readonly="" class="text-input" />
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

                <div style="float: left; margin: 20px; margin-left: 175px;">
                    <input type="button" value="Autorizar" id="sendButtonUpdate" />
                </div>
            </form>
        </div>
    </div>
</div>