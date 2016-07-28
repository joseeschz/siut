<script>
$(document).ready(function () {
    $("#removeEnrollment").hide();
    $("#loadingPictureUpdate").hide();
    var itemPeriod = "";
    var itemCareerTSU="";
    var itemCareerING="";
    var pkStudent;
    var enrollment="";
    createDropDownPeriod("inscription","#periodFilter");
    itemPeriod = $('#periodFilter').jqxDropDownList('getSelectedItem');
    createDropDownCareer(1,"#careerUpdateTSU",false);
    createDropDownCareer(2,"#careerUpdateING",false);
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
    $("#okWarningUpdate").off("click");
    $("#okWarningUpdate").click(function (){
        //en el evento submit del fomulario
        itemCareerING=$('#careerUpdateING').jqxDropDownList('getSelectedItem');
        itemPeriod=$('#periodFilter').jqxDropDownList('getSelectedItem');
        var datos = {
            "pkStudent": pkStudent,
            "field_name":"fk_career",
            "field_value":itemCareerING.value
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
            }
        });
        var datos = {
            "pkStudent": pkStudent,
            "field_name":"fk_period_inscription_ing",
            "field_value":itemPeriod.value
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
            }
        });
        var datos = {
            "pkStudent": pkStudent,
            "field_name":"fl_preinscription_ing",
            "field_value": 1
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
                $("#jqxWindowWarningIncriptionsUpdate").jqxWindow('close');
                $('#jqxWindowOk').jqxWindow('open');
                $("#ok").off("click");
                $("#ok").click(function (){
                    $.ajax({
                        type: "POST",
                        async: false,
                        url: "../../content/data-jr/documentPreregisterIng/cedule.jsp?sessionCeduleIng",
                        data: {
                            "pt_enrollment": enrollment
                        },
                        beforeSend: function (xhr) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) {
                            $("#exportToPdf").submit();
                            $('#jqxWindowOk').jqxWindow('close');
                            $("#removeEnrollment").click();
                        }
                    });
                });
            }
        });       
        
        createInputEnrrollmentPreregisterING("#enrollmentUpdate",true);
        
    });
    createInputEnrrollmentPreregisterING("#enrollmentUpdate",false);
    $("#enrollmentUpdate").on('select',function (event){        
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
        $("#careerUpdateTSU").jqxDropDownList({disabled: status});        
        $("#careerUpdateING").jqxDropDownList({disabled: status});        
        $('#enrollmentUpdate').jqxInput({disabled: !status});
        $('#nameUpdate').jqxInput({disabled: status});
        $('#matern_nameUpdate').jqxInput({disabled: status});
        $('#patern_nameUpdate').jqxInput({disabled: status});
        $('#sendButtonUpdate').jqxButton({disabled: status});
        if(status){
            $('#enrollmentUpdate').val("");
            $("#nameUpdate").val("");
            $("#patern_nameUpdate").val("");
            $("#matern_nameUpdate").val("");
            $("#loadingPictureUpdate").hide();
            $("#careerUpdateTSU").jqxDropDownList("selectIndex", 0);
            $("#careerUpdateING").jqxDropDownList("selectIndex", 0);
            pkStudent=null;
            enrollment=null;
        }
    }
    function loadData(data){
        $("#careerUpdateTSU").jqxDropDownList({disabled: true});
        $("#careerUpdateING").jqxDropDownList({disabled: true});
        itemCareerTSU = $("#careerUpdateTSU").jqxDropDownList('getItemByValue', data.dataPkCareerLevelStudy1);
        $("#careerUpdateTSU").jqxDropDownList("selectItem", itemCareerTSU);
        itemCareerING = $("#careerUpdateING").jqxDropDownList('getItemByValue', data.dataPkCareerLevelStudy2);
        $("#careerUpdateING").jqxDropDownList("selectItem", itemCareerING);
        $("#nameUpdate").val(data.dataName);
        $("#patern_nameUpdate").val(data.dataPaternName);
        $("#matern_nameUpdate").val(data.dataMaternName);     
    }
});
</script>
<div style="margin-right: 5px; display: inline-block">
    Periodo <br>
    <div id='periodFilter'></div>
</div>
<br>
<br>
<form action="../../content/data-jr/documentPreregisterIng/cedule.jsp" target="_blank" method="POST" id="exportToPdf"></form>
<div id="formUpdateInscription">
    <div id="registerUpdate">
        <div style="padding-left: 15px;">
            <b>Preinscribir registro</b>
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
                <div style="float: left; margin-right: 5px;">
                    <span>Carrera TSU</span> <br>
                    <div id="careerUpdateTSU"></div>
                </div>
                <div style="float: left; margin-right: 5px;">
                    <span>Carrera ING</span> <br>
                    <div id="careerUpdateING"></div>
                </div>
                <img id="loadingPictureUpdate" style="right: 20px; top: 75px; position: absolute;" width="85" src="../content/pictures-system/load.GIF"/>
                <div style="float: left; margin: 20px; margin-left: 175px;">
                    <input type="button" value="Preinscribir" id="sendButtonUpdate" />
                </div>
            </form>
        </div>
    </div>
</div>