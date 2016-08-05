<script>
    $(document).ready(function () {
        var dataForm = {
            fl_has_schoolarshipYes : false,
            fl_has_schoolarshipNot : true,
            fl_has_payment_penaltyYes : false,
            fl_has_payment_penaltyNot : true,
            fl_name_student : "Carlos",
            fl_enrollment : "UTS12",
            fl_group : "801",
            fl_career : "TICS",
            fl_ultimate_lowYes : false,
            fl_ultimate_lowNot : true,
            fl_temporaly_lowYes : false,
            fl_temporaly_lowNot : true,
            fl_request_for_studentYes : false,
            fl_request_for_studentNot : true,
            fl_repprobed : false,
            fl_background_academics_student : false,
            fl_utsem_not_first_option : false,
            fl_mistakes_regulation_school : false,
            fl_difficulty_matters_school : false,
            fl_that_matters : "algunas",
            fl_dissatisfaction_of_expectations : false,
            fl_deficient_orientation_vocational : false,
            fl_career_not_first_option : false,
            fl_others_factors_academics : false,
            fl_that_others_factors_academics : "algunos",
            fl_situation_economic_unfavorable : false,
            fl_student_work : false,
            fl_marriage_affects_situation_economic : false,
            fl_problems_bad_nutrition : false,
            fl_loss_employment_who_depends_student : false,
            fl_incompatibility_of_schedules_work_studies : false,
            fl_change_residence : false,
            fl_features_socioculturales_student : false,
            fl_lack_motivation : false,
            fl_distance_of_utsem : false,
            fl_problems_health : false,
            fl_not_present_classes : false,
            fl_problems_with_collagues_of_class : false,
            fl_problems_emotionals : false,
            fl_addictions : false,
            fl_problems_with_teachers : false,
            fl_others_factors_personals : false,
            fl_that_others_factors_personals : "algunos"
        };
        
        $("#register").jqxExpander({ toggleMode: 'none', width: '800px', showArrow: false });
        $('#sendButton').jqxButton({ width: 70, height: 30 });
        $('#sendButton').on('click', function () {
//            $('#testForm').jqxValidator('validate');
            console.log(dataForm);
        });
        $('.text-input').jqxInput({  });
        $(".jqxCheckBox").jqxCheckBox({ width: 'auto', height: 25});
        $(".jqxRadioButton1").jqxRadioButton({ width: 'auto', height: 25, groupName: "Group1", disabled: true});
        $(".jqxRadioButton2").jqxRadioButton({ width: 'auto', height: 25, groupName: "Group2", disabled: true});
        $(".jqxRadioButton3").jqxRadioButton({ width: 'auto', height: 25, groupName: "Group3"});
        $(".jqxRadioButton4").jqxRadioButton({ width: 'auto', height: 25, groupName: "Group4"});
        // initialize validator.
//        $('#testForm').jqxValidator({
//            rules: [
//                   { input: '#userInput', message: 'Username is required!', action: 'keyup, blur', rule: 'required' }
//            ]
//        });
        $.each(dataForm, function(index, value) {
            if($("[id="+index+"]").is("i")){
                $("[id="+index+"]").text(value);
            }else{
                $("[id="+index+"]").val(value);                
                if(index==="fl_has_schoolarshipYes" && value){
                    $(".fl_has_schoolarshipYes").show();
                }else if(index==="fl_has_schoolarshipNot" && value){
                    $(".fl_has_schoolarshipYes").hide();
                }
                if(index==="fl_difficulty_matters_school" && value){
                    $(".fl_difficulty_matters_school").show();
                }else if(index==="fl_difficulty_matters_school"){
                    $("#fl_that_matters").val("");
                    dataForm.fl_that_matters="";
                    $(".fl_difficulty_matters_school").hide();
                }
                if(index==="fl_others_factors_academics" && value){
                    $(".fl_others_factors_academics").show();
                }else if(index==="fl_others_factors_academics"){
                    $("#fl_that_others_factors_academics").val("");
                    dataForm.fl_that_others_factors_academics="";
                    $(".fl_others_factors_academics").hide();
                }
                if(index==="fl_others_factors_personals" && value){
                    $(".fl_others_factors_personals").show();
                }else if(index==="fl_others_factors_personals"){
                    $("#fl_that_others_factors_personals").val("");
                    dataForm.fl_others_factors_personals="";
                    $(".fl_others_factors_personals").hide();
                }
            }
        }); 
        $('.jqxCheckBox').on('change', function (event) { 
            var checked = event.args.checked; 
            var index =$(this).attr("id");
            dataForm[index]=checked;            
            if(index==="fl_difficulty_matters_school" && checked){
                $(".fl_difficulty_matters_school").show();
            }else if(index==="fl_difficulty_matters_school"){
                $("#fl_that_matters").val("");
                dataForm.fl_that_matters="";
                $(".fl_difficulty_matters_school").hide();
            }
            if(index==="fl_others_factors_academics" && checked){
                $(".fl_others_factors_academics").show();
            }else if(index==="fl_others_factors_academics"){
                $("#fl_that_others_factors_academics").val("");
                dataForm.fl_that_others_factors_academics="";
                $(".fl_others_factors_academics").hide();
            }
            if(index==="fl_others_factors_personals" && checked){
                $(".fl_others_factors_personals").show();
            }else if(index==="fl_others_factors_personals"){
                $("#fl_that_others_factors_personals").val("");
                dataForm.fl_others_factors_personals="";
                $(".fl_others_factors_personals").hide();
            }
        }); 
        $(".jqxRadioButton1, .jqxRadioButton2, .jqxRadioButton3, .jqxRadioButton4").on('change', function (event) { 
            var checked = event.args.checked;   
            var index =$(this).attr("id");
            dataForm[index]=checked;
            if(index==="fl_has_schoolarshipYes" && checked){
                $(".fl_has_schoolarshipYes").show();
            }else if(index==="fl_has_schoolarshipNot" && checked){
                $(".fl_has_schoolarshipYes").hide();
            }
        }); 
        $('.text-input').on('change', function (event) {  
            var index =$(this).attr("id");
            var value =$(this).val();
            dataForm[index]=value;
        }); 
    });        
