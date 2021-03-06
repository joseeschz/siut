function createDropDownEntity(selector, action, update){
    var url = "../getEntity?view=combo&&action="+action+"";
    var sourceEntity ={
        datatype: "json",
        root: "__ENTITIES",
        id: "id",
        datafields: [
            { name: 'dataPkEntity' },
            { name: 'dataNameEntity' }
        ],
        url: url,
        async: false
    };
    var dataAdapterEntity = new $.jqx.dataAdapter(sourceEntity);
    if(update){
        $(selector).jqxDropDownList('clearSelection');
        $(selector).jqxDropDownList({source: dataAdapterEntity, selectedIndex: 0});
    }else{
        $(selector).jqxDropDownList({
            theme: theme,
            selectedIndex: 0, 
            filterable: true,
            filterPlaceHolder: "Buscar",
            placeHolder: "SELECCIONAR",
            source: dataAdapterEntity, 
            displayMember: "dataNameEntity", 
            valueMember: "dataPkEntity",
            height: 26, 
            width: 200                
        }).css("display","inline-block");
    }
}
function createDropDownMunicipality(filtrable, action, selector, update){
    var sourceMunicipality ={
        datatype: "json",
        root: "__ENTITIES",
        id: "id",
        datafields: [
            { name: 'dataPkMunicipality' },
            { name: 'dataNameMunicipality' }
        ],
        url: "../getMunicipality?view=combo&&filtrable="+filtrable+"&&action="+action+"",
        async: false
    };
    var dataAdapterMunicipality = new $.jqx.dataAdapter(sourceMunicipality);
    if(update){
        $(selector).jqxDropDownList('clearSelection');
        $(selector).jqxDropDownList({source: dataAdapterMunicipality, selectedIndex: 0});
    }else{
        $(selector).jqxDropDownList({
            theme: theme,
            selectedIndex: 0, 
            dropDownWidth: "auto",
            filterable: true, 
            filterPlaceHolder: "Buscar",
            placeHolder: "SELECCIONAR",
            source: dataAdapterMunicipality, 
            displayMember: "dataNameMunicipality", 
            valueMember: "dataPkMunicipality",
            height: 26, 
            width: 360  
        }).css("display","inline-block");
    }
}
function createDropDownLocality(filtrable, action, selector, update){
    var sourceLocality ={
        datatype: "json",
        root: "__ENTITIES",
        id: "id",
        datafields: [
            { name: 'dataPkLocality' },
            { name: 'dataNameLocality' }
        ],
        url: "../getLocality?view=combo&&filtrable="+filtrable+"&&action="+action,
        async: false
    };
    var dataAdapterLocality = new $.jqx.dataAdapter(sourceLocality);
    if(update){
        $(selector).jqxDropDownList('clearSelection');
        $(selector).jqxDropDownList({source: dataAdapterLocality, selectedIndex: 0});
    }else{
        dataAdapterLocality = new $.jqx.dataAdapter(sourceLocality);
        $(selector).jqxDropDownList({
            theme: theme,
            filterable: true, 
            filterPlaceHolder: "Buscar",
            dropDownWidth: "auto",
            selectedIndex: 0, 
            source: dataAdapterLocality, 
            placeHolder: "SELECCIONAR",
            displayMember: "dataNameLocality", 
            valueMember: "dataPkLocality",
            height: 26, 
            width: 460                
        }).css("display","inline-block");
    }
}
function createDropDownPreparatory(filtrable, selector, update){
    var sourceLocality ={
        datatype: "json",
        root: "__ENTITIES",
        id: "id",
        datafields: [
            { name: 'dataPkPreparatory' },
            { name: 'dataNamePreparatory' }
        ],
        url: "../getPreparatory?view=combo&&filtrable="+filtrable+"",
        async: false
    };
    var dataAdapterLocality = new $.jqx.dataAdapter(sourceLocality);
    if(update){
        $(selector).jqxDropDownList('clearSelection');
        $(selector).jqxDropDownList({source: dataAdapterLocality, selectedIndex: 0});
    }else{
        $(selector).jqxDropDownList({
            theme: theme,
            filterable: true,
            autoDropDownHeight: true,
            filterPlaceHolder: "Buscar",
            dropDownWidth: 460,
            selectedIndex: 0, 
            source: dataAdapterLocality, 
            placeHolder: "SELECCIONAR",
            displayMember: "dataNamePreparatory", 
            valueMember: "dataPkPreparatory",
            height: 26, 
            width: 460                
        }).css("display","inline-block");
    }
}
function createDropDownControl(selector){
    var sourceControl =[{"dataNameControl":"Público","dataValueControl":"Público"},{"dataNameControl":"Privado","dataValueControl":"Privado"}];
    $(selector).jqxDropDownList({
        theme: theme,
        filterable: true, 
        autoDropDownHeight: true,
        placeHolder: "SELECCIONAR",
        selectedIndex: 0, 
        source: sourceControl, 
        displayMember: "dataNameControl", 
        valueMember: "dataValueControl",
        height: 26, 
        width: 100                
    }).css("display","inline-block");
}

function createDropDownStudyLevel(selector, update){
    var sourceEntity ={
        datatype: "json",
        root: "__ENTITIES",
        id: "id",
        datafields: [
            { name: 'dataPkStudyLevel' },
            { name: 'dataNameStudyLevel' }
        ],
        url: "../serviceStudyLevel?view=combo",
        async: false
    };
    var dataAdapterEntity = new $.jqx.dataAdapter(sourceEntity);
    if(update){
        $(selector).jqxDropDownList('clearSelection');
        $(selector).jqxDropDownList({source: dataAdapterEntity, selectedIndex: 0});
    }else{
        $(selector).jqxDropDownList({
            theme: theme,
            selectedIndex: 0, 
            autoDropDownHeight: true,
            filterPlaceHolder: "Buscar",
            placeHolder: "SELECCIONAR",
            source: dataAdapterEntity, 
            displayMember: "dataNameStudyLevel", 
            valueMember: "dataPkStudyLevel",
            width: 220                
        }).css("display","inline-block");
    }
}

function createDropDownCareer(filtrable, selector, update){
    var sourceCareer ={
        datatype: "json",
        root: "__ENTITIES",
        id: "id",
        datafields: [
            { name: 'dataPkCareer' },
            { name: 'dataNameCareer' }
        ],
        url: "../serviceCareer?view=combo&&fkLevel="+filtrable+"",
        async: false
    };
    var dataAdapterCareer = new $.jqx.dataAdapter(sourceCareer);
    if(update){
        $(selector).jqxDropDownList('clearSelection');
        $(selector).jqxDropDownList({source: dataAdapterCareer, selectedIndex: 0});
    }else{
        $(selector).jqxDropDownList({
            theme: theme,
            selectedIndex: 0, 
            autoDropDownHeight: true,
            filterPlaceHolder: "Buscar",
            placeHolder: "SELECCIONAR",
            source: dataAdapterCareer, 
            displayMember: "dataNameCareer", 
            valueMember: "dataPkCareer",
            width: 310                
        }).css("display","inline-block");
    }
}

