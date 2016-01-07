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
        var itemsScaleEvaluation = 0;
        var filtrableActivities=[];
        var rowExternal;
        createDropDownStudyLevelByTeacher("#registerGlobalCalFlangeLevelFilter",false);
        itemLevel = $('#registerGlobalCalFlangeLevelFilter').jqxDropDownList('getSelectedItem');
        if(itemLevel!==undefined && itemCareer!==undefined){
            createDropDownCareerByTeacher( itemLevel.value ,"#registerGlobalCalFlangeCareerFilter",false);
            itemCareer = $('#registerGlobalCalFlangeCareerFilter').jqxDropDownList('getSelectedItem');
            createDropDownPeriod("comboActiveYear","#registerGlobalCalFlangePeriodFilter");
            itemPeriod = $('#registerGlobalCalFlangePeriodFilter').jqxDropDownList('getSelectedItem');
            if(itemPeriod!==undefined){
                createDropDownSemesterByTeacher(itemPeriod.value, itemLevel.value,"#registerGlobalCalFlangeSemesterFilter",false);
                itemSemester = $('#registerGlobalCalFlangeSemesterFilter').jqxDropDownList('getSelectedItem');
                if(itemSemester!==undefined){
                    createDropDownGruopByTeacher(itemPeriod.value, itemSemester.value,"#registerGlobalCalFlangeGroupFilter",false);
                    itemGroup = $('#registerGlobalCalFlangeGroupFilter').jqxDropDownList('getSelectedItem');
                    if(itemGroup!==undefined){
                        createDropDownSubjectMatterByTeacher(itemPeriod.value, itemSemester.value, itemGroup.value, "#registerGlobalCalFlangeSubjectMatterFilter", false);
                        itemSubjectMatter=$('#registerGlobalCalFlangeSubjectMatterFilter').jqxDropDownList('getSelectedItem');
                        if(itemSubjectMatter!==undefined){
                            createDropDownScaleEvaluationBloqued("#calTeacherScaleGlobalEvaluationFilter", itemPeriod.value, itemSubjectMatter.value, false);
                            $("#calTeacherScaleGlobalEvaluationFilter").jqxDropDownList({selectedIndex: 1});
                            itemScaleEvaluation = $('#calTeacherScaleGlobalEvaluationFilter').jqxDropDownList('getSelectedItem');
                            if(itemScaleEvaluation!==undefined){
                                //exitWorkPlanning();
                                initDropDownActivities(false);
                                loadTable();
                            }else{
                                createDropDownActivities("#calGlobalTeacherActivitiesFilter", [], false);
                            }
                        }
                    }else{
                        createDropDownSubjectMatterByTeacher(null, null, null, "#registerGlobalCalFlangeSubjectMatterFilter", false);
                        createDropDownScaleEvaluationBloqued("#calTeacherScaleGlobalEvaluationFilter", null, null, false);
                    }   
                }else{
                    createDropDownGruopByTeacher(null, null,"#registerGlobalCalFlangeGroupFilter",false);
                    createDropDownSubjectMatterByTeacher(null, null, null, "#registerGlobalCalFlangeSubjectMatterFilter", false);
                    createDropDownScaleEvaluationBloqued("#calTeacherScaleGlobalEvaluationFilter", null, null, false);
                }
            }else{
                createDropDownSemesterByTeacher(null, null,"#registerGlobalCalFlangeSemesterFilter",false);
                createDropDownGruopByTeacher(null, null,"#registerGlobalCalFlangeGroupFilter",false);
                createDropDownSubjectMatterByTeacher(null, null, null, "#registerGlobalCalFlangeSubjectMatterFilter", false);
                createDropDownScaleEvaluationBloqued("#calTeacherScaleGlobalEvaluationFilter", null, null, false);
            }
            $('#registerGlobalCalFlangeLevelFilter').on('change',function (event){  
                itemLevel = $('#registerGlobalCalFlangeLevelFilter').jqxDropDownList('getSelectedItem');
                createDropDownCareerByTeacher(itemLevel.value, "#registerGlobalCalFlangeCareerFilter", true);
                itemPeriod = $('#registerGlobalCalFlangePeriodFilter').jqxDropDownList('getSelectedItem');
                itemCareer = $('#registerGlobalCalFlangeCareerFilter').jqxDropDownList('getSelectedItem');
                createDropDownSemesterByTeacher(itemPeriod.value, itemLevel.value,"#registerGlobalCalFlangeSemesterFilter", true);
                itemSemester = $('#registerGlobalCalFlangeSemesterFilter').jqxDropDownList('getSelectedItem');
            });
            $('#registerGlobalCalFlangeCareerFilter').on('change',function (event){           
                itemCareer = $('#registerGlobalCalFlangeCareerFilter').jqxDropDownList('getSelectedItem');
            });
            $("#registerGlobalCalFlangeSemesterFilter").on('change',function (){
                itemPeriod = $('#registerGlobalCalFlangePeriodFilter').jqxDropDownList('getSelectedItem');
                itemSemester = $('#registerGlobalCalFlangeSemesterFilter').jqxDropDownList('getSelectedItem');
                createDropDownGruopByTeacher(itemPeriod.value, itemSemester.value,"#registerGlobalCalFlangeGroupFilter",true);
                itemGroup=$('#registerGlobalCalFlangeGroupFilter').jqxDropDownList('getSelectedItem');
            });
            $("#registerGlobalCalFlangeGroupFilter").on('change',function (){
                itemPeriod = $('#registerGlobalCalFlangePeriodFilter').jqxDropDownList('getSelectedItem');
                itemSemester = $('#registerGlobalCalFlangeSemesterFilter').jqxDropDownList('getSelectedItem');
                itemGroup = $('#registerGlobalCalFlangeGroupFilter').jqxDropDownList('getSelectedItem');
                createDropDownSubjectMatterByTeacher(itemPeriod.value, itemSemester.value, itemGroup.value, "#registerGlobalCalFlangeSubjectMatterFilter", true);
                itemSubjectMatter=$('#registerGlobalCalFlangeSubjectMatterFilter').jqxDropDownList('getSelectedItem');
            });
            $("#registerGlobalCalFlangeSubjectMatterFilter").on('change',function (){
                itemPeriod = $('#registerGlobalCalFlangePeriodFilter').jqxDropDownList('getSelectedItem');
                itemSubjectMatter = $('#registerGlobalCalFlangeSubjectMatterFilter').jqxDropDownList('getSelectedItem');
                createDropDownScaleEvaluationBloqued("#calTeacherScaleGlobalEvaluationFilter", itemPeriod.value, itemSubjectMatter.value, true);
                itemScaleEvaluation = $('#calTeacherScaleGlobalEvaluationFilter').jqxDropDownList('getSelectedItem');  
                if(itemScaleEvaluation==undefined){
                    createDropDownActivities("#calGlobalTeacherActivitiesFilter", [], true);
                    $('#tableRegisterCalGlobalActivities').jqxGrid("clear");
                    $("#registerGlobal").jqxWindow("close");
                    $("#evaluateActivityGlobal").fadeOut("slow");
                }else{
                    
                }
            });
            $("#calTeacherScaleGlobalEvaluationFilter").on('change',function (event){
                itemScaleEvaluation = $('#calTeacherScaleGlobalEvaluationFilter').jqxDropDownList('getSelectedItem');  
                if(itemScaleEvaluation!==undefined){
                    initDropDownActivities(true);
                }else{
                    createDropDownActivities("#calGlobalTeacherActivitiesFilter", [], true);
                    $('#tableRegisterCalGlobalActivities').jqxGrid("clear");
                }
            });
            $("#calGlobalTeacherActivitiesFilter").on('change',function (event){
                if(itemActivity!==undefined){
                    $('#tableRegisterCalGlobalActivities').fadeIn("slow");
                    maxValActivity();
                    loadTable();
                }else{
                    $('#tableRegisterCalGlobalActivities').hide();
                }
            }); 
            //loadActivities(3);
        }else{
            createDropDownCareerByTeacher(null ,"#registerGlobalCalFlangeCareerFilter",false);
            createDropDownPeriod("comboActiveYear","#registerGlobalCalFlangePeriodFilter");
            createDropDownSemesterByTeacher(null, null,"#registerGlobalCalFlangeSemesterFilter",false);
            createDropDownGruopByTeacher(null, null,"#registerGlobalCalFlangeGroupFilter",false);
            createDropDownSubjectMatterByTeacher(null, null, null, "#registerGlobalCalFlangeSubjectMatterFilter", false);
            createDropDownScaleEvaluationBloqued("#calTeacherScaleGlobalEvaluationFilter", null, null, false);
            createDropDownActivities("#calGlobalTeacherActivitiesFilter", [], false);
        }
        $("#evaluateActivityGlobal").click(function (){
            var valItemCareer=0;
            var valItemSemester=0;
            var valItemPeriod=0;
            var valItemGroup=0;
            var valItemSubjectMatter=0;
            var valItemActivity=0;
            itemCareer = $('#registerGlobalCalFlangeCareerFilter').jqxDropDownList('getSelectedItem');
            itemSemester = $('#registerGlobalCalFlangeSemesterFilter').jqxDropDownList('getSelectedItem');
            itemPeriod = $('#registerGlobalCalFlangePeriodFilter').jqxDropDownList('getSelectedItem');
            itemGroup = $('#registerGlobalCalFlangeGroupFilter').jqxDropDownList('getSelectedItem');
            itemSubjectMatter=$('#registerGlobalCalFlangeSubjectMatterFilter').jqxDropDownList('getSelectedItem');
            itemActivity = $('#calGlobalTeacherActivitiesFilter').jqxDropDownList('getSelectedItem');
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
                $('#tableRegisterCalGlobalActivities').fadeIn("slow");
            }else{
                $('#tableRegisterCalGlobalActivities').hide();
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
            itemSubjectMatter= $('#registerGlobalCalFlangeSubjectMatterFilter').jqxDropDownList('getSelectedItem'); 
            itemGroup = $('#registerGlobalCalFlangeGroupFilter').jqxDropDownList('getSelectedItem');
            itemPeriod = $('#registerGlobalCalFlangePeriodFilter').jqxDropDownList('getSelectedItem');
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
                        $('#jqxTabs').jqxTabs('enableAt', 1);
                    }else{
                        //$('#jqxTabs').jqxTabs('enableAt', 1);
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
            itemCareer = $('#registerGlobalCalFlangeCareerFilter').jqxDropDownList('getSelectedItem');
            itemSemester = $('#registerGlobalCalFlangeSemesterFilter').jqxDropDownList('getSelectedItem');
            itemPeriod = $('#registerGlobalCalFlangePeriodFilter').jqxDropDownList('getSelectedItem');
            itemGroup = $('#registerGlobalCalFlangeGroupFilter').jqxDropDownList('getSelectedItem');
            itemActivity = $('#calGlobalTeacherActivitiesFilter').jqxDropDownList('getSelectedItem');
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
                $('#tableRegisterCalGlobalActivities').fadeIn("slow");
            }else{
                $('#tableRegisterCalGlobalActivities').hide();
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
                url: '../serviceActivitiesCalByStudents?view=global&&pkCareer='+valItemCareer+'&&pkSemester='+valItemSemester+'&&pkActivity='+valItemActivity+'&&pkGroup='+valItemGroup+'&&pkPeriod='+valItemPeriod+''
            };
            return ordersSource;
        }
        function loadSourceActivities(scaleEvaluation){
            var ordersSource=[];
            var valItemPeriod=0;
            var valItemSubjectMatter=0;
            var valItemLevel = 0;
            itemPeriod = $('#registerGlobalCalFlangePeriodFilter').jqxDropDownList('getSelectedItem');
            itemSubjectMatter=$('#registerGlobalCalFlangeSubjectMatterFilter').jqxDropDownList('getSelectedItem');
            itemLevel = $('#registerGlobalCalFlangeLevelFilter').jqxDropDownList('getSelectedItem');
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
        $("#registerGlobal").jqxWindow({
            theme: theme, 
            height: 160, 
            width: 410, 
            draggable: true, 
            resizable: false ,
            autoOpen: false,
            isModal: true,
            position: "center"
        });
        $('#registerGlobal').on('close', function (event) {
            $('#tableRegisterCalGlobalActivities').jqxGrid('clearselection');
        });
        function  loadEventRowclick(){
            var varIsClosed = isClosedWorkPlanning();
            if(varIsClosed!=1){
                $('#tableRegisterCalGlobalActivities').on('rowclick', function (event){
                    itemScaleEvaluation = $('#calTeacherScaleGlobalEvaluationFilter').jqxDropDownList('getSelectedItem');
                    if(itemScaleEvaluation.index!==0){
                        // event args.
                        var args = event.args;
                        // row data.
                        var row = $('#tableRegisterCalGlobalActivities').jqxGrid('getrowdata', args.rowindex);//args.row;
                        $('#tableRegisterCalGlobalActivities').jqxGrid({ selectedrowindex: args.rowindex}); 
                        if(row.dataValueObtanied!=="Sin evaluar"){
                            $("#dataValueObtaniedGlobal").jqxNumberInput({min:row.dataValueObtaniedOld});
                            $("#registerGlobal").jqxWindow("open");
                            $("#dataEnrollmentGlobal").text(row.dataEnrollment);
                            $("#dataNameStudentGlobal").text(row.dataNameStudent);
                            $("#dataValueObtaniedGlobal").val(row.dataValueObtanied);
                            $("#registerGlobal").focus();
                            $("#evaluateActivityGlobal").hide();
                        }else{                            
                            $("#evaluateActivityGlobal").show();
                        }
                    }
                });
                $('#tableRegisterCalGlobalActivities').on('rowselect', function (event){
                    itemScaleEvaluation = $('#calTeacherScaleGlobalEvaluationFilter').jqxDropDownList('getSelectedItem');
                    if(itemScaleEvaluation.index!==0){
                        var row = $('#tableRegisterCalGlobalActivities').jqxGrid('getrowdata', event.args.rowindex);//args.row;
                        if(row.dataValueObtanied!=="Sin evaluar"){
                            $("#dataEnrollmentGlobal").text(row.dataEnrollment);
                            $("#dataNameStudentGlobal").text(row.dataNameStudent);
                            $("#dataValueObtaniedGlobal").val(row.dataValueObtanied);
                            $("#registerGlobal").focus();
                            $("#evaluateActivityGlobal").hide();
                        }else{
                            $("#evaluateActivityGlobal").show();
                        }
                    }
                });
            }else{
                $('#tableRegisterCalGlobalActivities').off('rowclick');
            }
            return varIsClosed;
        }
        function loadActivities(type_eval){
            var valItemsScaleEvaluation=[];
            var ordersSource=[];
            itemsScaleEvaluation = $("#calTeacherScaleGlobalEvaluationFilter").jqxDropDownList('getSelectedItem');
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
            
            $("#tableRegisterCalGlobalActivities").jqxGrid({
                width: 620,
                height:450,
                selectionMode: "singlerow",
                localization: getLocalization("es"),
                source: dataAdapter,
                pageable: false,
                editable: false,
                filterable: false,
                altRows: true,
                showstatusbar: false,
                statusbarheight: 30,
                renderstatusbar: function (statusbar) {
                    // appends buttons to the status bar.
                    var container = $("<div style='overflow: hidden; position: relative; margin: 5px;'></div>");
                    var total = $("<span><a></a></span>");
                    container.append(total);
                    statusbar.append(container);
                    
                },
                columns: [
                    { text: '#',dataField: 'dataProgresivNumber', cellclassname: cellclass, width: 20},
                    { text: 'Matrícula',disabled: true, align: 'center', dataField: 'dataEnrollment', width: 120, cellclassname: cellclass },
                    { text: 'Alumno',disabled: true, align: 'center', dataField: 'dataNameStudent', cellclassname: cellclass},
                    { text: 'Obtenido', dataField: 'dataValueObtanied', cellsalign: 'center', align: 'center', width: 70, cellclassname: cellclass },
                    { text: 'Total', dataField: 'dataAcomulatedNow', cellsalign: 'center', align: 'center', width: 50, cellclassname: cellclass }
                ]
            });
            if(status==1){
                $('#tableRegisterCalGlobalActivities').jqxGrid({ enablehover: false, selectionmode: 'none'});
            }
            $("#registerGlobal").jqxWindow("close");
            $("#tableRegisterCalGlobalActivities").jqxGrid('clearselection');
            $("#tableRegisterCalGlobalActivities").jqxGrid('focus');
            
            if(length>0){
                var data = $('#tableRegisterCalGlobalActivities').jqxGrid('getrowdata', 0);
                if(data.dataValueObtanied!=="Sin evaluar"){
                    /*$("#dataEnrollmentGlobal").text(data.dataEnrollment);
                    $("#dataNameStudentGlobal").text(data.dataNameStudent);
                    $("#dataValueObtaniedGlobal").val(data.dataValueObtanied);
                    $("#tableRegisterCalGlobalActivities").jqxGrid('focus');*/
                    $("#evaluateActivityGlobal").hide();
                }else{
                    $("#evaluateActivityGlobal").show();
                }
            }
        }
        function exitWorkPlanning(){
            var valItemLevel=0;
            var valItemPeriod=0;
            var valItemGroup=0;
            var valItemSubjectMatter=0;
            var valItemScaleEvaluation=0;
            itemLevel = $('#registerGlobalCalFlangeLevelFilter').jqxDropDownList('getSelectedItem');
            itemPeriod = $('#registerGlobalCalFlangePeriodFilter').jqxDropDownList('getSelectedItem');
            itemGroup = $('#registerGlobalCalFlangeGroupFilter').jqxDropDownList('getSelectedItem');
            itemSubjectMatter=$('#registerGlobalCalFlangeSubjectMatterFilter').jqxDropDownList('getSelectedItem');
            itemScaleEvaluation = $('#calTeacherScaleGlobalEvaluationFilter').jqxDropDownList('getSelectedItem');  
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
                        $("#pkWorkPlannigGlobal").val(data.dataPkWorkPlanning);
                        if(data.dataRealized==="1"){
                        }else{
                        }
                    }else{
                        $("#pkWorkPlannigGlobal").val(0);
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
            itemLevel = $('#registerGlobalCalFlangeLevelFilter').jqxDropDownList('getSelectedItem');
            itemPeriod = $('#registerGlobalCalFlangePeriodFilter').jqxDropDownList('getSelectedItem');
            itemGroup = $('#registerGlobalCalFlangeGroupFilter').jqxDropDownList('getSelectedItem');
            itemSubjectMatter=$('#registerGlobalCalFlangeSubjectMatterFilter').jqxDropDownList('getSelectedItem');
            itemScaleEvaluation = $('#calTeacherScaleGlobalEvaluationFilter').jqxDropDownList('getSelectedItem'); 
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
                filtrableActivities[0]=$("#pkWorkPlannigGlobal").val();
                filtrableActivities[1]=valItemPeriod;
                filtrableActivities[2]=valItemLevel;
                filtrableActivities[3]=valItemSubjectMatter;
                filtrableActivities[4]=valItemGroup;
                filtrableActivities[5]=valItemScaleEvaluation;
                createDropDownActivities("#calGlobalTeacherActivitiesFilter", filtrableActivities, update);
                itemActivity = $('#calGlobalTeacherActivitiesFilter').jqxDropDownList('getSelectedItem'); 
                maxValActivity();
                loadActivities(3);
            }   
        }
        function maxValActivity(){
            itemActivity = $('#calGlobalTeacherActivitiesFilter').jqxDropDownList('getSelectedItem');
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
                        $("#dataValueObtaniedGlobal").jqxNumberInput({max: value_max});
                        $('#tableRegisterCalGlobalActivities').show();
                    }
                });
            }else{
                $('#tableRegisterCalGlobalActivities').fadeOut("slow");
                $("#registerGlobal").jqxWindow("close");
            }
        }
        $("#registerGlobal").focusout(function (){
            $("#tableRegisterCalGlobalActivities").jqxGrid('focus');
        });
        
        $("#dataValueObtaniedGlobal").jqxNumberInput({theme: theme, width: '80px', height: '26px',spinButtons: true, groupSize: 0,decimalDigits: 2,digits:2,min:0});
        $("#dataValueObtaniedGlobal").on("valueChanged", function (){
            var rowindex = $('#tableRegisterCalGlobalActivities').jqxGrid('getselectedrowindex');
            rowExternal = $('#tableRegisterCalGlobalActivities').jqxGrid('getrowdata', rowindex);
            //alert(rowExternal.id);
            $.ajax({
                //Send the paramethers to servelt
                type: "POST",
                async: false,
                url: "../serviceActivitiesCalByStudents",
                data:{
                    "update":"3",
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
                    var dataValueObtaniedOld=$('#tableRegisterCalGlobalActivities').jqxGrid('getcellvalue', rowindex, "dataValueObtanied");
                    var dataAcomulatedNow = $('#tableRegisterCalGlobalActivities').jqxGrid('getcellvalue', rowindex, "dataAcomulatedNow");
                    //$("");
                    dataAcomulatedNow=parseFloat(dataAcomulatedNow);
                    dataValueObtaniedOld=parseFloat(dataValueObtaniedOld);
                    var dataValueObtaniedNew=parseFloat($("#dataValueObtaniedGlobal").val());
                    var total=(dataValueObtaniedNew-dataValueObtaniedOld).toFixed(2);
                    total=parseFloat(total);
                    total=(total+dataAcomulatedNow).toFixed(2);
                    $("#tableRegisterCalGlobalActivities").jqxGrid('setcellvalue', rowindex, "dataAcomulatedNow", (total));
                    $("#tableRegisterCalGlobalActivities").jqxGrid('setcellvaluebyid', rowExternal.id, "dataValueObtanied", $("#dataValueObtaniedGlobal").val());
                }
            });
        });
        
        
        var btns = $("#btnLastGlobal, #btnNextGlobal, #btnPrevGlobal, #btnFirstGlobal");
        btns.jqxButton({theme: theme, cursor: "pointer",  height: 10, width: 20 });
        
        $("#btnFirstGlobal").click(function (){
           var rows = $('#tableRegisterCalGlobalActivities').jqxGrid('getrows'); 
           $('#tableRegisterCalGlobalActivities').jqxGrid('selectrow', 0);
           $('#tableRegisterCalGlobalActivities').jqxGrid('scrolloffset', 0, 0);
        });
        var i=0;
        $("#btnNextGlobal").click(function (){
            var position = $('#tableRegisterCalGlobalActivities').jqxGrid('scrollposition');
            i=position.top+7;
            var rows = $('#tableRegisterCalGlobalActivities').jqxGrid('getrows'); 
            var rowindex = $('#tableRegisterCalGlobalActivities').jqxGrid('getselectedrowindex');
            if(rowindex<rows.length-1){
                $('#tableRegisterCalGlobalActivities').jqxGrid('selectrow', rowindex+1);
                $('#tableRegisterCalGlobalActivities').jqxGrid('scrolloffset', i, 0);
            }           
        });
        var d=110;
        $("#btnPrevGlobal").click(function (){
            var position = $('#tableRegisterCalGlobalActivities').jqxGrid('scrollposition');
            d=position.top-7;
            var rows = $('#tableRegisterCalGlobalActivities').jqxGrid('getrows'); 
            var rowindex = $('#tableRegisterCalGlobalActivities').jqxGrid('getselectedrowindex');
            if(rowindex>=1){
                $('#tableRegisterCalGlobalActivities').jqxGrid('selectrow', rowindex-1);
                $('#tableRegisterCalGlobalActivities').jqxGrid('scrolloffset', d, 0);
            }
        });        
        $("#btnLastGlobal").click(function (){
           var rows = $('#tableRegisterCalGlobalActivities').jqxGrid('getrows'); 
           $('#tableRegisterCalGlobalActivities').jqxGrid('selectrow', (rows.length-1));
           $('#tableRegisterCalGlobalActivities').jqxGrid('scrolloffset', 110, 0);
        });
        var evaluateActivityGlobal = $("#evaluateActivityGlobal");
        evaluateActivityGlobal.jqxTooltip({ position: 'bottom', content: "Evaluar actividad"});
        evaluateActivityGlobal.jqxButton({"height": 20, "width": 20, cursor: "pointer"});
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
    <div id='registerGlobalCalFlangeLevelFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Carrera <br>
    <div id='registerGlobalCalFlangeCareerFilter'></div>