</script>
<style type="text/css">
    .jqxRadioButton1, .jqxRadioButton2, .jqxRadioButton3, .jqxRadioButton4{
        margin-right: 20px
    }
    .text-input
    {
        height: 21px;
        width: 150px;
    }
    .register-table
    {
        margin-top: 10px;
        margin-bottom: 10px;
    }
    .register-table td, 
    .register-table tr
    {
        margin: 0px;
        padding: 2px;
        border-spacing: 0px;
        border-collapse: collapse;
        font-family: Verdana;
        font-size: 12px;
    }
    h3 
    {
        display: inline-block;
        margin: 0px;
    }
    ul, li{
        list-style-type: none;
    }
</style>
<center>
<div id="register">
    <div><h3>REGISTRO DE BAJA</h3></div>
    <div>
        <fieldset>
            <legend>INFORMACIÓN</legend>
            <table class="register-table" style="width: 100%">
                <tr>
                    <td> 
                        <ul>
                            <li>
                                <label><b>Cuenta con beca:</b></label><br>
                                <div style='margin-top: 10px; display: inline-block' id='fl_has_schoolarshipYes' class='jqxRadioButton1'>Si</div>
                                <div style='margin-top: 10px; display: inline-block' id='fl_has_schoolarshipNot' class='jqxRadioButton1'>No</div>
                                <ul style="padding-left: 0px;" class="fl_has_schoolarshipYes">
                                    <li>
                                        <ul style="padding-left: 20px;">
                                            <li>
                                                <label><b>Tipo de beca:</b></label><br>
                                                <ul style="padding-left: 15px;">
                                                    <li><div style='margin-top: 10px; display: inline-block' id='' class='jqxCheckBox'>Acade</div></li>
                                                    <li><div style='margin-top: 10px; display: inline-block' id='' class='jqxCheckBox'>Socio</div></li>
                                                    <li><div style='margin-top: 10px; display: inline-block' id='' class='jqxCheckBox'>Manu</div></li>
                                                    <li><div style='margin-top: 10px; display: inline-block' id='' class='jqxCheckBox'>Trans</div></li>
                                                </ul>
                                            </li>
                                        </ul>                                        
                                    </li>
                                </ul>
                            </li>                                    
                        </ul>                        
                    </td>
                    <td valign="top">
                        <label><b>Tiene adeudos:</b></label><br>                        
                        <div style='margin-top: 10px; display: inline-block' id='fl_has_payment_penaltyYes' class='jqxRadioButton2'>Si</div>
                        <div style='margin-top: 10px; display: inline-block' id='fl_has_payment_penaltyNot' class='jqxRadioButton2'>No</div>
                    </td>
                </tr>
            </table>
        </fieldset>
        <fieldset>
            <legend>I.  DATOS GENERALES DEL ALUMNO</legend>
            <table class="register-table" style="width: 100%">
                <tr>
                    <td>                        
                        <label><b>Nombre:</b></label><br>
                        <span><b><i id="fl_name_student">Nombre</i><b/></span>
                    </td>
                    <td>                        
                        <label><b>Matrícula:</b></label><br>
                        <span><b><i id="fl_enrollment">Matrícula:</i></b></span>
                    </td>
                    <td>                        
                        <label><b>Grupo Escolar:</b></label><br>
                        <span><b><i id="fl_group">Grupo</i></b></span>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">                        
                        <label><b>Carrera:</b></label><br>
                        <span><b><i id="fl_career">Carrera:</i></b></span>
                    </td>
                </tr>
                
            </table>
        </fieldset>
        <fieldset>
            <legend>II. INFORMACIÓN SOBRE LA BAJA</legend>
            <table class="register-table" style="width: 100%">
                <tr>
                    <td>   
                        <ul>
                            <li>
                                <label><b>1.    Indique el tipo de baja que se solicita:</b></label><br>
                                <ul>
                                    <li>
                                        <div style='margin-top: 10px; display: inline-block' id='fl_ultimate_lowYes' class='jqxRadioButton3'>BAJA DEFINITIVA</div>
                                        <div style='margin-top: 10px; display: inline-block' id='fl_temporaly_lowNot' class='jqxRadioButton3'>BAJA TEMPORAL</div>
                                    </li>
                                    <li>
                                        <label><b>¿LA BAJA FUE SOLICITADA POR EL ALUMNO?</b></label><br>
                                        <div style='margin-top: 10px; display: inline-block' id='fl_request_for_studentYes' class='jqxRadioButton4'>Si</div>
                                        <div style='margin-top: 10px; display: inline-block' id='fl_request_for_studentNot' class='jqxRadioButton4'>No</div>
                                    </li>    
                                </ul>
                            </li>
                        </ul>
                    </td>
                </tr>
                <tr>
                    <td>                        
                        <ul>
                            <li>
                                <label><b>2.    Indique el motivo de la baja:</b></label>
                                <ul>
                                    <li>
                                        <label><b>a) FACTORES ACADÉMICOS</b></label>
                                        <ul>
                                            <li><div style='margin-top: 10px;' id='fl_repprobed' class='jqxCheckBox'>REPROBACIÓN</div></li>
                                            <li><div style='margin-top: 10px;' id='fl_background_academics_student' class='jqxCheckBox'>ANTECEDENTES ACADÉMICOS DEL ESTUDIANTE</div></li>
                                            <li><div style='margin-top: 10px;' id='fl_utsem_not_first_option' class='jqxCheckBox'>LA UTSEM NO ERA SU PRIMERA OPCIÓN</div></li>
                                            <li><div style='margin-top: 10px;' id='fl_mistakes_regulation_school' class='jqxCheckBox'>FALTAS AL REGLAMENTO ESCOLAR</div></li>
                                            <li>
                                                <div style='margin-top: 10px;' id='fl_difficulty_matters_school' class='jqxCheckBox'>DIFICULTAD EN EL APRENDIZAJE DE ALGUNAS MATERIA(S)</div>
                                                <ul>
                                                    <li class="fl_difficulty_matters_school">
                                                        <div style='margin-top: 10px;'><b>¿CUÁLES MATERÍAS?</b></div>
                                                        <input type='text' id='fl_that_matters' class='text-input' />
                                                    </li>  
                                                </ul>
                                            </li>                                                                                      
                                            <li><div style='margin-top: 10px;' id='fl_dissatisfaction_of_expectations' class='jqxCheckBox'>INSATISFACCIÓN DE EXPECTATIVAS</div></li>
                                            <li><div style='margin-top: 10px;' id='fl_deficient_orientation_vocational' class='jqxCheckBox'>DEFICIENTE ORIENTACIÓN VOCACIONAL</div></li>
                                            <li><div style='margin-top: 10px;' id='fl_career_not_first_option' class='jqxCheckBox'>LA CARRERA NO ERA SU PRIMERA OPCIÓN</div></li>
                                            <li>
                                                <div style='margin-top: 10px;' id='fl_others_factors_academics' class='jqxCheckBox'>OTROS FACTORES</div>
                                                <ul>
                                                    <li class="fl_others_factors_academics">
                                                        <div style='margin-top: 10px;'><b>¿CUÁLES OTROS?</b></div>
                                                        <input type='text' id='fl_that_others_factors_academics' class='text-input' />
                                                    </li>
                                                </ul>
                                            </li>                                                    
                                        </ul>
                                    </li>
                                </ul>
                            </li>
                            <li>
                                <ul>
                                    <li>
                                        <label><b>b) FACTORES ECONÓMICOS</b></label>
                                        <ul>
                                            <li><div style='margin-top: 10px;' id='fl_situation_economic_unfavorable' class='jqxCheckBox'>SITUACIÓN ECONÓMICA DESFAVORABLE DEL ALUMNO</div></li>
                                            <li><div style='margin-top: 10px;' id='fl_student_work' class='jqxCheckBox'>EL ALUMNO TRABAJA</div></li>
                                            <li><div style='margin-top: 10px;' id='fl_marriage_affects_situation_economic' class='jqxCheckBox'>MATRIMONIO DEL ALIMNO QUE AFECTE SU SITUACIÓN ECONÓMICA</div></li>
                                            <li><div style='margin-top: 10px;' id='fl_problems_bad_nutrition' class='jqxCheckBox'>PROBLEMAS DE MALNUTRICIÓN</div></li>
                                            <li><div style='margin-top: 10px;' id='fl_loss_employment_who_depends_student' class='jqxCheckBox'>PERDIDA DEL EMPLEO DE QUIEN SOSTIENE AL ALUMNO</div></li>
                                            <li><div style='margin-top: 10px;' id='fl_incompatibility_of_schedules_work_studies' class='jqxCheckBox'>INCOMPATIBILIDAD DE HORARIOS DE TRABAJO Y ESCUELA</div></li>                                            
                                        </ul>
                                    </li>
                                    <li>
                                        <label><b>c) FACTORES PERSONALES</b></label>
                                        <ul>
                                            <li><div style='margin-top: 10px;' id='fl_change_residence' class='jqxCheckBox'>CAMBIO DE RESIDENCIA</div></li>
                                            <li><div style='margin-top: 10px;' id='fl_features_socioculturales_student' class='jqxCheckBox'>CARACTERISTÍCAS SOCIOCULTURALES DEL ALUMNO</div></li>
                                            <li><div style='margin-top: 10px;' id='fl_lack_motivation' class='jqxCheckBox'>FALTA DE MOTIVACIÓN POR PROBLEMAS PERSONALES</div></li>
                                            <li><div style='margin-top: 10px;' id='fl_distance_of_utsem' class='jqxCheckBox'>DISTANCIA DE LA UTSEM</div></li>
                                            <li><div style='margin-top: 10px;' id='fl_problems_health' class='jqxCheckBox'>PROBLEMAS DE SALUD</div></li>
                                            <li><div style='margin-top: 10px;' id='fl_not_present_classes' class='jqxCheckBox'>NUNCA SE PRESENTÓ A CLASES</div></li>   
                                            <li><div style='margin-top: 10px;' id='fl_problems_with_collagues_of_class' class='jqxCheckBox'>PROBLEMAS CON LOS COMPAÑEROS DE CLASE</div></li>   
                                            <li><div style='margin-top: 10px;' id='fl_problems_emotionals' class='jqxCheckBox'>PROBLEMAS EMOCIONALES</div></li>  
                                            <li><div style='margin-top: 10px;' id='fl_addictions' class='jqxCheckBox'>ADICCIONES</div></li>  
                                            <li><div style='margin-top: 10px;' id='fl_problems_with_teachers' class='jqxCheckBox'>PROBLEMAS CON ALGUN(OS) PROFESOR(ES)</div></li> 
                                            <li>
                                                <div style='margin-top: 10px;' id='fl_others_factors_personals' class='jqxCheckBox'>OTROS FACTORES</div>
                                                <ul>
                                                    <li class="fl_others_factors_personals">
                                                        <div style='margin-top: 10px;'><b>¿CUÁLES OTROS?</b></div>
                                                        <input type='text' id='fl_that_others_factors_personals' class='text-input' />
                                                    </li>
                                                </ul>
                                            </li>                                                    
                                        </ul>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </td>
                    <tr>
                        <td colspan="2" style="text-align: center;"><input type="button" value="Guardar" id="sendButton" /></td>
                    </tr>
                </tr>
            </table>
        </fieldset>
    </div>
</div>
</center>