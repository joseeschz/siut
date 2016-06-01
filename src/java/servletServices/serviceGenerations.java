/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletServices;

import control.generationsControl;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.generationsModel;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author CARLOS
 */
@WebServlet(name = "serviceGenerations", urlPatterns = {"/serviceGenerations"})
public class serviceGenerations extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            if(request.getParameter("view")!=null){
                ArrayList<generationsModel> listGenerations;
                JSONArray principal = new JSONArray();
                JSONObject settings = new JSONObject();
                JSONArray content = new JSONArray();
                int pkUser=0;
                settings.put("__generationsModel","Generations");
                if(request.getParameter("view").equals("combo")){                    
                    listGenerations = new generationsControl().SelectGenerations("byStatus");
                }else{
                    listGenerations = new generationsControl().SelectGenerations("byAll");
                }  
                for(int i=0;i<listGenerations.size();i++){
                    JSONObject data = new JSONObject();
                    data.put("dataProgresivNumber", i+1);
                    data.put("dataPkGenerations", listGenerations.get(i).getPK_GENERATION());
                    data.put("dataUnique", listGenerations.get(i).getFL_UNIQUE());
                    data.put("dataGenerationsName", listGenerations.get(i).getFL_GENERATION_NAME());
                    data.put("dataYearBegin", listGenerations.get(i).getFL_YEAR_BEGIN());
                    data.put("dataYearEnd", listGenerations.get(i).getFL_YEAR_END());
                    data.put("dataActive", listGenerations.get(i).getFL_STATUS_ACTIVE());
                    content.add(data); 
                }
                settings.put("__ENTITIES", content);
                principal.add(settings);
                response.setContentType("application/json"); 
                out.print(principal);
                out.flush(); 
                out.close();
            }
            if(request.getParameter("insert")!=null){
                generationsModel dataGenerations=new generationsModel();
                dataGenerations.setFL_YEAR_BEGIN(request.getParameter("pt_year_begin"));
                dataGenerations.setFL_YEAR_END(request.getParameter("pt_year_end"));
                out.print(new generationsControl().InsertGenerations(dataGenerations));             
            }
            if(request.getParameter("update")!=null){      
                if(request.getParameter("pkGenerations") != null){
                    generationsModel dataGenerations=new generationsModel();
                    dataGenerations.setPK_GENERATION(Integer.parseInt(request.getParameter("pkGenerations")));
                    dataGenerations.setFL_STATUS_ACTIVE(request.getParameter("pt_active"));
                    out.print(new generationsControl().UpdateGenerations(dataGenerations));
                }                
            }
            if(request.getParameter("delete")!=null){     
                if(request.getParameter("pt_pkGenerations") != null){
                    out.print(new generationsControl().DeleteGenerations(Integer.parseInt(request.getParameter("pt_pkGenerations"))));
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
