<script type="text/javascript">
    $(document).ready(function () {
        var value_max=0;
        var itemLevel = 0;
        var itemCareer = 0;
        var itemPeriod = 0;
        var itemSemester = 0;
        var itemActivity = 0;
        var itemGroup = 0;
        var itemSubjectMatter = 0;
        var itemScaleEvaluation = 0;
        var itemTypeEvaluation = 0;
        var filtrableActivities=[];
        var itemsScaleEvaluation=[];
        var rowExternal;
        var evaluateActivityPopover = $("#evaluateActivityPopover");
        var deleteEvaluatedActivityPopover = $("#deleteEvaluatedActivityPopover");
        var evaluateActivity = $("#evaluateActivity");
        var deleteActivity = $("#deleteActivity");
        evaluateActivityPopover.jqxButton({"height": 20, "width": 20, cursor: "pointer"});
        deleteEvaluatedActivityPopover.jqxButton({"height": 20, "width": 20, cursor: "pointer"});
        evaluateActivity.jqxButton({"height": 30, "width": 60, cursor: "pointer"});
        deleteActivity.jqxButton({ cursor: "pointer", height: 20, width: 20 });
        deleteActivity.jqxTooltip({ position: 'bottom', content: "Eliminar"});
        
        createDropDownStudyLevelByTeacher("#registerCalFlangeLevelFilter",false);
        itemLevel = $('#registerCalFlangeLevelFilter').jqxDropDownList('getSelectedItem');
        if(itemLevel!==undefined && itemCareer!==undefined){
            createDropDownCareerByTeacher( itemLevel.value ,"#registerCalFlangeCareerFilter",false);
            
            
            itemCareer = $('#registerCalFlangeCareerFilter').jqxDropDownList('getSelectedItem');
            createDropDownPeriod("comboActiveYear","#registerCalFlangePeriodFilter");
            itemPeriod = $('#registerCalFlangePeriodFilter').jqxDropDownList('getSelectedItem');
            if(itemPeriod!==undefined){
                createDropDownSemesterByTeacher(itemPeriod.value,itemCareer.value, itemLevel.value,"#registerCalFlangeSemesterFilter",false);
                itemSemester = $('#registerCalFlangeSemesterFilter').jqxDropDownList('getSelectedItem');
                if(itemSemester!==undefined){
                    createDropDownGruopByTeacher(itemCareer.value, itemPeriod.value, itemSemester.value, "#registerCalFlangeGroupFilter", false);
                    itemGroup = $('#registerCalFlangeGroupFilter').jqxDropDownList('getSelectedItem');
                    if(itemGroup!==undefined){
                        createDropDownSubjectMatterByTeacher(itemPeriod.value, itemCareer.value, itemSemester.value, itemGroup.value, "#registerCalFlangeSubjectMatterFilter", false);
                        $("#registerCalFlangeSubjectMatterFilter").jqxDropDownList({width: 300});
                        itemSubjectMatter=$('#registerCalFlangeSubjectMatterFilter').jqxDropDownList('getSelectedItem');
                        initEvaluationType();
                        if(itemSubjectMatter!==undefined){
                            createDropDownScaleEvaluationBloqued("#calTeacherScaleEvaluationFilter", itemPeriod.value, itemSubjectMatter.value, false);
                            itemScaleEvaluation = $('#calTeacherScaleEvaluationFilter').jqxDropDownList('getSelectedItem');
                            if(itemScaleEvaluation!==undefined){    
                                initDropDownActivities(false, undefined);
                            }else{
                                createDropDownActivities("#calTeacherActivitiesFilter", [], false);
                            }
                        }
                    }else{
                        createDropDownSubjectMatterByTeacher(null, null, null, null, "#registerCalFlangeSubjectMatterFilter", false);
                        createDropDownScaleEvaluationBloqued("#calTeacherScaleEvaluationFilter", null, null, false);
                    }   
                }else{
                    createDropDownGruopByTeacher(null, null, null, "#registerCalFlangeGroupFilter",false);
                    createDropDownSubjectMatterByTeacher(null, null, null, null, "#registerCalFlangeSubjectMatterFilter", false);
                    createDropDownScaleEvaluationBloqued("#calTeacherScaleEvaluationFilter", null, null, false);
                }
            }else{
                createDropDownSemesterByTeacher(null,null, null,"#registerCalFlangeSemesterFilter",false);
                createDropDownGruopByTeacher(null, null, null, "#registerCalFlangeGroupFilter",false);
                createDropDownSubjectMatterByTeacher(null, null, null, null, "#registerCalFlangeSubjectMatterFilter", false);
                createDropDownScaleEvaluationBloqued("#calTeacherScaleEvaluationFilter", null, null, false);
            }
            $('#registerCalFlangeLevelFilter').on('change',function (event){  
                itemLevel = $('#registerCalFlangeLevelFilter').jqxDropDownList('getSelectedItem');
                createDropDownCareerByTeacher(itemLevel.value, "#registerCalFlangeCareerFilter", true);
            });
            $('#registerCalFlangeCareerFilter').on('change',function (event){         
                itemPeriod = $('#registerCalFlangePeriodFilter').jqxDropDownList('getSelectedItem');
                itemCareer = $('#registerCalFlangeCareerFilter').jqxDropDownList('getSelectedItem');
                createDropDownSemesterByTeacher(itemPeriod.value,itemCareer.value,itemLevel.value,"#registerCalFlangeSemesterFilter", true);
                itemSemester = $('#registerCalFlangeSemesterFilter').jqxDropDownList('getSelectedItem');
            });
            $("#registerCalFlangeSemesterFilter").on('change',function (){
                itemCareer = $('#registerCalFlangeCareerFilter').jqxDropDownList('getSelectedItem');
                itemPeriod = $('#registerCalFlangePeriodFilter').jqxDropDownList('getSelectedItem');
                itemSemester = $('#registerCalFlangeSemesterFilter').jqxDropDownList('getSelectedItem');
                createDropDownGruopByTeacher(itemCareer.value, itemPeriod.value, itemSemester.value, "#registerCalFlangeGroupFilter", true);
                itemGroup=$('#registerCalFlangeGroupFilter').jqxDropDownList('getSelectedItem');
            });
            $("#registerCalFlangeGroupFilter").on('change',function (){
                itemPeriod = $('#registerCalFlangePeriodFilter').jqxDropDownList('getSelectedItem');
                itemCareer = $('#registerCalFlangeCareerFilter').jqxDropDownList('getSelectedItem');
                itemSemester = $('#registerCalFlangeSemesterFilter').jqxDropDownList('getSelectedItem');
                itemGroup = $('#registerCalFlangeGroupFilter').jqxDropDownList('getSelectedItem');
                createDropDownSubjectMatterByTeacher(itemPeriod.value, itemCareer.value, itemSemester.value, itemGroup.value, "#registerCalFlangeSubjectMatterFilter", true);
                $("#registerCalFlangeSubjectMatterFilter").jqxDropDownList({width: 300});
                itemSubjectMatter=$('#registerCalFlangeSubjectMatterFilter').jqxDropDownList('getSelectedItem');
                var item = $("#registerCalEvaluationType").jqxDropDownList('getItemByValue', 1);
                $("#registerCalEvaluationType").jqxDropDownList('selectItem', item );
            });
            $("#registerCalFlangeSubjectMatterFilter").on('change',function (){
                itemPeriod = $('#registerCalFlangePeriodFilter').jqxDropDownList('getSelectedItem');
                itemSubjectMatter=$('#registerCalFlangeSubjectMatterFilter').jqxDropDownList('getSelectedItem');
                createDropDownScaleEvaluationBloqued("#calTeacherScaleEvaluationFilter", itemPeriod.value, itemSubjectMatter.value, true);
                itemScaleEvaluation = $('#calTeacherScaleEvaluationFilter').jqxDropDownList('getSelectedItem');  
                if(itemScaleEvaluation==undefined){
                    createDropDownActivities("#calTeacherActivitiesFilter", [], true);
                    $('#tableRegisterCalActivities').jqxGrid("clear");
                    $("#evaluateActivityPopover").parent().fadeOut("slow");                     
                }
            });
            
            $("#calTeacherScaleEvaluationFilter").on('change',function (event){
                if(event.args){
                    itemScaleEvaluation = $('#calTeacherScaleEvaluationFilter').jqxDropDownList('getSelectedItem');  
                    if(itemScaleEvaluation!==undefined){
                        initDropDownActivities(true, undefined);
                    }else{
                        createDropDownActivities("#calTeacherActivitiesFilter", [], true);
                        $('#tableRegisterCalActivities').jqxGrid("clear");
                    }
                }
            }); 
            
        }else{
            createDropDownCareerByTeacher(null ,"#registerCalFlangeCareerFilter",false);
            createDropDownPeriod("comboActiveYear","#registerCalFlangePeriodFilter");
            createDropDownSemesterByTeacher(null, null, null,"#registerCalFlangeSemesterFilter",false);
            createDropDownGruopByTeacher(null, null, null, "#registerCalFlangeGroupFilter",false);
            createDropDownSubjectMatterByTeacher(null, null, null, null, "#registerCalFlangeSubjectMatterFilter", false);
            createDropDownScaleEvaluationBloqued("#calTeacherScaleEvaluationFilter", null, null, false);
            createDropDownActivities("#calTeacherActivitiesFilter", [], false);
        }
        function initEvaluationType(){
            itemGroup = $('#registerCalFlangeGroupFilter').jqxDropDownList('getSelectedItem');
            itemPeriod = $('#registerCalFlangePeriodFilter').jqxDropDownList('getSelectedItem');
            itemSubjectMatter=$('#registerCalFlangeSubjectMatterFilter').jqxDropDownList('getSelectedItem');
            var data = {
                "fkGroup":itemGroup.value,
                "fkMatter":itemSubjectMatter.value,
                "fkPeriod":itemPeriod.value
            };            
            createDropDownEvaluationType("#registerCalEvaluationType", data);
            $("#registerCalEvaluationType").off("change");
            $("#registerCalEvaluationType").on('change',function (event){ 
                var args = event.args;
                if (args) {
                    itemTypeEvaluation = $('#registerCalEvaluationType').jqxDropDownList('getSelectedItem');                    
                    if(itemTypeEvaluation.value==1){
                        $("#calTeacherScaleEvaluationFilter").parent().show();
                        $("#contentCalTeacherActivitiesFilter").parent().show();                        
                    }else{
                        $("#calTeacherScaleEvaluationFilter").parent().hide();
                        $("#contentCalTeacherActivitiesFilter").parent().hide();                        
                    }                    
                    itemActivity = $('#calTeacherActivitiesFilter').jqxDropDownList('getSelectedItem');
                    if(itemActivity!==undefined && itemActivity!==null){
                        $('#tableRegisterCalActivities').fadeIn("slow");
                        maxValActivity();
                        loadTable();
                    }else{
                        $('#tableRegisterCalActivities').hide();
                    }
                }
            }); 
        }
        $("#popoverOptionDeleteEvaluated").jqxPopover({
            offset: {left: -80, top:0}, 
            arrowOffsetValue: 80, 
            title: "Eliminar actividad!", 
            showCloseButton: true,
            selector: deleteEvaluatedActivityPopover,
            width: 250
        });
        $("#popoverOptionEvaluate").jqxPopover({
            offset: {left: -50, top:0}, 
            arrowOffsetValue: 50, 
            title: "Evaluar actividad", 
            showCloseButton: true,
            selector: evaluateActivityPopover,
            width: 180
        });
        if(typeof (Storage) !=="undefined"){
            if(localStorage.getItem("wayScaleEvaluation")==="typeMin"){                                
                $("#typeMin").prop("checked", true);
            }else{
                $("#typeMax").prop("checked", true);
            }
        }else{
            $("#wayScaleEvaluation").prop("checked", true);
        }
        $("[name=wayScaleEvaluation]").off("change");
        $("[name=wayScaleEvaluation]").change(function (){
            if($(this).attr("id")==="typeMin"){
                localStorage.setItem("wayScaleEvaluation", "typeMin"); 
            }else{
                localStorage.setItem("wayScaleEvaluation", "typeMax");
            }
        });
        $("#deleteEvaluatedActivityPopover").click(function(){
            $('#tableRegisterCalActivities').jqxGrid('clearselection'); 
        });
        evaluateActivity.click(function (){
            var disabled = $(this).jqxButton('disabled');            
            if(!disabled){
                evaluateActivity.jqxButton({disabled: true });
                var valItemCareer=0;
                var valItemSemester=0;
                var valItemPeriod=0;
                var valItemGroup=0;
                var valItemSubjectMatter=0;
                var valItemActivity=0;
                itemCareer = $('#registerCalFlangeCareerFilter').jqxDropDownList('getSelectedItem');
                itemSemester = $('#registerCalFlangeSemesterFilter').jqxDropDownList('getSelectedItem');
                itemPeriod = $('#registerCalFlangePeriodFilter').jqxDropDownList('getSelectedItem');
                itemGroup = $('#registerCalFlangeGroupFilter').jqxDropDownList('getSelectedItem');
                itemSubjectMatter=$('#registerCalFlangeSubjectMatterFilter').jqxDropDownList('getSelectedItem');
                itemActivity = $('#calTeacherActivitiesFilter').jqxDropDownList('getSelectedItem');
                var indexActivity = itemActivity.index;
                if(itemCareer!==undefined){
                    valItemCareer=itemCareer.value;
                }
                if(itemSemester!==undefined){
                    valItemSemester=itemSemester.value;
                }
                if(itemPeriod!==undefined){
                    valItemPeriod=itemPeriod.value;
                }
                if(itemGroup!==undefined){
                    valItemGroup=itemGroup.value;
                }
                if(itemSubjectMatter!==undefined){
                    valItemSubjectMatter=itemSubjectMatter.value;
                }
                if(itemActivity!==undefined){
                    valItemActivity=itemActivity.value;
                    $('#tableRegisterCalActivities').fadeIn("slow");
                }else{
                    $('#tableRegisterCalActivities').hide();
                }
                $.ajax({
                    //Send the paramethers to servelt
                    type: "POST",
                    async: true,
                    url: "../serviceActivitiesCalByStudents",
                    data:{
                        "insert":"",
                        "wayScaleEvaluation": $("[name=wayScaleEvaluation]:checked").val(),
                        "pkCareer": valItemCareer, 
                        "pkSemester": valItemSemester, 
                        "pkGroup": valItemGroup, 
                        "pkMatter": valItemSubjectMatter, 
                        "pkActivity": valItemActivity, 
                        "pkPeriod": valItemPeriod
                    },
                    beforeSend: function (xhr) {
                        $("#loadEvaluating").show();
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        //This is if exits an error with the server internal can do server off, or page not found
                        alert("Error interno del servidor");
                        evaluateActivity.jqxButton({disabled: true });
                    },
                    success: function (data, textStatus, jqXHR) {
                        $("#popoverOptionEvaluate").jqxPopover("close");
                        initDropDownActivities(true, indexActivity);
                        $("#loadEvaluating").hide();
                        evaluateActivity.jqxButton({disabled: false });
                    }
                }); 
            }
        });
        deleteActivity.click(function (){            
            var disabled = $(this).jqxButton('disabled');            
            if(!disabled){
                deleteActivity.jqxButton({disabled: true });
                var valItemPeriod=0;
                var valItemGroup=0;
                var valItemActivity=0;
                itemPeriod = $('#registerCalFlangePeriodFilter').jqxDropDownList('getSelectedItem');
                itemGroup = $('#registerCalFlangeGroupFilter').jqxDropDownList('getSelectedItem');
                itemActivity = $('#calTeacherActivitiesFilter').jqxDropDownList('getSelectedItem');
                var indexActivity = itemActivity.index;
                if(itemPeriod!==undefined){
                    valItemPeriod=itemPeriod.value;
                }
                if(itemGroup!==undefined){
                    valItemGroup=itemGroup.value;
                }
                if(itemActivity!==undefined){
                    valItemActivity=itemActivity.value;
                    $('#tableRegisterCalActivities').fadeIn("slow");
                }else{
                    $('#tableRegisterCalActivities').hide();
                }
                $.ajax({
                    //Send the paramethers to servelt
                    type: "POST",
                    async: true,
                    url: "../serviceActivitiesCalByStudents",
                    data:{
                        "delete":"",
                        "pkGroup": valItemGroup, 
                        "pkActivity": valItemActivity, 
                        "pkPeriod": valItemPeriod
                    },
                    beforeSend: function (xhr) {
                        $("#loadDeleting").show();
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        //This is if exits an error with the server internal can do server off, or page not found
                        alert("Error interno del servidor");
                        deleteActivity.jqxButton({disabled: true });
                    },
                    success: function (data, textStatus, jqXHR) {                        
                        $("#popoverOptionDeleteEvaluated").jqxPopover("close");
                        initDropDownActivities(true, indexActivity);
                        $("#loadDeleting").hide();
                        deleteActivity.jqxButton({disabled: false });
                    }
                }); 
            }
        });
        function isClosedWorkPlanning(){
            itemSubjectMatter= $('#registerCalFlangeSubjectMatterFilter').jqxDropDownList('getSelectedItem'); 
            itemGroup = $('#registerCalFlangeGroupFilter').jqxDropDownList('getSelectedItem');
            itemPeriod = $('#registerCalFlangePeriodFilter').jqxDropDownList('getSelectedItem');
            itemTypeEvaluation = $('#registerCalEvaluationType').jqxDropDownList('getSelectedItem');
            var status=0;
            $.ajax({
                url: "../serviceCalification?isCloseWorkPlanning",
                data: {"fkType": itemTypeEvaluation.value, "fkMatter": itemSubjectMatter.value,"fkGroup": itemGroup.value,"fkPeriod": itemPeriod.value},
                type: 'POST',
                async: false,
                beforeSend: function (xhr) {
                },
                success: function (data, textStatus, jqXHR) {
                    var items = data[0].items;
                    for(var i=0; i<items.length; i++){
                        var item = $("#registerCalEvaluationType").jqxDropDownList('getItemByValue', items[i].valueMember);
                        if(items[i].status==="-1"){
                            $("#registerCalEvaluationType").jqxDropDownList('disableItem', item ); 
                        }else{
                            $("#registerCalEvaluationType").jqxDropDownList('enableItem', item ); 
                        }        
                    }                    
                    status=parseInt(data[0].closed);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert("Error interno del servidor");                
                }
            });
            return status;
        }
        function resizeGrid(){    
            var p = $("#registerCalEvaluationType");
            var position = p.position();
            var height = $("#averageTab").parent().parent().height();
            var finalHeight = (height-position.top)-20;
            $("#tableRegisterCalActivities").jqxGrid({
                height: finalHeight +"px"
            });
        }
        $('#jqxSplitter').on('resize', function (event) {       
            resizeGrid();
        });
        $(window).on('resize', function (event) {       
            resizeGrid();
        });
        
        function loadSource(){
            var valItemCareer=0;
            var valItemSemester=0;
            var valItemPeriod=0;
            var valItemGroup=0;
            var valItemActivity=0;
            itemCareer = $('#registerCalFlangeCareerFilter').jqxDropDownList('getSelectedItem');
            itemSemester = $('#registerCalFlangeSemesterFilter').jqxDropDownList('getSelectedItem');
            itemPeriod = $('#registerCalFlangePeriodFilter').jqxDropDownList('getSelectedItem');
            itemGroup = $('#registerCalFlangeGroupFilter').jqxDropDownList('getSelectedItem');
            itemSubjectMatter=$('#registerCalFlangeSubjectMatterFilter').jqxDropDownList('getSelectedItem');
            itemActivity = $('#calTeacherActivitiesFilter').jqxDropDownList('getSelectedItem');
            itemTypeEvaluation = $('#registerCalEvaluationType').jqxDropDownList('getSelectedItem');
            if(itemCareer!==undefined){
                valItemCareer=itemCareer.value;
            }
            if(itemSemester!==undefined){
                valItemSemester=itemSemester.value;
            }
            if(itemPeriod!==undefined){
                valItemPeriod=itemPeriod.value;
            }
            if(itemGroup!==undefined){
                valItemGroup=itemGroup.value;
            }
            if(itemActivity!==undefined && itemActivity!==null){
                valItemActivity=itemActivity.value;
                $('#tableRegisterCalActivities').fadeIn("slow");
            }else{
                $('#tableRegisterCalActivities').hide();
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
                    { name: 'dataObtaniedGlobalTotal', type: 'double' }
                ],
                root: "__ENTITIES",
                type:"POST",
                dataType: "json",
                id: 'id',
                async: false,
                data :{
                    view: itemTypeEvaluation.value,
                    pkCareer : valItemCareer,
                    pkSemester : valItemSemester,
                    pkActivity : valItemActivity,
                    pkGroup : valItemGroup,
                    pkMatter : itemSubjectMatter.value,
                    pkPeriod :valItemPeriod                    
                },
                url: '../serviceActivitiesCalByStudents'
            };
            return ordersSource;
        }
        function loadSourceActivities(scaleEvaluation, pkStudent){
            var ordersSource=[];
            var valItemSubjectMatter=0;
            itemSubjectMatter=$('#registerCalFlangeSubjectMatterFilter').jqxDropDownList('getSelectedItem');
            if(itemSubjectMatter!==undefined){
                valItemSubjectMatter=itemSubjectMatter.value;
            }
            $.ajax({
                type:"POST",
                dataType: "json",
                async: false,
                url: "../serviceActivitiesCalByStudents?listActivitiesByPkStudent",
                data: {"pkMatter": valItemSubjectMatter, "pkScale": scaleEvaluation, "pkStudent": pkStudent},
                success: function (data, textStatus, jqXHR) {
                    ordersSource=data;
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert("Error interno en el servidor");
                }
            });
            return ordersSource;
        }
        function loadEventRowclick(){
            var varIsClosed = isClosedWorkPlanning();
            if(varIsClosed!=1){
                $('#tableRegisterCalActivities').off('rowclick');
                $('#tableRegisterCalActivities').off('rowselect');
                $('#tableRegisterCalActivities').on('rowclick', function (event){
                    // event args.                 
                    if (event.args.rightclick) {
                        $("#tableRegisterCalActivities").jqxGrid('selectrow', event.args.rowindex);
                        var scrollTop = $(window).scrollTop();
                        var scrollLeft = $(window).scrollLeft();
                        contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                        return false;
                    }                    
                });                
                $('#tableRegisterCalActivities').on('rowselect', function (event){
                    // row data.
                    var args = event.args;
                    var row = $('#tableRegisterCalActivities').jqxGrid('getrowdata', args.rowindex);//args.row;
                    rowExternal = row;
                });
            }else{
                $('#tableRegisterCalActivities').off('rowclick');
            }
            return varIsClosed;
        }
        function evaluateActivityByRow(param){
            var rowData = $('#tableRegisterCalActivities').jqxGrid('getrowdata', param.row);
            var dataValueObtaniedOld= $('#tableRegisterCalActivities').jqxGrid('getcellvaluebyid', rowData.id, "dataValueObtanied");
            var dataAcomulatedNow = $('#tableRegisterCalActivities').jqxGrid('getcellvaluebyid', rowData.id, "dataAcomulatedNow");      
            dataAcomulatedNow=parseFloat(dataAcomulatedNow);
            var value = parseFloat(param.value);                    
            var equivalent =parseFloat(value*10/value_max).toFixed(2);
            var total=parseFloat(value-dataValueObtaniedOld+dataAcomulatedNow).toFixed(2);
            if(equivalent==="10.00"){
                equivalent=10;
            }
            if(equivalent==="0.00"){
                equivalent=0;
            }
            if(isNaN(total)){
                total=value_max;
            }
            var data = {
                "update": param.evaluationType,
                "pkActivityByStudent": rowData.id, 
                "valueOptanied": value,
                "valueOptaniedEquivalent": equivalent
            };
            if(rowData.dataEnrollment===rowData.id){
                itemCareer = $('#registerCalFlangeCareerFilter').jqxDropDownList('getSelectedItem');
                itemSemester = $('#registerCalFlangeSemesterFilter').jqxDropDownList('getSelectedItem');
                itemPeriod = $('#registerCalFlangePeriodFilter').jqxDropDownList('getSelectedItem');
                itemGroup = $('#registerCalFlangeGroupFilter').jqxDropDownList('getSelectedItem');
                itemSubjectMatter=$('#registerCalFlangeSubjectMatterFilter').jqxDropDownList('getSelectedItem');
                itemActivity = $('#calTeacherActivitiesFilter').jqxDropDownList('getSelectedItem');
                data = {
                    "insertByStudent":"",
                    "pkStudent": rowData.dataPkStudent, 
                    "valueOptanied": value,
                    "valueOptaniedEquivalent": equivalent,
                    "pkCareer": itemCareer.value,
                    "pkSemester": itemSemester.value,
                    "pkGroup": itemGroup.value,
                    "pkMatter": itemSubjectMatter.value,
                    "pkActivity": itemActivity.value,
                    "pkPeriod": itemPeriod.value
                };
            }else{
                data = {
                    "update":param.evaluationType,
                    "pkActivityByStudent": rowData.id, 
                    "valueOptanied": value,
                    "valueOptaniedEquivalent": equivalent
                };
            }
            $.ajax({
                //Send the paramethers to servelt
                type: "POST",
                async: false,
                url: "../serviceActivitiesCalByStudents",
                data: data,
                beforeSend: function (xhr) {
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    //This is if exits an error with the server internal can do server off, or page not found
                    alert("Error interno del servidor");
                },
                success: function (data, textStatus, jqXHR) {  
                    $("#tableRegisterCalActivities").jqxGrid('setcellvaluebyid', rowData.id, "dataAcomulatedNow", total);
                    $("#tableRegisterCalActivities").jqxGrid('setcellvaluebyid', rowData.id, "dataValueObtanied", value);
                    $("#tableRegisterCalActivities").jqxGrid('setcellvaluebyid', rowData.id, "dataValueObtaniedEquivalent", equivalent);
                }
            });
        }
        
        function evaluateScaleByRow(params){   
            var value = parseFloat(params.value);   
            var total=parseFloat(params.total);            
            var data = {
                "update": params.evaluationType,
                "pkCalificationByStudent": params.rowID, 
                "valueOptanied": value,
                "scaleType" : params.scaleType
            };
            $.ajax({
                //Send the paramethers to servelt
                type: "POST",
                async: false,
                url: "../serviceActivitiesCalByStudents",
                data: data,
                beforeSend: function (xhr) {
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    //This is if exits an error with the server internal can do server off, or page not found
                    alert("Error interno del servidor");
                },
                success: function (data, textStatus, jqXHR) {  
                    if(params.editor){
                        $(params.editor).attr("data-lastValue", value);
                    }                    
                    if(params.evaluationType===2){
                        $("#tableRegisterCalActivities").jqxGrid('setcellvaluebyid', params.rowID, "dataObtaniedRegularizationTotal", total);
                    }else{
                        $("#tableRegisterCalActivities").jqxGrid('setcellvaluebyid', params.rowID, "dataObtaniedGlobalTotal", total);
                    }                    
                }
            });
        }
        
        function loadActivities(type_eval, pkStudent){
            var valItemsScaleEvaluation=[];
            var ordersSource=[];
            itemsScaleEvaluation = $("#calTeacherScaleEvaluationFilter").jqxDropDownList('getItems');
            itemSubjectMatter=$('#registerCalFlangeSubjectMatterFilter').jqxDropDownList('getSelectedItem');
            if(itemsScaleEvaluation!==undefined){
                var table="";
                var thead="";
                var tbody="";
                var tfoot="";
                var trOnTbody="";
                valItemsScaleEvaluation=itemsScaleEvaluation;
                $(".tablesActivities"+type_eval).fadeOut();
                $(".tablesActivities"+type_eval).html("");      
                for(var it=0; it<itemsScaleEvaluation.length; it++){
                    table=$('<table class="table-utsem table-striped table-hover" border="1"></table>');
                    thead=$('<thead><tr><th align="left" colspan="5">'+valItemsScaleEvaluation[it].label+'</th></tr><tr><th align="center" width="85%" rowspan="2">Actividad</th><th align="center" colspan="2">Valor</th><th align="center" colspan="2">Calificación</th></tr><tr><th align="center" title="Real">#</th><th align="center" title="Porcentaje">%</th><th align="center" title="Real">R</th><th align="center" title="Equivalente">E</th></tr></thead>');
                    tbody=$('<tbody></tbody>');
                    ordersSource=loadSourceActivities(valItemsScaleEvaluation[it].value, pkStudent);
                    var subtotalScale=0;
                    var subtotalScaleObtanied=0;
                    var anyActivity=0;
                    var totalPercent=0;
                    var totalEquivalent="N/A";
                    for(var ia=0; ia<ordersSource.items.length; ia++){
                        anyActivity=anyActivity+1;
                        
                        //totalEquivalent=totalEquivalent+ordersSource.items[ia].dataValueObtaniedEquivalent;
                        if(ordersSource.items[ia].dataNameActivity==="Subtotal"){
                            totalPercent=totalPercent+((ordersSource.items[ia].dataValueActivity*100)/ordersSource.items[ia].dataMaxValueScale);
                            tfoot=$('<tfoot><tr><th align="right">Subtotal</th><th align="center" class="subtotalValueActivity">'+ordersSource.items[ia].dataValueActivity+'</th><th align="center">'+totalPercent+'%</th><th align="center" class="subtotalValueObtanied">'+ordersSource.items[ia].dataValueObtanied+'</th><th align="center">'+totalEquivalent+'</th></tr></tfoot>');
                        }else{
                            var dataValueObtaniedEquivalent = parseFloat(ordersSource.items[ia].dataValueObtaniedEquivalent).toFixed(1);
                            trOnTbody=$('<tr><td>'+ordersSource.items[ia].dataNameActivity+'</td><td align="center">'+ordersSource.items[ia].dataValueActivity+'</td><td align="center">'+parseFloat((ordersSource.items[ia].dataValueActivity*100)/ordersSource.items[ia].dataMaxValueScale).toFixed(2)+'%</td><td align="center">'+ordersSource.items[ia].dataValueObtanied+'</td><td align="center">'+dataValueObtaniedEquivalent+'</td></tr>');
                            trOnTbody.appendTo(tbody); 
                            subtotalScale=subtotalScale+parseFloat(ordersSource.items[ia].dataValueActivity);
                            subtotalScaleObtanied=subtotalScaleObtanied+parseFloat(ordersSource.items[ia].dataValueObtanied);
                        }
                    }                    
                    var equivalent=(subtotalScaleObtanied*10/subtotalScale).toFixed(2);
                    if(isNaN(subtotalScale)){
                        subtotalScale=0;
                    }
                    if(isNaN(subtotalScaleObtanied)){
                        subtotalScaleObtanied=0;
                    }
                    if(isNaN(subtotalScaleObtanied)){
                        subtotalScaleObtanied=0;
                    }
                    if(isNaN(equivalent)){
                        equivalent=0;
                    }
                    
                    if(anyActivity===0){
                        trOnTbody=$('<tr><td colspan="5">Este saber no cuenta con actividades evaluadas</td></tr>');
                        trOnTbody.appendTo(tbody); 
                    }else{
                        table.append(tfoot);
                        anyActivity=0;
                    }
                    
                    table.append(thead);
                    table.append(tbody);
                    
                    $(".tablesActivities"+type_eval).append(table);
                }
                $(".tablesActivities"+type_eval).fadeIn();
            }
        }
        var status;
        function loadTable(){
            var length =0 ;
            var dataAdapter = new $.jqx.dataAdapter(loadSource(),{
                loadComplete: function () {
                    length = dataAdapter.records.length;
                }
            });
            $("#tableRegisterCalActivities").off('cellselect');
            $("#tableRegisterCalActivities").on('cellselect', function (event) {
                var rowBoundIndex = event.args.rowindex;
                $("#contenttabletableRegisterCalActivities").each(function (){
                    $(this).children().children().css({
                        "text-decoration":"none"
                    });
                });
                var colorUnderline = $("#row"+rowBoundIndex+"tableRegisterCalActivities").children().children().css("color");
                $("#row"+rowBoundIndex+"tableRegisterCalActivities").children().css({
                    "text-decoration":"underline",
                    "text-decoration-color":colorUnderline||"#000"
                });
            });
            
            
            status = loadEventRowclick();   
            var activityEvaluated = anyActivityEvaluated();
            var initeditor = function (row, cellvalue, editor) {  
                itemTypeEvaluation = $('#registerCalEvaluationType').jqxDropDownList('getSelectedItem');
                var cell = $('#tableRegisterCalActivities').jqxGrid('getselectedcell');                 
                if(itemTypeEvaluation.value===1){
                    editor.jqxNumberInput({ 
                        inputMode: 'simple', 
                        spinButtons: true,
                        digits:1,
                        min:0,
                        max: value_max
                    });                    
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
                            var params = {
                                "evaluationType" : itemTypeEvaluation.value,
                                "row": row,
                                "value": $(this).val(),
                                "oldvalue" : cellvalue
                            };
                            evaluateActivityByRow(params);
                        }else if(itemTypeEvaluation.value===2){  
                            var rowData = $('#tableRegisterCalActivities').jqxGrid('getrowdata', row);
                            var cellBe = null;
                            var cellKnow = null;
                            var cellDo = null;
                            
                            if(cell.datafield==="dataObtaniedRegularizationBe"){
                                cellBe = $(this).val();
                                cellKnow = $('#tableRegisterCalActivities').jqxGrid('getcelltext', row, "dataObtaniedRegularizationKnow");
                                cellDo = $('#tableRegisterCalActivities').jqxGrid('getcelltext', row, "dataObtaniedRegularizationDo");
                            }
                            if(cell.datafield==="dataObtaniedRegularizationKnow"){
                                cellBe = $('#tableRegisterCalActivities').jqxGrid('getcelltext', row, "dataObtaniedRegularizationBe");
                                cellKnow = $(this).val();
                                cellDo = $('#tableRegisterCalActivities').jqxGrid('getcelltext', row, "dataObtaniedRegularizationDo");
                            }
                            if(cell.datafield==="dataObtaniedRegularizationDo"){
                                cellBe = $('#tableRegisterCalActivities').jqxGrid('getcelltext', row, "dataObtaniedRegularizationBe");
                                cellKnow = $('#tableRegisterCalActivities').jqxGrid('getcelltext', row, "dataObtaniedRegularizationKnow");
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
                            var rowData = $('#tableRegisterCalActivities').jqxGrid('getrowdata', row); 
                            var cellBe = null;
                            var cellKnow = null;
                            var cellDo = null;
                            
                            if(cell.datafield==="dataObtaniedGlobalBe"){
                                cellBe = $(this).val();
                                cellKnow = $('#tableRegisterCalActivities').jqxGrid('getcelltext', row, "dataObtaniedGlobalKnow");
                                cellDo = $('#tableRegisterCalActivities').jqxGrid('getcelltext', row, "dataObtaniedGlobalDo");
                            }
                            if(cell.datafield==="dataObtaniedGlobalKnow"){
                                cellBe = $('#tableRegisterCalActivities').jqxGrid('getcelltext', row, "dataObtaniedGlobalBe");
                                cellKnow = $(this).val();
                                cellDo = $('#tableRegisterCalActivities').jqxGrid('getcelltext', row, "dataObtaniedGlobalDo");
                            }
                            if(cell.datafield==="dataObtaniedGlobalDo"){
                                cellBe = $('#tableRegisterCalActivities').jqxGrid('getcelltext', row, "dataObtaniedGlobalBe");
                                cellKnow = $('#tableRegisterCalActivities').jqxGrid('getcelltext', row, "dataObtaniedGlobalKnow");
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
                itemTypeEvaluation = $('#registerCalEvaluationType').jqxDropDownList('getSelectedItem');
                if(itemTypeEvaluation.value===1){
                    if (value > value_max) {
                        return { result: false, message: "Calificación máxima "+value_max};
                    }
                    if (value < 0) {
                        return { result: false, message: "Calificación minima 0"};
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
                itemTypeEvaluation = $('#registerCalEvaluationType').jqxDropDownList('getSelectedItem');          
                if(itemTypeEvaluation.value===1){                    
                    if(status==1){
                        var data = $('#tableRegisterCalActivities').jqxGrid('getrowdata', row);
                        if(data.dataAcomulatedNow>=8){
                            classTheme=classTheme+"disabled";
                        }else{
                            classTheme=classTheme+"not-approved";
                        }                    
                    }else{
                        if(activityEvaluated>=1){
                        }else{      
                            classTheme=classTheme+"disabled";
                        }
                    }
                }else if(itemTypeEvaluation.value===2){ 
                    if(status==1){
                        var data = $('#tableRegisterCalActivities').jqxGrid('getrowdata', row);
                        if(data.dataObtaniedRegularizationTotal>=8){
                            classTheme=classTheme+"disabled";
                        }else{
                            classTheme=classTheme+"not-approved";
                        }                    
                    }else{
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
                        
                    }
                }else if(itemTypeEvaluation.value===3){ 
                    if(status==1){
                        var data = $('#tableRegisterCalActivities').jqxGrid('getrowdata', row);
                        if(data.dataObtaniedGlobalTotal>=8){
                            classTheme=classTheme+"disabled";
                        }else{
                            classTheme=classTheme+"not-approved";
                        }                    
                    }else{
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
                        }
                    }
                }
                return classTheme;
            };
            var cellbeginedit = function (row, datafield, columntype, value) {
                itemTypeEvaluation = $('#registerCalEvaluationType').jqxDropDownList('getSelectedItem');          
                if(itemTypeEvaluation.value===1){
                    if(status==1){
                        return false;
                    }
                    if(activityEvaluated>=1){
                        return true;
                    }else{    
                        $("#popoverOptionEvaluate").jqxPopover("open");
                        return false;
                    }
                }
            };
            var cellsrenderer = function (row, column, value, defaultHtml) {
                itemTypeEvaluation = $('#registerCalEvaluationType').jqxDropDownList('getSelectedItem');  
                var data = $('#tableRegisterCalActivities').jqxGrid('getrowdata', row);
                var element = $(defaultHtml);
                if(itemTypeEvaluation.value===1){
                    if(column==="dataValueObtaniedEquivalent"){
                        if (value<8) {                                                        
                            element.css('color', '#656565');
                            if(data.dataAcomulatedNow>="8"){
                                if(status==1){
                                    element.css('color', '#656565 !important');
                                }else{
                                    element.css('color', 'red');
                                }
                            }else{
                                if(status==1){
                                    element.css('color', '#656565 !important');
                                }else{
                                    element.css('color', 'red');
                                }
                            }  
                            return element[0].outerHTML;
                        }
                    }else if(column!=="dataProgresivNumber"){
                        if ((value*10/value_max)<8) {
                            var element = $(defaultHtml);
                            if(status==1){
                                element.css('color', '#656565');
                            }else{
                                element.css('color', 'red');
                            }
                            return element[0].outerHTML;
                        }
                    }
                }else if(itemTypeEvaluation.value===2){
                    if(data.dataObtaniedRegularizationTotal<"8"){
                        if(status==1){
                            element.css('color', '#656565 !important');
                        }else{
                            
                            element.css('color', '#F70025 !important');
                        }
                        return element[0].outerHTML;
                    }
                }else if(itemTypeEvaluation.value===3){
                    if(data.dataObtaniedGlobalTotal<"8"){
                        if(status==1){
                            element.css('color', '#656565 !important');
                        }else{
                            
                            element.css('color', '#F70025 !important');
                        }
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
                var items = $("#calTeacherScaleEvaluationFilter").jqxDropDownList('getItems');
            
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
                result = $('#tableRegisterCalActivities').jqxGrid('getcellvalue', cell.row, matchedColumType);
                return result;
            };
            
            var columsDefault = [
                { text: '#', dataField: 'dataProgresivNumber', cellclassname: cellclass, width: 20, cellsrenderer:cellsrenderer, editable: false},
                { text: 'Matrícula',align: 'center', dataField: 'dataEnrollment', width: 120, cellsrenderer:cellsrenderer, cellclassname: cellclass, editable: false },
                { text: 'Alumno', align: 'center', dataField: 'dataNameStudent', cellsrenderer:cellsrenderer, cellclassname: cellclass, editable: false}
            ];
            
            var columngroupsAcumulated = [
                {text: 'Acumulado', name: 'rating', align: 'center'}
            ];
            var columsAcumulated =[
                { text: 'R', hidecolumn : true, columngroup: 'rating', dataField: 'dataValueObtanied', cellsalign: 'center', align: 'center', width: 100, cellclassname: cellclass, cellsrenderer: cellsrenderer, editable: false },
                { text: 'Equivalente', clipboard: false, cellsformat:"f2", columngroup: 'rating', dataField: 'dataValueObtaniedEquivalent', cellsalign: 'center', align: 'center', width: 100, cellclassname: cellclass, cellsrenderer: cellsrenderer, editable: false },
                { 
                    text: 'Obtenido', cellsformat:"f2",  columngroup: 'rating', dataField: 'dataValueObtaniedNew', cellsalign: 'left', align: 'center', width: 80,  columntype: 'numberinput',
                    validation: validation,
                    initeditor: initeditor, 
                    cellbeginedit: cellbeginedit, 
                    cellsrenderer: cellsrenderer,
                    cellclassname: cellclass
                },
                { text: 'Total', dataField: 'dataAcomulatedNow', columngroup: 'rating', cellsalign: 'center', align: 'center', width: 50, cellclassname: cellclass, editable: false }
            ];
            var columngroupsRegularization = [
                {text: 'Acumulado', name: 'acumulated', align: 'center'},
                {text: 'Regularización', name: 'rating', align: 'center'}
            ];
            
            var columsRegularization =[
                { text: 'Ser', cellsformat:"f2", columngroup: 'acumulated', dataField: 'dataObtaniedAcumulatedBe', cellsalign: 'center', align: 'center', width: 50, cellclassname: cellclass, cellsrenderer: cellsrenderer, editable: false },
                { text: 'Saber', cellsformat:"f2", columngroup: 'acumulated', dataField: 'dataObtaniedAcumulatedKnow', cellsalign: 'center', align: 'center', width: 50, cellclassname: cellclass, cellsrenderer: cellsrenderer, editable: false },
                { text: 'Hacer', cellsformat:"f2", columngroup: 'acumulated', dataField: 'dataObtaniedAcumulatedDo', cellsalign: 'center', align: 'center', width: 50, cellclassname: cellclass, cellsrenderer: cellsrenderer, editable: false }, 
                { text: 'Ser', columngroup: 'rating', dataField: 'dataObtaniedRegularizationBe', cellsalign: 'center', align: 'center', width: 50, cellclassname: cellclass, cellsrenderer: cellsrenderer, editable: false },
                { 
                    text: 'Saber', cellsformat:"f2",  columngroup: 'rating', dataField: 'dataObtaniedRegularizationKnow', cellsalign: 'left', align: 'center', width: 50,  columntype: 'numberinput',
                    validation: validation,
                    initeditor: initeditor,
                    cellbeginedit: cellbeginedit, 
                    cellsrenderer: cellsrenderer,
                    cellclassname: cellclass
                },
                { 
                    text: 'Hacer', cellsformat:"f2",  columngroup: 'rating', dataField: 'dataObtaniedRegularizationDo', cellsalign: 'left', align: 'center', width: 50,  columntype: 'numberinput',
                    validation: validation,
                    initeditor: initeditor, 
                    cellbeginedit: cellbeginedit, 
                    cellsrenderer: cellsrenderer,
                    cellclassname: cellclass
                },
                { text: 'Total', dataField: 'dataObtaniedRegularizationTotal', columngroup: 'rating', cellsalign: 'center', align: 'center', width: 50, cellsrenderer:cellsrenderer, cellclassname: cellclass, editable: false }
            ];
            var columngroupsGlobal = [
                {text: 'Acumulado', name: 'acumulated', align: 'center'},
                {text: 'Regularización', name: 'regularization', align: 'center'},
                {text: 'Global', name: 'rating', align: 'center'}
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
                    text: 'Saber', cellsformat:"f2",  columngroup: 'rating', dataField: 'dataObtaniedGlobalKnow', cellsalign: 'left', align: 'center', width: 50,  columntype: 'numberinput',
                    validation: validation,
                    initeditor: initeditor,
                    cellbeginedit: cellbeginedit, 
                    cellsrenderer: cellsrenderer,
                    cellclassname: cellclass
                },
                { 
                    text: 'Hacer', cellsformat:"f2",  columngroup: 'rating', dataField: 'dataObtaniedGlobalDo', cellsalign: 'left', align: 'center', width: 50,  columntype: 'numberinput',
                    validation: validation,
                    initeditor: initeditor, 
                    cellbeginedit: cellbeginedit, 
                    cellsrenderer: cellsrenderer,
                    cellclassname: cellclass
                },
                { text: 'Total', dataField: 'dataObtaniedGlobalTotal', columngroup: 'rating', cellsalign: 'center', align: 'center', width: 50, cellclassname: cellclass, editable: false }
            ];
            
            
            var colums = null;
            var columngroups = null;
            itemTypeEvaluation = $('#registerCalEvaluationType').jqxDropDownList('getSelectedItem');
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
            $("#tableRegisterCalActivities").jqxGrid({
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
                    $('#tableRegisterCalActivities').jqxGrid('hidecolumn', 'dataValueObtanied');
                    resizeGrid();
                }
            });
            resizeGrid();
            $('#tableRegisterCalActivities').jqxGrid('hidecolumn', 'dataValueObtanied');
            if(status==1){                
                $('#tableRegisterCalActivities').jqxGrid({ enablehover: false, selectionmode: 'none'});
            }
            $("#tableRegisterCalActivities").jqxGrid('focus');
            $("#tableRegisterCalActivities").off('cellvaluechanged');
            $("#tableRegisterCalActivities").on('cellvaluechanged', function (event) {
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
                
                itemTypeEvaluation = $('#registerCalEvaluationType').jqxDropDownList('getSelectedItem');
                if(datafield==="dataValueObtaniedNew"){
                    if(itemTypeEvaluation.value===1){
                        var params = {
                            "evaluationType" : itemTypeEvaluation.value,
                            "row": rowBoundIndex,
                            "value": value,
                            "oldvalue" : oldvalue
                        };
                        evaluateActivityByRow(params);
                    }  
                }                              
                if(getTypeScale(datafield)===1 || getTypeScale(datafield)===2 || getTypeScale(datafield)===3){
                    if(itemTypeEvaluation.value===2){  
                        var rowData = $('#tableRegisterCalActivities').jqxGrid('getrowdata', rowBoundIndex);
                        var cellBe = $('#tableRegisterCalActivities').jqxGrid('getcellvalue', rowBoundIndex, "dataObtaniedRegularizationBe");
                        var cellKnow = $('#tableRegisterCalActivities').jqxGrid('getcellvalue', rowBoundIndex, "dataObtaniedRegularizationKnow");
                        var cellDo = $('#tableRegisterCalActivities').jqxGrid('getcellvalue', rowBoundIndex, "dataObtaniedRegularizationDo");
                        var total = parseFloat(cellBe)+parseFloat(cellKnow)+parseFloat(cellDo);
                        var total=total.toFixed(2);
                        var params = {
                            "evaluationType" : itemTypeEvaluation.value,
                            "rowID": rowData.id,
                            "value": value,
                            "total" : total,
                            "scaleType" :  getTypeScale(datafield)
                        };
                        evaluateScaleByRow(params);
                    }else if(itemTypeEvaluation.value===3){  
                        var rowData = $('#tableRegisterCalActivities').jqxGrid('getrowdata', rowBoundIndex); 
                        var cellBe = $('#tableRegisterCalActivities').jqxGrid('getcellvalue', rowBoundIndex, "dataObtaniedGlobalBe");
                        var cellKnow = $('#tableRegisterCalActivities').jqxGrid('getcellvalue', rowBoundIndex, "dataObtaniedGlobalKnow");
                        var cellDo = $('#tableRegisterCalActivities').jqxGrid('getcellvalue', rowBoundIndex, "dataObtaniedGlobalDo");
                        var total = parseFloat(cellBe)+parseFloat(cellKnow)+parseFloat(cellDo);
                        var total=total.toFixed(2);
                        var params = {
                            "evaluationType" : itemTypeEvaluation.value,
                            "rowID": rowData.id,
                            "value": value,
                            "total" : total,
                            "scaleType" :  getTypeScale(datafield)
                        };
                        evaluateScaleByRow(params);
                    }
                } 
            });
            if(length>0){
                if(status==1){
                    $('#tableRegisterCalActivities').jqxGrid('clearselection');
                    $(deleteEvaluatedActivityPopover).parent().hide();
                    $(evaluateActivityPopover).parent().hide(); 
                }else{
                    itemTypeEvaluation = $('#registerCalEvaluationType').jqxDropDownList('getSelectedItem');                    
                    if(itemTypeEvaluation.value==1){
                        if(activityEvaluated>=1){
                            $(evaluateActivityPopover).parent().hide();
                            $(deleteEvaluatedActivityPopover).parent().show();
                        }else{      
                            $(deleteEvaluatedActivityPopover).parent().hide();
                            $(evaluateActivityPopover).parent().show();
                        }                      
                    }else{
                        $(deleteEvaluatedActivityPopover).parent().hide();
                        $(evaluateActivityPopover).parent().hide();                        
                    }   
                }                
            }
        }
        function anyActivityEvaluated(){
            var valItemCareer=0;
            var valItemSemester=0;
            var valItemPeriod=0;
            var valItemGroup=0;
            var valItemActivity=0;
            itemCareer = $('#registerCalFlangeCareerFilter').jqxDropDownList('getSelectedItem');
            itemSemester = $('#registerCalFlangeSemesterFilter').jqxDropDownList('getSelectedItem');
            itemPeriod = $('#registerCalFlangePeriodFilter').jqxDropDownList('getSelectedItem');
            itemGroup = $('#registerCalFlangeGroupFilter').jqxDropDownList('getSelectedItem');
            itemSubjectMatter=$('#registerCalFlangeSubjectMatterFilter').jqxDropDownList('getSelectedItem');
            itemActivity = $('#calTeacherActivitiesFilter').jqxDropDownList('getSelectedItem');
            if(itemCareer!==undefined){
                valItemCareer=itemCareer.value;
            }
            if(itemSemester!==undefined){
                valItemSemester=itemSemester.value;
            }
            if(itemPeriod!==undefined){
                valItemPeriod=itemPeriod.value;
            }
            if(itemGroup!==undefined){
                valItemGroup=itemGroup.value;
            }
            if(itemActivity!==undefined && itemActivity!==null){
                valItemActivity=itemActivity.value;
            }
            var returnValue=undefined;
            $.ajax({
                //Send the paramethers to servelt
                type: "POST",
                async: false,
                dataType: 'json',
                data: {
                    anyActivityEvaluated : "",
                    pkCareer : valItemCareer,
                    pkSemester : valItemSemester,
                    pkActivity : valItemActivity,
                    pkGroup : valItemGroup,
                    pkMatter : itemSubjectMatter.value,
                    pkPeriod : valItemPeriod                    
                },
                url: '../serviceActivitiesCalByStudents',
                beforeSend: function (xhr) {
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    //This is if exits an error with the server internal can do server off, or page not found
                    alert("Error interno del servidor");
                },
                success: function (data, textStatus, jqXHR) {
                    returnValue=data[0].dataAnyActivityEvaluated;
                }
            });
            return returnValue;
        }
        function exitWorkPlanning(){
            var valItemLevel=0;
            var valItemPeriod=0;
            var valItemGroup=0;
            var valItemSubjectMatter=0;
            var valItemScaleEvaluation=0;
            itemLevel = $('#registerCalFlangeLevelFilter').jqxDropDownList('getSelectedItem');
            itemPeriod = $('#registerCalFlangePeriodFilter').jqxDropDownList('getSelectedItem');
            itemGroup = $('#registerCalFlangeGroupFilter').jqxDropDownList('getSelectedItem');
            itemSubjectMatter=$('#registerCalFlangeSubjectMatterFilter').jqxDropDownList('getSelectedItem');
            itemScaleEvaluation = $('#calTeacherScaleEvaluationFilter').jqxDropDownList('getSelectedItem');  
            if(itemLevel!==undefined){
                valItemLevel=itemLevel.value;
            }
            if(itemPeriod!==undefined){
                valItemPeriod=itemPeriod.value;
            }
            if(itemGroup!==undefined){
                valItemGroup=itemGroup.value;
            }
            if(itemSubjectMatter!==undefined){
                valItemSubjectMatter=itemSubjectMatter.value;
            }
            if(itemScaleEvaluation!==undefined){
                valItemScaleEvaluation=itemScaleEvaluation.value;
            }
            $.ajax({
                //Send the paramethers to servelt
                type: "POST",
                async: false,
                dataType: 'json',
                url: "../serviceActivities?exitWorkPlanning",
                data:{
                    "fk_period": valItemPeriod, 
                    "fk_study_level": valItemLevel, 
                    "fk_subject_matter": valItemSubjectMatter, 
                    "fk_group": valItemGroup, 
                    "fk_scale_evaluation": valItemScaleEvaluation
                },
                beforeSend: function (xhr) {
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    //This is if exits an error with the server internal can do server off, or page not found
                    alert("Error interno del servidor");
                },
                success: function (data, textStatus, jqXHR) {
                    if(data.dataResult==="Exist"){
                        $("#pkWorkPlannig").val(data.dataPkWorkPlanning);
                        if(data.dataRealized==="1"){
                        }else{
                        }
                    }else{
                        $("#pkWorkPlannig").val(0);
                    }
                }
            });
        }
        function initDropDownActivities(update, indexSelect){
            var valItemLevel=0;
            var valItemPeriod=0;
            var valItemGroup=0;
            var valItemSubjectMatter=0;
            var valItemScaleEvaluation=0;
            itemLevel = $('#registerCalFlangeLevelFilter').jqxDropDownList('getSelectedItem');
            itemPeriod = $('#registerCalFlangePeriodFilter').jqxDropDownList('getSelectedItem');
            itemGroup = $('#registerCalFlangeGroupFilter').jqxDropDownList('getSelectedItem');
            itemSubjectMatter=$('#registerCalFlangeSubjectMatterFilter').jqxDropDownList('getSelectedItem');
            itemScaleEvaluation = $('#calTeacherScaleEvaluationFilter').jqxDropDownList('getSelectedItem'); 
            if(itemLevel!==undefined){
                valItemLevel=itemLevel.value;
            }
            if(itemPeriod!==undefined){
                valItemPeriod=itemPeriod.value;
            }
            if(itemGroup!==undefined){
                valItemGroup=itemGroup.value;
            }
            if(itemSubjectMatter!==undefined){
                valItemSubjectMatter=itemSubjectMatter.value;
            }
            $("#calTeacherActivitiesFilter").off("change");
            
            if(itemScaleEvaluation!==undefined){
                exitWorkPlanning();
                valItemScaleEvaluation=itemScaleEvaluation.value;
                filtrableActivities[0]=$("#pkWorkPlannig").val();
                filtrableActivities[1]=valItemPeriod;
                filtrableActivities[2]=valItemLevel;
                filtrableActivities[3]=valItemSubjectMatter;
                filtrableActivities[4]=valItemGroup;
                filtrableActivities[5]=valItemScaleEvaluation;  
                filtrableActivities[6]=indexSelect;  
                createDropDownActivities("#calTeacherActivitiesFilter", filtrableActivities, update);                
                itemActivity = $('#calTeacherActivitiesFilter').jqxDropDownList('getSelectedItem'); 
                maxValActivity();
                loadTable();
            }  
            
            
            
            
            $("#calTeacherActivitiesFilter").on('change',function (event){
                if(event.args){
                    itemActivity = $('#calTeacherActivitiesFilter').jqxDropDownList('getSelectedItem');
                    if(itemActivity!==undefined && itemActivity!==null){
                        $('#tableRegisterCalActivities').fadeIn("slow");
                        maxValActivity();
                        loadTable();
                    }else{
                        $('#tableRegisterCalActivities').hide();
                    }
                }
            });
        }
        
        function maxValScale(pkScale){  
            var maxValScale=0;
            if(itemScaleEvaluation!==undefined){
                $.ajax({
                    //Send the paramethers to servelt
                    type: "POST",
                    async: false,
                    url: "../serviceScaleEvaluation",
                    dataType: 'json',
                    data:{
                        "view":"maxValueScale",
                        "pkScaleEvaluation": pkScale
                    },
                    beforeSend: function (xhr) {
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        //This is if exits an error with the server internal can do server off, or page not found
                        alert("Error interno del servidor");
                    },
                    success: function (data, textStatus, jqXHR) {
                        maxValScale = parseFloat(data[0].dataMaxValue);
                        $("#valMaxScale").text(maxValScale+" = 100%");
                    }
                });
            }
            return maxValScale;
        }
        function maxValActivity(){
            itemActivity = $('#calTeacherActivitiesFilter').jqxDropDownList('getSelectedItem');
            if(itemActivity!==undefined && itemActivity!==null){                
                $.ajax({
                    //Send the paramethers to servelt
                    type: "POST",
                    async: false,
                    url: "../serviceActivities",
                    data:{
                        "valueMaxActiity":"",
                        "pkActivity": itemActivity.value
                    },
                    beforeSend: function (xhr) {
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        //This is if exits an error with the server internal can do server off, or page not found
                        alert("Error interno del servidor");
                    },
                    success: function (data, textStatus, jqXHR) {
                        value_max=parseFloat(data[0].dataValueActivity);
                        $('#tableRegisterCalActivities').show();
                    }
                });
                itemScaleEvaluation = $("#calTeacherScaleEvaluationFilter").jqxDropDownList('getSelectedItem');
                var val_max_scale = maxValScale(itemScaleEvaluation.value);
                $("#valMaxActivity").text(value_max);
            }else{
                $('#tableRegisterCalActivities').fadeOut("slow");
            }
        }  
        
        $("#tableRegisterCalActivities").on('contextmenu', function () {
            return false;
        });
        var contextMenu = $("#jqxMenuContext").jqxMenu({ 
            width: 200, 
            height: 30, 
            autoOpenPopup: false, 
            mode: 'popup'
        });
        $("#jqxMenuContext").on('itemclick', function (event) {
            var args = event.args;
            var rowindex = $("#tableRegisterCalActivities").jqxGrid('getselectedrowindex');
            var data = $('#tableRegisterCalActivities').jqxGrid('getrowdata', rowindex);
            $("#nameStudenTemp").text(data.dataNameStudent);
            loadActivities(1, data.dataPkStudent);
            if ($.trim($(args).text()) === "Detalles de calificación") {
                var offset = $("#tableRegisterCalActivities").offset();
                $("#popupWindow").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
                $("#popupWindow").jqxWindow('show');
            }
        });
        $("#popupWindow").jqxWindow({ 
            width: 500, 
            height : 380,
            resizable: false,  
            isModal: true, 
            autoOpen: false, 
            modalOpacity: 0.6,
            maxHeight: 580,
            minHeight: 200,
            maxWidth: 500
        }); 
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
    .jqx-slider-tickscontainer{
        color: rgb(84, 146, 95) !important;
    }
</style>
<div style="float: left; margin-right: 5px;">
    Nivel de estudio<br>
    <div id='registerCalFlangeLevelFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Carrera <br>
    <div id='registerCalFlangeCareerFilter'></div>
</div>

<div style="float: right; margin-right: 5px; display: none">
    Periodo <br>
    <div id='registerCalFlangePeriodFilter'></div>
</div>

<div style="float: left; margin-right: 5px;">
    Cuatrimestre<br>
    <div id='registerCalFlangeSemesterFilter'></div>
</div>
<br><br><br>
<div style="float: left; margin-right: 5px;">
    Grupo<br>
    <div id='registerCalFlangeGroupFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Materia<br>
    <div id='registerCalFlangeSubjectMatterFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Tipo <br>
    <div id='registerCalEvaluationType'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Saber<br>
    <input type="hidden" id="pkWorkPlannig"/>
    <div id='calTeacherScaleEvaluationFilter'></div>
</div>
<div style="display: none; float: left; margin-right: 5px; text-align: center;">
    Valor<br>
    <div id='valMaxScale' style="font-size: 23px;"></div>
</div>

<div style="float: left; margin-right: 5px;">
    Actividad<br>
    <div id="contentCalTeacherActivitiesFilter">
        <div id='calTeacherActivitiesFilter'></div>
    </div>
</div>
<div style="float: left; margin-right: 5px; text-align: center; display: none;">
    Acción<br>
    <div id="evaluateActivityPopover" style="height: 28px; margin-left: 7px;">
        <div class="jqx-icon-action" style="height: 20px; width: 20px;"></div>
    </div>
</div>
<div style="float: left; margin-right: 5px; text-align: center; display: none;">
    Acción<br>
    <div id="deleteEvaluatedActivityPopover" style="height: 28px; margin-left: 7px;">
        <div class="jqx-icon-action" style="height: 20px; width: 20px;"></div>
    </div>
</div>
<div id="popoverOptionEvaluate">
    <div style="color: olive;">
        <label style="font-size: 14px; font-weight: bold">Evaluar actividad</label>
        <br>
        <label style="font-size: 12px">            
            <input id="typeMin" value="0" type="radio" name="wayScaleEvaluation"/>
            Mínimo 0
        </label>
        <br>
        <label style="font-size: 12px">           
            <input id="typeMax" value="1" type="radio" name="wayScaleEvaluation" />
            Máximo <span id='valMaxActivity'></span>
        </label>
        <br>
        <center><button id="evaluateActivity">Evaluar</button></center>
        <img id="loadEvaluating" style="display: none; width: 30px; position: absolute; right: 10px; bottom: 5px;" src="../content/pictures-system/loading.GIF">
    </div>
</div>
<div id="popoverOptionDeleteEvaluated">
    <div style="color: olive;">
        <label style="font-size: 12px;">Al borrar la evaluación de esta actividad se perdera la calificación de todo el grupo seleccionado.</label>
        <br>
        <center>
            <div id="deleteActivity" style="height: 28px; margin-left: 7px;">
                <div class="jqx-icon-delete" style="height: 20px; width: 20px;"></div>
            </div>
        </center>
        <img id="loadDeleting" style="display: none; width: 30px; position: absolute; right: 10px; bottom: 5px;" src="../content/pictures-system/loading.GIF">
    </div>
</div>
<br><br><br>
<div style=" margin-right: 5px;  width: 100%; height: 70%; display: inline-block;">
    <div id="tableRegisterCalActivities"></div>
</div>
<div id="popupWindow">
    <div>
        <b>Detalle de todas las actividades</b>
        <div>
            <b>Alumno: </b><span id="nameStudenTemp"></span>
        </div>
    </div>
    <div style="overflow: auto; padding: 0px">
        <div id="detailsScaleEvaluation">
            <style>
                .table-utsem{
                    color: #779670; margin: 2px;
                    /*width:99%;*/
                }
                .table-utsem thead{
                    background: rgb(190, 242, 152) none repeat scroll 0% 0%;
                }
                .table-striped tbody > tr:nth-child(2n+1) > td, .table-striped tbody > tr:nth-child(2n+1) > th{
                    background: rgb(221, 255, 214) none repeat scroll 0% 0%;
                }
                .table-hover tbody tr:hover > td, .table-hover tbody tr:hover > th{
                    background:#BEF298;
                }
            </style>
            <div class="tablesActivities1"></div>
        </div>
    </div>
</div>
<div id='jqxMenuContext'>
    <ul>
        <li>Detalles de calificación</li>
    </ul>
</div>