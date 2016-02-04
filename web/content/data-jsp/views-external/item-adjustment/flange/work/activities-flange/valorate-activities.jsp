<style>
    .error{
        -webkit-box-shadow: 2px 1px 15px -8px rgba(255,0,0,1) !important;
        -moz-box-shadow: 2px 1px 15px -8px rgb(255, 0, 0) !important;
        box-shadow: 2px 1px 15px -8px rgb(255, 0, 0) !important;
        box-shadow: 2px 1px 15px -8px rgb(255, 0, 0) !important;
        border: 1px solid #D15E5E !important;
    }
</style>
<script>
    $(document).ready(function () {
        var indications = "";
        var observations = "";
        var indicationsImpor = "";
        var itemLevel = 0;
        var itemCareer = 0;
        var itemPeriod = 0;
        var itemScaleEvaluation = 0;
        var itemSemester = 0;
        var itemSubjectMatter = 0;
        createDropDownStudyLevelByTeacher("#valorateActivitiesLevelFilter",false);
        itemLevel = $('#valorateActivitiesLevelFilter').jqxDropDownList('getSelectedItem');
        if(itemLevel!==undefined){
            createDropDownCareerByTeacher( itemLevel.value ,"#valorateActivitiesCareerFilter",false);
            itemCareer = $('#valorateActivitiesCareerFilter').jqxDropDownList('getSelectedItem');
            createDropDownPeriod("comboActiveYear","#valorateActivitiesPeriodFilter");
            itemPeriod = $('#valorateActivitiesPeriodFilter').jqxDropDownList('getSelectedItem');
            createDropDownSemesterByTeacher(itemPeriod.value, itemLevel.value,"#valorateActivitiesSemesterFilter",false);
            itemSemester = $('#valorateActivitiesSemesterFilter').jqxDropDownList('getSelectedItem');
            createDropDownSubjectMatterByTeacher(itemPeriod.value, itemCareer.value, itemSemester.value, null, "#valorateActivitiesSubjectMatterFilter", false);
            itemSubjectMatter=$('#valorateActivitiesSubjectMatterFilter').jqxDropDownList('getSelectedItem');
            createDropDownScaleEvaluation("#valorateActivitiesScaleEvaluationFilter",itemLevel.value,false);
            itemScaleEvaluation = $('#valorateActivitiesScaleEvaluationFilter').jqxDropDownList('getSelectedItem');     
            createLitsBoxPeriodByTeacher(itemCareer.value, itemSemester.value, itemSubjectMatter.value, itemScaleEvaluation.value, "#valorateActivitiesPeriodHistoryFilter");
            $('#valorateActivitiesLevelFilter').on('change',function (event){  
                var args = event.args;
                if(args){
                    itemLevel = $('#valorateActivitiesLevelFilter').jqxDropDownList('getSelectedItem');
                    createDropDownCareerByTeacher(itemLevel.value, "#valorateActivitiesCareerFilter", true);                    
                }        
            });
            $('#valorateActivitiesCareerFilter').on('change',function (event){  
                var args = event.args;
                if(args){                    
                    itemPeriod = $('#valorateActivitiesPeriodFilter').jqxDropDownList('getSelectedItem');
                    itemCareer = $('#valorateActivitiesCareerFilter').jqxDropDownList('getSelectedItem');
                    createDropDownSemesterByTeacher(itemPeriod.value, itemLevel.value,"#valorateActivitiesSemesterFilter", true);                    
                }
            });
            $('#valorateActivitiesPeriodFilter').on('change',function (event){   
                var args = event.args;
                if(args){
                    itemCareer = $('#valorateActivitiesCareerFilter').jqxDropDownList('getSelectedItem');
                    itemPeriod = $('#valorateActivitiesPeriodFilter').jqxDropDownList('getSelectedItem');
                    itemLevel = $('#valorateActivitiesLevelFilter').jqxDropDownList('getSelectedItem');
                    itemScaleEvaluation = $('#valorateActivitiesScaleEvaluationFilter').jqxDropDownList('getSelectedItem');
                    createDropDownSemesterByTeacher(itemPeriod.value, itemLevel.value,"#valorateActivitiesSemesterFilter", true);
                    itemSemester = $('#valorateActivitiesSemesterFilter').jqxDropDownList('getSelectedItem');
                    var pkSemester=0;
                    if(itemSemester!==null){
                        pkSemester = itemSemester.value;
                    }
                    createDropDownSubjectMatterByTeacher(itemPeriod.value, itemCareer.value, pkSemester, null, "#valorateActivitiesSubjectMatterFilter", true);
                    var dataAdapter = new $.jqx.dataAdapter(loadSource("today"));
                    $("#tableRegisterActivities").jqxGrid({source: dataAdapter});
                }
            });
            
            $("#valorateActivitiesSemesterFilter").on('change',function (event){
                var args = event.args;
                if(args){
                    itemCareer = $('#valorateActivitiesCareerFilter').jqxDropDownList('getSelectedItem');
                    itemPeriod = $('#valorateActivitiesPeriodFilter').jqxDropDownList('getSelectedItem');
                    itemSemester = $('#valorateActivitiesSemesterFilter').jqxDropDownList('getSelectedItem');
                    createDropDownSubjectMatterByTeacher(itemPeriod.value, itemCareer.value, itemSemester.value, null, "#valorateActivitiesSubjectMatterFilter", true);
                }
            });
            $("#valorateActivitiesSubjectMatterFilter").on('change',function (event){
                var args = event.args;
                if(args){
                    itemSemester = $('#valorateActivitiesSemesterFilter').jqxDropDownList('getSelectedItem');
                    itemSubjectMatter=$('#valorateActivitiesSubjectMatterFilter').jqxDropDownList('getSelectedItem');
                    createDropDownScaleEvaluation("#valorateActivitiesScaleEvaluationFilter",itemLevel.value, true);
                    itemScaleEvaluation = $('#valorateActivitiesScaleEvaluationFilter').jqxDropDownList('getSelectedItem'); 
                    if(itemScaleEvaluation!==null){
                        $("#contentTRegisterActivities").show();
                    }else{
                        $("#contentTRegisterActivities").hide();
                    }
                }
            });
            $("#valorateActivitiesScaleEvaluationFilter").on('change',function (event){
                var args = event.args;
                if(args){
                    existWorkPlanning(); 
                }                
            });
            $("#valorateActivitiesPeriodHistoryFilter").on('change',function (event){
                var args = event.args;
                if(args){
                    $('#jqxSplitter').jqxSplitter('collapse'); 
                    var dataAdapter = new $.jqx.dataAdapter(loadSource("history"));
                    loadTableRegisterActivitiesHistory(dataAdapter); 
                    if($("#divHistory").attr("style")!=="float: left;" && $("#divHistory").attr("style")!=="float: left; display: block;"){
                        $("#contentTRegisterActivitiesHistory").css("width","0px");
                        $("#divHistory").fadeIn("slow");
                        $("#contentTRegisterActivitiesHistory").animate({ "width": "585px" }, "fast");
                    }
                    if(!existWorkPlanning()){
                        $("#addWorkPlannin").click();
                    }
                }
            });  
            var dataAdapter = new $.jqx.dataAdapter(loadSource("today"));
            loadTableRegisterActivities(dataAdapter);
            existWorkPlanning();
        }else{
            $("#addWorkPlannin").hide();
            $(".close").parent().hide(); 
            createDropDownCareerByTeacher(null ,"#valorateActivitiesCareerFilter",false);
            createDropDownPeriod("comboActiveYear","#valorateActivitiesPeriodFilter");
            createDropDownSemesterByTeacher(null, null,"#valorateActivitiesSemesterFilter",false);
            createDropDownSubjectMatterByTeacher(null, null, null, null, "#valorateActivitiesSubjectMatterFilter", false);
            createDropDownScaleEvaluation("#valorateActivitiesScaleEvaluationFilter",null, false);
            createLitsBoxPeriodByTeacher(null, null, null, null, "#valorateActivitiesPeriodHistoryFilter");
        }
        
        function maxValScale(){  
            itemScaleEvaluation = $('#valorateActivitiesScaleEvaluationFilter').jqxDropDownList('getSelectedItem');
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
                        "pkScaleEvaluation": itemScaleEvaluation.value
                    },
                    beforeSend: function (xhr) {
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        //This is if exits an error with the server internal can do server off, or page not found
                        alert("Error interno del servidor");
                    },
                    success: function (data, textStatus, jqXHR) {
                        maxValScale = data[0].dataMaxValue;
                        $("#valMaxScale").text(maxValScale+" = 100%");
                    }
                });
            }
            return maxValScale;
        }         
        function existWorkPlanning(){
            var exist=false;
            itemPeriod = $('#valorateActivitiesPeriodFilter').jqxDropDownList('getSelectedItem');
            itemLevel = $('#valorateActivitiesLevelFilter').jqxDropDownList('getSelectedItem');
            itemSemester = $('#valorateActivitiesSemesterFilter').jqxDropDownList('getSelectedItem');
            itemSubjectMatter=$('#valorateActivitiesSubjectMatterFilter').jqxDropDownList('getSelectedItem');
            itemScaleEvaluation = $('#valorateActivitiesScaleEvaluationFilter').jqxDropDownList('getSelectedItem');
            //alert();
            if(itemSemester!==undefined){
                $.ajax({
                    //Send the paramethers to servelt
                    type: "POST",
                    async: false,
                    dataType: 'json',
                    url: "../serviceActivities?exitWorkPlanning",
                    data:{
                        "fk_period": itemPeriod.value, 
                        "fk_study_level": itemLevel.value, 
                        "fk_subject_matter": itemSubjectMatter.value, 
                        "fk_scale_evaluation": itemScaleEvaluation.value
                    },
                    beforeSend: function (xhr) {
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        //This is if exits an error with the server internal can do server off, or page not found
                        alert("Error interno del servidor");
                    },
                    success: function (data, textStatus, jqXHR) {
                        if(data.dataResult==="Exist"){
                            indications = data.dataIndication;
                            observations = data.dataObservations;
                            $("#addWorkPlannin").parent().fadeOut("slow");
                            $("#addWorkPlannin").show();
                            $("#contentTRegisterActivities").fadeIn("slow");
                            $(".close").parent().fadeIn("slow"); 
                            $("#pkWorkPlannig").val(data.dataPkWorkPlanning);
                            $("#indications").text(indications);
                            var dataAdapter = new $.jqx.dataAdapter(loadSource("today"));
                            loadTableRegisterActivities(dataAdapter);
                            if(data.dataRealized==="1"){
                                //$("#block-activities").show();
                                $(".jqx-icon-unlock").parent().show();
                                if(data.dataRealizedBlock==="3"){
                                    $(".jqx-icon-export").parent().show();
                                }else{
                                    $(".jqx-icon-export").parent().hide();
                                }     
                                $(".jqx-icon-plus").parent().hide();
                                $(".jqx-icon-lock").parent().hide();
                                $(".jqx-icon-delete").parent().hide();
                                $(".jqx-icon-edit").parent().hide();
                                
                                $("#tableRegisterActivities").jqxGrid({selectionMode: "none",enableHover: false});
                            }else{
                                $("#addWorkPlannin").fadeIn("slow");
                                $("#tableRegisterActivities").jqxGrid({selectionMode: "singleRow",enableHover: true});
                                $(".jqx-icon-unlock").parent().hide();
                                $(".jqx-icon-export").parent().hide();
                                //$("#block-activities").hide();
                                if(disponibilityValueByWorkPlanning()){
                                    $(".jqx-icon-plus").parent().show();
                                    $(".jqx-icon-lock").parent().hide();
                                    //$("#block-activities").hide();
                                }else{
                                    $(".jqx-icon-plus").parent().hide();
                                    $(".jqx-icon-lock").parent().show();
                                    //$("#block-activities").hide();
                                }
                                $(".jqx-icon-delete").parent().show();
                                $(".jqx-icon-edit").parent().show();
                            }
                            exist=true;
                        }else{
                            $("#addWorkPlannin").parent().fadeIn("slow");
                            $("#addWorkPlannin").show();
                            $("#contentTRegisterActivities").fadeOut("slow");
                            $(".close").parent().fadeOut("slow"); 
                        }
                    }
                });
                maxValScale();
            }
            return exist;
        }
        $("#addWorkPlannin").click(function (){
            itemLevel = $('#valorateActivitiesLevelFilter').jqxDropDownList('getSelectedItem');
            itemPeriod = $('#valorateActivitiesPeriodFilter').jqxDropDownList('getSelectedItem');
            itemSubjectMatter =$('#valorateActivitiesSubjectMatterFilter').jqxDropDownList('getSelectedItem');
            itemScaleEvaluation = $('#valorateActivitiesScaleEvaluationFilter').jqxDropDownList('getSelectedItem');
            $.ajax({
                //Send the paramethers to servelt
                type: "POST",
                async: false,
                dataType: 'json',
                url: "../serviceActivities?insertWorkPlanning",
                data:{
                    "fk_period": itemPeriod.value, 
                    "fk_study_level": itemLevel.value, 
                    "fk_subject_matter": itemSubjectMatter.value, 
                    "fk_scale_evaluation": itemScaleEvaluation.value
                },
                beforeSend: function (xhr) {
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    //This is if exits an error with the server internal can do server off, or page not found
                    alert("Error interno del servidor");
                },
                success: function (data, textStatus, jqXHR) {
                    if(data.dataResult==="Success"){
                        $("#contentTRegisterActivities").fadeIn();
                        $("#addWorkPlannin").hide();
                        $("#pkWorkPlannig").val(data.dataPkWorkPlanning);
                        var dataAdapter = new $.jqx.dataAdapter(loadSource("today"));
                        loadTableRegisterActivities(dataAdapter);
                    }
                }
            });
            existWorkPlanning();
        });
        function loadSource(type){
            if(type==="history"){
                itemPeriod = $('#valorateActivitiesPeriodHistoryFilter').jqxListBox('getSelectedItem');
            }else{
                itemPeriod = $('#valorateActivitiesPeriodFilter').jqxDropDownList('getSelectedItem');
            }
            itemLevel = $('#valorateActivitiesLevelFilter').jqxDropDownList('getSelectedItem');
            itemSemester = $('#valorateActivitiesSemesterFilter').jqxDropDownList('getSelectedItem');
            itemSubjectMatter=$('#valorateActivitiesSubjectMatterFilter').jqxDropDownList('getSelectedItem');
            itemScaleEvaluation = $('#valorateActivitiesScaleEvaluationFilter').jqxDropDownList('getSelectedItem');
            var pkMatter=0;
            if(itemSemester!==undefined){
                pkMatter=itemSubjectMatter.value;
            }else{
                itemSemester=0;
                pkMatter=null;
            }
            var ordersSource ={
                dataFields: [
                    { name: 'id', type:'int'},
                    { name: 'dataProgresivNumber', type:'int'},
                    { name: 'dataNameActivity', type: 'string' },
                    { name: 'dataDescriptionActivity', type: 'string' },
                    { name: 'dataCreationDate', type: 'string' },
                    { name: 'dataLastDateUpdate', type: 'string' },
                    { name: 'dataValueActivity', type: 'string' },
                    { name: 'dataValueActivityPercent', type: 'string' },
                    { name: 'dataPkScaleEvaluation', type: 'int' },
                    { name: 'dataNameScale', type: 'string' },
                    { name: 'dataMaxValue', type: 'dobule' },
                    { name: 'dataPkWorkPlanning', type: 'int' }
                ],
                root: "__ENTITIES",
                type:"POST",
                dataType: "json",
                id: 'id',
                async: false,
                url: '../serviceActivities?view',
                data:{ 
                        "pkWorkPlanning":0,
                        "fk_period": itemPeriod.value, 
                        "fk_study_level": itemLevel.value, 
                        "fk_subject_matter": pkMatter, 
                        "fk_scale_evaluation": itemScaleEvaluation.value
                },
                addRow: function (rowID, rowData, position, commit) {   
                },
                updateRow: function (rowID, rowData, commit) {
                },
                deleteRow: function (rowID, commit) {  
                }
            };
            return ordersSource;
        }
        var max_value=0;
        function disponibilityValueByWorkPlanning(){
            itemScaleEvaluation = $('#valorateActivitiesScaleEvaluationFilter').jqxDropDownList('getSelectedItem');
            var status;
            $.ajax({
                //Send the paramethers to servelt
                type: "POST",
                async: false,
                dataType: 'json',
                url: "../serviceActivities?disponibilityValueByWorkPlanning",
                data:{
                    "fk_work_planning": $("#pkWorkPlannig").val(), 
                    "fk_scale_evaluation": itemScaleEvaluation.value
                },
                beforeSend: function (xhr) {
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    //This is if exits an error with the server internal can do server off, or page not found
                    alert("Error interno del servidor");
                },
                success: function (data, textStatus, jqXHR) {
                    if(data.dataResult>=0.01){
                        max_value=data.dataResult;
                        status=true;
                    }else{
                        max_value=0;
                        status=false;
                    }
                }
            });
            return status;
        }
            
        //Tiene un evento que se almacena conforme cambias de pagina por lo que hace cargas por cada ves que hay un click anidado
        var addButton;
        function loadTableRegisterActivities(dataAdapter){
            $("#tableRegisterActivities").jqxGrid({
                width: 590,
                height:350,
                selectionMode: "singleRow",
                localization: getLocalization("es"),
                source: dataAdapter,
                pageable: true,
                editable: false,
                filterable: false,
                showToolbar: true,
                showStatusbar: true,
                altRows: false,
                autoRowHeight: true,
                pagerButtonsCount: 5,
                toolbarHeight: 35,
                statusBarHeight: 45,
                renderToolbar: function(toolBar){
                    var themeRenderToolbar = "";
                    var toTheme = function (className) {
                        if (themeRenderToolbar === "") return className;
                        return className + " " + className + "-" + themeRenderToolbar;
                    };
                    // appends buttons to the status bar.
                    var container = $("<div style='overflow: hidden; position: relative; height: 100%; width: 100%;'></div>");
                    var buttonTemplate = "<div style='float: left; padding: 3px; margin: 2px;'><div style='margin: 4px; width: 16px; height: 16px;'></div></div>";
                    addButton = $(buttonTemplate);
                    var editButton = $(buttonTemplate);
                    var deleteButton = $(buttonTemplate);
                    var lockButton = $(buttonTemplate);
                    var unlockButton = $(buttonTemplate);
                    var showButton = $(buttonTemplate);
                    var exportButton = $(buttonTemplate);
                    var infoButton = $(buttonTemplate);
//                    editButton.hide();
//                    deleteButton.hide();
//                    lockButton.hide();
//                    unlockButton.hide();
//                    exportButton.hide();
                    container.append(addButton);
                    container.append(lockButton);
                    container.append(unlockButton);
                    container.append(editButton);
                    container.append(deleteButton);
                    container.append(exportButton);
                    
                    container.append(infoButton);
                    container.append(showButton);   
                    
                    
                    var rowIndex = null;
                    var rowId = null;
                    var rowData = null;
                    toolBar.append(container);
                   
                    addButton.jqxButton({cursor: "pointer", enableDefault: false,  height: 25, width: 25 });
                    addButton.find('div:first').addClass(toTheme('jqx-icon-plus'));
                    addButton.jqxTooltip({ position: 'bottom', content: "Agregar"});
                    
                    unlockButton.jqxButton({cursor: "pointer", enableDefault: false,  height: 25, width: 25 });
                    unlockButton.find('div:first').addClass(toTheme('jqx-icon-unlock'));
                    unlockButton.jqxTooltip({ position: 'bottom', content: "Abrir actividades"});
                    
                    lockButton.jqxButton({cursor: "pointer", enableDefault: false,  height: 25, width: 25 });
                    lockButton.find('div:first').addClass(toTheme('jqx-icon-lock'));
                    lockButton.jqxTooltip({ position: 'bottom', content: "Cerrar actividades"});
                    
                    editButton.jqxButton({ cursor: "pointer", disabled: true, enableDefault: false,  height: 25, width: 25 });
                    editButton.find('div:first').addClass(toTheme('jqx-icon-edit'));
                    editButton.jqxTooltip({ position: 'bottom', content: "Editar"});
                    
                    deleteButton.jqxButton({ cursor: "pointer", disabled: true, enableDefault: false,  height: 25, width: 25 });
                    deleteButton.find('div:first').addClass(toTheme('jqx-icon-delete'));
                    deleteButton.jqxTooltip({ position: 'bottom', content: "Eliminar"});
                    
                    exportButton.jqxButton({cursor: "pointer", enableDefault: false,  height: 25, width: 25 });
                    exportButton.find('div:first').addClass(toTheme('jqx-icon-export'));
                    exportButton.jqxTooltip({ position: 'bottom', content: "Exportar a pdf"});
                    exportButton.attr("id","exportButton");
                    
                    infoButton.jqxButton({ cursor: "pointer", disabled: false, enableDefault: false,  height: 25, width: 25 });
                    infoButton.find('div:first').addClass(toTheme('jqx-icon-info'));
                    infoButton.css({"float":"right","cursor":"pointer"});
                    infoButton.jqxTooltip({ position: 'bottom', content: "Información"});
                    
                    showButton.jqxButton({ cursor: "pointer", disabled: false, enableDefault: false,  height: 25, width: 25 });
                    showButton.find('div:first').addClass(toTheme('jqx-icon-show'));
                    showButton.css({"float":"right","cursor":"pointer"});
                    showButton.jqxTooltip({ position: 'bottom', content: "Agregar observaciones"});
                    showButton.attr("id","showButton");                    
                    var updateButtons = function (action) {
                        switch (action) {
                            case "Select":
                                addButton.jqxButton({ disabled: false });
                                deleteButton.jqxButton({ disabled: false });
                                editButton.jqxButton({ disabled: false });
                                //updateButton.jqxButton({ disabled: true });
                                break;
                            case "Unselect":
                                addButton.jqxButton({ disabled: false });
                                deleteButton.jqxButton({ disabled: true });
                                editButton.jqxButton({ disabled: true });
                                //updateButton.jqxButton({ disabled: true });
                                break;
                        }
                    };
                    $("#tableRegisterActivities").on('rowselect', function (event) {
                        var args = event.args;
                        rowIndex = args.index;
                        rowId=args.row;
                        rowId=rowId.id;
                        rowData=args.row;
                        updateButtons('Select');
                    });
                    $("#tableRegisterActivities").on('rowunselect', function (event) {
                        updateButtons('Unselect');
                    });                    
                    lockButton.click(function () {
                        if (!lockButton.jqxButton('disabled')){
                            updateButtons('lockButton');
                            $('#jqxWindowWarningActivities').jqxWindow({
                                theme: theme,
                                height: 150,
                                width: 400,
                                resizable: false,
                                draggable: false,
                                okButton: $('#okWarning'),
                                autoOpen: false,
                                isModal: true,
                                cancelButton: $('#cancelWarning'),
                                initContent: function () {
                                    $('#okWarning').jqxButton({
                                        width: '80px',
                                        theme: theme
                                    });
                                    $('#cancelWarning').jqxButton({
                                        width: '80px',
                                        theme: theme
                                    });
                                    $('#okWarning').focus();
                                }
                            });
                            $("#jqxWindowWarningActivities").jqxWindow('open');
                            $("#messageWarning").text("Recuerda... Una vez cerradas las actividades no podrán ser modificadas si es que alguna de ellas ya cuenta con algún registro de calificación.");
                            $("#iconWarning").removeClass("trash").addClass("warning");
                            $("#okWarning").click(function (){
                                $("#okWarning").unbind("click"); 
                                $.ajax({
                                    //Send the paramethers to servelt
                                    type: "POST",
                                    async: false,
                                    dataType: 'json',
                                    url: "../serviceActivities",
                                    data:{
                                        "lockWorkPlanning":"",
                                        "fk_work_planning": $("#pkWorkPlannig").val()
                                    },
                                    beforeSend: function (xhr) {
                                    },
                                    error: function (jqXHR, textStatus, errorThrown) {
                                        //This is if exits an error with the server internal can do server off, or page not found
                                        alert("Error interno del servidor");
                                    },
                                    success: function (data, textStatus, jqXHR) {
                                        if(data.dataResult!=="fail"){
                                            $("#jqxWindowWarningActivities").jqxWindow('close');
                                            existWorkPlanning(); 
                                        }                                        
                                    }
                                });
                            });
                        }
                    });
                    
                    unlockButton.click(function () {
                        if (!lockButton.jqxButton('disabled')){
                            updateButtons('unlockButton');
                            $.ajax({
                                //Send the paramethers to servelt
                                type: "POST",
                                async: false,
                                dataType: 'json',
                                url: "../serviceActivities",
                                
                                data:{
                                    "unlockWorkPlanning":"",
                                    "fk_work_planning": $("#pkWorkPlannig").val()
                                },
                                beforeSend: function (xhr) {
                                },
                                error: function (jqXHR, textStatus, errorThrown) {
                                    //This is if exits an error with the server internal can do server off, or page not found
                                    alert("Error interno del servidor");
                                },
                                success: function (data, textStatus, jqXHR) {
                                    $('#jqxWindowOk').jqxWindow({
                                        theme: theme,
                                        height: 100,
                                        width: 350,
                                        resizable: false,
                                        draggable: false,
                                        okButton: $('#ok'),
                                        autoOpen: false,
                                        isModal: true,
                                        initContent: function () {
                                            $('#ok').jqxButton({
                                                width: '80px',
                                                theme: theme
                                            });
                                            $('#ok').focus();
                                        }
                                    });
                                    if(data.dataStatusResult==="success"){
                                        $("#titleOk").text("Bien");
                                        $("#pictureOk").removeClass("fail").addClass("ok");
                                        $("#messageOk").text(data.dataResult);
                                        $("#jqxWindowOk").jqxWindow({height: 100,width: 350});
                                    }else{
                                        $("#titleOk").text("Denegado");
                                        $("#pictureOk").removeClass("ok").addClass("fail");
                                        $("#messageOk").text(data.dataResult);
                                        $("#jqxWindowOk").jqxWindow({height: 130,width: 350}); 
                                    }   
                                    $("#jqxWindowOk").jqxWindow('open');
                                }
                            });
                        }
                    });
                    
                    addButton.click(function (event) {
                        if (!addButton.jqxButton('disabled')) { 
                            itemScaleEvaluation = $('#valorateActivitiesScaleEvaluationFilter').jqxDropDownList('getSelectedItem');
                            disponibilityValueByWorkPlanning();
                            var table = $("#contentTRegisterActivities");
                            $("#name_activity").val("");
                            $("#activity_description").val("");
                            $("#titleAddActivities").text("Nuevo");
                            $("#okAdd").val("Agregar");
                            $("#pictureAddActivities").attr("src","../content/pictures-system/add-activity.png");
                            $('#jqxWindowAddActivities').jqxWindow({position: 'center'});
                            var val_max_scale = 0;                            
                            val_max_scale = Math.round((max_value*100/maxValScale()));
                            $('#value_activity').on('change', function (event) {
                                var value = event.args.value;
                                if(value==0){
                                    $("#value_activity").val(1);
                                }else if(value>=val_max_scale){
                                    $("#value_activity").val(val_max_scale);
                                }     
                            });
                            $("#value_activity").val(val_max_scale);
                            $("#jqxWindowAddActivities").jqxWindow('open');
                        }
                    });
                    
                    editButton.click(function () {
                        if (!editButton.jqxButton('disabled')) {
                            updateButtons('edit');
                            itemScaleEvaluation = $('#valorateActivitiesScaleEvaluationFilter').jqxDropDownList('getSelectedItem');
                            disponibilityValueByWorkPlanning();
                            $("#titleAddActivities").text("Actualizar");
                            $("#okAdd").val("Guardar");
                            $("#pkActivity").val(rowId);
                            $("#pictureAddActivities").attr("src","../content/pictures-system/update-activity.png");
                            $('#jqxWindowAddActivities').jqxWindow({position: 'center'});
                            $('#value_activity').jqxSlider('focus'); 
                            var max_value_temp = (parseFloat((rowData.dataValueActivityPercent).replace("%",""))+(max_value*100/maxValScale()));
                            $('#value_activity').on('change', function (event) {
                                var value = event.args.value;     
                                //console.log(max_value_temp);
                                if(value==0){
                                    $("#value_activity").val(1);
                                }else if(value>=max_value_temp){
                                    $("#value_activity").val(max_value_temp);
                                }     
                            });
                            $("#name_activity").val(rowData.dataNameActivity);
                            $("#value_activity").val((rowData.dataValueActivityPercent).replace("%",""));
                            $("#activity_description").val(rowData.dataDescriptionActivity);
                            $("#name_activity").removeClass("error");
                            $("#activity_description").removeClass("error");
                            $("#jqxWindowAddActivities").jqxWindow('open');
                        }
                    });
                    
                    deleteButton.click(function () {
                        if (!deleteButton.jqxButton('disabled')){
                            updateButtons('delete');
                            $("#messageWarning").text("¡Estas seguro de borrar este registro!");
                            $("#iconWarning").removeClass("warning").addClass("trash");
                            $("#jqxWindowWarningActivities").jqxWindow('open');
                            $("#okWarning").click(function (){
                                $.ajax({
                                    //Send the paramethers to servelt
                                    type: "POST",
                                    async: false,
                                    url: "../serviceActivities?delete",
                                    data:{'pkActivitiesToWork':rowId},
                                    beforeSend: function (xhr) {
                                    },
                                    error: function (jqXHR, textStatus, errorThrown) {
                                        //This is if exits an error with the server internal can do server off, or page not found
                                        alert("Error interno del servidor");
                                    },
                                    success: function (data, textStatus, jqXHR) {
                                        $("#okWarning").unbind("click"); 
                                        $("#jqxWindowWarningActivities").jqxWindow('close');
                                        existWorkPlanning();
                                    }
                                });
                            });
                            
                        }
                    });
                    exportButton.click(function (){
                        itemCareer = $('#valorateActivitiesCareerFilter').jqxDropDownList('getSelectedItem');
                        itemSubjectMatter= $('#valorateActivitiesSubjectMatterFilter').jqxDropDownList('getSelectedItem'); 
                        itemLevel = $('#valorateActivitiesLevelFilter').jqxDropDownList('getSelectedItem');
                        $.ajax({
                            url: "../content/data-jr/evaluatedCriterion/index.jsp?session",
                            data: {
                                "pt_study_level": itemLevel.value,
                                "pt_career": itemCareer.value,
                                "pt_matter": itemSubjectMatter.value
                            },
                            type: 'POST',
                            beforeSend: function (xhr) {
                            },
                            success: function (data, textStatus, jqXHR) {
                                window.open("../content/data-jr/evaluatedCriterion/");
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                alert("Error interno del servidor");                
                            }
                        });
                    });
                    showButton.click(function (){
                        $("#jqxWindowAddObservations").jqxWindow('open');
                        $('#observations').val(observations);
                        $('#observations').focus();
                    });
                    var on=false;
                    infoButton.click(function (){
                        if(on){
                            if (!infoButton.jqxButton('disabled')){
                                $("#indications").text(indications);
                                $("#indications").fadeIn("slow");
                                updateButtons('infoButton');
                            }
                            on=false;
                        }else{
                            $("#indications").fadeOut("slow");
                            on=true;
                        }
                    });
                    
                },
                renderStatusBar: function (statusbar) {
                    // appends buttons to the status bar.
                    var container = $("<div style='overflow: hidden; position: relative; margin: 5px;'></div>");
                    
                    var info = $("<div style='float: left; margin-left: 5px;'><div id='indications'></div></div>");
                    container.append(info);
                    statusbar.append(container);
                    $("#indications").text(indications);
                }, 
                ready: function(){            
                    
                },
                columns: [
                    { text: 'NP', filterable: false, editable: false, dataField: 'dataProgresivNumber', width: 25 },
                    { text: 'Actividad', dataField: 'dataNameActivity', width: 150 },
                    { text: 'Descripción', dataField: 'dataDescriptionActivity', width: 295 },
                    { text: 'Val.#', dataField: 'dataValueActivity', width: 50 },
                    { text: 'Val.%', dataField: 'dataValueActivityPercent', width: 50 }
                ]
            }); 
            $("#tableRegisterActivities").jqxGrid('unselectRow', 0);
            $("#tableRegisterActivities").jqxGrid('clearSelection');
        }
        $('#jqxWindowAddActivities').on('close', function (event) { 
            $("#name_activity").val("");
            $("#activity_description").val("");
            $('#value_activity').off('change');
        }); 
        function loadTableRegisterActivitiesHistory(dataAdapter){
            $("#tableRegisterActivitiesHistory").jqxDataTable({
                width: 585,
                height:350,
                selectionMode: "multipleRows",
                enableHover: false,
                localization: getLocalization("es"),
                source: dataAdapter,
                pageable: true,
                editable: false,
                filterable: false,
                showToolbar: true,
                altRows: true,
                pagerButtonsCount: 10,
                toolbarHeight: 35,
                renderToolbar: function(toolBar){
                    var theme = "";
                    var toTheme = function (className) {
                        if (theme === "") return className;
                        return className + " " + className + "-" + theme;
                    };
                    // appends buttons to the status bar.
                    itemPeriod = $('#valorateActivitiesPeriodHistoryFilter').jqxListBox('getSelectedItem');
                    var period = itemPeriod.label;
                    
                    var container = $("<div style='overflow: hidden; position: relative; height: 100%; width: 100%;'></div>");
                    var textTitle = $("<div style='position: relative; width: 20px; float: left; color: white; padding: 6px; font-weight: bold;' id='period'></div>");
                    var buttonTemplate = "<div style='float: left; padding: 3px; margin: 2px;'><div style='margin: 4px; width: 16px; height: 16px;'></div></div>";
                    var importItem = $(buttonTemplate);
                    var importAll = $(buttonTemplate);
                    var infoButton = $(buttonTemplate);
          
                    container.append(infoButton);
                    container.append(importItem);
                    container.append(importAll);
                    container.append(textTitle);
                    toolBar.append(container);
                    
                    infoButton.jqxButton({ cursor: "pointer", disabled: false, enableDefault: false,  height: 25, width: 25 });
                    infoButton.find('div:first').addClass(toTheme('jqx-icon-help'));
                    infoButton.css({"float":"right","cursor":"pointer"});
                    infoButton.jqxTooltip({ position: 'bottom', content: "Ayuda"});
                    
                    importItem.jqxButton({ cursor: "pointer", disabled: true,  height: 20, width: 25 });
                    importItem.find('div:first').addClass(toTheme('jqx-icon-import-item'));
                    importItem.css({"float":"right","cursor":"pointer"});
                    importItem.jqxTooltip({ position: 'bottom', content: "Importar selección"});
                    
                    
                    importAll.jqxButton({ cursor: "pointer", disabled: false,  height: 20, width: 25 });
                    importAll.find('div:first').addClass(toTheme('jqx-icon-import-all'));
                    importAll.css({"float":"right","cursor":"pointer"});
                    importAll.jqxTooltip({ position: 'bottom', content: "Importar todo"});
                                       
                    
                    $("#period").text("PERIODO: "+period);
                    var updateButtons = function (action) {
                        switch (action) {
                            case "Select":
                                importItem.jqxButton({disabled: false});
                                break;
                            case "Unselect":
                                importItem.jqxButton({disabled: true});
                                break;
                        }
                    };
                    var rowIndex = null;
                    var rowId = null;
                    var rowData = null;
                    $("#tableRegisterActivitiesHistory").on('rowSelect', function (event) {
                        var args = event.args;
                        rowIndex = args.index;
                        rowId=args.row;
                        rowId=rowId.id;
                        rowData=args.row;
                        updateButtons('Select');
                    });
                    $("#tableRegisterActivitiesHistory").on('rowUnselect', function (event) {
                        updateButtons('Unselect');
                    });
                    $("#tableRegisterActivitiesHistory").on('rowEndEdit', function (event) {
                        updateButtons('End Edit');
                    });
                    $("#tableRegisterActivitiesHistory").on('rowBeginEdit', function (event) {
                        updateButtons('Edit');
                    });
                    infoButton.click(function () {
                        if (!infoButton.jqxButton('disabled')){
                            //$(".alert").removeClass("alert-success").addClass("alert-warning");
                            //$(".alert").hide();
                            $(".alert").fadeIn("slow");
                            indicationsImpor = "La tabla de titulo periodo contiene los\n\
                                                grupos de actividades que \n\
                                                ya  fueron planeadas en periodos pasados. Puedes \n\
                                                importar todo el grupo de actividades o bien solo alguna \n\
                                                de ellas, pero debes de considerar que al importar al grupo \n\
                                                a las nuevas actividades el progreso será remplazado y no podrá ser recuperado.";
                            $("#indicationsx").text(indicationsImpor);
                            updateButtons('infoButton');
                        }
                    });
                    
                    importItem.click(function (){
                        var dataExternal;
                        var selection = $("#tableRegisterActivitiesHistory").jqxDataTable('getSelection');
                        for (var i = 0; i < selection.length; i++) {
                            // get a selected row.
                            var rowData = selection[i];
                            $("#tableRegisterActivitiesHistory").jqxDataTable('unselectRow', rowData.index);
                            $.ajax({
                                //Send the paramethers to servelt
                                type: "POST",
                                async: false,
                                url: "../serviceActivities?insertImported",
                                data:{
                                    "pkWorkPlanning": $("#pkWorkPlannig").val(), 
                                    "pkActivity": rowData.id
                                },
                                beforeSend: function (xhr) {
                                },
                                error: function (jqXHR, textStatus, errorThrown) {
                                    //This is if exits an error with the server internal can do server off, or page not found
                                    alert("Error interno del servidor");
                                },
                                success: function (data, textStatus, jqXHR) {
                                    dataExternal = data;
                                    if(data==="fail"){
                                        $("#titleOk").text("Denegado");
                                        $("#pictureOk").removeClass("ok").addClass("fail");
                                        $("#messageOk").text("No debes de pasar del valor establecido por cada saber.");
                                        $("#jqxWindowOk").jqxWindow({height: 130,width: 350}); 
                                        $("#jqxWindowOk").jqxWindow('open');
                                    }else if(data==="blocked"){
                                        $("#titleOk").text("Denegado");
                                        $("#pictureOk").removeClass("ok").addClass("fail");
                                        $("#messageOk").text("No puede realizar cambios miestras las actividades estan bloqueadas.");
                                        $("#jqxWindowOk").jqxWindow({height: 130,width: 350}); 
                                        $("#jqxWindowOk").jqxWindow('open');
                                    }
                                }
                            });
                        } 
                        if(dataExternal!=="fail"&&dataExternal!=="blocked"){
                           existWorkPlanning();  
                        }
                    });
                    importAll.click(function (){
                        $("#tableRegisterActivitiesHistory").jqxDataTable('selectRow', 0);
                        var selection = $("#tableRegisterActivitiesHistory").jqxDataTable('getSelection');
                        for (var i = 0; i < selection.length; i++) {
                            // get a selected row.
                            var rowData = selection[i];
                        }
                        $.ajax({
                            //Send the paramethers to servelt
                            type: "POST",
                            async: false,
                            url: "../serviceActivities?insertImportedAll",
                            data:{
                                "pkWorkPlanningNew": $("#pkWorkPlannig").val(), 
                                "pkWorkPlanningOld": rowData.dataPkWorkPlanning
                            },
                            beforeSend: function (xhr) {
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                //This is if exits an error with the server internal can do server off, or page not found
                                alert("Error interno del servidor");
                            },
                            success: function (data, textStatus, jqXHR) {
                                if(data==="blocked"){
                                    $("#titleOk").text("Denegado");
                                    $("#pictureOk").removeClass("ok").addClass("fail");
                                    $("#messageOk").text("No puede realizar cambios miestras las actividades estan bloqueadas.");
                                    $("#jqxWindowOk").jqxWindow({height: 130,width: 350}); 
                                    $("#jqxWindowOk").jqxWindow('open');
                                }else{
                                    existWorkPlanning();   
                                }
                            }
                        });
                        $("#tableRegisterActivitiesHistory").jqxDataTable('clearSelection');
                    });
                },
                ready: function(){
                    
                },
                columns: [
                    { text: 'NP',filterable: false, editable: false, dataField: 'dataProgresivNumber', width: 25 },
                    { text: 'Actividad', dataField: 'dataNameActivity', width: 180 },
                    { text: 'Descripción', dataField: 'dataDescriptionActivity' },
                    { text: 'Val.#', dataField: 'dataValueActivity', width: 50 },
                    { text: 'Val.%', dataField: 'dataValueActivityPercent', width: 50 }
                ]
            }); 
            $("#tableRegisterActivities").jqxGrid('unselectRow', 0);
            $("#tableRegisterActivities").jqxGrid('clearSelection');
        }
        
        $("#ok").click(function (){ 
            if($("#titleOk").text()==="Denegado"){
                $("#jqxWindowOk").jqxWindow('close');
            }else{
                $("#jqxWindowOk").jqxWindow('close');
                existWorkPlanning(); 
            }
        }); 
        $("#okAdd").click(function (){
            var url="../serviceActivities";
            if($(this).val()==="Agregar"){
                url = "../serviceActivities?insert";
            }else{
                url = "../serviceActivities?update&&pkActivity="+$("#pkActivity").val();
            }
            if(($("#name_activity").val()!=="")&&($("#value_activity").val()>=0.01)){
                $("#name_activity").removeClass("error");
                $.ajax({
                    //Send the paramethers to servelt
                    type: "POST",
                    async: false,
                    url: url,
                    data:{
                        "pkWorkPlanning": $("#pkWorkPlannig").val(), 
                        "pkScaleEvaluation": itemScaleEvaluation.value,
                        "nameActivity": $("#name_activity").val(),
                        "valueActivity": convertionInverseToFix($("#value_activity").val()),
                        "descriptionActivity": $("#activity_description").val()
                    },
                    beforeSend: function (xhr) {
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        //This is if exits an error with the server internal can do server off, or page not found
                        alert("Error interno del servidor");
                    },
                    success: function (data, textStatus, jqXHR) {
                        $("#jqxWindowAddActivities").jqxWindow('close');
                        existWorkPlanning();     
                    }
                });
            }else{
                if($("#name_activity").val()!=="0"){
                    $("#name_activity").removeClass("error");
                }else{
                    $("#name_activity").addClass("error");
                }
            }
        });
        $('#value_activity').jqxSlider({
            theme:"",
            width:"450px",
            height:"10px",
            mode:'fixed',
            max: 100,
            tooltip: true,
            tooltipPosition: "far",
            step:1,
            ticksFrequency: 10,
            showTickLabels: true,
            ticksPosition:'bottom',
            tickLabelFormatFunction: function (value) {
                return value+"%";
            },
            tooltipFormatFunction: function(value){
                return value+"%";
            }
        });        
        $("#name_activity").jqxInput({theme: theme, placeHolder: "Nombre de la actividad", height: 28, width: 200, minLength: 1});
        $("#value_activity, #name_activity").css("display","inline-flex");
        $('#jqxWindowAddActivities').jqxWindow({
            theme: theme,
            height: 350,
            width: 500,
            animationType: 'slide',
            resizable: false,
            draggable: true,
            position: 'center',
            autoOpen: false,
            isModal: true,
            modalOpacity: 0.1,
            cancelButton: $('#cancelAdd'),
            initContent: function () {
                $('#okAdd').jqxButton({
                    width: '80px',
                    theme: theme
                });
                $('#cancelAdd').jqxButton({
                    width: '80px',
                    theme: theme
                });
                $('#okAdd').focus();
            }
        });
        $('#jqxWindowAddObservations').jqxWindow({
            theme: theme,
            height: 190,
            width: 300,
            resizable: false,
            draggable: true,
            position: 'center',
            autoOpen: false,
            isModal: true,
            modalOpacity: 0.5,
            okButton: $('#okObservations'),
            initContent: function () {
                $('#okObservations').jqxButton({
                    width: '80px',
                    theme: theme
                });
                $('#observations').focus();
            }
        });
        $("#observations").focusout(function (){
            itemLevel = $('#valorateActivitiesLevelFilter').jqxDropDownList('getSelectedItem');
            itemSubjectMatter=$('#valorateActivitiesSubjectMatterFilter').jqxDropDownList('getSelectedItem');
            itemPeriod = $('#valorateActivitiesPeriodFilter').jqxDropDownList('getSelectedItem');
            $.ajax({
                url: "../serviceActivities?setObservations",
                data: {"fkMatter": itemSubjectMatter.value, "fkPeriod": itemPeriod.value, "fkStudyLevel":itemLevel.value, "flObservations": $(this).val() },
                type: 'POST',
                beforeSend: function (xhr) {
                },
                success: function (data, textStatus, jqXHR) {
                    observations = $('#observations').val();
                },
                error: function (jqXHR, textStatus, errorThrown) {
                                    
                }
            });
        });
        $(".close").click(function (){
           $(this).parent().fadeOut(); 
        });
                
        var addWorkPlannin = $("#addWorkPlannin");
        addWorkPlannin.jqxTooltip({ position: 'bottom', content: "Agregar tabla de actividades"});
        addWorkPlannin.jqxButton({"height": 20, "width": 20, cursor: "pointer"});
        
        var addWorkPlannin = $("#importWorkPlanninHitory");
        //addWorkPlannin.jqxTooltip({ position: 'left', content: "Importar grupo de actividades"});
        addWorkPlannin.jqxButton({"height": 20, "width": 20, cursor: "pointer"});
        
        var switchClick = 0;
        $("#importWorkPlanninHitory").click(function (){
            switchClick = switchClick+1;
            $("#contentTRegisterActivitiesHistory").animate({ "width": "0px" }, "slow");
            $("#divHistory").fadeOut("slow");
            $("#contentHistoryPeriods").animate({height: "toggle", width: "toggle"}, 500);
            if(switchClick % 2 === 0){
                $("#valorateActivitiesLevelFilter").jqxDropDownList({ disabled: false }); 
                $("#valorateActivitiesCareerFilter").jqxDropDownList({ disabled: false });
                $("#valorateActivitiesSemesterFilter").jqxDropDownList({ disabled: false }); 
                $("#valorateActivitiesSubjectMatterFilter").jqxDropDownList({ disabled: false });
                $("#valorateActivitiesScaleEvaluationFilter").jqxDropDownList({ disabled: false });
                $('#jqxSplitter').jqxSplitter('expand');
                switchClick=0;
            }else{
                $("#valorateActivitiesLevelFilter").jqxDropDownList({ disabled: true }); 
                $("#valorateActivitiesCareerFilter").jqxDropDownList({ disabled: true }); 
                $("#valorateActivitiesSemesterFilter").jqxDropDownList({ disabled: true }); 
                $("#valorateActivitiesSubjectMatterFilter").jqxDropDownList({ disabled: true }); 
                $("#valorateActivitiesScaleEvaluationFilter").jqxDropDownList({ disabled: true });
            }       
        });
        
        
        $("#name_activity").focusout(function(){
            if($(this).val()!==""){
                $(this).removeClass("error");
            }else{
                $(this).focus();
                $(this).addClass("error");
            }
        });
        $("#name_activity").keyup(function(){
            if($(this).val()!==""){
                $(this).removeClass("error");
            }else{
                $(this).focus();
                $(this).addClass("error");
            }
        });
        function convertionInverseToFix(value){
            //console.log(value+"--"+max_value);
            return (((value/10)*maxValScale())/10).toFixed(2);
        }
    });
