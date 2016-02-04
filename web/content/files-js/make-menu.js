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
    $('#jqxTree').jqxTree({theme:theme, height: '100%', width: '100%',allowDrag: false});
    $('#jqxTree').css('visibility', 'visible');
    $('#jqxTree').on('select', function (event) {
       // $("#ContentPanel").html("<div style='margin: 10px;'>" + event.args.element.id + "</div>");
    });
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
        source: records, 
        width: '100%',
        toggleMode: 'click'
    });
    $('#jqxTree').jqxTree('selectItem', $("#1")[0]);
    //menu-load-state
    var dir;
    var itemClickedId;
    var itemClickedText;
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
        $("#ContentPanel").load("../content/data-jsp/views-external/item-adjustment/flange/acount/acount.jsp?lockPage=false");
        $('#jqxTree').jqxTree('selectItem', $("#25")[0]);
        $.cookie('itemParentId',"9");
        $.cookie('itemClickedId',"25");
    });
    if(dirCookie==undefined){
        $.cookie('dir','item-start/start.jsp');
        dirCookie=$.cookie('dir');
        $("#ContentPanel").load("../content/data-jsp/views-external/item-start/start.jsp?lockPage=false");
        $('#jqxTree').jqxTree('selectItem', $("#1")[0]);
        $.cookie('itemParentId',"undefined");
        $.cookie('itemClickedId',"1");
    }
    if(dirCookie==="undefined"){
        dirCookie=$.cookie('dir');
        itemClickedId=$.cookie('itemClickedId');
        itemClickedText=$.cookie('itemClickedText');
        $('#jqxTree').jqxTree('selectItem', $("#"+itemClickedId)[0]);
        $.cookie('itemParentId',"undefined");
        $("#ContentPanel").load("../content/data-jsp/loadItemsMenuOnPanel/itemsPanelMenu.jsp?pkParent="+itemClickedId+"");
    }else if(dirCookie==="null"){
        $.cookie('dir','item-start/start.jsp');
        $("#ContentPanel").load("../content/data-jsp/views-external/item-start/start.jsp?lockPage=false");
        $('#jqxTree').jqxTree('selectItem', $("#1")[0]);
        $.cookie('itemParentId',"undefined");
        $.cookie('itemClickedId',"1");
    }
    else{
        itemParentId=$.cookie('itemParentId');
        itemClickedId=$.cookie('itemClickedId');
        $('#jqxTree').jqxTree('selectItem', $("#"+itemClickedId)[0]);  
        $("#jqxTree").jqxTree('expandItem', $("#"+itemParentId)[0]);
        $.ajax({
            url:"../content/data-jsp/views-external/"+dirCookie+"?lockPage=false",
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

            }
        });
    }
    var itemOld = $.cookie('itemNew');
    $('#jqxTree').on('select',function (event){
        var args = event.args;
//        var item = $('#jqxTree').jqxTree('getItem', args.element);
//        var label = item.label; 
//        $.cookie('itemNew',$(this).text());
    });
    //menu-click´s
    $(".itemsMenu").parent().on("click",function (){   
        $("div").off("valueChanged");
        dir = $(this).children("span").attr("dir");
        //alert(dir);
        dir = dir.split(',');
        if(dir[1]!=="undefined"){
            itemParentId = $(this).parent().parent().parent().attr("id");
            itemChildrenId = $(this).parent().attr("id");
            itemClickedId=$(this).parent().attr("id");
            $.cookie('dir',dir[1]);
            $.cookie('itemNew',$(this).text());  
            $.cookie('itemParentId',itemClickedId);
            $.cookie('itemClickedId',itemClickedId);
        }else{
            //Es parent por default
            itemParentId = $(this).parent().attr("id");
            itemClickedId=$(this).parent().attr("id");
            itemClickedText=$(this).text();
            $("#jqxTree").jqxTree('expandItem', $("#"+itemParentId)[0]);
            $.cookie('itemParentId',itemParentId);
            $.cookie('itemClickedId',itemClickedId);
            $.cookie('itemClickedText',itemClickedText);
            $.cookie('dir',dir[1]);
            $("#ContentPanel").load("../content/data-jsp/loadItemsMenuOnPanel/itemsPanelMenu.jsp?pkParent="+itemClickedId+"");
        }
        if($.cookie('itemNew')!==itemOld){
            $.cookie('tabActive',0);
            itemOld=$.cookie('itemNew');
            if(dir[1]!=="undefined"){
                //alert(dir[1]);
                $.cookie('dir',dir[1]);
                location="/admin";
//                $.ajax({
//                    url:"../content/data-jsp/views-external/"+dir[1]+"?lockPage=false",
//                    async: true,
//                    beforeSend: function (xhr) {
//                        if(dir[0]!=="undefined"){
//                            $("#load-page-external").jqxWindow('open');
//                        }
//                    },
//                    success: function (data, textStatus, jqXHR) {
//                        $("#ContentPanel").html(data);
//                        if(dir[0]!=="undefined"){
//                            setTimeout(function (){
//                                $(".hidenTab").show();
//                                $("#load-page-external").jqxWindow('close');
//                            },'1000');
//                        }
//                    },
//                    error: function (jqXHR, textStatus, errorThrown) {
//
//                    }
//                });
            }
        } 
        itemChildrenId=undefined;
        itemClickedId=undefined;
        itemParentId=undefined;
    });
});

