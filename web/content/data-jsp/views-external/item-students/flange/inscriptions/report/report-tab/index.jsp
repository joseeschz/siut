<script type="text/javascript">
    $(document).ready(function () {
        function loadSource(){
            var url = "../serviceStudent?tableByAllColumsMetadata";
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
        var cellsrenderer = function (row, column, value) {
            return "<div style='margin:4px;'>" + (value + 1) + "</div>";
        };
        var createfilterpanel = function (datafield, filterPanel) {
            buildFilterPanel(filterPanel, datafield );
        };
        var adapter;
        var columns;
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
                columns = data[0].columns;
                var dataFields = data[1].dataFields;
                var rows = data[2].rowsCal;                
                var gridAdapter = new $.jqx.dataAdapter({
                    dataFields: dataFields,
                    id: 'dataProgresivNumber',
                    localdata: rows
                });
//                var rows.prototype.toUpperCase();
                
                adapter = gridAdapter;
                var arr = columns;
                var str = JSON.stringify(arr);
                var newArr = JSON.parse(str);
                for(var i=0;i<newArr.length; i++){
                    if(newArr[i].resizable){
                        newArr[i].resizable = eval(newArr[i].resizable);
                    }
                    if(newArr[i].resizable){
                        newArr[i].resizable = eval(newArr[i].resizable);
                    }
                    if(newArr[i].sortable){
                        newArr[i].sortable = eval(newArr[i].sortable);
                    }
                    if(newArr[i].cellsrenderer){
                        newArr[i].cellsrenderer = eval(newArr[i].cellsrenderer);
                    }
                    if(newArr[i].createfilterpanel){
                        newArr[i].createfilterpanel = eval(newArr[i].createfilterpanel);
                    }
                    if(newArr[i].rendered){
                        newArr[i].rendered = eval(newArr[i].rendered);
                    }
                    if(newArr[i].pinned){
                        newArr[i].pinned = eval(newArr[i].pinned);
                    }
                    if(newArr[i].filterable){
                        newArr[i].filterable = eval(newArr[i].filterable);
                    }
                    
                }
                columns=newArr;
            }
        });
        var buildFilterPanel = function (filterPanel, datafield) {
            var textInput = $("<input style='margin:5px;'/>");
            var applyinput = $("<div class='filter' style='height: 25px; margin-left: 20px; margin-top: 7px;'></div>");
            var filterbutton = $('<span tabindex="0" style="padding: 4px 12px; margin-left: 2px;">Filtrar</span>');
            applyinput.append(filterbutton);
            var filterclearbutton = $('<span tabindex="0" style="padding: 4px 12px; margin-left: 5px;">Limpiar</span>');
            applyinput.append(filterclearbutton);
            filterPanel.append(textInput);
            filterPanel.append(applyinput);
            filterbutton.jqxButton({ theme: theme, height: 20 });
            filterclearbutton.jqxButton({ theme: theme, height: 20 });
            var dataSource ={
                localdata: adapter.records,
                datatype: "array",
                async: false
            };
            var dataadapter = new $.jqx.dataAdapter(dataSource,{
                autoBind: false,
                autoSort: true,
                autoSortField: datafield,
                async: false,
                uniqueDataFields: [datafield]
            });
            var column = $("#jqxGridReport").jqxGrid('getcolumn', datafield);
            textInput.jqxInput({ theme: theme, placeHolder: "BUSCAR " + column.text, popupZIndex: 9999999, displayMember: datafield, source: dataadapter, height: 23, width: 175 });
            textInput.keyup(function (event) {
                if (event.keyCode === 13) {
                    filterbutton.trigger('click');
                }
            });
            filterbutton.click(function () {
                var filtergroup = new $.jqx.filter();
                var filter_or_operator = 1;
                var filtervalue = textInput.val();
                var filtercondition = 'contains';
                var filter1 = filtergroup.createfilter('stringfilter', filtervalue, filtercondition);            
                filtergroup.addfilter(filter_or_operator, filter1);
                // add the filters.
                $("#jqxGridReport").jqxGrid('addfilter', datafield, filtergroup);
                // apply the filters.
                $("#jqxGridReport").jqxGrid('applyfilters');
                $("#jqxGridReport").jqxGrid('closemenu');
            });
            filterbutton.keydown(function (event) {
                if (event.keyCode === 13) {
                    filterbutton.trigger('click');
                }
            });
            filterclearbutton.click(function () {
                $("#jqxGridReport").jqxGrid('removefilter', datafield);
                // apply the filters.
                $("#jqxGridReport").jqxGrid('applyfilters');
                $("#jqxGridReport").jqxGrid('closemenu');
            });
            filterclearbutton.keydown(function (event) {
                if (event.keyCode === 13) {
                    filterclearbutton.trigger('click');
                }
                textInput.val("");
            });
        };     
        $("#jqxGridReport").on('contextmenu', function () {
            return false;
        }); 
        $("#jqxGridReport").jqxGrid({
            width: 850,
            height: 520, 
            selectionmode: 'singlecell',
            source: adapter,
            clipboard: true,
            filterable: true,
            sortable: true,
            columnsresize: true,
            columnsautoresize: true,
            pageable: true,
            pagesize: 30,
            enabletooltips: true,
            pagesizeoptions: ['15', '30', '50'],
            localization: getLocalization("es"),
            ready: function () {
//                $("#jqxGridReport").jqxGrid('autoresizecolumns');
            },
            autoshowfiltericon: false,
            columnmenuopening: function (menu, datafield, height) {
                var column = $("#jqxGridReport").jqxGrid('getcolumn', datafield);
                if (column.filtertype === "custom") {
                    menu.height(155);
                    setTimeout(function () {
                        menu.find('input').focus();
                    }, 25);
                }
                else menu.height(height);
            },
            columns: columns
        });
        $("#jqxGridReport").on("filter", function (event) {
            $("#clearfilteringbutton").show();
        });
        $('#clearfilteringbutton').jqxButton({ height: 25 });
        $('#clearfilteringbutton').click(function () {
            $("#jqxGridReport").jqxGrid('clearfilters');
            $(this).hide();
        });
