/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletServices;

import control.tempReportPaymentsGobControl;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.tempReportPaymentsGobModel;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author Lab5-E
 */
@WebServlet(name = "servicetempReportPaymentsGob", urlPatterns = {"/servicetempReportPaymentsGob"})
public class servicetempReportPaymentsGob extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            if(request.getParameter("view")!=null){
                ArrayList<tempReportPaymentsGobModel> listStudentsPenalityPayments;
                JSONArray principal = new JSONArray();
                JSONObject settings = new JSONObject();
                JSONArray content = new JSONArray();
                settings.put("__tempReportPaymentsGobModel","StudentsPenalityPayments");
                listStudentsPenalityPayments = new tempReportPaymentsGobControl().SelectReportPaymentsGob();
                for(int i=0;i<listStudentsPenalityPayments.size();i++){
                    JSONObject data = new JSONObject();
                    data.put("dataProgresivNumber", i+1);
                    data.put("dataPkTempReportPaymentGob", listStudentsPenalityPayments.get(i).getPK_TEMP_REPORT_PAYMENTS_GOB());
                    data.put("dataBank", listStudentsPenalityPayments.get(i).getFL_BANK());
                    data.put("dataCommission", listStudentsPenalityPayments.get(i).getFL_COMMISSION());
                    data.put("dataDateLoaded", listStudentsPenalityPayments.get(i).getFL_DATE_LOADED());
                    data.put("dataDatePayment", listStudentsPenalityPayments.get(i).getFL_DATE_PAYMENT());
                    data.put("dataDayTerm", listStudentsPenalityPayments.get(i).getFL_DAY_TERM());
                    data.put("dataFormToPay", listStudentsPenalityPayments.get(i).getFL_FORM_TO_PAY());
                    data.put("dataImport", listStudentsPenalityPayments.get(i).getFL_IMPORT());
                    data.put("dataOrganism", listStudentsPenalityPayments.get(i).getFL_ORGANISM());
                    data.put("dataPaymentMethod", listStudentsPenalityPayments.get(i).getFL_PAYMENT_METHOD());
                    data.put("dataReference", listStudentsPenalityPayments.get(i).getFL_REFERENCE());
                    data.put("dataStatusLoad", listStudentsPenalityPayments.get(i).getFL_STATUS_LOAD());
                    data.put("dataSubtotal", listStudentsPenalityPayments.get(i).getFL_SUBTOTAL());
                    content.add(data); 
                }
                settings.put("__ENTITIES", content);
                principal.add(settings);
                response.setContentType("application/json"); 
                out.print(principal);
                out.flush(); 
                out.close();
            }
            if(request.getParameter("uploadFileCSV")!=null){
                response.setContentType("application/json"); 
                JSONObject data = new JSONObject();
                String field_value;
                File file ;
                int maxFileSize = 5000 * 1024*50;
                int maxMemSize = 5000 * 1024*50;

                // Verify the content type
                String contentType = request.getContentType();

                if ((contentType.contains("multipart/form-data"))) {
                    DiskFileItemFactory factory = new DiskFileItemFactory();
                    // maximum size that will be stored in memory
                    factory.setSizeThreshold(maxMemSize);
                    // Location to save data that is larger than maxMemSize.

                    // Path
                    String path = "C:/temp/Loads-Paymenst/";
                    File filePath=new File(path);
                    if(filePath.exists()){
                        factory.setRepository(filePath);
                    }else{
                        filePath.mkdirs();
                        factory.setRepository(filePath);
                    }
                    // Create a new file upload handler
                    ServletFileUpload upload = new ServletFileUpload(factory);
                    // maximum file size to be uploaded.
                    upload.setSizeMax( maxFileSize );

                    try{ 
                        // Parse the request to get file items.
                        List fileItems = upload.parseRequest(request);
                        // Process the uploaded file items
                        Iterator i = fileItems.iterator();
                        while ( i.hasNext () ){
                            FileItem fi = (FileItem)i.next();
                            if ( !fi.isFormField () ) {
                                // Get the uploaded file parameters
                                String fieldName = fi.getFieldName();
                                String fileName = fi.getName();
                                boolean isInMemory = fi.isInMemory();
                                long sizeInBytes = fi.getSize();
                                // Write the file
                                if(sizeInBytes<=4194304){
                                    if( fileName.lastIndexOf("\\") >= 0 ){
                                        file = new File( path +""+ fieldName+".csv") ;
                                    }else{
                                        file = new File( path +""+ fieldName+".csv");
                                        //file = new File( filePath +"/"+ fileName.substring(fileName.lastIndexOf("\\")+1));
                                    }
                                    fi.write(file);
                                    //out.println("Archivo cargado en " +filePath +"");
                                    //Establecer los parametros a la BD
                                    String status = new tempReportPaymentsGobControl().InsertReportPaymentsGobOfFileCSV(path +""+ fieldName+".csv"); 
                                    data.put("status", status);
                                }else{
                                    data.put("status", "FileMuchLong");
                                }
                            }
                        }
                    }catch(Exception ex) {
                        data.put("status", ex);
                    }
                }else{
                    data.put("status", "FileNotExist");
                }
                out.print(data);
            }
            if(request.getParameter("delete")!=null){     
                response.setContentType("application/json"); 
                JSONObject data = new JSONObject();
                String status = new tempReportPaymentsGobControl().DeleteReportPaymentsGob();
                data.put("status", status);
                out.print(data);
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
