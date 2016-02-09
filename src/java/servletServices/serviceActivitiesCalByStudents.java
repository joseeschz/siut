/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletServices;

import control.activitiesByStudentsControl;
import control.activitiesToGroupControl;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.activitiesByStudentsModel;
import model.activitiesToGroupModel;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author Carlos
 */
@WebServlet(name = "serviceActivitiesCalByStudents", urlPatterns = {"/serviceActivitiesCalByStudents"})
public class serviceActivitiesCalByStudents extends HttpServlet {

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
                if(request.getParameter("view").equals("average")){
                    int pkCareer = Integer.parseInt(request.getParameter("pkCareer"));
                    int pkSemester = Integer.parseInt(request.getParameter("pkSemester"));
                    int pkGroup = Integer.parseInt(request.getParameter("pkGroup"));
                    int pkActivity = Integer.parseInt(request.getParameter("pkActivity"));
                    int pkPeriod = Integer.parseInt(request.getParameter("pkPeriod"));
                    ArrayList<activitiesToGroupModel> listActivityValMax=new activitiesToGroupControl().SelectActivityToGroup(pkActivity);
                    ArrayList<activitiesByStudentsModel> listActivity=new activitiesByStudentsControl().SelectActivitiesByStudents(pkCareer, pkSemester, pkGroup, pkActivity, pkPeriod);
                    JSONArray principal = new JSONArray();
                    JSONObject settings = new JSONObject();
                    JSONArray content = new JSONArray();
                    settings.put("__ActivityByStudent","ActivityByStudent");                    
                    for(int i=0;i<listActivity.size();i++){                        
                        JSONObject data = new JSONObject();
                        data.put("id", listActivity.get(i).getPK_ACTIVITY_BY_STUDENT());
                        data.put("dataProgresivNumber", i+1);
                        data.put("dataPkStudent", listActivity.get(i).getFK_STUDENT());
                        data.put("dataEnrollment", listActivity.get(i).getFL_ENROLLMENT());
                        data.put("dataNameStudent", listActivity.get(i).getFL_NAME_STUDENT());  
                        data.put("dataValueObtanied", listActivity.get(i).getFL_VALUE_OBTANIED());
                        if(listActivity.get(i).getFL_VALUE_OBTANIED().equals("Sin evaluar")){
                            data.put("dataValueObtaniedEquivalent", (Double.parseDouble("0")*10/listActivityValMax.get(0).getFL_VALUE_ACTIVITY()));
                        }else{
                            data.put("dataValueObtaniedEquivalent", (Double.parseDouble(listActivity.get(i).getFL_VALUE_OBTANIED())*10/listActivityValMax.get(0).getFL_VALUE_ACTIVITY()));
                        }                        
                        data.put("dataAcomulatedNow", listActivity.get(i).getFL_ACUMULATED_NOW());
                        content.add(data);                         
                    }
                    settings.put("__ENTITIES", content);                    
                    principal.add(settings);                    
                    response.setContentType("application/json"); 
                    out.print(principal);                    
                    out.flush(); 
                    out.close();
                }else if(request.getParameter("view").equals("regularization")){
                    int pkCareer = Integer.parseInt(request.getParameter("pkCareer"));
                    int pkSemester = Integer.parseInt(request.getParameter("pkSemester"));
                    int pkGroup = Integer.parseInt(request.getParameter("pkGroup"));
                    int pkActivity = Integer.parseInt(request.getParameter("pkActivity"));
                    int pkPeriod = Integer.parseInt(request.getParameter("pkPeriod"));
                    ArrayList<activitiesByStudentsModel> listActivity=new activitiesByStudentsControl().SelectActivitiesByStudentsRegularization(pkCareer, pkSemester, pkGroup, pkActivity, pkPeriod);
                    JSONArray principal = new JSONArray();
                    JSONObject settings = new JSONObject();
                    JSONArray content = new JSONArray();
                    settings.put("__ActivityByStudent","ActivityByStudent");
                    for(int i=0;i<listActivity.size();i++){
                        JSONObject data = new JSONObject();
                        data.put("id", listActivity.get(i).getPK_ACTIVITY_BY_STUDENT());
                        data.put("dataProgresivNumber", i+1);
                        data.put("dataEnrollment", listActivity.get(i).getFL_ENROLLMENT());
                        data.put("dataNameStudent", listActivity.get(i).getFL_NAME_STUDENT());
                        data.put("dataApproved", listActivity.get(i).getFL_APPROVED());
                        data.put("dataValueObtaniedOld", listActivity.get(i).getFL_VALUE_OBTANIED_OLD());
                        data.put("dataValueObtanied", listActivity.get(i).getFL_VALUE_OBTANIED());
                        data.put("dataAcomulatedNow", listActivity.get(i).getFL_ACUMULATED_NOW());
                        content.add(data); 
                    }
                    settings.put("__ENTITIES", content);
                    principal.add(settings);
                    response.setContentType("application/json"); 
                    out.print(principal);
                    out.flush(); 
                    out.close();
                }else if(request.getParameter("view").equals("global")){
                    int pkCareer = Integer.parseInt(request.getParameter("pkCareer"));
                    int pkSemester = Integer.parseInt(request.getParameter("pkSemester"));
                    int pkGroup = Integer.parseInt(request.getParameter("pkGroup"));
                    int pkActivity = Integer.parseInt(request.getParameter("pkActivity"));
                    int pkPeriod = Integer.parseInt(request.getParameter("pkPeriod"));
                    ArrayList<activitiesByStudentsModel> listActivity=new activitiesByStudentsControl().SelectActivitiesByStudentsGlobal(pkCareer, pkSemester, pkGroup, pkActivity, pkPeriod);
                    JSONArray principal = new JSONArray();
                    JSONObject settings = new JSONObject();
                    JSONArray content = new JSONArray();
                    settings.put("__ActivityByStudent","ActivityByStudent");
                    for(int i=0;i<listActivity.size();i++){
                        JSONObject data = new JSONObject();
                        data.put("id", listActivity.get(i).getPK_ACTIVITY_BY_STUDENT());
                        data.put("dataProgresivNumber", i+1);
                        data.put("dataEnrollment", listActivity.get(i).getFL_ENROLLMENT());
                        data.put("dataNameStudent", listActivity.get(i).getFL_NAME_STUDENT());
                        data.put("dataApproved", listActivity.get(i).getFL_APPROVED());
                        data.put("dataValueObtaniedOld", listActivity.get(i).getFL_VALUE_OBTANIED_OLD());
                        data.put("dataValueObtanied", listActivity.get(i).getFL_VALUE_OBTANIED());
                        data.put("dataAcomulatedNow", listActivity.get(i).getFL_ACUMULATED_NOW());
                        content.add(data); 
                    }
                    settings.put("__ENTITIES", content);
                    principal.add(settings);
                    response.setContentType("application/json"); 
                    out.print(principal);
                    out.flush(); 
                    out.close();
                }
            }
            if(request.getParameter("listActivitiesByPkStudent")!=null){
                int pkScale = Integer.parseInt(request.getParameter("pkScale"));
                int pkMatter = Integer.parseInt(request.getParameter("pkMatter"));
                int pkStudent = Integer.parseInt(request.getParameter("pkStudent"));
                ArrayList<activitiesByStudentsModel> listActivity=new activitiesByStudentsControl().SelectListActivitiesByStudent(pkStudent, pkMatter, pkScale, 0);
                JSONArray principal = new JSONArray();
                JSONObject settings = new JSONObject();
                JSONArray content = new JSONArray();
                settings.put("ActivityByStudentByMatter","ActivityByStudentByMatter");
                for(int i=0;i<listActivity.size();i++){
                    JSONObject data = new JSONObject();
                    data.put("id", listActivity.get(i).getPK_ACTIVITY_BY_STUDENT());
                    data.put("dataProgresivNumber", i+1);
                    data.put("dataFkScaleEvaluation", listActivity.get(i).getFK_SCALE_EVALUATION());
                    data.put("dataNameScale", listActivity.get(i).getFL_NAME_SCALE());
                    data.put("dataPkActivity", listActivity.get(i).getPK_ACTIVITY());
                    data.put("dataNameActivity", listActivity.get(i).getFL_NAME_ACTIVITY());
                    data.put("dataPkAvtivityByStudent", listActivity.get(i).getPK_ACTIVITY_BY_STUDENT());
                    data.put("dataValueObtanied", listActivity.get(i).getFL_VALUE_OBTANIED());
                    data.put("dataValueActivity", listActivity.get(i).getFL_VALUE_ACTIVITY());
                    content.add(data); 
                }
                settings.put("items", content);
                principal.add(settings);
                response.setContentType("application/json"); 
                out.print(settings);
                out.flush(); 
                out.close();
            }
            if(request.getParameter("listActivities")!=null){
                int pkScale = Integer.parseInt(request.getParameter("pkScale"));
                int pkMatter = Integer.parseInt(request.getParameter("pkMatter"));
                int pkStudent = Integer.parseInt(session.getAttribute("pkStudent").toString());
                ArrayList<activitiesByStudentsModel> listActivity=new activitiesByStudentsControl().SelectListActivitiesByStudents(pkStudent, pkMatter, pkScale, 0);
                JSONArray principal = new JSONArray();
                JSONObject settings = new JSONObject();
                JSONArray content = new JSONArray();
                settings.put("ActivityByStudentByMatter","ActivityByStudentByMatter");
                for(int i=0;i<listActivity.size();i++){
                    JSONObject data = new JSONObject();
                    data.put("id", listActivity.get(i).getPK_ACTIVITY_BY_STUDENT());
                    data.put("dataProgresivNumber", i+1);
                    data.put("dataFkScaleEvaluation", listActivity.get(i).getFK_SCALE_EVALUATION());
                    data.put("dataNameScale", listActivity.get(i).getFL_NAME_SCALE());
                    data.put("dataPkActivity", listActivity.get(i).getPK_ACTIVITY());
                    data.put("dataNameActivity", listActivity.get(i).getFL_NAME_ACTIVITY());
                    data.put("dataPkAvtivityByStudent", listActivity.get(i).getPK_ACTIVITY_BY_STUDENT());
                    data.put("dataValueObtanied", listActivity.get(i).getFL_VALUE_OBTANIED());
                    data.put("dataValueActivity", listActivity.get(i).getFL_VALUE_ACTIVITY());
                    content.add(data); 
                }
                settings.put("items", content);
                principal.add(settings);
                response.setContentType("application/json"); 
                out.print(settings);
                out.flush(); 
                out.close();
            }
            if(request.getParameter("insert")!=null){
                int pkCareer = Integer.parseInt(request.getParameter("pkCareer"));
                int pkSemester = Integer.parseInt(request.getParameter("pkSemester"));
                int pkGroup = Integer.parseInt(request.getParameter("pkGroup"));
                int pkMatter = Integer.parseInt(request.getParameter("pkMatter"));
                int pkActivity = Integer.parseInt(request.getParameter("pkActivity"));
                int pkPeriod = Integer.parseInt(request.getParameter("pkPeriod"));
                out.print(new activitiesByStudentsControl().InsertActivitiesByStudents(pkCareer, pkSemester, pkGroup, pkMatter, pkActivity, pkPeriod));
            }
            if(request.getParameter("update")!=null){
                int updateTypeEval=Integer.parseInt(request.getParameter("update"));
                int pkActivityByStudent = Integer.parseInt(request.getParameter("pkActivityByStudent"));
                double valueOptanied = Double.parseDouble(request.getParameter("valueOptanied"));
                out.print(new activitiesByStudentsControl().UpdateActivitiesByStudents(updateTypeEval, pkActivityByStudent, valueOptanied));
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
