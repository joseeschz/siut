<%-- 
    Document   : expedient
    Created on : 29/01/2016, 11:15:58 AM
    Author     : Lab5-E
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script>
            var initDataTableExpedient = function () {
                var url = "../serviceStudent?selectStudentExpedient";
                // prepare the data
                var source =
                {
                    datatype: "json",
                    datafields: [
                        { name: 'dataPkRequirement', type: 'string' },
                        { name: 'dataPkStudent', type: 'string' },
                        { name: 'dataName', type: 'string' },
                        { name: 'dataFulfillment', type: 'string' },
                        { name: 'dataParent', type: 'string' }
                    ],
                    id: 'id',
                    url: url,
                    data :{
                        "pt_pk_student": <%out.print(request.getParameter("pt_pk_student"));%>
                    },
                    updaterow: function (rowid, rowdata, commit) {
                        // synchronize with the server - send update command
                        // call commit with parameter true if the synchronization with the server is successful 
                        // and with parameter false if the synchronization failder.
                        var url;
                        if(rowdata.dataFulfillment){
                            url = "../serviceStudent?updateStudentExpedient";
                        }else{
                            url = "../serviceStudent?deleteStudentExpedient";
                        }
                        $.ajax({
                            type: "POST",
                            async: false,
                            url: url,
                            data: {
                                "pk_student": rowdata.dataPkStudent,
                                "pk_requirement": rowdata.dataPkRequirement
                            },
                            beforeSend: function (xhr) {
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                alert("Error interno del servidor");
                            },
                            success: function (data, textStatus, jqXHR) {
                                commit(true);
                            }
                        });
                    }
                };
                var dataAdapter = new $.jqx.dataAdapter(source);
                var cellclass = function (row, columnfield, value) {
                    var classTheme="";
                    var data = $('#jqxDataTableExpedient').jqxGrid('getrowdata', row);
                    if(data.dataParent==="Si"){
                        if(columnfield==="dataFulfillment"){                            
                            classTheme="head no-checkbox";
                        }else{
                            classTheme="head no-select";
                        }
                    }else{
                        classTheme="detail";
                    }    
                    return classTheme;
                };
                $("#jqxDataTableExpedient").jqxGrid({
                    width: 1035,
                    height: 480, 
                    pageSize: 50,
                    pageable: false,
                    localization: getLocalization("es"),
                    source: dataAdapter,
                    filterable: false,
                    editable: true,
                    cellhover: function(tableCell, x, y){
                        if($(tableCell).hasClass("head")){
                            $(tableCell).removeClass("jqx-grid-cell-hover-greenUtsem jqx-fill-state-hover jqx-fill-state-hover-greenUtsem");
                        }
                    },
                    columns: [
                        { editable: false, text: 'Requisito', datafield: 'dataName', width: 850, resizable: true, cellclassname: cellclass },
                        { text: 'Cumplimiento', cellclassname:"hola", datafield: 'dataFulfillment', columntype: 'checkbox', width: 'auto', cellsAlign:'center', cellclassname: cellclass}                   
                    ]
                });
            };
            initDataTableExpedient();
        </script>
    </head>
    <style>
        .head{            
            background-color: rgb(150, 150, 150) !important;
        }
        .no-checkbox .jqx-checkbox{
            display: none;
        }
        .no-checkbox .jqx-checkbox{
            background-color: rgb(150, 150, 150) !important;
        }
        .head.jqx-fill-state-pressed-greenUtsem, .head.jqx-widget-greenUtsem .jqx-grid-cell-selected-greenUtsem{
            background: rgb(150, 150, 150) !important;
        }
    </style>
    <body>
        <div style="overflow: hidden;">
            <div id="jqxDataTableExpedient"></div>
        </div>
    </body>
</html>
