/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletServices;

import control.scaleEvaluationControl;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.scaleEvaluationModel;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author CARLOS
 */
@WebServlet(name = "serviceScaleEvaluation", urlPatterns = {"/serviceScaleEvaluation"})
public class serviceScaleEvaluation extends HttpServlet {

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
            response.setContentType("application/json"); 
            if(request.getParameter("view")!=null){
                int fkStudyLevel;
                ArrayList<scaleEvaluationModel> listScaleEvaluation;
                JSONArray principal = new JSONArray();
                JSONObject settings = new JSONObject();
                JSONArray  content = new JSONArray();
                settings.put("__serviceGroup","Group");
                if(request.getParameter("view").equals("combo")){
                    fkStudyLevel = Integer.parseInt(request.getParameter("fkStudyLevel"));
                    listScaleEvaluation = new scaleEvaluationControl().SelectScaleEvaluationByLevel(fkStudyLevel);
                    for(int i=0;i<listScaleEvaluation.size();i++){
                        JSONObject data = new JSONObject();
                        data.put("id", listScaleEvaluation.get(i).getPK_SCALE_EVALUATION());
                        data.put("dataProgresivNumber", i+1);
                        data.put("dataPkScaleEvalution", listScaleEvaluation.get(i).getPK_SCALE_EVALUATION());
                        data.put("dataNameScale", listScaleEvaluation.get(i).getFL_NAME_SCALE());
                        data.put("dataMaxValue", listScaleEvaluation.get(i).getFL_MAX_VALUE());
                        content.add(data); 
                    }                    
                }
                if(request.getParameter("view").equals("comboBloqued")){
                    int pkPeriod = Integer.parseInt(request.getParameter("pkPeriod"));
                    int pkTeacher = Integer.parseInt(session.getAttribute("pkUser").toString());
                    int pkSubjectMatter = Integer.parseInt(request.getParameter("pkSubjectMatter"));
                    listScaleEvaluation = new scaleEvaluationControl().SelectScaleEvaluationByLevelBloqued(pkPeriod, pkTeacher, pkSubjectMatter);
                    for(int i=0;i<listScaleEvaluation.size();i++){
                        JSONObject data = new JSONObject();
                        data.put("id", listScaleEvaluation.get(i).getPK_SCALE_EVALUATION());
                        data.put("dataProgresivNumber", i+1);
                        data.put("dataPkScaleEvalution", listScaleEvaluation.get(i).getPK_SCALE_EVALUATION());
                        data.put("dataNameScale", listScaleEvaluation.get(i).getFL_NAME_SCALE());
                        data.put("dataMaxValue", listScaleEvaluation.get(i).getFL_MAX_VALUE());
                        content.add(data); 
                    }
                }
                if(request.getParameter("view").equals("maxValueScale")){
                    int pkScaleEvaluation = Integer.parseInt(request.getParameter("pkScaleEvaluation"));
                    listScaleEvaluation = new scaleEvaluationControl().SelectValueScaleEvaluationByLevelBloqued(pkScaleEvaluation);
                    for(int i=0;i<listScaleEvaluation.size();i++){
                        JSONObject data = new JSONObject();
                        data.put("id", listScaleEvaluation.get(i).getPK_SCALE_EVALUATION());
                        data.put("dataProgresivNumber", i+1);
                        data.put("dataPkScaleEvalution", listScaleEvaluation.get(i).getPK_SCALE_EVALUATION());
                        data.put("dataNameScale", listScaleEvaluation.get(i).getFL_NAME_SCALE());
                        data.put("dataMaxValue", listScaleEvaluation.get(i).getFL_MAX_VALUE());
                        content.add(data); 
                    }
                    out.print(content);
                    out.flush(); 
                    out.close();
                }
                if(request.getParameter("view").equals("comboBloquedStudent")){
                    int pkMatter = Integer.parseInt(request.getParameter("pkMatter"));
                    listScaleEvaluation = new scaleEvaluationControl().SelectScaleEvaluationByLevelBloquedStudent(pkMatter);
                    for(int i=0;i<listScaleEvaluation.size();i++){
                        JSONObject data = new JSONObject();
                        data.put("id", listScaleEvaluation.get(i).getPK_SCALE_EVALUATION());
                        data.put("dataProgresivNumber", i+1);
                        data.put("dataPkScaleEvalution", listScaleEvaluation.get(i).getPK_SCALE_EVALUATION());
                        data.put("dataNameScale", listScaleEvaluation.get(i).getFL_NAME_SCALE());
                        data.put("dataMaxValue", listScaleEvaluation.get(i).getFL_MAX_VALUE());
                        content.add(data); 
                    }
                }
                response.setHeader("Access-Control-Allow-Origin", "*");
                response.setHeader("Access-Control-Allow-Methods", "POST,PUT, GET, OPTIONS, DELETE");
                response.setHeader("Access-Control-Max-Age", "3600");
                response.setHeader("Access-Control-Allow-Headers"," Origin, X-Requested-With, Content-Type, Accept,AUTH-TOKEN");
                response.setContentType("application/json");
                settings.put("__ENTITIES", content);
                principal.add(settings);
                out.print(principal);
                out.flush(); 
                out.close();
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
