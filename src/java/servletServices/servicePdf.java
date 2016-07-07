/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletServices;

import control.connectionControl;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperRunManager;

/**
 *
 * @author Lab5-E
 */
@WebServlet(name = "servicePdf", urlPatterns = {"/servicePdf"})
public class servicePdf extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, JRException {
        HttpSession session = request.getSession();
        ServletContext application = request.getServletContext();
        if(request.getParameter("cedule")==null){
            if(session.getAttribute("logueadoCandidate") != null){
                //Parametros para realizar la conexión// 
                connectionControl connection=new connectionControl();
                //Establecemos la ruta del reporte//
                File reportFile = new File(application.getRealPath("content/data-jr/documentPreregister/preregisterPDF.jasper")); 
                //No enviamos parámetros porque nuestro reporte no los necesita asi que escriba 
                //cualquier cadena de texto ya que solo seguiremos el formato del método runReportToPdf// 
                Map parameters = new HashMap(); 
                parameters.put("pt_folio", session.getAttribute("folioSystem")); 
                //Enviamos la ruta del reporte, los parámetros y la conexión(objeto Connection)//        
                byte[] bytes = JasperRunManager.runReportToPdf(reportFile.getPath(), parameters, connection.getConexion()); 
                //Indicamos que la respuesta va a ser en formato PDF//
                response.setContentType("application/pdf");
                response.setHeader("Content-disposition","inline; filename=Documento-con-folio-"+ session.getAttribute("folioSystem")+".pdf" );
                response.setContentLength(bytes.length); 
                try (ServletOutputStream ouputStream = response.getOutputStream()) {
                    ouputStream.write(bytes, 0, bytes.length);

                    //Limpiamos y cerramos flujos de salida//
                    ouputStream.flush();
                } 
            }
        }else{
            if(request.getParameter("cedule").equals("session")){
                session.setAttribute("folioSystem", request.getParameter("folioSystem"));  
                try (PrintWriter out = response.getWriter()) {
                    out.print("Correcto");
                }
            }
            if(request.getParameter("cedule").equals("print")){
                if(session.getAttribute("folioSystem") != null){
                    //Parametros para realizar la conexión// 
                    connectionControl connection=new connectionControl();
                    //Establecemos la ruta del reporte//
                    File reportFile = new File(application.getRealPath("content/data-jr/documentPreregister/preregister-cedulePDF.jasper")); 
                    //No enviamos parámetros porque nuestro reporte no los necesita asi que escriba 
                    //cualquier cadena de texto ya que solo seguiremos el formato del método runReportToPdf// 
                    Map parameters = new HashMap(); 
                    parameters.put("pt_folio", session.getAttribute("folioSystem")); 
                    //Enviamos la ruta del reporte, los parámetros y la conexión(objeto Connection)//        
                    byte[] bytes = JasperRunManager.runReportToPdf(reportFile.getPath(), parameters, connection.getConexion()); 
                    //Indicamos que la respuesta va a ser en formato PDF//
                    response.setContentType("application/pdf");
                    response.setHeader("Content-disposition","inline; filename=Cedula-con-folio-"+ session.getAttribute("folioSystem")+".pdf" );
                    response.setContentLength(bytes.length); 
                    try (ServletOutputStream ouputStream = response.getOutputStream()) {
                        ouputStream.write(bytes, 0, bytes.length);

                        //Limpiamos y cerramos flujos de salida//
                        ouputStream.flush();
                    } 
                }else{
                    try (PrintWriter out = response.getWriter()) {
                        out.print("No existe un archivo de cédula en la sesión");
                    }
                }
            }else{
                response.sendRedirect("/admin");
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
        try {
            processRequest(request, response);
        } catch (JRException ex) {
            Logger.getLogger(servicePdf.class.getName()).log(Level.SEVERE, null, ex);
        }
        //response.sendRedirect("/");
        //response.sendRedirect("/");
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
        try {
            processRequest(request, response);
        } catch (JRException ex) {
            Logger.getLogger(servicePdf.class.getName()).log(Level.SEVERE, null, ex);
        }
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