</div>
<div style="float: right; margin-right: 5px; display: none">
    Periodo <br>
    <div id='registerGlobalCalFlangePeriodFilter'></div>
</div>
<br><br><br>
<div style="float: left; margin-right: 5px;">
    Cuatrimestre<br>
    <div id='registerGlobalCalFlangeSemesterFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Grupo<br>
    <div id='registerGlobalCalFlangeGroupFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Materia<br>
    <div id='registerGlobalCalFlangeSubjectMatterFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Saber<br>
    <input type="hidden" id="pkWorkPlannigGlobal"/>
    <div id='calTeacherScaleGlobalEvaluationFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Actividad<br>
    <div id="contentCalGlobalTeacherActivitiesFilter">
        <div id='calGlobalTeacherActivitiesFilter'></div>
    </div>
</div>
<div style="float: left; margin-right: 5px;">
    <br>
    <div id="evaluateActivityGlobal" style="height: 28px; display: none">
        <div class="jqx-icon-list" style="height: 20px; width: 20px;"></div>
    </div>
</div>
<br><br><br>
<div style="float: left; margin-right: 5px;">
    <div id="tableRegisterCalGlobalActivities"></div>
</div>
<div style="float: left; margin-right: 5px;">
    <div id="detailsScaleEvaluation">
        <div class='jqxNavigationBar'>
            <div class="titleActivities">Actividades programadas</div>
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
                <div class="tablesActivities3"></div>
            </div>
        </div>
    </div>
