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
            
            loadTable(null, null, null, null);
            loadTableCalifications(null, null, null, null);
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
    
    $("#subjectMattersRatings").jqxExpander({disabled:true, theme:theme, toggleMode: 'none', width: '100%', height: 500, showArrow: false});

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
    function  disableElements(status){
        $("#studyLevelRatings").jqxDropDownList({disabled: status}); 
        $("#careerRatings").jqxDropDownList({disabled: status});      
        $("#semesterRatings").jqxDropDownList({disabled: status});  
        $("#scaleEvaluationRatings").jqxDropDownList({disabled: status});  
        $("#studyPlanRatings").jqxDropDownList({disabled: status}); 
        $("#evaluationTypeRatings").jqxDropDownList({disabled: status}); 
        $("#periodRatings").jqxDropDownList({disabled: status}); 
        $("#subjectMattersRatings").jqxExpander({disabled: status});
        $('#enrollmentRatings').jqxInput({disabled: !status});
        $('#nameRatings').jqxInput({disabled: true});
        if(status){
            $('#enrollmentRatings').val("");
            $("#nameRatings").val("");  
            $("#loadingPictureRatings").hide();
            $("#studyLevelRatings").jqxDropDownList('clearSelection'); 
            $("#careerRatings").jqxDropDownList('clearSelection'); 
            $("#semesterRatings").jqxDropDownList('clearSelection'); 
            $("#scaleEvaluationRatings").jqxDropDownList('clearSelection'); 
            $("#studyPlanRatings").jqxDropDownList('clearSelection'); 
            $("#evaluationTypeRatings").jqxDropDownList('clearSelection'); 
            $("#periodRatings").jqxDropDownList('clearSelection'); 
            $("#tableSubjectMatters").jqxGrid('clear'); 
            $("#tableSubjectMattersCalifications").jqxGrid('clear'); 
        }else{
//            $("#studyLevelRatings").jqxDropDownList('selectIndex', 0); 
//            $("#careerRatings").jqxDropDownList('selectIndex', 0); 
//            $("#semesterRatings").jqxDropDownList('selectIndex', 0); 
//            $("#scaleEvaluationRatings").jqxDropDownList('selectIndex', 0); 
//            $("#studyPlanRatings").jqxDropDownList('selectIndex', 0); 
//            $("#evaluationTypeRatings").jqxDropDownList('selectIndex', 0);
//            $("#periodRatings").jqxDropDownList('selectIndex', 0);
        }
    }
    function loadData(data){     
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
        pkStudent_temp = data.dataPkStudent;
        var params = {
            pkStudent : pkStudent_temp,
            fkSemester : itemSemester.value                
        };
        createDropDownPeriodByStudentsCalifications("#periodRatings", params, true);
        itemPeriod = $('#periodRatings').jqxDropDownList('getSelectedItem');
        
        loadTable(itemCareer.value, itemSemester.value, itemStudyPlan.value, 1);      
        loadTableCalifications(itemCareer.value, itemSemester.value, itemStudyPlan.value, 1); 
        
        
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
                createDropDownEvaluationTypeUnlocked("#evaluationTypeRatings", true);
                itemTypeEvaluation = $('#evaluationTypeRatings').jqxDropDownList('getSelectedItem');      
            }                  
        });
        
        $("#evaluationTypeRatings").off('change');
        $("#evaluationTypeRatings").on('change',function (event){
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
                itemSemester = $('#semesterRatings').jqxDropDownList('getSelectedItem');
                itemStudyPlan = $('#studyPlanRatings').jqxDropDownList('getSelectedItem');
                
                var params = {
                    pkStudent : pkStudent_temp,
                    fkSemester : itemSemester.value                
                };
                createDropDownPeriodByStudentsCalifications("#periodRatings", params, true);
                itemPeriod = $('#periodRatings').jqxDropDownList('getSelectedItem');
                
                loadTable(itemCareer.value, itemSemester.value, itemStudyPlan.value, 1);      
                loadTableCalifications(itemCareer.value, itemSemester.value, itemStudyPlan.value, 1);      
            }                  
        });
    }
    function loadTable(pkCareer, pkSemester, pkStudyPlan, pkStudent){
        var loadSource=function(pkCareer, pkSemester, pkStudyPlan, pkStudent){
            var ordersSource ={
                dataFields: [
                    { name: 'id', type:'int'},
                    { name: 'dataProgresivNumber', type:'int'},
                    { name: 'dataNameSubjectMatter', type: 'string' },
                    { name: 'dataIntegradora', type: 'string' }                    
                ],
                root: "__ENTITIES",
                dataType: "json",
                async: false,
                id: 'id',
                url: '../serviceSubjectMatter?view&&pkCareer='+pkCareer+'&&pkSemester='+pkSemester+'&&pkStudyPlan='+pkStudyPlan+''
            };
            return ordersSource;
        };
        var dataAdapter = new $.jqx.dataAdapter(loadSource(pkCareer, pkSemester, pkStudyPlan, pkStudent));
        $("#tableSubjectMatters").jqxGrid({
            width: 930,
            height : 220,
            selectionmode: "singlerow",
            localization: getLocalization("es"),
            source: dataAdapter,
            pageable: false,
            editable: false,
            filterable: false,
            enabletooltips: true,
            altRows: true,
            showToolbar: true,
            toolbarHeight: 30,
            columnsheight: 50,
            pagerbuttonscount: 10,
            ready: function(){

            },
            columns: [
                { text: 'NP',filterable: false, editable: false, datafield: 'dataProgresivNumber', width: 20 },
                { text: 'Materia', datafield: 'dataNameSubjectMatter'},
                { text: 'Integradora', columntype: 'custom', align:'center', cellsAlign:'center', dataField: 'dataIntegradora', width: 100}
            ]
        });
    }
    function loadTableCalifications(pkCareer, pkSemester, pkStudyPlan, pkStudent){
        var loadSource=function(pkCareer, pkSemester, pkStudyPlan, pkStudent){
            var ordersSource ={
                dataFields: [
                    { name: 'id', type:'int'},
                    { name: 'dataProgresivNumber', type:'int'},
                    { name: 'dataNameSubjectMatter', type: 'string' },
                    { name: 'dataIntegradora', type: 'string' },
                    { name: 'dataCalificationBe', type: 'string' },
                    { name: 'dataCalificationKnow', type: 'string' },
                    { name: 'dataCalificationDo', type: 'string' },
                    { name: 'dataAvg', type: 'string' }
                ],
                root: "__ENTITIES",
                dataType: "json",
                async: false,
                id: 'id',
                url: '../serviceSubjectMatter?view&&pkCareer='+pkCareer+'&&pkSemester='+pkSemester+'&&pkStudyPlan='+pkStudyPlan+''
            };
            return ordersSource;
        };
        var dataAdapter = new $.jqx.dataAdapter(loadSource(pkCareer, pkSemester, pkStudyPlan, pkStudent));
        $("#tableSubjectMattersCalifications").jqxGrid({
            width: 930,
            height : 220,
            selectionmode: "singlerow",
            localization: getLocalization("es"),
            source: dataAdapter,
            pageable: false,
            editable: true,
            filterable: false,
            enabletooltips: true,
            altRows: true,
            showToolbar: true,
            toolbarHeight: 30,
            pagerbuttonscount: 10,
            ready: function(){

            },
            columngroups: [
                { text: 'Calificación', align: 'center', name: 'calification' }
            ],
            columns: [
                { text: 'NP',filterable: false, editable: false, datafield: 'dataProgresivNumber', width: 20 },
                { text: 'Materia', dataField: 'dataNameSubjectMatter', editable: false},
                { text: 'Ser', columngroup: 'calification', datafield: 'dataCalificationBe', width: 50},
                { text: 'Saber', columngroup: 'calification', datafield: 'dataCalificationKnow', width: 50},
                { text: 'Hacer', columngroup: 'calification', datafield: 'dataCalificationDo', width: 50},
                { text: 'Total', columngroup: 'calification', datafield: 'dataAvg', editable: false, width: 50}
            ]
        });
    }
    function loadTableCalificationsTemp(){
        var loadSource = function(){
            var valItemCareer=0;
            var valItemSemester=0;
            var valItemPeriod=0;
            var valItemGroup=0;
            var valItemActivity=0;
            itemTypeEvaluation = $('#evaluationTypeRatings').jqxDropDownList('getSelectedItem');
            if(itemCareer!==undefined){
                valItemCareer=itemCareer.value;
            }
            if(itemSemester!==undefined){
                valItemSemester=itemSemester.value;
            }
            if(itemPeriod!==undefined){
                valItemPeriod=itemPeriod.value;
            }
            var ordersSource ={
                dataFields: [
                    { name: 'id', type:'int'},
                    { name: 'dataProgresivNumber', type:'int'},
                    { name: 'dataPkStudent', type:'int'},
                    { name: 'dataRealized', type:'int'},
                    { name: 'dataEnrollment', type:'string'},
                    { name: 'dataNameStudent', type:'string'},
                    { name: 'dataApproved', type: 'string' },
                    { name: 'dataValueObtanied', type: 'double' },
                    { name: 'dataValueObtaniedNew', type: 'double' },
                    { name: 'dataValueObtaniedEquivalent', type: 'double' },
                    { name: 'dataAcomulatedNow', type: 'double' },                    
                    { name: 'dataObtaniedAcumulatedBe', type: 'double' },
                    { name: 'dataObtaniedAcumulatedKnow', type: 'double' },
                    { name: 'dataObtaniedAcumulatedDo', type: 'double' },
                    { name: 'dataObtaniedAcumulatedTotal', type: 'double' },
                    { name: 'dataObtaniedRegularizationBe', type: 'double' },
                    { name: 'dataObtaniedRegularizationKnow', type: 'double' },
                    { name: 'dataObtaniedRegularizationDo', type: 'double' },
                    { name: 'dataObtaniedRegularizationTotal', type: 'double' },
                    { name: 'dataObtaniedGlobalBe', type: 'double' },
                    { name: 'dataObtaniedGlobalKnow', type: 'double' },
                    { name: 'dataObtaniedGlobalDo', type: 'double' },
                    { name: 'dataObtaniedGlobalTotal', type: 'double' },
                    { name: 'dataPermitGlobal', type: 'string' }
                ],
                root: "__ENTITIES",
                type:"POST",
                dataType: "json",
                id: 'id',
                async: false,
                data :{
                    view: itemTypeEvaluation.value,
                    pkCareer : 6,
                    pkSemester : 1,
                    pkActivity : 0,
                    pkGroup : 1,
                    pkMatter : 2,
                    pkPeriod : 3                    
                },
                url: '../serviceActivitiesCalByStudents'
            };
            return ordersSource;
        };
        var length =0 ;
        var dataAdapter = new $.jqx.dataAdapter(loadSource(),{
            loadComplete: function () {
                length = dataAdapter.records.length;
            }
        });
        $("#tableSubjectMattersCalifications").off('cellselect');
        $("#tableSubjectMattersCalifications").on('cellselect', function (event) {
            var rowBoundIndex = event.args.rowindex;
            $("#contenttabletableSubjectMattersCalifications").each(function (){
                $(this).children().children().css({
                    "text-decoration":"none"
                });
            });
            var colorUnderline = $("#row"+rowBoundIndex+"tableSubjectMattersCalifications").children().children().css("color");
            $("#row"+rowBoundIndex+"tableSubjectMattersCalifications").children().css({
                "text-decoration":"underline",
                "text-decoration-color":colorUnderline||"#000"
            });
        });

        var initeditor = function (row, cellvalue, editor) {  
            itemTypeEvaluation = $('#evaluationTypeRatings').jqxDropDownList('getSelectedItem');
            var cell = $('#tableSubjectMattersCalifications').jqxGrid('getselectedcell');                 
            if(itemTypeEvaluation.value===1){
                if(cell.column==="dataValueObtaniedEquivalent"){
                    editor.jqxNumberInput({ 
                        inputMode: 'simple', 
                        spinButtons: true,
                        digits:2,
                        min:0,
                        max: 10
                    }); 
                }else{
                    editor.jqxNumberInput({ 
                        inputMode: 'simple', 
                        spinButtons: true,
                        digits:1,
                        min:0,
                        max: value_max
                    }); 
                }                                       
            }else{
                var maxValueScale = parseFloat(getMaxValueByScale(cell.datafield)).toFixed(2);
                var minValueScale = parseFloat(getMinValueByScale(cell)).toFixed(2);
                editor.jqxNumberInput({ 
                    inputMode: 'simple', 
                    spinButtons: true,
                    digits:1,
                    min: minValueScale,
                    max: maxValueScale
                });
            }
            editor.off('change');
            editor.on('change', function (event) {  
                if(event.args){                  
                    if(itemTypeEvaluation.value===1){
                        if(cell.column==="dataValueObtaniedEquivalent"){
                            var value = parseFloat($(this).val());
                            var valueObtaniedNew = parseFloat(value*value_max/10).toFixed(2);
                            $("#tableSubjectMattersCalifications").jqxGrid('setcellvalue', row, "dataValueObtaniedNew", valueObtaniedNew); 
                        }else{
                            var params = {
                                "evaluationType" : itemTypeEvaluation.value,
                                "row": row,
                                "value": $(this).val(),
                                "oldvalue" : cellvalue
                            };
                            evaluateActivityByRow(params);
                        }
                    }else if(itemTypeEvaluation.value===2){  
                        var rowData = $('#tableSubjectMattersCalifications').jqxGrid('getrowdata', row);
                        var cellBe = null;
                        var cellKnow = null;
                        var cellDo = null;

                        if(cell.datafield==="dataObtaniedRegularizationBe"){
                            cellBe = $(this).val();
                            cellKnow = $('#tableSubjectMattersCalifications').jqxGrid('getcelltext', row, "dataObtaniedRegularizationKnow");
                            cellDo = $('#tableSubjectMattersCalifications').jqxGrid('getcelltext', row, "dataObtaniedRegularizationDo");
                        }
                        if(cell.datafield==="dataObtaniedRegularizationKnow"){
                            cellBe = $('#tableSubjectMattersCalifications').jqxGrid('getcelltext', row, "dataObtaniedRegularizationBe");
                            cellKnow = $(this).val();
                            cellDo = $('#tableSubjectMattersCalifications').jqxGrid('getcelltext', row, "dataObtaniedRegularizationDo");
                        }
                        if(cell.datafield==="dataObtaniedRegularizationDo"){
                            cellBe = $('#tableSubjectMattersCalifications').jqxGrid('getcelltext', row, "dataObtaniedRegularizationBe");
                            cellKnow = $('#tableSubjectMattersCalifications').jqxGrid('getcelltext', row, "dataObtaniedRegularizationKnow");
                            cellDo = $(this).val();
                        }

                        var total = parseFloat(cellBe)+parseFloat(cellKnow)+parseFloat(cellDo);
                        var total=total.toFixed(2);
                        var params = {
                            "evaluationType" : itemTypeEvaluation.value,
                            "rowID": rowData.id,
                            "value": $(this).val(),
                            "total" : total,
                            "scaleType" :  getTypeScale(cell.datafield)
                        };
                        evaluateScaleByRow(params);
                    }else if(itemTypeEvaluation.value===3){  
                        var rowData = $('#tableSubjectMattersCalifications').jqxGrid('getrowdata', row); 
                        var cellBe = null;
                        var cellKnow = null;
                        var cellDo = null;

                        if(cell.datafield==="dataObtaniedGlobalBe"){
                            cellBe = $(this).val();
                            cellKnow = $('#tableSubjectMattersCalifications').jqxGrid('getcelltext', row, "dataObtaniedGlobalKnow");
                            cellDo = $('#tableSubjectMattersCalifications').jqxGrid('getcelltext', row, "dataObtaniedGlobalDo");
                        }
                        if(cell.datafield==="dataObtaniedGlobalKnow"){
                            cellBe = $('#tableSubjectMattersCalifications').jqxGrid('getcelltext', row, "dataObtaniedGlobalBe");
                            cellKnow = $(this).val();
                            cellDo = $('#tableSubjectMattersCalifications').jqxGrid('getcelltext', row, "dataObtaniedGlobalDo");
                        }
                        if(cell.datafield==="dataObtaniedGlobalDo"){
                            cellBe = $('#tableSubjectMattersCalifications').jqxGrid('getcelltext', row, "dataObtaniedGlobalBe");
                            cellKnow = $('#tableSubjectMattersCalifications').jqxGrid('getcelltext', row, "dataObtaniedGlobalKnow");
                            cellDo = $(this).val();
                        }
                        var total = parseFloat(cellBe)+parseFloat(cellKnow)+parseFloat(cellDo);
                        var total=total.toFixed(2);
                        var params = {
                            "evaluationType" : itemTypeEvaluation.value,
                            "rowID": rowData.id,
                            "value": $(this).val(),
                            "total" : total,
                            "scaleType" :  getTypeScale(cell.datafield)
                        };
                        evaluateScaleByRow(params);
                    }
                } 
            });
        };
        var validation = function (cell, value) {    
            itemTypeEvaluation = $('#evaluationTypeRatings').jqxDropDownList('getSelectedItem');
            if(itemTypeEvaluation.value===1){
                if(cell.column==="dataValueObtaniedEquivalent"){
                    if (value > 10) {
                        return { result: false, message: "Calificación máxima 10"};
                    }
                    if (value < 0) {
                        return { result: false, message: "Calificación minima 0"};
                    }
                }else{
                    if (value > value_max) {
                        return { result: false, message: "Calificación máxima "+value_max};
                    }
                    if (value < 0) {
                        return { result: false, message: "Calificación minima 0"};
                    }
                }
            }else{
                var maxValueScale = parseFloat(getMaxValueByScale(cell.datafield)).toFixed(2);
                var minValueScale = parseFloat(getMinValueByScale(cell)).toFixed(2);                        
                if (value < 0 || value > maxValueScale) {
                    return { result: false, message: "Calificación máxima "+maxValueScale};
                }
                if (value < minValueScale) {
                    return { result: false, message: "Calificación minima "+minValueScale};
                }
            }
            return true;
        };
        var cellclass = function (row, columnfield, value) {
            var classTheme="white ";
            itemTypeEvaluation = $('#evaluationTypeRatings').jqxDropDownList('getSelectedItem');          
            if(itemTypeEvaluation.value===1){                    
                classTheme=classTheme+"disabled";
            }else if(itemTypeEvaluation.value===2){ 
                if(columnfield==="dataObtaniedAcumulatedBe"){
                    classTheme=classTheme+"disabled";
                }
                if(columnfield==="dataObtaniedAcumulatedKnow"){
                    classTheme=classTheme+"disabled";
                }
                if(columnfield==="dataObtaniedAcumulatedDo"){
                    classTheme=classTheme+"disabled";
                }
                if(columnfield==="dataObtaniedRegularizationBe"){
                    classTheme=classTheme+"disabled";
                }
            }else if(itemTypeEvaluation.value===3){ 
                var data = $('#tableSubjectMattersCalifications').jqxGrid('getrowdata', row);
                if(data.dataObtaniedGlobalTotal>=8){
                    if(columnfield==="dataObtaniedAcumulatedBe"){
                        classTheme=classTheme+"disabled";
                    }
                    if(columnfield==="dataObtaniedAcumulatedKnow"){
                        classTheme=classTheme+"disabled";
                    }
                    if(columnfield==="dataObtaniedAcumulatedDo"){
                        classTheme=classTheme+"disabled";
                    }
                    if(columnfield==="dataObtaniedRegularizationBe"){
                        classTheme=classTheme+"disabled";
                    }
                    if(columnfield==="dataObtaniedRegularizationKnow"){
                        classTheme=classTheme+"disabled";
                    }
                    if(columnfield==="dataObtaniedRegularizationDo"){
                        classTheme=classTheme+"disabled";
                    }
                    if(columnfield==="dataObtaniedGlobalBe"){
                        classTheme=classTheme+"disabled";
                    };
                }
            }
            return classTheme;
        };
        var cellbeginedit = function (row, datafield, columntype, value) {
            itemTypeEvaluation = $('#evaluationTypeRatings').jqxDropDownList('getSelectedItem');          
            if(itemTypeEvaluation.value===1){
                return true;
            }else if(itemTypeEvaluation.value===2){
                return true;
            }else if(itemTypeEvaluation.value===3){
                return true;
            }
        };
        
        var cellsrenderer = function (row, column, value, defaultHtml) {
            itemTypeEvaluation = $('#evaluationTypeRatings').jqxDropDownList('getSelectedItem');  
            var data = $('#tableSubjectMattersCalifications').jqxGrid('getrowdata', row);
            var element = $(defaultHtml);
            if(itemTypeEvaluation.value===1){
                if(data.dataObtaniedAcumulatedTotal<"8"){
                    element.css('color', '#F70025 !important');
                    return element[0].outerHTML;
                }
            }else if(itemTypeEvaluation.value===2){
                if(data.dataObtaniedRegularizationTotal<"8"){
                    element.css('color', '#F70025 !important');
                    return element[0].outerHTML;
                }
            }else if(itemTypeEvaluation.value===3){
                if(data.dataObtaniedGlobalTotal<"8"){
                    element.css('color', '#F70025 !important');
                    return element[0].outerHTML;
                }
            }
            return defaultHtml;
        };

        var prepareColumns = function (columsManager){
            for(var i = 0; i<columsManager.length; i++){
                columsDefault.push(columsManager[i]);
            }
            return columsDefault;
        };

        var getTypeScale = function (colum){     
            var matchedColumType = null;
            if(colum==="dataObtaniedRegularizationBe"){
                matchedColumType=1;
            }else if(colum==="dataObtaniedRegularizationKnow"){
                matchedColumType=2;
            }else if(colum==="dataObtaniedRegularizationDo"){
                matchedColumType=3;
            }else if(colum==="dataObtaniedGlobalBe"){
                matchedColumType=1;
            }else if(colum==="dataObtaniedGlobalKnow"){
                matchedColumType=2;
            }else if(colum==="dataObtaniedGlobalDo"){
                matchedColumType=3;
            }
            return matchedColumType;
        };


        var getMaxValueByScale = function (colum){                 
            var result = null;
            var matchedColumType = null;
            if(colum==="dataObtaniedRegularizationBe"){
                matchedColumType=1;
            }else if(colum==="dataObtaniedRegularizationKnow"){
                matchedColumType=2;
            }else if(colum==="dataObtaniedRegularizationDo"){
                matchedColumType=3;
            }else if(colum==="dataObtaniedGlobalBe"){
                matchedColumType=1;
            }else if(colum==="dataObtaniedGlobalKnow"){
                matchedColumType=2;
            }else if(colum==="dataObtaniedGlobalDo"){
                matchedColumType=3;
            }
            var items = $("#scaleEvaluationRatings").jqxDropDownList('getItems');

            for(var i=0; i<items.length; i++){
                if(items[i].originalItem.dataTypeEvaluation===matchedColumType){
                    result = items[i].originalItem.dataMaxValue;
                }
            }
            return result;
        };

        var getMinValueByScale = function (cell){                 
            var result = null;
            var matchedColumType = null;
            if(cell.column==="dataObtaniedRegularizationBe"){
                matchedColumType="dataObtaniedAcumulatedBe";
            }else if(cell.column==="dataObtaniedRegularizationKnow"){
                matchedColumType="dataObtaniedAcumulatedKnow";
            }else if(cell.column==="dataObtaniedRegularizationDo"){
               matchedColumType="dataObtaniedAcumulatedDo";
            }else if(cell.column==="dataObtaniedGlobalBe"){
               matchedColumType="dataObtaniedRegularizationBe";
            }else if(cell.column==="dataObtaniedGlobalKnow"){
               matchedColumType="dataObtaniedRegularizationKnow";
            }else if(cell.column==="dataObtaniedGlobalDo"){
               matchedColumType="dataObtaniedRegularizationDo";
            }
            result = $('#tableSubjectMattersCalifications').jqxGrid('getcellvalue', cell.row, matchedColumType);
            return result;
        };

        var columsDefault = [
            { text: '#', dataField: 'dataProgresivNumber', cellclassname: cellclass, width: 20, cellsrenderer:cellsrenderer, editable: false},
            { text: 'Matrícula',align: 'center', dataField: 'dataEnrollment', width: 120, cellsrenderer:cellsrenderer, cellclassname: cellclass, editable: false },
            { text: 'Alumno', align: 'center', dataField: 'dataNameStudent', cellsrenderer:cellsrenderer, cellclassname: cellclass, editable: false}
        ];

        var columngroupsAcumulated = [
            {text: 'Acumulado', name: 'acumulated', align: 'center'}
        ];
        var columsAcumulated =[
            { text: 'Ser', cellsformat:"f2", columngroup: 'acumulated', dataField: 'dataObtaniedAcumulatedBe', cellsalign: 'center', align: 'center', width: 50, cellclassname: cellclass, cellsrenderer: cellsrenderer, editable: false },
            { 
                text: 'Saber', cellsformat:"f2",  columngroup: 'acumulated', dataField: 'dataObtaniedAcumulatedKnow', cellsalign: 'left', align: 'center', width: 70,  columntype: 'numberinput',
                validation: validation,
                initeditor: initeditor,
                cellbeginedit: cellbeginedit, 
                cellsrenderer: cellsrenderer,
                cellclassname: cellclass
            },
            { 
                text: 'Hacer', cellsformat:"f2",  columngroup: 'acumulated', dataField: 'dataObtaniedAcumulatedDo', cellsalign: 'left', align: 'center', width: 70,  columntype: 'numberinput',
                validation: validation,
                initeditor: initeditor, 
                cellbeginedit: cellbeginedit, 
                cellsrenderer: cellsrenderer,
                cellclassname: cellclass
            },
            { text: 'Total', dataField: 'dataObtaniedAcumulatedTotal', columngroup: 'acumulated', cellsalign: 'center', align: 'center', width: 50, cellsrenderer:cellsrenderer, cellclassname: cellclass, editable: false }
        ];
        var columngroupsRegularization = [
            {text: 'Acumulado', name: 'acumulated', align: 'center'},
            {text: 'Regularización', name: 'regularization', align: 'center'}
        ];

        var columsRegularization =[
            { text: 'Ser', cellsformat:"f2", columngroup: 'acumulated', dataField: 'dataObtaniedAcumulatedBe', cellsalign: 'center', align: 'center', width: 50, cellclassname: cellclass, cellsrenderer: cellsrenderer, editable: false },
            { text: 'Saber', cellsformat:"f2", columngroup: 'acumulated', dataField: 'dataObtaniedAcumulatedKnow', cellsalign: 'center', align: 'center', width: 50, cellclassname: cellclass, cellsrenderer: cellsrenderer, editable: false },
            { text: 'Hacer', cellsformat:"f2", columngroup: 'acumulated', dataField: 'dataObtaniedAcumulatedDo', cellsalign: 'center', align: 'center', width: 50, cellclassname: cellclass, cellsrenderer: cellsrenderer, editable: false }, 
            { text: 'Ser', columngroup: 'rating', dataField: 'dataObtaniedRegularizationBe', cellsalign: 'center', align: 'center', width: 50, cellclassname: cellclass, cellsrenderer: cellsrenderer, editable: false },
            { 
                text: 'Saber', cellsformat:"f2",  columngroup: 'regularization', dataField: 'dataObtaniedRegularizationKnow', cellsalign: 'left', align: 'center', width: 70,  columntype: 'numberinput',
                validation: validation,
                initeditor: initeditor,
                cellbeginedit: cellbeginedit, 
                cellsrenderer: cellsrenderer,
                cellclassname: cellclass
            },
            { 
                text: 'Hacer', cellsformat:"f2",  columngroup: 'regularization', dataField: 'dataObtaniedRegularizationDo', cellsalign: 'left', align: 'center', width: 70,  columntype: 'numberinput',
                validation: validation,
                initeditor: initeditor, 
                cellbeginedit: cellbeginedit, 
                cellsrenderer: cellsrenderer,
                cellclassname: cellclass
            },
            { text: 'Total', dataField: 'dataObtaniedRegularizationTotal', columngroup: 'regularization', cellsalign: 'center', align: 'center', width: 50, cellsrenderer:cellsrenderer, cellclassname: cellclass, editable: false }
        ];
        var columngroupsGlobal = [
            {text: 'Acumulado', name: 'acumulated', align: 'center'},
            {text: 'Regularización', name: 'regularization', align: 'center'},
            {text: 'Global', name: 'global', align: 'center'}
        ];
        var columsGlobal =[
            { text: 'Ser', cellsformat:"f2", columngroup: 'acumulated', dataField: 'dataObtaniedAcumulatedBe', cellsalign: 'center', align: 'center', width: 50, cellclassname: cellclass, cellsrenderer: cellsrenderer, editable: false },
            { text: 'Saber', cellsformat:"f2", columngroup: 'acumulated', dataField: 'dataObtaniedAcumulatedKnow', cellsalign: 'center', align: 'center', width: 50, cellclassname: cellclass, cellsrenderer: cellsrenderer, editable: false },
            { text: 'Hacer', cellsformat:"f2", columngroup: 'acumulated', dataField: 'dataObtaniedAcumulatedDo', cellsalign: 'center', align: 'center', width: 50, cellclassname: cellclass, cellsrenderer: cellsrenderer, editable: false }, 
            { text: 'Ser', columngroup: 'regularization', dataField: 'dataObtaniedRegularizationBe', cellsalign: 'center', align: 'center', width: 50, cellclassname: cellclass, cellsrenderer: cellsrenderer, editable: false },
            { text: 'Saber', columngroup: 'regularization', dataField: 'dataObtaniedRegularizationKnow', cellsalign: 'center', align: 'center', width: 50, cellclassname: cellclass, cellsrenderer: cellsrenderer, editable: false },
            { text: 'Hacer', columngroup: 'regularization', dataField: 'dataObtaniedRegularizationDo', cellsalign: 'center', align: 'center', width: 50, cellclassname: cellclass, cellsrenderer: cellsrenderer, editable: false },
            { text: 'Ser', columngroup: 'rating', dataField: 'dataObtaniedGlobalBe', cellsalign: 'center', align: 'center', width: 50, cellclassname: cellclass, cellsrenderer: cellsrenderer, editable: false },
            { 
                text: 'Saber', cellsformat:"f2",  columngroup: 'global', dataField: 'dataObtaniedGlobalKnow', cellsalign: 'left', align: 'center', width: 70,  columntype: 'numberinput',
                validation: validation,
                initeditor: initeditor,
                cellbeginedit: cellbeginedit, 
                cellsrenderer: cellsrenderer,
                cellclassname: cellclass
            },
            { 
                text: 'Hacer', cellsformat:"f2",  columngroup: 'global', dataField: 'dataObtaniedGlobalDo', cellsalign: 'left', align: 'center', width: 70,  columntype: 'numberinput',
                validation: validation,
                initeditor: initeditor, 
                cellbeginedit: cellbeginedit, 
                cellsrenderer: cellsrenderer,
                cellclassname: cellclass
            },
            { text: 'Total', dataField: 'dataObtaniedGlobalTotal', columngroup: 'global', cellsalign: 'center', align: 'center', width: 50, cellclassname: cellclass, editable: false }
        ];


        var colums = null;
        var columngroups = null;
        itemTypeEvaluation = $('#evaluationTypeRatings').jqxDropDownList('getSelectedItem');
        if(itemTypeEvaluation.value==1){
            colums=prepareColumns(columsAcumulated);
            columngroups= columngroupsAcumulated;
        }else if(itemTypeEvaluation.value==2){
            colums=prepareColumns(columsRegularization);
            columngroups= columngroupsRegularization;
        }else if(itemTypeEvaluation.value==3){
            colums=prepareColumns(columsGlobal);
            columngroups= columngroupsGlobal;
        }else{
            colums=columsDefault;
        }
        $("#tableSubjectMattersCalifications").jqxGrid({
            width: "100%",
            height: "600px",
            selectionMode: "multiplecellsadvanced",
            localization: getLocalization("es"),
            source: dataAdapter,
            pageable: false,
            editable: true,
            filterable: false,
            clipboard: true,
            altRows: true,
            columns: colums,
            columngroups: columngroups,
            ready: function (){
                $('#tableSubjectMattersCalifications').jqxGrid('hidecolumn', 'dataValueObtanied');
            }
        });
        $('#tableSubjectMattersCalifications').jqxGrid('hidecolumn', 'dataValueObtanied');
        $("#tableSubjectMattersCalifications").jqxGrid('focus');
        $("#tableSubjectMattersCalifications").off('cellvaluechanged');
        $("#tableSubjectMattersCalifications").on('cellvaluechanged', function (event) {
            // event arguments.
            var args = event.args;
            // column data field.
            var datafield = event.args.datafield;
            // row's bound index.
            var rowBoundIndex = args.rowindex;
            // new cell value.
            var value = args.newvalue;
            // old cell value.
            var oldvalue = args.oldvalue;

            itemTypeEvaluation = $('#evaluationTypeRatings').jqxDropDownList('getSelectedItem');
            if(getTypeScale(datafield)===1 || getTypeScale(datafield)===2 || getTypeScale(datafield)===3){
                if(itemTypeEvaluation.value===1){  
                    var rowData = $('#tableSubjectMattersCalifications').jqxGrid('getrowdata', rowBoundIndex);
                    var cellBe = $('#tableSubjectMattersCalifications').jqxGrid('getcellvalue', rowBoundIndex, "dataObtaniedAcumulatedBe");
                    var cellKnow = $('#tableSubjectMattersCalifications').jqxGrid('getcellvalue', rowBoundIndex, "dataObtaniedAcumulatedKnow");
                    var cellDo = $('#tableSubjectMattersCalifications').jqxGrid('getcellvalue', rowBoundIndex, "dataObtaniedAcumulatedDo");
                    var total = parseFloat(cellBe)+parseFloat(cellKnow)+parseFloat(cellDo);
                    var total=total.toFixed(2);
                    var params = {
                        "evaluationType" : itemTypeEvaluation.value,
                        "rowID": rowData.id,
                        "value": value,
                        "total" : total,
                        "scaleType" :  getTypeScale(datafield)
                    };
//                    evaluateScaleByRow(params);
                }else if(itemTypeEvaluation.value===2){  
                    var rowData = $('#tableSubjectMattersCalifications').jqxGrid('getrowdata', rowBoundIndex);
                    var cellBe = $('#tableSubjectMattersCalifications').jqxGrid('getcellvalue', rowBoundIndex, "dataObtaniedRegularizationBe");
                    var cellKnow = $('#tableSubjectMattersCalifications').jqxGrid('getcellvalue', rowBoundIndex, "dataObtaniedRegularizationKnow");
                    var cellDo = $('#tableSubjectMattersCalifications').jqxGrid('getcellvalue', rowBoundIndex, "dataObtaniedRegularizationDo");
                    var total = parseFloat(cellBe)+parseFloat(cellKnow)+parseFloat(cellDo);
                    var total=total.toFixed(2);
                    var params = {
                        "evaluationType" : itemTypeEvaluation.value,
                        "rowID": rowData.id,
                        "value": value,
                        "total" : total,
                        "scaleType" :  getTypeScale(datafield)
                    };
//                    evaluateScaleByRow(params);
                }else if(itemTypeEvaluation.value===3){  
                    var rowData = $('#tableSubjectMattersCalifications').jqxGrid('getrowdata', rowBoundIndex); 
                    var cellBe = $('#tableSubjectMattersCalifications').jqxGrid('getcellvalue', rowBoundIndex, "dataObtaniedGlobalBe");
                    var cellKnow = $('#tableSubjectMattersCalifications').jqxGrid('getcellvalue', rowBoundIndex, "dataObtaniedGlobalKnow");
                    var cellDo = $('#tableSubjectMattersCalifications').jqxGrid('getcellvalue', rowBoundIndex, "dataObtaniedGlobalDo");
                    var total = parseFloat(cellBe)+parseFloat(cellKnow)+parseFloat(cellDo);
                    var total=total.toFixed(2);
                    var params = {
                        "evaluationType" : itemTypeEvaluation.value,
                        "rowID": rowData.id,
                        "value": value,
                        "total" : total,
                        "scaleType" :  getTypeScale(datafield)
                    };
                    console.log(cellBe)
                    console.log(cellKnow)
                    console.log(cellDo)
//                    evaluateScaleByRow(params);
                }
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
                <div style="float: left; margin-right: 5px;">
                    Saber<br>
                    <input type="hidden" id="pkWorkPlannig"/>
                    <div id='scaleEvaluationRatings'></div>
                </div>
                <div style="float: left; margin-right: 5px;">
                    <span>Tipo</span><br>
                    <div id='evaluationTypeRatings'></div>
                </div>
                <div style="float: left; margin-right: 5px;">
                    <span>Periodo</span><br>
                    <div id='periodRatings'></div>
                </div>
                <img id="loadingPictureRatings" style="right: 20px; top: 0px; position: absolute;" width="85" src="../content/pictures-system/load.GIF"/>
                
            </form>
        </div>
    </div>
</div>
<div id="subjectMattersRatings">
    <div style="padding-left: 15px;">
        <b>Materias y Calificaciones</b>
    </div>
    <div style=" position: relative;">
        <div style="margin-right: 5px;">
            <div id="tableSubjectMatters"></div>
        </div>
        <br>
        <div style="margin-right: 5px;">
            <div id="tableSubjectMattersCalifications"></div>
        </div>        
    </div>
</div>