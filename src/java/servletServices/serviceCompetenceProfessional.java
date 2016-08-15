/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletServices;

import control.competenceProfessionalControl;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.competenceProfessionalModel;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author Lab5-E
 */
@WebServlet(name = "serviceCompetenceProfessional", urlPatterns = {"/serviceCompetenceProfessional"})
public class serviceCompetenceProfessional extends HttpServlet {

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
                JSONArray content = new JSONArray();
                try{
                    int pt_fk_type = Integer.parseInt(request.getParameter("pt_fk_type"));
                    int pt_pk_study_plann = Integer.parseInt(request.getParameter("pt_pk_study_plann"));
                    ArrayList<competenceProfessionalModel> listCompetences=new competenceProfessionalControl().SelectCompetenceProfessionals(pt_pk_study_plann, pt_fk_type);
                    
                    int i = 0;
                    for (competenceProfessionalModel competenceProfessionalMdl : listCompetences) {
                        i+=1;
                        JSONObject data = new JSONObject();
                        data.put("dataProgresivNumber", i);
                        data.put("dataPkCompetenceProfessional", competenceProfessionalMdl.getPK_COMPETENCE_PROFESSIONAL());
                        data.put("dataNameCompetences", competenceProfessionalMdl.getFL_CONCEPT());                    
                        data.put("dataPkStudyPlann", competenceProfessionalMdl.getStudyPlanMdl().getPK_STUDY_PLAN());
                        content.add(data);
                    }          
                }catch(Exception e){
                    content.add("{error: 'emptyParams'}");
                } 
                response.setContentType("application/json"); 
                out.print(content);
                out.flush(); 
                out.close();     
                
            }
            if(request.getParameter("insert")!=null){
                response.setContentType("application/json");
                JSONObject data = new JSONObject();
                try{
                    String pt_concept=request.getParameter("pt_concept");
                    int pt_fk_type = Integer.parseInt(request.getParameter("pt_fk_type"));
                    int pt_pk_study_plann = Integer.parseInt(request.getParameter("pt_pk_study_plann"));
                    data.put("status", new competenceProfessionalControl().InsertCompetenceProfessional(pt_concept, pt_fk_type, pt_pk_study_plann));                    
                }catch(Exception e){
                    data.put("error", "emptyParams");
                }       
                out.print(data);
            }
            if(request.getParameter("update")!=null){      
                response.setContentType("application/json"); 
                JSONObject data = new JSONObject();
                try{                    
                    String pt_concept=request.getParameter("pt_concept");
                    int pt_pk_competence_professional = Integer.parseInt(request.getParameter("pt_pk_competence_professional"));                     
                    data.put("status", new competenceProfessionalControl().UpdateCompetenceProfessional(pt_concept, pt_pk_competence_professional));                    
                }catch(Exception e){
                    data.put("error", "emptyParams");
                }       
                out.print(data);
            }
            if(request.getParameter("delete")!=null){   
                response.setContentType("application/json"); 
                JSONObject data = new JSONObject();
                try {
                    int pt_pk_competence_professional=Integer.parseInt(request.getParameter("pt_pk_competence_professional"));
                    data.put("status", new competenceProfessionalControl().DeleteCompetenceProfessional(pt_pk_competence_professional));
                } catch (Exception e) {
                    data.put("error", "emptyParams");
                }                    
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
