function createInputEnrrollment(selector, update){
    var ordersSource =
            {
                url: "../serviceStudent?consultAllEnrollments",
                async: false,
                datatype: "json",
                root: "__ENTITIES",
                datafields: [
                    { name: 'id' },
                    { name: 'dataNameEnrollment' }
                ]
            };
    var dataAdapter = new $.jqx.dataAdapter(ordersSource);
    if(update){
        $(selector).jqxInput({source: dataAdapter});
    }else{    
        // Create a jqxListBox
        $(selector).jqxInput({ 
            theme:theme,
            source: dataAdapter, 
            maxLength: 13,
            placeHolder: "Matrícula",
            displayMember: "dataNameEnrollment", 
            valueMember: "id", 
            width: "180px", 
            height: "26px"
        });
    }
}
function createInputFolioSystem(selector, update){
    var ordersSource =
            {
                url: "../serviceCandidate?consultAllFoliosSystem",
                async: false,
                datatype: "json",
                root: "__ENTITIES",
                datafields: [
                    { name: 'dataProgresivNumber' },
                    { name: 'dataNameFolio' }
                ]
            };
    var dataAdapter = new $.jqx.dataAdapter(ordersSource);
    if(update){
        $(selector).jqxInput({source: dataAdapter});
    }else{    
        // Create a jqxListBox
        $(selector).jqxInput({ 
            theme:theme,
            source: dataAdapter, 
            maxLength: 8,
            placeHolder: "Folio Sistema",
            displayMember: "dataNameFolio", 
            valueMember: "dataProgresivNumber",
            width: 90, 
            height: 15
        });
    }
}
function createInputFolioSystemAll(selector, update){
    var ordersSource =
            {
                url: "../serviceCandidate?consultAllFoliosSystemAll",
                async: false,
                datatype: "json",
                root: "__ENTITIES",
                datafields: [
                    { name: 'dataProgresivNumber' },
                    { name: 'dataNameFolio' }
                ]
            };
    var dataAdapter = new $.jqx.dataAdapter(ordersSource);
    if(update){
        $(selector).jqxInput({source: dataAdapter});
    }else{    
        // Create a jqxListBox
        $(selector).jqxInput({ 
            theme:theme,
            source: dataAdapter, 
            maxLength: 8,
            placeHolder: "Folio Sistema",
            displayMember: "dataNameFolio", 
            valueMember: "dataProgresivNumber",
            width: 90, 
            height: 15
        });
    }
}
function createInputFolioUtsem(selector, update){
    var ordersSource =
            {
                url: "../serviceCandidate?consultAllFoliosUtsem",
                async: false,
                datatype: "json",
                root: "__ENTITIES",
                datafields: [
                    { name: 'dataProgresivNumber' },
                    { name: 'dataNameFolio' }
                ]
            };
    var dataAdapter = new $.jqx.dataAdapter(ordersSource);
    if(update){
        $(selector).jqxInput({source: dataAdapter});
    }else{    
        // Create a jqxListBox
        $(selector).jqxInput({ 
            theme:theme,
            source: dataAdapter, 
            maxLength: 8,
            placeHolder: "Folio Utsem",
            displayMember: "dataNameFolio", 
            valueMember: "dataProgresivNumber",
            width: 120, 
            height: 15
        });
    }
}