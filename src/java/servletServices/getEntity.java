/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletServices;

import control.entityControl;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.entityModel;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author CARLOS
 */
@WebServlet(name = "getEntity", urlPatterns = {"/getEntity"})
public class getEntity extends HttpServlet {

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
                String action = request.getParameter("action");                
                ArrayList<entityModel> listEntity=new entityControl().SelectEntity(action);
                JSONArray principal = new JSONArray();
                JSONObject settings = new JSONObject();
                JSONArray content = new JSONArray();
                settings.put("__entityModel","Estates");
                if(request.getParameter("view").equals("combo")){
                    JSONObject datos = new JSONObject();
                    datos.put("id", 0);
                    datos.put("dataProgresivNumber",0);
                    datos.put("dataPkEntity","0");
                    datos.put("dataNameEntity", "SELECCIONAR");
                    content.add(datos); 
                }  
                for(int i=0;i<listEntity.size();i++){
                    JSONObject datos = new JSONObject();
                    datos.put("id", listEntity.get(i).getPK_ENTITY());
                    datos.put("dataProgresivNumber", i+1);
                    datos.put("dataPkEntity", listEntity.get(i).getPK_ENTITY());
                    datos.put("dataNameEntity", listEntity.get(i).getFL_NAME_ENTITY());
                    content.add(datos); 
                }
                settings.put("__ENTITIES", content);
                principal.add(settings);
                response.setContentType("application/json"); 
                out.print(principal);
                out.flush(); 
                out.close();
                listEntity.clear();
            }
            if(request.getParameter("insert")!=null){
                if(request.getParameter("nameEntity") != null){
                    entityModel dataEntity=new entityModel();
                    dataEntity.setFL_NAME_ENTITY(request.getParameter("nameEntity"));
                    out.print(new entityControl().InsertEntity(dataEntity));
                }                
            }
            if(request.getParameter("update")!=null){       
                if(request.getParameter("nameEntity") != null && request.getParameter("pkEntity") != null){
                    entityModel dataEntity=new entityModel();
                    dataEntity.setPK_ENTITY(Integer.parseInt(request.getParameter("pkEntity")));
                    dataEntity.setFL_NAME_ENTITY(request.getParameter("nameEntity"));
                    out.print(new entityControl().UpdateEntity(dataEntity));
                }                
            }
            if(request.getParameter("delete")!=null){       
                if(request.getParameter("pkEntity") != null){
                    out.print(new entityControl().DeleteEntity(Integer.parseInt(request.getParameter("pkEntity"))));
                }                
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
