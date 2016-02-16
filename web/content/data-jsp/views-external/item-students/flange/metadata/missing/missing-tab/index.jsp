<script>
    $(document).ready(function () {
        var itemLevel = 0;
        var itemCareer = 0;
        var itemPeriod = 0;
        var itemGroup = 0;
        var itemSemester = 0;
        createDropDownStudyLevelByDirector("#levelFilter",false);
        itemLevel = $('#levelFilter').jqxDropDownList('getSelectedItem');
        if(itemLevel!==undefined){
            createDropDownCareerByDirector( itemLevel.value ,"#careerFilter",false);
            itemCareer = $('#careerFilter').jqxDropDownList('getSelectedItem');
            createDropDownPeriod("comboActiveYear","#periodFilter");
            itemPeriod = $('#periodFilter').jqxDropDownList('getSelectedItem');
            if(itemPeriod!==undefined){
                createDropDownSemesterByDirector(itemPeriod.value, itemLevel.value,"#semesterFilter",false);
                itemSemester = $('#semesterFilter').jqxDropDownList('getSelectedItem');
                if(itemSemester!==undefined){
                    createDropDownGruopByDirector(itemPeriod.value, itemSemester.value, "#groupFilter",false);
                    itemGroup = $('#groupFilter').jqxDropDownList('getSelectedItem');
                }else{
                    createDropDownGruopByDirector(null, null, "#groupFilter",false);
                }
            }else{
                createDropDownSemesterByDirector(null, null,"#semesterFilter",false);
                createDropDownGruopByDirector(null, null, "#groupFilter",false);
            }
            $('#levelFilter').on('change',function (event){  
                itemLevel = $('#levelFilter').jqxDropDownList('getSelectedItem');
                if(itemLevel!==undefined){
                    createDropDownCareerByDirector(itemLevel.value, "#careerFilter", true);
                    itemPeriod = $('#periodFilter').jqxDropDownList('getSelectedItem');
                    if(itemPeriod!==undefined){
                        itemCareer = $('#careerFilter').jqxDropDownList('getSelectedItem');
                        createDropDownSemesterByDirector(itemPeriod.value, itemLevel.value,"#semesterFilter", true);
                        itemSemester = $('#semesterFilter').jqxDropDownList('getSelectedItem'); 
                    }else{
                        createDropDownSemesterByDirector(null, null,"#semesterFilter", true);
                    }
                }else{
                    createDropDownCareerByDirector(null, "#careerFilter", true);
                    createDropDownSemesterByDirector(null, null,"#semesterFilter", true);
                }
                
            });
            $('#careerFilter').on('change',function (event){           
                itemCareer = $('#careerFilter').jqxDropDownList('getSelectedItem');
            });
            $("#semesterFilter").on('change',function (){
                itemPeriod = $('#periodFilter').jqxDropDownList('getSelectedItem');
                if(itemPeriod!==null){
                    itemSemester = $('#semesterFilter').jqxDropDownList('getSelectedItem');
                    if(itemSemester!==undefined){
                        createDropDownGruopByDirector(itemPeriod.value, itemSemester.value, "#groupFilter",true);
                    }else{
                        createDropDownGruopByDirector(null, null, "#groupFilter",true);
                    }
                }else{
                    createDropDownGruopByDirector(null, null, "#groupFilter",true);
                }
            });
            $("#groupFilter").on('change',function (){  
                loadDataAdapter();
            });
            loadDataAdapter();
        }else{
            createDropDownCareerByDirector(null ,"#careerFilter",false);
            createDropDownPeriod("comboActiveYear","#periodFilter");
            createDropDownSemesterByDirector(null, null,"#semesterFilter",false);
            createDropDownGruopByDirector(null, null, "#groupFilter",false);
        }
        function loadSource(){
            var valItemCareer=0;
            var valItemGroup=0;
            itemCareer = $('#careerFilter').jqxDropDownList('getSelectedItem');
            itemGroup = $('#groupFilter').jqxDropDownList('getSelectedItem');
            if(itemCareer!==undefined){
                valItemCareer=itemCareer.value;
            }
            if(itemGroup!==undefined){
                valItemGroup=itemGroup.value;
            }          
            var ordersSource ={
                dataFields: [
                    { name: 'dataProgresivNumber', type:'int'},
                    { name: 'dataEnrollment', type: 'string' },
                    { name: 'dataStudentName', type: 'string' }
                ],
                dataType: "json",
                async: false,
                url: '../serviceStudent?selectStudentsMissingMetadata',
                data:{
                    "pt_group":valItemGroup,
                    "pt_career":valItemCareer
                }
            };
            return ordersSource;
        }
        var dataAdapter;
        function loadDataAdapter(){
            var rows;
            dataAdapter = new $.jqx.dataAdapter(loadSource(),{
                loadComplete: function () {
                    rows = dataAdapter.records.length;   
                    if(rows>0){
                        $("#exportButton").jqxButton({disabled: false});
                    }else{
                        $("#exportButton").jqxButton({disabled: true});
                    }                    
                }
            });
            $("#tableStudentMetadata").jqxDataTable({
                width: 700,
                height : 500,
                selectionMode: "none",
                localization: getLocalization("es"),
                source: dataAdapter,
                pageable: false,
                showToolbar: true,
                altRows: true,
                toolbarHeight: 35,
                renderToolbar: function(toolBar){
                    var theme = "";
                    var toTheme = function (className) {
                        if (theme === "") return className;
                        return className + " " + className + "-" + theme;
                    };
                    // appends buttons to the nameCareerAbreiated bar.
                    var container = $("<div style='overflow: hidden; position: relative; height: 100%; width: 100%;'></div>");
                    var buttonTemplate = "<div style='float: left; padding: 3px; margin: 2px;'><div style='margin: 4px; width: 16px; height: 16px;'></div></div>";
                    var exportButton = $(buttonTemplate);
                    container.append(exportButton);
                    toolBar.append(container);
                    exportButton.jqxButton({cursor: "pointer", disabled: true, enableDefault: false,  height: 25, width: 25 });
                    exportButton.find('div:first').addClass(toTheme('jqx-icon-export'));
                    exportButton.jqxTooltip({ position: 'bottom', content: "Exportar a PDF"});
                    exportButton.attr("id","exportButton");       
                    exportButton.click(function (event) {
                        itemCareer = $('#careerFilter').jqxDropDownList('getSelectedItem');
                        itemGroup = $('#groupFilter').jqxDropDownList('getSelectedItem');
                        $.ajax({
                            url: "../content/data-jr/studentsByGroupMetadataMissing/index.jsp?sessionStudentsByGroupMetadataMissing",
                            data: {
                                "pt_career": itemCareer.value,
                                "pt_group": itemGroup.value
                            },
                            type: 'POST',
                            beforeSend: function (xhr) {
                            },
                            success: function (data, textStatus, jqXHR) {
                                window.open("../content/data-jr/studentsByGroupMetadataMissing");
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                alert("Error interno del servidor");                
                            }
                        });
                    });   
                    
                },
                ready: function(){ 
                },
                columns: [
                    { text: 'NP', dataField: 'dataProgresivNumber', width: 25 },
                    { text: 'Matrícula', dataField: 'dataEnrollment', width: 160},
                    { text: 'Alumno', dataField: 'dataStudentName'}
                ]
            }); 
        }        
    });
</script>
<div style="float: left; margin-right: 5px;">
    Nivel de estudio<br>
    <div id='levelFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Carrera <br>
    <div id='careerFilter'></div>
</div>
<div style="float: right; margin-right: 5px; display: none">
    Periodo <br>
    <div id='periodFilter'></div>
</div>
<br><br><br>
<div style="float: left; margin-right: 5px;">
    Cuatrimestre<br>
    <div id='semesterFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Grupo<br>
    <div id='groupFilter'></div>
</div>
<br><br><br>
<div style="float: left; margin-right: 5px" id="tableStudentMetadata"></div>