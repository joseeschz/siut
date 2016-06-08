<script>
$(document).ready(function () {
    $("#removeEnrollment").hide();
    $("#loadingPictureRatings").hide();
    var itemStudent = "";
    var itemPeriod = "";
    var itemLevel="";
    var itemCareer="";
    var itemSemester="";
    var itemStudyPlan="";
    var itemTypeEvaluation="";
    var itemScaleEvaluation="";
    
    var enrollmentRatings_temp="";
    var pkStudent_temp="";
    var pkCareerLevelStudy1_temp="";
    var pkCareerLevelStudy2_temp="";
    createDropDownStudyLevel("#studyLevelRatings",false);
    itemLevel=$('#studyLevelRatings').jqxDropDownList('getSelectedItem');    
    if(itemLevel!==undefined){
        createDropDownCareer(itemLevel.value,"#careerRatings",false);
        itemCareer = $('#careerRatings').jqxDropDownList('getSelectedItem');        
        itemCareer = $('#careerRatings').jqxDropDownList('getSelectedItem');
        if(itemCareer!==undefined){
            createDropDownStudyPlan(itemCareer.value,"#studyPlanRatings",false);
            itemStudyPlan = $('#studyPlanRatings').jqxDropDownList('getSelectedItem');  
            createDropDownSemester(itemLevel.value,"#semesterRatings", false);
            itemSemester = $('#semesterRatings').jqxDropDownList('getSelectedItem');
            var params = {
                pkStudent : 1,
                fkSemester : itemSemester.value                
            };
            createDropDownPeriodByStudentsCalifications("#periodRatings", params, false);
            itemPeriod = $('#periodRatings').jqxDropDownList('getSelectedItem');
            
            createDropDownEvaluationTypeUnlocked("#evaluationTypeRatings", false);
            itemTypeEvaluation = $('#evaluationTypeRatings').jqxDropDownList('getSelectedItem');
            
            createDropDownScaleEvaluation("#scaleEvaluationRatings", itemLevel.value, false);
            itemScaleEvaluation = $('#scaleEvaluationRatings').jqxDropDownList('getSelectedItem');
        }else{
            createDropDownStudyPlan(null,"#studyPlanRatings",false);
        }
    }else{
        createDropDownCareer(null, "#careerRatings", false);
        createDropDownSemester(null,"#semesterRatings", false);
        createDropDownStudyPlan(null,"#studyPlanRatings",false);
    }
    
    $("#registerRatings").jqxExpander({theme:theme, toggleMode: 'none', width: '100%', showArrow: false});
    $(".jqx-expander-header-content").width("95%");
    

    $('#nameRatings').jqxInput({theme:theme, disabled:true, width:300, height:26});
    $("#okWarning").click(function (){
        //en el evento submit del fomulario
        itemCareer=$('#careerRatings').jqxDropDownList('getSelectedItem');
        var datos = {
            "enrollmentRatings":enrollmentRatings_temp,
            "nameRatingsStudent":$("#nameRatings").val(),
            "careerRatings":itemCareer.value
        }; 
        $("#jqxWindowWarningRatings").jqxWindow('close');
    });
    createInputEnrrollment("#enrollmentRatings",false);
    $("#enrollmentRatings").on('select',function (event){
        var enrollment="";
        var pkStudent;
        if(event.args){
            var item = event.args.item;
            if(item){
                pkStudent = item.value;
                enrollment = item.label;
                enrollmentRatings_temp=enrollment;
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
                    $("#loadingPictureRatings").show();
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
                $("#loadingPictureRatings").fadeOut("slow");                
            });
        }
    });
    $("#removeEnrollment").click(function (){
        $(this).hide();
        disableElements(true);
    });
    disableElements(true);
    function disableElements(status){
        $("#studyLevelRatings").jqxDropDownList({disabled: status}); 
        $("#careerRatings").jqxDropDownList({disabled: status});      
        $("#semesterRatings").jqxDropDownList({disabled: status});  
        $("#scaleEvaluationRatings").jqxDropDownList({disabled: true});  
        $("#studyPlanRatings").jqxDropDownList({disabled: status}); 
        $("#evaluationTypeRatings").jqxDropDownList({disabled: status}); 
        $("#periodRatings").jqxDropDownList({disabled: status}); 
        $('#enrollmentRatings').jqxInput({disabled: !status});
        $('#nameRatings').jqxInput({disabled: true});
        if(status){
            $('#enrollmentRatings').val("");
            $("#nameRatings").val("");  
            $("#loadingPictureRatings").hide();
            $("#studyLevelRatings").jqxDropDownList('clearSelection'); 
            $("#careerRatings").jqxDropDownList('clearSelection'); 
            $("#semesterRatings").jqxDropDownList('clearSelection');   
            $("#studyPlanRatings").jqxDropDownList('clearSelection'); 
            $("#evaluationTypeRatings").jqxDropDownList('clearSelection'); 
            $("#periodRatings").jqxDropDownList('clearSelection'); 
        }else{
//            $("#studyLevelRatings").jqxDropDownList('selectIndex', 0); 
//            $("#careerRatings").jqxDropDownList('selectIndex', 0); 
//            $("#semesterRatings").jqxDropDownList('selectIndex', 0); 
//            $("#scaleEvaluationRatings").jqxDropDownList('selectIndex', 0); 
//            $("#studyPlanRatings").jqxDropDownList('selectIndex', 0); 
//            $("#evaluationTypeRatings").jqxDropDownList('selectIndex', 0);
//            $("#periodRatings").jqxDropDownList('selectIndex', 0);
            $("#studyLevelRatings").jqxDropDownList({disabled: !status}); 
            $("#careerRatings").jqxDropDownList({disabled: !status});      
            $("#scaleEvaluationRatings").jqxDropDownList({disabled: true});  
            
        }
    }
    function loadData(data){    
        $("#studyLevelRatings").off('change');
        $("#careerRatings").off('change');
        $("#studyPlanRatings").off('change');
        $("#semesterRatings").off('change');
        $("#evaluationTypeRatings").off('change');
        $("#periodRatings").off('change');
        
        $("#nameRatings").val(data.dataName+" "+data.dataPaternName+" "+data.dataMaternName);
        
        itemLevel = $("#studyLevelRatings").jqxDropDownList('getItemByValue', data.dataPkLevelStudy);
        $("#studyLevelRatings").jqxDropDownList('selectItem', itemLevel); 
        
        createDropDownScaleEvaluation("#scaleEvaluationRatings", itemLevel.value, true);
        itemScaleEvaluation = $('#scaleEvaluationRatings').jqxDropDownList('getSelectedItem');
        
        createDropDownCareer(itemLevel.value,"#careerRatings",true);         
        itemCareer = $("#careerRatings").jqxDropDownList('getItemByValue', data.dataFkCareer);
        $("#careerRatings").jqxDropDownList("selectItem", itemCareer);
        
        createDropDownStudyPlan(itemCareer.value,"#studyPlanRatings",true);
        $("#studyPlanRatings").jqxDropDownList("selectIndex", 0);
        itemStudyPlan = $('#studyPlanRatings').jqxDropDownList('getSelectedItem'); 
        
        itemLevel=$('#studyLevelRatings').jqxDropDownList('getSelectedItem');
        createDropDownSemester(itemLevel.value,"#semesterRatings", true);
        itemSemester = $('#semesterRatings').jqxDropDownList('getSelectedItem'); 
        $("#scaleEvaluationRatings").jqxDropDownList('selectIndex', 0);
        $("#evaluationTypeRatings").jqxDropDownList('selectIndex', 0);
        pkStudent_temp = data.dataPkStudent;
        pkCareerLevelStudy1_temp=data.dataPkCareerLevelStudy1;
        pkCareerLevelStudy2_temp=data.dataPkCareerLevelStudy2;
        
        var params = {
            pkStudent : pkStudent_temp,
            fkSemester : itemSemester.value                
        };
        createDropDownPeriodByStudentsCalifications("#periodRatings", params, true);
        itemPeriod = $('#periodRatings').jqxDropDownList('getSelectedItem');
        
        if(itemPeriod==null || itemPeriod==undefined){
            $("#studyLevelRatings").jqxDropDownList({disabled: false}); 
            $("#careerRatings").jqxDropDownList({disabled: true});      
            $("#semesterRatings").jqxDropDownList({disabled: false});  
            $("#scaleEvaluationRatings").jqxDropDownList({disabled: true});  
            $("#studyPlanRatings").jqxDropDownList({disabled: false}); 
            $("#evaluationTypeRatings").jqxDropDownList({disabled: false}); 
            $("#periodRatings").jqxDropDownList({disabled: false}); 
        }else{
            $("#studyLevelRatings").jqxDropDownList({disabled: false}); 
            $("#scaleEvaluationRatings").jqxDropDownList({disabled: true});  
        }
        $("#studyLevelRatings").off('change');
        $("#studyLevelRatings").on('change',function (event){
            var args = event.args;
            if (args) {
                 // index represents the item's index.                      
                var index = args.index;
                var item = args.item;
                // get item's label and value.
                var label = item.label;
                var value = item.value;
                var type = args.type; // keyboard, mouse or null depending on how the item was selected.
                createDropDownCareer(value,"#careerRatings",true);  
                if(value==1){
                    itemCareer = $("#careerRatings").jqxDropDownList('getItemByValue', pkCareerLevelStudy1_temp);
                    $("#careerRatings").jqxDropDownList("selectItem", itemCareer); 
                    
                    createDropDownStudyPlan(itemCareer.value,"#studyPlanRatings",true);
                    itemStudyPlan = $('#studyPlanRatings').jqxDropDownList('getSelectedItem'); 
                                        
                    createDropDownScaleEvaluation("#scaleEvaluationRatings", value, true);
                    itemScaleEvaluation = $('#scaleEvaluationRatings').jqxDropDownList('getSelectedItem');
                }else{
                    itemCareer = $("#careerRatings").jqxDropDownList('getItemByValue', pkCareerLevelStudy2_temp);
                    $("#careerRatings").jqxDropDownList("selectItem", itemCareer); 
                    
                    createDropDownStudyPlan(itemCareer.value,"#studyPlanRatings",true);
                    itemStudyPlan = $('#studyPlanRatings').jqxDropDownList('getSelectedItem');                                        
                    
                    createDropDownScaleEvaluation("#scaleEvaluationRatings", value, true);
                    itemScaleEvaluation = $('#scaleEvaluationRatings').jqxDropDownList('getSelectedItem');
                }                    
            }                  
        });
        
        $("#studyPlanRatings").off('change');
        $("#studyPlanRatings").on('change',function (event){
            var args = event.args;
            if (args) {
                 // index represents the item's index.                      
                var index = args.index;
                var item = args.item;
                // get item's label and value.
                var label = item.label;
                var value = item.value;
                var type = args.type; // keyboard, mouse or null depending on how the item was selected.
                itemLevel=$('#studyLevelRatings').jqxDropDownList('getSelectedItem');
                createDropDownSemester(itemLevel.value,"#semesterRatings", true);
                itemSemester = $('#semesterRatings').jqxDropDownList('getSelectedItem'); 
            }                  
        });
        
        $("#semesterRatings").off('change');
        $("#semesterRatings").on('change',function (event){
            var args = event.args;
            if (args) {
                 // index represents the item's index.                      
                var index = args.index;
                var item = args.item;
                // get item's label and value.
                var label = item.label;
                var value = item.value;
                var type = args.type; // keyboard, mouse or null depending on how the item was selected.
                itemTypeEvaluation = $('#evaluationTypeRatings').jqxDropDownList('getSelectedItem'); 
                createDropDownEvaluationTypeUnlocked("#evaluationTypeRatings", true);
                itemTypeEvaluation = $('#evaluationTypeRatings').jqxDropDownList('getSelectedItem'); 
                $("#evaluationTypeRatings").jqxDropDownList('selectIndex', 0);
            }                  
        }); 
    }    
});
</script>
<style>
    .disabled:not(.jqx-grid-cell-hover):not(.jqx-grid-cell-selected), .jqx-widget .disabled:not(.jqx-grid-cell-hover):not(.jqx-grid-cell-selected) {
        color: #656565 !important;
        background-color: #E0E0E0 !important;
    }
    .white:not(.jqx-grid-cell-hover):not(.jqx-grid-cell-selected), .jqx-widget .white:not(.jqx-grid-cell-hover):not(.jqx-grid-cell-selected) {
        color: #656565 !important;
        background-color: #fff ;
    }
    .approved{
        background-color: rgb(117, 201, 228) !important;
    }
    .not-approved{
        color: #656565 !important;
        background-color: #D7C1C1 !important;
    }
    .down{
        color: #656565 !important;
        background-color: #D7C1C1 !important;
    }
    .down{
        color: #656565 !important;
        background-color: #D7C1C1 !important;
    }
    .missingTeacherAcumulated{
        color: #656565 !important;
        background-color: #F2E0C1 !important;
    }
    .missingTeacherRegula{
        color: #656565 !important;
        background-color: #DECAB0 !important;
    }
    .jqx-slider-tickscontainer{
        color: rgb(84, 146, 95) !important;
    }
