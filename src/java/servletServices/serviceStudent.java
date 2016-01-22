/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletServices;

import control.mailControl;
import control.studentControl;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.studentModel;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author CARLOS
 */
@WebServlet(name = "serviceStudent", urlPatterns = {"/serviceStudent"})
public class serviceStudent extends HttpServlet {

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
            if(request.getParameter("generateEnrollment")!=null){
                String period = request.getParameter("period");
                out.print(new studentControl().GenerateEnrollment(period));   
            }
            if(request.getParameter("consultAllEnrollments")!=null){
                ArrayList<studentModel> listStudent=new studentControl().SelectEnrollments();
                JSONArray principal = new JSONArray();
                JSONObject settings = new JSONObject();
                JSONArray content = new JSONArray();
                settings.put("__entityModel","Matriculas");
                for(int i=0;i<listStudent.size();i++){
                    JSONObject datos = new JSONObject();
                    datos.put("id", listStudent.get(i).getPK_STUDENT());
                    datos.put("dataProgresivNumber", i+1);
                    datos.put("dataNameEnrollment", listStudent.get(i).getFL_ENROLLMENT());
                    content.add(datos); 
                }
                settings.put("__ENTITIES", content);
                principal.add(settings);
                response.setContentType("application/json"); 
                out.print(principal);
                out.flush(); 
                out.close();
            }
            if(request.getParameter("selectStudent")!=null){
                String enrollment = request.getParameter("enrollment");
                ArrayList<studentModel> listStudent=new studentControl().SelectStudent(enrollment, "onlyDataBasic");
                JSONObject datos = new JSONObject();
                for(int i=0;i<listStudent.size();i++){
                    datos.put("id", listStudent.get(i).getPK_STUDENT());
                    datos.put("dataProgresivNumber", i+1);
                    datos.put("dataName", listStudent.get(i).getFL_NAME());
                    datos.put("dataEnrollment", listStudent.get(i).getFL_ENROLLMENT());
                    datos.put("dataModify", listStudent.get(i).getFL_MODIFY());
                    datos.put("dataPaternName", listStudent.get(i).getFL_PATERN_NAME());
                    datos.put("dataMaternName", listStudent.get(i).getFL_MATERN_NAME());
                    datos.put("dataPkLevelStudy", listStudent.get(i).getPK_LEVEL_STUDY());
                    datos.put("dataFkCareer", listStudent.get(i).getFK_CAREER());
                    datos.put("dataPkEntity", listStudent.get(i).getPK_ENTITY());
                    datos.put("dataPkMunicipality", listStudent.get(i).getPK_MUNICIPALITY());
                    datos.put("dataPkLocality", listStudent.get(i).getPK_LOCALITY());
                    datos.put("dataFkPreparatory", listStudent.get(i).getFK_PREPARATORY());
                    response.setContentType("application/json"); 
                    out.print(datos);
                    out.flush(); 
                    out.close();
                }                
            }
            if(request.getParameter("selectStudentByPkStudent")!=null){
                String enrrollmentStudent="";
                if(session.getAttribute("enrrollmentStudent")!=null){
                    enrrollmentStudent=session.getAttribute("enrrollmentStudent").toString();
                }
                if(request.getParameter("enrrollmentStudent")!=null){
                    enrrollmentStudent=request.getParameter("enrrollmentStudent");
                }
                ArrayList<studentModel> listStudent=new studentControl().SelectStudent(enrrollmentStudent, "allData");
                JSONObject datos = new JSONObject();
                for(int i=0;i<listStudent.size();i++){
                    datos.put("pk_student", listStudent.get(i).getPK_STUDENT());
                    datos.put("fl_enrollment", listStudent.get(i).getFL_ENROLLMENT());
                    datos.put("fk_career", listStudent.get(i).getFK_CAREER());
                    datos.put("fk_entity", listStudent.get(i).getPK_ENTITY());
                    datos.put("fk_municipality", listStudent.get(i).getPK_MUNICIPALITY());
                    datos.put("fk_locality", listStudent.get(i).getPK_LOCALITY());
                    datos.put("fk_preparatory", listStudent.get(i).getFK_PREPARATORY());
                    datos.put("fl_register_date", listStudent.get(i).getFL_REGISTER_DATE());
                    datos.put("fl_utsem_folio", listStudent.get(i).getFL_UTSEM_FOLIO());
                    datos.put("fl_ceneval_folio", listStudent.get(i).getFL_CENEVAL_FOLIO());
                    datos.put("fl_name", listStudent.get(i).getFL_NAME());
                    datos.put("fl_matern_name", listStudent.get(i).getFL_MATERN_NAME());
                    datos.put("fl_patern_name", listStudent.get(i).getFL_PATERN_NAME());
                    datos.put("fl_date_born", listStudent.get(i).getFL_DATE_BORN());
                    datos.put("fl_gender", listStudent.get(i).getFL_GENDER());
                    datos.put("fl_photography", listStudent.get(i).getFL_PHOTOGRAPHY());
                    datos.put("fl_maritial_status", listStudent.get(i).getFL_MARITIAL_STATUS());
                    datos.put("fl_working", listStudent.get(i).getFL_WORKING());
                    datos.put("fl_bacherol_type", listStudent.get(i).getFL_BACHEROL_TYPE());
                    datos.put("fl_school_type", listStudent.get(i).getFL_SCHOOL_TYPE());
                    datos.put("fl_above_average", listStudent.get(i).getFL_ABOVE_AVERAGE());
                    datos.put("fl_period_bacherol", listStudent.get(i).getFL_PERIOD_BACHEROL());
                    datos.put("fl_file_id_oficial", ""/*listStudent.get(i).getFL_FILE_ID_OFICIAL()*/);
                    datos.put("fl_file_document_born", ""/* listStudent.get(i).getFL_FILE_DOCUMENT_BORN()*/);
                    datos.put("fl_curp", listStudent.get(i).getFL_CURP());
                    datos.put("fl_file_curp", ""/*listStudent.get(i).getFL_FILE_CURP()*/);
                    datos.put("fk_born_entity", listStudent.get(i).getFK_BORN_ENTITY());
                    datos.put("fk_born_municipality", listStudent.get(i).getFK_BORN_MUNICIPALITY());
                    datos.put("fk_born_locality", listStudent.get(i).getFK_BORN_LOCALITY());
                    datos.put("fl_name_street", listStudent.get(i).getFL_NAME_STREET());
                    datos.put("fl_external_number", listStudent.get(i).getFL_EXTERNAL_NUMBER());
                    datos.put("fl_internal_number", listStudent.get(i).getFL_INTERNAL_NUMBER());
                    datos.put("fl_between_street1", listStudent.get(i).getFL_BETWEEN_STREET1());
                    datos.put("fl_between_street2", listStudent.get(i).getFL_BETWEEN_STREET2());
                    datos.put("fl_reference", listStudent.get(i).getFL_REFERENCE());
                    datos.put("fk_current_entity", listStudent.get(i).getFK_CURRENT_ENTITY());
                    datos.put("fk_current_municipality", listStudent.get(i).getFK_CURRENT_MUNICIPALITY());
                    datos.put("fk_current_locality", listStudent.get(i).getFK_CURRENT_LOCALITY());
                    datos.put("fl_current_colony", listStudent.get(i).getFL_CURRENT_COLONY());
                    datos.put("fl_zip_code", listStudent.get(i).getFL_ZIP_CODE());
                    datos.put("fl_phone_home", listStudent.get(i).getFL_PHONE_HOME());
                    datos.put("fl_cell_phone", listStudent.get(i).getFL_CELL_PHONE());
                    datos.put("fl_mail", listStudent.get(i).getFL_MAIL());
                    datos.put("fl_facebook", listStudent.get(i).getFL_FACEBOOK());
                    datos.put("fl_twitter", listStudent.get(i).getFL_TWITTER());
                    datos.put("fl_tutor_relationship", listStudent.get(i).getFL_TUTOR_RELATIONSHIP());
                    datos.put("fl_patern_name_tutor", listStudent.get(i).getFL_PATERN_NAME_TUTOR());
                    datos.put("fl_matern_name_tutor", listStudent.get(i).getFL_MATERN_NAME_TUTOR());
                    datos.put("fl_name_tutor", listStudent.get(i).getFL_NAME_TUTOR());
                    datos.put("fl_born_date_tutor", listStudent.get(i).getFL_BORN_DATE_TUTOR());
                    datos.put("fl_gender_tutor", listStudent.get(i).getFL_GENDER_TUTOR());
                    datos.put("fl_maritial_state_tutor", listStudent.get(i).getFL_MARITIAL_STATE_TUTOR());
                    datos.put("fk_born_entity_tutor", listStudent.get(i).getFK_BORN_ENTITY_TUTOR());
                    datos.put("fk_born_municipality_tutor", listStudent.get(i).getFK_BORN_MUNICIPALITY_TUTOR());
                    datos.put("fk_born_locality_tutor", listStudent.get(i).getFK_BORN_LOCALITY_TUTOR());
                    datos.put("fl_occupation_tutor", listStudent.get(i).getFL_OCCUPATION_TUTOR());
                    datos.put("fl_level_education", listStudent.get(i).getFL_LEVEL_EDUCATION());
                    datos.put("fl_file_id_oficial_tutor", ""/*listStudent.get(i).getFL_FILE_ID_OFICIAL_TUTOR()*/);
                    datos.put("fl_curp_tutor", listStudent.get(i).getFL_CURP_TUTOR());
                    datos.put("fl_file_curp_tutor", ""/*listStudent.get(i).getFL_FILE_CURP_TUTOR()*/);
                    datos.put("fl_street_name_tutor", listStudent.get(i).getFL_STREET_NAME_TUTOR());
                    datos.put("fl_external_number_tutor", listStudent.get(i).getFL_EXTERNAL_NUMBER_TUTOR());
                    datos.put("fl_internal_number_tutor", listStudent.get(i).getFL_INTERNAL_NUMBER_TUTOR());
                    datos.put("fl_between_street1_tutor", listStudent.get(i).getFL_BETWEEN_STREET1_TUTOR());
                    datos.put("fl_between_street2_tutor", listStudent.get(i).getFL_BETWEEN_STREET2_TUTOR());
                    datos.put("fl_reference_tutor", listStudent.get(i).getFL_REFERENCE_TUTOR());
                    datos.put("fk_current_entity_tutor", listStudent.get(i).getFK_CURRENT_ENTITY_TUTOR());
                    datos.put("fk_current_municipality_tutor", listStudent.get(i).getFK_CURRENT_MUNICIPALITY_TUTOR());
                    datos.put("fk_current_locality_tutor", listStudent.get(i).getFK_CURRENT_LOCALITY_TUTOR());
                    datos.put("fl_colony_tutor", listStudent.get(i).getFL_COLONY_TUTOR());
                    datos.put("fl_zip_code_tutor", listStudent.get(i).getFL_ZIP_CODE_TUTOR());
                    datos.put("fl_phone_home_tutor", listStudent.get(i).getFL_PHONE_HOME_TUTOR());
                    datos.put("fl_cell_phone_tutor", listStudent.get(i).getFL_CELL_PHONE_TUTOR());
                    datos.put("fl_mail_tutor", listStudent.get(i).getFL_MAIL_TUTOR());
                    datos.put("fl_facebook_tutor", listStudent.get(i).getFL_FACEBOOK_TUTOR());
                    datos.put("fl_twitter_tutor", listStudent.get(i).getFL_TWITTER_TUTOR());
                    datos.put("fl_emergency_phone1", listStudent.get(i).getFL_EMERGENCY_PHONE1());
                    datos.put("fl_emergency_phone2", listStudent.get(i).getFL_EMERGENCY_PHONE2());
                    datos.put("fl_house_status", listStudent.get(i).getFL_HOUSE_STATUS());
                    datos.put("fl_wall_material", listStudent.get(i).getFL_WALL_MATERIAL());
                    datos.put("fl_roof_material", listStudent.get(i).getFL_ROOF_MATERIAL());
                    datos.put("fl_floor_material", listStudent.get(i).getFL_FLOOR_MATERIAL());
                    datos.put("fl_room", listStudent.get(i).getFL_ROOM());
                    datos.put("fl_dining_room", listStudent.get(i).getFL_DINING_ROOM());
                    datos.put("fl_kitchen", listStudent.get(i).getFL_KITCHEN());
                    datos.put("fl_toilet", listStudent.get(i).getFL_TOILET());
                    datos.put("fl_television", listStudent.get(i).getFL_TELEVISION());
                    datos.put("fl_stereo", listStudent.get(i).getFL_STEREO());
                    datos.put("fl_dvd", listStudent.get(i).getFL_DVD());
                    datos.put("fl_computer", listStudent.get(i).getFL_COMPUTER());
                    datos.put("fl_number_members_famly", listStudent.get(i).getFL_NUMBER_MEMBERS_FAMLY());
                    datos.put("fl_laptop", listStudent.get(i).getFL_LAPTOP());
                    datos.put("fl_refrigerator", listStudent.get(i).getFL_REFRIGERATOR());
                    datos.put("fl_washer", listStudent.get(i).getFL_WASHER());
                    datos.put("fl_stove", listStudent.get(i).getFL_STOVE());
                    datos.put("fl_family_monthly_income", listStudent.get(i).getFL_FAMILY_MONTHLY_INCOME());
                    datos.put("fl_family_monthly_discharge", listStudent.get(i).getFL_FAMILY_MONTHLY_DISCHARGE());
                    datos.put("fl_student_montgly_income", listStudent.get(i).getFL_STUDENT_MONTGLY_INCOME());
                    datos.put("fl_student_montgly_discharge", listStudent.get(i).getFL_STUDENT_MONTGLY_DISCHARGE());
                    datos.put("fl_diffusion_call", listStudent.get(i).getFL_DIFFUSION_CALL());
                    datos.put("fl_diffusion_cartel", listStudent.get(i).getFL_DIFFUSION_CARTEL());
                    datos.put("fl_diffusion_plantel_talks", listStudent.get(i).getFL_DIFFUSION_PLANTEL_TALKS());
                    datos.put("fl_diffusion_personal_ut", listStudent.get(i).getFL_DIFFUSION_PERSONAL_UT());
                    datos.put("fl_diffusion_graduates", listStudent.get(i).getFL_DIFFUSION_GRADUATES());
                    datos.put("fl_diffusion_family_friends", listStudent.get(i).getFL_DIFFUSION_FAMILY_FRIENDS());
                    datos.put("fl_diffusion_directlt_ut", listStudent.get(i).getFL_DIFFUSION_DIRECTLT_UT());
                    datos.put("fl_diffusion_brochure", listStudent.get(i).getFL_DIFFUSION_BROCHURE());
                    datos.put("fl_diffusion_newspaper", listStudent.get(i).getFL_DIFFUSION_NEWSPAPER());
                    datos.put("fl_diffusion_students_ut", listStudent.get(i).getFL_DIFFUSION_STUDENTS_UT());
                    datos.put("fl_diffusion_manta", listStudent.get(i).getFL_DIFFUSION_MANTA());
                    datos.put("fl_diffusion_triptych", listStudent.get(i).getFL_DIFFUSION_TRIPTYCH());
                    datos.put("fl_diffusion_guided_visits", listStudent.get(i).getFL_DIFFUSION_GUIDED_VISITS());
                    datos.put("fl_diffusion_exhibitions", listStudent.get(i).getFL_DIFFUSION_EXHIBITIONS());
                    datos.put("fl_diffusion_other", listStudent.get(i).getFL_DIFFUSION_OTHER());
                    datos.put("fl_diffusion_other_name", listStudent.get(i).getFL_DIFFUSION_OTHER_NAME());
                    datos.put("fl_option_utsem_study", listStudent.get(i).getFL_OPTION_UTSEM_STUDY());
                    datos.put("fl_physical_disability", listStudent.get(i).getFL_PHYSICAL_DISABILITY());
                    datos.put("fl_disability_name", listStudent.get(i).getFL_DISABILITY_NAME());
                    datos.put("fl_indigenous_group", listStudent.get(i).getFL_INDIGENOUS_GROUP());
                    datos.put("fl_indigenous_group_name", listStudent.get(i).getFL_INDIGENOUS_GROUP_NAME());
                    datos.put("fl_secutity_medical", listStudent.get(i).getFL_SECUTITY_MEDICAL());
                    datos.put("fl_security_name", listStudent.get(i).getFL_SECURITY_NAME());
                    datos.put("fl_number_security_medical", listStudent.get(i).getFL_NUMBER_SECURITY_MEDICAL());
                    datos.put("fl_acept_term", listStudent.get(i).getFL_ACEPT_TERM()); 
                    response.setContentType("application/json"); 
                    out.print(datos);
                    out.flush(); 
                    out.close();
                }                
            }
            if(request.getParameter("selectLoginStudent")!=null){
                String statusLogin = request.getParameter("statusLogin");
                if(statusLogin.equals("in")){
                    String enrrollment = request.getParameter("enrrollment");
                    String password = request.getParameter("password");
                    int pkStudent = 0;
                    String name = "";
                    String mail = "";
                    studentModel dataUser=new studentModel();
                    dataUser.setFL_ENROLLMENT(enrrollment);
                    dataUser.setFL_PASSWORD(password);
                    ArrayList<studentModel> list=new studentControl().SelectUserLogin(dataUser);
                    for(int i=0;i<list.size();i++){
                        pkStudent = list.get(i).getPK_STUDENT();
                        name = list.get(i).getFL_NAME();
                        enrrollment = list.get(i).getFL_ENROLLMENT();
                        mail = list.get(i).getFL_MAIL();
                    }
                    if(enrrollment != null && password != null){
                        if(list.size()==1){
                            session.setAttribute("pkStudent", pkStudent);
                            session.setAttribute("enrrollmentStudent", enrrollment);
                            session.setAttribute("mailStudent", mail);
                            session.setAttribute("passwordStudent", password);
                            session.setAttribute("logueadoStudent", name);
                            out.print("logeado");                   
                        }else{
                            out.print("notExit");
                            session.removeAttribute("pkStudent");
                            session.removeAttribute("logueadoStudent");
                        }
                    }
                }else if(statusLogin.equals("out")){
                    session.removeAttribute("pkStudent");
                    session.removeAttribute("logueadoStudent");
                    session.removeAttribute("mailStudent");
                    session.removeAttribute("enrrollmentStudent");
                    session.removeAttribute("passwordStudent");
                    response.sendRedirect("/metadato");
                }else{
                    session.removeAttribute("pkStudent");
                    session.removeAttribute("logueadoStudent");
                    session.removeAttribute("mailStudent");
                    session.removeAttribute("enrrollmentStudent");
                    session.removeAttribute("passwordStudent");
                    response.sendRedirect("/");
                }
            }
            if(request.getParameter("insert")!=null){
                studentModel dataStudent=new studentModel();
                String enrollment = request.getParameter("enrollment");
                String name=request.getParameter("nameStudent");
                int career=Integer.parseInt(request.getParameter("career"));
                String mater_name=request.getParameter("maternName");
                String patern_name=request.getParameter("paternName");
                int fk_preparatory=Integer.parseInt(request.getParameter("fkPreparatory"));
                dataStudent.setFL_ENROLLMENT(enrollment);
                dataStudent.setFK_CAREER(career);
                dataStudent.setFL_NAME(name);
                dataStudent.setFL_MATERN_NAME(mater_name);
                dataStudent.setFL_PATERN_NAME(patern_name);
                dataStudent.setFK_PREPARATORY(fk_preparatory);
                out.print(new studentControl().InsertStudent(dataStudent));
            }
            if(request.getParameter("insertOfPreregister")!=null){
                studentModel dataStudent=new studentModel();                
                if(request.getParameter("enrollment") != null && request.getParameter("utsemFolio") != null){
                    String enrollment = request.getParameter("enrollment");
                    String utsemFolio = request.getParameter("utsemFolio");
                    dataStudent.setFL_ENROLLMENT(enrollment);
                    dataStudent.setFL_UTSEM_FOLIO(utsemFolio);
                    out.print(new studentControl().InsertStudentOfPreregister(dataStudent));
                }
                
            }
            if(request.getParameter("update")!=null){       
                studentModel dataStudent=new studentModel();
                String enrollment = request.getParameter("enrollmentUpdate");
                String name=request.getParameter("nameUpdateStudent");
                int career=Integer.parseInt(request.getParameter("careerUpdate"));
                String mater_name=request.getParameter("maternNameUpdate");
                String patern_name=request.getParameter("paternNameUpdate");
                int fk_preparatory=Integer.parseInt(request.getParameter("fkPreparatoryUpdate"));
                dataStudent.setFL_ENROLLMENT(enrollment);
                dataStudent.setFK_CAREER(career);
                dataStudent.setFL_NAME(name);
                dataStudent.setFL_MATERN_NAME(mater_name);
                dataStudent.setFL_PATERN_NAME(patern_name);
                dataStudent.setFK_PREPARATORY(fk_preparatory);
                out.print(new studentControl().UpdateStudent(dataStudent));
            }
            if(request.getParameter("updateField")!=null){     
                int pk_student = 0;
                if(session.getAttribute("pkStudent")!=null){
                    pk_student=Integer.parseInt(session.getAttribute("pkStudent").toString());
                }
                if(request.getParameter("pkStudent")!=null){
                    pk_student=Integer.parseInt(request.getParameter("pkStudent"));
                }
                String field_name=request.getParameter("field_name"); 
                String field_value=request.getParameter("field_value");
                if(field_name.equals("fl_password")){
                    if(new studentControl().UpdateStudent(pk_student, field_name, field_value).equals("Datos Modificados")){
                        studentModel data = new studentModel();
                        data.setFL_PASSWORD(field_value);
                        data.setFL_MAIL(session.getAttribute("mailStudent").toString());
                        mailControl obj = new mailControl();
                        out.print(obj.MailSender(data));
                    }else{
                        out.print("sqlFail");
                    }
                }else{
                    out.print(new studentControl().UpdateStudent(pk_student, field_name, field_value));
                }
            }
            if(request.getParameter("getPassword")!=null){
                if(session.getAttribute("logueadoStudent")!=null){
                    out.print(session.getAttribute("passwordStudent"));
                }else{
                    out.print("");
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
