/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletServices;

import control.lowOfStudentControl;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.lowOfStudentModel;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author Lab5-E
 */
@WebServlet(name = "serviceLowOfStudent", urlPatterns = {"/serviceLowOfStudent"})
public class serviceLowOfStudent extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            if(request.getParameter("selectStudentsLowsTempsES")!=null){
                int fkPeriod = Integer.parseInt(request.getParameter("fkPeriod"));
                ArrayList<lowOfStudentModel> listStudents=new lowOfStudentControl().SelectStudentsLowsES(fkPeriod);  
                JSONArray content = new JSONArray();
                listStudents.stream().map((lowOfStudentMdl) -> {
                    JSONObject data = new JSONObject();
                    data.put("dataPkLowStundet", lowOfStudentMdl.getPK_LOW_STUDENT());
                    data.put("dataPkStudent", lowOfStudentMdl.getStudentMdl().getPK_STUDENT());                    
                    data.put("dataName", lowOfStudentMdl.getStudentMdl().getFL_NAME());
                    data.put("dataEnrollment", lowOfStudentMdl.getStudentMdl().getFL_ENROLLMENT());
                    if(lowOfStudentMdl.getStudentMdl().getFL_DOWN()==1){
                        data.put("dataDown", "Si");
                    }else{
                        data.put("dataDown", "No");
                    }
                    data.put("dataStatusES", lowOfStudentMdl.getFL_STATUS_ES());
                    data.put("dataCareer", lowOfStudentMdl.getCareerMdl().getFL_NAME_ABBREVIATED());
                    data.put("dataSemester", lowOfStudentMdl.getSemesterMdl().getFL_NAME_SEMESTER());
                    data.put("dataGroup", lowOfStudentMdl.getGroupMdl().getFL_NAME_GROUP());
                    return data;
                }).forEach((data) -> {
                    content.add(data);
                });
              
