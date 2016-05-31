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
(function ($) {
    $.fn.extend({
    // With every keystroke capitalize first letter of ALL words in the text
    upperFirstAll: function() {
        $(this).keyup(function(event) {
            var box = event.target;
            var txt = $(this).val();
            var start = box.selectionStart;
            var end = box.selectionEnd;

            $(this).val(txt.toLowerCase().replace(/^(.)|(\s|\-)(.)/g,
            function(c) {
                return c.toUpperCase();
            }));
            box.setSelectionRange(start, end);
        });
        $(this).focusout(function(event) {
            var box = event.target;
            var txt = $(this).val();
            var start = box.selectionStart;
            var end = box.selectionEnd;

            $(this).val(txt.toLowerCase().replace(/^(.)|(\s|\-)(.)/g,
            function(c) {
                return c.toUpperCase();
            }));
            box.setSelectionRange(start, end);
        });
        return this;
    },

    // With every keystroke capitalize first letter of the FIRST word in the text
    upperFirst: function() {
        $(this).keyup(function(event) {
            var box = event.target;
            var txt = $(this).val();
            var start = box.selectionStart;
            var end = box.selectionEnd;

            $(this).val(txt.toLowerCase().replace(/^(.)/g,
            function(c) {
                return c.toUpperCase();
            }));
            box.setSelectionRange(start, end);
        });
        return this;
    },

    // Converts with every keystroke the hole text to lowercase
    lowerCase: function() {
        $(this).keyup(function(event) {
            var box = event.target;
            var txt = $(this).val();
            var start = box.selectionStart;
            var end = box.selectionEnd;

            $(this).val(txt.toLowerCase());
            box.setSelectionRange(start, end);
        });
        return this;
    },

    // Converts with every keystroke the hole text to uppercase
    upperCase: function() {
        $(this).keyup(function(event) {
            var box = event.target;
            var txt = $(this).val();
            var start = box.selectionStart;
            var end = box.selectionEnd;

            $(this).val(txt.toUpperCase());
            box.setSelectionRange(start, end);
        });
        return this;
    }

    });
}(jQuery));
</script>
<script>
    $(document).ready(function () {
        var indications = "";
        var observations = "";
        var printDate = "";
        var indicationsImpor = "";
        var itemLevel = 0;
        var itemCareer = 0;
        var itemPeriod = 0;
        var itemScaleEvaluation = 0;
        var itemSemester = 0;
        var itemSubjectMatter = 0;
        createDropDownPeriod("comboActiveYear","#valorateActivitiesPeriodFilter");
        itemPeriod = $('#valorateActivitiesPeriodFilter').jqxDropDownList('getSelectedItem');
        if(itemPeriod!=null || itemPeriod!=undefined){
            createDropDownStudyLevelByTeacher("#valorateActivitiesLevelFilter",false);
            itemLevel = $('#valorateActivitiesLevelFilter').jqxDropDownList('getSelectedItem');
            if(itemLevel!=null || itemLevel!=undefined){
                createDropDownCareerByTeacher( itemLevel.value ,"#valorateActivitiesCareerFilter",false);
                itemCareer = $('#valorateActivitiesCareerFilter').jqxDropDownList('getSelectedItem');                
                if(itemCareer!=null || itemCareer!=undefined){
                    createDropDownSemesterByTeacher(itemPeriod.value, itemCareer.value, itemLevel.value,"#valorateActivitiesSemesterFilter",false);
                    itemSemester = $('#valorateActivitiesSemesterFilter').jqxDropDownList('getSelectedItem');
                    if(itemSemester!=null || itemSemester!=undefined){
                        createDropDownSubjectMatterByTeacher(itemPeriod.value, itemCareer.value, itemSemester.value, null, "#valorateActivitiesSubjectMatterFilter", false);
                        itemSubjectMatter=$('#valorateActivitiesSubjectMatterFilter').jqxDropDownList('getSelectedItem');
                        if(itemSubjectMatter!=null || itemSubjectMatter!=undefined){
                            createDropDownScaleEvaluation("#valorateActivitiesScaleEvaluationFilter",itemLevel.value,false);
                            itemScaleEvaluation = $('#valorateActivitiesScaleEvaluationFilter').jqxDropDownList('getSelectedItem');
                            if(itemScaleEvaluation!=null || itemScaleEvaluation!=undefined){
                                createLitsBoxPeriodByTeacher(itemCareer.value, itemSemester.value, itemSubjectMatter.value, itemScaleEvaluation.value, "#valorateActivitiesPeriodHistoryFilter");
                                
                                existWorkPlanning();
                            }
                        }else{
                            createDropDownScaleEvaluation("#valorateActivitiesScaleEvaluationFilter",null, false);
                            createLitsBoxPeriodByTeacher(null, null, null, null, "#valorateActivitiesPeriodHistoryFilter");
                            $("#addWorkPlannin").hide();
                            $(".close").parent().hide(); 
                        }                        
                    }else{
                        createDropDownSubjectMatterByTeacher(null, null, null, null, "#valorateActivitiesSubjectMatterFilter", false);
                        
                    }
                    
                }else{                    
                    createDropDownSemesterByTeacher(null, null, null,"#valorateActivitiesSemesterFilter",false);
                    createDropDownSubjectMatterByTeacher(null, null, null, null, "#valorateActivitiesSubjectMatterFilter", false);
                    createDropDownScaleEvaluation("#valorateActivitiesScaleEvaluationFilter",null, false);
                    createLitsBoxPeriodByTeacher(null, null, null, null, "#valorateActivitiesPeriodHistoryFilter");
                    $("#addWorkPlannin").hide();
                    $(".close").parent().hide(); 
                }
            }else{                
                createDropDownCareerByTeacher(null ,"#valorateActivitiesCareerFilter",false);
                createDropDownSemesterByTeacher(null, null, null,"#valorateActivitiesSemesterFilter",false);
                createDropDownSubjectMatterByTeacher(null, null, null, null, "#valorateActivitiesSubjectMatterFilter", false);
                createDropDownScaleEvaluation("#valorateActivitiesScaleEvaluationFilter",null, false);
                createLitsBoxPeriodByTeacher(null, null, null, null, "#valorateActivitiesPeriodHistoryFilter");
                $("#addWorkPlannin").hide();
                $(".close").parent().hide(); 
            }
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
                    createDropDownSemesterByTeacher(itemPeriod.value, itemCareer.value, itemLevel.value,"#valorateActivitiesSemesterFilter", true);                    
                }
            });
            $('#valorateActivitiesPeriodFilter').on('change',function (event){   
                var args = event.args;
                if(args){
                    itemCareer = $('#valorateActivitiesCareerFilter').jqxDropDownList('getSelectedItem');
                    itemPeriod = $('#valorateActivitiesPeriodFilter').jqxDropDownList('getSelectedItem');
                    itemLevel = $('#valorateActivitiesLevelFilter').jqxDropDownList('getSelectedItem');
                    itemScaleEvaluation = $('#valorateActivitiesScaleEvaluationFilter').jqxDropDownList('getSelectedItem');
                    createDropDownSemesterByTeacher(itemPeriod.value, itemCareer.value, itemLevel.value,"#valorateActivitiesSemesterFilter", true);
                    itemSemester = $('#valorateActivitiesSemesterFilter').jqxDropDownList('getSelectedItem');
                    var pkSemester=0;
                    if(itemSemester!==null){
                        pkSemester = itemSemester.value;
                    }
                    createDropDownSubjectMatterByTeacher(itemPeriod.value, itemCareer.value, pkSemester, null, "#valorateActivitiesSubjectMatterFilter", true);
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
        }else{
            $("#addWorkPlannin").hide();
            $(".close").parent().hide(); 
            createDropDownStudyLevelByTeacher("#valorateActivitiesLevelFilter",false);
            createDropDownCareerByTeacher(null ,"#valorateActivitiesCareerFilter",false);
            createDropDownPeriod("comboActiveYear","#valorateActivitiesPeriodFilter");
            createDropDownSemesterByTeacher(null, null, null,"#valorateActivitiesSemesterFilter",false);
            createDropDownSubjectMatterByTeacher(null, null, null, null, "#valorateActivitiesSubjectMatterFilter", false);
            createDropDownScaleEvaluation("#valorateActivitiesScaleEvaluationFilter",null, false);
            createLitsBoxPeriodByTeacher(null, null, null, null, "#valorateActivitiesPeriodHistoryFilter");
        }
        var varMaxValScale=0;
        function maxValScale(){  
            itemScaleEvaluation = $('#valorateActivitiesScaleEvaluationFilter').jqxDropDownList('getSelectedItem');
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
                        varMaxValScale = parseFloat(data[0].dataMaxValue);
                    }
                });
            }
            return varMaxValScale;
        }     
        maxValScale();
        function existWorkPlanning(){
            var exist=false;
            itemPeriod = $('#valorateActivitiesPeriodFilter').jqxDropDownList('getSelectedItem');
            itemLevel = $('#valorateActivitiesLevelFilter').jqxDropDownList('getSelectedItem');
            itemSemester = $('#valorateActivitiesSemesterFilter').jqxDropDownList('getSelectedItem');
            itemSubjectMatter=$('#valorateActivitiesSubjectMatterFilter').jqxDropDownList('getSelectedItem');
            itemScaleEvaluation = $('#valorateActivitiesScaleEvaluationFilter').jqxDropDownList('getSelectedItem');
            //alert();
            if(itemScaleEvaluation!==undefined){
                maxValScale();
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
                            printDate = data.dataPrintDate;
                            $("#addWorkPlannin").parent().fadeOut("slow");
                            $("#addWorkPlannin").show();
                            $("#contentTRegisterActivities").fadeIn("slow");
                            $(".close").parent().fadeIn("slow"); 
                            $("#pkWorkPlannig").val(data.dataPkWorkPlanning);
                            $("#indications").text(indications);
                            $(".calendarInput").val(printDate);
                            var dataAdapter = new $.jqx.dataAdapter(loadSource("today"));
                            loadTableRegisterActivities(dataAdapter, data);                            
                            exist=true;
                        }else{
                            $("#addWorkPlannin").parent().fadeIn("slow");
                            $("#addWorkPlannin").show();
                            $("#contentTRegisterActivities").fadeOut("slow");
                            $(".close").parent().fadeOut("slow"); 
                        }
                    }
                });
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
                        existWorkPlanning();
                    }
                }
            });
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
                datafields: [
                    { name: 'dataPkActivity', type:'int'},
                    { name: 'dataProgresivNumber', type:'int'},
                    { name: 'dataNumActivity', type: 'string' },
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
                }
            };
            return ordersSource;
        }
        var max_value_disponibility=0;
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
                        max_value_disponibility=parseFloat(data.dataResult);
                        status=true;
                    }else{
                        max_value_disponibility=0;
                        status=false;
                    }
                }
            });
            return status;
        }
        var container = $("<div class='container' style='overflow: hidden; position: relative; height: 100%; width: 100%;'></div>");
        var buttonTemplate = "<div style='float: left; padding: 3px; margin: 2px;'><div style='margin: 4px; width: 16px; height: 16px;'></div></div>";
        var addButton = $(buttonTemplate);
        var editButton = $(buttonTemplate);
        var deleteButton = $(buttonTemplate);
        var lockButton = $(buttonTemplate);
        var unlockButton = $(buttonTemplate);
        var dateContent = $('<div style="float: right; margin-top: 2px; margin-right: 2px;"><div class="calendarInput" id="datePrint" ></div></div>');
        var settingsButton = $(buttonTemplate);
        var showButton = $(buttonTemplate);
        var shareButton = $(buttonTemplate);
        var importButton = $(buttonTemplate);
        var exportButton = $(buttonTemplate);
        var infoButton = $(buttonTemplate);
        var rowIndexUnselect = null;
        var rowIndex = null;
        var rowId = null;
        var rowData = null;
        
        //Tiene un evento que se almacena conforme cambias de pagina por lo que hace cargas por cada ves que hay un click anidado
        function loadTableRegisterActivities(dataAdapter, metadata){            
            $("#tableRegisterActivities").jqxGrid({
                width: 590,
                height:350,
                selectionmode: "singlerow",
                localization: getLocalization("es"),
                source: dataAdapter,
                pageable: true,
                editable: false,
                filterable: false,
                showtoolbar: true,
                showstatusbar: true,
                altrows: false,
                autorowheight: true,
                pagerbuttonscount: 5,
                toolbarheight: 35,
                statusbarheight: 45,
                rendertoolbar: function(toolBar){
                    addButton.off("click");
                    editButton.off("click");
                    deleteButton.off("click");
                    lockButton.off("click");
                    unlockButton.off("click");
//                    settingsButton.off("click");
                    showButton.off("click");
                    exportButton.off("click");
                    infoButton.off("click");
                    $("#tableRegisterActivities").jqxGrid('clearselection');
                    $("#tableRegisterActivities").off('rowselect');
                    $("#tableRegisterActivities").off('rowunselect');
                    var themeRenderToolbar = "";
                    var toTheme = function (className) {
                        if (themeRenderToolbar === "") return className;
                        return className + " " + className + "-" + themeRenderToolbar;
                    };
                    // appends buttons to the status bar.
                    
                    
                    
                    if($(".container").length==0){
                        addButton.hide();
                        editButton.hide();
                        deleteButton.hide();
                        lockButton.hide();
                        unlockButton.hide();
                        exportButton.hide();
                        container.append(addButton);
                        container.append(lockButton);
                        container.append(unlockButton);
                        container.append(editButton);
                        container.append(deleteButton);
                        container.append(exportButton);

                        //container.append(infoButton);
//                        container.append(shareButton);
                        
                        container.append(showButton); 
//                        container.append(importButton);  
                        container.append(settingsButton);  
                        container.append(dateContent);  
                        toolBar.append(container);
                        
                        addButton.jqxButton({cursor: "pointer", enableDefault: true,  height: 25, width: 25 });
                        addButton.find('div:first').addClass(toTheme('jqx-icon-plus'));
                        addButton.jqxTooltip({ position: 'bottom', content: "Agregar"});

                        unlockButton.jqxButton({cursor: "pointer", enableDefault: true,  height: 25, width: 25 });
                        unlockButton.find('div:first').addClass(toTheme('jqx-icon-unlock'));
                        unlockButton.jqxTooltip({ position: 'bottom', content: "Abrir actividades"});

                        lockButton.jqxButton({cursor: "pointer", enableDefault: true,  height: 25, width: 25 });
                        lockButton.find('div:first').addClass(toTheme('jqx-icon-lock'));
                        lockButton.jqxTooltip({ position: 'bottom', content: "Cerrar actividades"});

                        editButton.jqxButton({ cursor: "pointer", disabled: true, enableDefault: true,  height: 25, width: 25 });
                        editButton.find('div:first').addClass(toTheme('jqx-icon-edit'));
                        editButton.jqxTooltip({ position: 'bottom', content: "Editar"});

                        deleteButton.jqxButton({ cursor: "pointer", disabled: true, enableDefault: true,  height: 25, width: 25 });
                        deleteButton.find('div:first').addClass(toTheme('jqx-icon-delete'));
                        deleteButton.jqxTooltip({ position: 'bottom', content: "Eliminar"});

                        exportButton.jqxButton({cursor: "pointer", enableDefault: true,  height: 25, width: 25 });
                        exportButton.find('div:first').addClass(toTheme('jqx-icon-export'));
                        exportButton.jqxTooltip({ position: 'bottom', content: "Exportar a pdf"});
                        exportButton.attr("id","exportButton");

                        infoButton.jqxButton({ cursor: "pointer", disabled: false, enableDefault: true,  height: 25, width: 25 });
                        infoButton.find('div:first').addClass(toTheme('jqx-icon-info'));
                        infoButton.css({"float":"right","cursor":"pointer"});
                        infoButton.jqxTooltip({ position: 'bottom', content: "Información"});

                        showButton.jqxButton({ cursor: "pointer", disabled: false, enableDefault: true,  height: 25, width: 25 });
                        showButton.find('div:first').addClass(toTheme('jqx-icon-show'));
                        showButton.css({"float":"right","cursor":"pointer"});
                        showButton.jqxTooltip({ position: 'bottom', content: "Agregar observaciones"});
                        showButton.attr("id","showButton");   
                        
                        settingsButton.jqxButton({ cursor: "pointer", disabled: false, enableDefault: true,  height: 25, width: 25 });
                        settingsButton.find('div:first').addClass(toTheme('jqx-icon-settings'));
                        settingsButton.css({"float":"right","cursor":"pointer"});
                        settingsButton.jqxTooltip({ position: 'bottom', content: "Ajustes"});
                        settingsButton.attr("id","settingsButton");
                        
                        importButton.jqxButton({ cursor: "pointer", disabled: false, enableDefault: true,  height: 25, width: 25 });
                        importButton.find('div:first').addClass(toTheme('jqx-icon-down'));
                        importButton.css({"float":"right","cursor":"pointer"});
                        importButton.jqxTooltip({ position: 'bottom', content: "Compartido"});
                        importButton.attr("id","importButton");
                        
                        shareButton.jqxButton({ cursor: "pointer", disabled: false, enableDefault: true,  height: 25, width: 25 });
                        shareButton.find('div:first').addClass(toTheme('jqx-icon-import'));
                        shareButton.css({"float":"right","cursor":"pointer"});
                        shareButton.jqxTooltip({ position: 'bottom', content: "Compartir"});
                        shareButton.attr("id","shareButton");
                        
                        
                        $("#aliasBlock").jqxInput({placeHolder: "Criterios de la materia...", height: 25, width: 160, minLength: 1 });
                        $("#shareNow").jqxButton({ cursor: "pointer", disabled: false, enableDefault: true,  height: 25, width: 168 });
                        $("#shareNow").find('div:first').addClass(toTheme('jqx-icon-import'));
                        $("#shareNow").css({"cursor":"pointer"});
                        $("#shareNow").jqxTooltip({ position: 'bottom', content: "Compartir ahora"});
                        
                        $('.calendarInput').jqxDateTimeInput({culture: 'es-MX',formatString: "yyyy/MM/dd", theme: theme, width: '120px', height: '30px'});
                        $('.calendarInput').off('change');
                        $('.calendarInput').on('change', function (event) {
                            if(event.args){
                                $.ajax({
                                    url: "../serviceActivities?setPrintDate",
                                    data: {
                                        "fkMatter": itemSubjectMatter.value, 
                                        "fkPeriod": itemPeriod.value, 
                                        "fkStudyLevel":itemLevel.value, 
                                        "flPrintDate": $(this).val() 
                                    },
                                    type: 'POST',
                                    beforeSend: function (xhr) {
                                    },
                                    success: function (data, textStatus, jqXHR) {
                                    },
                                    error: function (jqXHR, textStatus, errorThrown) {

                                    }
                                });          
                            }
                        }); 
        
                        $("#popoverSettings").jqxPopover({
                            offset: {left: -50, top:0}, 
                            arrowOffsetValue: 50, 
                            title: "Ajustes", 
                            showCloseButton: true,
                            selector: settingsButton,
                            width: 150
                        });
                        
                        $("#popoverShare").jqxPopover({
                            offset: {left:0, top: 63}, 
                            arrowOffsetValue: -60, 
                            position: "right",
                            title: "Compartir", 
                            showCloseButton: true,
                            selector: shareButton,
                            width: 200
                        });
                        if(typeof (Storage) !=="undefined"){
                            if(localStorage.getItem("wayInput")==="typeInput"){                                
                                $("#typeInput").prop("checked", true);
                            }else{
                                $("#typeSlider").prop("checked", true);
                            }
                        }else{
                            $("#wayInput").prop("checked", true);
                        }
                        $("[name=wayInput]").off("change");
                        $("[name=wayInput]").change(function (){
                            if($(this).attr("id")==="typeInput"){
                                localStorage.setItem("wayInput", "typeInput"); 
                            }else{
                                localStorage.setItem("wayInput", "typeSlider");
                            }
                            $("#popoverSettings").jqxPopover('close');
                        });
                    }else{
                        addButton.jqxButton({ disabled: false });
                        deleteButton.jqxButton({ disabled: true });
                        editButton.jqxButton({ disabled: true });
                    }
                    if(metadata.dataRealized==="1"){
                        unlockButton.show();
                        if(metadata.dataRealizedBlock==="3"){
                            exportButton.show();
                        }else{
                            exportButton.hide();
                        }  
                        addButton.hide();
                        lockButton.hide();
                        deleteButton.hide();     
                        editButton.hide();
                        $("#tableRegisterActivities").jqxGrid({selectionMode: "none",enableHover: false});
                    }else{
                        $("#addWorkPlannin").fadeIn("slow");
                        $("#tableRegisterActivities").jqxGrid({enableHover: true});
                        unlockButton.hide();
                        exportButton.hide();
                        if(disponibilityValueByWorkPlanning()){
                            addButton.show();
                            lockButton.hide();
                            
                        }else{
                            addButton.hide();
                            lockButton.show();
                        }
                        deleteButton.show();
                        editButton.show();
                    }
                    
                    var updateButtons = function (action) {
                        switch (action) {
                            case "Select":
                                addButton.jqxButton({ disabled: false });
                                deleteButton.jqxButton({ disabled: false });
                                editButton.jqxButton({ disabled: false });
                                //updateButton.jqxButton({ disabled: true });
                            break;
                            case "Unselect":
                                if(rowIndex==rowIndexUnselect){
                                    addButton.jqxButton({ disabled: false });
                                    deleteButton.jqxButton({ disabled: true });
                                    editButton.jqxButton({ disabled: true });
                                    //updateButton.jqxButton({ disabled: true });
                                }
                            break;
                        }
                    }; 
                    $("#tableRegisterActivities").on('rowunselect', function (event) {
                        rowIndexUnselect=event.args.rowindex;
                        updateButtons('Unselect');
                    }); 
                    $("#tableRegisterActivities").on('rowselect', function (event) {
                        var args = event.args;
                        rowIndex = args.rowindex;   
                        rowData=args.row;
                        rowId=rowData.dataPkActivity;
                        updateButtons('Select');
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
                            $("#messageWarning").text("Recuerda... Una ves cerradas las actividades no podrán ser modificadas si es que alguna de ellas ya cuenta con algún registro de calificación.");
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
                            $("#name_activity").val("");
                            $("#activity_description").val("");
                            $("#titleAddActivities").text("Nuevo");
                            $("#okAdd").val("Agregar");
                            $("#pictureAddActivities").attr("src","../content/pictures-system/add-activity.png");
                            $('#jqxWindowAddActivities').jqxWindow({position: 'center'});
                            var val_max_scale = 0;                            
                            val_max_scale = max_value_disponibility;
                            var val_max_scale_percent = parseFloat(parseFloat((val_max_scale*100/varMaxValScale))).toFixed(2);
                            if(val_max_scale_percent==="100.00"){
                                val_max_scale_percent=100;
                            }
                            if($("#typeInput").is(":checked")){
                                $("#contentNumberInput").html('<div class="value_activity" id="value_activity" name="value_activity"></div>');
                                $("#value_activity").jqxNumberInput({ 
                                    width: '60px', 
                                    height: '25px', 
                                    inputMode: 'simple', 
                                    spinButtons: true,
                                    digits:1,
                                    min:0.01,
                                    max: val_max_scale
                                });
                                $('#value_activity').off('change');
                                $('#value_activity').on('change', function (event) {                                
                                    if(event.args){
                                        var value = event.args.value; 
                                        val_max_scale_percent = parseFloat(parseFloat((value*100/varMaxValScale))).toFixed(2);
                                        if(val_max_scale_percent==="100.00"){
                                            val_max_scale_percent=100;
                                        }
                                        $("#value_activity_percent").text(val_max_scale_percent+"%");
                                        $("#value_activity_label").text(value);
                                    }
                                });
                                $("#value_activity").val(val_max_scale);
                            }else{
                                var ticksFrequency = 0;
                                $("#contentNumberInput").html('<div class="value_activity" id="value_activity" name="value_activity"></div>');
                                if(varMaxValScale<=1){
                                    ticksFrequency=0.1;
                                }else{
                                    ticksFrequency=0.5;
                                }
                                $('#value_activity').jqxSlider({
                                    theme:"",
                                    width:"450px",
                                    height:"10px",
                                    mode:'fixed',
                                    tooltip: true,
                                    tooltipPosition: "far",
                                    step: 0.01,
                                    ticksFrequency: ticksFrequency,
                                    max: varMaxValScale,
                                    showTickLabels: true,
                                    ticksPosition:'bottom',
                                    tickLabelFormatFunction: function (value) {
                                        var splitFunction = (parseFloat(value).toFixed(2)).split(".");
                                        if(splitFunction[1]==="00"){
                                            return splitFunction[0];
                                        }else{
                                            return (parseFloat(value).toFixed(2));
                                        }
                                    },
                                    tooltipFormatFunction: function(value){
                                        var splitFunction = (parseFloat(value).toFixed(2)).split(".");
                                        if(splitFunction[1]==="00"){
                                            return splitFunction[0];
                                        }else{
                                            return (parseFloat(value).toFixed(2));
                                        }
                                    }
                                }); 
                                $('#value_activity').off('slide');
                                $('#value_activity').on('slide', function (event) {
                                    var value = event.args.value;                                    
                                    value = parseFloat(value).toFixed(2);
                                    if(value==0.00){
                                        $("#value_activity").val(0.01);
                                        value=0.01; 
                                    }else if(value>=val_max_scale){
                                        $("#value_activity").val(val_max_scale);  
                                        value=val_max_scale; 
                                    }
                                    var splitFunction = (""+value).split(".");
                                    if(splitFunction[1]==="00"){
                                        value = splitFunction[0];
                                    }else{
                                        value = (parseFloat(value).toFixed(2));
                                    } 
                                    val_max_scale_percent = parseFloat(parseFloat((value*100/varMaxValScale))).toFixed(2);
                                    if(val_max_scale_percent==="100.00"){
                                        val_max_scale_percent=100;
                                    }
                                    $("#value_activity_percent").text(val_max_scale_percent+"%"); 
                                    $("#value_activity_label").text(value);
                                });
                                $("#value_activity").val(val_max_scale);                                
                            }
                            $("#value_activity_percent").text(val_max_scale_percent+"%");
                            $("#value_activity_label").text(val_max_scale);
                            $("#jqxWindowAddActivities").jqxWindow('open');
                        }
                    });
                    
                    editButton.click(function () {
                        if (!editButton.jqxButton('disabled')) {
                            itemScaleEvaluation = $('#valorateActivitiesScaleEvaluationFilter').jqxDropDownList('getSelectedItem');
                            disponibilityValueByWorkPlanning();
                            $("#titleAddActivities").text("Actualizar");
                            $("#okAdd").val("Guardar");
                            $("#pkActivity").val(rowId);
                            $("#pictureAddActivities").attr("src","../content/pictures-system/update-activity.png");
                            $('#jqxWindowAddActivities').jqxWindow({position: 'center'});
                            var value_current = parseFloat(rowData.dataValueActivity);
                            var max_value_disponibility_temp = (parseFloat(rowData.dataValueActivity)+max_value_disponibility);
                            var val_max_scale_percent = parseFloat((parseFloat(rowData.dataValueActivity)*100/varMaxValScale)).toFixed(2);
                            if(val_max_scale_percent==="100.00"){
                                val_max_scale_percent=100;
                            }
                            
                            if($("#typeInput").is(":checked")){
                                $("#contentNumberInput").html('<div class="value_activity" id="value_activity" name="value_activity"></div>');
                                $("#value_activity").jqxNumberInput({ 
                                    width: '60px', 
                                    height: '25px', 
                                    inputMode: 'simple', 
                                    spinButtons: true,
                                    digits:1,
                                    min:0.01,
                                    max: max_value_disponibility_temp
                                });
                                $('#value_activity').off('change');
                                $('#value_activity').on('change', function (event) {                                
                                    if(event.args){
                                        var value = event.args.value; 
                                        val_max_scale_percent = parseFloat(parseFloat((value*100/varMaxValScale))).toFixed(2);
                                        if(val_max_scale_percent==="100.00"){
                                            val_max_scale_percent=100;
                                        }
                                        $("#value_activity_percent").text(val_max_scale_percent+"%");
                                        $("#value_activity_label").text(value);
                                    }
                                });
                                $("#value_activity").val(value_current);
                            }else{
                                var ticksFrequency = 0;
                                $("#contentNumberInput").html('<div class="value_activity" id="value_activity" name="value_activity"></div>');
                                if(varMaxValScale<=1){
                                    ticksFrequency=0.1;
                                }else{
                                    ticksFrequency=0.5;
                                }
                                $('#value_activity').jqxSlider({
                                    theme:"",
                                    width:"450px",
                                    height:"10px",
                                    mode:'fixed',
                                    tooltip: true,
                                    tooltipPosition: "far",
                                    step: 0.01,
                                    ticksFrequency: ticksFrequency,
                                    max: varMaxValScale,
                                    showTickLabels: true,
                                    ticksPosition:'bottom',
                                    tickLabelFormatFunction: function (value) {
                                        var splitFunction = (parseFloat(value).toFixed(2)).split(".");
                                        if(splitFunction[1]==="00"){
                                            return splitFunction[0];
                                        }else{
                                            return (parseFloat(value).toFixed(2));
                                        }
                                    },
                                    tooltipFormatFunction: function(value){
                                        var splitFunction = (parseFloat(value).toFixed(2)).split(".");
                                        if(splitFunction[1]==="00"){
                                            return splitFunction[0];
                                        }else{
                                            return (parseFloat(value).toFixed(2));
                                        }
                                    }
                                }); 
                                $('#value_activity').off('slide');
                                $('#value_activity').on('slide', function (event) {
                                    var value = event.args.value;                                    
                                    value = parseFloat(value).toFixed(2);
                                    if(value==0.00){
                                        $("#value_activity").val(0.01);
                                        value=0.01; 
                                    }else if(value>=max_value_disponibility_temp){
                                        $("#value_activity").val(max_value_disponibility_temp);  
                                        value=max_value_disponibility_temp; 
                                    }
                                    var splitFunction = (""+value).split(".");
                                    if(splitFunction[1]==="00"){
                                        value = splitFunction[0];
                                    }else{
                                        value = (parseFloat(value).toFixed(2));
                                    } 
                                    val_max_scale_percent = parseFloat(parseFloat((value*100/varMaxValScale))).toFixed(2);
                                    if(val_max_scale_percent==="100.00"){
                                        val_max_scale_percent=100;
                                    }
                                    $("#value_activity_percent").text(val_max_scale_percent+"%"); 
                                    $("#value_activity_label").text(value);
                                });
                                $("#value_activity").val(value_current);                                
                            }
                            
                            $("#value_activity").val(parseFloat(rowData.dataValueActivity));
                            $("#value_activity_percent").text(val_max_scale_percent+"%");
                            $("#value_activity_label").text(rowData.dataValueActivity);
                            $("#name_activity").val(rowData.dataNameActivity);                            
                            $("#activity_description").val(rowData.dataDescriptionActivity);
                            $("#name_activity").removeClass("error");
                            $("#activity_description").removeClass("error");
                            $("#jqxWindowAddActivities").jqxWindow('open');
                        }
                    });
                    
                    deleteButton.click(function () {
                        if (!deleteButton.jqxButton('disabled')){
                            $("#messageWarning").text("¡Estas seguro de borrar este registro!");
                            $("#iconWarning").removeClass("warning").addClass("trash");
                            $("#jqxWindowWarningActivities").jqxWindow('open');
                            $("#okWarning").off("click");
                            $("#okWarning").on("click",function (){
                                $.ajax({
                                    //Send the paramethers to servelt
                                    type: "POST",
                                    async: false,
                                    url: "../serviceActivities?delete",
                                    data:{
                                        'pkActivitiesToWork': rowId
                                    },
                                    beforeSend: function (xhr) {
                                    },
                                    error: function (jqXHR, textStatus, errorThrown) {
                                        //This is if exits an error with the server internal can do server off, or page not found
                                        alert("Error interno del servidor");
                                    },
                                    success: function (data, textStatus, jqXHR) {
                                        $("#jqxWindowWarningActivities").jqxWindow('close');
                                        existWorkPlanning();
                                    }
                                });
                            });
                            
                        }
                    });
                    exportButton.click(function (){
                        itemPeriod = $('#valorateActivitiesPeriodFilter').jqxDropDownList('getSelectedItem');
                        itemCareer = $('#valorateActivitiesCareerFilter').jqxDropDownList('getSelectedItem');
                        itemSubjectMatter= $('#valorateActivitiesSubjectMatterFilter').jqxDropDownList('getSelectedItem'); 
                        itemLevel = $('#valorateActivitiesLevelFilter').jqxDropDownList('getSelectedItem');
                        $.ajax({
                            url: "../content/data-jr/evaluatedCriterion/index.jsp?session",
                            data: {
                                "pt_study_level": itemLevel.value,
                                "pt_career": itemCareer.value,
                                "pt_matter": itemSubjectMatter.value,
                                "pt_period": itemPeriod.value
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
                renderstatusbar: function (statusbar) {
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
                    { text: 'No.', filterable: false, editable: false, dataField: 'dataNumActivity', width: 40 },
                    { text: 'Actividad', datafield : 'dataNameActivity', width: 150 },
                    { text: 'Descripción', datafield : 'dataDescriptionActivity', width: 250 },
                    { text: 'Val.#', datafield : 'dataValueActivity', width: 60 },
                    { text: 'Val.%', datafield : 'dataValueActivityPercent', width: 70 }
                ]
            }); 
            
        }
        $('#jqxWindowAddActivities').on('close', function (event) { 
            $("#name_activity").val("");
            $("#activity_description").val("");
//            $('#value_activity_slider').off('change');
        }); 
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
                        "valueActivity": parseFloat($("#value_activity").val()).toFixed(2),
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
                
        $("#name_activity").jqxInput({theme: theme, placeHolder: "Nombre de la actividad", height: 28, width: 200, minLength: 1});
        
        $("#value_activity, #name_activity").css("display","inline-flex");
        $('#jqxWindowAddActivities').jqxWindow({
            theme: theme,
            height: 400,
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
        //addWorkPlannin.jqxTooltip({ position: 'left', content: "Importar grupo de actividades"});
        addWorkPlannin.jqxButton({"height": 20, "width": 20, cursor: "pointer"});
        
        var switchClick = 0;
        
        
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
        $("#name_activity").upperFirstAll();
        $("#activity_description").upperFirstAll();      
        function convertionInverseToFix(value){
            //console.log(value+"--"+max_value_disponibility);
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
                    <input type="text"  id="name_activity" name="name_activity"/>
                </div>
                <br>
                <div class="form-group col-xs-5 input-prepend">
                    <label class="label-row" for="value_activity">Valor</label><br> 
                    <div id="contentNumberInput">
                        <div class="value_activity" id="value_activity" name="value_activity"></div>
                    </div>
                </div>
                <img id="pictureAddActivities" src="../content/pictures-system/add-activity.png" style="position: absolute; right: 30px; top: 10px;"/>
                <br>
                <br>
                <div class="form-group col-xs-12 input-prepend">
                    <label class="label-row" for="value_activity_label">Valor: <span id="value_activity_label"></span></label>   
                </div>
                <br>
                <div class="form-group col-xs-12 input-prepend">
                    <label class="label-row" for="value_activity_percent">Porcentaje: <span id="value_activity_percent"></span></label>   
                </div>
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

<div id="popoverSettings" style="display: none">
    <div style="color: olive;">
        <label style="font-size: 12px; font-weight: bold">Tipo de entrada</label>
        <br>
        <label style="font-size: 12px">            
            <input id="typeInput" type="radio" name="wayInput"/>
            Caja númerica
        </label>
        <br>
        <label style="font-size: 12px">           
            <input id="typeSlider" type="radio" name="wayInput" />
            Deslizador
        </label>
    </div>
</div>

<div id="popoverShare" style="display: none">
    <div style="color: olive;">
        <label style="font-size: 12px; font-weight: bold">Ajustes del bloque de actividades</label>
        <br><br>
        <label style="font-size: 12px">  
            Alias del bloque
            <input id="aliasBlock" type="text"/>            
        </label>
        <label style="font-size: 12px">  
            <button id="shareNow">Compartir ahora</button>           
        </label>
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
<div style="display: none; margin-right: 5px;">
    Periodo <br>
    <div id='valorateActivitiesPeriodFilter'></div>
</div>
<div style="display: inline-block; margin-right: 5px;">
    Nivel de estudio<br>
    <div id='valorateActivitiesLevelFilter'></div>
</div>
<div style="display: inline-block; margin-right: 5px;">
    Carrera <br>
    <div id='valorateActivitiesCareerFilter'></div>
</div>
<div id="contentHistoryPeriods" style="display: none; float: right; right: 100px; position: absolute; z-index: 10000;">
    Periodo historial <br>
    <div id='valorateActivitiesPeriodHistoryFilter'></div>
</div>
<div style="display: inline-block; margin-right: 5px;">
    Cuatrimestre<br>
    <div id='valorateActivitiesSemesterFilter'></div>
</div>
<div style="display: inline-block; margin-right: 5px;">
    Materia<br>
    <div id='valorateActivitiesSubjectMatterFilter'></div>
</div>
<div style="display: inline-block; margin-right: 5px;">
    Saber<br>
    <input type="hidden" id="pkWorkPlannig"/>
    <div id='valorateActivitiesScaleEvaluationFilter'></div>
</div>
<div style="display: inline-block; margin-right: 5px;">
    <div id="addWorkPlannin" style="height: 28px; display: none">
        <div class="jqx-icon-list" style="height: 20px; width: 20px;"></div>
    </div>
</div>
<br>
<div style="display: inline-block; margin-right: 5px;">
    <div id="contentTRegisterActivities">
        <div id="tableRegisterActivities"></div>
    </div>
</div>