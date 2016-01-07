<script>
    $(document).ready(function () {
        var itemLevel = 0;
        var itemCareer = 0;
        var itemPeriod = 0;
        var itemGroup = 0;
        var itemSemester = 0;
        var itemSubjectMatter = 0;
        createDropDownStudyLevelByTeacher("#recordsQualificationsGlobalLevelFilter",false);
        itemLevel = $('#recordsQualificationsGlobalLevelFilter').jqxDropDownList('getSelectedItem');
        
        if(itemLevel!==undefined){
            createDropDownCareerByTeacher( itemLevel.value ,"#recordsQualificationsGlobalCareerFilter",false);
            itemCareer = $('#recordsQualificationsGlobalCareerFilter').jqxDropDownList('getSelectedItem');
            createDropDownPeriod("comboActiveYear","#recordsQualificationsGlobalPeriodFilter");
            itemPeriod = $('#recordsQualificationsGlobalPeriodFilter').jqxDropDownList('getSelectedItem');
            createDropDownSemesterByTeacher(itemPeriod.value, itemLevel.value,"#recordsQualificationsGlobalSemesterFilter",false);
            itemSemester = $('#recordsQualificationsGlobalSemesterFilter').jqxDropDownList('getSelectedItem');
            createDropDownSubjectMatterByTeacher(itemPeriod.value, itemSemester.value, null, "#recordsQualificationsGlobalSubjectMatterFilter", false);
            itemSubjectMatter=$('#recordsQualificationsGlobalSubjectMatterFilter').jqxDropDownList('getSelectedItem'); 
            createDropDownGruopByTeacherMattter(itemPeriod.value, itemSemester.value, itemSubjectMatter.value, "#recordsQualificationsGlobalGroupFilter",false);
            itemGroup = $('#recordsQualificationsGlobalGroupFilter').jqxDropDownList('getSelectedItem');
            $('#recordsQualificationsGlobalLevelFilter').on('change',function (event){  
                itemLevel = $('#recordsQualificationsGlobalLevelFilter').jqxDropDownList('getSelectedItem');
                createDropDownCareerByTeacher(itemLevel.value, "#recordsQualificationsGlobalCareerFilter", true);
                itemPeriod = $('#recordsQualificationsGlobalPeriodFilter').jqxDropDownList('getSelectedItem');
                createDropDownSemesterByTeacher(itemPeriod.value, itemLevel.value,"#recordsQualificationsGlobalSemesterFilter", true);   
            });
            $('#recordsQualificationsGlobalCareerFilter').on('change',function (event){           
                itemCareer = $('#recordsQualificationsGlobalCareerFilter').jqxDropDownList('getSelectedItem');
            });
            $("#recordsQualificationsGlobalSemesterFilter").on('change',function (){
                itemPeriod = $('#recordsQualificationsGlobalPeriodFilter').jqxDropDownList('getSelectedItem');
                itemSemester = $('#recordsQualificationsGlobalSemesterFilter').jqxDropDownList('getSelectedItem');
                createDropDownSubjectMatterByTeacher(itemPeriod.value, itemSemester.value, null, "#recordsQualificationsGlobalSubjectMatterFilter", true);
            });
            $("#recordsQualificationsGlobalSubjectMatterFilter").on('change',function (){  
                itemPeriod = $('#recordsQualificationsGlobalPeriodFilter').jqxDropDownList('getSelectedItem');
                itemSemester = $('#recordsQualificationsGlobalSemesterFilter').jqxDropDownList('getSelectedItem');
                itemSubjectMatter=$('#recordsQualificationsGlobalSubjectMatterFilter').jqxDropDownList('getSelectedItem'); 
                createDropDownGruopByTeacherMattter(itemPeriod.value, itemSemester.value, itemSubjectMatter.value, "#recordsQualificationsGlobalGroupFilter",true);
                itemGroup = $('#recordsQualificationsGlobalGroupFilter').jqxDropDownList('getSelectedItem');
            });
            $("#recordsQualificationsGlobalGroupFilter").on('change',function (){  
                var dataAdapter = new $.jqx.dataAdapter(loadSource());
                $("#tableGlobalQualifications").jqxGrid({source: dataAdapter});
                isClosedWorkPlanningGlobal();
            });
            loadTableQualifications();
        }else{
            createDropDownCareerByTeacher(null ,"#recordsQualificationsGlobalCareerFilter",false);
            createDropDownPeriod("comboActiveYear","#recordsQualificationsGlobalPeriodFilter");
            createDropDownSemesterByTeacher(null, null,"#recordsQualificationsGlobalSemesterFilter",false);
            createDropDownSubjectMatterByTeacher(null, null, null, "#recordsQualificationsGlobalSubjectMatterFilter", false);
            createDropDownGruopByTeacherMattter(null, null, null, "#recordsQualificationsGlobalGroupFilter",false);
        }
        
        function loadSource(){
            itemPeriod = $('#recordsQualificationsGlobalPeriodFilter').jqxDropDownList('getSelectedItem');
            itemSubjectMatter=$('#recordsQualificationsGlobalSubjectMatterFilter').jqxDropDownList('getSelectedItem');  
            itemGroup = $('#recordsQualificationsGlobalGroupFilter').jqxDropDownList('getSelectedItem');
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
                url: '../serviceCalification?view=recordsCalificationsGlobal&&fkPeriod='+itemPeriod.value+'&&fkMatter='+itemSubjectMatter.value+'&&fkGroup='+itemGroup.value+''
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
            $("#tableGlobalDescription").jqxGrid({
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
            $("#tableGlobalDescription2").jqxGrid({
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
                var lockButtonGlobal = $(buttonTemplate);
                var unlockButtonGlobal = $(buttonTemplate);
                var infoButtonGlobal = $(buttonTemplate);
                var showButtonGlobal = $(buttonTemplate);
                var exportButtonGlobal = $(buttonTemplate);
                
                container.append(unlockButtonGlobal);
                container.append(exportButtonGlobal);
                container.append(infoButtonGlobal);
                container.append(lockButtonGlobal);
                container.append(showButtonGlobal);
                toolbar.append(container);
                var me = this;     
                
                
                lockButtonGlobal.jqxButton({cursor: "pointer", enableDefault: false,  height: 25, width: 25 });
                lockButtonGlobal.find('div:first').addClass(toTheme('jqx-icon-lock'));
                lockButtonGlobal.jqxTooltip({ position: 'bottom', content: "Cerrar calificaciones"});
                lockButtonGlobal.attr("id", "lockButtonGlobal");
                
                
                unlockButtonGlobal.jqxButton({cursor: "pointer", enableDefault: false,  height: 25, width: 25 });
                unlockButtonGlobal.find('div:first').addClass(toTheme('jqx-icon-unlock'));
                unlockButtonGlobal.jqxTooltip({ position: 'bottom', content: "Calificaciones cerradas"});
                unlockButtonGlobal.attr("id","unlockButtonGlobal");
                unlockButtonGlobal.jqxButton({ disabled: true });
                
                exportButtonGlobal.jqxButton({cursor: "pointer", enableDefault: false,  height: 25, width: 25 });
                exportButtonGlobal.find('div:first').addClass(toTheme('jqx-icon-export'));
                exportButtonGlobal.jqxTooltip({ position: 'bottom', content: "Exportar a pdf"});
                exportButtonGlobal.attr("id","exportButtonGlobal");

                infoButtonGlobal.jqxButton({ cursor: "pointer", disabled: false, enableDefault: false,  height: 25, width: 25 });
                infoButtonGlobal.find('div:first').addClass(toTheme('jqx-icon-info'));
                infoButtonGlobal.css({"float":"right","cursor":"pointer"});
                infoButtonGlobal.jqxTooltip({ position: 'bottom', content: "Descripción de letra"});

                showButtonGlobal.jqxButton({ cursor: "pointer", disabled: false, enableDefault: false,  height: 25, width: 25 });
                showButtonGlobal.find('div:first').addClass(toTheme('jqx-icon-show'));
                showButtonGlobal.css({"float":"right","cursor":"pointer"});
                showButtonGlobal.jqxTooltip({ position: 'bottom', content: "Agregar observaciones"});
                showButtonGlobal.attr("id","showButtonGlobal");
                
                isClosedWorkPlanningGlobal();
                
                lockButtonGlobal.click(function (){
                    $("#messageWarning").text("¡Una ves cerradas las calificaciones de global no podrán ser alteradas, esta seguro que desea continuar...?");
                    $("#typeEval").val("global");
                    $('#jqxWindowWarningCalications').jqxWindow("open");
                });
                var onShow=true;
                showButtonGlobal.click(function (){
                   if(onShow){
                        $("#jqxGlobalObservations").fadeIn("slow");
                        $("#tableGlobalDescription").hide();
                        $("#tableGlobalDescription2").hide();
                        onShow=false;
                        on=true;
                    }else{
                        $("#jqxGlobalObservations").fadeOut("slow");
                        onShow=true;
                    }
                });
                var on=true;
                infoButtonGlobal.click(function (){
                    if(on){
                        $("#tableGlobalDescription").fadeIn("slow");
                        $("#tableGlobalDescription2").fadeIn("slow");
                        $("#jqxGlobalObservations").hide();
                        on=false;
                        onShow=true;
                    }else{
                        $("#tableGlobalDescription").fadeOut("slow");
                        $("#tableGlobalDescription2").fadeOut("slow");
                        on=true;
                    }
                });
                exportButtonGlobal.click(function (){
                    itemSubjectMatter= $('#recordsQualificationsGlobalSubjectMatterFilter').jqxDropDownList('getSelectedItem'); 
                    itemGroup = $('#recordsQualificationsGlobalGroupFilter').jqxDropDownList('getSelectedItem');
                    itemPeriod = $('#recordsQualificationsGlobalPeriodFilter').jqxDropDownList('getSelectedItem');
                    $.ajax({
                        url: "../content/data-jr/recordsCalifications/index.jsp?session",
                        data: {"pt_type_report":"byMatterRecordsCalificationsGlobal", "pt_matter": itemSubjectMatter.value,"pt_group": itemGroup.value,"pt_period": itemPeriod.value},
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
            $("#tableGlobalQualifications").jqxGrid({
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
                    $("#tableGlobalQualifications").jqxGrid('focus');
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
            itemSubjectMatter= $('#recordsQualificationsGlobalSubjectMatterFilter').jqxDropDownList('getSelectedItem'); 
            itemGroup = $('#recordsQualificationsGlobalGroupFilter').jqxDropDownList('getSelectedItem');
            itemPeriod = $('#recordsQualificationsGlobalPeriodFilter').jqxDropDownList('getSelectedItem');
            $.ajax({
                url: "../serviceCalification?getObservations",
                data: {"fkType":3, "fkMatter": itemSubjectMatter.value,"fkGroup": itemGroup.value,"fkPeriod": itemPeriod.value},
                type: 'POST',
                beforeSend: function (xhr) {
                },
                success: function (data, textStatus, jqXHR) {
                    $("#GlobalObservations").val(data);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert("Error interno del servidor");                
                }
            });
        }
        function isClosedWorkPlanningGlobal(){
            itemSubjectMatter= $('#recordsQualificationsGlobalSubjectMatterFilter').jqxDropDownList('getSelectedItem'); 
            itemGroup = $('#recordsQualificationsGlobalGroupFilter').jqxDropDownList('getSelectedItem');
            itemPeriod = $('#recordsQualificationsGlobalPeriodFilter').jqxDropDownList('getSelectedItem');
            var status=0;
            $.ajax({
                url: "../serviceCalification?isCloseWorkPlanning",
                data: {"fkType":3, "fkMatter": itemSubjectMatter.value,"fkGroup": itemGroup.value,"fkPeriod": itemPeriod.value},
                type: 'POST',
                async: false,
                beforeSend: function (xhr) {
                },
                success: function (data, textStatus, jqXHR) {
                    status=parseInt(data);
                    if(status==1){
                        $("#unlockButtonGlobal").show();
                        $("#exportButtonGlobal").show();
                        $("#showButtonGlobal").hide();
                        $("#lockButtonGlobal").hide();
                    }else if(status==0){    
                        $("#showButtonGlobal").show();
                        $("#lockButtonGlobal").show();
                        $("#unlockButtonGlobal").hide();
                        $("#exportButtonGlobal").hide();
                    }else{
                        $("#unlockButtonGlobal").hide();
                        $("#exportButtonGlobal").hide();
                        $("#showButtonGlobal").hide();
                        $("#lockButtonGlobal").hide();
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert("Error interno del servidor");                
                }
            });
            return status;
        }
        
        function closeWorkPlanningByGroupMattersGlobal(){
            itemSubjectMatter= $('#recordsQualificationsGlobalSubjectMatterFilter').jqxDropDownList('getSelectedItem'); 
            itemGroup = $('#recordsQualificationsGlobalGroupFilter').jqxDropDownList('getSelectedItem');
            itemPeriod = $('#recordsQualificationsGlobalPeriodFilter').jqxDropDownList('getSelectedItem');
            $.ajax({
                url: "../serviceCalification?closeWorkPlanning",
                data: {"fkType":3, "fkMatter": itemSubjectMatter.value,"fkGroup": itemGroup.value,"fkPeriod": itemPeriod.value},
                type: 'POST',
                beforeSend: function (xhr) {
                },
                success: function (data, textStatus, jqXHR) {
                    $("#lockButtonGlobal").hide();
                    $("#showButtonGlobal").hide();
                    $("#exportButtonGlobal").show();
                    $("#unlockButtonGlobal").show();
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert("Error interno del servidor");                
                }
            });
        }
        $('#okWarning').click(function (){
            if($("#typeEval").val()==="global"){
                closeWorkPlanningByGroupMattersGlobal();
            }            
        });
        $("#GlobalObservations").focusout(function (){
            itemSubjectMatter= $('#recordsQualificationsGlobalSubjectMatterFilter').jqxDropDownList('getSelectedItem'); 
            itemGroup = $('#recordsQualificationsGlobalGroupFilter').jqxDropDownList('getSelectedItem');
            itemPeriod = $('#recordsQualificationsGlobalPeriodFilter').jqxDropDownList('getSelectedItem');
            $.ajax({
                url: "../serviceCalification?setObservations",
                data: {"fkType":3, "fkMatter": itemSubjectMatter.value,"fkGroup": itemGroup.value,"fkPeriod": itemPeriod.value,"flObservations": $(this).val() },
                type: 'POST',
                beforeSend: function (xhr) {
                },
                success: function (data, textStatus, jqXHR) {
                },
                error: function (jqXHR, textStatus, errorThrown) {
                                    
                }
            });
        });
        $("#jqxGlobalObservations").jqxExpander({
            width: 210,
            toggleMode: "none",
            height: 150,
            theme: theme
        });
    });
</script>
<div style="float: left; margin-right: 5px;">
    Nivel de estudio<br>
    <div id='recordsQualificationsGlobalLevelFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Carrera <br>
    <div id='recordsQualificationsGlobalCareerFilter'></div>
</div>
<div id="contentGlobalHistoryPeriods" style="display: none; float: right; right: 100px; position: absolute; z-index: 10000;">
    Periodo historial <br>
    <div id='recordsQualificationsGlobalPeriodHistoryFilter'></div>
</div>
<div style="float: right; margin-right: 5px; display: none">
    Periodo <br>
    <div id='recordsQualificationsGlobalPeriodFilter'></div>
</div>
<br><br><br>
<div style="float: left; margin-right: 5px;">
    Cuatrimestre<br>
    <div id='recordsQualificationsGlobalSemesterFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Materia<br>
    <div id='recordsQualificationsGlobalSubjectMatterFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Grupo<br>
    <div id='recordsQualificationsGlobalGroupFilter'></div>
</div>
<br><br><br>
<div style="" id="tableGlobalQualifications"></div>
<div style="float: left; margin-top: 15px; margin-right: 15px; display: none" id="tableGlobalDescription2"></div>
<div style="float: left; margin-top: 15px; display: none" id="tableGlobalDescription"></div>
<div style="float: left; margin-left: 5px; display: none" id='jqxGlobalObservations'>
    <div>Obseravaciones</div>
    <div>
        <textarea  id="GlobalObservations" style="margin: 3px; width: 180px; height: 100px; resize: none;" placeholder="Escriba aquí sus observaciones..."></textarea>
    </div>
</div>