function createDropDownCareerPreregistro(selector, update){
    var sourceCareer ={
        datatype: "json",
        root: "__ENTITIES",
        id: "id",
        datafields: [
            { name: 'dataPkCareer' },
            { name: 'dataNameCareer' }
        ],
        url: "../serviceCareer?view=combo&&statusInscription",
        async: false
    };
    var dataAdapterCareer = new $.jqx.dataAdapter(sourceCareer);
    if(update){
        $(selector).jqxDropDownList('clearSelection');
        $(selector).jqxDropDownList({source: dataAdapterCareer, selectedIndex: 0});
    }else{
        $(selector).jqxDropDownList({
            theme: theme,
            selectedIndex: 0, 
            autoDropDownHeight: true,
            filterPlaceHolder: "Buscar",
            placeHolder: "SELECCIONAR",
            source: dataAdapterCareer, 
            displayMember: "dataNameCareer", 
            valueMember: "dataPkCareer",
            width: 310                
        }).css("display","inline-block");
    }
}

function createDropDownGruop(filtrable, selector, update){
    var sourceGroup ={
        datatype: "json",
        root: "__ENTITIES",
        id: "id",
        datafields: [
            { name: 'dataPkGruop' },
            { name: 'dataNameGroup' }
        ],
        url: "../serviceGroup?view=combo&fkSemester="+filtrable,
        async: false
    };
    var dataAdapterGroup = new $.jqx.dataAdapter(sourceGroup);
    if(update){
        $(selector).jqxDropDownList('clearSelection');
        $(selector).jqxDropDownList({source: dataAdapterGroup, selectedIndex: 0});
    }else{
        $(selector).jqxDropDownList({
            theme: theme,
            selectedIndex: 0, 
            dropDownHeight: 100,
            filterable: true, 
            filterPlaceHolder: "Buscar",
            placeHolder: "SELECCIONAR",
            source: dataAdapterGroup, 
            displayMember: "dataNameGroup", 
            valueMember: "dataPkGruop",
            width: 115
        }).css("display","inline-block");
    }
}

