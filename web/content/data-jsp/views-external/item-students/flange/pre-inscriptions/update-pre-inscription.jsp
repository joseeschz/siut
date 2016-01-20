<script>
$(document).ready(function () {
    var itemEntity=0;
    var itemMunicipality=0;
    var itemLocality=0;
    //Creating wizard module
    var wizard = (function () {
        //Adding event listeners
        var _addHandlers = function () {
            $('.nextButton').click(function () {
                wizard.validate(true);
                $('#jqxWisard').jqxTabs('next');
            });
            $('.backButton').click(function () {
                wizard.validate(true);
                $('#jqxWisard').jqxTabs('previous');
            });
        };
        return {
           
            //Initializing the wizzard - creating all elements, adding event handlers and starting the validation
            init: function () {
                $('#jqxWisard').jqxTabs({ height: "600px", width: "auto",  keyboardNavigation: false, disabled: true});
                $('.nextButton').jqxButton({ width: 80, height: "26px"});
                $('.backButton').jqxButton({ width: 80, height: "26px"});
                $('.disabled').jqxButton({disabled: true });
                _addHandlers();
                this.validate();
                this.showHint('Validation hints.');
            },
            //Validating all wizard tabs
            validate: function (notify) {
                return;
//                if (!this.firstTab(notify)) {
//                    $('#jqxWisard').jqxTabs('disableAt', 1);
//                    $('#jqxWisard').jqxTabs('disableAt', 2);
//                    ;
//                } else {
//                    $('#jqxWisard').jqxTabs('enableAt', 1);
//                }
//                if (!this.secondTab(notify)) {
//                    $('#jqxWisard').jqxTabs('disableAt', 2);
//                    return;
//                } else {
//                    $('#jqxWisard').jqxTabs('enableAt', 2);
//                }
            },
            //Displaying message to the user
            showHint: function (message, selector) {
                if (typeof selector === 'undefined') {
                    selector = '.hint';
                }
                if (message === '') {
                    message = 'You can continue.';
                }
                $(selector).html('<strong>' + message + '</strong>');
            },
            //Validating the first tab
            firstTab: function (notify) {
                
                return true;
            },
            //Validating the second tab
            secondTab: function () {
                
                return true;
            },
            thirdTab: function () {
                
                return true;
            },
            fourthTab: function () {
                
                return true;
            }
        };
    }());
    //Initializing the wizard
    //
    initConponents();
    wizard.init();
    var pk_student=undefined;
    $("#removeFolioSystemVerify").hide();
    $("#medatadaUpdate").jqxExpander({theme:theme, toggleMode: 'none', width: '950px', height: 690, showArrow: false});
    createInputFolioSystemAll("#folioSystemVerify",false);
    var folioSystemVerify="";
    $("#folioSystemVerify").on('select',function (event){
        if(event.args){
            var item = event.args.item;
            if(item){
                pk_student = item.value;
                folioSystemVerify = item.label;
            }
        }
        if(folioSystemVerify.length>=3){
            $.ajax({
                type: "POST",
                url: "../serviceCandidate?selectCandidateByPkCandidate",
                data: {"folioSystem":folioSystemVerify},
                async: true,
                dataType: 'json',
                beforeSend: function (xhr) {
                    $("#loadingPictureUpdate").show();
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert("Error interno del servidor");
                },
                success: function (data, textStatus, jqXHR) {
                    $("#removeFolioSystemVerify").show();
                    disableElements(false);
                    loadData(folioSystemVerify);
                }
            }).done(function (){
                $("#loadingPictureUpdate").fadeOut("slow");
                
            });
        }
    });
    $("#removeFolioSystemVerify").click(function (){
        $(this).hide();
        pk_student=undefined;
        disableElements(true);
    });
    disableElements(true);
    
    function  disableElements(status){
        $('#folioSystemVerify').jqxInput({disabled: !status});
        $('#jqxWisard').jqxTabs({disabled: status});
         if(status){
            $("input[data-type-role=text]").jqxInput({disabled: status});
            $("input[data-type-role=radio]").jqxInput({disabled: status});
            $("input[type=button]").jqxButton({disabled: status});
            $("[data-type-role=combo]").jqxDropDownList({disabled: status});
            $("[data-type-role=text].jqx-numberinput").jqxNumberInput({disabled: status});
            $("[data-type-role=text].telephoneInput").jqxMaskedInput({disabled: status});
            $("[data-type-role=text].zip-codeInput").jqxMaskedInput({disabled: status});
            $("[data-type-role=text].calendarInput").jqxDateTimeInput({disabled: status});
            //$("[data-type-role=file]").jqxFileUpload({disabled: status});
            $('#folioSystemVerify').val("");
            $("[data-field=true]").each(function (){
                var name_data_fiel;
                var data_rol;
                name_data_fiel= $(this).attr("name");
                data_rol = $(this).attr("data-type-role");
                if(data_rol==="text"){
                    if($(this).attr("name")==="fl_date_born" || $(this).attr("name")==="fl_born_date_tutor" ){
                    }else{
                        $(this).val("");
                    }
                }
                if(data_rol==="radio"){
                    $("input[type=radio]").prop('checked',false);
                }
                if(data_rol==="combo"){    
                    $("#"+name_data_fiel).jqxDropDownList('selectIndex', 0);
                }
                if(data_rol==="checkbox"){    
                    $("input[type=checkbox]").prop('checked',false);
                }
            });
        }else{
            
            $("input[data-type-role=text]").jqxInput({disabled: status});
            $("input[data-type-role=radio]").jqxInput({disabled: status});
            $("input[type=button]").jqxInput({disabled: status});
            $("[data-type-role=combo]").jqxDropDownList({disabled: status});
            $("[data-type-role=text].jqx-numberinput").jqxNumberInput({disabled: status});
            $("[data-type-role=text].telephoneInput").jqxMaskedInput({disabled: status});
            $("[data-type-role=text].zip-codeInput").jqxMaskedInput({disabled: status});
            $("[data-type-role=text].calendarInput").jqxDateTimeInput({disabled: status});
            $("[data-type-role=file]").jqxFileUpload({disabled: status});
        }
    }
    function initConponents(){     
        $("div[data-type-role='text']").css("display","inline-table");
        $("input").jqxInput({theme: theme});
        $("input[data-field=true]").jqxInput({height: '26px'});
        $("#fl_above_average").jqxNumberInput({theme: theme, width: '60px',height: '26px',spinButtons: true,groupSize: 0,decimalDigits: 1,digits:2,max:10,min:0});
        $("#fl_number_members_famly").jqxNumberInput({theme: theme, width: '50px',height: '26px',spinButtons: true,groupSize: 0,decimalDigits: 0,digits:2,max:20,min:0});
        $(".numberInputMoney").jqxNumberInput({theme: theme, width: '110px', height: '26px',spinButtons: true, decimalDigits: 2,digits:5, min: 0, max: 100000, symbol: '$'});
        $(".zip-codeInput").jqxMaskedInput({theme: theme, mask: '#####', width: '70px', height: '26px'  });
        $(".telephoneInput").jqxMaskedInput({theme: theme, mask: '(###)###-####', width: '150px', height: '26px'  });
        $('.calendarInput').jqxDateTimeInput({culture: 'es-MX',formatString: "yyyy/MM/dd", theme: theme, width: '120px', height: '26px'});
        $("div [data-file=true]").each(function (){
            $('#'+$(this).attr("id")).jqxFileUpload({
                theme:theme,
                uploadUrl: '../serviceFile?update='+$(this).attr("id"),
                fileInputName: 'fileInput',
                autoUpload: false,
                accept: 'application/pdf',
                multipleFilesUpload: false,
                renderFiles: function (fileName) {
                    var stopIndex = fileName.indexOf('.');
                    var name = fileName.slice(0, stopIndex);
                    var extension = fileName.slice(stopIndex);
                    return '<div>Archivo<strong>' + extension + '</strong></div>';
                }
            }).css({"display": "inline-block", "padding":"1px"});
            $('#'+$(this).attr("id")).on('uploadEnd', function (event) {
                var args = event.args;
                var serverResponce = args.response;
                if(serverResponce==="<pre>File much long</pre>"){
                    $('#wizard').smartWizard('showMessage',"No es posible cargar el archivo por que es mayor a 1MB");
                    setTimeout(function (){
                        $(".msgBox").fadeOut();
                    },4000);
                }else if(serverResponce==="<pre>Cargado</pre>"){
                    $('#wizard').smartWizard('showMessage',"Archivo cargado correctamente");
                    setTimeout(function (){
                        $(".msgBox").fadeOut();
                    },2000);
                }else if(serverResponce==="<pre>Fail</pre>"){
                    $('#wizard').smartWizard('showMessage',"El archivo no se pudo guardar en la base de datos");
                    setTimeout(function (){
                        $(".msgBox").fadeOut();
                    },2000);
                }
            });
        });
        $("#load-data").jqxWindow({
            theme:theme,
            width: 370, 
            height: 100,
            showCloseButton: false,    
            position: { x: (($(document).width()/2)-(370/2)), y: (($(document).height()/2)-100) },
            resizable: false,  
            draggable: false,
            isModal: true, 
            autoOpen: false, 
            modalOpacity: 0.3           
        });
    
        $("[name=fl_physical_disability]").change(function (){
            if($(this).val()==="Si"){
                $("#disability_name_div").fadeIn();
            }else{
                $("input[name=fl_disability_name]").val("");
                $("#disability_name_div").fadeOut();
                if(pk_student!=undefined){
                    $.ajax({
                        type: "POST",
                        async: true,
                        url: "../serviceCandidate?updateField",
                        data: {"pkStudent":pk_student,"field_name":"fl_disability_name","field_value":""},
                        beforeSend: function (xhr) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) {
                        }
                    });
                }
            }
        });
        $("[name=fl_indigenous_group]").change(function (){
            if($(this).val()==="Si"){
                $("#indigenous_group_name_div").fadeIn();
            }else{
                $("input[name=fl_indigenous_group_name]").val("");
                $("#indigenous_group_name_div").fadeOut();
                if(pk_student!=undefined){
                    $.ajax({
                        type: "POST",
                        async: true,
                        url: "../serviceCandidate?updateField",
                        data: {"pkStudent":pk_student,"field_name":"fl_indigenous_group_name","field_value":""},
                        beforeSend: function (xhr) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) {
                        }
                    });
                }
            }
        });
        $("[name=fl_secutity_medical]").change(function (){
            if($(this).val()==="Si"){
                $("#fl_number_security_medical_div").fadeIn();
            }else{
                $("input[name=fl_security_name]").val("");
                $("input[name=fl_number_security_medical]").val("");
                $("#fl_number_security_medical_div").fadeOut();
                if(pk_student!=undefined){
                    $.ajax({
                        type: "POST",
                        async: true,
                        url: "../serviceCandidate?updateField",
                        data: {"pkStudent":pk_student,"field_name":"fl_security_name","field_value":""},
                        beforeSend: function (xhr) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) {
                        }
                    });
                    $.ajax({
                        type: "POST",
                        async: true,
                        url: "../serviceCandidate?updateField",
                        data: {"pkStudent":pk_student,"field_name":"fl_number_security_medical","field_value":""},
                        beforeSend: function (xhr) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) {
                        }
                    });
                }
            }
        });
        $("[name=fl_diffusion_other]").change(function (){
            if($(this).prop("checked")){
                $("#fl_diffusion_other_div").fadeIn();
            }else{
                $("input[name=fl_diffusion_other_name]").val("");
                $("#fl_diffusion_other_div").fadeOut();
                if(pk_student!=undefined){
                    $.ajax({
                        type: "POST",
                        async: true,
                        url: "../serviceCandidate?updateField",
                        data: {"pkStudent":pk_student,"field_name":"fl_diffusion_other_name","field_value":""},
                        beforeSend: function (xhr) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) {
                        }
                    });
                }
            }
        });
        $("#fl_period_bacherol").jqxMaskedInput({width: '130px', height: '26px', mask:'(####) - (####)', value: 20152016});
        createDropDownEntity("#fk_entity",'null',false);
        $("#fk_entity").jqxDropDownList({placeHolder: "SELECCIONAR", disabled:false,filterable:true, filterPlaceHolder: "Buscar",autoDropDownHeight: false, dropDownHeight: 300});
        itemEntity = $('#fk_entity').jqxDropDownList('getSelectedItem');
        createDropDownMunicipality(itemEntity.value, 'null', "#fk_municipality",false);
        $("#fk_municipality").jqxDropDownList({disabled:false, autoDropDownHeight: false, width: 300, placeHolder: "Seleccionar", dropDownHeight: 300});
        itemMunicipality=$('#fk_municipality').jqxDropDownList('getSelectedItem');
        createDropDownLocality(itemMunicipality.value,'byPk', "#fk_locality",false);
        $("#fk_locality").jqxDropDownList({disabled:false,autoDropDownHeight: false,width: 360, placeHolder: "Seleccionar",dropDownHeight: 300});
        itemLocality=$('#fk_locality').jqxDropDownList('getSelectedItem');
        createDropDownPreparatory(itemLocality.value, "#fk_preparatory", false);
        $("#fk_preparatory").jqxDropDownList({disabled:false,autoDropDownHeight: false, placeHolder: "Seleccionar"});

        // prepare the data                    
        $('#fk_entity').on('select',function (event){
            var args = event.args;
            if (args) {
                itemEntity = args.item;
            }
            createDropDownMunicipality(itemEntity.value,'null', "#fk_municipality",true);
        });
        $('#fk_municipality').on('select',function (event){  
            var args = event.args;
            if (args) {
                itemMunicipality = args.item;
            }
            createDropDownLocality(itemMunicipality.value, 'byPk', "#fk_locality",true);
        });
        $('#fk_locality').on('select',function (event){  
            var args = event.args;
            if (args) {
                itemLocality = args.item;
            }
            createDropDownPreparatory(itemLocality.value, "#fk_preparatory", true);
        });

        createDropDownEntity("#fk_born_entity",'inegi',false);
        itemEntity = $('#fk_born_entity').jqxDropDownList('getSelectedItem');
        createDropDownMunicipality(itemEntity.value, 'byPkInegi', "#fk_born_municipality",false);
        itemMunicipality=$('#fk_born_municipality').jqxDropDownList('getSelectedItem');
        createDropDownLocality(itemMunicipality.value,'byPkInegi', "#fk_born_locality",false);

        $('#fk_born_entity').on('select',function (event){
            var args = event.args;
            if (args) {
                itemEntity = args.item;
            }
            createDropDownMunicipality(itemEntity.value,'byPkInegi', "#fk_born_municipality",true);
        });
        $('#fk_born_municipality').on('select',function (event){  
            var args = event.args;
            if(args){
                itemMunicipality = args.item;
            }
            createDropDownLocality(itemMunicipality.value, 'byPkInegi', "#fk_born_locality",true);
        });
        $('#fk_born_locality').on('select',function (event){  
            var args = event.args;
            if (args) {
                itemLocality = args.item;
            }
        });
        createDropDownEntity("#fk_current_entity",'inegi',false);
        itemEntity = $('#fk_current_entity').jqxDropDownList('getSelectedItem');
        createDropDownMunicipality(itemEntity.value, 'byPkInegi', "#fk_current_municipality",false);
        itemMunicipality=$('#fk_current_municipality').jqxDropDownList('getSelectedItem');
        createDropDownLocality(itemMunicipality.value,'byPkInegi', "#fk_current_locality",false);
        $('#fk_current_entity').on('select',function (event){
            var args = event.args;
            if (args) {
                itemEntity = args.item;
            }
            createDropDownMunicipality(itemEntity.value,'byPkInegi', "#fk_current_municipality",true);
        });
        $('#fk_current_municipality').on('select',function (event){  
            var args = event.args;
            if(args){
                itemMunicipality = args.item;
            }
            createDropDownLocality(itemMunicipality.value, 'byPkInegi', "#fk_current_locality",true);
        });
        $('#fk_current_locality').on('select',function (event){  
            var args = event.args;
            if (args) {
                itemLocality = args.item;
            }
        });

        createDropDownEntity("#fk_born_entity_tutor",'inegi',false);
        itemEntity = $('#fk_born_entity_tutor').jqxDropDownList('getSelectedItem');
        createDropDownMunicipality(itemEntity.value, 'byPkInegi', "#fk_born_municipality_tutor",false);
        itemMunicipality=$('#fk_born_municipality_tutor').jqxDropDownList('getSelectedItem');
        createDropDownLocality(itemMunicipality.value,'byPkInegi', "#fk_born_locality_tutor",false);

        $('#fk_born_entity_tutor').on('select',function (event){
            var args = event.args;
            if (args) {
                itemEntity = args.item;
            }
            createDropDownMunicipality(itemEntity.value,'byPkInegi', "#fk_born_municipality_tutor",true);
        });

        $('#fk_born_municipality_tutor').on('select',function (event){  
            var args = event.args;
            if(args){
                itemMunicipality = args.item;
            }
            createDropDownLocality(itemMunicipality.value, 'byPkInegi', "#fk_born_locality_tutor",true);
        });
        $('#fk_born_locality_tutor').on('select',function (event){  
            var args = event.args;
            if (args) {
                itemLocality = args.item;
            }
        });
        createDropDownEntity("#fk_current_entity_tutor",'inegi',false);
        itemEntity = $('#fk_current_entity_tutor').jqxDropDownList('getSelectedItem');
        createDropDownMunicipality(itemEntity.value, 'byPkInegi', "#fk_current_municipality_tutor",false);
        itemMunicipality=$('#fk_current_municipality_tutor').jqxDropDownList('getSelectedItem');
        createDropDownLocality(itemMunicipality.value,'byPkInegi', "#fk_current_locality_tutor",false);

        $('#fk_current_entity_tutor').on('select',function (event){
            var args = event.args;
            if (args) {
                itemEntity = args.item;
            }
            createDropDownMunicipality(itemEntity.value,'byPkInegi', "#fk_current_municipality_tutor",true);
        });
        $('#fk_current_municipality_tutor').on('select',function (event){  
            var args = event.args;
            if(args){
                itemMunicipality = args.item;
            }
            createDropDownLocality(itemMunicipality.value, 'byPkInegi', "#fk_current_locality_tutor",true);
        });
        $('#fk_current_locality_tutor').on('select',function (event){  
            var args = event.args;
            if (args) {
                itemLocality = args.item;
            }
        });
    }
    function loadData(folioSystemVerify){
        $.ajax({
            type: "POST",
            url: "../serviceCandidate?selectCandidateByPkCandidate",
            data: {"folioSystem" : folioSystemVerify},
            async: true,
            beforeSend: function (xhr) {
                $("#load-data").jqxWindow('open');
            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert("Error interno del servidor");
            },
            success: function (data, textStatus, jqXHR) {
                var name_data_fiel;
                var data_rol;
                $("#load-data").jqxWindow('open');
                $("[data-field=true]").each(function (){
                    name_data_fiel= $(this).attr("name");
                    data_rol = $(this).attr("data-type-role");
                    if(data_rol==="text"){
                        $(this).val(data[name_data_fiel]);
                    }
                    if(data_rol==="radio"){
                        if($(this).attr("value")==data[name_data_fiel]){
                            $("input[name="+name_data_fiel+"][value="+data[name_data_fiel]+"]").prop('checked',true);
                        }
                        if("fl_physical_disability"===name_data_fiel){
                            if($("[name=fl_physical_disability]").prop('checked')){
                                $("#disability_name_div").fadeIn();
                            }else{
                                $("#fl_disability_name").val("");
                                $("#disability_name_div").fadeOut();
                            }
                        }
                        if("fl_indigenous_group"===name_data_fiel){
                            if($("[name=fl_indigenous_group]").prop('checked')){
                                $("#indigenous_group_name_div").fadeIn();
                            }else{
                                $("#fl_indigenous_group_name").val("");
                                $("#indigenous_group_name_div").fadeOut();
                            }
                        }
                        if("fl_secutity_medical"===name_data_fiel){
                            if($("[name=fl_secutity_medical]").prop('checked')){
                                $("#fl_number_security_medical_div").fadeIn();
                            }else{
                                $("#fl_number_security_medical").val("");
                                $("#fl_number_security_medical_div").fadeOut();
                            }
                        }
                    }
                    if(data_rol==="combo"){    
                        itemEntity = $("#"+name_data_fiel).jqxDropDownList('getItemByValue', data[name_data_fiel]);
                        $("#"+name_data_fiel).jqxDropDownList('selectItem', itemEntity);
                    }
                    if(data_rol==="checkbox"){    
                        if("fl_diffusion_other"===name_data_fiel){
                            if($("[name=fl_diffusion_other]").prop('checked')){
                                $("#fl_diffusion_other_div").fadeIn();
                            }else{
                                $("#fl_diffusion_other_name").val("");
                                $("#fl_diffusion_other_div").fadeOut();
                            }
                        }
                        if($(this).attr("value")===data[name_data_fiel]){
                            $("input[name="+name_data_fiel+"][value="+data[name_data_fiel]+"]").prop('checked',true);
                        }else{
                            $("input[name="+name_data_fiel+"][value="+data[name_data_fiel]+"]").prop('checked',false);
                        }
                    }
                });
            }
        }).done(function (){
            $("#load-data").jqxWindow('close');
        });
    }
    var old_field_value;
    var field_value;
    var old_field_name;
    var field_name;
    $('.calendarInput').on('textchanged', function (event) {
        old_field_name= $(this).attr("name");
    }); 
    $("[data-field=true]").focusin(function (){
        old_field_name= $(this).attr("name");
        var data_rol = $(this).attr("data-type-role");
        if(data_rol==="text"){
            old_field_value = $(this).val();
        }
        if(data_rol==="radio"){
            old_field_value=$("input[name="+old_field_name+"]:checked").val();
        }
        if(data_rol==="checkbox"){
            old_field_value=$("input[name="+old_field_name+"]:checked").val();
            if(old_field_value==undefined){
                old_field_value="No";
            }
        }
    });
    $("[data-field=true]").change(function (){
        field_name= $(this).attr("name");
        var data_rol = $(this).attr("data-type-role");
        var flag=false;
        if(data_rol==="text"){
            flag=true;
            field_value = $(this).val();
        }
        if(data_rol==="combo"){ 
            flag=false;
            field_value = undefined;
        }
        if(data_rol==="radio"){
            flag=true;
            field_value=$("input[name="+field_name+"]:checked").val();
        }
        if(data_rol==="checkbox"){
            flag=true;
            field_value=$("input[name="+field_name+"]:checked").val();
            if(field_value==undefined){
                field_value="No";
            }
        }
        if(old_field_name===field_name&&old_field_value!==field_value){
            if(flag){
                if(pk_student!=undefined){
                    $.ajax({
                        type: "POST",
                        async: false,
                        url: "../serviceCandidate?updateField",
                        data: {"pkStudent":pk_student,"field_name":field_name,"field_value":field_value},
                        beforeSend: function (xhr) {
                            $(".loader").fadeIn("slow");
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) {
                            $(".loader").fadeOut("slow");
                            flag=false;
                        }
                    });
                }
            }
        }
    });
    $("[data-field=true]").select(function (){
        field_name= $(this).attr("name");
        var data_rol = $(this).attr("data-type-role");
        if(data_rol==="combo"){  
            field_value = $(this).val();
            if(old_field_name===field_name&&old_field_value!==field_value){
                if(pk_student!=undefined){
                    $.ajax({
                        type: "POST",
                        async: false,
                        url: "../serviceCandidate?updateField",
                        data: {"pkStudent":pk_student,"field_name":field_name,"field_value":field_value},
                        beforeSend: function (xhr) {
                            $(".loader").fadeIn("slow");
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) {
                            $(".loader").fadeOut("slow");
                        }
                    });
                }
            }
        }
    });
    $("#fl_acept_term").change(function (){
        validateSteps("5");
    });

    //Make combo since sourse
    var source = ["GENERAL","UNIVERSITARIO", "TECNOLÓGICO"];
    $("#fl_bacherol_type").jqxDropDownList({theme: theme, placeHolder: "SELECCIONAR", selectedIndex: -1, autoDropDownHeight:80, source: source, width: '120px', height: '26px' }).css("display","inline-block");

    var source = ["PÚBLICA","PRIVADA"];
    $("#fl_school_type").jqxDropDownList({theme: theme, placeHolder: "SELECCIONAR", selectedIndex: -1, autoDropDownHeight:80, source: source, width: '120px', height: '26px' }).css("display","inline-block");

    var source = ["CASADO(A)","SOLTERO(A)", "VIUDO(A)","DIVORCIADO(A)", "UNIÓN LIBRE"];
    $("#fl_maritial_status").jqxDropDownList({theme: theme, placeHolder: "SELECCIONAR", selectedIndex: -1, autoDropDownHeight:80, source: source, width: '120px', height: '26px' }).css("display","inline-block");

    var source = ["PADRE","MADRE","HERMANO(A)","ABUELO(A)","TIO(A)","OTRO"];
    $("#fl_tutor_relationship").jqxDropDownList({theme: theme, placeHolder: "SELECCIONAR", selectedIndex: -1, autoDropDownHeight:80, source: source, width: '120px', height: '26px' }).css("display","inline-block");

    var source = ["CASADO(A)","SOLTERO(A)", "VIUDO(A)","DIVORCIADO(A)","UNIÓN LIBRE"];
    $("#fl_maritial_state_tutor").jqxDropDownList({theme: theme, placeHolder: "SELECCIONAR", selectedIndex: -1, autoDropDownHeight:80, source: source, width: '120px', height: '26px' }).css("display","inline-block");

    var source = ["PRIMARIA","SECUNDARIA", "PREPARATORIA", "UNIVERSIDAD", "MAESTRIA", "DOCTORADO", "NINGUNO"];
    $("#fl_level_education").jqxDropDownList({theme: theme, placeHolder: "SELECCIONAR", selectedIndex: -1, autoDropDownHeight:80, source: source, width: '150px', height: '26px' }).css("display","inline-block");

    var source = ["PROPIA", "PRESTADA", "RENTADA"];
    $("#fl_house_status").jqxDropDownList({theme: theme, placeHolder: "SELECCIONAR", selectedIndex: -1, autoDropDownHeight:80, source: source, width: '120px', height: '26px' }).css("display","inline-block");

    var source = ["MADERA", "TRIPLAY", "TABICON","BLOCK","LADRILLO", "ADOBE","TABLA ROCA", "CARTON"];
    $("#fl_wall_material").jqxDropDownList({theme: theme, placeHolder: "SELECCIONAR", selectedIndex: -1, autoDropDownHeight:80, source: source, width: '130px', height: '26px' }).css("display","inline-block");

    var source = ["TEJAS", "MADERA", "MADERA Y TEJAS", "LAMINAS", "CONCRETO", "ADOBE"];
    $("#fl_roof_material").jqxDropDownList({theme: theme, placeHolder: "SELECCIONAR", selectedIndex: -1, autoDropDownHeight:80, source: source, width: '130px', height: '26px' }).css("display","inline-block");

    var source = ["TIERRA", "PISO FIRME", "CONCRETO","LOSETA", "MADERA"];
    $("#fl_floor_material").jqxDropDownList({theme: theme, placeHolder: "SELECCIONAR", selectedIndex: -1, autoDropDownHeight:80, source: source, width: '120px', height: '26px' }).css("display","inline-block");

    var source = ["PRIMERA", "SEGUNDA", "TERCERA","CUARTA", "QUINTA"];
    $("#fl_option_utsem_study").jqxDropDownList({theme: theme, placeHolder: "SELECCIONAR", selectedIndex: -1, autoDropDownHeight:80, source: source, width: '120px', height: '26px' }).css("display","inline-block");

    $("#form1").jqxValidator({
        hintType : 'label',
        animationDuration: 0,
        rules: [
                    { input: "#fl_curp", message: "Requerido", action: 'keyup, blur',  rule: "required"}
                ]
    });  
    $("#form2").jqxValidator({
        hintType : 'label',
        animationDuration: 0,
        rules: [
                    { input: '#fl_mail', message: 'E-mail es Requerido!', action: 'keyup, blur', rule: 'required' },
                    { input: '#fl_mail', message: 'E-mail invalido!', action: 'keyup', rule: 'email' }
                ]
    });  
    $("#form3").jqxValidator({
        hintType : 'label',
        animationDuration: 0,
        rules: [
                    { input: '#fl_mail_tutor', message: 'E-mail invalido!', action: 'keyup', rule: 'email' }
                ]
    });  

    function validateSteps(step){
        var isStepValid=true;       
        if(step === "1"){
            if(!$('#form1').jqxValidator('validate')){
                isStepValid = false; 
                $('#wizard').smartWizard('setError',{stepnum:1,iserror:true});                           
            }else{
                $('#wizard').smartWizard('setError',{stepnum:1,iserror:false});
            }   
            if($("[name=fl_gender]:checked").val()==undefined){
                $('#wizard').smartWizard('setError',{stepnum:1,iserror:true});
                $('#wizard').smartWizard('showMessage',"Selecciona el sexo");
                setTimeout(function (){
                    $(".msgBox").fadeOut();
                },1000);
                isStepValid=false;
            }else{
                $('#wizard').smartWizard('setError',{stepnum:1,iserror:false});
            }
            var fk_preparatory = $('#fk_preparatory').jqxDropDownList('getSelectedItem');        
            if(fk_preparatory.value==="0"){
                $('#wizard').smartWizard('setError',{stepnum:1, iserror:true});
                $('#wizard').smartWizard('showMessage',"Selecciona una preparatoria");
                setTimeout(function (){
                    $(".msgBox").fadeOut();
                },1000);
                isStepValid=false;
            }else{
                $('#wizard').smartWizard('setError',{stepnum:1,iserror:false});
                fk_preparatory= (fk_preparatory.value);
                if(pk_student!=undefined){
                    $.ajax({
                        type: "POST",
                        async: false,
                        url: "../serviceCandidate?updateField",
                        data: {"pkStudent":pk_student,"field_name":"fk_preparatory","field_value": fk_preparatory},
                        beforeSend: function (xhr) {
                            $(".loader").fadeIn("slow");
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) {
                            $(".loader").fadeOut("slow");
                        }
                    });
                }
                var fl_bacherol_type = $('#fl_bacherol_type').jqxDropDownList('getSelectedItem');        
                if(fl_bacherol_type==null){
                    $('#wizard').smartWizard('setError',{stepnum:1, iserror:true});
                    $('#wizard').smartWizard('showMessage',"Selecciona el tipo de bachillerato");
                    setTimeout(function (){
                        $(".msgBox").fadeOut();
                    },1000);
                    isStepValid=false;
                }else{
                    $('#wizard').smartWizard('setError',{stepnum:1, iserror: false});
                }
                var fl_maritial_status = $('#fl_maritial_status').jqxDropDownList('getSelectedItem'); 
                if(fl_maritial_status==null){
                    $('#wizard').smartWizard('setError',{stepnum:1, iserror:true});
                    $('#wizard').smartWizard('showMessage',"Selecciona el estado civil");
                    setTimeout(function (){
                        $(".msgBox").fadeOut();
                    },1000);
                    isStepValid=false;
                }else{
                    $('#wizard').smartWizard('setError',{stepnum:1, iserror: false});
                }
            }                            
        }
        if(step === "2"){
            if($('#form2').jqxValidator('validate')){    
                var fk_born_entity = $('#fk_born_entity').jqxDropDownList('getSelectedItem');        
                if(fk_born_entity.value==="0"){
                    $('#wizard').smartWizard('setError',{stepnum:2,iserror:true}); 
                    $('#wizard').smartWizard('showMessage',"Selecciona la entidad de nacimiento");
                    setTimeout(function (){
                        $(".msgBox").fadeOut();
                    },1000);
                    isStepValid=false;
                }else{
                    var fk_born_municipality = $('#fk_born_municipality').jqxDropDownList('getSelectedItem');        
                    if(fk_born_municipality.value==="0"){
                        $('#wizard').smartWizard('setError',{stepnum:2, iserror:true});
                        $('#wizard').smartWizard('showMessage',"Selecciona el municipio de nacimiento");
                        setTimeout(function (){
                            $(".msgBox").fadeOut();
                        },1000);
                        isStepValid=false;
                    }else{
                        var fk_born_locality = $('#fk_born_locality').jqxDropDownList('getSelectedItem');        
                        if(fk_born_locality.value==="0"){
                            $('#wizard').smartWizard('setError',{stepnum:2, iserror:true});
                            $('#wizard').smartWizard('showMessage',"Selecciona la localidad de nacimiento");
                            setTimeout(function (){
                                $(".msgBox").fadeOut();
                            },1000);
                            isStepValid=false;
                        }else{
                            $('#wizard').smartWizard('setError',{stepnum:2,iserror:false});
                            fk_born_locality= (fk_born_locality.value);
                            if(pk_student!=undefined){
                                $.ajax({
                                    type: "POST",
                                    async: false,
                                    url: "../serviceCandidate?updateField",
                                    data: {"pkStudent":pk_student,"field_name":"fk_born_locality","field_value": fk_born_locality},
                                    beforeSend: function (xhr) {
                                        $(".loader").fadeIn("slow");
                                    },
                                    error: function (jqXHR, textStatus, errorThrown) {
                                        alert("Error interno del servidor");
                                    },
                                    success: function (data, textStatus, jqXHR) {
                                        $(".loader").fadeOut("slow");
                                    }
                                });
                            }
                        }
                    }
                }
                var fk_born_locality = $('#fk_born_locality').jqxDropDownList('getSelectedItem');    
                var fk_current_entity = $('#fk_current_entity').jqxDropDownList('getSelectedItem');  
                if(fk_born_locality.value==="0"){
                    $('#wizard').smartWizard('setError',{stepnum:2, iserror:true});
                    $('#wizard').smartWizard('showMessage',"Selecciona la localidad de nacimiento");
                    setTimeout(function (){
                        $(".msgBox").fadeOut();
                    },1000);
                    isStepValid=false;
                }else{
                    if(fk_current_entity.value==="0"){
                        $('#wizard').smartWizard('setError',{stepnum:2, iserror:true});
                        $('#wizard').smartWizard('showMessage',"Selecciona la entidad de actual");
                        setTimeout(function (){
                            $(".msgBox").fadeOut();
                        },1000);
                        isStepValid=false;
                    }else{
                        var fk_current_municipality = $('#fk_current_municipality').jqxDropDownList('getSelectedItem');        
                        if(fk_current_municipality.value==="0"){
                            $('#wizard').smartWizard('setError',{stepnum:2, iserror:true});
                            $('#wizard').smartWizard('showMessage',"Selecciona el municipio actual");
                            setTimeout(function (){
                                $(".msgBox").fadeOut();
                            },1000);
                            isStepValid=false;
                        }else{
                            var fk_current_locality = $('#fk_current_locality').jqxDropDownList('getSelectedItem');        
                            if(fk_current_locality.value==="0"){
                                $('#wizard').smartWizard('setError',{stepnum:2, iserror:true});
                                $('#wizard').smartWizard('showMessage',"Selecciona la localidad actual");
                                setTimeout(function (){
                                    $(".msgBox").fadeOut();
                                },1000);
                                isStepValid=false;
                            }else{
                                $('#wizard').smartWizard('setError',{stepnum:2,iserror:false});
                                fk_current_locality= (fk_current_locality.value);
                                if(pk_student!=undefined){
                                    $.ajax({
                                        type: "POST",
                                        async: false,
                                        url: "../serviceCandidate?updateField",
                                        data: {"pkStudent":pk_student,"field_name":"fk_current_locality","field_value": fk_current_locality},
                                        beforeSend: function (xhr) {
                                            $(".loader").fadeIn("slow");
                                        },
                                        error: function (jqXHR, textStatus, errorThrown) {
                                            alert("Error interno del servidor");
                                        },
                                        success: function (data, textStatus, jqXHR) {
                                            $(".loader").fadeOut("slow");
                                        }
                                    });
                                }
                            }
                        }
                    }
                }   
            }else{
                isStepValid = false; 
                $('#wizard').smartWizard('setError',{stepnum:2,iserror:true}); 
            }
        }
        if(step === "3"){
            var fk_born_entity_tutor = $('#fk_born_entity_tutor').jqxDropDownList('getSelectedItem');  
            var fk_born_municipality_tutor = $('#fk_born_municipality_tutor').jqxDropDownList('getSelectedItem');
            var fk_born_locality_tutor = $('#fk_born_locality_tutor').jqxDropDownList('getSelectedItem');  
            var fk_current_entity_tutor = $('#fk_current_entity_tutor').jqxDropDownList('getSelectedItem');  
            var fk_current_municipality_tutor = $('#fk_current_municipality_tutor').jqxDropDownList('getSelectedItem'); 
            var fk_current_locality_tutor = $('#fk_current_locality_tutor').jqxDropDownList('getSelectedItem'); 

            if(fk_born_entity_tutor.value==="0"){
                $('#wizard').smartWizard('setError',{stepnum:3, iserror:true});
                $('#wizard').smartWizard('showMessage',"Selecciona la entidad de nacimiento");
                setTimeout(function (){
                    $(".msgBox").fadeOut();
                },1000);
                isStepValid=false;
            }else{
                if(fk_born_municipality_tutor.value==="0"){
                    $('#wizard').smartWizard('setError',{stepnum:3, iserror:true});
                    $('#wizard').smartWizard('showMessage',"Selecciona el municipio de nacimiento");
                    setTimeout(function (){
                        $(".msgBox").fadeOut();
                    },1000);
                    isStepValid=false;
                }else{    
                    if(fk_born_locality_tutor.value==="0"){
                        $('#wizard').smartWizard('setError',{stepnum:3, iserror:true});
                        $('#wizard').smartWizard('showMessage',"Selecciona la localidad de nacimiento");
                        setTimeout(function (){
                            $(".msgBox").fadeOut();
                        },1000);
                        isStepValid=false;
                    }else{
                        fk_born_locality_tutor = (fk_born_locality_tutor.value);
                        if(pk_student!=undefined){
                            $.ajax({
                                type: "POST",
                                async: false,
                                url: "../serviceCandidate?updateField",
                                data: {"pkStudent":pk_student,"field_name":"fk_born_locality_tutor","field_value": fk_born_locality_tutor},
                                beforeSend: function (xhr) {
                                    $(".loader").fadeIn("slow");
                                },
                                error: function (jqXHR, textStatus, errorThrown) {
                                    alert("Error interno del servidor");
                                },
                                success: function (data, textStatus, jqXHR) {
                                    $(".loader").fadeOut("slow");
                                }
                            });
                        }
                    }
                }
            }

            if(fk_born_locality_tutor.value==="0"){
                $('#wizard').smartWizard('setError',{stepnum:3, iserror:true});
                $('#wizard').smartWizard('showMessage',"Selecciona la localidad de nacimiento");
                setTimeout(function (){
                    $(".msgBox").fadeOut();
                },1000);
                isStepValid=false;
            }else{
                if(fk_current_entity_tutor.value==="0"){
                    $('#wizard').smartWizard('setError',{stepnum:3, iserror:true});
                    $('#wizard').smartWizard('showMessage',"Selecciona la entidad de actual");
                    setTimeout(function (){
                        $(".msgBox").fadeOut();
                    },1000);
                    isStepValid=false;
                }else{
                    if(fk_current_municipality_tutor.value==="0"){
                        $('#wizard').smartWizard('setError',{stepnum:3, iserror:true});
                        $('#wizard').smartWizard('showMessage',"Selecciona el municipio actual");
                        setTimeout(function (){
                            $(".msgBox").fadeOut();
                        },1000);
                        isStepValid=false;
                    }else{   
                        if(fk_current_locality_tutor.value==="0"){
                            $('#wizard').smartWizard('setError',{stepnum:3, iserror:true});
                            $('#wizard').smartWizard('showMessage',"Selecciona la localidad actual");
                            setTimeout(function (){
                                $(".msgBox").fadeOut();
                            },1000);
                            isStepValid=false;
                        }else{
                            fk_current_locality_tutor = (fk_current_locality_tutor.value);
                            if(pk_student!=undefined){
                                $.ajax({
                                    type: "POST",
                                    async: false,
                                    url: "../serviceCandidate?updateField",
                                    data: {"pkStudent":pk_student,"field_name":"fk_current_locality_tutor","field_value": fk_current_locality_tutor},
                                    beforeSend: function (xhr) {
                                        $(".loader").fadeIn("slow");
                                    },
                                    error: function (jqXHR, textStatus, errorThrown) {
                                        alert("Error interno del servidor");
                                    },
                                    success: function (data, textStatus, jqXHR) {
                                        $(".loader").fadeOut("slow");
                                    }
                                });
                            }
                            var fl_tutor_relationship = $('#fl_tutor_relationship').jqxDropDownList('getSelectedItem'); 
                            if(fl_tutor_relationship==null){
                                $('#wizard').smartWizard('setError',{stepnum:3, iserror: true});
                                $('#wizard').smartWizard('showMessage',"Selecciona el parentesco");
                                setTimeout(function (){
                                    $(".msgBox").fadeOut();
                                },1000);
                                isStepValid=false;
                            }else{
                                $('#wizard').smartWizard('setError',{stepnum:3,iserror:false});
                            }
                            var fl_maritial_state_tutor = $('#fl_maritial_state_tutor').jqxDropDownList('getSelectedItem'); 
                            if(fl_maritial_state_tutor==null){
                                $('#wizard').smartWizard('setError',{stepnum:3, iserror: true});
                                $('#wizard').smartWizard('showMessage',"Selecciona el estado civil");
                                setTimeout(function (){
                                    $(".msgBox").fadeOut();
                                },1000);
                                isStepValid=false;
                            }else{
                                $('#wizard').smartWizard('setError',{stepnum:3,iserror:false});
                            }
                            var fl_level_education = $('#fl_level_education').jqxDropDownList('getSelectedItem'); 
                            if(fl_level_education==null){
                                $('#wizard').smartWizard('setError',{stepnum:3, iserror: true});
                                $('#wizard').smartWizard('showMessage',"Selecciona el nivel de educación");
                                setTimeout(function (){
                                    $(".msgBox").fadeOut();
                                },1000);
                                isStepValid=false;
                            }else{
                                $('#wizard').smartWizard('setError',{stepnum:3,iserror:false});
                            }
                        }
                    }
                }
            }
        }
        if(step === "4"){
            var fl_house_status = $('#fl_house_status').jqxDropDownList('getSelectedItem'); 
            if(fl_house_status==null){
                $('#wizard').smartWizard('setError',{stepnum:4, iserror: true});
                $('#wizard').smartWizard('showMessage',"Seleccionar cuenta con casa");
                setTimeout(function (){
                    $(".msgBox").fadeOut();
                },1000);
                isStepValid=false;
            }else{
                $('#wizard').smartWizard('setError',{stepnum:4,iserror:false});
            }
            var fl_wall_material = $('#fl_wall_material').jqxDropDownList('getSelectedItem'); 
            if(fl_wall_material==null){
                $('#wizard').smartWizard('setError',{stepnum:4, iserror: true});
                $('#wizard').smartWizard('showMessage',"Seleccionar el material de las paredes");
                setTimeout(function (){
                    $(".msgBox").fadeOut();
                },1000);
                isStepValid=false;
            }else{
                $('#wizard').smartWizard('setError',{stepnum:4,iserror:false});
            }
            var fl_roof_material = $('#fl_roof_material').jqxDropDownList('getSelectedItem'); 
            if(fl_roof_material==null){
                $('#wizard').smartWizard('setError',{stepnum:4, iserror: true});
                $('#wizard').smartWizard('showMessage',"Seleccionar el material del techo");
                setTimeout(function (){
                    $(".msgBox").fadeOut();
                },1000);
                isStepValid=false;
            }else{
                $('#wizard').smartWizard('setError',{stepnum:4,iserror:false});
            }
            var fl_floor_material = $('#fl_floor_material').jqxDropDownList('getSelectedItem'); 
            if(fl_floor_material==null){
                $('#wizard').smartWizard('setError',{stepnum:4, iserror: true});
                $('#wizard').smartWizard('showMessage',"Seleccionar el material del piso");
                setTimeout(function (){
                    $(".msgBox").fadeOut();
                },1000);
                isStepValid=false;
            }else{
                $('#wizard').smartWizard('setError',{stepnum:4,iserror:false});
            }
        }
        if(step === "5"){
            if(!$("[name=fl_acept_term]").prop("checked")){
                $(".buttonFinish").text("Terminar");
                isStepValid = false;
                $('#wizard').smartWizard('showMessage',"<span id='acept_term_link' style='color: #FB3500;text-decoration: none; cursor: pointer'>Es necesario aceptar los terminos</a>");
                $('#wizard').smartWizard('setError',{stepnum:5,iserror: true});
            }else{
                $(".buttonFinish").text("Salir");
                $('#wizard').smartWizard('hideMessage');
                $('#wizard').smartWizard('setError',{stepnum:5,iserror:false});
            }
        }
        return isStepValid;
    } 
});
</script>
<style type="text/css">
    #form
    {
        height: 100px;
        float: left;
        margin-top: 30px;
        margin-left: 20px;
    }
    .inputContainer
    {
        width: 150px;
    }
    .formInput
    {
        width: 150px;
        outline: none;
    }
    #hintWrapper
    {
        height: 130px;
        float: right;
    }
    #hintSection
    {
        float: left;
        margin-top: 30px;
        margin-right: 20px;
        padding: 5px;
        width: 225px;
    }
    #checkBoxWrapper
    {
        float: left;
        margin-left: 20px;
        margin-top: 30px;
    }
    #section
    {
        margin: 5px;
    }
    #sectionButtonsWrapper
    {
        clear: both;
        width: 180px;
        margin-right: 10px;
        margin-top: 30px;
        float: right;
        bottom: 9px;
        position: absolute;
        right: 10px;
    }
    #hintBasket
    {
        margin-left: 20px;
        margin-top: 7px;
        float: left;
        padding: 5px;
    }
    .basket div
    {
        position: relative;
    }
    .nextButton
    {
        float: right;
        margin-left: 0px;
    }
    .backButton
    {
        float: left;
    }
    #basketButtonsWrapper
    {
        clear: both;
        width: 180px;
        margin-right: 10px;
        margin-top: 30px;
        float: right;
        bottom: 9px;
        position: absolute;
        right: 10px;
    }
    #selectedProductsHeader
    {
        margin-left: 20px;
        float: left;
        width: 200px;
    }
    #selectedProductsButtonsWrapper
    {
        float: right;
        margin-right: 10px;
        width: 115px;
        margin-top: 160px;
    }
    #products
    {
        border: none;
    }
    .StepTitle{
        display: block;
        position: relative;
        border: 1px solid #E0E0E0;
        padding: 5px;
        font: bold 20px Verdana,Arial,Helvetica,sans-serif;
        color: #575757;
        background-color: #80D046;
        clear: both;
        text-align: left;
        z-index: 88;
        text-shadow: none;
        border-color: #779670;
        background-color: #BEF298;
        background-image: linear-gradient(to bottom, #BEF298, #BEF298);
        background-clip: padding-box;
    }
    .form{
        padding-left: 55px;
    }
    label, input, button, select, textarea{
        font-size: 16px;
    }
    .calendarInput{
        display: inline-block !important;
    }
    .disabled-element{
        position:absolute;
        z-index:3200;
        filter:alpha(opacity=65);
        -moz-opacity:65;
        -webkit-opacity:65;
        opacity:0.20;
        background-color:#999;
        left: 0px;
        right: 0px;
        top: 0px;
        bottom: 0px;
        -webkit-border-radius: 9px;
        -moz-border-radius: 9px;
        border-radius: 9px;
    }
</style>
<br>

<div id="medatadaUpdate">
    <div style="padding-left: 15px; width: 925px;">
        <b>Preregistro</b>
        <div style="float: right; margin-right: 5px;">
            <div style="float: right; margin-right: 5px;">
                <span>Folio Sistema</span>
                <input type="text" id="folioSystemVerify" style="width: 140px; height: 26px" class="text-input" />
                <span id="removeFolioSystemVerify" style="cursor: pointer;font-size: 16px;position: relative;right: 20px;top: 2px;">X</span>
            </div>
        </div>
    </div>
    <div style="overflow: hidden; position: relative;">
        <div id='jqxWisard'>
            <ul>
                <li style="margin-left: 30px;">Datos personales</li>
                <li>Datos de ubicación</li>
                <li>Datos del padre o tutor</li>
                <li>Situación</li>
                <li>Difusión</li>
            </ul>
            <div class="section">
                <div id="form1" class="form">
                    <fieldset>
                        <h2 class="StepTitle">Datos personales</h2> 
                        <div class="div-row1 input-prepend">
                            <label class="label-row" for="fl_name">Nombre</label><br>
                            <span class="add-on"><i class="icon-text-width"></i></span>  
                            <input data-type-role="text" id="fl_name" data-field="true"  name="fl_name" placeholder="Nombre" style="width: 260px"/>
                        </div>
                        <div class="div-row2 input-prepend">
                            <label class="label-row" for="fl_patern_name">Apellido paterno</label><br>
                            <span class="add-on"><i class="icon-text-width"></i></span>  
                            <input data-type-role="text" id="fl_patern_name" data-field="true"  name="fl_patern_name" placeholder="Apellido paterno" style="width: 160px"/>
                        </div>
                        <div class="div-row1 input-prepend">
                            <label class="label-row" for="fl_matern_name">Apellido materno</label><br>
                            <span class="add-on"><i class="icon-text-width"></i></span>  
                            <input data-type-role="text" id="fl_matern_name" data-field="true"  name="fl_matern_name" placeholder="Apellido materno" style="width: 160px"/>
                        </div>
                        <div class="div-row1 input-prepend">
                            <label class="label-row" for="fl_date_born">Fecha de nacimiento</label><br>
                            <span class="add-on"><i class="icon-calendar"></i></span>  
                            <div data-type-role="text" class="calendarInput" data-field="true"  name="fl_date_born"  id="fl_date_born"></div>
                            <br><span>AAAA-MM-DD</span>
                        </div>                            
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fl_gender">Sexo</label><br>
                            <label style="font-size: 16px; line-height: 32px;"><input data-type-role="radio" type="radio" value="Hombre"  data-field="true"  name="fl_gender"/> Hombre</label><br>
                            <label style="font-size: 16px; line-height: 32px;"><input data-type-role="radio" type="radio" value="Mujer" data-field="true"  name="fl_gender"/> Mujer</label>
                        </div>
                        <div class="div-row2 input-prepend">
                            <label class="label-row" for="fl_maritial_status">Estado civil</label><br>
                            <span class="add-on"><i class="icon-adjust"></i></span>  
                            <div data-type-role="combo" data-field="true" name="fl_maritial_status" id="fl_maritial_status"></div>
                        </div>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fl_working">Se encuentra trabajando</label><br>
                            <label style="font-size: 16px; line-height: 32px;"><input data-type-role="radio" type="radio" data-field="true" value="Si"  name="fl_working"/> Si</label><br>
                            <label style="font-size: 16px; line-height: 32px;"><input data-type-role="radio" type="radio" data-field="true" value="No"  name="fl_working"/> No</label>
                        </div>

<!--                        <div class="div-row input-prepend">
                            <label class="label-row" for="fl_file_id_oficial">Seleccionar identificación oficial</label><br>
                            <span class="add-on"><i class="icon-file"></i></span>
                            <div data-file="true" id="fl_file_id_oficial" data-type-role="file" name="fl_file_id_oficial"></div>
                            <br>
                            <span><a target="_blank" href="../serviceFile?viewFile=file_id_oficial">Ver</a></span>
                        </div>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fl_file_document_born">Seleccionar acta de nacimiento</label><br>
                            <span class="add-on"><i class="icon-file"></i></span> 
                            <div data-file="true" id="fl_file_document_born" data-type-role="file" name="fl_file_document_born"></div>
                            <br>
                            <span><a target="_blank" href="../serviceFile?viewFile=file_document_born">Ver</a></span>
                        </div>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fl_file_curp">Seleccionar CURP</label><br>
                            <span class="add-on"><i class="icon-file"></i></span> 
                            <div data-file="true" id="fl_file_curp" data-type-role="file" name="fl_file_curp"></div>
                            <br>
                            <span><a target="_blank" href="../serviceFile?viewFile=file_curp">Ver</a></span>
                        </div>  -->
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fl_curp">CURP</label><br>
                            <span class="add-on"><i class="icon-text-width"></i></span>  
                            <input data-type-role="text" data-field="true"  id="fl_curp" name="fl_curp" placeholder="CURP" style="width: 185px"/>
                        </div>
                    </fieldset>
                    <fieldset>
                        <h2 class="StepTitle">Datos de la preparatoria de procedencia</h2> 
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fk_entity">Entidad</label><br>
                            <span class="add-on"><i class="icon-book"></i></span>  
                            <div data-type-role="combo" data-field="true" name="fk_entity"  id="fk_entity"></div>
                        </div>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fk_municipality">Municipio</label><br>
                            <span class="add-on"><i class="icon-book"></i></span>  
                            <div data-type-role="combo" data-field="true" name="fk_municipality"  id="fk_municipality"></div>
                        </div>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fk_locality">Localidad</label><br>
                            <span class="add-on"><i class="icon-book"></i></span>  
                            <div data-type-role="combo" data-field="true" name="fk_locality"  id="fk_locality"></div>
                        </div>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fk_preparatory">Preparatoria de procedencia</label><br>
                            <span class="add-on"><i class="icon-book"></i></span>  
                            <div data-type-role="combo" data-field="true" name="fk_preparatory"  id="fk_preparatory"></div>
                        </div>
                        <div class="div-row2 input-prepend">
                            <label class="label-row" for="fl_bacherol_type">Tipo de bachillerato</label><br>
                            <span class="add-on"><i class="icon-book"></i></span>  
                            <div data-type-role="combo" data-field="true" name="fl_bacherol_type"  id="fl_bacherol_type"></div>
                        </div>
                        <div class="div-row2 input-prepend">
                            <label class="label-row" for="fl_school_type">Tipo de escuela</label><br>
                            <span class="add-on"><i class="icon-book"></i></span>  
                            <div data-type-role="combo" data-field="true" name="fl_school_type"  id="fl_school_type"></div>
                        </div>
                        <div class="div-row2 input-prepend">
                            <label class="label-row" for="fl_above_average">Promedio anterior</label><br>
                            <span class="add-on"><i class="icon-question-sign"></i></span>  
                            <div data-type-role="text" data-field="true" name="fl_above_average"  id="fl_above_average"></div>
                        </div>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fl_period_bacherol">Periodo en el que realizo el bachillerato</label><br>
                            <span class="add-on"><i class="icon-calendar"></i></span>  
                            <input data-type-role="text" data-field="true" name="fl_period_bacherol"  id="fl_period_bacherol" style="height: 26px"/><br>
                            <span style="margin-left: 20px; color: rgb(141, 141, 141)">(Año inicio)-(Año final)</span>
                        </div>
                    </fieldset>
                </div> 
                <div id="sectionButtonsWrapper">
                    <input type="button" value="Atras" class="backButton disabled"/>
                    <input type="button" value="Siguiente" class="nextButton"/>
                </div>
            </div>
            <div class="section">
                <div id="form2" class="form">
                    <fieldset>
                        <h2 class="StepTitle">Registra tus datos de nacimiento</h2>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fk_born_entity">Entidad</label><br>
                            <span class="add-on"><i class="icon-book"></i></span>  
                            <div data-type-role="combo" data-field="true" name="fk_born_entity"  id="fk_born_entity"></div>
                        </div>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fk_born_municipality">Municipio</label><br>
                            <span class="add-on"><i class="icon-list"></i></span>  
                            <div data-type-role="combo" data-field="true" name="fk_born_municipality"  id="fk_born_municipality"></div>
                        </div>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fk_born_locality">Localidad</label><br>
                            <span class="add-on"><i class="icon-list"></i></span>  
                            <div data-type-role="combo" data-field="true" name="fk_born_locality"  id="fk_born_locality"></div>
                        </div>
                    </fieldset>
                    <fieldset>
                        <h2 class="StepTitle">Registra tus datos donde vives en la actualidad</h2>	
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fk_current_entity">Entidad</label><br>
                            <span class="add-on"><i class="icon-list"></i></span>  
                            <div data-type-role="combo" data-field="true" name="fk_current_entity"  id="fk_current_entity"></div>
                        </div>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fk_current_municipality">Municipio</label><br>
                            <span class="add-on"><i class="icon-home"></i></span>  
                            <div data-type-role="combo" data-field="true" name="fk_current_municipality"  id="fk_current_municipality"></div>
                        </div>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fk_current_locality">Localidad</label><br>
                            <span class="add-on"><i class="icon-home"></i></span>  
                            <div data-type-role="combo" data-field="true" name="fk_current_locality"  id="fk_current_locality"></div>
                        </div>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fl_current_colony">Colonia</label><br>
                            <span class="add-on"><i class="icon-home"></i></span>  
                            <input data-type-role="text" data-field="true"  id="fl_current_colony" name="fl_current_colony" placeholder="Colonia..." style="width: 360px"/>
                        </div>
                        <div class="div-row1 input-prepend">
                            <label class="label-row" for="fl_name_street">Calle</label><br>
                            <span class="add-on"><i class="icon-road"></i></span>  
                            <input  data-type-role="text" data-field="true"  id="fl_name_street" name="fl_name_street" placeholder="Calle donde vive..." style="width: 240px"/>
                        </div>
                        <div class="div-row2 input-prepend">
                            <label class="label-row" for="fl_external_number">Número exterior</label><br>
                            <span class="add-on"><i class="icon-star"></i></span>  
                            <input data-type-role="text" data-field="true"  id="fl_external_number" name="fl_external_number" placeholder="No." style="width: 40px"/>
                        </div>
                        <div class="div-row2 input-prepend">
                            <label class="label-row" for="fl_internal_number">Número interior</label><br>
                            <span class="add-on"><i class="icon-star"></i></span>  
                            <input data-type-role="text" data-field="true"  id="fl_internal_number" name="fl_internal_number" placeholder="No." style="width: 40px"/>
                        </div>
                        <div class="div-row1 input-prepend">
                            <label class="label-row" for="fl_between_street1">Entre calle</label><br>
                            <span class="add-on"><i class="icon-road"></i></span>  
                            <input  data-type-role="text" data-field="true"  id="fl_between_street1" name="fl_between_street1" placeholder="Entre calle..." style="width: 260px"/>
                        </div>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fl_between_street2">Y calle</label><br>
                            <span class="add-on"><i class="icon-road"></i></span>  
                            <input  data-type-role="text" data-field="true"  id="fl_between_street2" name="fl_between_street2" placeholder="Y calle..." style="width: 360px"/>
                        </div>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fl_reference">Alguna referencia cerca</label><br>
                            <span class="add-on"><i class="icon-eye-open"></i></span>  
                            <input  data-type-role="text" data-field="true"  id="fl_reference" name="fl_reference" placeholder="Alguna referencia cerca..." style="width: 460px"/>
                        </div>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fl_zip_code">Código postal</label><br>
                            <span class="add-on"><i class="icon-lock"></i></span>  
                            <div data-type-role="text" data-field="true"  class="zip-codeInput" id="fl_zip_code" name="fl_zip_code"></div>
                        </div>
                        <div class="div-row2 input-prepend">
                            <label class="label-row" for="fl_phone_home">Teléfono de casa</label><br>
                            <span class="add-on"><i class="icon-tag"></i></span>  
                            <div data-type-role="text" data-field="true"  class="telephoneInput" id="fl_phone_home" name="fl_phone_home"></div>
                        </div>
                        <div class="div-row2 input-prepend">
                            <label class="label-row" for="fl_cell_phone">Celular</label><br>
                            <span class="add-on"><i class="icon-tag"></i></span>  
                            <div data-type-role="text" data-field="true"  class="telephoneInput" id="fl_cell_phone" name="fl_cell_phone"></div>
                        </div>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fl_mail">Correo electrónico</label><br>
                            <span class="add-on"><i class="icon-envelope"></i></span>  
                            <input data-type-role="text" data-field="true"  id="fl_mail" name="fl_mail" placeholder="Correo electrónico..." style="width: 300px"/>
                        </div>
                        <div class="div-row1 input-prepend">
                            <label class="label-row" for="fl_facebook">Link de Facebook opcional</label><br>
                            <span class="add-on"><i class="icon-thumbs-up"></i></span>  
                            <input data-type-role="text" data-field="true"  id="fl_facebook" name="fl_facebook" placeholder="Link de facebook..." style="width: 260px"/>
                        </div>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fl_twitter">Link de Twitter opcional</label><br>
                            <span class="add-on"><i class="icon-thumbs-up"></i></span>  
                            <input data-type-role="text" data-field="true"  id="fl_twitter" name="fl_twitter" placeholder="Link de twitter..." style="width: 360px"/>
                        </div>
                    </fieldset>
                </div> 
                <div id="basketButtonsWrapper">
                    <input type="button" value="Atras" class="backButton"/>
                    <input type="button" value="Siguiente" class="nextButton"/>
                </div>
            </div>
            <div class="section">
                <div id="form3" class="form">
                    <fieldset>
                        <h2 class="StepTitle">Registra los datos de nacimiento del padre o tutor</h2>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fk_born_entity_tutor">Entidad</label><br>
                            <span class="add-on"><i class="icon-book"></i></span>  
                            <div data-type-role="combo" data-field="true" name="fk_born_entity_tutor"  id="fk_born_entity_tutor"></div>
                        </div>                                        
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fk_born_municipality_tutor">Municipio</label><br>
                            <span class="add-on"><i class="icon-list"></i></span>  
                            <div data-type-role="combo" data-field="true" name="fk_born_municipality_tutor"  id="fk_born_municipality_tutor"></div>
                        </div>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fk_born_locality_tutor">Localidad</label><br>
                            <span class="add-on"><i class="icon-list"></i></span>  
                            <div data-type-role="combo" data-field="true" name="fk_born_locality_tutor"  id="fk_born_locality_tutor"></div>
                        </div>
                    </fieldset>
                    <fieldset>
                        <h2 class="StepTitle">Registra los datos del padre o tutor donde vive en la actualidad</h2>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fk_current_entity_tutor">Entidad</label><br>
                            <span class="add-on"><i class="icon-list"></i></span>  
                            <div data-type-role="combo" data-field="true" name="fk_current_entity_tutor"  id="fk_current_entity_tutor"></div>
                        </div>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fk_current_municipality_tutor">Municipio</label><br>
                            <span class="add-on"><i class="icon-home"></i></span>  
                            <div data-type-role="combo" data-field="true" name="fk_current_municipality_tutor"  id="fk_current_municipality_tutor"></div>
                        </div>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fk_current_locality_tutor">Localidad</label><br>
                            <span class="add-on"><i class="icon-home"></i></span>  
                            <div data-type-role="combo" data-field="true" name="fk_current_locality_tutor"  id="fk_current_locality_tutor"></div>
                        </div>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fl_colony_tutor">Colonia</label><br>
                            <span class="add-on"><i class="icon-home"></i></span>  
                            <input data-type-role="text" data-field="true" id="fl_colony_tutor" name="fl_colony_tutor" placeholder="Colonia..." style="width: 360px"/>
                        </div>
                        <div class="div-row1 input-prepend">
                            <label class="label-row" for="fl_street_name_tutor">Calle donde vive</label><br>
                            <span class="add-on"><i class="icon-road"></i></span>  
                            <input data-type-role="text" data-field="true"  id="fl_street_name_tutor" name="fl_street_name_tutor" placeholder="Calle donde vive..." style="width: 240px"/>
                        </div>
                        <div class="div-row2 input-prepend">
                            <label class="label-row" for="fl_external_number_tutor">Número exterior</label><br>
                            <span class="add-on"><i class="icon-star"></i></span>  
                            <input data-type-role="text" data-field="true"  id="fl_external_number_tutor" name="fl_external_number_tutor" placeholder="No." style="width: 40px"/>
                        </div>
                        <div class="div-row2 input-prepend">
                            <label class="label-row" for="fl_internal_number_tutor">Número interior</label><br>
                            <span class="add-on"><i class="icon-star"></i></span>  
                            <input data-type-role="text" data-field="true"  id="fl_internal_number_tutor" name="fl_internal_number_tutor" placeholder="No." style="width: 40px"/>
                        </div>
                        <div class="div-row1 input-prepend">
                            <label class="label-row" for="fl_between_street1_tutor">Entre calle</label><br>
                            <span class="add-on"><i class="icon-road"></i></span>  
                            <input data-type-role="text" data-field="true"  id="fl_between_street1_tutor" name="fl_between_street1_tutor" placeholder="Entre calle..." style="width: 260px"/>
                        </div>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fl_between_street2_tutor">Y calle</label><br>
                            <span class="add-on"><i class="icon-road"></i></span>  
                            <input data-type-role="text" data-field="true"  id="fl_between_street2_tutor" name="fl_between_street2_tutor" placeholder="Y calle..." style="width: 360px"/>
                        </div>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fl_reference_tutor">Alguna referencia cerca</label><br>
                            <span class="add-on"><i class="icon-eye-open"></i></span>  
                            <input data-type-role="text" data-field="true"  id="fl_reference_tutor" name="fl_reference_tutor" placeholder="Alguna referencia cerca..." style="width: 460px"/>
                        </div>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fl_zip_code_tutor">Código postal</label><br>
                            <span class="add-on"><i class="icon-lock"></i></span>  
                            <div data-type-role="text" data-field="true" class="zip-codeInput" name="fl_zip_code_tutor" id="fl_zip_code_tutor"></div>
                        </div>
                        <div class="div-row2 input-prepend">
                            <label class="label-row" for="fl_phone_home_tutor">Teléfono de casa</label><br>
                            <span class="add-on"><i class="icon-tag"></i></span>  
                            <div data-type-role="text" data-field="true" class="telephoneInput" name="fl_phone_home_tutor" id="fl_phone_home_tutor"></div>
                        </div>
                        <div class="div-row2 input-prepend">
                            <label class="label-row" for="fl_cell_phone_tutor">Celular</label><br>
                            <span class="add-on"><i class="icon-tag"></i></span>  
                            <div data-type-role="text" data-field="true" class="telephoneInput" name="fl_cell_phone_tutor" id="fl_cell_phone_tutor"></div>
                        </div>
                        <div class="div-row1 input-prepend">
                            <label class="label-row" for="fl_emergency_phone1">Teléfono de emergencia 1</label><br>
                            <span class="add-on"><i class="icon-tag"></i></span>  
                            <div data-type-role="text" data-field="true" class="telephoneInput" name="fl_emergency_phone1" id="fl_emergency_phone1"></div>
                        </div>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fl_emergency_phone2">Teléfono de emergencia 2</label><br>
                            <span class="add-on"><i class="icon-tag"></i></span>  
                            <div data-type-role="text" data-field="true" class="telephoneInput" name="fl_emergency_phone2" id="fl_emergency_phone2"></div>
                        </div>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fl_mail_tutor">Correo electrónico</label><br>
                            <span class="add-on"><i class="icon-envelope"></i></span>  
                            <input data-type-role="text" data-field="true" id="fl_mail_tutor" name="fl_mail_tutor" placeholder="Correo electrónico..." style="width: 300px"/>
                        </div>
                        <div class="div-row1 input-prepend">
                            <label class="label-row" for="fl_facebook_tutor">Link de Facebook opcional</label><br>
                            <span class="add-on"><i class="icon-thumbs-up"></i></span>  
                            <input data-type-role="text" data-field="true" id="fl_facebook_tutor" name="fl_facebook_tutor" placeholder="Link de facebook..." style="width: 260px"/>
                        </div>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fl_twitter_tutor">Link de Twitter opcional</label><br>
                            <span class="add-on"><i class="icon-thumbs-up"></i></span>  
                            <input data-type-role="text" data-field="true" id="fl_twitter_tutor" name="fl_twitter_tutor" placeholder="Link de twitter..." style="width: 360px"/>
                        </div>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fl_tutor_relationship">Parentesco con el tutor</label><br>
                            <span class="add-on"><i class="icon-list"></i></span>  
                            <div data-type-role="combo" data-field="true" name="fl_tutor_relationship"  id="fl_tutor_relationship"></div>
                        </div>
                        <div class="div-row1 input-prepend">
                            <label class="label-row" for="fl_name_tutor">Nombre del padre o tutor</label><br>
                            <span class="add-on"><i class="icon-text-width"></i></span>  
                            <input data-type-role="text" data-field="true" id="fl_name_tutor" name="fl_name_tutor" placeholder="Nombre..." style="width: 240px"/>
                        </div>
                        <div class="div-row1 input-prepend">
                            <label class="label-row" for="fl_patern_name_tutor">Apellido paterno</label><br>
                            <span class="add-on"><i class="icon-text-width"></i></span>  
                            <input data-type-role="text" data-field="true" id="fl_patern_name_tutor" name="fl_patern_name_tutor" placeholder="Apellido paterno..." style="width: 240px"/>
                        </div>
                        <div class="div-row1 input-prepend">
                            <label class="label-row" for="fl_matern_name_tutor">Apellido materno</label><br>
                            <span class="add-on"><i class="icon-text-width"></i></span>  
                            <input data-type-role="text" data-field="true" id="fl_matern_name_tutor" name="fl_matern_name_tutor" placeholder="Apellido materno..." style="width: 240px"/>
                        </div>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fl_born_date_tutor">Fecha de nacimiento</label><br>
                            <span class="add-on"><i class="icon-calendar"></i></span>  
                            <div data-type-role="text" class="calendarInput" data-field="true"  name="fl_born_date_tutor"  id="fl_born_date_tutor"></div>
                            <br><span>AAAA-MM-DD</span>
                        </div> 
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fl_gender_tutor">Sexo</label><br>
                            <label style="font-size: 16px; line-height: 32px;"><input data-type-role="radio" type="radio" value="Hombre"  data-field="true"  name="fl_gender_tutor"/> Hombre</label><br>
                            <label style="font-size: 16px; line-height: 32px;"><input data-type-role="radio" type="radio" value="Mujer" data-field="true"  name="fl_gender_tutor"/> Mujer</label>
                        </div>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fl_maritial_state_tutor">Estado civil</label><br>
                            <span class="add-on"><i class="icon-list"></i></span>  
                            <div data-type-role="combo" data-field="true" name="fl_maritial_state_tutor" id="fl_maritial_state_tutor"></div>
                        </div>
                        <div class="div-row1 input-prepend">
                            <label class="label-row" for="fl_level_education">Nivel de educación</label><br>
                            <span class="add-on"><i class="icon-list"></i></span>  
                            <div data-type-role="combo" data-field="true" name="fl_level_education" id="fl_level_education"></div>
                        </div>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fl_occupation_tutor">Ocupación</label><br>
                            <span class="add-on"><i class="icon-list"></i></span>   
                            <input data-type-role="text" data-field="true" name="fl_occupation_tutor" placeholder="Ocupación..." style="width: 285px"/>
                        </div>
<!--                        <div class="div-row input-prepend">
                            <label class="label-row" for="fl_file_id_oficial_tutor">Seleccionar identificación oficial del tutor</label><br>
                            <span class="add-on"><i class="icon-file"></i></span>
                            <div data-file="true" id="fl_file_id_oficial_tutor" data-type-role="file" name="fl_file_id_oficial_tutor"></div>
                            <br>
                            <span><a target="_blank" href="../serviceFile?viewFile=file_id_oficial_tutor">Ver</a></span>
                        </div>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fl_file_curp_tutor">Seleccionar CURP</label><br>
                            <span class="add-on"><i class="icon-file"></i></span> 
                            <div data-file="true" id="fl_file_curp_tutor" data-type-role="file" name="fl_file_curp_tutor"></div>
                            <br>
                            <span><a target="_blank" href="../serviceFile?viewFile=file_curp_tutor">Ver</a></span>
                        </div>-->
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fl_curp_tutor">CURP</label><br>
                            <span class="add-on"><i class="icon-text-width"></i></span>  
                            <input data-type-role="text" data-field="true"  id="fl_curp_tutor" name="fl_curp_tutor" placeholder="CURP" style="width: 185px"/>
                        </div>
                    </fieldset>
                </div> 
                <div id="basketButtonsWrapper">
                    <input type="button" value="Atras" class="backButton"/>
                    <input type="button" value="Siguiente" class="nextButton"/>
                </div>
            </div>
            <div class="section">
                <div id="form4" class="form">
                    <fieldset>
                        <h2 class="StepTitle">Situación económica familiar del estudiante</h2>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fl_house_status">¿Actualmente cuenta con casa...?</label><br>
                            <span class="add-on"><i class="icon-list"></i></span>  
                            <div data-type-role="combo" data-field="true" name="fl_house_status" id="fl_house_status"></div>
                        </div>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fl_wall_material">¿Cuál es el material con el que están hechas las paredes?</label><br>
                            <span class="add-on"><i class="icon-list"></i></span>  
                            <div data-type-role="combo" data-field="true" name="fl_wall_material" id="fl_wall_material"></div>
                        </div>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fl_roof_material">¿De qué material está construido el techo?</label><br>
                            <span class="add-on"><i class="icon-list"></i></span>  
                            <div data-type-role="combo" data-field="true" name="fl_roof_material" id="fl_roof_material"></div>
                        </div>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fl_floor_material">¿Tipo de material es el piso?</label><br>
                            <span class="add-on"><i class="icon-list"></i></span>
                            <div data-type-role="combo" data-field="true" name="fl_floor_material" id="fl_floor_material"></div>
                        </div>
                        <div class="div-row input-prepend" style="min-height: 0px; margin-bottom: 15px;">
                            <label class="label-row">¿La vivienda donde vive cuenta con...?</label>
                        </div>
                        <div class="div-row input-prepend" style="min-height: 0px; margin-bottom: 0px;">
                            <input data-type-role="checkbox" data-field="true" type="checkbox" value="Si" name="fl_room" id="fl_room"/>   
                            <label class="checkbox-inline label-row" for="fl_room" style="margin-left: 10px; display: inline;">Sala</label>
                        </div>
                        <div class="div-row input-prepend" style="min-height: 0px; margin-bottom: 0px;">
                            <input data-type-role="checkbox" data-field="true" type="checkbox" value="Si" name="fl_dining_room" id="fl_dining_room"/>    
                            <label class="checkbox-inline label-row" for="fl_dining_room" style="margin-left: 10px; display: inline;">Comedor</label>
                        </div>
                        <div class="div-row input-prepend" style="min-height: 0px; margin-bottom: 0px;">
                            <input data-type-role="checkbox" data-field="true" type="checkbox" value="Si" name="fl_kitchen" id="fl_kitchen"/>    
                            <label class="checkbox-inline label-row" for="fl_kitchen" style="margin-left: 10px; display: inline;">Cocina</label>
                        </div>
                        <div class="div-row input-prepend" style="min-height: 0px; margin-bottom: 0px;">
                            <input data-type-role="checkbox" data-field="true" type="checkbox" value="Si" name="fl_toilet" id="fl_toilet"/>
                            <label class="checkbox-inline label-row" for="fl_toilet" style="margin-left: 10px; display: inline;">Baño</label><br>                                     
                        </div>
                        <div class="div-row input-prepend" style="min-height: 0px; margin-bottom: 15px;">
                            <label class="label-row" for="total_rooms">Seleccione con cuales de los siguientes aparatos electrodomésticos cuenta en casa</label><br>
                        </div>
                        <div class="div-row input-prepend" style="min-height: 0px; margin-bottom: 0px;">
                            <input data-type-role="checkbox" data-field="true" type="checkbox" value="Si" name="fl_television" id="fl_television"/>   
                            <label class="checkbox-inline label-row" for="fl_television" style="margin-left: 10px; display: inline;">Televisión</label>
                        </div>
                        <div class="div-row input-prepend" style="min-height: 0px; margin-bottom: 0px;">
                            <input data-type-role="checkbox" data-field="true" type="checkbox" value="Si" name="fl_stereo" id="fl_stereo"/>   
                            <label class="checkbox-inline label-row" for="fl_stereo" style="margin-left: 10px; display: inline;">Sonido estéreo</label>
                        </div>
                        <div class="div-row input-prepend" style="min-height: 0px; margin-bottom: 0px;">
                            <input data-type-role="checkbox" data-field="true" type="checkbox" value="Si" name="fl_dvd" id="fl_dvd"/>   
                            <label class="checkbox-inline label-row" for="fl_dvd" style="margin-left: 10px; display: inline;">Video (dvd)</label>
                        </div>
                        <div class="div-row input-prepend" style="min-height: 0px; margin-bottom: 0px;">
                            <input data-type-role="checkbox" data-field="true" type="checkbox" value="Si" name="fl_computer" id="fl_computer"/>   
                            <label class="checkbox-inline label-row" for="fl_computer" style="margin-left: 10px; display: inline;">Computadora</label>
                        </div>
                        <div class="div-row input-prepend" style="min-height: 0px; margin-bottom: 0px;">
                            <input data-type-role="checkbox" data-field="true" type="checkbox" value="Si" name="fl_laptop" id="fl_laptop"/>   
                            <label class="checkbox-inline label-row" for="fl_laptop" style="margin-left: 10px; display: inline;">Laptop</label>
                        </div>
                        <div class="div-row input-prepend" style="min-height: 0px; margin-bottom: 15px;">
                            <label class="label-row" for="total_rooms">Seleccione con cuales de los siguientes aparatos de línea blanca cuenta en casa</label><br>
                        </div>
                        <div class="div-row input-prepend" style="min-height: 0px; margin-bottom: 0px;">
                            <input data-type-role="checkbox" data-field="true" type="checkbox" value="Si" name="fl_refrigerator" id="fl_refrigerator"/>   
                            <label class="checkbox-inline label-row" for="fl_refrigerator" style="margin-left: 10px; display: inline;">Refrigerador</label>
                        </div>
                        <div class="div-row input-prepend" style="min-height: 0px; margin-bottom: 0px;">
                            <input data-type-role="checkbox" data-field="true" type="checkbox" value="Si" name="fl_washer" id="fl_washer"/>   
                            <label class="checkbox-inline label-row" for="fl_washer" style="margin-left: 10px; display: inline;">Lavadora</label>
                        </div>
                        <div class="div-row input-prepend" style="min-height: 0px; margin-bottom: 0px;">
                            <input data-type-role="checkbox" data-field="true" type="checkbox" value="Si" name="fl_stove" id="fl_stove"/>   
                            <label class="checkbox-inline label-row" for="fl_stove" style="margin-left: 10px; display: inline;">Estufa</label>
                        </div>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fl_number_members_famly">¿Cuántos miembros son el la familia que actualmente están en casa?</label><br>
                            <span class="add-on"><i class="icon-question-sign"></i></span>  
                            <div data-type-role="text" data-field="true" name="fl_number_members_famly"  id="fl_number_members_famly"></div>
                        </div>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fl_family_monthly_income">Calcule aproximadamente el ingreso mensual familiar</label><br>
                            <span class="add-on"><i class="icon-question-sign"></i></span>  
                            <div data-type-role="text" data-field="true" class="numberInputMoney" name="fl_family_monthly_income" id="fl_family_monthly_income"></div>
                        </div>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fl_family_monthly_discharge">Calcule aproximadamente el egreso mensual familiar</label><br>
                            <span class="add-on"><i class="icon-question-sign"></i></span>  
                            <div data-type-role="text" data-field="true" class="numberInputMoney" name="fl_family_monthly_discharge" id="fl_family_monthly_discharge"></div>
                        </div>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fl_student_montgly_income">¿Cuánto es el total de tu ingreso mensual "que te aportan tus papás o tutor" incluyendo tu salario si es que trabajas?</label><br>
                            <span class="add-on"><i class="icon-question-sign"></i></span>  
                            <div data-type-role="text" data-field="true" class="numberInputMoney" name="fl_student_montgly_income" id="fl_student_montgly_income"></div>
                        </div>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fl_student_montgly_discharge">¿Cuál es tu egreso mensual?</label><br>
                            <span class="add-on"><i class="icon-question-sign"></i></span>  
                            <div data-type-role="text" data-field="true" class="numberInputMoney" name="fl_student_montgly_discharge" id="fl_student_montgly_discharge"></div>
                        </div>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fl_physical_disability">Presenta alguna discapacidad</label><br>
                            <label style="font-size: 16px; line-height: 32px;"><input data-type-role="radio" type="radio" data-field="true" value="Si" name="fl_physical_disability"/> Si</label><br>
                            <label style="font-size: 16px; line-height: 32px;"><input data-type-role="radio" type="radio" data-field="true" value="No" name="fl_physical_disability"/> No</label>    
                        </div>
                        <div class="div-row input-prepend" id="disability_name_div">
                            <label class="label-row" for="fl_disability_name">¿Cuál?</label><br>
                            <span class="add-on"><i class=" icon-eye-close"></i></span>  
                            <input data-type-role="text" id="fl_disability_name" data-field="true" name="fl_disability_name" placeholder="Cuál..." style="width: 160px"/>
                        </div>
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fl_indigenous_group">Pertenece a un grupo indígena</label><br>
                            <label style="font-size: 16px; line-height: 32px;"><input data-type-role="radio" type="radio" data-field="true" value="Si" name="fl_indigenous_group"/> Si</label><br>
                            <label style="font-size: 16px; line-height: 32px;"><input data-type-role="radio" type="radio" data-field="true" value="No" name="fl_indigenous_group"/> No</label>
                        </div>
                        <div class="div-row input-prepend" id="indigenous_group_name_div">
                            <label class="label-row" for="fl_indigenous_group_name">¿Cuál?</label><br>
                            <span class="add-on"><i class="icon-question-sign"></i></span>  
                            <input data-type-role="text" id="fl_indigenous_group_name" data-field="true" name="fl_indigenous_group_name" placeholder="Cuál..." style="width: 160px"/>
                        </div>

                        <div class="div-row input-prepend">
                            <label class="label-row" for="fl_secutity_medical">¿Cuenta con seguro médico o de salud?</label><br>
                            <label style="font-size: 16px; line-height: 32px;"><input type="radio" data-type-role="radio" data-field="true" value="Si" name="fl_secutity_medical"/> Si</label><br>
                            <label style="font-size: 16px; line-height: 32px;"><input type="radio" data-type-role="radio" data-field="true" value="No" name="fl_secutity_medical"/> No</label>
                        </div>
                        <div id="fl_number_security_medical_div" style="display: none">
                            <div class="div-row input-prepend">
                                <label class="label-row" for="fl_security_name">¿Cuál?</label><br>
                                <span class="add-on"><i class="icon-text-width"></i></span>      
                                <input data-type-role="text" data-field="true" name="fl_security_name" placeholder="Nombre..." style="width: 285px"/>
                            </div>
                            <div class="div-row input-prepend">
                                <label class="label-row" for="fl_number_security_medical">Número de su seguro médico</label><br>
                                <span class="add-on"><i class="icon-text-width"></i></span>  
                                <input data-type-role="text" data-field="true" name="fl_number_security_medical" placeholder="No."/>
                            </div>
                        </div>
                    </fieldset>
                </div>
                <div id="basketButtonsWrapper">
                    <input type="button" value="Atras" class="backButton" />
                    <input type="button" value="Siguiente" class="nextButton"/>
                </div>
            </div>
            <div class="section">
                <div id="form5" class="form">
                    <h2 class="StepTitle">Difusión</h2><br>
                    <div class="div-row input-prepend" style="min-height: 0px; margin-bottom: 15px;">
                        <label class="label-row" for="total_rooms">Seleccione el medio de difusión por el cual se enteró de la comunidad de estudios en la UTsem.</label><br>
                    </div>
                    <div class="div-row input-prepend" style="min-height: 0px; margin-bottom: 0px;">
                        <input data-type-role="checkbox" disabled="" data-field="true" type="checkbox" value="Si" name="fl_diffusion_call" id="fl_diffusion_call"/>   
                        <label class="checkbox-inline label-row" for="fl_diffusion_call" style="margin-left: 10px; display: inline;">Convocatoria</label>
                    </div>
                    <div class="div-row input-prepend" style="min-height: 0px; margin-bottom: 0px;">
                        <input data-type-role="checkbox" disabled="" data-field="true" type="checkbox" value="Si" name="fl_diffusion_cartel" id="fl_diffusion_cartel"/>   
                        <label class="checkbox-inline label-row" for="fl_diffusion_cartel" style="margin-left: 10px; display: inline;">Cartel</label>
                    </div>
                    <div class="div-row input-prepend" style="min-height: 0px; margin-bottom: 0px;">
                        <input data-type-role="checkbox" disabled="" data-field="true" type="checkbox" value="Si" name="fl_diffusion_plantel_talks" id="fl_diffusion_plantel_talks"/>   
                        <label class="checkbox-inline label-row" for="fl_diffusion_plantel_talks" style="margin-left: 10px; display: inline;">Pláticas en el pantel</label>
                    </div>
                    <div class="div-row input-prepend" style="min-height: 0px; margin-bottom: 0px;">
                        <input data-type-role="checkbox" disabled="" data-field="true" type="checkbox" value="Si" name="fl_diffusion_personal_ut" id="fl_diffusion_personal_ut"/>   
                        <label class="checkbox-inline label-row" for="fl_diffusion_personal_ut" style="margin-left: 10px; display: inline;">Personal del UT</label>
                    </div>
                    <div class="div-row input-prepend" style="min-height: 0px; margin-bottom: 0px;">
                        <input data-type-role="checkbox" disabled="" data-field="true" type="checkbox" value="Si" name="fl_diffusion_graduates" id="fl_diffusion_graduates"/>   
                        <label class="checkbox-inline label-row" for="fl_diffusion_graduates" style="margin-left: 10px; display: inline;">Egresados(as) de la UT</label>
                    </div>
                    <div class="div-row input-prepend" style="min-height: 0px; margin-bottom: 0px;">
                        <input data-type-role="checkbox" disabled="" data-field="true" type="checkbox" value="Si" name="fl_diffusion_family_friends" id="fl_diffusion_family_friends"/>   
                        <label class="checkbox-inline label-row" for="fl_diffusion_family_friends" style="margin-left: 10px; display: inline;">Familiares y amigos</label>
                    </div>
                    <div class="div-row input-prepend" style="min-height: 0px; margin-bottom: 0px;">
                        <input data-type-role="checkbox" disabled="" data-field="true" type="checkbox" value="Si" name="fl_diffusion_directlt_ut" id="fl_diffusion_directlt_ut"/>   
                        <label class="checkbox-inline label-row" for="fl_diffusion_directlt_ut" style="margin-left: 10px; display: inline;">Directamente en la UT</label>
                    </div>
                    <div class="div-row input-prepend" style="min-height: 0px; margin-bottom: 0px;">
                        <input data-type-role="checkbox" disabled="" data-field="true" type="checkbox" value="Si" name="fl_diffusion_brochure" id="fl_diffusion_brochure"/>   
                        <label class="checkbox-inline label-row" for="fl_diffusion_brochure" style="margin-left: 10px; display: inline;">Folleto</label>
                    </div>
                    <div class="div-row input-prepend" style="min-height: 0px; margin-bottom: 0px;">
                        <input data-type-role="checkbox" disabled="" data-field="true" type="checkbox" value="Si" name="fl_diffusion_newspaper" id="fl_diffusion_newspaper"/>   
                        <label class="checkbox-inline label-row" for="fl_diffusion_newspaper" style="margin-left: 10px; display: inline;">Periódico</label>
                    </div>
                    <div class="div-row input-prepend" style="min-height: 0px; margin-bottom: 0px;">
                        <input data-type-role="checkbox" disabled="" data-field="true" type="checkbox" value="Si" name="fl_diffusion_students_ut" id="fl_diffusion_students_ut"/>   
                        <label class="checkbox-inline label-row" for="fl_diffusion_students_ut" style="margin-left: 10px; display: inline;">Estudiantes de la UT</label>
                    </div>   
                    <div class="div-row input-prepend" style="min-height: 0px; margin-bottom: 0px;">
                        <input data-type-role="checkbox" disabled="" data-field="true" type="checkbox" value="Si" name="fl_diffusion_manta" id="fl_diffusion_manta"/>   
                        <label class="checkbox-inline label-row" for="fl_diffusion_manta" style="margin-left: 10px; display: inline;">Manta</label>
                    </div>
                    <div class="div-row input-prepend" style="min-height: 0px; margin-bottom: 0px;">
                        <input data-type-role="checkbox" disabled="" data-field="true" type="checkbox" value="Si" name="fl_diffusion_triptych" id="fl_diffusion_triptych"/>   
                        <label class="checkbox-inline label-row" for="fl_diffusion_triptych" style="margin-left: 10px; display: inline;">Tríptico</label>
                    </div>
                    <div class="div-row input-prepend" style="min-height: 0px; margin-bottom: 0px;">
                        <input data-type-role="checkbox" disabled="" data-field="true" type="checkbox" value="Si" name="fl_diffusion_guided_visits" id="fl_diffusion_guided_visits"/>   
                        <label class="checkbox-inline label-row" for="fl_diffusion_guided_visits" style="margin-left: 10px; display: inline;">Visitas guiadas</label>
                    </div>
                    <div class="div-row input-prepend" style="min-height: 0px; margin-bottom: 0px;">
                        <input data-type-role="checkbox" disabled="" data-field="true" type="checkbox" value="Si" name="fl_diffusion_exhibitions" id="fl_diffusion_exhibitions"/>   
                        <label class="checkbox-inline label-row" for="fl_diffusion_exhibitions" style="margin-left: 10px; display: inline;">Exposiciones</label>
                    </div>
                    <div class="div-row input-prepend" style="min-height: 0px; margin-bottom: 0px;">
                        <input data-type-role="checkbox" disabled="" data-field="true" type="checkbox"  value="Si" name="fl_diffusion_other" id="fl_diffusion_other"/>   
                        <label class="checkbox-inline label-row" for="fl_diffusion_other" style="margin-left: 10px; display: inline;">Otro</label>
                    </div>
                    <div id="fl_diffusion_other_div" style="display: none">
                        <div class="div-row input-prepend">
                            <label class="label-row" for="fl_diffusion_other_name">¿Cuál?</label><br>
                            <span class="add-on"><i class="icon-text-width"></i></span>      
                            <input data-type-role="text" disabled="" data-field="true" name="fl_diffusion_other_name" placeholder="Nombre..." style="width: 285px"/>
                        </div>
                    </div>
                    <div class="div-row input-prepend">
                        <label class="label-row" for="fl_option_utsem_study">¿Qué opción es para ti la UTsem para la continuidad de Estudios?</label><br>
                        <span class="add-on"><i class="icon-list"></i></span>
                        <div data-type-role="combo" disabled="" data-field="true" name="fl_option_utsem_study" id="fl_option_utsem_study"></div>
                    </div>  
                </div>
                <div id="form5" class="form">
                    <h2 class="StepTitle">Aacuerdos del registro</h2><br>
                    <div class="panel-body" style="text-align: left; padding: 20px; color:#53A753;">
                        <p>Los datos personales son necesarios para que un individuo pueda interactuar con otros 
                            o con una o más organizaciones, sin que sea confundido con el resto de la colectividad.</p>
                        <p>Los datos personales recabados de Usted, serán utilizados para los fines propios del 
                            objeto de la Universidad y que son indispensables para el cumplimiento de su objeto.</p>
                        <p>La Universidad tiene la responsabilidad del uso, tratamiento y protección de sus 
                            datos personales, observando los principios de Licitud, Consentimiento, Lealtad, 
                            Finalidad, proporcionalidad y Responsabilidad.</p>
                        <p>La entrega de tus datos personales es obligatorio, en caso de que el titular se 
                            niegue a otorgarlos, no se estará en posibilidad de realizar el trámite 
                            correspondiente para el cumplimiento de los fines de la Universidad.</p>   
                        <legend>Acuerdo</legend>
                        <p>¿Está usted de acuerdo en proporcionar los datos solicitados en el presente 
                            sistema de información? </p>
                        <div class="div-row input-prepend" style="min-height: 0px; margin-bottom: 0px;">
                            <input data-type-role="checkbox" disabled="" data-field="true" type="checkbox" value="Si" name="fl_acept_term" id="fl_acept_term"> 
                            <label class="checkbox-inline label-row" for="fl_acept_term" style="margin-left: 10px; display: inline;">Acepto los terminos de privacidad</label>
                        </div><br>
                    </div>
                </div>
                <div id="basketButtonsWrapper">
                    <input type="button" value="Atras" class="backButton" />
                    <input type="button" value="Siguiente" class="nextButton disabled" id="continue"/>
                </div>
            </div>
        </div>
        <div class="loader" style="display: none">
            <img style="width: 40px; margin: 4px;" src="../content/pictures-system/load.GIF">Dato guardado...
        </div>
    </div>
</div>