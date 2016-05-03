<script type="text/javascript">
    $(document).ready(function () {
        var itemLevel = 0;
        var itemCareer = 0;
        var itemPeriod = 0;
        var itemSemester = 0;
        var itemGroup = 0;
        var itemStudyPlan = 0;
        var itemTeacher = 0;
        // appends buttons to the status bar.
        var containerElements = $("<div style='overflow: hidden; position: relative; height: 100%; width: 100%;'></div>");
        var buttonTemplate = "<div style='float: left; padding: 3px; margin: 2px;'><div style='margin: 4px; width: 16px; height: 16px;'></div></div>";
        var deleteButton = $(buttonTemplate);
        var exportButton = $(buttonTemplate);
        var dropDownTutor = $("<div style='float: right; margin: 2px;'><span style='padding: 5px; top: -7px; position: relative;'>Tutor</span><div id='studentToGroupFlangeTutorFilter'></div></div>");
        createDropDownPeriod("comboAll","#teacherToGroupFlangePeriodFilter");
        itemPeriod = $('#teacherToGroupFlangePeriodFilter').jqxDropDownList('getSelectedItem');
        createDropDownStudyLevelByDirector("#teacherToGroupFlangeLevelFilter",false);
        itemLevel = $('#teacherToGroupFlangeLevelFilter').jqxDropDownList('getSelectedItem');
        createDropDownCareerByDirector(itemLevel.value ,"#teacherToGroupFlangeCareerFilter",false);
        itemCareer = $('#teacherToGroupFlangeCareerFilter').jqxDropDownList('getSelectedItem');
        
        createDropDownStudyPlan(itemCareer.value,"#subjectMattersStudyPlanFilter",false);
        itemStudyPlan = $('#subjectMattersStudyPlanFilter').jqxDropDownList('getSelectedItem');
        createDropDownSemester(itemLevel.value,"#teacherToGroupFlangeSemesterFilter",false);
        itemSemester = $('#teacherToGroupFlangeSemesterFilter').jqxDropDownList('getSelectedItem');
        createDropDownGruop(itemSemester.value,"#teacherToGroupFlangeGroupFilter",false);
        itemGroup = $('#teacherToGroupFlangeGroupFilter').jqxDropDownList('getSelectedItem');
        
        
        $("#jqxNotification").jqxNotification({ 
            width: "100%", 
            appendContainer: "#containerNotifications", 
            opacity: 0.9, 
            autoClose: true, 
            template: "error" 
        });
        $("#jqxNotificationStudentToGroup").jqxNotification({ 
            width: "100%", 
            appendContainer: "#containerNotificationsStudentToGroup", 
            opacity: 0.9, 
            autoClose: true, 
            template: "info" 
        });
        var renderText = function (text, value) {
            if (value < 55){
                return "<span style='color: #333;'>" + text + "</span>";
            }
            return "<span style='color: #fff;'>" + text + "</span>";
        };
        $("#jqxProgressBar3").jqxProgressBar({ 
            animationDuration: 0, 
            showText: true, 
            renderText: renderText, 
            width: 250, 
            height: 30, 
            value: 0 
        });
        
        var values = {};
        var addInterval = function (id, intervalStep){
            values[id] = {value: 0};
            values[id].interval = setInterval(function (){
                values[id].value++;
                if (values[id].value == 100){
                    clearInterval(values[id].interval);
                }
                $("#" + id).val(values[id].value);
            }, intervalStep);
        };
        
        $("#working-modal").jqxWindow({
            theme:"bootstrap",
            width: 370, 
            height: 100,
            showCloseButton: false,       
            resizable: false,  
            draggable: false,
            isModal: true, 
            autoOpen: false, 
            modalOpacity: 0.1           
        });
        loadGridStudentGroup(null);
        loadTableMatersTeachers();
        
        
        $('#teacherToGroupFlangeLevelFilter').on('change',function (event){  
            var args = event.args;
            if (args) {
                // index represents the item's index.                      
                var index = args.index;
                var item = args.item;
                // get item's label and value.
                var label = item.label;
                var value = item.value;
                var type = args.type; // keyboard, mouse or null depending on how the item was selected.
                createDropDownCareerByDirector(value, "#teacherToGroupFlangeCareerFilter", true);
                createDropDownSemester(value,"#teacherToGroupFlangeSemesterFilter", true);                
            }            
        });
        
        $('#teacherToGroupFlangeCareerFilter').on('change',function (event){
            var args = event.args;
            if (args) {
                // index represents the item's index.                      
                var index = args.index;
                var item = args.item;
                // get item's label and value.
                var label = item.label;
                var value = item.value;
                var type = args.type; // keyboard, mouse or null depending on how the item was selected.
                createDropDownStudyPlan(value,"#subjectMattersStudyPlanFilter",true);                
            }   
        });
        
        $("#teacherToGroupFlangeSemesterFilter").on('change',function (event){
            var args = event.args;
            if (args) {
                // index represents the item's index.                      
                var index = args.index;
                var item = args.item;
                // get item's label and value.
                var label = item.label;
                var value = item.value;
                var type = args.type; // keyboard, mouse or null depending on how the item was selected.
                createDropDownGruop(value,"#teacherToGroupFlangeGroupFilter", true);         
            }  
        });
        
        $("#teacherToGroupFlangeGroupFilter").on('change',function (event){
            var args = event.args;
            if (args) {
                // index represents the item's index.                      
                var index = args.index;
                var item = args.item;
                // get item's label and value.
                var label = item.label;
                var value = item.value;
                var type = args.type; // keyboard, mouse or null depending on how the item was selected.    
                loadTableMatersTeachers();
            }  
        });
        
        $("#teacherToGroupFlangePeriodFilter").on('change',function (event){
            var args = event.args;
            if (args) {
                // index represents the item's index.                      
                var index = args.index;
                var item = args.item;
                // get item's label and value.
                var label = item.label;
                var value = item.value;
                var type = args.type; // keyboard, mouse or null depending on how the item was selected.
                loadTableMatersTeachers();
                if(item.originalItem.dataPkPeriodActive!=null){
                    $("#tableStudentGroup").jqxGrid({ disabled: false});
                    $("#btnBottomAdd").jqxButton({ disabled: false});
                }else{
                    $("#tableStudentGroup").jqxGrid({ disabled: true});
                    $("#btnBottomAdd").jqxButton({ disabled: true});
                }
            }  
        });
        function sourceMattersTeachers(){
            itemPeriod = $('#teacherToGroupFlangePeriodFilter').jqxDropDownList('getSelectedItem');
            itemCareer = $('#teacherToGroupFlangeCareerFilter').jqxDropDownList('getSelectedItem');
            itemStudyPlan = $('#subjectMattersStudyPlanFilter').jqxDropDownList('getSelectedItem');
            itemSemester = $('#teacherToGroupFlangeSemesterFilter').jqxDropDownList('getSelectedItem');
            itemGroup = $('#teacherToGroupFlangeGroupFilter').jqxDropDownList('getSelectedItem');
            var ordersSource ={
                datafields: [
                    { name: 'id', type:'int'},
                    { name: 'dataProgresivNumber', type:'int'},
                    { name: 'dataSemesterName', type: 'string' },
                    { name: 'dataGroupName', type: 'string' },
                    { name: 'dataPkSubjectMatter', type: 'string' },
                    { name: 'dataSubjectMatterName', type: 'string' },
                    { name: 'dataPkTeacher', type: 'string' },
                    { name: 'dataTeacherName', type: 'string' }
                ],
                root: "__ENTITIES",
                dataType: "json",
                id: 'id',
                async: false,
                url: '../serviceGroupMatterTeacher?view&pk_career='+itemCareer.value+'&pk_study_plan='+itemStudyPlan.value+'&pk_period='+itemPeriod.value+'&pk_semester='+itemSemester.value+'&pk_group='+itemGroup.value+'',
                addRow: function (rowID, rowData, position, commit) {
                },
                updateRow: function (rowID, rowData, commit) {
                },
                deleteRow: function (rowID, commit) {
                }
            };
            return ordersSource;
        }
        function loadTableMatersTeachers(){            
            resetGridAll();
            var gridAdapter = new $.jqx.dataAdapter(sourceMattersTeachers());
            var tooltiprenderer = function (element) {
                $(element).jqxTooltip({position: 'mouse', content: $(element).text() });
            };
            $("#tableGroupMatterTeacher").jqxGrid({
                width: 700,
                height: 400,
                source: gridAdapter,
                columnsresize: true,
                clipboard: false,
                selectionmode: 'singlerow',
                editmode: 'dblclick',
                autoheight: true,
                autorowheight: false,
                enabletooltips: true, 
                editable: true,
                columns: [  
                    {
                        width: "60%",
                        editable: false,
                        text: 'Materias', 
                        datafield: 'dataSubjectMatterName',
                        rendered: tooltiprenderer
                    },  
                    {
                        width: 10,
                        editable: false,
                        text: 'ID', 
                        datafield: 'dataPkTeacher',
                        rendered: tooltiprenderer
                    },  
                    {
                        width: "auto",
                        rendered: tooltiprenderer,
                        text: 'Profesores', datafield: 'dataTeacherName', displayfield: 'dataTeacherName', columntype: 'dropdownlist',
                        createeditor: function (row, value, editor) {
                            var data = $('#tableGroupMatterTeacher').jqxGrid('getrowdata', row);
                            var selectValue = data.dataPkTeacher;
                            if(data.dataPkTeacher==="0"){
                                selectValue = null;
                            }
                            createDropDownTeachers(editor, selectValue);
                        },
                        // update the editor's value before saving it.
                        cellvaluechanging: function (row, column, columntype, oldvalue, newvalue) {
                            // return the old value, if the new value is empty.
                            if (newvalue == "") return oldvalue;
                        },
                        geteditorvalue: function (row, cellvalue, editor) {
                            // return the editor's value.
                            var item = editor.jqxDropDownList('getSelectedItem'); 
                            if(item!=null){
                                $("#tableGroupMatterTeacher").jqxGrid('setcellvalue', row, "dataPkTeacher", editor.find('input').val());
                                return item.label;
                            }else{
                                return "";
                            }
                        },
                        cellbeginedit : function (row, datafield, columntype, value) {
                            var editor = $("#dropdownlisteditortableGroupMatterTeacherdataTeacherName");
                            itemPeriod = $('#teacherToGroupFlangePeriodFilter').jqxDropDownList('getSelectedItem');
                            if(itemPeriod.originalItem.dataPkPeriodActive!=null){
                                if(editor.length>0){
                                    var data = $('#tableGroupMatterTeacher').jqxGrid('getrowdata', row);
                                    var selectValue = data.dataPkTeacher;
                                    if(data.dataPkTeacher==0){
                                        selectValue = null;
                                    }
                                    var item;
                                    if(selectValue==null){
                                        item=null;

                                    }else{
                                        item = $(editor).jqxDropDownList('getItemByValue', selectValue);
                                    }
                                    $(editor).jqxDropDownList('clearFilter'); 
                                    $(editor).jqxDropDownList('clearSelection'); 
                                    $(editor).jqxDropDownList('selectItem', item ); 
                                }
                            }else{
                                return false;
                            }
                            
                        }
                    }                    
                ],
                ready: function(){
                    $('#tableGroupMatterTeacher').jqxGrid('hidecolumn', 'dataPkTeacher');
                }
            });
            var height = $('#contenttableGroupMatterTeacher').height(); 
            $("#containerNotifications").height(height-32);            
            $('#tableGroupMatterTeacher').jqxGrid('hidecolumn', 'dataPkTeacher');
            $("#tableGroupMatterTeacher").off('cellvaluechanged');
            $("#tableGroupMatterTeacher").on('cellvaluechanged', function (event) {
                // event arguments.
                var args = event.args;
                // column data field.
                var datafield = event.args.datafield;
                // row's bound index.
                var rowBoundIndex = args.rowindex;
                // new cell value.
                var value = args.newvalue;
                // old cell value.
                if (datafield === "dataTeacherName"){
                    if(value==null){
                        $("#tableGroupMatterTeacher").jqxGrid('setcellvalue', rowBoundIndex, "dataPkTeacher", 0);
                    }  
                    var rows = $('#tableGroupMatterTeacher').jqxGrid('getrows');
                    for(var i=0; i<rows.length; i++){
                        if(rows[i].dataPkTeacher==0){
                            if($("#studentToGroupFlangeTutorFilter").length>0){
                                $("#studentToGroupFlangeTutorFilter").jqxDropDownList({disabled: true});
                                $("#studentToGroupFlangeTutorFilter").jqxDropDownList('clearSelection');
                            }
                            break;
                        }else{
                            if($("#studentToGroupFlangeTutorFilter").length>0){
                                $("#studentToGroupFlangeTutorFilter").jqxDropDownList({disabled: false});
                                $("#studentToGroupFlangeTutorFilter").jqxDropDownList('clearSelection');
                            }
                        }
                    }
                }
            });
            $('#tableGroupMatterTeacher').off('rowunselect');
            $('#tableGroupMatterTeacher').on('rowunselect', function (event){
                // event arguments.
                var args = event.args;
                // row's bound index.
                var rowBoundIndex = args.rowindex;
                // row's data. The row's data object or null(when all rows are being selected or unselected with a single action). If you have a datafield called "firstName", to access the row's firstName, use var firstName = rowData.firstName;
                var rowData = args.row;
                if(args){
                    $("#tableGroupMatterTeacher").jqxGrid('endcelledit', rowBoundIndex, "dataTeacherName", false);
                }
            });
            $('#tableGroupMatterTeacher').off('rowselect');
            $('#tableGroupMatterTeacher').on('rowselect', function (event) {
                // event arguments.
                var args = event.args;
                // row's bound index.
                var rowBoundIndex = args.rowindex;
                // row's data. The row's data object or null(when all rows are being selected or unselected with a single action). If you have a datafield called "firstName", to access the row's firstName, use var firstName = rowData.firstName;
                var rowData = args.row;
                if(args){
                    if(rowData.dataPkTeacher!=0){
                        resetGridAll();
                        loadGridStudentGroup(rowData.dataPkSubjectMatter);
                        var existData = 0;
                        for (var i = 0; i < 50; i++) {
                            var data = $('#tableStudentGroup').jqxGrid('getrowdata', i);
                            if(data.dataEnrollment!==""&&data.dataStudentName!=="" && data.dataPkGroupMatterTeacherStudent!==""){
                                existData=existData+1;
                            }
                        }
                        var rows = $('#tableGroupMatterTeacher').jqxGrid('getrows');
                        for(var i=0; i<rows.length; i++){
                            if(rows[i].dataPkTeacher==0){
                                if($("#studentToGroupFlangeTutorFilter").length>0){
                                    $("#studentToGroupFlangeTutorFilter").jqxDropDownList({disabled: true});
                                    $("#studentToGroupFlangeTutorFilter").jqxDropDownList('clearSelection');
                                }
                                break;
                            }
                        }
                        if(existData>0){
                            exportButton.jqxButton({disabled: false});
                            $("#studentToGroupFlangeTutorFilter").jqxDropDownList({disabled: false});
                            $("#btnBottomAdd").jqxButton({ disabled: false});
                            $("#btnBottomAdd").text("Actualizar datos");
                        }else{
                            $("#studentToGroupFlangeTutorFilter").jqxDropDownList({disabled: false});
                            $("#btnBottomAdd").jqxButton({ disabled: false});
                            $("#btnBottomAdd").text("Agregar");
                        }
                    }else{
                        resetGridAll();
                        itemPeriod = $('#teacherToGroupFlangePeriodFilter').jqxDropDownList('getSelectedItem');
                        if(itemPeriod.originalItem.dataPkPeriodActive!=null){
                            $("#tableStudentGroup").jqxGrid({ disabled: false});
                            $("#btnBottomAdd").jqxButton({ disabled: false});
                            $("#btnBottomAdd").jqxButton({ disabled: false});
                        }else{
                            $("#tableStudentGroup").jqxGrid({ disabled: true});
                            $("#btnBottomAdd").jqxButton({ disabled: true});
                            $("#btnBottomAdd").jqxButton({ disabled: true});
                        }                        
                    }
                }
            });
            $('#tableGroupMatterTeacher').jqxGrid('clearselection');
            var data = $('#tableGroupMatterTeacher').jqxGrid('getrowdata', 0);
            if(data.dataPkTeacher!=0){
                $("#tableGroupMatterTeacher").jqxGrid('selectrow', 0);
            }
        }
        function sourcePrepareGrid(){
            var ordersSource ={
                datafields: [
                    { name: 'dataPkGroupMatterTeacherStudent', type:'int'},
                    { name: 'dataProgresivNumber', type:'int'},
                    { name: 'dataEnrollment', type: 'string' },
                    { name: 'dataStudentName', type: 'string' },
                    { name: 'dataStatusRow', type: 'int' },
                    { name: 'dataStatusRowQuestion', type: 'string' }
                ],
                root: "__ENTITIES",
                dataType: "json",
                async: false,
                id: 'dataID',
                url: '../serviceStudentsGroup?view=insert',
                addRow: function (rowID, rowData, position, commit) {
                },
                updateRow: function (rowID, rowData, commit) {
                },
                deleteRow: function (rowID, commit) {
                }
            };
            return ordersSource;
        }
        function sourceStudents(fkSubjectMatter){
            itemPeriod = $('#teacherToGroupFlangePeriodFilter').jqxDropDownList('getSelectedItem');
            itemCareer = $('#teacherToGroupFlangeCareerFilter').jqxDropDownList('getSelectedItem');
            itemSemester = $('#teacherToGroupFlangeSemesterFilter').jqxDropDownList('getSelectedItem');
            itemGroup = $('#teacherToGroupFlangeGroupFilter').jqxDropDownList('getSelectedItem');
            var ordersSource ={
                datafields: [
                    { name: 'dataPkGroupMatterTeacherStudent', type:'int'},
                    { name: 'dataProgresivNumber', type:'int'},
                    { name: 'dataEnrollment', type: 'string' },
                    { name: 'dataStudentName', type: 'string' },
                    { name: 'dataPkTutor', type: 'int' }
                ],
                root: "__ENTITIES",
                dataType: "json",
                async: false,
                id: 'dataID',
                url: '../serviceStudentsGroup?view=consult',
                data:{
                    fkCareer: itemCareer.value,
                    fkSemester : itemSemester.value,
                    fkGroup : itemGroup.value,
                    fkPeriod : itemPeriod.value,
                    fkSubjectMatter : fkSubjectMatter
                },
                addRow: function (rowID, rowData, position, commit) {
                },
                updateRow: function (rowID, rowData, commit) {
                },
                deleteRow: function (rowID, commit) {
                }
            };
            return ordersSource;
        }
        
        function loadGridStudentGroup(dataPkSubjectMatter){
            var dataAdapterPrepareGrid = new $.jqx.dataAdapter(sourcePrepareGrid());                
            if(dataPkSubjectMatter!=null){
                var existData = 0;
                for (var i = 0; i < 50; i++) {
                    var data = $('#tableStudentGroup').jqxGrid('getrowdata', i);
                    if(data.dataEnrollment!==""&&data.dataStudentName!=="" && data.dataPkGroupMatterTeacherStudent!==""){
                        existData=existData+1;
                    }
                }
                if(existData>0){
                    exportButton.jqxButton({disabled: false});  
                }else{
                    exportButton.jqxButton({disabled: true});  
                }
                
                $("#studentToGroupFlangeTutorFilter").jqxDropDownList({disabled: false});                 
                var dataAdapter = new $.jqx.dataAdapter(sourceStudents(dataPkSubjectMatter), {
                    loadComplete: function () {
                        // get data records.
                        var records = dataAdapter.records;
                        var length = records.length;
                        if(length>0){
                            $('#tableStudentGroup').jqxGrid('showloadelement');
                            resetGridAll();
                            for(var i=0; i<length;i++){
                                $("#tableStudentGroup").jqxGrid('setcellvalue', i,  "dataEnrollment", records[i].dataEnrollment);
                                $("#tableStudentGroup").jqxGrid('setcellvalue', i,  "dataPkGroupMatterTeacherStudent", records[i].dataPkGroupMatterTeacherStudent);
                                $("#tableStudentGroup").jqxGrid('setcellvalue', i,  "dataStudentName", records[i].dataStudentName);
                            }
                            $('#tableStudentGroup').jqxGrid('hideloadelement');
                            var item = $("#studentToGroupFlangeTutorFilter").jqxDropDownList('getItemByValue', records[0].dataPkTutor);
                            $("#studentToGroupFlangeTutorFilter").jqxDropDownList('selectItem', item ); 
                        }else{
                            resetGridAll();
                        }
                    }
                });
                dataAdapter.dataBind();
            }else{
                var cellclass = function (row, columnfield, value) {
                    var classTheme="";
                    var data = $('#tableStudentGroup').jqxGrid('getrowdata', row);
                    if(data.dataStatusRow===0){
                        classTheme="not-exists";
                    }else if(data.dataStatusRow===3){
                        classTheme="exist-in-same-group";
                    }else if(data.dataStatusRow===4){
                        classTheme="exist-in-diferent-group";
                    }else{
                        classTheme="";
                    }  
                    return classTheme;
                };
                var cellbeginedit = function (row, datafield, columntype, value) {
                    // some code
                    //return false;
                };
                $("#tableStudentGroup").jqxGrid({
                    width: 700,
                    height:350,
                    selectionmode: "multiplerowsextended",
                    localization: getLocalization("es"),
                    pagesizeoptions:['25', '30', '50'],
                    pagesize: 25,
                    editmode: 'dblclick',
                    source: dataAdapterPrepareGrid,
                    pageable: false,
                    editable: true,
                    showtoolbar: true,
                    keyboardnavigation: true,
                    toolbarheight: 35,
                    rendertoolbar: function(toolBar){
                        var theme = "";
                        var toTheme = function (className) {
                            if (theme === "") return className;
                            return className + " " + className + "-" + theme;
                        };
    //                    containerNotifications.append(deleteButton);
                        containerElements.append(exportButton);
                        containerElements.append(dropDownTutor);
                        toolBar.append(containerElements);
                        createDropDownTutorTeacher("#studentToGroupFlangeTutorFilter",false);
                        $("#studentToGroupFlangeTutorFilter").jqxDropDownList({disabled: true});
                        itemTeacher = $('#studentToGroupFlangeTutorFilter').jqxDropDownList('getSelectedItem');
                        $("#studentToGroupFlangeTutorFilter").jqxDropDownList('clearSelection');
                        deleteButton.jqxButton({ cursor: "pointer", disabled: true, enableDefault: true,  height: 25, width: 25 });
                        deleteButton.find('div:first').addClass(toTheme('jqx-icon-delete'));
                        deleteButton.jqxTooltip({ position: 'bottom', content: "Quitar del grupo"});

                        exportButton.jqxButton({cursor: "pointer", disabled: true, enableDefault: true,  height: 25, width: 25 });
                        exportButton.find('div:first').addClass(toTheme('jqx-icon-export'));
                        exportButton.jqxTooltip({ position: 'bottom', content: "Exportar a pdf"});
                        exportButton.attr("id","exportButton");
                        
                        exportButton.click(function (){
                            if(!exportButton.jqxButton('disabled')){
                               itemPeriod = $('#teacherToGroupFlangePeriodFilter').jqxDropDownList('getSelectedItem');
                                itemCareer = $('#teacherToGroupFlangeCareerFilter').jqxDropDownList('getSelectedItem');
                                itemStudyPlan = $('#subjectMattersStudyPlanFilter').jqxDropDownList('getSelectedItem');
                                itemSemester = $('#teacherToGroupFlangeSemesterFilter').jqxDropDownList('getSelectedItem');
                                itemGroup = $('#teacherToGroupFlangeGroupFilter').jqxDropDownList('getSelectedItem');
                                $.ajax({
                                    url: "../content/data-jr/studentsByGroup/index.jsp?sessionStudentsByGroup",
                                    data: {
                                        "pt_career": itemCareer.value,
                                        "pt_semester": itemSemester.value,
                                        "pt_group": itemGroup.value,
                                        "pt_period": itemPeriod.value
                                    },
                                    type: 'POST',
                                    beforeSend: function (xhr) {
                                    },
                                    success: function (data, textStatus, jqXHR) {
                                        window.open("../content/data-jr/studentsByGroup");
                                    },
                                    error: function (jqXHR, textStatus, errorThrown) {
                                        alert("Error interno del servidor");                
                                    }
                                }); 
                            }else{
                                
                            }
                        });
                    },
                    ready: function(){
                        $('#tableStudentGroup').jqxGrid('hidecolumn', 'dataPkGroupMatterTeacherStudent');
                        $('#tableStudentGroup').jqxGrid('hidecolumn', 'dataStatusRow');
                        $('#tableStudentGroup').jqxGrid('hidecolumn', 'dataStatusRowQuestion');
                    },
                    columns: [
                        {
                          text: '#', sortable: false, filterable: false, editable: false,
                          groupable: false, draggable: false, resizable: false,
                          datafield: '', columntype: 'number', width: 10,
                          cellsrenderer: function (row, column, value) {
                              return "<div style='margin:4px;'>" + (value + 1) + "</div>";
                          }
                        },
                        { cellclassname: cellclass,cellbeginedit:cellbeginedit, text: 'Matrícula', datafield: 'dataEnrollment', width: 130 },
                        { cellclassname: cellclass,cellbeginedit:cellbeginedit, text: 'Alumno', datafield: 'dataStudentName'},
                        { text: 'ID', datafield: 'dataPkGroupMatterTeacherStudent',  disabled: true, filterable: false, editable: false},
                        { text: 'Estado', datafield: 'dataStatusRow' ,disabled: true, filterable: false, editable: false},
                        { text: 'Pregunta', datafield: 'dataStatusRowQuestion', disabled: true, filterable: false, editable: false}
                    ]
                });
                $('#tableStudentGroup').jqxGrid('hidecolumn', 'dataPkGroupMatterTeacherStudent');
                $('#tableStudentGroup').jqxGrid('hidecolumn', 'dataStatusRow');
                $('#tableStudentGroup').jqxGrid('hidecolumn', 'dataStatusRowQuestion');
                $("#tableStudentGroup").off('cellvaluechanged');
                $("#tableStudentGroup").on('cellvaluechanged', function (event) {
                    // event arguments.
                    var args = event.args;
                    // column data field.
                    var datafield = event.args.datafield;
                    // row's bound index.
                    var rowBoundIndex = args.rowindex;
                    // new cell value.
                    var value = args.newvalue;
                    // old cell value.

                    if (datafield === "dataProgresivNumber"){
                        var oldvalue = args.oldvalue;
                        if(oldvalue!==0){
                            $("#tableStudentGroup").jqxGrid('setcellvalue', rowBoundIndex, "dataProgresivNumber", oldvalue);
                        }
                    }
                });
                $("#tableStudentGroup").off('rowselect');
                $("#tableStudentGroup").on('rowselect', function (event){
                    // event arguments.
                    var args = event.args;
                    // row's bound index.
                    var rowBoundIndex = args.rowindex;
                    // row's data. The row's data object or null(when all rows are being selected or unselected with a single action). If you have a datafield called "firstName", to access the row's firstName, use var firstName = rowData.firstName;
                    var rowData = args.row;
                    if(args){
                        $("#tableStudentGroup").jqxGrid('endcelledit', rowBoundIndex, "dataEnrollment", false);
                        $("#tableStudentGroup").jqxGrid('endcelledit', rowBoundIndex, "dataStudentName", false);
                    }
                });
                var height = $('#contenttableStudentGroup').height(); 
                $("#containerNotificationsStudentToGroup").height(height-55);
            }
        }
        var contextMenu = $("#contextMenu").jqxMenu({ width: 180, autoOpenPopup: false, mode: 'popup'});
        $("#tableStudentGroup").on('contextmenu', function () {
            return false;
        });
        // handle context menu clicks.
        $("#contextMenu").on('itemclick', function (event) {
            var args = event.args;
            var rowindex = $("#tableStudentGroup").jqxGrid('getselectedrowindex');
            if ($.trim($(args).text()) == "Quitar de la lista"){
                var selectedrowindexes = null;
                var rowIDs = new Array();
                selectedrowindexes = $('#tableStudentGroup').jqxGrid('getselectedrowindexes');
                
                var existData = 0;
                if(selectedrowindexes.length>0){
                    $("#jqxWidgetResultDelete").html("");
                    for(var i=0; i<selectedrowindexes.length; i++){                        
                        var rowid = $('#tableStudentGroup').jqxGrid('getrowid', selectedrowindexes[i]);
                        var data = $('#tableStudentGroup').jqxGrid('getrowdatabyid', rowid);
                        if(data.dataEnrollment!==""&&data.dataStudentName!=="" && data.dataPkGroupMatterTeacherStudent!==""){
                            existData=existData+1;
                            $("#jqxWidgetResultDelete").html($("#jqxWidgetResultDelete").html()+"<span class='alert-delete'>"+data.dataEnrollment+"...</span><br>");
                        }
                    }
                }else{
                    $("#jqxWidgetResultDelete").html("Sin registros...");
                }          
                if(existData>0){
                    $("#jqxWindowWarning").jqxWindow('open');
                    existData=0;
                }                
                $("#ok").off('click');
                $("#ok").on('click', function (){
                    $("#jqxWindowWarning").jqxWindow('close');
                    removeStudentBySubjectMatter(selectedrowindexes);
                });
            }
        });
        $("#tableStudentGroup").on('rowclick', function (event) {
            if (event.args.rightclick) {
                var data = $('#tableStudentGroup').jqxGrid('getrowdata', event.args.rowindex);
                $("#tableStudentGroup").jqxGrid('selectrow', event.args.rowindex);
                if(data.dataPkGroupMatterTeacherStudent!==null){
                    $("#contextMenu").jqxMenu('disable', 'removeRow', false);
                }else{
                    $("#contextMenu").jqxMenu('disable', 'removeRow', true);
                }
                
                var scrollTop = $(window).scrollTop();
                var scrollLeft = $(window).scrollLeft();
                contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                return false;
            }
        });
        
        $("#btnBottomAdd").jqxButton({ width: 202, height:49, disabled: false});

        var indexExternal = 0;
        $("#btnBottomAdd").click(function (){
            if(!$("#btnBottomAdd").jqxButton('disabled')){
                var rows = $('#tableGroupMatterTeacher').jqxGrid('getrows');
                var canBeginTransaction = true;
                canBeginTransaction = function (){
                    var result = true;
                    if(rows.length>0){
                        for(var i=0; i<rows.length; i++){
                            if(rows[i].dataPkTeacher==0 || rows[i].dataTeacherName==="null"){ 
                                result = false;
                                break;
                            }
                        }
                    }
                    return result;
                };
                if(!canBeginTransaction()){                
                    $("#notificationContent").html("Faltan materias por asociar a un profesor...");
                    $("#jqxNotification").jqxNotification("open");
                }else{                                          
                    itemTeacher = $('#studentToGroupFlangeTutorFilter').jqxDropDownList('getSelectedItem');
                    if(itemTeacher==null){
                        $('#jqxNotificationStudentToGroup').jqxNotification({ template: 'warning' }); 
                        $("#notificationStudentToGroupContent").html("Selecciona un tutor");
                        $("#jqxNotificationStudentToGroup").jqxNotification("open");
                    }else{
                        var existData = 0;
                        for (var i = 0; i < 50; i++) {
                            var data = $('#tableStudentGroup').jqxGrid('getrowdata', i);
                            if(data.dataEnrollment!==""&&data.dataStudentName!==""){
                                existData=existData+1;
                            }
                        }
                        if(existData>0){  
                            var rows = $('#tableGroupMatterTeacher').jqxGrid('getrows');
                            $("#loadTitle").text("Realizando operaciones");
                            $("#loadPreview").children("span").text("Trabajando...");
                            $("#working-modal").jqxWindow('open');
                            $("#jqxProgressBar3").val(0);
                            insertStudentBySubjectMatter(0, rows); 
                        }else{
                            $('#jqxNotificationStudentToGroup').jqxNotification({ template: 'warning' }); 
                            $("#notificationStudentToGroupContent").html("Al parecer no hay datos que agregar");
                            $("#jqxNotificationStudentToGroup").jqxNotification("open");
                        }
                    }                          
                }
            }
        });
        function resetGridAll(){
            exportButton.jqxButton({disabled: true});
            $("#btnBottomAdd").jqxButton({ disabled: true});
            $("#btnBottomAdd").text("Agregar");
            if($("#studentToGroupFlangeTutorFilter").length>0){
                $("#studentToGroupFlangeTutorFilter").jqxDropDownList({disabled: true});
                $("#studentToGroupFlangeTutorFilter").jqxDropDownList('clearSelection');
            }            
            $('#tableStudentGroup').jqxGrid('clearselection');
            for(var i=0;i<50; i++){
                $("#tableStudentGroup").jqxGrid('setcellvalue', i, "dataPkGroupMatterTeacherStudent", "");
                $("#tableStudentGroup").jqxGrid('setcellvalue', i, "dataEnrollment", "");
                $("#tableStudentGroup").jqxGrid('setcellvalue', i, "dataStudentName", "");
            }
        }
        function insertStudentBySubjectMatter(i, rows){             
            insertStudentToGroup(rows[i].dataPkTeacher, rows[i].dataPkSubjectMatter);
            if(i == rows.length-1){
                $("#working-modal").jqxWindow('close');                
                return;
            }
            setTimeout(function(){
                var steps = parseFloat(120/rows.length);
                var currentValue = $("#jqxProgressBar3").val();
                $("#jqxProgressBar3").val(currentValue+steps);
                insertStudentBySubjectMatter(i + 1, rows);   
            }, 1000);
        }
        function removeStudentBySubjectMatter(selectedrowindexes){
            $('#tableStudentGroup').jqxGrid('showloadelement');
            for(var i=0; i<selectedrowindexes.length; i++){
                var rowid = $('#tableStudentGroup').jqxGrid('getrowid', selectedrowindexes[i]);
                var rowData = $('#tableStudentGroup').jqxGrid('getrowdatabyid', rowid);
                removeStudentOfGroup(rowData);
            }
            
            var rowindex = $('#tableGroupMatterTeacher').jqxGrid('getselectedrowindex');
            var rowDataMatterTeacher = $('#tableGroupMatterTeacher').jqxGrid('getrowdata', rowindex);
            if(rowDataMatterTeacher.dataPkSubjectMatter!=null){
                var existData = 0;
                for (var i = 0; i < 50; i++) {
                    var data = $('#tableStudentGroup').jqxGrid('getrowdata', i);
                    if(data.dataEnrollment!==""&&data.dataStudentName!=="" && data.dataPkGroupMatterTeacherStudent!==""){
                        existData=existData+1;
                    }
                }
                if(existData>0){
                    exportButton.jqxButton({disabled: false});  
                }else{
                    exportButton.jqxButton({disabled: true});  
                }
                
                $("#studentToGroupFlangeTutorFilter").jqxDropDownList({disabled: false});                 
                var dataAdapter = new $.jqx.dataAdapter(sourceStudents(rowDataMatterTeacher.dataPkSubjectMatter), {
                    loadComplete: function () {
                        // get data records.
                        var records = dataAdapter.records;
                        var length = records.length;
                        if(length>0){
                            resetGridAll();
                            $('#tableStudentGroup').jqxGrid('showloadelement');
                            for(var i=0; i<length;i++){
                                $("#tableStudentGroup").jqxGrid('setcellvalue', i,  "dataEnrollment", records[i].dataEnrollment);
                                $("#tableStudentGroup").jqxGrid('setcellvalue', i,  "dataPkGroupMatterTeacherStudent", records[i].dataPkGroupMatterTeacherStudent);
                                $("#tableStudentGroup").jqxGrid('setcellvalue', i,  "dataStudentName", records[i].dataStudentName);
                            }
                            $('#tableStudentGroup').jqxGrid('hideloadelement');
                            var item = $("#studentToGroupFlangeTutorFilter").jqxDropDownList('getItemByValue', records[0].dataPkTutor);
                            $("#studentToGroupFlangeTutorFilter").jqxDropDownList('selectItem', item ); 
                        }else{
                            resetGridAll();
                        }
                    }
                });
                dataAdapter.dataBind();
            }
            $('#tableStudentGroup').jqxGrid('hideloadelement');
        }
        $("#okWarning").click(function (){
            changeValQuestionCell(indexExternal, "Si");
            indexExternal=0;
            insertStudentToGroup();
        });
        $("#cancelWarning").click(function (){
            changeValQuestionCell(indexExternal, "No");
            indexExternal=0;
            insertStudentToGroup();
        });
        function insertStudentToGroup(fkTeacher, fkSubjectMatter){            
            itemPeriod = $('#teacherToGroupFlangePeriodFilter').jqxDropDownList('getSelectedItem');
            itemCareer = $('#teacherToGroupFlangeCareerFilter').jqxDropDownList('getSelectedItem');
            itemStudyPlan = $('#subjectMattersStudyPlanFilter').jqxDropDownList('getSelectedItem');
            itemSemester = $('#teacherToGroupFlangeSemesterFilter').jqxDropDownList('getSelectedItem');
            itemGroup = $('#teacherToGroupFlangeGroupFilter').jqxDropDownList('getSelectedItem');
            itemTeacher = $('#studentToGroupFlangeTutorFilter').jqxDropDownList('getSelectedItem');
            for (var i = 0; i < 50; i++) {
                var data = $('#tableStudentGroup').jqxGrid('getrowdata', i);
                if(data.dataEnrollment!==""&&data.dataStudentName!==""){
                    $.ajax({
                        //Send the paramethers to servelt
                        type: "POST",
                        async: false,
                        url: "../serviceStudentsGroup?insert",
                        data:{
                            'enrollment': data.dataEnrollment,
                            'fkCareer': itemCareer.value,
                            'fkSemester': itemSemester.value,
                            'fkGroup': itemGroup.value,
                            'fkPeriod': itemPeriod.value,
                            'fkTutor': itemTeacher.value,
                            'fkTeacher': fkTeacher,
                            'fkSubjectMatter': fkSubjectMatter
                        },
                        beforeSend: function (xhr) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //This is if exits an error with the server internal can do server off, or page not found
                            alert("Error interno del servidor");
                        },
                        success: function (data_result, textStatus, jqXHR) { 
                            if(data_result.includes("base de datos")){
                                $('#jqxNotificationStudentToGroup').jqxNotification({ template: 'error' }); 
                                $("#notificationStudentToGroupContent").html(data_result+"<br>Por lo que no será asociado a un grupo...");
                                $("#jqxNotificationStudentToGroup").jqxNotification("open");
                            }else if(data_result.includes("Registro Insertado")){  
                                $('#jqxNotificationStudentToGroup').jqxNotification({ template: 'info' }); 
                                $("#notificationStudentToGroupContent").html("Alumno asociado correctamente");
                            }else if(data_result.includes("Registro Actualizado")){
                                $('#jqxNotificationStudentToGroup').jqxNotification({ template: 'info' }); 
                            }else if(data_result.includes("en este grupo")){
                                $('#jqxNotificationStudentToGroup').jqxNotification({ template: 'info' }); 
                            }else if(data_result.includes("en el grupo")){
                                $('#jqxNotificationStudentToGroup').jqxNotification({ template: 'warning' }); 
                                $("#notificationStudentToGroupContent").html(data_result+"<br>Por lo que no será asociado a un grupo...");
                                $("#jqxNotificationStudentToGroup").jqxNotification("open");
                            }
                        }
                    });
                }
            }
        }
        function removeStudentOfGroup(rowData){            
            $.ajax({
                //Send the paramethers to servelt
                type: "POST",
                async: false,
                url: "../serviceStudentsGroup?delete",
                data:{
                    'pkGroupByStudent': rowData.dataPkGroupMatterTeacherStudent
                },
                beforeSend: function (xhr) {
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    //This is if exits an error with the server internal can do server off, or page not found
                    alert("Error interno del servidor");
                },
                success: function (data_result, textStatus, jqXHR) { 
                    if(data_result==="Registro Borrado"){
                        $('#jqxNotificationStudentToGroup').jqxNotification({ template: 'info' }); 
                        $("#notificationStudentToGroupContent").html("<br>El alumno "+rowData.dataEnrollment+" fue desasociado de la materia seleccionada...");
                        $("#jqxNotificationStudentToGroup").jqxNotification("open");
                    }else{
                        $('#jqxNotificationStudentToGroup').jqxNotification({ template: 'info' }); 
                        $("#notificationStudentToGroupContent").html(data_result);
                        $("#jqxNotificationStudentToGroup").jqxNotification("open");
                    }
                }
            });            
        }
        function changeValQuestionCell(indice, val){
            $("#tableStudentGroup").jqxGrid('setcellvalue', indice, "dataStatusRowQuestion", val);
        }
    });
