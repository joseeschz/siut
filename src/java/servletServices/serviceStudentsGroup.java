/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletServices;

import control.groupStudentControl;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.groupStudentModel;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author CARLOS
 */
@WebServlet(name = "serviceStudentsGroup", urlPatterns = {"/serviceStudentsGroup"})
public class serviceStudentsGroup extends HttpServlet {

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
                ArrayList<groupStudentModel> listGroupStudent;
                JSONArray principal = new JSONArray();
                JSONObject settings = new JSONObject();
                JSONArray content = new JSONArray();
                settings.put("__studentGroupModel","");
                if(request.getParameter("view").equals("consult")){
                    int fk_career = Integer.parseInt(request.getParameter("fkCareer"));
                    int fk_semester = Integer.parseInt(request.getParameter("fkSemester"));
                    int fk_group = Integer.parseInt(request.getParameter("fkGroup"));
                    int fk_subject_matter = Integer.parseInt(request.getParameter("fkSubjectMatter"));
                    int fk_period = Integer.parseInt(request.getParameter("fkPeriod"));
                    listGroupStudent = new groupStudentControl().SelectGroupStudent(fk_career, fk_semester, fk_group, fk_subject_matter, fk_period);
                    for(int i=0;i<listGroupStudent.size();i++){
                        JSONObject datos = new JSONObject();
                        datos.put("dataID", i+1);
                        datos.put("dataPkGroupMatterTeacherStudent", listGroupStudent.get(i).getPK_GROUP_MATTER_TEACHER());
                        datos.put("dataProgresivNumber", i+1);
                        datos.put("dataEnrollment", listGroupStudent.get(i).getFL_ENROLLMENT());
                        datos.put("dataStudentName", listGroupStudent.get(i).getFL_STUDENT_NAME());
                        datos.put("dataPkTutor", listGroupStudent.get(i).getFK_TUTOR_TEACHER());
                        content.add(datos); 
                    }
                }
                if(request.getParameter("view").equals("consultGroupStay")){
                    int fk_career = Integer.parseInt(request.getParameter("fkCareer"));
                    int fk_semester = Integer.parseInt(request.getParameter("fkSemester"));
                    int fk_group = Integer.parseInt(request.getParameter("fkGroup"));
                    int fk_subject_matter = Integer.parseInt(request.getParameter("fkSubjectMatter"));
                    int fk_period = Integer.parseInt(request.getParameter("fkPeriod"));
                    listGroupStudent = new groupStudentControl().SelectGroupStudent(fk_career, fk_semester, fk_group, fk_subject_matter, fk_period);
                    for(int i=0;i<listGroupStudent.size();i++){
                        JSONObject datos = new JSONObject();
                        datos.put("dataID", i+1);
                        datos.put("dataPkGroupMatterTeacherStudent", listGroupStudent.get(i).getPK_GROUP_MATTER_TEACHER());
                        datos.put("dataProgresivNumber", i+1);
                        datos.put("dataEnrollment", listGroupStudent.get(i).getFL_ENROLLMENT());
                        datos.put("dataStudentName", listGroupStudent.get(i).getFL_STUDENT_NAME());
                        datos.put("dataPkTutor", listGroupStudent.get(i).getFK_TUTOR_TEACHER());
                        datos.put("dataDeliveryDescription", "No entregado");
                        datos.put("dataDeliveryStatus", false);
                        content.add(datos); 
                    }
                }
                if(request.getParameter("view").equals("insert")){
                    for(int i=0;i<50;i++){
                        JSONObject datos = new JSONObject();
                        datos.put("dataID", i+1);
                        datos.put("dataPkGroupMatterTeacherStudent", null);
                        datos.put("dataProgresivNumber", i+1);
                        datos.put("dataEnrollment", "");
                        datos.put("dataStudentName", "");
                        content.add(datos); 
                    }
                }
                settings.put("__ENTITIES", content);
                principal.add(settings);
                response.setContentType("application/json"); 
                out.print(principal);
                out.flush(); 
                out.close();
            }
            if(request.getParameter("insert")!=null){
                if(request.getParameter("fkCareer") != null && request.getParameter("fkSemester") != null && request.getParameter("fkGroup") != null && request.getParameter("fkPeriod") != null && request.getParameter("fkTutor") != null && request.getParameter("fkTeacher") != null && request.getParameter("fkSubjectMatter") != null){
                    groupStudentModel dataGroupStudent=new groupStudentModel();
                    dataGroupStudent.setFK_CAREER(Integer.parseInt(request.getParameter("fkCareer")));
                    dataGroupStudent.setFK_SEMESTER(Integer.parseInt(request.getParameter("fkSemester")));
                    dataGroupStudent.setFK_GROUP(Integer.parseInt(request.getParameter("fkGroup")));
                    dataGroupStudent.setFK_PERIOD(Integer.parseInt(request.getParameter("fkPeriod")));
                    dataGroupStudent.setFK_TUTOR_TEACHER(Integer.parseInt(request.getParameter("fkTutor")));
                    dataGroupStudent.setFK_TEACHER(Integer.parseInt(request.getParameter("fkTeacher")));
                    dataGroupStudent.setFK_SUBJECT_MATTER(Integer.parseInt(request.getParameter("fkSubjectMatter")));
                    dataGroupStudent.setFL_ENROLLMENT(request.getParameter("enrollment"));
                    out.print(new groupStudentControl().InsertGroupStudent(dataGroupStudent));
                    out.flush(); 
                    out.close();
                }                
            }
            if(request.getParameter("update")!=null){       
                if(request.getParameter("fkCareer") != null && request.getParameter("fkSemester") != null && request.getParameter("fkGroup") != null && request.getParameter("fkPeriod") != null && request.getParameter("fkTutor") != null && request.getParameter("fkTeacher") != null && request.getParameter("fkSubjectMatter") != null){
                    groupStudentModel dataGroupStudent=new groupStudentModel();
                    dataGroupStudent.setFK_CAREER(Integer.parseInt(request.getParameter("fkCareer")));
                    dataGroupStudent.setFK_SEMESTER(Integer.parseInt(request.getParameter("fkSemester")));
                    dataGroupStudent.setFK_GROUP(Integer.parseInt(request.getParameter("fkGroup")));
                    dataGroupStudent.setFK_PERIOD(Integer.parseInt(request.getParameter("fkPeriod")));
                    dataGroupStudent.setFK_TUTOR_TEACHER(Integer.parseInt(request.getParameter("fkTutor")));
                    dataGroupStudent.setFK_TEACHER(Integer.parseInt(request.getParameter("fkTeacher")));
                    dataGroupStudent.setFK_SUBJECT_MATTER(Integer.parseInt(request.getParameter("fkSubjectMatter")));
                    dataGroupStudent.setFL_ENROLLMENT(request.getParameter("enrollment"));
                    out.print(new groupStudentControl().UpdateGroupStudent(dataGroupStudent));
                }                    
            }
            if(request.getParameter("delete")!=null){       
                if(request.getParameter("dataPkGroupMatterTeacherStudent") != null){
                    int dataPkGroupMatterTeacherStudent = Integer.parseInt(request.getParameter("dataPkGroupMatterTeacherStudent")); 
                    out.print(new groupStudentControl().DeleteGroupStudent(dataPkGroupMatterTeacherStudent));
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
