<script type="text/javascript">
    $(document).ready(function () {
        var itemRol = 0;
        function loadSource(fkRol){
            var ordersSource ={
                dataFields: [
                    { name: 'id', type:'int'},
                    { name: 'dataProgresivNumber', type:'int'},
                    { name: 'dataNamePage', type: 'string' },
                    { name: 'dataFkParent', type: 'int' },
                    { name: 'dataAccess', type: 'int' },
                    { name: 'dataAccessDescription', type: 'string' }
                ],
                hierarchy:
                {
                    keyDataField: { name: 'id' },
                    parentDataField: { name: 'dataFkParent' }
                },
                root: "__ENTITIES",
                dataType: "json",
                async: false,
                id: 'id',
                url: '../serviceSectionsMenu?view=amissibleness&&userRol='+fkRol+'' 
            };
            return ordersSource;
        };
        createDropDownRol("#amissiblenessRolFilter");
        itemRol = $('#amissiblenessRolFilter').jqxDropDownList('getSelectedItem');
        itemRol = itemRol.value;
        var dataAdapter = new $.jqx.dataAdapter(loadSource(itemRol));
        $("#tableAmissibleness").jqxTreeGrid({
            width: 400,
            height: 300,
            selectionMode: "singleRow",
            localization: getLocalization("es"),
            altRows: true,
            hierarchicalCheckboxes: true,
            checkboxes: true,
            source: dataAdapter,
            ready: function(){ 
                var view = $("#tableAmissibleness").jqxTreeGrid('getView');
                var displayView = function (records) {
                    for (var i = 0; i < records.length; i++) {
                        if(records[i].dataAccess===1){
                            $("#tableAmissibleness").jqxTreeGrid('checkRow',records[i].id);
                        }else{
                            $("#tableAmissibleness").jqxTreeGrid('uncheckRow', records[i].id);
                        }
                        if (records[i].records) {
                            displayView(records[i].records);
                        }
                    }
                };
                displayView(view);         
            },
            columns: [
                { text: 'Página', dataField: 'dataNamePage', width: 300},
                { text: 'Estado', dataField: 'dataAccessDescription',cellsalign:'center', align: 'center'}
            ]
        });
        $('#amissiblenessRolFilter').on('change',function (event){   
            itemRol = $('#amissiblenessRolFilter').jqxDropDownList('getSelectedItem');
            $("#tableAmissibleness").jqxTreeGrid('clear');
            dataAdapter = new $.jqx.dataAdapter(loadSource(itemRol.value));
            $("#tableAmissibleness").jqxTreeGrid({source: dataAdapter});
        });
        var bindingComplete=true;
        $('#tableAmissibleness').on('bindingComplete', function (event) {
            //$("#tableAmissibleness").off("rowCheck");
            //$("#tableAmissibleness").off("rowUncheck");
            var view = $("#tableAmissibleness").jqxTreeGrid('getView');
            var displayView = function (records) {
                for (var i = 0; i < records.length; i++) {
                    if(records[i].dataAccess===1){
                        bindingComplete=false;
                        $("#tableAmissibleness").jqxTreeGrid('checkRow',records[i].id);
                    }else{
                        bindingComplete=false;
                        $("#tableAmissibleness").jqxTreeGrid('uncheckRow', records[i].id);
                    }
                    if (records[i].records) {
                        displayView(records[i].records);
                    }
                }
            };
            displayView(view);  
            bindingComplete=true;
        }); 
        $('#tableAmissibleness').on('rowCheck', function (event){
            if(bindingComplete){
                // event args.
                var args = event.args;
                // row data.
                var row = args.row;
                // row key.
                var key = args.key;
                itemRol = $('#amissiblenessRolFilter').jqxDropDownList('getSelectedItem');
                $.ajax({
                    //Send the paramethers to servelt
                    type: "POST",
                    dataType: 'json',
                    async: true,
                    url: "../serviceSectionsMenu?amissiblenessUpdate",
                    data:{"pkRol": itemRol.value,"pkSection":row.id,"access":1},
                    beforeSend: function (xhr) {
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        //This is if exits an error with the server internal can do server off, or page not found
                        alert("Error interno del servidor");
                    },
                    success: function (data, textStatus, jqXHR) {
                        $("#tableAmissibleness").jqxTreeGrid('setCellValue', row.id, 'dataAccessDescription', 'Permitido');
                    }
                });
            }
        });
        $('#tableAmissibleness').on('rowUncheck', function (event){
            if(bindingComplete){
                // event args.
                var args = event.args;
                // row data.
                var row = args.row;
                // row key.
                var key = args.key;
                itemRol = $('#amissiblenessRolFilter').jqxDropDownList('getSelectedItem');
                $.ajax({
                    //Send the paramethers to servelt
                    type: "POST",
                    async: true,
                    dataType: 'json',
                    url: "../serviceSectionsMenu?amissiblenessUpdate",
                    data:{"pkRol": itemRol.value,"pkSection":row.id,"access":0},
                    beforeSend: function (xhr) {
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        //This is if exits an error with the server internal can do server off, or page not found
                        alert("Error interno del servidor");
                    },
                    success: function (data, textStatus, jqXHR) {
                        //alert(data.retult);
                        $("#tableAmissibleness").jqxTreeGrid('setCellValue', row.id, 'dataAccessDescription', 'Denegado');
                    }
                });
            }
        });        
    });
</script>
<div style="float: left; margin-right: 5px;">
    Rol<br>
    <div id='amissiblenessRolFilter'></div>
</div><br><br><br>
<div id="tableAmissibleness"></div>