function createDropDownGruopCheck(filtrable, selector, update){
    var sourceGroup ={
        datatype: "json",
        root: "__ENTITIES",
        id: "id",
        datafields: [
            { name: 'dataPkGruop' },
            { name: 'dataNameGroup' }
        ],
        url: "../serviceGroup?view=combo&fkSemester="+filtrable,
        async: false
    };
    var dataAdapterGroup = new $.jqx.dataAdapter(sourceGroup);
    if(update){
        $(selector).jqxDropDownList('clearSelection');
        $(selector).jqxDropDownList({source: dataAdapterGroup, selectedIndex: 0});
    }else{
        $(selector).jqxDropDownList({
            selectedIndex: 0, 
            dropDownHeight: 100,
            checkboxes: true,
            placeHolder: "SELECCIONAR",
            source: dataAdapterGroup, 
            displayMember: "dataNameGroup", 
            valueMember: "dataPkGruop",
            width: 150
        }).css("display","inline-block");
        $(selector).jqxDropDownList('checkIndex',0);
    }
}
function createDropDownPeriodByStudentsCalifications(selector, params, update){
    var source ={
        datatype: "json",
        root: "__ENTITIES",
        id: "id",
        datafields: [
            { name: 'dataPkPeriod' },
            { name: 'dataNamePeriod' }
        ],
        url: "../servicePeriod?view=byStudentAdjustmentCalifications",
        data : {
            fkSemester : params.fkSemester,
            pkStudent : params.pkStudent
        },
        async: false
    };
    var dataAdapterPeriod = new $.jqx.dataAdapter(source);
    if(update){
        $(selector).jqxDropDownList('clearSelection');
        $(selector).jqxDropDownList({source: dataAdapterPeriod, selectedIndex: 0});
    }else{
        $(selector).jqxDropDownList({
            theme: theme,
            filterable: false, 
            autoDropDownHeight: true,
            placeHolder: "SELECCIONAR",
            selectedIndex: 0,
            source: dataAdapterPeriod, 
            displayMember: "dataNamePeriod", 
            valueMember: "dataPkPeriod",
            height: 26, 
            width: 240                
        }).css("display","inline-block");
    }
}
function createDropDownSchoolYear(selector){
    var pkSchoolYearSelected = 0;
    var sourceSchoolYear ={
        datatype: "json",
        root: "__ENTITIES",
        id: "dataPkSchoolYear",
        datafields: [
            { name: 'dataProgresivNumber', type:'int'},
            { name: 'dataPkSchoolYear', type: 'string' },
            { name: 'dataUnique', type: 'string' },
            { name: 'dataSchoolYearName', type: 'string' } ,
            { name: 'dataYearBegin', type: 'string' } ,
            { name: 'dataYearEnd', type: 'string' } ,
            { name: 'dataActive', type: 'int' } 
        ],
        url: "../serviceSchoolYear?view",
        async: false
    };
    var dataAdapterPeriod = new $.jqx.dataAdapter(sourceSchoolYear,{
        loadComplete: function () {
            var length = dataAdapterPeriod.records.length;
            for(var i=0; i<length; i++){
                if(dataAdapterPeriod.records[i].dataActive==="Activo"){
                    pkSchoolYearSelected=dataAdapterPeriod.records[i].dataPkSchoolYear;
                }
            }
        }
    });
    $(selector).jqxDropDownList({
        theme: theme, 
        selectedIndex: 0, 
        placeHolder: "SELECCIONAR",
        filterPlaceHolder: "Buscar",
        filterable: true, 
        searchMode: 'containsignorecase',
        source: dataAdapterPeriod, 
        displayMember: "dataSchoolYearName", 
        valueMember: "dataPkSchoolYear",
        height: 26, 
        width: 240,
        dropDownHeight: 400
    }).css("display","inline-block");
    console.log(pkSchoolYearSelected)
    var item = $(selector).jqxDropDownList('getItemByValue', pkSchoolYearSelected);
    $(selector).jqxDropDownList({selectedIndex: item.index}); 
}
function createDropDownPeriod(filtrable, selector){
    var periodSelected = 0;
    if(filtrable==="inscription"){
        $.ajax({
            //Send the paramethers to servelt
            type: "POST",
            url: "../servicePeriod?view=activePeriodInscription",
            dataType: 'text',
            async: false,
            beforeSend: function (xhr) {
            },
            error: function (jqXHR, textStatus, errorThrown) {
                //This is if exits an error with the server internal can do server off, or page not found
                alert("Error interno del servidor");
            },
            success: function (data, textStatus, jqXHR) {
                periodSelected = data;
                periodSelected = parseInt(periodSelected);  
            }
        });
    }else{
        $.ajax({
            //Send the paramethers to servelt
            type: "POST",
            url: "../servicePeriod?view=activePeriodYear",
            data:{},
            async: false,
            beforeSend: function (xhr) {
            },
            error: function (jqXHR, textStatus, errorThrown) {
                //This is if exits an error with the server internal can do server off, or page not found
                alert("Error interno del servidor");
            },
            success: function (data, textStatus, jqXHR) {
                periodSelected = data;
                periodSelected = parseInt(periodSelected);
            }
        });
    }
    var sourceCareer ={
        datatype: "json",
        root: "__ENTITIES",
        id: "id",
        datafields: [
            { name: 'dataPkPeriod' },
            { name: 'dataNamePeriod' },
            { name: 'dataPkPeriodActive' }
        ],
        url: "../servicePeriod?view="+filtrable+"",
        async: false
    };
    var dataAdapterPeriod = new $.jqx.dataAdapter(sourceCareer);
    $(selector).jqxDropDownList({
        theme: theme, 
        selectedIndex: 0, 
        placeHolder: "SELECCIONAR",
        filterPlaceHolder: "Buscar",
        filterable: true, 
        searchMode: 'containsignorecase',
        source: dataAdapterPeriod, 
        displayMember: "dataNamePeriod", 
        valueMember: "dataPkPeriod",
        height: 26, 
        width: 240,
        dropDownHeight: 100
    }).css("display","inline-block");
    var item = $(selector).jqxDropDownList('getItemByValue', periodSelected);
    $(selector).jqxDropDownList({selectedIndex: item.index}); 
}
function createDropDownTypePreinscription(selector){
    var sourceRol =[
        {"dataNameType":"ESCOLARIZADA","dataValueType":"ES"},
        {"dataNameType":"SEMIESCOLARIZADA","dataValueType":"SE"}
    ];
    $(selector).jqxDropDownList({
        theme: theme,
        filterable: false, 
        autoDropDownHeight: true,
        placeHolder: "SELECCIONAR",
        selectedIndex: 0, 
        source: sourceRol, 
        displayMember: "dataNameType", 
        valueMember: "dataValueType",
        height: 26, 
        width: 180                
    }).css("display","inline-block");
}
function createDropDownPeriodActive(filtrable, selector){
    var periodSelected = 0;
    $.ajax({
        //Send the paramethers to servelt
        type: "POST",
        url: "../../servicePeriod?view=activePeriodYear",
        data:{},
        async: false,
        beforeSend: function (xhr) {
        },
        error: function (jqXHR, textStatus, errorThrown) {
            //This is if exits an error with the server internal can do server off, or page not found
            alert("Error interno del servidor");
        },
        success: function (data, textStatus, jqXHR) {
            periodSelected = data;
            periodSelected = parseInt(periodSelected);
        }
    });
    var sourceCareer ={
        datatype: "json",
        root: "__ENTITIES",
        id: "id",
        datafields: [
            { name: 'dataPkPeriod' },
            { name: 'dataNamePeriod' }
        ],
        url: "../../servicePeriod?view="+filtrable+"",
        async: false
    };
    var dataAdapterPeriod = new $.jqx.dataAdapter(sourceCareer);
    $(selector).jqxDropDownList({
        theme: theme,
        filterable: false, 
        autoDropDownHeight: true,
        placeHolder: "SELECCIONAR",
        //selectedIndex: periodSelected, 
        source: dataAdapterPeriod, 
        displayMember: "dataNamePeriod", 
        valueMember: "dataPkPeriod",
        height: 26, 
        width: 240                
    }).css("display","inline-block");
    var item = $(selector).jqxDropDownList('getItemByValue', periodSelected);
    $(selector).jqxDropDownList({selectedIndex: item.index }); 
}
function createDropDownCurrentSemester(selector, filtrable, update){
    var sourceSemester={
        datatype: "json",
        root: "__ENTITIES",
        id: "id",
        datafields: [
            { name: 'dataValueSemester' },
            { name: 'dataNameSemester' }
        ],
        url: "../serviceSemester?view=combo",
        data:{
            pkStudyLevel:0,
            currentSemester : null,
            pkStudyPlan : filtrable.pkStudyPlan,
            pkCareer: filtrable.pkCareer,
            pkPeriod: filtrable.pkPeriod
        },
        async: false
    };
    var dataAdapterSemester = new $.jqx.dataAdapter(sourceSemester);
    if(update){
        $(selector).jqxDropDownList('clearSelection');
        $(selector).jqxDropDownList({source: dataAdapterSemester, selectedIndex: 0});
    }else{
        $(selector).jqxDropDownList({
            theme: theme,
            filterable: false, 
            dropDownHeight: 150,
            autoDropDownHeight: true,
            placeHolder: "SELECCIONAR",
            filterPlaceHolder: "Buscar",
            selectedIndex: 0, 
            source: dataAdapterSemester, 
            displayMember: "dataNameSemester", 
            valueMember: "dataValueSemester",
            height: 26, 
            width: 150                
        }).css("display","inline-block");
    }
}
function createDropDownSemester(filtrable, selector, update){
    var sourceSemester={
        datatype: "json",
        root: "__ENTITIES",
        id: "id",
        datafields: [
            { name: 'dataValueSemester' },
            { name: 'dataNameSemester' }
        ],
        url: "../serviceSemester?view=combo&&pkStudyLevel="+filtrable,
        async: false
    };
    var dataAdapterSemester = new $.jqx.dataAdapter(sourceSemester);
    if(update){
        $(selector).jqxDropDownList('clearSelection');
        $(selector).jqxDropDownList({source: dataAdapterSemester, selectedIndex: 0});
    }else{
        $(selector).jqxDropDownList({
            theme: theme,
            filterable: false, 
            dropDownHeight: 150,
            autoDropDownHeight: true,
            placeHolder: "SELECCIONAR",
            filterPlaceHolder: "Buscar",
            selectedIndex: 0, 
            source: dataAdapterSemester, 
            displayMember: "dataNameSemester", 
            valueMember: "dataValueSemester",
            height: 26, 
            width: 150                
        }).css("display","inline-block");
    }
}
function createDropDownSemesterX(filtrable, selector, update){
    var sourceSemester={
        datatype: "json",
        root: "__ENTITIES",
        id: "id",
        datafields: [
            { name: 'dataValueSemester' },
            { name: 'dataNameSemester' }
        ],
        url: "../../serviceSemester?view=combo&&pkStudyLevel="+filtrable,
        async: false
    };
    var dataAdapterSemester = new $.jqx.dataAdapter(sourceSemester);
    if(update){
        $(selector).jqxDropDownList('clearSelection');
        $(selector).jqxDropDownList({source: dataAdapterSemester, selectedIndex: 0});
    }else{
        $(selector).jqxDropDownList({
            theme: theme,
            filterable: true, 
            dropDownHeight: 150,
            autoDropDownHeight: true,
            placeHolder: "SELECCIONAR",
            filterPlaceHolder: "Buscar",
            selectedIndex: 0, 
            source: dataAdapterSemester, 
            displayMember: "dataNameSemester", 
            valueMember: "dataValueSemester",
            height: 26, 
            width: 180                
        }).css("display","inline-block");
    }
}

