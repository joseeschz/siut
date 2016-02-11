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
        var filtrableActivities=[];
        var itemsScaleEvaluation=[];
        var rowExternal;
        var btns = $("#btnLast, #btnNext, #btnPrev, #btnFirst");
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
                        createDropDownSubjectMatterByTeacher(itemPeriod.value, itemCareer.value, itemSemester.value, null, "#registerCalFlangeSubjectMatterFilter", false);
                        $("#registerCalFlangeSubjectMatterFilter").jqxDropDownList({width: 300});
                        itemSubjectMatter=$('#registerCalFlangeSubjectMatterFilter').jqxDropDownList('getSelectedItem');
                        if(itemSubjectMatter!==undefined){
                            createDropDownScaleEvaluationBloqued("#calTeacherScaleEvaluationFilter", itemPeriod.value, itemSubjectMatter.value, false);
                            itemScaleEvaluation = $('#calTeacherScaleEvaluationFilter').jqxDropDownList('getSelectedItem');
                            if(itemScaleEvaluation!==undefined){                                
                                //exitWorkPlanning();
                                initDropDownActivities(false);
                                loadTable();
                            }else{
                                $("#register").hide();
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
            });
            $("#registerCalFlangeSubjectMatterFilter").on('change',function (){
                itemPeriod = $('#registerCalFlangePeriodFilter').jqxDropDownList('getSelectedItem');
                itemSubjectMatter=$('#registerCalFlangeSubjectMatterFilter').jqxDropDownList('getSelectedItem');
                createDropDownScaleEvaluationBloqued("#calTeacherScaleEvaluationFilter", itemPeriod.value, itemSubjectMatter.value, true);
                itemScaleEvaluation = $('#calTeacherScaleEvaluationFilter').jqxDropDownList('getSelectedItem');  
                if(itemScaleEvaluation==undefined){
                    $("#register").hide();
                    createDropDownActivities("#calTeacherActivitiesFilter", [], true);
                    $('#tableRegisterCalActivities').jqxGrid("clear");
                    $("#evaluateActivity").parent().fadeOut("slow");
                }else{
                    $("#register").show();
                }
            });
            $("#calTeacherScaleEvaluationFilter").on('change',function (event){
                itemScaleEvaluation = $('#calTeacherScaleEvaluationFilter').jqxDropDownList('getSelectedItem');  
                if(itemScaleEvaluation!==undefined){
                    initDropDownActivities(true);
                }else{
                    createDropDownActivities("#calTeacherActivitiesFilter", [], true);
                    $('#tableRegisterCalActivities').jqxGrid("clear");
                }
            });
            $("#calTeacherActivitiesFilter").on('change',function (event){
                if(itemActivity!==undefined){
                    $('#tableRegisterCalActivities').fadeIn("slow");
                    maxValActivity();
                    loadTable();
                }else{
                    $('#tableRegisterCalActivities').hide();
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
        $("#evaluateActivity").click(function (){
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
                    "pkCareer": valItemCareer, 
                    "pkSemester": valItemSemester, 
                    "pkGroup": valItemGroup, 
                    "pkMatter": valItemSubjectMatter, 
                    "pkActivity": valItemActivity, 
                    "pkPeriod": valItemPeriod
                },
                beforeSend: function (xhr) {
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    //This is if exits an error with the server internal can do server off, or page not found
                    alert("Error interno del servidor");
                },
                success: function (data, textStatus, jqXHR) {
                    maxValActivity();
                    loadTable();
                }
            });
        });
        function isClosedWorkPlanning(){
            itemSubjectMatter= $('#registerCalFlangeSubjectMatterFilter').jqxDropDownList('getSelectedItem'); 
            itemGroup = $('#registerCalFlangeGroupFilter').jqxDropDownList('getSelectedItem');
            itemPeriod = $('#registerCalFlangePeriodFilter').jqxDropDownList('getSelectedItem');
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
                        $('#jqxTabs').jqxTabs('enableAt', 1);
                        $('#jqxTabs').jqxTabs('enableAt', 2);
                    }else{
                        //$('#jqxTabs').jqxTabs('disableAt', 1);
                        //$('#jqxTabs').jqxTabs('disableAt', 2);
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert("Error interno del servidor");                
                }
            });
            return status;
        }
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
            if(itemActivity!==undefined){
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
                    { name: 'dataValueObtaniedEquivalent', type: 'double' },
                    { name: 'dataAcomulatedNow', type: 'double' }
                ],
                root: "__ENTITIES",
                type:"POST",
                dataType: "json",
                id: 'id',
                async: false,
                url: '../serviceActivitiesCalByStudents?view=average&&pkCareer='+valItemCareer+'&&pkSemester='+valItemSemester+'&&pkActivity='+valItemActivity+'&&pkGroup='+valItemGroup+'&&pkPeriod='+valItemPeriod+''
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
        $("#register").jqxExpander({ 
            width: '340px',
            showArrow: false,
            toggleMode: "none"
        });
        function loadEventRowclick(){
            var varIsClosed = isClosedWorkPlanning();
            if(varIsClosed!=1){
                $('#tableRegisterCalActivities').off('rowclick');
                $('#tableRegisterCalActivities').off('rowselect');
                $('#tableRegisterCalActivities').on('rowclick', function (event){
                    // event args.
                    var args = event.args;
                    // row data.
                    var row = $('#tableRegisterCalActivities').jqxGrid('getrowdata', args.rowindex);//args.row;
                    $('#tableRegisterCalActivities').jqxGrid({ selectedrowindex: args.rowindex}); 
                    if(row.dataValueObtanied!==""){
                        $("#dataEnrollment").text(row.dataEnrollment);
                        $("#dataNameStudent").text(row.dataNameStudent);
                        $("#dataValueObtanied").val(convertionToFix(row.dataValueObtanied));                        
                        $("#evaluateActivity").parent().hide();
                    }else{
                        $("#evaluateActivity").parent().show();
                    }
                });
                $('#tableRegisterCalActivities').on('rowselect', function (event){
                    var row = $('#tableRegisterCalActivities').jqxGrid('getrowdata', event.args.rowindex);//args.row;
                    if(row.dataValueObtanied!==""){
                        $("#dataEnrollment").text(row.dataEnrollment);
                        $("#dataNameStudent").text(row.dataNameStudent);
                        $("#dataValueObtanied").val(convertionToFix(row.dataValueObtanied));
                        $("#evaluateActivity").parent().hide();
                        $("#captureCal").show();
                    }else{
                        console.log(row);
                        $("#captureCal").hide();
                        $("#evaluateActivity").parent().show();
                    }
                });
            }else{
                $('#tableRegisterCalActivities').off('rowclick');
            }
            return varIsClosed;
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
                        totalPercent=totalPercent+((ordersSource.items[ia].dataValueActivity*100)/ordersSource.items[ia].dataMaxValueScale);
                        //totalEquivalent=totalEquivalent+ordersSource.items[ia].dataValueObtaniedEquivalent;
                        trOnTbody=$('<tr><td>'+ordersSource.items[ia].dataNameActivity+'</td><td align="center">'+ordersSource.items[ia].dataValueActivity+'</td><td align="center">'+((ordersSource.items[ia].dataValueActivity*100)/ordersSource.items[ia].dataMaxValueScale)+'%</td><td align="center">'+ordersSource.items[ia].dataValueObtanied+'</td><td align="center">'+ordersSource.items[ia].dataValueObtaniedEquivalent+'</td></tr>');
                        trOnTbody.appendTo(tbody); 
                        subtotalScale=subtotalScale+parseFloat(ordersSource.items[ia].dataValueActivity);
                        subtotalScaleObtanied=subtotalScaleObtanied+parseFloat(ordersSource.items[ia].dataValueObtanied);
                    }                    
                    var equivalent=(subtotalScaleObtanied*10/subtotalScale).toFixed(1);
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
                    tfoot=$('<tfoot><tr><th align="right">Subtotal</th><th align="center">'+subtotalScale+'</th><th align="center">'+totalPercent+'%</th><th align="center">'+subtotalScaleObtanied+'</th><th align="center">'+totalEquivalent+'</th></tr></tfoot>');
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
            status = loadEventRowclick();            
            var cellclass = function (row, columnfield, value) {
                var classTheme="";
                if(status==1){
                    var data = $('#tableRegisterCalActivities').jqxGrid('getrowdata', row);
                    if(data.dataAcomulatedNow>="8"){
                        classTheme="approved";
                    }else{
                        classTheme="not-approved";
                    }                    
                }else{
//                    var data = $('#tableRegisterCalActivities').jqxGrid('getrowdata', row);
//                    if(data.dataAcomulatedNow===""){
//                        classTheme="disabled";
//                    }else{
//                        classTheme="";
//                    } 
                }
                return classTheme;
            };
            $("#tableRegisterCalActivities").jqxGrid({
                width: 600,
                height:450,
                selectionMode: "singlerow",
                localization: getLocalization("es"),
                source: dataAdapter,
                pageable: false,
                editable: false,
                filterable: false,
                altRows: true,
                columns: [
                    { text: '#',dataField: 'dataProgresivNumber', cellclassname: cellclass, width: 20},
                    { text: 'Matrícula',disabled: true, align: 'center', dataField: 'dataEnrollment', width: 120, cellclassname: cellclass },
                    { text: 'Alumno',disabled: true, align: 'center', dataField: 'dataNameStudent', cellclassname: cellclass},
                    { text: 'R', columngroup: 'rating', dataField: 'dataValueObtanied', cellsalign: 'center', align: 'center', width: 50, cellclassname: cellclass },
                    { text: 'E', columngroup: 'rating', dataField: 'dataValueObtaniedEquivalent', cellsalign: 'center', align: 'center', width: 50, cellclassname: cellclass },
                    { text: 'Total', dataField: 'dataAcomulatedNow', cellsalign: 'center', align: 'center', width: 50, cellclassname: cellclass }
                ],
                columngroups: [{
                    text: 'Calificación',
                    name: 'rating',
                    align: 'center'
                }]
            });
            if(status==1){                
                $('#tableRegisterCalActivities').jqxGrid({ enablehover: false, selectionmode: 'none'});
            }
            $("#tableRegisterCalActivities").jqxGrid('focus');
            
            if(length>0){
                if(status==1){
                    $('#tableRegisterCalActivities').jqxGrid('clearselection');
                    $("#detailsScaleEvaluation").parent().hide("fast");
                    $("#dataValueObtanied").jqxSlider({ disabled: true }); 
                    btns.jqxButton({disabled: true});
                    $("#dataEnrollment").text("Sin dato");
                    $("#dataNameStudent").text("Sin dato");
                }else{
                    $("#register").show();
                    $("#dataEnrollment").text("");
                    $("#dataNameStudent").text("");
                    $("#detailsScaleEvaluation").parent().show("fast");
                    $('#tableRegisterCalActivities').jqxGrid('selectrow', 0);
                    $("#dataValueObtanied").jqxSlider({ disabled: false }); 
                     btns.jqxButton({disabled: false});
                }
                var data = $('#tableRegisterCalActivities').jqxGrid('getrowdata', 0);
                if(data.dataValueObtanied!==""){
                    $("#evaluateActivity").parent().hide();
                    $("#captureCal").show();
                }else{                    
                    $("#evaluateActivity").parent().show();
                    $("#captureCal").hide();
                }
                
            }else{
                $("#captureCal").hide();
                $("#evaluateActivity").parent().show();
            }
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
        function initDropDownActivities(update){
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
                exitWorkPlanning();
                valItemScaleEvaluation=itemScaleEvaluation.value;
                filtrableActivities[0]=$("#pkWorkPlannig").val();
                filtrableActivities[1]=valItemPeriod;
                filtrableActivities[2]=valItemLevel;
                filtrableActivities[3]=valItemSubjectMatter;
                filtrableActivities[4]=valItemGroup;
                filtrableActivities[5]=valItemScaleEvaluation;
                createDropDownActivities("#calTeacherActivitiesFilter", filtrableActivities, update);
                itemActivity = $('#calTeacherActivitiesFilter').jqxDropDownList('getSelectedItem'); 
                maxValActivity();
            }            
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
                        maxValScale = data[0].dataMaxValue;
                        $("#valMaxScale").text(maxValScale+" = 100%");
                    }
                });
            }
            return maxValScale;
        }
        function maxValActivity(){
            itemActivity = $('#calTeacherActivitiesFilter').jqxDropDownList('getSelectedItem');
            if(itemActivity!==undefined){
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
                        value_max=data[0].dataValueActivity;
                        $('#tableRegisterCalActivities').show();
                    }
                });
                itemScaleEvaluation = $("#calTeacherScaleEvaluationFilter").jqxDropDownList('getSelectedItem');
                var val_max_scale = maxValScale(itemScaleEvaluation.value);
                $("#valMaxActivity").text(Math.round((value_max*100/val_max_scale))+"%");
            }else{
                $('#tableRegisterCalActivities').fadeOut("slow");
            }
        }
        $('#dataValueObtanied').jqxSlider({
            theme:"",
            width:"200px",
            height:"10px",
            mode:'fixed',
            tooltip: true,
            tooltipPosition: "far",
            step:0.1,
            ticksFrequency: 1,
            showTickLabels: true,
            ticksPosition:'bottom'
        });
        $('#dataValueObtanied').jqxSlider({ tooltipFormatFunction: function(value){
                return (value.toFixed(1));
            }
        });
        $("#dataValueObtanied").on("change", function (){
            var rowindex = $('#tableRegisterCalActivities').jqxGrid('getselectedrowindex');
            rowExternal = $('#tableRegisterCalActivities').jqxGrid('getrowdata', rowindex);
            var dataValueObtaniedOld=$('#tableRegisterCalActivities').jqxGrid('getcellvalue', rowindex, "dataValueObtanied");
            var dataAcomulatedNow = $('#tableRegisterCalActivities').jqxGrid('getcellvalue', rowindex, "dataAcomulatedNow");
            dataAcomulatedNow=parseFloat(dataAcomulatedNow);
            var dataValueObtaniedNew=parseFloat(convertionInverseToFix($("#dataValueObtanied").val()));
            var total=((dataValueObtaniedNew-dataValueObtaniedOld)+dataAcomulatedNow);
            $.ajax({
                //Send the paramethers to servelt
                type: "POST",
                async: false,
                url: "../serviceActivitiesCalByStudents",
                data:{
                    "update":"1",
                    "pkActivityByStudent": rowExternal.id, 
                    "valueOptanied": dataValueObtaniedNew.toFixed(2)
                },
                beforeSend: function (xhr) {
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    //This is if exits an error with the server internal can do server off, or page not found
                    alert("Error interno del servidor");
                },
                success: function (data, textStatus, jqXHR) {  
                    $("#tableRegisterCalActivities").jqxGrid('setcellvalue', rowindex, "dataAcomulatedNow", (total.toFixed(2)));
                    $("#tableRegisterCalActivities").jqxGrid('setcellvaluebyid', rowExternal.id, "dataValueObtanied", dataValueObtaniedNew.toFixed(2));
                    var equivalent=0;
                    if(($("#dataValueObtanied").val().toFixed(1))==="10.0"){
                        equivalent=10;
                    }else{
                        equivalent = ($("#dataValueObtanied").val().toFixed(1));
                    }
                    $("#tableRegisterCalActivities").jqxGrid('setcellvaluebyid', rowExternal.id, "dataValueObtaniedEquivalent", equivalent);
                }
            });
        });
        
        btns.jqxButton({theme: theme, cursor: "pointer",  height: 10, width: 20 });
        var rows = $('#tableRegisterCalActivities').jqxGrid('getrows');        
        $("#btnFirst").click(function (){
            if(status!=1){
                if(rows.length>0){
                    $('#tableRegisterCalActivities').jqxGrid('selectrow', 0);
                    $('#tableRegisterCalActivities').jqxGrid('scrolloffset', 0, 0);
                }
            }
        });
        var i=0;
        $("#btnNext").click(function (){
            if(status!=1){
                var position = $('#tableRegisterCalActivities').jqxGrid('scrollposition');
                i=position.top+15;
                var rows = $('#tableRegisterCalActivities').jqxGrid('getrows'); 
                var rowindex = $('#tableRegisterCalActivities').jqxGrid('getselectedrowindex');
                if(rowindex<rows.length-1){
                    $('#tableRegisterCalActivities').jqxGrid('selectrow', rowindex+1);
                    $('#tableRegisterCalActivities').jqxGrid('scrolloffset', i, 0);
                }     
            }
        });
        var d=110;
        $("#btnPrev").click(function (){
            if(status!=1){
                var position = $('#tableRegisterCalActivities').jqxGrid('scrollposition');
                d=position.top-15;
                var rowindex = $('#tableRegisterCalActivities').jqxGrid('getselectedrowindex');
                if(rowindex>=1){
                    $('#tableRegisterCalActivities').jqxGrid('selectrow', rowindex-1);
                    $('#tableRegisterCalActivities').jqxGrid('scrolloffset', d, 0);
                }
            }
        });        
        $("#btnLast").click(function (){
            if(status!=1){
                var rows = $('#tableRegisterCalActivities').jqxGrid('getrows'); 
                $('#tableRegisterCalActivities').jqxGrid('selectrow', (rows.length-1));
                $('#tableRegisterCalActivities').jqxGrid('scrolloffset', 400, 0);
            }
        });
        var evaluateActivity = $("#evaluateActivity");
        evaluateActivity.jqxTooltip({ position: 'bottom', content: "Evaluar actividad"});
        evaluateActivity.jqxButton({"height": 20, "width": 20, cursor: "pointer"});
        function convertionToFix(value){
            return value*10/value_max;
        }
        function convertionInverseToFix(value){
            return value/10*value_max;
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
        $("#tableRegisterCalActivities").on('rowclick', function (event) {
            if (event.args.rightclick) {
                $("#tableRegisterCalActivities").jqxGrid('selectrow', event.args.rowindex);
                var scrollTop = $(window).scrollTop();
                var scrollLeft = $(window).scrollLeft();
                contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                return false;
            }
        });
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
        background-color: rgb(225, 139, 139) !important;
    }