</div>
<div id="captureCal" style="float: left; margin-right: 5px; display: none">
    <div id="registerGlobal">
        <div>Valor obtenido</div>
        <div>
            <form id="testFormGlobal" action="./">
                <table class="registerGlobal-table" style="width: 400px">
                    <tr>
                        <td style="width: 50px">Matrícula:</td>
                        <td id="dataEnrollmentGlobal"></td>
                    </tr>
                    <tr>
                        <td style="width: 50px">Alumno:</td>
                        <td id="dataNameStudentGlobal"></td>
                    </tr>
                    <tr>
                        <td style="width: 50px">Calificación</td>
                        <td>
                            <div id="dataValueObtaniedGlobal" style="float: left;"></div>
                            <div style="text-align: center; float: right; margin-top: 10px;"> 
                                <div id="btnFirstGlobal" style="float: left; margin-right:5px;">
                                    <div class="jqx-icon-arrow-first" style="height: 10px; width: 20px;"></div>
                                </div>
                                <div id="btnPrevGlobal" style="float: left;">
                                    <div class="jqx-icon-arrow-left" style="height: 10px; width: 20px;"></div>
                                </div>
                                <div id="btnNextGlobal" style="float: left; margin-left: 5px;">
                                    <div class="jqx-icon-arrow-right" style="height: 10px; width: 20px;"></div>
                                </div>
                                <div id="btnLastGlobal" style="float: left; margin-left: 5px;">
                                    <div class="jqx-icon-arrow-last" style="height: 10px; width: 20px;"></div>
                                </div>
                            </div>
                            <!--<span style="float: right;"><a>Materias en comun</a></span>-->
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</div>