function createDropDownStudyPlan(filtrable, selector, update){
    var sourceCareer ={
        datatype: "json",
        root: "__ENTITIES",
        id: "id",
        datafields: [
            { name: 'dataPkStudyPlan' },
            { name: 'dataNameStudyPlan' }
        ],
        url: "../serviceStudyPlan?view=combo&&fkCareer="+filtrable+"",
        async: false
    };
    var dataAdapterCareer = new $.jqx.dataAdapter(sourceCareer);
    if(update){
        $(selector).jqxDropDownList('clearSelection');
        $(selector).jqxDropDownList({source: dataAdapterCareer, selectedIndex: 0});
    }else{
        $(selector).jqxDropDownList({
            theme: theme,
            selectedIndex: 0, 
            autoDropDownHeight: true,
            filterPlaceHolder: "Buscar",
            placeHolder: "SELECCIONAR",
            source: dataAdapterCareer, 
            displayMember: "dataNameStudyPlan", 
            valueMember: "dataPkStudyPlan",
            width: 290                
        }).css("display","inline-block");
    }
}

function createDropDownRol(selector){
    var sourceRol =[
        {"dataNameRol":"SISTEMA","dataValueRol":"1"},
        {"dataNameRol":"DIRECTOR","dataValueRol":"2"},
        {"dataNameRol":"MAESTRO","dataValueRol":"3"},
        {"dataNameRol":"SECRETARIA DE CARRERA","dataValueRol":"4"},
        {"dataNameRol":"ADMINISTRATIVO","dataValueRol":"5"}
    ];
    $(selector).jqxDropDownList({
        theme: theme,
        filterable: false, 
        autoDropDownHeight: true,
        placeHolder: "SELECCIONAR",
        selectedIndex: 0, 
        source: sourceRol, 
        displayMember: "dataNameRol", 
        valueMember: "dataValueRol",
        height: 26, 
        width: 180                
    }).css("display","inline-block");
}
function createDropDownEvaluationTypeUnlocked(selector, update){
    var source ={
        datatype: "json",
        root: "__ENTITIES",
        id: "id",
        datafields: [
            { name: 'displayMember' },
            { name: 'valueMember' }
        ],
        url: "../serviceCalification?getTypeEvaluationsUnlocked",
        async: false
    };
    var dataAdapter = new $.jqx.dataAdapter(source);
    if(update){
        $(selector).jqxDropDownList('clearSelection');
        $(selector).jqxDropDownList({source: dataAdapter, selectedIndex: 0});
    }else{
        $(selector).jqxDropDownList({
            theme: theme,
            selectedIndex: 0, 
            filterable: false, 
            autoDropDownHeight: true,
            filterPlaceHolder: "Buscar",
            placeHolder: "SELECCIONAR",
            source: dataAdapter, 
            displayMember: "displayMember", 
            valueMember: "valueMember",
            width: 150                
        }).css("display","inline-block");
    }
}
function createDropDownEvaluationType(selector, data, update){
    var source ={
        datatype: "json",
        root: "__ENTITIES",
        id: "id",
        datafields: [
            { name: 'displayMember' },
            { name: 'valueMember' },
            { name: 'status' }
        ],
        data:data,
        url: "../serviceCalification?getTypeEvaluations",
        async: false
    };
    var dataAdapter = new $.jqx.dataAdapter(source);
    if(update){
        $(selector).jqxDropDownList('clearSelection');
        $(selector).jqxDropDownList({source: dataAdapter, selectedIndex: 0});
    }else{
        $(selector).jqxDropDownList({
            theme: theme,
            selectedIndex: 0, 
            filterable: false, 
            autoDropDownHeight: true,
            filterPlaceHolder: "Buscar",
            placeHolder: "SELECCIONAR",
            source: dataAdapter, 
            displayMember: "displayMember", 
            valueMember: "valueMember",
            width: 150                
        }).css("display","inline-block");
    }
    var items = $(selector).jqxDropDownList('getItems'); 
    for(var i=0; i<items.length; i++){
        if(items[i].originalItem.status==="-1"){
            $(selector).jqxDropDownList('disableItem', items[i] ); 
        }        
    }
}
function createDropDownEvaluationTypeByActivity(selector){
    var sourceRol =[
        {"dataNameType":"PRIMER PARCIAL","dataValueType":"1"},
        {"dataNameType":"SEGUNDO PARCIAL","dataValueType":"2"},
        {"dataNameType":"REGULARIZACIÓN","dataValueType":"4"},
        {"dataNameType":"GLOBAL","dataValueType":"5"}
    ];
    $(selector).jqxDropDownList({
        theme: theme,
        filterable: false, 
        autoDropDownHeight: true,
        placeHolder: "SELECCIONAR",
        selectedIndex: 0, 
        source: sourceRol, 
        displayMember: "dataNameType", 
        valueMember: "dataValueType",
        height: 26, 
        width: 150               
    }).css("display","inline-block");
}

function createDropDownScaleEvaluation(selector, filterable, update){
    var sourceCareer ={
        datatype: "json",
        root: "__ENTITIES",
        id: "id",
        datafields: [
            { name: 'dataPkScaleEvalution' },
            { name: 'dataNameScale' },
            { name: 'dataMaxValue' },
            { name: 'dataTypeEvaluation' }
        ],
        url: "../serviceScaleEvaluation?view=combo&&fkStudyLevel="+filterable+"",
        async: false
    };
    var dataAdapterCareer = new $.jqx.dataAdapter(sourceCareer);
    if(update){
        $(selector).jqxDropDownList('clearSelection');
        $(selector).jqxDropDownList({source: dataAdapterCareer, selectedIndex: 0});
    }else{
        $(selector).jqxDropDownList({
            theme: theme,
            selectedIndex: 0, 
            filterable: false, 
            autoDropDownHeight: true,
            filterPlaceHolder: "Buscar",
            placeHolder: "SELECCIONAR",
            source: dataAdapterCareer, 
            displayMember: "dataNameScale", 
            valueMember: "dataPkScaleEvalution",
            width: 80                
        }).css("display","inline-block");
    }
}