</script>
<div id="working-modal">
    <div id="loadTitle">Realizando operaciones</div>
    <div id="loadPreview">
        <img src="../content/pictures-system/load.GIF" width="60" style="margin-right: 20px; float: left;" />
        <span style="float: left; width: 250px;">Trabajando...</span>
        <div style='margin-top: 10px; float: left;' id='jqxProgressBar3'></div>
    </div>
</div>
<div style="float: left; margin-right: 5px;">
    Nivel de estudio <br>
    <div id='teacherToGroupFlangeLevelFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Carrera <br>
    <div id='teacherToGroupFlangeCareerFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Plan de estudio<br>
    <div id='subjectMattersStudyPlanFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Cuatrimestre<br>
    <div id='teacherToGroupFlangeSemesterFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Grupo<br>
    <div id='teacherToGroupFlangeGroupFilter'></div>
</div>
<div style="float: left; margin-right: 5px;">
    Periodo <br>
    <div id='teacherToGroupFlangePeriodFilter'></div>
</div>
<br><br><br><br><br><br>
<div style="padding: 0px">
    <div style="float: left; margin-right: 10px; margin-bottom: 10px; display: inline-block;">
        <div id="tableGroupMatterTeacher"></div>
    </div>
    <div style="float: left; margin-right: 10px; margin-bottom: 10px;  display: inline-block;">
        <span style="color: #54925F; font-size: 16px; ">Regitro de movimientos</span>
        <div id="containerNotifications" style="width: 200px; height: 100px; margin-top: 10px; border: 1px dashed #AAAAAA; overflow: auto;"></div>
    </div>
    <div style="float: left; margin-right: 10px; margin-bottom: 10px; display: inline-block;">
        <div id="tableStudentGroup"></div>
    </div>
    <div style="float: left; margin-right: 10px; margin-bottom: 10px; display: inline-block;">        
        <span style="color: #54925F; font-size: 16px; ">Regitro de movimientos</span>
        <div id="containerNotificationsStudentToGroup" style="width: 200px; height: 100px; margin-top: 10px; border: 1px dashed #AAAAAA; overflow: auto;"></div>
        <button style=" margin: 10px 10px 0 0;" id="btnBottomAdd">Agregar</button>
    </div>    
</div>  
<div id="jqxNotification">
    <div id="notificationContent"></div>
</div>
<div id="jqxNotificationStudentToGroup">
    <div id="notificationStudentToGroupContent"></div>
</div>
<div id='contextMenu'>
    <ul>
<!--        <li>Copiar</li>
        <li>Pegar</li>-->
        <li id="removeRow">Quitar de la lista</li>
    </ul>
</div>