</script>
<div id='jqxWindowAddActivities' style="display: none">
    <div id="titleAddActivities">Nuevo</div>
    <div>
        <span style="color: olive; width: 100%; position: absolute;">
            <f  orm>
                <input type="hidden" id="pkActivity"/>
                <div class="form-group col-xs-5 input-prepend">
                    <label class="label-row" for="name_activity">Actividad</label><br>
                    <span style="height: 20px" class="add-on"><i class="icon-certificate"></i></span> 
                    <input type="text" id="name_activity" name="name_activity"/>
                </div>
                <br>
                <div class="form-group col-xs-5 input-prepend" style="width: 200px">
                    <label class="label-row" for="value_activity">Valor</label><br> 
                    <div id="value_activity" name="value_activity"></div>
                </div>
                <img id="pictureAddActivities" src="../content/pictures-system/add-activity.png" style="position: absolute; right: 30px; top: 10px;"/>
                <div class="form-group col-xs-12 input-prepend">
                    <label class="label-row" for="activity_description">Descripción</label><br>
                    <textarea id="activity_description" style="resize: none; width: 450px" class="form-control" rows="2"></textarea>
                </div>
            </form>
        </span>
        <div style="float: right; bottom: 10px; right: 20px;  position: absolute;">
            <input type="button" id="okAdd" value="Agregar" style="margin-right: 10px" />
            <input type="button" id="cancelAdd" value="Cancelar" />
        </div>
    </div>