function createDropDownScaleEvaluationBloqued(selector,pkPeriod,pkSubjectMatter, update){
    var sourceCareer ={
        datatype: "json",
        root: "__ENTITIES",
        id: "id",
        datafields: [
            { name: 'dataPkScaleEvalution' },
            { name: 'dataNameScale' },
            { name: 'dataMaxValue' },
            { name: 'dataTypeEvaluation' }
        ],
        url: "../serviceScaleEvaluation?view=comboBloqued&&pkPeriod="+pkPeriod+"&&pkSubjectMatter="+pkSubjectMatter+"",
        async: false
    };
    var dataAdapterCareer = new $.jqx.dataAdapter(sourceCareer);
    if(update){
        $(selector).jqxDropDownList('clearSelection');
        $(selector).jqxDropDownList({source: dataAdapterCareer, selectedIndex: 0});
    }else{
        $(selector).jqxDropDownList({
            theme: theme,
            selectedIndex: 0, 
            filterable: false, 
            autoDropDownHeight: true,
            filterPlaceHolder: "Buscar",
            placeHolder: "SELECCIONAR",
            source: dataAdapterCareer, 
            displayMember: "dataNameScale", 
            valueMember: "dataPkScaleEvalution",
            width: 80
        }).css("display","inline-block");
    }
}
function createDropDownScaleEvaluationBloquedStudent(selector, pkMatter, update){
    var sourceCareer ={
        datatype: "json",
        root: "__ENTITIES",
        id: "id",
        crossDomain: true,
        datafields: [
            { name: 'dataPkScaleEvalution' },
            { name: 'dataNameScale' },
            { name: 'dataMaxValue' },
            { name: 'dataTypeEvaluation' }
        ],
        url: "../serviceScaleEvaluation?view=comboBloquedStudent&&pkMatter="+pkMatter,
        async: false
    };
    var dataAdapterCareer = new $.jqx.dataAdapter(sourceCareer);
    if(update){
        $(selector).jqxDropDownList('clearSelection');
        $(selector).jqxDropDownList({source: dataAdapterCareer, selectedIndex: 0});
    }else{
        $(selector).jqxDropDownList({
            theme: "android",
            selectedIndex: 0, 
            filterable: false, 
            autoDropDownHeight: true,
            filterPlaceHolder: "Buscar",
            placeHolder: "SELECCIONAR",
            source: dataAdapterCareer, 
            displayMember: "dataNameScale", 
            valueMember: "dataPkScaleEvalution",
            width: 70                
        });
    }
}
function createDropDownActivities(selector, filterable, update){
    var renderer = function (index, label, value) {
        var item = $(selector).jqxDropDownList('getItem', index ); 
        var label = label+"<br>Val: "+item.originalItem.dataValueActivity;
        return label;
    };
    var sourceCareer ={
        datatype: "json",
        type: "POST",
        root: "__ENTITIES",
        id: "id",
        datafields: [
            { name: 'dataPkActivity' },
            { name: 'dataNameActivity' },
            { name: 'dataDescriptActivity'},
            { name: 'dataEvaluatedActivityByGroup'},
            { name: 'dataValueActivity'}
        ],
        url: "../serviceActivities?view",
        data:{
            "pkWorkPlanning" : filterable[0],
            "fk_period" : filterable[1],
            "fk_study_level" : filterable[2] ,
            "fk_subject_matter" : filterable[3] ,
            "fk_group" : filterable[4] ,
            "fk_scale_evaluation" : filterable[5] 
        },
        async: false
    };
    var data = null;
    var dataAdapterCareer = new $.jqx.dataAdapter(sourceCareer, {
        beforeLoadComplete: function (records) {
            data = null;
            data = records;
            return records;
        }
    });
    if(update){
        $(selector).jqxDropDownList('clearSelection');
        $(selector).jqxDropDownList({
            selectedIndex: filterable[6] || 0,
            source: dataAdapterCareer
        });
    }else{
        $(selector).jqxDropDownList({
            theme: theme,
            selectedIndex: 0, 
            filterable: true, 
            searchMode: 'contains',
            autoDropDownHeight: false,
            filterPlaceHolder: "Buscar",
            placeHolder: "SELECCIONAR",
            //renderer: renderer,
            source: dataAdapterCareer, 
            displayMember: "dataDescriptActivity", 
            valueMember: "dataPkActivity",
            width: 250
        }).css("display","inline-block");
    }
    $(selector).jqxDropDownList({selectedIndex: filterable[6] || 0});
}

function createDropDownTutorTeacher(selector, update){
    var sourceCareer ={
        datatype: "json",
        root: "__ENTITIES",
        id: "id",
        datafields: [
            { name: 'dataPkWorker' },
            { name: 'dataNameWorker' }
        ],
        url: "../serviceTeacher?view=combo",
        async: false
    };
    var dataAdapterCareer = new $.jqx.dataAdapter(sourceCareer);
    if(update){
        $(selector).jqxDropDownList('clearSelection');
        $(selector).jqxDropDownList({source: dataAdapterCareer, selectedIndex: 0});
    }else{
        $(selector).jqxDropDownList({
            theme: theme,
            selectedIndex: 0, 
            filterable: true, 
            searchMode: 'containsignorecase',
            dropDownHeight: 150,
            filterPlaceHolder: "Buscar",
            placeHolder: "SELECCIONAR",
            source: dataAdapterCareer, 
            displayMember: "dataNameWorker", 
            valueMember: "dataPkWorker",
            width: 240                
        }).css("display","inline-block");
    }
}

function createDropDownTeachers(selector, selectValue){
    var ordersSource ={
            datatype: "json",
            datafields: [
                { name: 'dataNameWorker' },
                { name: 'id' }
            ],
            root: "__ENTITIES",
            id: 'id',
            async: false,
            url: '../serviceTeacher?view'
        };
    var dataAdapter = new $.jqx.dataAdapter(ordersSource);
   
    // Create a jqxListBox
    $(selector).jqxDropDownList({ 
        theme: theme,
        source: dataAdapter, 
        displayMember: "dataNameWorker", 
        valueMember: "id", 
        placeHolder: "SELECCIONAR",
        filterable:true,
        filterPlaceHolder: "Buscar",
        dropDownHeight: 150,
        searchMode: 'containsignorecase'
    });
    var item;
    if(selectValue==null){
        item=null;
    }else{
        item = $(selector).jqxDropDownList('getItemByValue', selectValue);
    }
    $(selector).jqxDropDownList('selectItem', item ); 
}
function createDropDownDetailDowns(selector, update){
    var sourceEntity ={
        datatype: "json",
        root: "__ENTITIES",
        id: "id",
        datafields: [
            { name: 'dataPkDownDetail' },
            { name: 'dataDescription' }
        ],
        url: "../serviceStudent?selectDetailDowns",
        async: false
    };
    var dataAdapterEntity = new $.jqx.dataAdapter(sourceEntity);
    if(update){
        $(selector).jqxDropDownList('clearSelection');
        $(selector).jqxDropDownList({source: dataAdapterEntity, selectedIndex: 0});
    }else{
        $(selector).jqxDropDownList({
            theme: theme,
            selectedIndex: 0, 
            autoDropDownHeight: true,
            filterPlaceHolder: "Buscar",
            placeHolder: "SELECCIONAR",
            source: dataAdapterEntity, 
            displayMember: "dataDescription", 
            valueMember: "dataPkDownDetail",
            width: 270                
        }).css("display","inline-block");
    }
}
function createDropDownStudyLevelByTeacher(selector, update){
    var sourceEntity ={
        datatype: "json",
        root: "__ENTITIES",
        id: "id",
        datafields: [
            { name: 'dataPkStudyLevel' },
            { name: 'dataNameStudyLevel' }
        ],
        url: "../serviceStudyLevel?view=combo&teacher",
        async: false
    };
    var dataAdapterEntity = new $.jqx.dataAdapter(sourceEntity);
    if(update){
        $(selector).jqxDropDownList('clearSelection');
        $(selector).jqxDropDownList({source: dataAdapterEntity, selectedIndex: 0});
    }else{
        $(selector).jqxDropDownList({
            theme: theme,
            selectedIndex: 0, 
            autoDropDownHeight: true,
            filterPlaceHolder: "Buscar",
            placeHolder: "SELECCIONAR",
            source: dataAdapterEntity, 
            displayMember: "dataNameStudyLevel", 
            valueMember: "dataPkStudyLevel",
            width: 270                
        }).css("display","inline-block");
    }
}
function createDropDownStudyLevelByTeacherTutor(selector, update){
    var sourceEntity ={
        datatype: "json",
        root: "__ENTITIES",
        id: "id",
        datafields: [
            { name: 'dataPkStudyLevel' },
            { name: 'dataNameStudyLevel' }
        ],
        url: "../serviceStudyLevel?view=combo&teacherTutor",
        async: false
    };
    var dataAdapterEntity = new $.jqx.dataAdapter(sourceEntity);
    if(update){
        $(selector).jqxDropDownList('clearSelection');
        $(selector).jqxDropDownList({source: dataAdapterEntity, selectedIndex: 0});
    }else{
        $(selector).jqxDropDownList({
            theme: theme,
            selectedIndex: 0, 
            autoDropDownHeight: true,
            filterPlaceHolder: "Buscar",
            placeHolder: "SELECCIONAR",
            source: dataAdapterEntity, 
            displayMember: "dataNameStudyLevel", 
            valueMember: "dataPkStudyLevel",
            width: 270                
        }).css("display","inline-block");
    }
}

