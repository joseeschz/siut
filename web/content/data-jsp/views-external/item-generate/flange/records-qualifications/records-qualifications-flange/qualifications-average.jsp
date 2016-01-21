<script>
    $(document).ready(function () {
        var itemLevel = 0;
        var itemCareer = 0;
        var itemPeriod = 0;
        var itemGroup = 0;
        var itemSemester = 0;
        var itemSubjectMatter = 0;
        createDropDownStudyLevelByTeacher("#qualificationsLevelFilter",false);
        itemLevel = $('#qualificationsLevelFilter').jqxDropDownList('getSelectedItem');
        
        if(itemLevel!==undefined){
            createDropDownCareerByTeacher( itemLevel.value ,"#qualificationsCareerFilter",false);
            itemCareer = $('#qualificationsCareerFilter').jqxDropDownList('getSelectedItem');
            createDropDownPeriod("comboActiveYear","#qualificationsPeriodFilter");
            itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');
            createDropDownSemesterByTeacher(itemPeriod.value, itemLevel.value,"#qualificationsSemesterFilter",false);
            itemSemester = $('#qualificationsSemesterFilter').jqxDropDownList('getSelectedItem');
            createDropDownSubjectMatterByTeacher(itemPeriod.value, itemCareer.value, itemSemester.value, null, "#qualificationsSubjectMatterFilter", false);
            itemSubjectMatter=$('#qualificationsSubjectMatterFilter').jqxDropDownList('getSelectedItem'); 
            createDropDownGruopByTeacherMattter(itemPeriod.value, itemSemester.value, itemSubjectMatter.value, "#qualificationsGroupFilter",false);
            itemGroup = $('#qualificationsGroupFilter').jqxDropDownList('getSelectedItem');
            $('#qualificationsLevelFilter').on('change',function (event){  
                itemLevel = $('#qualificationsLevelFilter').jqxDropDownList('getSelectedItem');
                createDropDownCareerByTeacher(itemLevel.value, "#qualificationsCareerFilter", true);
                itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');
                createDropDownSemesterByTeacher(itemPeriod.value, itemLevel.value,"#qualificationsSemesterFilter", true);   
            });
            $('#qualificationsCareerFilter').on('change',function (event){           
                itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');
                itemCareer = $('#qualificationsCareerFilter').jqxDropDownList('getSelectedItem');
                createDropDownSemesterByTeacher(itemPeriod.value, itemLevel.value,"#qualificationsSemesterFilter", true);
                itemSemester = $('#qualificationsSemesterFilter').jqxDropDownList('getSelectedItem');
            });
            $("#qualificationsSemesterFilter").on('change',function (){
                itemCareer = $('#qualificationsCareerFilter').jqxDropDownList('getSelectedItem');
                itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');
                itemSemester = $('#qualificationsSemesterFilter').jqxDropDownList('getSelectedItem');
                createDropDownSubjectMatterByTeacher(itemPeriod.value, itemCareer.value, itemSemester.value, null, "#qualificationsSubjectMatterFilter", true);
            });
            $("#qualificationsSubjectMatterFilter").on('change',function (){  
                itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');
                itemSemester = $('#qualificationsSemesterFilter').jqxDropDownList('getSelectedItem');
                itemSubjectMatter=$('#qualificationsSubjectMatterFilter').jqxDropDownList('getSelectedItem'); 
                createDropDownGruopByTeacherMattter(itemPeriod.value, itemSemester.value, itemSubjectMatter.value, "#qualificationsGroupFilter",true);
                itemGroup = $('#qualificationsGroupFilter').jqxDropDownList('getSelectedItem');
            });
            $("#qualificationsGroupFilter").on('change',function (){  
                var dataAdapter = new $.jqx.dataAdapter(loadSource());
                $("#tableQualifications").jqxGrid({source: dataAdapter});
                isClosedWorkPlanning();
            });
            loadTableQualifications();
        }else{
            createDropDownCareerByTeacher(null ,"#qualificationsCareerFilter",false);
            createDropDownPeriod("comboActiveYear","#qualificationsPeriodFilter");
            createDropDownSemesterByTeacher(null, null,"#qualificationsSemesterFilter",false);
            createDropDownSubjectMatterByTeacher(null, null, null, null, "#qualificationsSubjectMatterFilter", false);
            createDropDownGruopByTeacherMattter(null, null, null, "#qualificationsGroupFilter",false);
        }
        
        function loadSource(){
            itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');
            itemSubjectMatter=$('#qualificationsSubjectMatterFilter').jqxDropDownList('getSelectedItem');  
            itemGroup = $('#qualificationsGroupFilter').jqxDropDownList('getSelectedItem');
            var ordersSource ={
                dataFields: [
                    { name: 'id', type:'int'},
                    { name: 'dataProgresivNumber', type:'int'},
                    { name: 'dataEnrollment', type: 'string' },
                    { name: 'dataFkStudent', type: 'int' },
                    { name: 'dataStudentName', type: 'string' },
                    { name: 'dataCalificationBe', type: 'double' },
                    { name: 'dataCalificationKnow', type: 'double' },
                    { name: 'dataCalificationDo', type: 'double' },
                    { name: 'dataAvg', type: 'double'},
                    { name: 'dataLetter', type: 'string'}
                ],
                root: "__ENTITIES",
                dataType: "json",
                id: 'id',
                async: false,
                url: '../serviceCalification?view=recordsCalificationsAverage&&fkPeriod='+itemPeriod.value+'&&fkMatter='+itemSubjectMatter.value+'&&fkGroup='+itemGroup.value+''
            };
            return ordersSource;
        }
        function loadSourceDescription(){
            var ordersSource ={
                dataFields: [
                    { name: 'dataIntegradora', type: 'string' },
                    { name: 'dataNoIntegradora', type: 'string' }
                ],
                root: "__ENTITIES",
                dataType: "json",
                id: 'id',
                async: false,
                url: '../serviceCalification?view=recordsCalificationsDescription'
            };
            return ordersSource;
        }
        function loadTableDescription(){
            var dataAdapter = new $.jqx.dataAdapter(loadSourceDescription());
            $("#tableDescription").jqxGrid({
                width: 225,
                height: 127,
                selectionMode: "singlerow",
                localization: getLocalization("es"),
                source: dataAdapter,
                pageable: false,
                editable: false,
                filterable: false,
                altRows: true,
                columns: [
                    { text: 'Integradoras',disabled: true, align: 'center', dataField: 'dataNoIntegradora'}
                ]
            });
            $("#tableDescription2").jqxGrid({
                width: 225,
                height: 127,
                selectionMode: "singlerow",
                localization: getLocalization("es"),
                source: dataAdapter,
                pageable: false,
                editable: false,
                filterable: false,
                altRows: true,
                columns: [
                    { text: 'No integradoras',disabled: true, align: 'center', dataField: 'dataIntegradora'}
                ]
            });
        }
        
        function loadTableQualifications(){
            var toolbarfunc = function (toolbar) {
                var themeRenderToolbar = "";
                var toTheme = function (className) {
                    if (themeRenderToolbar === "") return className;
                    return className + " " + className + "-" + themeRenderToolbar;
                };
                var container = $("<div style='overflow: hidden; position: relative; height: 100%; width: 100%;'></div>");
                var buttonTemplate = "<div style='display: BLOCK; float: left; padding: 3px; margin: 2px;'><div style='margin: 4px; width: 16px; height: 16px;'></div></div>";
                var lockButton = $(buttonTemplate);
                var unlockButton = $(buttonTemplate);
                var infoButton = $(buttonTemplate);
                var showButton = $(buttonTemplate);
                var exportButton = $(buttonTemplate);
                
                container.append(unlockButton);
                container.append(exportButton);
                container.append(infoButton);
                container.append(lockButton);
                container.append(showButton);
                toolbar.append(container);
                var me = this;     
                
                
                lockButton.jqxButton({cursor: "pointer", enableDefault: false,  height: 25, width: 25 });
                lockButton.find('div:first').addClass(toTheme('jqx-icon-lock'));
                lockButton.jqxTooltip({ position: 'bottom', content: "Cerrar calificaciones"});
                lockButton.attr("id","lockButton");
                
                unlockButton.jqxButton({cursor: "pointer", enableDefault: false,  height: 25, width: 25 });
                unlockButton.find('div:first').addClass(toTheme('jqx-icon-unlock'));
                unlockButton.jqxTooltip({ position: 'bottom', content: "Calificaciones cerradas"});
                unlockButton.jqxButton({ disabled: true });
                unlockButton.attr("id","unlockButton");

                exportButton.jqxButton({cursor: "pointer", enableDefault: false,  height: 25, width: 25 });
                exportButton.find('div:first').addClass(toTheme('jqx-icon-export'));
                exportButton.jqxTooltip({ position: 'bottom', content: "Exportar a pdf"});
                exportButton.attr("id","exportButton");

                infoButton.jqxButton({ cursor: "pointer", disabled: false, enableDefault: false,  height: 25, width: 25 });
                infoButton.find('div:first').addClass(toTheme('jqx-icon-info'));
                infoButton.css({"float":"right","cursor":"pointer"});
                infoButton.jqxTooltip({ position: 'bottom', content: "Descripción de letra"});

                showButton.jqxButton({ cursor: "pointer", disabled: false, enableDefault: false,  height: 25, width: 25 });
                showButton.find('div:first').addClass(toTheme('jqx-icon-show'));
                showButton.css({"float":"right","cursor":"pointer"});
                showButton.jqxTooltip({ position: 'bottom', content: "Agregar observaciones"});
                showButton.attr("id","showButton");
                
                
                
                isClosedWorkPlanning();
                
                lockButton.click(function (){
                    $("#messageWarning").text("¡Una ves cerradas las calificaciones de promedio no podrán ser alteradas, esta seguro que desea continuar...?");
                    $("#typeEval").val("average");
                    $('#jqxWindowWarningCalications').jqxWindow("open");
                });
                var onShow=true;
                showButton.click(function (){
                   if(onShow){
                        $("#jqxObservations").fadeIn("slow");
                        $("#tableDescription").hide();
                        $("#tableDescription2").hide();
                        onShow=false;
                        on=true;
                    }else{
                        $("#jqxObservations").fadeOut("slow");
                        onShow=true;
                    }
                });
                var on=true;
                infoButton.click(function (){
                    if(on){
                        $("#tableDescription").fadeIn("slow");
                        $("#tableDescription2").fadeIn("slow");
                        $("#jqxObservations").hide();
                        on=false;
                        onShow=true;
                    }else{
                        $("#tableDescription").fadeOut("slow");
                        $("#tableDescription2").fadeOut("slow");
                        on=true;
                    }
                });
                exportButton.click(function (){
                    itemSubjectMatter= $('#qualificationsSubjectMatterFilter').jqxDropDownList('getSelectedItem'); 
                    itemGroup = $('#qualificationsGroupFilter').jqxDropDownList('getSelectedItem');
                    itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');
                    $.ajax({
                        url: "../content/data-jr/recordsCalifications/index.jsp?session",
                        data: {"pt_type_report":"byMatterRecordsCalifications", "pt_matter": itemSubjectMatter.value,"pt_group": itemGroup.value,"pt_period": itemPeriod.value},
                        type: 'POST',
                        beforeSend: function (xhr) {
                        },
                        success: function (data, textStatus, jqXHR) {
                            window.open("../content/data-jr/recordsCalifications");
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            alert("Error interno del servidor");                
                        }
                    });
                });
            };
            
            var dataAdapter = new $.jqx.dataAdapter(loadSource());
            $("#tableQualifications").jqxGrid({
                width: 800,
                height: 450,
                selectionMode: "singlerow",
                localization: getLocalization("es"),
                source: dataAdapter,
                pageable: false,
                editable: false,
                toolbarheight: 34,
                filterable: false,
                altRows: true,
                ready: function(){
                    $("#tableQualifications").jqxGrid('focus');
                },
                columngroups: [
                    { text: 'Calificación', align: 'center', name: 'calification' }
                ],
                columns: [
                    { text: '#',  disabled: true, filterable: false, editable: false, dataField: 'dataProgresivNumber', width: 25 },
                    { text: 'Matrícula',disabled: true, align: 'center', dataField: 'dataEnrollment', editable: false, width: 140 },
                    { text: 'Alumno',disabled: true, align: 'center', dataField: 'dataStudentName', editable: false},
                    { text: 'Ser', columngroup: 'calification', parentgroup: 'calification', dataField: 'dataCalificationBe', cellsalign: 'center', align: 'center', width: 60 },
                    { text: 'Saber',columngroup: 'calification', cellsalign: 'center', align: 'center', dataField: 'dataCalificationKnow', width: 60},
                    { text: 'Hacer', columngroup: 'calification', cellsalign: 'center', align: 'center', dataField: 'dataCalificationDo', width: 60},
                    { text: 'Numero', columngroup: 'calification', cellsalign: 'center', align: 'center', dataField: 'dataAvg', width: 80},
                    { text: 'Letra', columngroup: 'calification', cellsalign: 'center', align: 'center', dataField: 'dataLetter', width: 80}
                ],
                showtoolbar: true,
                rendertoolbar: toolbarfunc
            });
            loadTableDescription();
            getObservations();
        }
        function getObservations(){
            itemSubjectMatter= $('#qualificationsSubjectMatterFilter').jqxDropDownList('getSelectedItem'); 
            itemGroup = $('#qualificationsGroupFilter').jqxDropDownList('getSelectedItem');
            itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');
            $.ajax({
                url: "../serviceCalification?getObservations",
                data: {"fkType":1, "fkMatter": itemSubjectMatter.value,"fkGroup": itemGroup.value,"fkPeriod": itemPeriod.value},
                type: 'POST',
                beforeSend: function (xhr) {
                },
                success: function (data, textStatus, jqXHR) {
                    $("#observations").val(data);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert("Error interno del servidor");                
                }
            });
        }
        function isClosedWorkPlanning(){
            itemSubjectMatter= $('#qualificationsSubjectMatterFilter').jqxDropDownList('getSelectedItem'); 
            itemGroup = $('#qualificationsGroupFilter').jqxDropDownList('getSelectedItem');
            itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');
            var status=0;
            $.ajax({
                url: "../serviceCalification?isCloseWorkPlanning",
                data: {"fkType":1, "fkMatter": itemSubjectMatter.value,"fkGroup": itemGroup.value,"fkPeriod": itemPeriod.value},
                type: 'POST',
                async: false,
                beforeSend: function (xhr) {
                },
                success: function (data, textStatus, jqXHR) {
                    status=parseInt(data);
                    if(status==1){
                        $("#unlockButton").show();
                        $("#exportButton").show();
                        $("#showButton").hide();
                        $("#lockButton").hide();
                        $('#jqxTabs').jqxTabs('enableAt', 1);
                    }else if(status==0){    
                        $('#jqxTabs').jqxTabs('disableAt', 1);
                        $('#jqxTabs').jqxTabs('disableAt', 2);
                        $("#showButton").show();
                        $("#lockButton").show();
                        $("#unlockButton").hide();
                        $("#exportButton").hide();
                    }else{
                        $('#jqxTabs').jqxTabs('disableAt', 1);
                        $('#jqxTabs').jqxTabs('disableAt', 2);
                        $("#unlockButton").hide();
                        $("#exportButton").hide();
                        $("#showButton").hide();
                        $("#lockButton").hide();
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert("Error interno del servidor");                
                }
            });
            return status;
        }
        
        function closeWorkPlanningByGroupMatters(){
            itemSubjectMatter= $('#qualificationsSubjectMatterFilter').jqxDropDownList('getSelectedItem'); 
            itemGroup = $('#qualificationsGroupFilter').jqxDropDownList('getSelectedItem');
            itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');
            $.ajax({
                url: "../serviceCalification?closeWorkPlanning",
                data: {"fkType":1, "fkMatter": itemSubjectMatter.value,"fkGroup": itemGroup.value,"fkPeriod": itemPeriod.value},
                type: 'POST',
                beforeSend: function (xhr) {
                },
                success: function (data, textStatus, jqXHR) {
                    $('#jqxTabs').jqxTabs('enableAt', 1);
                    $("#lockButton").hide();
                    $("#showButton").hide();
                    $("#exportButton").show();
                    $("#unlockButton").show();
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert("Error interno del servidor");                
                }
            });
        }
        $('#okWarning').click(function (){
            if($("#typeEval").val()==="average"){
                closeWorkPlanningByGroupMatters();
            }
        });
        $("#observations").focusout(function (){
            itemSubjectMatter= $('#qualificationsSubjectMatterFilter').jqxDropDownList('getSelectedItem'); 
            itemGroup = $('#qualificationsGroupFilter').jqxDropDownList('getSelectedItem');
            itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');
            $.ajax({
                url: "../serviceCalification?setObservations",
                data: {"fkType":1, "fkMatter": itemSubjectMatter.value,"fkGroup": itemGroup.value,"fkPeriod": itemPeriod.value,"flObservations": $(this).val() },
                type: 'POST',
                beforeSend: function (xhr) {
                },
                success: function (data, textStatus, jqXHR) {
                },
                error: function (jqXHR, textStatus, errorThrown) {
                                    
                }
            });
        });
        $("#jqxObservations").jqxExpander({
            width: 210,
            toggleMode: "none",
            height: 150,
            theme: theme
        });
    });
</script>
<div style="float: left; margin-right: 5px;">
    Nivel de estudio<br>
    <div id='qualificationsLevelFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Carrera <br>
    <div id='qualificationsCareerFilter'></div>
</div>
<div id="contentHistoryPeriods" style="display: none; float: right; right: 100px; position: absolute; z-index: 10000;">
    Periodo historial <br>
    <div id='qualificationsPeriodHistoryFilter'></div>
</div>
<div style="float: right; margin-right: 5px; display: none">
    Periodo <br>
    <div id='qualificationsPeriodFilter'></div>
</div>
<br><br><br>
<div style="float: left; margin-right: 5px;">
    Cuatrimestre<br>
    <div id='qualificationsSemesterFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Materia<br>
    <div id='qualificationsSubjectMatterFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Grupo<br>
    <div id='qualificationsGroupFilter'></div>
</div>
<br><br><br>
<div style="" id="tableQualifications"></div>
<div style="float: left; margin-top: 15px; margin-right: 15px; display: none" id="tableDescription2"></div>
<div style="float: left; margin-top: 15px; display: none" id="tableDescription"></div>
<div style="float: left; margin-left: 5px; display: none" id='jqxObservations'>
    <div>Obseravaciones</div>
    <div>
        <textarea  id="observations" style="margin: 3px; width: 180px; height: 100px; resize: none;" placeholder="Escriba aquí sus observaciones..."></textarea>
    </div>
</div>