</div>
<div id='jqxWindowAddObservations' style="display: none">
    <div id="title">Observaciones</div>
    <div>
        <div>
            <textarea  id="observations" style="margin: 3px; width: 270px; height: 100px; resize: none;" placeholder="Escriba aquí sus observaciones..."></textarea>
        </div>
        <div style="float: right; bottom: 10px; right: 20px;  position: absolute;">
            <input type="button" id="okObservations" value="Aceptar" style="margin-right: 10px" />
        </div>
    </div>
</div>
<div style="float: left; margin-right: 5px;">
    Nivel de estudio<br>
    <div id='valorateActivitiesLevelFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Carrera <br>
    <div id='valorateActivitiesCareerFilter'></div>
</div>
<div style="float: right; margin-right: 5px;">
    Importar<br>
    <div id="importWorkPlanninHitory" style="height: 28px; margin-left: 15px;">
        <div class="jqx-icon-import" style="height: 20px; width: 20px;"></div>
    </div>
</div>
<div id="contentHistoryPeriods" style="display: none; float: right; right: 100px; position: absolute; z-index: 10000;">
    Periodo historial <br>
    <div id='valorateActivitiesPeriodHistoryFilter'></div>
</div>
<div style="float: right; margin-right: 5px; display: none">
    Periodo <br>
    <div id='valorateActivitiesPeriodFilter'></div>