function createDropDownStudyLevelByDirector(selector, update){
    var sourceEntity ={
        datatype: "json",
        root: "__ENTITIES",
        id: "id",
        datafields: [
            { name: 'dataPkStudyLevel' },
            { name: 'dataNameStudyLevel' }
        ],
        url: "../serviceStudyLevel?view=combo&director",
        async: false
    };
    var dataAdapterEntity = new $.jqx.dataAdapter(sourceEntity);
    if(update){
        $(selector).jqxDropDownList('clearSelection');
        $(selector).jqxDropDownList({source: dataAdapterEntity, selectedIndex: 0});
    }else{
        $(selector).jqxDropDownList({
            theme: theme,
            selectedIndex: 0, 
            autoDropDownHeight: true,
            filterPlaceHolder: "Buscar",
            placeHolder: "SELECCIONAR",
            source: dataAdapterEntity, 
            displayMember: "dataNameStudyLevel", 
            valueMember: "dataPkStudyLevel",
            width: 100                
        }).css("display","inline-block");
    }
}
function createDropDownCareerByTeacher(filtrable, selector, update){
    var sourceCareer ={
        datatype: "json",
        root: "__ENTITIES",
        id: "id",
        datafields: [
            { name: 'dataPkCareer' },
            { name: 'dataNameCareer' }
        ],
        url: "../serviceCareer?view=combo&&fkLevel="+filtrable+"&&teacher",
        async: false
    };
    var dataAdapterCareer = new $.jqx.dataAdapter(sourceCareer);
    if(update){
        $(selector).jqxDropDownList('clearSelection');
        $(selector).jqxDropDownList({source: dataAdapterCareer, selectedIndex: 0});
    }else{
        $(selector).jqxDropDownList({
            theme: theme,
            selectedIndex: 0, 
            autoDropDownHeight: true,
            filterPlaceHolder: "Buscar",
            placeHolder: "SELECCIONAR",
            source: dataAdapterCareer, 
            displayMember: "dataNameCareer", 
            valueMember: "dataPkCareer",
            width: 500                
        }).css("display","inline-block");
    }
}

function createDropDownCareerByTeacherTutor(filtrable, selector, update){
    var sourceCareer ={
        datatype: "json",
        root: "__ENTITIES",
        id: "id",
        datafields: [
            { name: 'dataPkCareer' },
            { name: 'dataNameCareer' }
        ],
        url: "../serviceCareer?view=combo&&fkLevel="+filtrable+"&&teacherTutor",
        async: false
    };
    var dataAdapterCareer = new $.jqx.dataAdapter(sourceCareer);
    if(update){
        $(selector).jqxDropDownList('clearSelection');
        $(selector).jqxDropDownList({source: dataAdapterCareer, selectedIndex: 0});
    }else{
        $(selector).jqxDropDownList({
            theme: theme,
            selectedIndex: 0, 
            autoDropDownHeight: true,
            filterPlaceHolder: "Buscar",
            placeHolder: "SELECCIONAR",
            source: dataAdapterCareer, 
            displayMember: "dataNameCareer", 
            valueMember: "dataPkCareer",
            width: 500                
        }).css("display","inline-block");
    }
}

function createDropDownCareerByDirector(filtrable, selector, update){
    var sourceCareer ={
        datatype: "json",
        root: "__ENTITIES",
        id: "id",
        datafields: [
            { name: 'dataPkCareer' },
            { name: 'dataNameCareer' }
        ],
        url: "../serviceCareer?view=combo&&fkLevel="+filtrable+"&&director",
        async: false
    };
    var dataAdapterCareer = new $.jqx.dataAdapter(sourceCareer);
    if(update){
        $(selector).jqxDropDownList('clearSelection');
        $(selector).jqxDropDownList({source: dataAdapterCareer, selectedIndex: 0});
    }else{
        $(selector).jqxDropDownList({
            theme: theme,
            selectedIndex: 0, 
            autoDropDownHeight: true,
            filterPlaceHolder: "Buscar",
            placeHolder: "SELECCIONAR",
            source: dataAdapterCareer, 
            displayMember: "dataNameCareer", 
            valueMember: "dataPkCareer",
            width: 500                
        }).css("display","inline-block");
    }
}

function createDropDownSemesterByTeacher(period, career, filtrable, selector, update){
    var sourceSemester={
        datatype: "json",
        root: "__ENTITIES",
        id: "id",
        datafields: [
            { name: 'dataValueSemester' },
            { name: 'dataNameSemester' }
        ],
        url: "../serviceSemester?pkStudyLevel="+filtrable+"&view=combo&&teacher&pkPeriod="+period+"&pkCareer="+career,
        async: false
    };
    var dataAdapterSemester = new $.jqx.dataAdapter(sourceSemester);
    if(update){
        $(selector).jqxDropDownList('clearSelection');
        $(selector).jqxDropDownList({source: dataAdapterSemester, selectedIndex: 0});
    }else{
        $(selector).jqxDropDownList({
            theme: theme,
            filterable: false, 
            dropDownHeight: 150,
            autoDropDownHeight: true,
            placeHolder: "SELECCIONAR",
            selectedIndex: 0, 
            source: dataAdapterSemester, 
            displayMember: "dataNameSemester", 
            valueMember: "dataValueSemester",
            height: 26, 
            width: 100                
        }).css("display","inline-block");
    }
}

