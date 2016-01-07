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
        createDropDownStudyLevelByTeacher("#registerRegulaCalFlangeLevelFilter",false);
        itemLevel = $('#registerRegulaCalFlangeLevelFilter').jqxDropDownList('getSelectedItem');
        if(itemLevel!==undefined && itemCareer!==undefined){
            createDropDownCareerByTeacher( itemLevel.value ,"#registerRegulaCalFlangeCareerFilter",false);
            itemCareer = $('#registerRegulaCalFlangeCareerFilter').jqxDropDownList('getSelectedItem');
            createDropDownPeriod("comboActiveYear","#registerRegulaCalFlangePeriodFilter");
            itemPeriod = $('#registerRegulaCalFlangePeriodFilter').jqxDropDownList('getSelectedItem');
            if(itemPeriod!==undefined){
                createDropDownSemesterByTeacher(itemPeriod.value, itemLevel.value,"#registerRegulaCalFlangeSemesterFilter",false);
                itemSemester = $('#registerRegulaCalFlangeSemesterFilter').jqxDropDownList('getSelectedItem');
                if(itemSemester!==undefined){
                    createDropDownGruopByTeacher(itemPeriod.value, itemSemester.value,"#registerRegulaCalFlangeGroupFilter",false);
                    itemGroup = $('#registerRegulaCalFlangeGroupFilter').jqxDropDownList('getSelectedItem');
                    if(itemGroup!==undefined){
                        createDropDownSubjectMatterByTeacher(itemPeriod.value, itemSemester.value, itemGroup.value, "#registerRegulaCalFlangeSubjectMatterFilter", false);
                        itemSubjectMatter=$('#registerRegulaCalFlangeSubjectMatterFilter').jqxDropDownList('getSelectedItem');
                        if(itemSubjectMatter!==undefined){
                            createDropDownScaleEvaluationBloqued("#calTeacherScaleRegulaEvaluationFilter", itemPeriod.value, itemSubjectMatter.value, false);
                            $("#calTeacherScaleRegulaEvaluationFilter").jqxDropDownList({selectedIndex: 1});
                            itemScaleEvaluation = $('#calTeacherScaleRegulaEvaluationFilter').jqxDropDownList('getSelectedItem');
                            if(itemScaleEvaluation!==undefined){
                                //exitWorkPlanning();
                                initDropDownActivities(false);
                                loadTable();
                            }else{
                                createDropDownActivities("#calRegulaTeacherActivitiesFilter", [], false);
                            }
                        }
                    }else{
                        createDropDownSubjectMatterByTeacher(null, null, null, "#registerRegulaCalFlangeSubjectMatterFilter", false);
                        createDropDownScaleEvaluationBloqued("#calTeacherScaleRegulaEvaluationFilter", null, null, false);
                    }   
                }else{
                    createDropDownGruopByTeacher(null, null,"#registerRegulaCalFlangeGroupFilter",false);
                    createDropDownSubjectMatterByTeacher(null, null, null, "#registerRegulaCalFlangeSubjectMatterFilter", false);
                    createDropDownScaleEvaluationBloqued("#calTeacherScaleRegulaEvaluationFilter", null, null, false);
                }
            }else{
                createDropDownSemesterByTeacher(null, null,"#registerRegulaCalFlangeSemesterFilter",false);
                createDropDownGruopByTeacher(null, null,"#registerRegulaCalFlangeGroupFilter",false);
                createDropDownSubjectMatterByTeacher(null, null, null, "#registerRegulaCalFlangeSubjectMatterFilter", false);
                createDropDownScaleEvaluationBloqued("#calTeacherScaleRegulaEvaluationFilter", null, null, false);
            }
            $('#registerRegulaCalFlangeLevelFilter').on('change',function (event){  
                itemLevel = $('#registerRegulaCalFlangeLevelFilter').jqxDropDownList('getSelectedItem');
                createDropDownCareerByTeacher(itemLevel.value, "#registerRegulaCalFlangeCareerFilter", true);
                itemPeriod = $('#registerRegulaCalFlangePeriodFilter').jqxDropDownList('getSelectedItem');
                itemCareer = $('#registerRegulaCalFlangeCareerFilter').jqxDropDownList('getSelectedItem');
                createDropDownSemesterByTeacher(itemPeriod.value, itemLevel.value,"#registerRegulaCalFlangeSemesterFilter", true);
                itemSemester = $('#registerRegulaCalFlangeSemesterFilter').jqxDropDownList('getSelectedItem');
            });
            $('#registerRegulaCalFlangeCareerFilter').on('change',function (event){           
                itemCareer = $('#registerRegulaCalFlangeCareerFilter').jqxDropDownList('getSelectedItem');
            });
            $("#registerRegulaCalFlangeSemesterFilter").on('change',function (){
                itemPeriod = $('#registerRegulaCalFlangePeriodFilter').jqxDropDownList('getSelectedItem');
                itemSemester = $('#registerRegulaCalFlangeSemesterFilter').jqxDropDownList('getSelectedItem');
                createDropDownGruopByTeacher(itemPeriod.value, itemSemester.value,"#registerRegulaCalFlangeGroupFilter",true);
                itemGroup=$('#registerRegulaCalFlangeGroupFilter').jqxDropDownList('getSelectedItem');
            });
            $("#registerRegulaCalFlangeGroupFilter").on('change',function (){
                itemPeriod = $('#registerRegulaCalFlangePeriodFilter').jqxDropDownList('getSelectedItem');
                itemSemester = $('#registerRegulaCalFlangeSemesterFilter').jqxDropDownList('getSelectedItem');
                itemGroup = $('#registerRegulaCalFlangeGroupFilter').jqxDropDownList('getSelectedItem');
                createDropDownSubjectMatterByTeacher(itemPeriod.value, itemSemester.value, itemGroup.value, "#registerRegulaCalFlangeSubjectMatterFilter", true);
                itemSubjectMatter=$('#registerRegulaCalFlangeSubjectMatterFilter').jqxDropDownList('getSelectedItem');
            });
            $("#registerRegulaCalFlangeSubjectMatterFilter").on('change',function (){
                itemPeriod = $('#registerRegulaCalFlangePeriodFilter').jqxDropDownList('getSelectedItem');
                itemSubjectMatter = $('#registerRegulaCalFlangeSubjectMatterFilter').jqxDropDownList('getSelectedItem');
                createDropDownScaleEvaluationBloqued("#calTeacherScaleRegulaEvaluationFilter", itemPeriod.value, itemSubjectMatter.value, true);
                itemScaleEvaluation = $('#calTeacherScaleRegulaEvaluationFilter').jqxDropDownList('getSelectedItem');  
                
                if(itemScaleEvaluation==undefined){
                    createDropDownActivities("#calRegulaTeacherActivitiesFilter", [], true);
                    $('#tableRegisterCalRegulaActivities').jqxGrid("clear");
                    $("#registerRegula").jqxWindow("close");
                    $("#evaluateActivityRegula").fadeOut("slow");
                }else{
                    
                }
            });
            $("#calTeacherScaleRegulaEvaluationFilter").on('change',function (event){
                itemScaleEvaluation = $('#calTeacherScaleRegulaEvaluationFilter').jqxDropDownList('getSelectedItem');  
                if(itemScaleEvaluation!==undefined){
                    initDropDownActivities(true);
                }else{
                    createDropDownActivities("#calRegulaTeacherActivitiesFilter", [], true);
                    $('#tableRegisterCalRegulaActivities').jqxGrid("clear");
                }
            });
            $("#calRegulaTeacherActivitiesFilter").on('change',function (event){
                if(itemActivity!==undefined){
                    $('#tableRegisterCalRegulaActivities').fadeIn("slow");
                    maxValActivity();
                    loadTable();
                }else{
                    $('#tableRegisterCalRegulaActivities').hide();
                }
            }); 
            //loadActivities(2);
        }else{
            createDropDownCareerByTeacher(null ,"#registerRegulaCalFlangeCareerFilter",false);
            createDropDownPeriod("comboActiveYear","#registerRegulaCalFlangePeriodFilter");
            createDropDownSemesterByTeacher(null, null,"#registerRegulaCalFlangeSemesterFilter",false);
            createDropDownGruopByTeacher(null, null,"#registerRegulaCalFlangeGroupFilter",false);
            createDropDownSubjectMatterByTeacher(null, null, null, "#registerRegulaCalFlangeSubjectMatterFilter", false);
            createDropDownScaleEvaluationBloqued("#calTeacherScaleRegulaEvaluationFilter", null, null, false);
            createDropDownActivities("#calRegulaTeacherActivitiesFilter", [], false);
        }
        $("#evaluateActivityRegula").click(function (){
            var valItemCareer=0;
            var valItemSemester=0;
            var valItemPeriod=0;
            var valItemGroup=0;
            var valItemSubjectMatter=0;
            var valItemActivity=0;
            itemCareer = $('#registerRegulaCalFlangeCareerFilter').jqxDropDownList('getSelectedItem');
            itemSemester = $('#registerRegulaCalFlangeSemesterFilter').jqxDropDownList('getSelectedItem');
            itemPeriod = $('#registerRegulaCalFlangePeriodFilter').jqxDropDownList('getSelectedItem');
            itemGroup = $('#registerRegulaCalFlangeGroupFilter').jqxDropDownList('getSelectedItem');
            itemSubjectMatter=$('#registerRegulaCalFlangeSubjectMatterFilter').jqxDropDownList('getSelectedItem');
            itemActivity = $('#calRegulaTeacherActivitiesFilter').jqxDropDownList('getSelectedItem');
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
                $('#tableRegisterCalRegulaActivities').fadeIn("slow");
            }else{
                $('#tableRegisterCalRegulaActivities').hide();
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
            itemSubjectMatter= $('#registerRegulaCalFlangeSubjectMatterFilter').jqxDropDownList('getSelectedItem'); 
            itemGroup = $('#registerRegulaCalFlangeGroupFilter').jqxDropDownList('getSelectedItem');
            itemPeriod = $('#registerRegulaCalFlangePeriodFilter').jqxDropDownList('getSelectedItem');
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
                        $('#jqxTabs').jqxTabs('enableAt', 2);
                    }else{
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
            itemCareer = $('#registerRegulaCalFlangeCareerFilter').jqxDropDownList('getSelectedItem');
            itemSemester = $('#registerRegulaCalFlangeSemesterFilter').jqxDropDownList('getSelectedItem');
            itemPeriod = $('#registerRegulaCalFlangePeriodFilter').jqxDropDownList('getSelectedItem');
            itemGroup = $('#registerRegulaCalFlangeGroupFilter').jqxDropDownList('getSelectedItem');
            itemActivity = $('#calRegulaTeacherActivitiesFilter').jqxDropDownList('getSelectedItem');
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
                $('#tableRegisterCalRegulaActivities').fadeIn("slow");
            }else{
                $('#tableRegisterCalRegulaActivities').hide();
            }
            var ordersSource ={
                dataFields: [
                    { name: 'id', type:'int'},
                    { name: 'dataProgresivNumber', type:'int'},
                    { name: 'dataEnrollment', type:'string'},
                    { name: 'dataNameStudent', type:'string'},
                    { name: 'dataApproved', type: 'string' },
                    { name: 'dataValueObtaniedOld', type: 'double' },
                    { name: 'dataValueObtanied', type: 'double' },
                    { name: 'dataAcomulatedNow', type: 'double' }
                ],
                root: "__ENTITIES",
                type:"POST",
                dataType: "json",
                id: 'id',
                async: false,
                url: '../serviceActivitiesCalByStudents?view=regularization&&pkCareer='+valItemCareer+'&&pkSemester='+valItemSemester+'&&pkActivity='+valItemActivity+'&&pkGroup='+valItemGroup+'&&pkPeriod='+valItemPeriod+''
            };
            return ordersSource;
        }
        function loadSourceActivities(scaleEvaluation){
            var ordersSource=[];
            var valItemPeriod=0;
            var valItemSubjectMatter=0;
            var valItemLevel = 0;
            itemPeriod = $('#registerRegulaCalFlangePeriodFilter').jqxDropDownList('getSelectedItem');
            itemSubjectMatter=$('#registerRegulaCalFlangeSubjectMatterFilter').jqxDropDownList('getSelectedItem');
            itemLevel = $('#registerRegulaCalFlangeLevelFilter').jqxDropDownList('getSelectedItem');
            if(itemLevel!==undefined){
                valItemLevel=itemLevel.value;
            }
            if(itemPeriod!==undefined){
                valItemPeriod=itemPeriod.value;
            }
            if(itemSubjectMatter!==undefined){
                valItemSubjectMatter=itemSubjectMatter.value;
            }
            $.ajax({
                type:"POST",
                dataType: "json",
                async: false,
                url: '../serviceActivities?listActivities&&fk_period='+valItemPeriod+'&&fk_study_level='+valItemLevel+'&&fk_subject_matter='+valItemSubjectMatter+'&&fk_scale_evaluation='+scaleEvaluation+'',
                success: function (data, textStatus, jqXHR) {
                    ordersSource=data;
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert("Error interno en el servidor");
                }
            });
            return ordersSource;
        }
        $("#registerRegula").jqxWindow({
            theme: theme, 
            height: 160, 
            width: 410, 
            draggable: true, 
            resizable: false ,
            autoOpen: false,
            isModal: true,
            position: "center"
        });
        $('#registerRegula').on('close', function (event) {
            $('#tableRegisterCalRegulaActivities').jqxGrid('clearselection');
        }); 
        function  loadEventRowclick(){
            var varIsClosed = isClosedWorkPlanning();
            if(varIsClosed!=1){
                $('#tableRegisterCalRegulaActivities').on('rowclick', function (event){
                    itemScaleEvaluation = $('#calTeacherScaleRegulaEvaluationFilter').jqxDropDownList('getSelectedItem');
                    if(itemScaleEvaluation.index!==0){
                        // event args.
                        var args = event.args;
                        // row data.
                        var row = $('#tableRegisterCalRegulaActivities').jqxGrid('getrowdata', args.rowindex);//args.row;
                        $('#tableRegisterCalRegulaActivities').jqxGrid({ selectedrowindex: args.rowindex}); 
                        if(row.dataValueObtanied!=="Sin evaluar"){
                            $("#dataValueObtaniedRegula").jqxNumberInput({min:row.dataValueObtaniedOld});
                            $("#registerRegula").jqxWindow("open");
                            $("#dataEnrollmentRegula").text(row.dataEnrollment);
                            $("#dataNameStudentRegula").text(row.dataNameStudent);
                            $("#dataValueObtaniedRegula").val(row.dataValueObtanied);
                            $("#registerRegula").focus();
                            $("#evaluateActivityRegula").hide();
                        }else{
                            $("#evaluateActivityRegula").show();
                        }
                    }
                });
                $('#tableRegisterCalRegulaActivities').on('rowselect', function (event){
                    itemScaleEvaluation = $('#calTeacherScaleRegulaEvaluationFilter').jqxDropDownList('getSelectedItem');
                    if(itemScaleEvaluation.index!==0){
                        var row = $('#tableRegisterCalRegulaActivities').jqxGrid('getrowdata', event.args.rowindex);//args.row;
                        if(row.dataValueObtanied!=="Sin evaluar"){
                            $("#dataEnrollmentRegula").text(row.dataEnrollment);
                            $("#dataNameStudentRegula").text(row.dataNameStudent);
                            $("#dataValueObtaniedRegula").val(row.dataValueObtanied);
                            $("#registerRegula").focus();
                            $("#evaluateActivityRegula").hide();
                        }else{
                            $("#evaluateActivityRegula").show();
                        }
                    }
                });
            }else{
                $('#tableRegisterCalRegulaActivities').off('rowclick');
            }
            return varIsClosed;
        }
        
        function loadActivities(type_eval){
            var valItemsScaleEvaluation=[];
            var ordersSource=[];
            itemsScaleEvaluation = $("#calTeacherScaleRegulaEvaluationFilter").jqxDropDownList('getSelectedItem');
            if(itemsScaleEvaluation!==undefined){
                var table="";
                var thead="";
                var tbody="";
                var tfoot="";
                var trOnTbody="";
                valItemsScaleEvaluation=itemsScaleEvaluation;
                $(".tablesActivities"+type_eval).html("");
                for(var it=0; it<1; it++){
                    table=$('<table class="table-utsem table-striped table-hover" border="1"></table>');
                    thead=$('<thead><tr><th align="center" colspan="2">'+valItemsScaleEvaluation.label+'</th></tr><tr><th align="center" width="85%">Actividad</th><th align="center">Valor</th></tr></thead>');
                    tbody=$('<tbody></tbody>');
                    ordersSource=loadSourceActivities(valItemsScaleEvaluation.value);
                    var totalScale=0;
                    for(var ia=0; ia<ordersSource.items.length; ia++){
                        trOnTbody=$('<tr><td>'+ordersSource.items[ia].dataNameActivity+'</td><td align="center">'+ordersSource.items[ia].dataValueActivity+'</td></tr>');
                        trOnTbody.appendTo(tbody); 
                        totalScale=totalScale+ordersSource.items[ia].dataValueActivity;
                    }
                    tfoot=$('<tfoot><tr><th align="right">Total</th><th align="center">'+totalScale+'</th></tr></tfoot>');
                    table.append(thead);
                    table.append(tbody);
                    table.append(tfoot);
                    $(".tablesActivities"+type_eval).append(table);
                }
            }
        }
        var status;
        function loadTable(){
            var length =0 ;
            var dataAdapter = new $.jqx.dataAdapter(loadSource(),{
                loadComplete: function () {length = dataAdapter.records.length;}
            });
            if(status!=undefined){
                status=status;
            }else{
                status = loadEventRowclick();
            }
            var cellclass = function (row, columnfield, value) {
                var classTheme="";
                if(status==1){
                    classTheme="disabled";
                }
                return classTheme;
            };
            $("#tableRegisterCalRegulaActivities").jqxGrid({
                width: 620,
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
                    { text: 'Obtenido', dataField: 'dataValueObtanied', cellsalign: 'center', align: 'center', width: 70, cellclassname: cellclass },
                    { text: 'Total', dataField: 'dataAcomulatedNow', cellsalign: 'center', align: 'center', width: 50, cellclassname: cellclass }
                ]
            });
            if(status==1){
                $('#tableRegisterCalRegulaActivities').jqxGrid({ enablehover: false, selectionmode: 'none'});
            }
            $("#registerRegula").jqxWindow("close");
            $("#tableRegisterCalRegulaActivities").jqxGrid('clearselection');
            $("#tableRegisterCalRegulaActivities").jqxGrid('focus');
            
            if(length>0){
                var data = $('#tableRegisterCalRegulaActivities').jqxGrid('getrowdata', 0);
                if(data.dataValueObtanied!=="Sin evaluar"){
                    /*$("#dataEnrollmentRegula").text(data.dataEnrollment);
                    $("#dataNameStudentRegula").text(data.dataNameStudent);
                    $("#dataValueObtaniedRegula").val(data.dataValueObtanied);
                    $("#tableRegisterCalRegulaActivities").jqxGrid('focus');*/
                    $("#evaluateActivityRegula").hide();
                }else{
                    $("#evaluateActivityRegula").show();
                }
            }
        }
        function exitWorkPlanning(){
            var valItemLevel=0;
            var valItemPeriod=0;
            var valItemGroup=0;
            var valItemSubjectMatter=0;
            var valItemScaleEvaluation=0;
            itemLevel = $('#registerRegulaCalFlangeLevelFilter').jqxDropDownList('getSelectedItem');
            itemPeriod = $('#registerRegulaCalFlangePeriodFilter').jqxDropDownList('getSelectedItem');
            itemGroup = $('#registerRegulaCalFlangeGroupFilter').jqxDropDownList('getSelectedItem');
            itemSubjectMatter=$('#registerRegulaCalFlangeSubjectMatterFilter').jqxDropDownList('getSelectedItem');
            itemScaleEvaluation = $('#calTeacherScaleRegulaEvaluationFilter').jqxDropDownList('getSelectedItem');  
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
                        $("#pkWorkPlannigRegula").val(data.dataPkWorkPlanning);
                        if(data.dataRealized==="1"){
                        }else{
                        }
                    }else{
                        $("#pkWorkPlannigRegula").val(0);
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
            itemLevel = $('#registerRegulaCalFlangeLevelFilter').jqxDropDownList('getSelectedItem');
            itemPeriod = $('#registerRegulaCalFlangePeriodFilter').jqxDropDownList('getSelectedItem');
            itemGroup = $('#registerRegulaCalFlangeGroupFilter').jqxDropDownList('getSelectedItem');
            itemSubjectMatter=$('#registerRegulaCalFlangeSubjectMatterFilter').jqxDropDownList('getSelectedItem');
            itemScaleEvaluation = $('#calTeacherScaleRegulaEvaluationFilter').jqxDropDownList('getSelectedItem'); 
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
                filtrableActivities[0]=$("#pkWorkPlannigRegula").val();
                filtrableActivities[1]=valItemPeriod;
                filtrableActivities[2]=valItemLevel;
                filtrableActivities[3]=valItemSubjectMatter;
                filtrableActivities[4]=valItemGroup;
                filtrableActivities[5]=valItemScaleEvaluation;
                createDropDownActivities("#calRegulaTeacherActivitiesFilter", filtrableActivities, update);
                itemActivity = $('#calRegulaTeacherActivitiesFilter').jqxDropDownList('getSelectedItem'); 
                maxValActivity();
                loadActivities(2);
            }            
        }
        function maxValActivity(){
            itemActivity = $('#calRegulaTeacherActivitiesFilter').jqxDropDownList('getSelectedItem');
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
                        $("#dataValueObtaniedRegula").jqxNumberInput({max: value_max});
                        $('#tableRegisterCalRegulaActivities').show();
                    }
                });
            }else{
                $('#tableRegisterCalRegulaActivities').fadeOut("slow");
                $("#registerRegula").jqxWindow("close");
            }
        }
        $("#registerRegula").focusout(function (){
            $("#tableRegisterCalRegulaActivities").jqxGrid('focus');
        });
        
        $("#dataValueObtaniedRegula").jqxNumberInput({theme: theme, width: '80px', height: '26px',spinButtons: true, groupSize: 0,decimalDigits: 2,digits:2,min:0});
        $("#dataValueObtaniedRegula").on("valueChanged", function (){
            var rowindex = $('#tableRegisterCalRegulaActivities').jqxGrid('getselectedrowindex');
            rowExternal = $('#tableRegisterCalRegulaActivities').jqxGrid('getrowdata', rowindex);
            //alert(rowExternal.id);
            $.ajax({
                //Send the paramethers to servelt
                type: "POST",
                async: false,
                url: "../serviceActivitiesCalByStudents",
                data:{
                    "update":"2",
                    "pkActivityByStudent": rowExternal.id, 
                    "valueOptanied": $(this).val()
                },
                beforeSend: function (xhr) {
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    //This is if exits an error with the server internal can do server off, or page not found
                    alert("Error interno del servidor");
                },
                success: function (data, textStatus, jqXHR) {
                    var dataValueObtaniedOld=$('#tableRegisterCalRegulaActivities').jqxGrid('getcellvalue', rowindex, "dataValueObtanied");
                    var dataAcomulatedNow = $('#tableRegisterCalRegulaActivities').jqxGrid('getcellvalue', rowindex, "dataAcomulatedNow");
                    //$("");
                    dataAcomulatedNow=parseFloat(dataAcomulatedNow);
                    dataValueObtaniedOld=parseFloat(dataValueObtaniedOld);
                    var dataValueObtaniedNew=parseFloat($("#dataValueObtaniedRegula").val());
                    var total=(dataValueObtaniedNew-dataValueObtaniedOld).toFixed(2);
                    total=parseFloat(total);
                    total=(total+dataAcomulatedNow).toFixed(2);
                    $("#tableRegisterCalRegulaActivities").jqxGrid('setcellvalue', rowindex, "dataAcomulatedNow", (total));
                    $("#tableRegisterCalRegulaActivities").jqxGrid('setcellvaluebyid', rowExternal.id, "dataValueObtanied", $("#dataValueObtaniedRegula").val());
                }
            });
        });
        
        
        var btns = $("#btnLastRegula, #btnNextRegula, #btnPrevRegula, #btnFirstRegula");
        btns.jqxButton({theme: theme, cursor: "pointer",  height: 10, width: 20 });
        
        $("#btnFirstRegula").click(function (){
           var rows = $('#tableRegisterCalRegulaActivities').jqxGrid('getrows'); 
           $('#tableRegisterCalRegulaActivities').jqxGrid('selectrow', 0);
           $('#tableRegisterCalRegulaActivities').jqxGrid('scrolloffset', 0, 0);
        });
        var i=0;
        $("#btnNextRegula").click(function (){
            var position = $('#tableRegisterCalRegulaActivities').jqxGrid('scrollposition');
            i=position.top+7;
            var rows = $('#tableRegisterCalRegulaActivities').jqxGrid('getrows'); 
            var rowindex = $('#tableRegisterCalRegulaActivities').jqxGrid('getselectedrowindex');
            if(rowindex<rows.length-1){
                $('#tableRegisterCalRegulaActivities').jqxGrid('selectrow', rowindex+1);
                $('#tableRegisterCalRegulaActivities').jqxGrid('scrolloffset', i, 0);
            }           
        });
        var d=110;
        $("#btnPrevRegula").click(function (){
            var position = $('#tableRegisterCalRegulaActivities').jqxGrid('scrollposition');
            d=position.top-7;
            var rows = $('#tableRegisterCalRegulaActivities').jqxGrid('getrows'); 
            var rowindex = $('#tableRegisterCalRegulaActivities').jqxGrid('getselectedrowindex');
            if(rowindex>=1){
                $('#tableRegisterCalRegulaActivities').jqxGrid('selectrow', rowindex-1);
                $('#tableRegisterCalRegulaActivities').jqxGrid('scrolloffset', d, 0);
            }
        });        
        $("#btnLastRegula").click(function (){
           var rows = $('#tableRegisterCalRegulaActivities').jqxGrid('getrows'); 
           $('#tableRegisterCalRegulaActivities').jqxGrid('selectrow', (rows.length-1));
           $('#tableRegisterCalRegulaActivities').jqxGrid('scrolloffset', 110, 0);
        });
        var evaluateActivityRegula = $("#evaluateActivityRegula");
        evaluateActivityRegula.jqxTooltip({ position: 'bottom', content: "Evaluar actividad"});
        evaluateActivityRegula.jqxButton({"height": 20, "width": 20, cursor: "pointer"});
        
    });