</div>
<br><br><br>
<div style="float: left; margin-right: 5px;">
    Cuatrimestre<br>
    <div id='valorateActivitiesSemesterFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Materia<br>
    <div id='valorateActivitiesSubjectMatterFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Saber<br>
    <input type="hidden" id="pkWorkPlannig"/>
    <div id='valorateActivitiesScaleEvaluationFilter'></div>
</div>
<div style="display: none; float: left; margin-right: 5px; text-align: center;">
    Valor<br>
    <div id='valMaxScale' style="font-size: 23px;"></div>
</div>
<div style="float: left; margin-right: 5px;">
    <br>
    <div id="addWorkPlannin" style="height: 28px; display: none">
        <div class="jqx-icon-list" style="height: 20px; width: 20px;"></div>
    </div>
</div>
<br><br><br><br><br>
<div id="divHistory" style="float: left; display: none">
    <div id="contentTRegisterActivitiesHistory" style="margin-right: 10px">
        <div id="tableRegisterActivitiesHistory"></div>
    </div>
</div>
<div id="moveRight" style="float: left; margin-right: 5px;">
    <div id="contentTRegisterActivities">
        <div id="tableRegisterActivities"></div>
    </div>
</div>
<div style="width: 450px; margin-right: 5px; display: none">
    <div class="alert alert-success alert-dismissible" role="alert">
        <button type="button" class="close" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <div id="indicationsx"></div>
    </div>
</div>
<div id="block-activities" style="display: none; height: 160px; width: 450px; display: none; background: #898989; opacity: .3; top: 66px; position: relative; z-index: 100000"></div>