</style>
<div id="slider"></div>
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
<br><br><br>
<div style="float: left; margin-right: 5px;">
    Cuatrimestre<br>
    <div id='registerCalFlangeSemesterFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Grupo<br>
    <div id='registerCalFlangeGroupFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Materia<br>
    <div id='registerCalFlangeSubjectMatterFilter'></div>
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
<div style="display: none; float: left; margin-right: 5px; text-align: center;">
    Valor<br>
    <div id='valMaxActivity' style="font-size: 23px;"></div>
</div>
<div style="float: left; margin-right: 5px; text-align: center; display: none;">
    Acción<br>
    <div id="evaluateActivity" style="height: 28px; margin-left: 7px;">
        <div class="jqx-icon-list" style="height: 20px; width: 20px;"></div>
    </div>
</div>
<br><br><br>
<div style="float: left; margin-right: 5px;">
    <div id="tableRegisterCalActivities"></div>
</div>
<div id="captureCal" style="float: left; margin-right: 5px;">
    <div id="register">
        <div>Calificación</div>
        <div id="testForm">
            <table class="register-table" style="width: 400px">
                <tr style="height: 20px">
                    <td style="width: 50px">Matrícula:</td>
                    <td id="dataEnrollment"></td>
                </tr>
                <tr style="height: 50px">
                    <td style="width: 50px">Alumno:</td>
                    <td id="dataNameStudent"></td>
                </tr>
                <tr style="height: 40px">
                    <td style="width: 50px">Calificación:</td>
                    <td>
                        <div id="dataValueObtanied" style="float: left;"></div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div style="text-align: center; float: right; margin-top: 10px;"> 
                            <div id="btnFirst" style="float: left; margin-right:5px;">
                                <div class="jqx-icon-arrow-first" style="height: 10px; width: 20px;"></div>
                            </div>
                            <div id="btnPrev" style="float: left;">
                                <div class="jqx-icon-arrow-left" style="height: 10px; width: 20px;"></div>
                            </div>
                            <div id="btnNext" style="float: left; margin-left: 5px;">
                                <div class="jqx-icon-arrow-right" style="height: 10px; width: 20px;"></div>
                            </div>
                            <div id="btnLast" style="float: left; margin-left: 5px;">
                                <div class="jqx-icon-arrow-last" style="height: 10px; width: 20px;"></div>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
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
                    //width:99%;
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