</script>
<style>
    .disabled:not(.jqx-grid-cell-hover):not(.jqx-grid-cell-selected), .jqx-widget .disabled:not(.jqx-grid-cell-hover):not(.jqx-grid-cell-selected) {
        color: #656565 !important;
        background-color: #E0E0E0 !important;
    }
</style>
<div style="float: left; margin-right: 5px;">
    Nivel de estudio<br>
    <div id='registerRegulaCalFlangeLevelFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Carrera <br>
    <div id='registerRegulaCalFlangeCareerFilter'></div>
</div>
<div style="float: right; margin-right: 5px; display: none">
    Periodo <br>
    <div id='registerRegulaCalFlangePeriodFilter'></div>
</div>
<br><br><br>
<div style="float: left; margin-right: 5px;">
    Cuatrimestre<br>
    <div id='registerRegulaCalFlangeSemesterFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Grupo<br>
    <div id='registerRegulaCalFlangeGroupFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Materia<br>
    <div id='registerRegulaCalFlangeSubjectMatterFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Saber<br>
    <input type="hidden" id="pkWorkPlannigRegula"/>
    <div id='calTeacherScaleRegulaEvaluationFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Actividad<br>
    <div id="contentCalRegulaTeacherActivitiesFilter">
        <div id='calRegulaTeacherActivitiesFilter'></div>
    </div>
