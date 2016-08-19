function createDropDownPeriodActive(filtrable, selector){
    var periodSelected = 0;
    $.ajax({
        //Send the paramethers to servelt
        type: "GET",
        url: "http://127.0.0.1/servicePeriod?view=activePeriodYear",
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
        url: "http://127.0.0.1/servicePeriod?view="+filtrable+"",
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
function createDropDownSubjectMatterByStudent(selector, update){
    var ordersSource ={
            datatype: "json",
            crossDomain: true,
            datafields: [
                { name: 'dataNameSubjectMatter' },
                { name: 'dataPkSubjectMatter' },
                { name: 'dataNameWorker' },
                { name: 'dataPkTeacher' }
            ],
            root: "__ENTITIES",
            id: 'id',
            async: false,
            data: {
                "pkStudent": localStorage.getItem("pkStudent") || sessionStorage.getItem("pkStudent")
            },
            url: 'http://127.0.0.1/serviceSubjectMatter?view=comboMattersByStudent&pkSemester=0'
        };
    var dataAdapter = new $.jqx.dataAdapter(ordersSource);
    if(update){
        $(selector).jqxDropDownList('clearSelection');
        $(selector).jqxDropDownList({source: dataAdapter,selectedIndex:0});
        $(selector).off("select");
        $(selector).on("select", function (){
            if(navigator.vibrate) {
                navigator.vibrate(20);
            }
        });
    }else{    
        // Create a jqxListBox
        $(selector).jqxDropDownList({ 
            theme: "mobile",
            selectedIndex: 0, 
            autoDropDownHeight: false,
            dropDownHeight:200,
            itemHeight:35,
            filterPlaceHolder: "Buscar",
            placeHolder: "SELECCIONAR",
            source: dataAdapter, 
            displayMember: "dataNameSubjectMatter", 
            valueMember: "dataPkSubjectMatter",
            width: "100%",
            height: 35
        });
        $(selector).off("select");
        $(selector).on("select", function (){
            if(navigator.vibrate) {
                navigator.vibrate(20);
            }
        });
    }
}
function createDropDownScaleEvaluationBloquedStudent(selector, params, update){
    var sourceCareer ={
        datatype: "json",
        root: "__ENTITIES",
        id: "id",
        datafields: [
            { name: 'dataPkScaleEvalution' },
            { name: 'dataNameScale' },
            { name: 'dataMaxValue' }
        ],
        url: "http://127.0.0.1/serviceScaleEvaluation",
        data : {
            "view" : "comboBloquedStudent",
            "pkMatter" : params.pkMatter,
            "pkTeacher" : params.pkTeacher
        },
        async: false
    };
    var dataAdapterCareer = new $.jqx.dataAdapter(sourceCareer);
    if(update){
        $(selector).jqxDropDownList('clearSelection');
        $(selector).jqxDropDownList({source: dataAdapterCareer, selectedIndex: 0});
    }else{
        $(selector).jqxDropDownList({
            theme: "mobile",
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