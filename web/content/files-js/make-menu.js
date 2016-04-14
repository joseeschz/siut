/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function () {
    //****************Comentary****************//
    //*Menu*//
    /*Este codigo hace un toogle al menu*/
    $("html").on('contextmenu', function () {
        //return false;
    });
    
    var offset = $("#panel-principal").offset();
    var widthPanel= $("#panel-principal").width();
    var heightPanel=$("#panel-principal").height();
    $("#popover").jqxPopover({
        offset: {left: -50, top:0},
        arrowOffsetValue: 50, 
        title: "Usuario", 
        width: '180px', 
        showCloseButton: true, 
        selector: $(".jqx-triangulo_inf") 
    });
    $("#popover").children(".jqx-popover-content").css("padding","0");
    
    $("#jqxMenuOptions").jqxMenu({
        width: '178px', 
        height: '130px',
        theme:""
    }).css("background","white");;
    $('#jqxMenuOptions').jqxMenu('disable', 'close', true);
    $('#jqxMenuOptions').jqxMenu('disable', 'userName', true);
    $("#jqxMenuOptions").children("ul").show();
    $("#load-page-external").jqxWindow({
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
    $("#infoImg").jqxTooltip({
        width: 180, 
        content: '<p style="text-align: left;">Los items del menu son \n\
        administrados por el sistema y asignados por roles.</p>',
        autoHideDelay: 10000000, 
        position: 'bottom-right', 
        name: 'movieTooltip'
    });
    $("#menu-despliegue").jqxTooltip({
        content: 'Colapsar',
        autoHideDelay: 10000000, 
        closeOnClick:true,
        position: 'right', 
        name: 'movieTooltip'
    });
    $("#picturePerfil").jqxTooltip({
        content: 'Imagen de perfil',
        autoHideDelay: 10000000, 
        closeOnClick:true,
        position: 'bottom', 
        name: 'movieTooltip'
    });
    $("#helpSystem").jqxTooltip({
        width: 400,
        content: '<p style="text-align: left;">El sistema SIUT contribuye con el desarrollo integral \n\
        de la UTsem por lo cual cada cabe la posibilidad que un \n\
        módulo sea dependiente de otro.</p>',
        autoHideDelay: 10000000, 
        closeOnClick:true,
        position: 'bottom-left', 
        name: 'movieTooltip'
    });
    $("#aboutSystem").click(function (){
        var left = (screen.width/2)-(400/2);
        var top = (screen.height/2)-(400/2);
        window.open ("../content/data-jsp/about/about.html", "mywindow","location=1,status=1,scrollbars=1, width=400,height=400, top="+top+", left="+left+"");
    });
    var open=true;
    $("#menu-despliegue").click(function (){
        if(open){
            $(this).addClass( "menu-despliegue-right"); 
            $(this).removeClass("menu-despliegue-left");
            $('#jqxSplitter').jqxSplitter('collapse');     
            $("#menu-despliegue").jqxTooltip({ content: 'Desplegar'});
        }else{
            $(this).addClass( "menu-despliegue-left"); 
            $(this).removeClass("menu-despliegue-right");
            $('#jqxSplitter').jqxSplitter('expand');
            $("#menu-despliegue").jqxTooltip({ content: 'Colapsar'});
        }
    });
    $('#jqxSplitter').on('collapsed',function (event) { 
        open=false;
        if(open){
            $("#menu-despliegue").addClass( "menu-despliegue-left"); 
            $("#menu-despliegue").removeClass("menu-despliegue-right");                      
        }else{
            $("#menu-despliegue").addClass( "menu-despliegue-right"); 
            $("#menu-despliegue").removeClass("menu-despliegue-left");
        }
    });
    $('#jqxSplitter').on('expanded',function (event) {
        open=true; 
        if(open){
            $("#menu-despliegue").addClass( "menu-despliegue-left"); 
            $("#menu-despliegue").removeClass("menu-despliegue-right");                      
        }else{
            $("#menu-despliegue").addClass( "menu-despliegue-right"); 
            $("#menu-despliegue").removeClass("menu-despliegue-left");
        }
    });
    
    //->Muenu<-//
    //****************Comentary****************//
    //*Splitter*//
    /*Este codigo hace un div splitter*/
    $("#jqxSplitter").jqxSplitter({theme:theme,height: "100%", width: "100%", panels: [{ size: 250}] });

    //->Muenu<-//
    // Create jqxExpander
    $('#jqxExpander').jqxExpander({theme:theme, showArrow: false, toggleMode: 'none', width: '100%', height: '100%'});
    // Create jqxTree
    var source =
    {
        url:"../serviceSectionsMenu?view",
        datatype: "json",
        datafields: [
            { name: 'id' },
            { name: 'parentid' },
            { name: 'text' },
            { name: 'icon' }
        ],
        id: 'id',
        async: false
    };
    //Lose the page back
    window.location.hash="";
    window.location.hash=""; //chrome
    window.onhashchange=function(){window.location.hash="";};
    // create data adapter.
    var dataAdapter = new $.jqx.dataAdapter(source);
    // perform Data Binding.
    dataAdapter.dataBind();
    // get the tree items. The first parameter is the item's id. The second parameter is the parent item's id. The 'items' parameter represents 
    // the sub items collection name. Each jqxTree item has a 'label' property, but in the JSON data, we have a 'text' field. The last parameter 
    // specifies the mapping between the 'text' and 'label' fields.  
    var records = dataAdapter.getRecordsHierarchy('id', 'parentid', 'items', [{ name: 'text', map: 'label', icon: 'icon'}]);
    $('#jqxTree').jqxTree({ 
        theme:theme, 
        height: '100%',
        width: '100%',
        allowDrag: false,
        source: records, 
        toggleMode: 'click'
    }).css('visibility', 'visible');
    //menu-load-state
    var itemNew;
    var dir;
    var itemClickedId;
    var itemParentId;
    var itemChildrenId;
    var dirCookie = $.cookie('dir');
    $("#logOut").click(function (){
        $.cookie('dir', null);
        $.cookie('itemParentId',null);
        $.cookie('itemClickedId', null);
        $.cookie('itemNew',null);
        $.cookie('itemClickedText',null);
        $.cookie('tabActive',null);
    });
    $("#settingsAcount").click(function (){
        $.cookie('dir','item-adjustment/flange/acount/acount.jsp');
        dirCookie=$.cookie('dir');
        $('#jqxTree').jqxTree('selectItem', $("#25")[0]);
        $.cookie('itemParentId',"9");
        $.cookie('itemClickedId',"25");
        location="/admin";
    });
    var isParent = $.cookie('isParent') || true;
    var isChildren = $.cookie('isChildren') || false;
    if($.cookie('isParent') || $.cookie('dir')===""){        
        $('#jqxTree').jqxTree('selectItem', $("#"+$.cookie('itemParentId')||1)[0]);
        $("#ContentPanel").load("../content/data-jsp/loadItemsMenuOnPanel/itemsPanelMenu.jsp?pkParent="+$.cookie('itemParentId')+"");
        $("#jqxTree").jqxTree('expandItem', $("#"+$.cookie('itemParentId')||1)[0]);    
    }else{
         $("#ContentPanel").load("../content/data-jsp/views-external/item-start/start.jsp?lockPage=false");
        $('#jqxTree').jqxTree('selectItem', $("#1")[0]);
    }
    if(isChildren && $.cookie('dir')!==""){
        $("#jqxTree").jqxTree('expandItem', $("#"+$.cookie('itemParentId')||1)[0]);  
        $('#jqxTree').jqxTree('selectItem', $("#"+$.cookie('itemClickedId')||1)[0]); 
        $.ajax({
            url:"../content/data-jsp/views-external/"+$.cookie('dir')+"?lockPage=false",
            async: true,
            beforeSend: function (xhr) {
                $("#load-page-external").jqxWindow('open');
            },
            success: function (data, textStatus, jqXHR) {
                $("#ContentPanel").html(data);
                setTimeout(function (){
                    $(".hidenTab").show();
                    $("#load-page-external").jqxWindow('close');
                },'1000');
            },
            error: function (jqXHR, textStatus, errorThrown) {
                setTimeout(function (){
                    $(".hidenTab").show();
                    $("#load-page-external").jqxWindow('close');
                },'1000');
            }
        });
    }   
    
    $('#jqxTree').on('select',function (event){
        var args = event.args;
        if($(args.element).children().children("span").attr("parent")==="-1" || $(args.element).children().children("span").attr("dir")===""){
            isParent = true;
            $.removeCookie("isChildren");
            itemParentId=$(args.element).attr("id");
            itemChildrenId=$(args.element).children().children("span").attr("parent");
            itemClickedId=$(args.element).attr("id");
            itemNew = $(args.element).text();
            dir = $(args.element).children().children("span").attr("dir");            
            $("#ContentPanel").load("../content/data-jsp/loadItemsMenuOnPanel/itemsPanelMenu.jsp?pkParent="+itemClickedId+"");     
            $.cookie('isParent',isParent);
            $.cookie('dir',dir);
            $.cookie('itemNew',itemNew);  
            $.cookie('itemParentId',itemClickedId);
            $.cookie('itemClickedId',itemClickedId);
        }else{
            $.cookie('isChildren', true);
            $.removeCookie("isParent");
            itemParentId=$(args.element).attr("id");
            itemChildrenId=$(args.element).children().children("span").attr("parent");
            itemClickedId=$(args.element).attr("id");
            itemNew = $(args.element).text();
            dir = $(args.element).children().children("span").attr("dir");  
            $.cookie('dir',dir);
            $.cookie('itemClickedId',itemClickedId); 
            location="/admin";
        }
    });
    
});

