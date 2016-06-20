/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletServices;

import control.studentControl;
import control.tempReportPaymentsGobControl;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author Carlos
 */
@WebServlet(name = "serviceFile", urlPatterns = {"/serviceFile"})
public class serviceFile extends HttpServlet {

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
        HttpSession session = request.getSession();
        int pkStudent = 0;
        if(session.getAttribute("pkStudent")!=null){
            pkStudent = Integer.parseInt(session.getAttribute("pkStudent").toString());
        }
        if(request.getParameter("update")!=null){
            String field_name=request.getParameter("update");
            String field_value;
            try (PrintWriter out = response.getWriter()) {
                if(session.getAttribute("pkStudent")!=null){
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
                        String enrollment = session.getAttribute("enrollmentStudent").toString();
                        String path = "C:/temp/"+enrollment;
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
                                    if(sizeInBytes<=1048576){
                                        field_value=field_name.replace("fl_", "");
                                        if( fileName.lastIndexOf("\\") >= 0 ){
                                            file = new File( filePath +"/"+ field_value+".pdf") ;
                                        }else{
                                            file = new File( filePath +"/"+ field_value+".pdf");
                                            //file = new File( filePath +"/"+ fileName.substring(fileName.lastIndexOf("\\")+1));
                                        }
                                        fi.write(file);
                                        //out.println("Archivo cargado en " +filePath +"");
                                        //Establecer los parametros a la BD
                                        if(new studentControl().UpdateStudent(pkStudent, field_name, (path+"/"+field_value+".pdf")).equals("Datos Modificados")){
                                            out.print("Cargado");
                                        }else{
                                            out.print("Fail");
                                        }
                                    }else{
                                        out.print("File much long");
                                    }
                                }
                            }
                        }catch(Exception ex) {
                            out.println(ex);
                        }
                    }else{
                        out.println("<p>No existe un archivo en este campo</p>"); 
                    }
                }else{
                    response.sendRedirect("siut/alumnos.jsp");
                }
            }
        }
        if(request.getParameter("viewFile")!=null){
            try(ServletOutputStream out = response.getOutputStream()){                
                String fileType=request.getParameter("viewFile");                
                String enrollment = session.getAttribute("enrollmentStudent").toString();
                if(enrollment!=null){                    
                    String pdfPath = "C://temp/"+enrollment+"/"+fileType+".pdf";
                    File existFile = new File(pdfPath);
                    if(existFile.exists()){
                        ServletOutputStream  outs =  response.getOutputStream ();
                        response.setContentType( "application/pdf" ); 
                        File file=new File(pdfPath);

                        response.setHeader("Content-disposition","inline; filename=" +enrollment+"-"+fileType+".pdf" );

                        BufferedInputStream  bis = null; 
                        BufferedOutputStream bos = null;
                        try {
                            InputStream isr=new FileInputStream(file);
                            bis = new BufferedInputStream(isr);
                            bos = new BufferedOutputStream(outs);
                            byte[] buff = new byte[2048];
                            int bytesRead;
                            // Simple read/write loop.
                            while(-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
                                bos.write(buff, 0, bytesRead);
                            }
                        } 
                        catch(Exception e)
                        {
                            response.setContentType("text/html;charset=UTF-8");
                            out.println("Exception ----- Message ---"+e);
                        } 
                        finally {
                            if (bis != null) bis.close();
                            if (bos != null) bos.close();
                        }         
                    }else{
                        response.setContentType("text/html;charset=UTF-8");
                        out.print("Lo sentimos no se encuentra el archivo :(");
                    }
                }else{
                    response.sendRedirect("siut/alumnos.jsp");
                }
            }
        }
        //Load files of databases binary
        /*if(request.getParameter("viewFile")!=null){
            try(ServletOutputStream out = response.getOutputStream()){
                String file=request.getParameter("viewFile");
                byte[] pdfFile;
                pdfFile =new studentControl().SelectFile(file, pkStudent);
                if((pdfFile.length>0)){
                    response.setContentType("application/pdf");
                    out.write(pdfFile);
                }else{
                    out.print("<h1>No Hay Archivo en la Base de Datos</h1>");
                }   
                if(Arrays.toString(pdfFile).equals("null")){
                    out.print("<h1>Parametros incorrectos!</h1>");
                }                
            }
        }*/
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