</style>
<br>
<div id="formRatingsInscription">
    <div id="registerRatings">
        <div style="padding-left: 15px;">
            <b>Consultar registro</b>
            <div style="float: right; width: 316px; height: 28px; position: relative;">
                <div style="float: right;">
                    <span>Matrícula</span>
                    <input type="text" id="enrollmentRatings" style="width: 140px; height: 26px" class="text-input" />
                    <span id="removeEnrollment" style="cursor: pointer; font-size: 16px; position: absolute; right: 6px; top: 4px; display: block;">X</span>
                </div>
            </div>
        </div>
        <div style=" position: relative;">
            <form id="registerRatingsForm" style="padding: 15px;">
                <div style="float: left; margin-right: 5px;">
                    <span>Nombre</span> <br>
                    <input disabled="" type="text" id="nameRatings" class="text-input" />
                </div>
                <br>
                <br>
                <br>
                <div style="float: left; margin-right: 5px;">
                    <span>Nivel</span> <br>
                    <div id="studyLevelRatings"></div>
                </div>
                <div style="float: left; margin-right: 5px;">
                    <span>Carrera</span> <br>
                    <div id="careerRatings"></div>
                </div>
                <div style="float: left; margin-right: 5px;">
                    <span>Plan de Estudio</span> <br>
                    <div id="studyPlanRatings"></div>
                </div>
                <div style="float: left; margin-right: 5px;">
                    <span>Cuatrimestre</span> <br>
                    <div id="semesterRatings"></div>
                </div>
                <div style="float: left; margin-right: 5px; display: none">
                    Saber<br>
                    <input type="hidden" id="pkWorkPlannig"/>
                    <div id='scaleEvaluationRatings'></div>
                </div>
                <div style="float: left; margin-right: 5px; display: none">
                    <span>Tipo</span><br>
                    <div id='evaluationTypeRatings'></div>
                </div>
                <div style="float: left; margin-right: 5px; display: none">
                    <span>Periodo</span><br>
                    <div id='periodRatings'></div>
                </div>
                <img id="loadingPictureRatings" style="right: 20px; top: 0px; position: absolute;" width="85" src="../content/pictures-system/load.GIF"/>
                
            </form>
        </div>
    </div>
</div>