//        $("#excelExport").jqxButton();
//        $("#xmlExport").jqxButton();
//        $("#csvExport").jqxButton();
//        $("#tsvExport").jqxButton();
//        $("#htmlExport").jqxButton();
//        $("#jsonExport").jqxButton();
//        $("#pdfExport").jqxButton();
//        $("#excelExport").click(function () {
//            $("#jqxGridReport").jqxGrid('exportdata', 'xls', 'jqxGrid');           
//        });
//        $("#xmlExport").click(function () {
//            $("#jqxGridReport").jqxGrid('exportdata', 'xml', 'jqxGrid');
//        });
//        $("#csvExport").click(function () {
//            $("#jqxGridReport").jqxGrid('exportdata', 'csv', 'jqxGrid');
//        });
//        $("#tsvExport").click(function () {
//            $("#jqxGridReport").jqxGrid('exportdata', 'tsv', 'jqxGrid');
//        });
//        $("#htmlExport").click(function () {
//            $("#jqxGridReport").jqxGrid('exportdata', 'html', 'jqxGrid');
//        });
//        $("#jsonExport").click(function () {
//            $("#jqxGridReport").jqxGrid('exportdata', 'json', 'jqxGrid');
//        });
//        $("#pdfExport").click(function () {
//            $("#jqxGridReport").jqxGrid('exportdata', 'pdf', 'jqxGrid');
//        });
    });
</script>
<div id='jqxWidget' style="font-size: 13px; font-family: Verdana; float: left;">    
    <div id="jqxGridReport"></div>
    <input value="Quitar filtros" id="clearfilteringbutton" type="button" style="display: none" />
<!--    <div style='margin-top: 20px;'>
        <div style='float: left;'>
            <input type="button" value="Export to Excel" id='excelExport' />
            <br /><br />
            <input type="button" value="Export to XML" id='xmlExport' />
        </div>
        <div style='margin-left: 10px; float: left;'>
            <input type="button" value="Export to CSV" id='csvExport' />
            <br /><br />
            <input type="button" value="Export to TSV" id='tsvExport' />
        </div>
        <div style='margin-left: 10px; float: left;'>
            <input type="button" value="Export to HTML" id='htmlExport' />
            <br /><br />
            <input type="button" value="Export to JSON" id='jsonExport' />
        </div>
        <div style='margin-left: 10px; float: left;'>
            <input type="button" value="Export to PDF" id='pdfExport' />
        </div>
    </div>-->
</div>