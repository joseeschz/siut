<script type="text/javascript">
    $(document).ready(function () {
        var url = "../serviceCandidate?tableByAllColumsMetadata";
        function loadSource(){
            var ordersSource ={
                dataType: "json",
                async: false,
                url: url
            };
            return ordersSource;
        }
        
        var tooltiprenderer = function (element) {
            $(element).jqxTooltip({position: 'mouse', content: $(element).text() });
        };
        var dataAdapter = new $.jqx.dataAdapter(loadSource(), {
            autoBind: true,
            beforeSend:function (){
                $("#jqxGridReport").jqxGrid('showloadelement');
            },
            beforeLoadComplete:function (){
                $("#jqxGridReport").jqxGrid('hideloadelement');
            },
            downloadComplete: function (data) {

                //dataExternal=data;
                var columns = data[0].columns;
                console.log(data[0].columns);
                var dataFields = data[1].dataFields;
                var rows = data[2].rowsCal;
                var gridAdapter = new $.jqx.dataAdapter({
                    dataFields: dataFields,
                    id: 'dataProgresivNumber',
                    localdata: rows
                });

                var arr = columns;
                var str = JSON.stringify(arr);
                var newArr = JSON.parse(str);
                for(var i=0;i<newArr.length; i++){
                    if(newArr[i].rendered){
                        newArr[i].rendered = eval(newArr[i].rendered);
                    }  
                    if(newArr[i].cellclassname){
                        newArr[i].cellclassname = eval(newArr[i].cellclassname);
                    }
                }
                columns=newArr;
                $("#jqxGridReport").jqxGrid({
                    width: 800,
                    height: 520, 
                    pageable: true,
                    sortable: true,
                    columnsResize: true,
                    showfilterrow: true,
                    pagesize: 30,
                    pagesizeoptions: ['15', '30', '50'],
                    localization: getLocalization("es"),
                    source: gridAdapter,
                    filterable: true,
                    columns: columns,
                    ready: function (){
                        $("#jqxGridReport").jqxGrid('autoresizecolumns');
                    }
                });
                $("#jqxGridReport").jqxGrid('endupdate');
            }
        });
        $("#jqxGridReport").on("pagechanged", function (event) {
            // event arguments.
            var args = event.args;
            // page number.
            var pagenum = args.pagenum;
            // page size.
            var pagesize = args.pagesize;
            $("#jqxGridReport").jqxGrid('autoresizecolumns');
        });  
        $("#jqxGridReport").on("filter", function (event) {
            $("#jqxGridReport").jqxGrid('autoresizecolumns');
        });     
        $("#jqxGridReport").on('contextmenu', function () {
            return false;
        });
        
        $("#excelExport").jqxButton();
        $("#excelExport").click(function () {
            $("#jqxGridReport").jqxGrid('exportdata', 'csv', 'jqxGrid', true, null, true, "http://jqwidgets.com/export_server/save-file.php");
//            $("#jqxGridReport").jqxGrid('exportData', 'xls', 'Preregistrados',  true, null, true, "http://jqwidgets.com/export_server/save-file.php");
        });
    });
</script>
<div id="jqxGridReport"></div>
<input type="button" value="Export to Excel" id='excelExport' />