function createDropDownSemesterByTeacherTutor(period, filtrable, selector, update){
    var sourceSemester={
        datatype: "json",
        root: "__ENTITIES",
        id: "id",
        datafields: [
            { name: 'dataValueSemester' },
            { name: 'dataNameSemester' }
        ],
        url: "../serviceSemester?pkStudyLevel="+filtrable+"&view=combo&&teacherTutor&pkPeriod="+period+"",
        async: false
    };
    var dataAdapterSemester = new $.jqx.dataAdapter(sourceSemester);
    if(update){
        $(selector).jqxDropDownList('clearSelection');
        $(selector).jqxDropDownList({source: dataAdapterSemester, selectedIndex: 0});
    }else{
        $(selector).jqxDropDownList({
            theme: theme,
            filterable: false, 
            dropDownHeight: 150,
            autoDropDownHeight: true,
            placeHolder: "SELECCIONAR",
            selectedIndex: 0, 
            source: dataAdapterSemester, 
            displayMember: "dataNameSemester", 
            valueMember: "dataValueSemester",
            height: 26, 
            width: 100                
        }).css("display","inline-block");
    }
}

function createDropDownSemesterByDirector(period, filtrable, selector, update){
    var sourceSemester={
        datatype: "json",
        root: "__ENTITIES",
        id: "id",
        datafields: [
            { name: 'dataValueSemester' },
            { name: 'dataNameSemester' }
        ],
        url: "../serviceSemester?pkStudyLevel="+filtrable+"&view=combo&&director&&pkPeriod="+period+"",
        async: false
    };
    var dataAdapterSemester = new $.jqx.dataAdapter(sourceSemester);
    if(update){
        $(selector).jqxDropDownList('clearSelection');
        $(selector).jqxDropDownList({source: dataAdapterSemester, selectedIndex: 0});
    }else{
        $(selector).jqxDropDownList({
            theme: theme,
            filterable: false, 
            dropDownHeight: 150,
            autoDropDownHeight: true,
            placeHolder: "SELECCIONAR",
            selectedIndex: 0, 
            source: dataAdapterSemester, 
            displayMember: "dataNameSemester", 
            valueMember: "dataValueSemester",
            height: 26, 
            width: 100                
        }).css("display","inline-block");
    }
}

