<script>
    $(document).ready(function () {
        $("#jqxExpanderImportData").jqxExpander({ 
            width: 'auto',
            height: 150,
            showArrow: false,
            toggleMode: "none"
        });
        $("#jqxExpanderImportedDataTemp").jqxExpander({ 
            width: 'auto',
            height: 450,
            showArrow: false,
            toggleMode: "none"
        });
        $('#jqxFileUpload').jqxFileUpload({ 
            width: 300, 
            uploadUrl: '../servicetempReportPaymentsGob?uploadFileCSV', 
            fileInputName: 'fileToUploadCSV',
            accept: '.csv',
            multipleFilesUpload: false,
            uploadTemplate: 'success',
            renderFiles: function (fileName) {
                var stopIndex = fileName.indexOf('.');
                var name = fileName.slice(0, stopIndex);
                var extension = fileName.slice(stopIndex);
                return name + '<strong>' + extension + '</strong>';
            },
            localization: { 
                browseButton: 'Buscar Archivo', 
                uploadButton: 'Subir Archivo', 
                cancelButton: 'Cancelar', 
                uploadFileTooltip: 'Subir Archivo', 
                cancelFileTooltip: 'Cancelar' }
        });
        $('#jqxFileUpload').on('uploadStart', function (event) {
            $("#loading").show();
            var fileName = event.args.file;
            // Your code here.
            if(fileName.indexOf(".csv")>=0){
                
            }else{
                $("#messageUploadStatus").text("No se permiten archivos que no seán formato csv");
            }
        });
        $('#jqxFileUpload').on('uploadEnd', function (event) {
            var args = event.args;
            var fileName = args.file;
            var serverResponce = args.response;
            // Your code here.
            var responce = JSON.parse(serverResponce.replace("<pre>","").replace("</pre>","").replace('<pre style="word-wrap: break-word; white-space: pre-wrap;">', ""));
            console.log(responce)
            setTimeout(function (){
                $("#loading").hide();
                if(responce.status==="Inserted"){
                    $("#messageUploadStatus").text("Archivo subido correctamente");
                    loadGridImportedDataTemp();
                }else if(responce.status==="FileMuchLong"){
                    $("#messageUploadStatus").text("No fué posible subir el archivo peso máximo 4MB");
                }else if(responce.status==="FileNotExist"){
                    $("#messageUploadStatus").text("El archivo seleccionado no fue encontrado");
                }else{
                    $("#messageUploadStatus").text(responce.status);
                }
            },1000);
            
            setTimeout(function (){
                $("#messageUploadStatus").text("");
                
            },4000);
        });
        function loadSource(){      
            var ordersSource ={
                dataFields: [
                    { name: 'dataProgresivNumber', type: 'int' },
                    { name: 'dataPkTempReportPaymentGob', type: 'int' },
                    { name: 'dataBank', type: 'string' },
                    { name: 'dataCommission', type: 'string' },
                    { name: 'dataDateLoaded', type: 'string' },
                    { name: 'dataDatePayment', type: 'string' },
                    { name: 'dataDayTerm', type: 'string' },
                    { name: 'dataFormToPay', type: 'string' },
                    { name: 'dataImport', type: 'string' },
                    { name: 'dataOrganism', type: 'string' },
                    { name: 'dataPaymentMethod', type: 'string' },
                    { name: 'dataReference', type: 'string' },
                    { name: 'dataStatusLoad', type: 'string' },
                    { name: 'dataSubtotal', type: 'string' }
                ],
                dataType: "json",
                root: "__ENTITIES",
                id: "dataPkTempReportPaymentGob",
                async: false,
                url: '../servicetempReportPaymentsGob?view',
                deleteRow: function (rowID, commit) {
                    // synchronize with the server - send delete command
                    // call commit with parameter true if the synchronization with the server is successful 
                    // and with parameter false if the synchronization failed.
                    $.ajax({
                        //Send the paramethers to servelt
                        type: "POST",
                        async: false,
                        dataType: 'json',
                        url: "../servicetempReportPaymentsGob?delete",
                        beforeSend: function (xhr) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //This is if exits an error with the server internal can do server off, or page not found
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) {
                            $("#tableImportedDataTemp").jqxDataTable('updateBoundData');
                        }
                    });
                }
            };
            return ordersSource;
        }
        var rendertoolbar = function(toolBar){
            var theme = "";
            var toTheme = function (className) {
                if (theme === "") return className;
                return className + " " + className + "-" + theme;
            };
            // appends buttons to the status bar.
            var container = $("<div style='overflow: hidden; position: relative; height: 100%; width: 100%;'></div>");
            var buttonTemplate = "<div style='float: left; padding: 3px; margin: 2px;'><div style='margin: 4px; width: 16px; height: 16px;'></div></div>";

            var deleteButton = $(buttonTemplate);
            container.append(deleteButton);
            toolBar.append(container);
            
            deleteButton.jqxButton({ cursor: "pointer", disabled: true, enableDefault: false,  height: 25, width: 25 });
            deleteButton.find('div:first').addClass(toTheme('jqx-icon-delete'));
            deleteButton.jqxTooltip({ position: 'bottom', content: "Eliminar"});
            
            var updateButtons = function (action) {
                switch (action) {
                    case "Select":
                        deleteButton.jqxButton({ disabled: false });
                        break;
                    case "Unselect":
                        deleteButton.jqxButton({ disabled: true });
                        break;
                    case "Edit":
                        deleteButton.jqxButton({ disabled: true });
                        break;
                    case "End Edit":
                        deleteButton.jqxButton({ disabled: false });
                        break;
                }
            };
            var rowIndex = null;
            $("#tableImportedDataTemp").on('rowSelect', function (event) {
                var args = event.args;
                rowIndex = args.index;
                updateButtons('Select');
            });
            $("#tableImportedDataTemp").on('rowUnselect', function (event) {
                updateButtons('Unselect');
            });
            deleteButton.click(function () {
                if (!deleteButton.jqxButton('disabled')) {
                    $("#jqxWindowWarning").jqxWindow('open');
                    $("#okWarning").click(function (){
                        $("#okWarning").unbind("click"); 
                        $("#jqxWindowWarning").jqxWindow('close');
                        $("#tableImportedDataTemp").jqxDataTable('deleteRow', rowIndex);
                    });
                    updateButtons('delete');
                }
            });
        };
        function loadGridImportedDataTemp(){
            var dataAdapter = new $.jqx.dataAdapter(loadSource());  
            var tooltiprenderer = function (element) {
                $(element).jqxTooltip({position: 'mouse', content: $(element).text() });
            };
            $("#tableImportedDataTemp").jqxDataTable({
                width: 900,
                height: 350,
                selectionMode: "singlerow",
                localization: getLocalization("es"),
                source: dataAdapter,
                renderToolbar : rendertoolbar,
                showToolbar: true,
                toolbarHeight: 35,
                pageable: false,
                editable: false,
                altRows: true,
                filterable: true,
                showAggregates: true,
                aggregatesHeight: 65,
                ready: function(){
                    $("#tableImportedDataTemp").jqxGrid('focus');
                },
                columns: [
                    { text: '#', filterable: false, align: 'center', cellsalign: 'center', dataField: 'dataProgresivNumber', width: 40, rendered: tooltiprenderer },
                    { text: 'ORGANISMO', align: 'center', dataField: 'dataOrganism', width: 450, rendered: tooltiprenderer },
                    { 
                        text: 'CARGADO', 
                        align: 'center', 
                        cellsalign: 'center', 
                        dataField: 'dataStatusLoad', 
                        aggregates: [
                            { '<b>Total</b>' : function (aggregatedValue, currentValue, column, record){
                                    if (currentValue) {
                                        return aggregatedValue + 1;
                                    }
                                    return aggregatedValue;   
                                }
                            },
                            { 'Cargado': function (aggregatedValue, currentValue) {
                                    if (currentValue == 2) {
                                        return aggregatedValue + 1;
                                    }
                                    return aggregatedValue;
                                }
                            },
                            { 'No Cargado': function (aggregatedValue, currentValue) {
                                    if (currentValue == 1) {
                                        return aggregatedValue + 1;
                                    }
                                    return aggregatedValue;
                                }
                            }
                        ], 
                        width: 150, 
                        rendered: tooltiprenderer
                    },
                    { 
                        text: 'REFERENCIA', 
                        align: 'center', 
                        dataField: 'dataReference', 
                        width: 250, 
                        rendered: tooltiprenderer
                    },
                    { 
                        text: 'IMPORTE', 
                        align: 'center', 
                        cellsalign: 'right', 
                        dataField: 'dataImport', 
                        aggregates: [
                            { 'Total': function (aggregatedValue, currentValue, column, record) {
                                    var total = currentValue * parseInt(record['dataImport']);
                                    return aggregatedValue + total;
                                }
                            }
                        ], 
                        cellsformat: 'C2', 
                        width: 180, 
                        rendered: tooltiprenderer
                    },
                    { text: 'FECHA DE PAGO', align: 'center', cellsalign: 'center', dataField: 'dataDatePayment', width: 140, rendered: tooltiprenderer},
                    { text: 'FECHA DE CARGO', align: 'center', cellsalign: 'center', dataField: 'dataDateLoaded', width: 140, rendered: tooltiprenderer},
                    { text: 'BANCO', align: 'center', dataField: 'dataBank', width: 180, rendered: tooltiprenderer},
                    { text: 'MEDIO DE PAGO', align: 'center', dataField: 'dataPaymentMethod', width: 120, rendered: tooltiprenderer},
                    { text: 'FORMA DE PAGO', align: 'center', dataField: 'dataFormToPay', width: 120, rendered: tooltiprenderer},
                    { text: 'PLAZO', align: 'center', cellsalign: 'center', dataField: 'dataDayTerm', width: 80, rendered: tooltiprenderer},
                    { 
                        text: 'COMISIÓN', 
                        align: 'center', 
                        dataField: 'dataCommission', 
                        aggregates: [
                            { 'Total': function (aggregatedValue, currentValue, column, record) {
                                var total = currentValue * parseInt(record['dataCommission']);
                                return aggregatedValue + total;
                            }
                            }
                        ], 
                        width: 180, 
                        cellsformat: 'C2', 
                        rendered: tooltiprenderer
                    },
                    { 
                        text: 'SUBTOTAL', 
                        align: 'center', 
                        dataField: 'dataSubtotal', 
                        aggregates: [
                            { 'Total': function (aggregatedValue, currentValue, column, record) {
                                    var total = currentValue * parseInt(record['dataSubtotal']);
                                    return aggregatedValue + total;
                                }
                            }
                        ],  
                        width: 180, 
                        cellsformat: 'C2', 
                        rendered: tooltiprenderer
                    }
                ],
                columnsResize: false
            });
        }   
        loadGridImportedDataTemp();
    });
</script>
<div id='jqxExpanderImportData'>
    <div>Importar archivo csv delimitado por comas</div>
    <div>
        <div style="display: inline-block; width: 316px; height: 28px; position: relative;">
            <div style="float: left;">
                <div id="jqxFileUpload"></div>
            </div>
        </div>
        <br>
        <br>
        <img id="loading" style="display: none; width: 70px;margin-left: 115px;" src="../content/pictures-system/load.GIF">
        <strong id="messageUploadStatus" style="color: #fe5539;font-size: 18px;"></strong>
    </div>
</div>
<br>
<div id='jqxExpanderImportedDataTemp'>
    <div>Registros</div>
    <div>
        <div style="display: inline-block; margin-right: 5px;">
            <div id="tableImportedDataTemp"></div>
        </div>
    </div>
</div>