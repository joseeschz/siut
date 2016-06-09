<script>
    $(document).ready(function () {
        var itemLevel = 0;
        var itemCareer = 0;
        var itemPeriod = 0;
        createDropDownStudyLevel("#qualificationsLevelFilter",false);
        itemLevel = $('#qualificationsLevelFilter').jqxDropDownList('getSelectedItem');
        if(itemLevel!==undefined){
            createDropDownPeriod("comboActiveYear","#qualificationsPeriodFilter");
            itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');   
            $('#qualificationsPeriodFilter').jqxDropDownList({width: 180});
            createDropDownCareer(itemLevel.value ,"#qualificationsCareerFilter",false);
            itemCareer = $('#qualificationsCareerFilter').jqxDropDownList('getSelectedItem');   
            loadTable();
        }else{
            createDropDownCareer(null ,"#qualificationsCareerFilter",false);
        }
        
        $('#qualificationsLevelFilter').on('change',function (event){  
            itemLevel = $('#qualificationsLevelFilter').jqxDropDownList('getSelectedItem');
            if(itemLevel!=undefined){
                createDropDownCareer(itemLevel.value ,"#qualificationsCareerFilter",true);
                itemCareer = $('#qualificationsCareerFilter').jqxDropDownList('getSelectedItem');
                if(itemCareer!=undefined || itemCareer!=null){
                    loadTable();
                }else{
                    $("#tableQualifications").parent().hide();
                }
            }else{
                createDropDownCareer(null ,"#qualificationsCareerFilter",true);
                $("#tableQualifications").parent().hide();
            }
        });
        $('#qualificationsPeriodFilter').on('change',function (event){  
            itemLevel = $('#qualificationsLevelFilter').jqxDropDownList('getSelectedItem');
            if(itemLevel!=undefined){
                itemCareer = $('#qualificationsCareerFilter').jqxDropDownList('getSelectedItem');
                itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');
                if(itemCareer!=undefined){                        
                   loadTable();
                }else{
                    $("#tableQualifications").parent().hide();
                }
            }else{
                createDropDownCareer(null ,"#qualificationsCareerFilter",true);
                $("#tableQualifications").parent().hide();
            }
        });
        $('#qualificationsCareerFilter').on('change',function (event){  
            var args = event.args;
            if (args) {
                // index represents the item's index.                      
                var index = args.index;
                var item = args.item;
                // get item's label and value.
                var label = item.label;
                var value = item.value;
                var type = args.type; // keyboard, mouse or null depending on how the item was selected. 
                itemCareer = $('#qualificationsCareerFilter').jqxDropDownList('getSelectedItem');
                loadTable();
            }                
        });
        function loadSource(pkCareer, pkPeriod){
            var ordersSource ={
                dataFields: [
                    { name: 'dataProgresivNumber', type:'int'},
                    { name: 'dataPkTeacher', type: 'int' },
                    { name: 'dataPkSubjectMatter', type: 'int' },
                    { name: 'dataNameSubjectMatter', type: 'string' },
                    { name: 'dataNameWorker', type: 'string' },
                    { name: 'dataBlocks', type: 'string' },
                    { name: 'dataFkSemester', type: 'int' },
                    { name: 'dataNameSemester', type: 'string' }                    
                ],
                root: "__ENTITIES",
                dataType: "json",
                async: false,
                id: 'dataProgresivNumber',
                url: '../serviceSubjectMatter?subjectMattersMissingWorkPlanning',
                data : {
                    pkCareer : pkCareer,
                    pkPeriod : pkPeriod
                }
            };
            return ordersSource;
        };
        var dataAdapter;
        function loadTable(){
            itemPeriod = $('#qualificationsPeriodFilter').jqxDropDownList('getSelectedItem');
            itemCareer = $('#qualificationsCareerFilter').jqxDropDownList('getSelectedItem'); 
            dataAdapter = new $.jqx.dataAdapter(loadSource(itemCareer.value, itemPeriod.value));
            $("#tableQualifications").jqxDataTable({
                width: 850,
                height : 300,
                selectionMode: "singleRow",
                localization: getLocalization("es"),
                source: dataAdapter,
                pageable: true,
                altRows: true,
                pagerButtonsCount: 10,
                ready: function(){

                },
                columns: [
                    { text: 'NP', dataField: 'dataProgresivNumber', width: 35, align:"center"},
                    { text: 'Materia', dataField: 'dataNameSubjectMatter', align:"center" },
                    { text: 'Profesor', dataField: 'dataNameWorker', width: 280, align:"center"},
                    { text: 'Cuatrimestre', dataField: 'dataNameSemester', width: 120, align:"center", cellsalign:"center"},
                    { text: 'Bloques', dataField: 'dataBlocks', width: 80, align:"center", cellsalign:"center"}
                ]
            });
        }
    });
</script>
<style>
    .disabled:not(.jqx-grid-cell-hover):not(.jqx-grid-cell-selected), .jqx-widget .disabled:not(.jqx-grid-cell-hover):not(.jqx-grid-cell-selected) {
        color: #656565 !important;
        background-color: #E0E0E0 !important;
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
<div style="display: inline-block; margin-right: 5px;">
    Nivel de estudio<br>
    <div id='qualificationsLevelFilter'></div>
</div>
<div style="display: inline-block; margin-right: 5px;">
    Carrera <br>
    <div id='qualificationsCareerFilter'></div>
</div>
<div style="display: inline-block; margin-right: 5px;">
    Periodo <br>
    <div id='qualificationsPeriodFilter'></div>
</div>
<div style="display: inline-block; margin-right: 5px;">
    <div style="" id="tableQualifications">Tabla</div>
</div>