function createDropDownGruopByTeacher(career, period, filtrable, selector, update){
    var sourceGroup ={
        datatype: "json",
        root: "__ENTITIES",
        id: "id",
        datafields: [
            { name: 'dataPkGruop' },
            { name: 'dataNameGroup' }
        ],
        url: "../serviceGroup?view=combo&&teacher&&pkCareer="+career+"&&fkSemester="+filtrable+"&&pkPeriod="+period+"",
        async: false
    };
    var dataAdapterGroup = new $.jqx.dataAdapter(sourceGroup);
    if(update){
        $(selector).jqxDropDownList('clearSelection');
        $(selector).jqxDropDownList({source: dataAdapterGroup, selectedIndex: 0});
    }else{
        $(selector).jqxDropDownList({
            theme: theme,
            selectedIndex: 0, 
            autoDropDownHeight: true,
            filterPlaceHolder: "Buscar",
            placeHolder: "SELECCIONAR",
            source: dataAdapterGroup, 
            displayMember: "dataNameGroup", 
            valueMember: "dataPkGruop",
            width:70
        }).css("display","inline-block");
    }
}
function createDropDownGruopByTeacherTutor(period, filtrable, selector, update){
    var sourceGroup ={
        datatype: "json",
        root: "__ENTITIES",
        id: "id",
        datafields: [
            { name: 'dataPkGruop' },
            { name: 'dataNameGroup' }
        ],
        url: "../serviceGroup?view=combo&&teacherTutor&&fkSemester="+filtrable+"&&pkPeriod="+period+"",
        async: false
    };
    var dataAdapterGroup = new $.jqx.dataAdapter(sourceGroup);
    if(update){
        $(selector).jqxDropDownList('clearSelection');
        $(selector).jqxDropDownList({source: dataAdapterGroup, selectedIndex: 0});
    }else{
        $(selector).jqxDropDownList({
            theme: theme,
            selectedIndex: 0, 
            autoDropDownHeight: true,
            filterPlaceHolder: "Buscar",
            placeHolder: "SELECCIONAR",
            source: dataAdapterGroup, 
            displayMember: "dataNameGroup", 
            valueMember: "dataPkGruop",
            width:70
        }).css("display","inline-block");
    }
}
function createDropDownGruopByDirector(period, filtrable, selector, update){
    var sourceGroup ={
        datatype: "json",
        root: "__ENTITIES",
        id: "id",
        datafields: [
            { name: 'dataPkGruop' },
            { name: 'dataNameGroup' }
        ],
        url: "../serviceGroup?view=combo&&director&&fkSemester="+filtrable+"&&pkPeriod="+period+"",
        async: false
    };
    var dataAdapterGroup = new $.jqx.dataAdapter(sourceGroup);
    if(update){
        $(selector).jqxDropDownList('clearSelection');
        $(selector).jqxDropDownList({source: dataAdapterGroup, selectedIndex: 0});
    }else{
        $(selector).jqxDropDownList({
            theme: theme,
            selectedIndex: 0, 
            autoDropDownHeight: true,
            filterPlaceHolder: "Buscar",
            placeHolder: "SELECCIONAR",
            source: dataAdapterGroup, 
            displayMember: "dataNameGroup", 
            valueMember: "dataPkGruop",
            width:70
        }).css("display","inline-block");
    }
}
function createDropDownGruopByCurrentSemester(selector, filtrable, update){
    var sourceGroup ={
        datatype: "json",
        root: "__ENTITIES",
        id: "id",
        datafields: [
            { name: 'dataPkGruop' },
            { name: 'dataNameGroup' }
        ],
        url: "../serviceGroup?view=comboByCurrentSemester",
        data : {
            pkCareer : filtrable.pkCareer,
            fkSemester :  filtrable.pkSemester,
            pkPeriod : filtrable.pkPeriod
        },
        async: false
    };
    var dataAdapterGroup = new $.jqx.dataAdapter(sourceGroup);
    if(update){
        $(selector).jqxDropDownList('clearSelection');
        $(selector).jqxDropDownList({source: dataAdapterGroup, selectedIndex: 0});
    }else{
        $(selector).jqxDropDownList({
            theme: theme,
            selectedIndex: 0, 
            autoDropDownHeight: true,
            filterPlaceHolder: "Buscar",
            placeHolder: "SELECCIONAR",
            source: dataAdapterGroup, 
            displayMember: "dataNameGroup", 
            valueMember: "dataPkGruop",
            width: 70
        }).css("display","inline-block");
    }
}
function createDropDownGruopByTeacherMattter(period, filtrable, matter, selector, update){
    var sourceGroup ={
        datatype: "json",
        root: "__ENTITIES",
        id: "id",
        datafields: [
            { name: 'dataPkGruop' },
            { name: 'dataNameGroup' }
        ],
        url: "../serviceGroup?view=comboByMatter&&teacher&&fkSemester="+filtrable+"&&pkPeriod="+period+"&&pkMatter="+matter+"",
        async: false
    };
    var dataAdapterGroup = new $.jqx.dataAdapter(sourceGroup);
    if(update){
        $(selector).jqxDropDownList('clearSelection');
        $(selector).jqxDropDownList({source: dataAdapterGroup, selectedIndex: 0});
    }else{
        $(selector).jqxDropDownList({
            theme: theme,
            selectedIndex: 0, 
            autoDropDownHeight: true,
            filterPlaceHolder: "Buscar",
            placeHolder: "SELECCIONAR",
            source: dataAdapterGroup, 
            displayMember: "dataNameGroup", 
            valueMember: "dataPkGruop",
            width:70
        }).css("display","inline-block");
    }
}
function createDropDownSubjectMatter(filtrable, selector, update){
    var ordersSource ={
            datatype: "json",
            datafields: [
                { name: 'dataNameSubjectMatter' },
                { name: 'dataPkSubjectMatter' }
            ],
            root: "__ENTITIES",
            id: 'id',
            async: false,
            url: '../serviceSubjectMatter?view=combo&&pkCareer='+filtrable[0]+'&pkSemester='+filtrable[1]+'&pkGroup='+filtrable[2]+'&pkStudyPlan='+filtrable[3]+'&pkPeriod='+filtrable[4]+''
        };
    var dataAdapter = new $.jqx.dataAdapter(ordersSource);
    if(update){
        $(selector).jqxDropDownList('clearSelection');
        $(selector).jqxDropDownList({source: dataAdapter,selectedIndex:0});
    }else{    
        // Create a jqxListBox
        $(selector).jqxDropDownList({ 
            theme: theme,
            selectedIndex: 0, 
            autoDropDownHeight: true,
            filterPlaceHolder: "Buscar",
            placeHolder: "SELECCIONAR",
            source: dataAdapter, 
            displayMember: "dataNameSubjectMatter", 
            valueMember: "dataPkSubjectMatter",
            width: 390
        }).css("display","inline-block");
        $(selector).on('select', function (event) {
            if (event.args) {
                var item = event.args.item;
                if (item) {
                    //alert();
                }
            }
        });
    }
}
function createDropDownSubjectMatterByCurrentSemester(selector, filtrable, update){
    var ordersSource ={
            datatype: "json",
            datafields: [
                { name: 'dataNameSubjectMatter' },
                { name: 'dataPkSubjectMatter' }
            ],
            root: "__ENTITIES",
            id: 'id',
            async: false,
            url: '../serviceSubjectMatter?view=combo',
            data : {
                comboByCurrentSemester : null,
                pkCareer : filtrable.pkCareer,
                pkSemester : filtrable.pkSemester,
                pkStudyPlan : filtrable.pkStudyPlan,
                pkPeriod : filtrable.pkPeriod
            }
        };
    var dataAdapter = new $.jqx.dataAdapter(ordersSource);
    if(update){
        $(selector).jqxDropDownList('clearSelection');
        $(selector).jqxDropDownList({source: dataAdapter,selectedIndex:0});
    }else{    
        // Create a jqxListBox
        $(selector).jqxDropDownList({ 
            theme: theme,
            selectedIndex: 0, 
            autoDropDownHeight: true,
            filterPlaceHolder: "Buscar",
            placeHolder: "SELECCIONAR",
            source: dataAdapter, 
            displayMember: "dataNameSubjectMatter", 
            valueMember: "dataPkSubjectMatter",
            width: 390
        }).css("display","inline-block");
    }
}
function createDropDownSubjectMatterByGroup(filtrable, selector, update){
    var ordersSource ={
            datatype: "json",
            datafields: [
                { name: 'dataNameSubjectMatter' },
                { name: 'dataPkSubjectMatter' }
            ],
            root: "__ENTITIES",
            id: 'id',
            async: false,
            url: '../serviceSubjectMatter?view=combo',
            data : {
                byGroup : null,
                pkCareer : filtrable.pkCareer,
                pkSemester : filtrable.pkSemester,
                pkGroup : filtrable.pkGroup,
                pkPeriod : filtrable.pkPeriod
            }
        };
    var dataAdapter = new $.jqx.dataAdapter(ordersSource);
    if(update){
        $(selector).jqxDropDownList('clearSelection');
        $(selector).jqxDropDownList({source: dataAdapter,selectedIndex:0});
    }else{    
        // Create a jqxListBox
        $(selector).jqxDropDownList({ 
            theme: theme,
            selectedIndex: 0, 
            autoDropDownHeight: true,
            filterPlaceHolder: "Buscar",
            placeHolder: "SELECCIONAR",
            source: dataAdapter, 
            displayMember: "dataNameSubjectMatter", 
            valueMember: "dataPkSubjectMatter",
            width: 390
        }).css("display","inline-block");
    }
}
function createDropDownSubjectMatterByTeacher(period, career, filtrable, group, selector, update){
    var url="../serviceSubjectMatter?view=combo&&teacher&&pkCareer="+career+"&&pkPeriod="+period+"&&pkGroup="+group+"&&pkSemester="+filtrable+"";
    if(group===null){
        url="../serviceSubjectMatter?view=comboWithoutGroup&&teacher&&pkCareer="+career+"&&pkPeriod="+period+"&&pkSemester="+filtrable+"";
    }
    var sourceGroup ={
        datatype: "json",
        root: "__ENTITIES",
        id: "id",
        datafields: [
            { name: 'dataPkSubjectMatter' },
            { name: 'dataNameSubjectMatter' }
        ],
        url: url,
        async: false
    };
    var dataAdapterGroup = new $.jqx.dataAdapter(sourceGroup);
    if(update){
        $(selector).jqxDropDownList('clearSelection');
        $(selector).jqxDropDownList({source: dataAdapterGroup, selectedIndex: 0});
    }else{
        $(selector).jqxDropDownList({
            theme: theme,
            selectedIndex: 0, 
            autoDropDownHeight: false,
            filterPlaceHolder: "Buscar",
            placeHolder: "SELECCIONAR",
            source: dataAdapterGroup, 
            displayMember: "dataNameSubjectMatter", 
            valueMember: "dataPkSubjectMatter",
            width: 390,
            dropDownHeight: 150
        }).css("display","inline-block");
    }
}
function createDropDownSubjectMatterByStudent(selector, update){
    var ordersSource ={
            datatype: "json",
            datafields: [
                { name: 'dataNameSubjectMatter' },
                { name: 'dataPkSubjectMatter' }
            ],
            root: "__ENTITIES",
            id: 'id',
            async: false,
            url: '../../serviceSubjectMatter?view=comboMattersByStudent&pkSemester=0'
        };
    var dataAdapter = new $.jqx.dataAdapter(ordersSource);
    if(update){
        $(selector).jqxDropDownList('clearSelection');
        $(selector).jqxDropDownList({source: dataAdapter,selectedIndex:0});
    }else{    
        // Create a jqxListBox
        $(selector).jqxDropDownList({ 
            theme: "android",
            selectedIndex: 0, 
            autoDropDownHeight: true,
            filterPlaceHolder: "Buscar",
            placeHolder: "SELECCIONAR",
            source: dataAdapter, 
            displayMember: "dataNameSubjectMatter", 
            valueMember: "dataPkSubjectMatter",
            width: "95%"
        });
        $(selector).on('select', function (event) {
            if (event.args) {
                var item = event.args.item;
                if (item) {
                    //alert();
                }
            }
        });
    }
}