                response.setContentType("application/json"); 
                out.print(content);
                out.flush(); 
                out.close();               
            }
            if(request.getParameter("selectStudentsLowsTempsDirector")!=null){
                int fkCareer = Integer.parseInt(request.getParameter("fkCareer"));
                int fkPeriod = Integer.parseInt(request.getParameter("fkPeriod"));
                ArrayList<lowOfStudentModel> listStudents=new lowOfStudentControl().SelectStudentsLowsDirector(fkCareer, fkPeriod);
  
                JSONArray content = new JSONArray();
                listStudents.stream().map((lowOfStudentMdl) -> {
                    JSONObject data = new JSONObject();
                    data.put("dataPkLowStundet", lowOfStudentMdl.getPK_LOW_STUDENT());
                    data.put("dataPkStudent", lowOfStudentMdl.getStudentMdl().getPK_STUDENT());                    
                    data.put("dataName", lowOfStudentMdl.getStudentMdl().getFL_NAME());
                    data.put("dataEnrollment", lowOfStudentMdl.getStudentMdl().getFL_ENROLLMENT());
                    if(lowOfStudentMdl.getStudentMdl().getFL_DOWN()==1){
                        data.put("dataDown", "Si");
                    }else{
                        data.put("dataDown", "No");
                    }
                    data.put("dataStatusES", lowOfStudentMdl.getFL_STATUS_ES());
                    data.put("dataSemester", lowOfStudentMdl.getSemesterMdl().getFL_NAME_SEMESTER());
                    data.put("dataGroup", lowOfStudentMdl.getGroupMdl().getFL_NAME_GROUP());
                    return data;
                }).forEach((data) -> {
                    content.add(data);
                });
              
                response.setContentType("application/json"); 
                out.print(content);
                out.flush(); 
                out.close();               
            }
            if(request.getParameter("selectStudentsLowsTemps")!=null){
                int fkCareer = Integer.parseInt(request.getParameter("fkCareer"));
                int fkSemester = Integer.parseInt(request.getParameter("fkSemester"));
                int fkGroup = Integer.parseInt(request.getParameter("fkGroup"));
                int fkPeriod = Integer.parseInt(request.getParameter("fkPeriod"));
                ArrayList<lowOfStudentModel> listStudents=new lowOfStudentControl().SelectStudentsLows(fkCareer, fkSemester, fkGroup, fkPeriod);
  
                JSONArray content = new JSONArray();
                listStudents.stream().map((lowOfStudentMdl) -> {
                    JSONObject data = new JSONObject();
                    data.put("dataPkLowStundet", lowOfStudentMdl.getPK_LOW_STUDENT());
                    data.put("dataPkStudent", lowOfStudentMdl.getStudentMdl().getPK_STUDENT());                    
                    data.put("dataName", lowOfStudentMdl.getStudentMdl().getFL_NAME());
                    data.put("dataEnrollment", lowOfStudentMdl.getStudentMdl().getFL_ENROLLMENT());
                    if(lowOfStudentMdl.getStudentMdl().getFL_DOWN()==1){
                        data.put("dataDown", "Si");
                    }else{
                        data.put("dataDown", "No");
                    }
                    data.put("dataStatusDir", lowOfStudentMdl.getFL_STATUS_DIR());
                    data.put("dataStatusES", lowOfStudentMdl.getFL_STATUS_ES());
                    return data;
                }).forEach((data) -> {
                    content.add(data);
                });
              
                response.setContentType("application/json"); 
                out.print(content);
                out.flush(); 
                out.close();               
            }
            if(request.getParameter("view")!=null){          
                int pk_student=Integer.parseInt(request.getParameter("pt_pk_student"));
                int pk_period=Integer.parseInt(request.getParameter("pt_pk_period"));
                ArrayList<lowOfStudentModel> allData=new lowOfStudentControl().SelectLowOfStudent(pk_student, pk_period);
                JSONArray content = new JSONArray();
                allData.stream().forEach(lowStudentMdl -> {
                    JSONObject data = new JSONObject();
                    data.put("pk_low_student",lowStudentMdl.getPK_LOW_STUDENT());
                    data.put("fl_folio_low",lowStudentMdl.getFL_FOLIO_LOW());
                    data.put("fl_autorization_date",lowStudentMdl.getFL_AUTORIZATION_DATE());
                    if(lowStudentMdl.isFL_HAS_SCHOOLARSHIP()){
                        data.put("fl_has_schoolarshipYes", true);
                        data.put("fl_has_schoolarshipNot", false);
                    }else{
                        data.put("fl_has_schoolarshipNot", true);
                        data.put("fl_has_schoolarshipYes", false);
                    }                    
                    data.put("pk_schoolarship_student",lowStudentMdl.getSchoolarshipStudentsMdl().getPK_SCHOOLARSHIP_STUDENT());
                    
                    if(lowStudentMdl.isFL_HAS_DEBT()){
                        data.put("fl_has_debtYes", true);
                        data.put("fl_has_debtNot", false);
                    }else{
                        data.put("fl_has_debtNot", true);
                        data.put("fl_has_debtYes", false);
                    }   
                    data.put("pk_debt",lowStudentMdl.getDebtMdl().getPK_DEBT());
                    data.put("pk_student",lowStudentMdl.getStudentMdl().getPK_STUDENT());
                    data.put("fl_name_student",lowStudentMdl.getStudentMdl().getFL_NAME());
                    data.put("fl_enrollment",lowStudentMdl.getStudentMdl().getFL_ENROLLMENT());
                    data.put("fl_career",lowStudentMdl.getCareerMdl().getFL_NAME_CAREER());
                    data.put("fl_group",lowStudentMdl.getGroupMdl().getFL_NAME_GROUP());
                    if(lowStudentMdl.isFL_ULTIMATE_LOW()){
                        data.put("fl_ultimate_lowYes", true);
                        data.put("fl_ultimate_lowNot", false);
                    }else{
                        data.put("fl_ultimate_lowNot", true);
                        data.put("fl_ultimate_lowYes", false);
                    }  
                    if(lowStudentMdl.isFL_TEMPORALY_LOW()){
                        data.put("fl_temporaly_lowYes", true);
                        data.put("fl_temporaly_lowNot", false);
                    }else{
                        data.put("fl_temporaly_lowNot", true);
                        data.put("fl_temporaly_lowYes", false);
                    }  
                    if(lowStudentMdl.isFL_REQUEST_FOR_STUDENT()){
                        data.put("fl_request_for_studentYes", true);
                        data.put("fl_request_for_studentNot", false);
                    }else{
                        data.put("fl_request_for_studentNot", true);
                        data.put("fl_request_for_studentYes", false);
                    }
                    data.put("fl_repprobed",lowStudentMdl.isFL_REPPROBED());
                    data.put("fl_background_academics_student",lowStudentMdl.isFL_BACKGROUND_ACADEMICS_STUDENT());
                    data.put("fl_utsem_not_first_option",lowStudentMdl.isFL_UTSEM_NOT_FIRST_OPTION());
                    data.put("fl_mistakes_regulation_school",lowStudentMdl.isFL_MISTAKES_REGULATION_SCHOOL());
                    data.put("fl_difficulty_matters_school",lowStudentMdl.isFL_DIFFICULTY_MATTERS_SCHOOL());
                    data.put("fl_that_matters",lowStudentMdl.getFL_THAT_MATTERS());
                    data.put("fl_absence",lowStudentMdl.isFL_ABSENCE());
                    data.put("fl_dissatisfaction_of_expectations",lowStudentMdl.isFL_DISSATISFACTION_OF_EXPECTATIONS());
                    data.put("fl_deficient_orientation_vocational",lowStudentMdl.isFL_DEFICIENT_ORIENTATION_VOCATIONAL());
                    data.put("fl_career_not_first_option",lowStudentMdl.isFL_CAREER_NOT_FIRST_OPTION());
                    data.put("fl_others_factors_academics",lowStudentMdl.isFL_OTHERS_FACTORS_ACADEMICS());
                    data.put("fl_that_others_factors_academics",lowStudentMdl.getFL_THAT_OTHERS_FACTORS_ACADEMICS());
                    data.put("fl_situation_economic_unfavorable",lowStudentMdl.isFL_SITUATION_ECONOMIC_UNFAVORABLE());
                    data.put("fl_student_work",lowStudentMdl.isFL_STUDENT_WORK());
                    data.put("fl_marriage_affects_situation_economic",lowStudentMdl.isFL_MARRIAGE_AFFECTS_SITUATION_ECONOMIC());
                    data.put("fl_problems_bad_nutrition",lowStudentMdl.isFL_PROBLEMS_BAD_NUTRITION());
                    data.put("fl_loss_employment_who_depends_student",lowStudentMdl.isFL_LOSS_EMPLOYMENT_WHO_DEPENDS_STUDENT());
                    data.put("fl_incompatibility_of_schedules_work_studies",lowStudentMdl.isFL_INCOMPATIBILITY_OF_SCHEDULES_WORK_STUDIES());
                    data.put("fl_change_residence",lowStudentMdl.isFL_CHANGE_RESIDENCE());
                    data.put("fl_features_socioculturales_student",lowStudentMdl.isFL_FEATURES_SOCIOCULTURALES_STUDENT());
                    data.put("fl_lack_motivation",lowStudentMdl.isFL_LACK_MOTIVATION());
                    data.put("fl_distance_of_utsem",lowStudentMdl.isFL_DISTANCE_OF_UTSEM());
                    data.put("fl_problems_health",lowStudentMdl.isFL_PROBLEMS_HEALTH());
                    data.put("fl_not_present_classes",lowStudentMdl.isFL_NOT_PRESENT_CLASSES());
                    data.put("fl_problems_with_collagues_of_class",lowStudentMdl.isFL_PROBLEMS_WITH_COLLAGUES_OF_CLASS());
                    data.put("fl_problems_emotionals",lowStudentMdl.isFL_PROBLEMS_EMOTIONALS());
                    data.put("fl_addictions",lowStudentMdl.isFL_ADDICTIONS());
                    data.put("fl_problems_with_teachers",lowStudentMdl.isFL_PROBLEMS_WITH_TEACHERS());
                    data.put("fl_others_factors_personals",lowStudentMdl.isFL_OTHERS_FACTORS_PERSONALS());
                    data.put("fl_that_others_factors_personals",lowStudentMdl.getFL_THAT_OTHERS_FACTORS_PERSONALS());
                    data.put("fl_name_worker_director",lowStudentMdl.getWorkerDirectorMdl().getFL_NAME_WORKER());
                    data.put("fl_name_worker_tutor",lowStudentMdl.getWorkerTutorMdl().getFL_NAME_WORKER());
                    data.put("fl_name_worker_es",lowStudentMdl.getWorkerESMdl().getFL_NAME_WORKER());
                    data.put("fl_name_worker_cp",lowStudentMdl.getWorkerCPMdl().getFL_MATERN_NAME());
                    data.put("pk_period",lowStudentMdl.getPeriodMdl().getPK_PERIOD());
                    data.put("fl_authorization_director",lowStudentMdl.isFL_AUTHORIZATION_DIRECTOR());
                    data.put("fl_authorization_es",lowStudentMdl.isFL_AUTHORIZATION_ES());                                        
                    content.add(data);
                });
                response.setContentType("application/json"); 
                out.print(content);
                out.flush(); 
                out.close();
            }
            if(request.getParameter("insert")!=null){
                response.setContentType("application/json"); 
                if(request.getParameter("pt_pk_student") != null){
                    JSONObject data = new JSONObject();
                    int pk_student=Integer.parseInt(request.getParameter("pt_pk_student"));
                    int pk_period=Integer.parseInt(request.getParameter("pt_pk_period"));
                    data.put("status", new lowOfStudentControl().InsertLowOfStudent(pk_student, pk_period));
                    out.print(data);
                }                
            }
            if(request.getParameter("update")!=null){      
                response.setContentType("application/json"); 
                if(request.getParameter("pt_pk_low_student") != null && request.getParameter("pt_field_name") != null && request.getParameter("pt_field_value") != null){
                    JSONObject data = new JSONObject();
                    int pk_low_student=Integer.parseInt(request.getParameter("pt_pk_low_student"));
                    String field_name = request.getParameter("pt_field_name");
                    String field_value = request.getParameter("pt_field_value");
                    data.put("status", new lowOfStudentControl().UpdateLowOfStudent(pk_low_student, field_name, field_value));
                    out.print(data);
                }                
            }
            if(request.getParameter("delete")!=null){   
                response.setContentType("application/json"); 
                if(request.getParameter("pt_pk_low_student") != null){
                    JSONObject data = new JSONObject();
                    int pk_low_student=Integer.parseInt(request.getParameter("pt_pk_low_student"));
                    data.put("status", new lowOfStudentControl().DeleteLowOfStudent(pk_low_student));
                    out.print(data);
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
