<script>
    $(document).ready(function () {
        var itemPeriod = 0;
        
        var buttonTemplate = "<div style='float: left; padding: 3px; margin: 2px;'><div style='margin: 4px; width: 16px; height: 16px;'></div></div>";
        var exportButton = $(buttonTemplate);
        var container = $("<div class='container' style='overflow: hidden; position: relative; height: 100%; width: 100%;'></div>");
        
        createDropDownPeriod("comboActiveYear","#qualificationsPeriodFilter");
        itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');        
        if(itemPeriod!=undefined || itemPeriod!=null){
            loadGridCalifications();
            $('#qualificationsPeriodFilter').on('change',function (event){  
                var args = event.args;
                if (args) {
                    // index represents the item's index.                      
                    var index = args.index;
                    var item = args.item;
                    // get item's label and value.
                    var label = item.label;
                    var value = item.value;
                    var type = args.type; // keyboard, mouse or null depending on how the item was selected. 
                    itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');
        
                    if(itemPeriod!=undefined || itemPeriod!=null){
                        loadGridCalifications();
                    }else{
                        $("#tableQualifications").parent().hide();
                    }
                }                
            });
        }else{
            $("#tableQualifications").parent().hide();
        }
        
        function loadSource(){
            itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');            
            var ordersSource ={
                dataFields: [
                    { name: 'dataProgresivNumber', type:'int'},
                    { name: 'dataYear', type:'string'},
                    { name: 'dataMonth', type:'string'},
                    { name: 'dataNameCareer', type:'string'},
                    { name: 'dataStudentsFinishedSemester', type:'int'},
                    { name: 'dataStudentsFinishedSemesterAsAcumulated', type: 'int' },
                    { name: 'dataStudentsFinishedSemesterAsRegularization', type: 'int' },
                    { name: 'dataStudentsFinishedSemesterAsGlobal', type: 'int' },
                    { name: 'dataStudentsFinishedSemesterAsRepproved', type: 'int' },
                    { name: 'dataAverageCareer', type: 'double' }
                ],
                root: "__ENTITIES",
                dataType: "json",
                id: 'id',
                async: false,
                url: '../serviceCalification?actievementQuartely',
                data:{
                    pkPeriod: itemPeriod.value
                }
            };
            return ordersSource;
        }
        function loadGridCalifications(){
            var popoverrender = function (element){
                var desc = $(element.context.innerHTML).children("div").attr("desc");
                var htmlPopover = $('<div><div>'+desc+'</div></div>');
                htmlPopover.jqxPopover({offset: {left: 0, top:0}, width:150, isModal: true, arrowOffsetValue: 10, title: "Nombre", showCloseButton: true, selector: $(element.parent().parent()) });  
            };
            var cellclass = function (row, columnfield, value) {
                return 'grey';
            };
            var dataAdapter = new $.jqx.dataAdapter(loadSource());
            var toolbarfunc = function (toolbar) {
                var themeRenderToolbar = "";
                var toTheme = function (className) {
                    if (themeRenderToolbar === "") return className;
                    return className + " " + className + "-" + themeRenderToolbar;
                }; 
                
                container.append(exportButton);
                
                toolbar.append(container);
                var me = this;    
                exportButton.jqxButton({cursor: "pointer", enableDefault: true,  height: 25, width: 25 });
                exportButton.find('div:first').addClass(toTheme('jqx-icon-export'));
                exportButton.jqxTooltip({ position: 'bottom', content: "Exportar a pdf"});
                exportButton.attr("id","exportButton");

                exportButton.off("click");
                exportButton.click(function (event){
                    printReport();
                });
            };
            var tooltiprenderer = function (element) {
                $(element).jqxTooltip({position: 'mouse', content: $(element).text() });
            };
            $("#tableQualifications").jqxGrid({
                width: 900,
                height: 450,
                selectionMode: "singlerow",
                localization: getLocalization("es"),
                source: dataAdapter,
                pageable: false,
                editable: false,
                columnsheight: 40,
                autorowheight: true,
                autoheight: true,
                toolbarheight: 34,
                filterable: false,
                altRows: true,
                columns: [                    
                    { text: '#', datafield: 'dataProgresivNumber', align:"center", cellsalign:"center", width: 25, rendered: tooltiprenderer },
                    { text: 'Mes', align: 'center', datafield: 'dataMonth', cellsalign:"center", width: 80, rendered: tooltiprenderer },
                    { text: 'Año', align: 'center', datafield: 'dataYear', cellsalign:"center", width: 80, rendered: tooltiprenderer },
                    { text: 'Carrera', align: 'center', datafield: 'dataNameCareer', width: 350, rendered: tooltiprenderer},
                    { text: 'Alumnos que finalizaron el cuatrimestre', align: 'center', cellsalign:"center",  datafield: 'dataStudentsFinishedSemester', width: 140, rendered: tooltiprenderer },
                    { text: 'Alumnos aprobados en curso acumulado', align: 'center', cellsalign:"center", datafield: 'dataStudentsFinishedSemesterAsAcumulated', width: 140, rendered: tooltiprenderer },
                    { text: 'Alumnos aprobados en periodo regularizacion', align: 'center', cellsalign:"center", datafield: 'dataStudentsFinishedSemesterAsRegularization', width: 140, rendered: tooltiprenderer },
                    { text: 'Alumnos aprobados en periodo global', align: 'center', cellsalign:"center", datafield: 'dataStudentsFinishedSemesterAsGlobal', width: 140, rendered: tooltiprenderer },
                    { text: 'Reprobados', align: 'center', cellsalign:"center", datafield: 'dataStudentsFinishedSemesterAsRepproved', width: 140, rendered: tooltiprenderer },
                    { text: 'Promedio cuatrimestral', align: 'center', cellsalign:"center", datafield: 'dataAverageCareer', width: 140, rendered: tooltiprenderer }
                ],
                showtoolbar: true,
                rendertoolbar: toolbarfunc
            });
            
        }
        function printReport(){
            itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');
            $.ajax({
                url: "../content/data-jr/quartelyAcademicAchievement/index.jsp?sessionAchievementQuartely",
                data: { 
                    "pt_period": itemPeriod.value
                },
                type: 'POST',
                beforeSend: function (xhr) {
                },
                success: function (data, textStatus, jqXHR) {
                    window.open("../content/data-jr/quartelyAcademicAchievement");
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert("Error interno del servidor");                
                }
            });
        }       
    });
</script>
<style>
    .grey {
        color: black\9;
        background-color: #DADADA;
    }
    grey:not(.jqx-grid-cell-hover):not(.jqx-grid-cell-selected), .jqx-widget .grey:not(.jqx-grid-cell-hover):not(.jqx-grid-cell-selected) {
        color: black;
        background-color: #DADADA;
    }
</style>
<div style="display: inline-block; margin-right: 5px;">
    Periodo <br>
    <div id='qualificationsPeriodFilter'></div>
</div>
<br><br>
<div style="display: inline-block; margin-right: 5px;">
    <div id="tableQualifications"></div>
</div>
<div id="popover"></div>
<style>
    .texto-vertical {
        writing-mode: vertical-lr;
        transform: rotate(180deg);
    }
</style>