/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletServices;

import control.studyPlanControl;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.studyPlanModel;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author CARLOS
 */
@WebServlet(name = "serviceStudyPlan", urlPatterns = {"/serviceStudyPlan"})
public class serviceStudyPlan extends HttpServlet {

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
                int fkCareer = Integer.parseInt(request.getParameter("fkCareer"));
                ArrayList<studyPlanModel> listStudyPlan;
                JSONArray principal = new JSONArray();
                JSONObject settings = new JSONObject();
                JSONArray content = new JSONArray();
                settings.put("__serviceStudyPlanModel","StudyPlan");
                if(request.getParameter("view").equals("combo")){
                    listStudyPlan=new studyPlanControl().SelectStudyPlan(fkCareer);
                }else{
                    listStudyPlan=new studyPlanControl().SelectStudyPlan(fkCareer);
                }  
                for(int i=0;i<listStudyPlan.size();i++){
                    JSONObject data = new JSONObject();
                    data.put("id", listStudyPlan.get(i).getPK_STUDY_PLAN());
                    data.put("dataProgresivNumber", i+1);
                    data.put("dataPkStudyPlan", listStudyPlan.get(i).getPK_STUDY_PLAN());
                    data.put("dataNameStudyPlan", listStudyPlan.get(i).getFL_NAME_PLAN());
                    data.put("dataFkCareer", listStudyPlan.get(i).getFK_CAREER());
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
                if(request.getParameter("fkCareer") != null){
                    studyPlanModel dataStudyPlan=new studyPlanModel();
                    dataStudyPlan.setFL_NAME_PLAN(request.getParameter("nameStudyPlan"));
                    dataStudyPlan.setFK_CAREER(Integer.parseInt(request.getParameter("fkCareer")));
                    out.print(new studyPlanControl().InsertStudyPlan(dataStudyPlan));
                }                
            }
            if(request.getParameter("update")!=null){       
                if(request.getParameter("pkStudyPlan") != null && request.getParameter("fkCareer") != null){
                    studyPlanModel dataStudyPlan=new studyPlanModel();
                    dataStudyPlan.setPK_STUDY_PLAN(Integer.parseInt(request.getParameter("pkStudyPlan")));
                    dataStudyPlan.setFL_NAME_PLAN(request.getParameter("nameStudyPlan"));
                    dataStudyPlan.setFK_CAREER(Integer.parseInt(request.getParameter("fkCareer")));
                    out.print(new studyPlanControl().UpdateStudyPlan(dataStudyPlan));
                }                
            }
            if(request.getParameter("delete")!=null){       
                if(request.getParameter("pkStudyPlan") != null){
                    int pkStudyPlan = Integer.parseInt(request.getParameter("pkStudyPlan"));
                    out.print(new studyPlanControl().DeleteStudyPlan(pkStudyPlan));
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
