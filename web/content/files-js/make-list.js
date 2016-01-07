function createLitsBoxSubjectMatters(filtrable, selector, update){
    var ordersSource ={
            datatype: "json",
            datafields: [
                { name: 'dataNameSubjectMatter' },
                { name: 'id' }
            ],
            root: "__ENTITIES",
            id: 'id',
            async: false,
            url: '../serviceSubjectMatter?view=combo&&pkCareer='+filtrable[0]+'&pkSemester='+filtrable[1]+'&pkGroup='+filtrable[2]+'&pkStudyPlan='+filtrable[3]+'&pkPeriod='+filtrable[4]+''
        };
    var dataAdapter = new $.jqx.dataAdapter(ordersSource);
    if(update){
        $(selector).jqxListBox({ 
            source: dataAdapter,
            selectedIndex:0
        });
    }else{    
        // Create a jqxListBox
        $(selector).jqxListBox({ 
            source: dataAdapter, 
            multipleextended:true,
            selectedIndex:0,
            displayMember: "dataNameSubjectMatter", 
            valueMember: "id", 
            width: 260, 
            height: 200,
            filterable:true,
            filterPlaceHolder: "Buscar"
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

function createLitsBoxTeachers(selector, update){
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
    if(update){
        $(selector).jqxListBox({ 
            source: dataAdapter,
            selectedIndex:0
        });
    }else{    
        // Create a jqxListBox
        $(selector).jqxListBox({ 
            source: dataAdapter, 
            selectedIndex:0,
            displayMember: "dataNameWorker", 
            valueMember: "id", 
            width: 270, 
            height: 200,
            filterable:true,
            filterPlaceHolder: "Buscar"
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
function createLitsBoxGruopByTeacher(period, filtrable, matter, selector, update){
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
        $(selector).jqxListBox({source: dataAdapterGroup, selectedIndex: 0});
    }else{
        $(selector).jqxListBox({
            theme: theme,
            multipleextended: true,
            source: dataAdapterGroup, 
            selectedIndex:0,
            displayMember: "dataNameGroup", 
            valueMember: "dataPkGruop", 
            width: 100, 
            height: 60,
            filterable:false,
            filterPlaceHolder: "Buscar"
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

function createLitsBoxPeriodByTeacher(pkCareer, pkSemester, pkMatter, pkTypeEval, selector){
    var periodSelected = 0;
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
    
    var sourceCareer ={
        datatype: "json",
        root: "__ENTITIES",
        id: "id",
        datafields: [
            { name: 'dataPkPeriod' },
            { name: 'dataNamePeriodAbbreviated' }
        ],
        url: "../servicePeriod?view=periodByTeacherByMatterHistory",
        data:{
            "pkCareer":pkCareer,
            "pkSemester":pkSemester,
            "pkMatter":pkMatter,
            "pkTypeEval":pkTypeEval
        },
        async: false
    };
    var dataAdapterPeriod = new $.jqx.dataAdapter(sourceCareer);
    $(selector).jqxListBox({
        theme: theme,
        source: dataAdapterPeriod, 
        selectedIndex: periodSelected,
        displayMember: "dataNamePeriodAbbreviated", 
        valueMember: "dataPkPeriod", 
        width: 150, 
        height: 105,
        filterable: true,
        filterPlaceHolder: "Buscar"                 
    }).css("display","inline-block");
    //var item = $(selector).jqxListBox('getItemByValue', periodSelected);
    //$(selector).jqxListBox({selectedIndex: item.index }); 
}