<script>
    $(document).ready(function () {
        var itemLevel = 0;
        var itemCareer = 0;
        var itemPeriod = 0;
        var itemGroup = 0;
        var itemSemester = 0;
        var itemSubjectMatter = 0;
        createDropDownStudyLevelByTeacher("#recordsQualificationsRegulaLevelFilter",false);
        itemLevel = $('#recordsQualificationsRegulaLevelFilter').jqxDropDownList('getSelectedItem');
        
        if(itemLevel!==undefined){
            createDropDownCareerByTeacher( itemLevel.value ,"#recordsQualificationsRegulaCareerFilter",false);
            itemCareer = $('#recordsQualificationsRegulaCareerFilter').jqxDropDownList('getSelectedItem');
            createDropDownPeriod("comboActiveYear","#recordsQualificationsRegulaPeriodFilter");
            itemPeriod = $('#recordsQualificationsRegulaPeriodFilter').jqxDropDownList('getSelectedItem');
            createDropDownSemesterByTeacher(itemPeriod.value, itemLevel.value,"#recordsQualificationsRegulaSemesterFilter",false);
            itemSemester = $('#recordsQualificationsRegulaSemesterFilter').jqxDropDownList('getSelectedItem');
            createDropDownSubjectMatterByTeacher(itemPeriod.value, itemSemester.value, null, "#recordsQualificationsRegulaSubjectMatterFilter", false);
            itemSubjectMatter=$('#recordsQualificationsRegulaSubjectMatterFilter').jqxDropDownList('getSelectedItem'); 
            createDropDownGruopByTeacherMattter(itemPeriod.value, itemSemester.value, itemSubjectMatter.value, "#recordsQualificationsRegulaGroupFilter",false);
            itemGroup = $('#recordsQualificationsRegulaGroupFilter').jqxDropDownList('getSelectedItem');
            $('#recordsQualificationsRegulaLevelFilter').on('change',function (event){  
                itemLevel = $('#recordsQualificationsRegulaLevelFilter').jqxDropDownList('getSelectedItem');
                createDropDownCareerByTeacher(itemLevel.value, "#recordsQualificationsRegulaCareerFilter", true);
                itemPeriod = $('#recordsQualificationsRegulaPeriodFilter').jqxDropDownList('getSelectedItem');
                createDropDownSemesterByTeacher(itemPeriod.value, itemLevel.value,"#recordsQualificationsRegulaSemesterFilter", true);   
            });
            $('#recordsQualificationsRegulaCareerFilter').on('change',function (event){           
                itemCareer = $('#recordsQualificationsRegulaCareerFilter').jqxDropDownList('getSelectedItem');
            });
            $("#recordsQualificationsRegulaSemesterFilter").on('change',function (){
                itemPeriod = $('#recordsQualificationsRegulaPeriodFilter').jqxDropDownList('getSelectedItem');
                itemSemester = $('#recordsQualificationsRegulaSemesterFilter').jqxDropDownList('getSelectedItem');
                createDropDownSubjectMatterByTeacher(itemPeriod.value, itemSemester.value, null, "#recordsQualificationsRegulaSubjectMatterFilter", true);
            });
            $("#recordsQualificationsRegulaSubjectMatterFilter").on('change',function (){  
                itemPeriod = $('#recordsQualificationsRegulaPeriodFilter').jqxDropDownList('getSelectedItem');
                itemSemester = $('#recordsQualificationsRegulaSemesterFilter').jqxDropDownList('getSelectedItem');
                itemSubjectMatter=$('#recordsQualificationsRegulaSubjectMatterFilter').jqxDropDownList('getSelectedItem'); 
                createDropDownGruopByTeacherMattter(itemPeriod.value, itemSemester.value, itemSubjectMatter.value, "#recordsQualificationsRegulaGroupFilter",true);
                itemGroup = $('#recordsQualificationsRegulaGroupFilter').jqxDropDownList('getSelectedItem');
            });
            $("#recordsQualificationsRegulaGroupFilter").on('change',function (){  
                var dataAdapter = new $.jqx.dataAdapter(loadSource());
                $("#tableRegulaQualifications").jqxGrid({source: dataAdapter});
                isClosedWorkPlanningRegula();
            });
            loadTableQualifications();
        }else{
            createDropDownCareerByTeacher(null ,"#recordsQualificationsRegulaCareerFilter",false);
            createDropDownPeriod("comboActiveYear","#recordsQualificationsRegulaPeriodFilter");
            createDropDownSemesterByTeacher(null, null,"#recordsQualificationsRegulaSemesterFilter",false);
            createDropDownSubjectMatterByTeacher(null, null, null, "#recordsQualificationsRegulaSubjectMatterFilter", false);
            createDropDownGruopByTeacherMattter(null, null, null, "#recordsQualificationsRegulaGroupFilter",false);
        }
        
        function loadSource(){
            itemPeriod = $('#recordsQualificationsRegulaPeriodFilter').jqxDropDownList('getSelectedItem');
            itemSubjectMatter=$('#recordsQualificationsRegulaSubjectMatterFilter').jqxDropDownList('getSelectedItem');  
            itemGroup = $('#recordsQualificationsRegulaGroupFilter').jqxDropDownList('getSelectedItem');
            var ordersSource ={
                dataFields: [
                    { name: 'id', type:'int'},
                    { name: 'dataProgresivNumber', type:'int'},
                    { name: 'dataEnrollment', type: 'string' },
                    { name: 'dataFkStudent', type: 'int' },
                    { name: 'dataStudentName', type: 'string' },
                    { name: 'dataCalificationBe', type: 'string' },
                    { name: 'dataCalificationKnow', type: 'string' },
                    { name: 'dataCalificationDo', type: 'string' },
                    { name: 'dataAvg', type: 'double'},
                    { name: 'dataLetter', type: 'string'}
                ],
                root: "__ENTITIES",
                dataType: "json",
                id: 'id',
                async: false,
                url: '../serviceCalification?view=recordsCalificationsRegula&&fkPeriod='+itemPeriod.value+'&&fkMatter='+itemSubjectMatter.value+'&&fkGroup='+itemGroup.value+''
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
            $("#tableRegulaDescription").jqxGrid({
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
            $("#tableRegulaDescription2").jqxGrid({
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
                var buttonTemplate = "<div style='float: left; padding: 3px; margin: 2px;'><div style='margin: 4px; width: 16px; height: 16px;'></div></div>";
                var lockButtonRegula = $(buttonTemplate);
                var unlockButtonRegula = $(buttonTemplate);
                var infoButtonRegula = $(buttonTemplate);
                var showButtonRegula = $(buttonTemplate);
                var exportButtonRegula = $(buttonTemplate);
                
                container.append(unlockButtonRegula);
                container.append(exportButtonRegula);
                container.append(infoButtonRegula);
                container.append(lockButtonRegula);
                container.append(showButtonRegula);
                toolbar.append(container);
                var me = this;     
                
                
                lockButtonRegula.jqxButton({cursor: "pointer", enableDefault: false,  height: 25, width: 25 });
                lockButtonRegula.find('div:first').addClass(toTheme('jqx-icon-lock'));
                lockButtonRegula.jqxTooltip({ position: 'bottom', content: "Cerrar calificaciones"});
                lockButtonRegula.attr("id","lockButtonRegula");
                
                unlockButtonRegula.jqxButton({cursor: "pointer", enableDefault: false,  height: 25, width: 25 });
                unlockButtonRegula.find('div:first').addClass(toTheme('jqx-icon-unlock'));
                unlockButtonRegula.jqxTooltip({ position: 'bottom', content: "Calificaciones cerradas"});
                unlockButtonRegula.attr("id","unlockButtonRegula");
                unlockButtonRegula.jqxButton({ disabled: true });

                exportButtonRegula.jqxButton({cursor: "pointer", enableDefault: false,  height: 25, width: 25 });
                exportButtonRegula.find('div:first').addClass(toTheme('jqx-icon-export'));
                exportButtonRegula.jqxTooltip({ position: 'bottom', content: "Exportar a pdf"});
                exportButtonRegula.attr("id","exportButtonRegula");

                infoButtonRegula.jqxButton({ cursor: "pointer", disabled: false, enableDefault: false,  height: 25, width: 25 });
                infoButtonRegula.find('div:first').addClass(toTheme('jqx-icon-info'));
                infoButtonRegula.css({"float":"right","cursor":"pointer"});
                infoButtonRegula.jqxTooltip({ position: 'bottom', content: "Descripción de letra"});

                showButtonRegula.jqxButton({ cursor: "pointer", disabled: false, enableDefault: false,  height: 25, width: 25 });
                showButtonRegula.find('div:first').addClass(toTheme('jqx-icon-show'));
                showButtonRegula.css({"float":"right","cursor":"pointer"});
                showButtonRegula.jqxTooltip({ position: 'bottom', content: "Agregar observaciones"});
                showButtonRegula.attr("id","showButtonRegula");
                
                isClosedWorkPlanningRegula();
                
                lockButtonRegula.click(function (){
                    $("#messageWarning").text("¡Una ves cerradas las calificaciones de regularización no podrán ser alteradas, esta seguro que desea continuar...?");
                    $("#typeEval").val("regularization");
                    $('#jqxWindowWarningCalications').jqxWindow("open");
                });
                var onShow=true;
                showButtonRegula.click(function (){
                   if(onShow){
                        $("#jqxRegulaObservations").fadeIn("slow");
                        $("#tableRegulaDescription").hide();
                        $("#tableRegulaDescription2").hide();
                        onShow=false;
                        on=true;
                    }else{
                        $("#jqxRegulaObservations").fadeOut("slow");
                        onShow=true;
                    }
                });
                var on=true;
                infoButtonRegula.click(function (){
                    if(on){
                        $("#tableRegulaDescription").fadeIn("slow");
                        $("#tableRegulaDescription2").fadeIn("slow");
                        $("#jqxRegulaObservations").hide();
                        on=false;
                        onShow=true;
                    }else{
                        $("#tableRegulaDescription").fadeOut("slow");
                        $("#tableRegulaDescription2").fadeOut("slow");
                        on=true;
                    }
                });
                exportButtonRegula.click(function (){
                    itemSubjectMatter= $('#recordsQualificationsRegulaSubjectMatterFilter').jqxDropDownList('getSelectedItem'); 
                    itemGroup = $('#recordsQualificationsRegulaGroupFilter').jqxDropDownList('getSelectedItem');
                    itemPeriod = $('#recordsQualificationsRegulaPeriodFilter').jqxDropDownList('getSelectedItem');
                    var status=0;
                    $.ajax({
                        url: "../content/data-jr/recordsCalifications/index.jsp?session",
                        data: {"pt_type_report":"byMatterRecordsCalificationsRegularization", "pt_matter": itemSubjectMatter.value,"pt_group": itemGroup.value,"pt_period": itemPeriod.value},
                        type: 'POST',
                        async: false,
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
            $("#tableRegulaQualifications").jqxGrid({
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
                    $("#tableRegulaQualifications").jqxGrid('focus');
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
            itemSubjectMatter= $('#recordsQualificationsRegulaSubjectMatterFilter').jqxDropDownList('getSelectedItem'); 
            itemGroup = $('#recordsQualificationsRegulaGroupFilter').jqxDropDownList('getSelectedItem');
            itemPeriod = $('#recordsQualificationsRegulaPeriodFilter').jqxDropDownList('getSelectedItem');
            $.ajax({
                url: "../serviceCalification?getObservations",
                data: {"fkType":2, "fkMatter": itemSubjectMatter.value,"fkGroup": itemGroup.value,"fkPeriod": itemPeriod.value},
                type: 'POST',
                beforeSend: function (xhr) {
                },
                success: function (data, textStatus, jqXHR) {
                    $("#RegulaObservations").val(data);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert("Error interno del servidor");                
                }
            });
        }
        function isClosedWorkPlanningRegula(){
            itemSubjectMatter= $('#recordsQualificationsRegulaSubjectMatterFilter').jqxDropDownList('getSelectedItem'); 
            itemGroup = $('#recordsQualificationsRegulaGroupFilter').jqxDropDownList('getSelectedItem');
            itemPeriod = $('#recordsQualificationsRegulaPeriodFilter').jqxDropDownList('getSelectedItem');
            var status=0;
            $.ajax({
                url: "../serviceCalification?isCloseWorkPlanning",
                data: {"fkType":2, "fkMatter": itemSubjectMatter.value,"fkGroup": itemGroup.value,"fkPeriod": itemPeriod.value},
                type: 'POST',
                async: false,
                beforeSend: function (xhr) {
                },
                success: function (data, textStatus, jqXHR) {
                    status=parseInt(data);
                    if(status==1){
                        $("#unlockButtonRegula").show();
                        $("#exportButtonRegula").show();
                        $("#showButtonRegula").hide();
                        $("#lockButtonRegula").hide();
                        $('#jqxTabs').jqxTabs('enableAt', 2);
                    }else if(status==0){    
                        $('#jqxTabs').jqxTabs('disableAt', 2);
                        $("#showButtonRegula").show();
                        $("#lockButtonRegula").show();
                        $("#unlockButtonRegula").hide();
                        $("#exportButtonRegula").hide();
                    }else{
                        $('#jqxTabs').jqxTabs('disableAt', 2);
                        $("#unlockButtonRegula").hide();
                        $("#exportButtonRegula").hide();
                        $("#showButtonRegula").hide();
                        $("#lockButtonRegula").hide();
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert("Error interno del servidor");                
                }
            });
            return status;
        }
        
        function closeWorkPlanningByGroupMattersRegula(){
            itemSubjectMatter= $('#recordsQualificationsRegulaSubjectMatterFilter').jqxDropDownList('getSelectedItem'); 
            itemGroup = $('#recordsQualificationsRegulaGroupFilter').jqxDropDownList('getSelectedItem');
            itemPeriod = $('#recordsQualificationsRegulaPeriodFilter').jqxDropDownList('getSelectedItem');
            $.ajax({
                url: "../serviceCalification?closeWorkPlanning",
                data: {"fkType":2, "fkMatter": itemSubjectMatter.value,"fkGroup": itemGroup.value,"fkPeriod": itemPeriod.value},
                type: 'POST',
                beforeSend: function (xhr) {
                },
                success: function (data, textStatus, jqXHR) {
                    $("#lockButtonRegula").hide();
                    $("#showButtonRegula").hide();
                    $("#exportButtonRegula").show();
                    $("#unlockButtonRegula").show();
                    $('#jqxTabs').jqxTabs('enableAt', 2);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert("Error interno del servidor");                
                }
            });
        }
        $('#okWarning').click(function (){
            if($("#typeEval").val()==="regularization"){
                closeWorkPlanningByGroupMattersRegula();
            }
        });
        $("#RegulaObservations").focusout(function (){
            itemSubjectMatter= $('#recordsQualificationsRegulaSubjectMatterFilter').jqxDropDownList('getSelectedItem'); 
            itemGroup = $('#recordsQualificationsRegulaGroupFilter').jqxDropDownList('getSelectedItem');
            itemPeriod = $('#recordsQualificationsRegulaPeriodFilter').jqxDropDownList('getSelectedItem');
            $.ajax({
                url: "../serviceCalification?setObservations",
                data: {"fkType":2, "fkMatter": itemSubjectMatter.value,"fkGroup": itemGroup.value,"fkPeriod": itemPeriod.value,"flObservations": $(this).val() },
                type: 'POST',
                beforeSend: function (xhr) {
                },
                success: function (data, textStatus, jqXHR) {
                },
                error: function (jqXHR, textStatus, errorThrown) {
                                    
                }
            });
        });
        $("#jqxRegulaObservations").jqxExpander({
            width: 210,
            toggleMode: "none",
            height: 150,
            theme: theme
        });
    });
</script>
<div style="float: left; margin-right: 5px;">
    Nivel de estudio<br>
    <div id='recordsQualificationsRegulaLevelFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Carrera <br>
    <div id='recordsQualificationsRegulaCareerFilter'></div>
</div>
<div id="contentRegulaHistoryPeriods" style="display: none; float: right; right: 100px; position: absolute; z-index: 10000;">
    Periodo historial <br>
    <div id='recordsQualificationsRegulaPeriodHistoryFilter'></div>
</div>
<div style="float: right; margin-right: 5px; display: none">
    Periodo <br>
    <div id='recordsQualificationsRegulaPeriodFilter'></div>
</div>
<br><br><br>
<div style="float: left; margin-right: 5px;">
    Cuatrimestre<br>
    <div id='recordsQualificationsRegulaSemesterFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Materia<br>
    <div id='recordsQualificationsRegulaSubjectMatterFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Grupo<br>
    <div id='recordsQualificationsRegulaGroupFilter'></div>
</div>
<br><br><br>
<div style="" id="tableRegulaQualifications"></div>
<div style="float: left; margin-top: 15px; margin-right: 15px; display: none" id="tableRegulaDescription2"></div>
<div style="float: left; margin-top: 15px; display: none" id="tableRegulaDescription"></div>
<div style="float: left; margin-left: 5px; display: none" id='jqxRegulaObservations'>
    <div>Obseravaciones</div>
    <div>
        <textarea  id="RegulaObservations" style="margin: 3px; width: 180px; height: 100px; resize: none;" placeholder="Escriba aquí sus observaciones..."></textarea>
    </div>
</div>