</div>
<div style="float: left; margin-right: 5px;">
    <br>
    <div id="evaluateActivityRegula" style="height: 28px; display: none">
        <div class="jqx-icon-list" style="height: 20px; width: 20px;"></div>
    </div>
</div>
<br><br><br>
<div style="float: left; margin-right: 5px;">
    <div id="tableRegisterCalRegulaActivities"></div>
</div>
<div style="float: left; margin-right: 5px;">
    <div id="detailsScaleEvaluation">
        <div class='jqxNavigationBar'>
            <div class="titleActivities">Todas las actividades</div>
            <div style="padding: 2px; overflow-y: auto; max-height: 318px">
                <style>
                    .table-utsem{
                        color: #779670; margin: 2px;
                        width:99%;
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
                <div class="tablesActivities2"></div>
            </div>
        </div>
    </div>
</div>
<div id="captureCal" style="float: left; margin-right: 5px; display: none">
    <div id="registerRegula">
        <div>Calificación</div>
        <div>
            <form id="testFormRegula" action="./">
                <table class="registerRegula-table" style="width: 400px">
                    <tr>
                        <td style="width: 50px">Matrícula:</td>
                        <td id="dataEnrollmentRegula"></td>
                    </tr>
                    <tr>
                        <td style="width: 50px">Alumno:</td>
                        <td id="dataNameStudentRegula"></td>
                    </tr>
                    <tr>
                        <td style="width: 50px">Calificación</td>
                        <td>
                            <div id="dataValueObtaniedRegula" style="float: left;"></div>
                            <div style="text-align: center; float: right; margin-top: 10px;"> 
                                <div id="btnFirstRegula" style="float: left; margin-right:5px;">
                                    <div class="jqx-icon-arrow-first" style="height: 10px; width: 20px;"></div>
                                </div>
                                <div id="btnPrevRegula" style="float: left;">
                                    <div class="jqx-icon-arrow-left" style="height: 10px; width: 20px;"></div>
                                </div>
                                <div id="btnNextRegula" style="float: left; margin-left: 5px;">
                                    <div class="jqx-icon-arrow-right" style="height: 10px; width: 20px;"></div>
                                </div>
                                <div id="btnLastRegula" style="float: left; margin-left: 5px;">
                                    <div class="jqx-icon-arrow-last" style="height: 10px; width: 20px;"></div>
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</div>