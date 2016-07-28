/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletServices;

import control.aes;
import control.downDetailControl;
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
import model.downDetailModel;
import model.propetiesTableModel;
import model.requirementsModel;
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
            if(request.getParameter("tableByAllColumsMetadata")!=null){  
                ArrayList<propetiesTableModel> listColumns=new studentControl().SelectReportColums();
                JSONArray contentRowsCal=new studentControl().SelectMetadataRows();
                JSONArray contentColums = new JSONArray();
                JSONArray contentDataFields = new JSONArray();
                JSONArray bulding = new JSONArray();
                JSONObject rowsCal = new JSONObject();
                JSONObject columns = new JSONObject();
                JSONObject dataFields = new JSONObject();
              
                for(int i=0;i<listColumns.size();i++){
                    JSONObject dataColums = new JSONObject();
                    if(listColumns.get(i).getFL_TEXT()!=null){
                        dataColums.put("text", listColumns.get(i).getFL_TEXT());
                    }
                    if(listColumns.get(i).getFL_DATA_FIELD()!=null){
                        dataColums.put("datafield", listColumns.get(i).getFL_DATA_FIELD());
                    }
                    if(listColumns.get(i).getFL_SORTABLE()!=null){
                        dataColums.put("sortable", listColumns.get(i).getFL_SORTABLE());
                    }
                    if(listColumns.get(i).getFL_FILTERABLE()!=null){
                        dataColums.put("filterable", listColumns.get(i).getFL_FILTERABLE());
                    }
                    if(listColumns.get(i).getFL_RESIZABLE()!=null){
                        dataColums.put("resizable", listColumns.get(i).getFL_RESIZABLE());
                    }
                    if(listColumns.get(i).getFL_FILTER()!=null){
                        dataColums.put("filter", listColumns.get(i).getFL_FILTER());
                    }
                    if(listColumns.get(i).getFL_HIDEABLE()!=null){
                        dataColums.put("hideable", listColumns.get(i).getFL_HIDEABLE());
                    }
                    if(listColumns.get(i).getFL_HIDDEN()!=null){
                        dataColums.put("hiden", listColumns.get(i).getFL_HIDDEN());
                    }
                    if(listColumns.get(i).getFL_ALIGN()!=null){
                        dataColums.put("align", listColumns.get(i).getFL_ALIGN());
                    }
                    if(listColumns.get(i).getFL_CELLSALING()!=null){
                        dataColums.put("cellsalign", listColumns.get(i).getFL_CELLSALING());
                    }
                    if(listColumns.get(i).getFL_CELLSRENDERER()!=null){
                        dataColums.put("cellsrenderer", listColumns.get(i).getFL_CELLSRENDERER());
                    }
                    if(listColumns.get(i).getFL_PINNED()!=null){
                        dataColums.put("pinned", listColumns.get(i).getFL_PINNED());
                    }
                    if(listColumns.get(i).getFL_CREATEFILTERPANE()!=null){
                        dataColums.put("createfilterpanel", listColumns.get(i).getFL_CREATEFILTERPANE());
                    }
                    if(listColumns.get(i).getFL_FILTERTYPE()!=null){
                        dataColums.put("filtertype", listColumns.get(i).getFL_FILTERTYPE());
                    }
                    if(listColumns.get(i).getFL_COLUMNTYPE()!=null){
                        dataColums.put("columntype", listColumns.get(i).getFL_COLUMNTYPE());
                    }
                    if(listColumns.get(i).getFL_RENDERED()!=null){
                        dataColums.put("rendered", listColumns.get(i).getFL_RENDERED());
                    }
                    if(listColumns.get(i).getFL_COLUMNGROUP()!=null){
                        dataColums.put("columngroup", listColumns.get(i).getFL_COLUMNGROUP());
                    }
                    dataColums.put("width", listColumns.get(i).getFL_WIDHT());
                    contentColums.add(dataColums); 
                }
                for(int i=0;i<listColumns.size();i++){
                    JSONObject datadataFields = new JSONObject();
                    datadataFields.put("name", listColumns.get(i).getFL_DATA_FIELD());
                    datadataFields.put("type", "string");                    
                    contentDataFields.add(datadataFields); 
                }
                rowsCal.put("rowsCal", contentRowsCal);
                columns.put("columns", contentColums);
                dataFields.put("dataFields", contentDataFields);
                bulding.add(columns);
                bulding.add(dataFields);
                bulding.add(rowsCal);
                response.setContentType("application/json"); 
                out.print(bulding);
                out.flush(); 
                out.close();
            }
            if(request.getParameter("generateEnrollment")!=null){
                String period = request.getParameter("period");
                out.print(new studentControl().GenerateEnrollment(period));   
            }
            if(request.getParameter("consultAllEnrollmentsPreregisterING")!=null){
                ArrayList<studentModel> listStudent=new studentControl().SelectEnrollmentsPreregisterING();
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
            if(request.getParameter("selectCandidatesInscriptionING")!=null){
                ArrayList<studentModel> listCandidateING=new studentControl().SelectCandidatesING();
                JSONArray content = new JSONArray();
                for(int i=0;i<listCandidateING.size();i++) {
                    JSONObject datos = new JSONObject();
                    datos.put("id", listCandidateING.get(i).getPK_STUDENT());
                    datos.put("fl_enrollment", listCandidateING.get(i).getFL_ENROLLMENT());
                    datos.put("fl_register_date", listCandidateING.get(i).getFL_REGISTER_DATE());
                    datos.put("fl_name", listCandidateING.get(i).getFL_NAME());
                    datos.put("fl_career", listCandidateING.get(i).getFL_NAME_ABBREVIATED());
                    content.add(datos); 
                }                
                response.setContentType("application/json"); 
                out.print(content);
                out.flush(); 
                out.close();
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
            if(request.getParameter("selectStudentsCareerSemesterGroup")!=null){
                int fkCareer = Integer.parseInt(request.getParameter("fkCareer"));
                int fkSemester = Integer.parseInt(request.getParameter("fkSemester"));
                int fkGroup = Integer.parseInt(request.getParameter("fkGroup"));
                int fkPeriod = Integer.parseInt(request.getParameter("fkGroup"));
                ArrayList<studentModel> listStudents=new studentControl().SelectStudentsCareerSemesterGroup(fkCareer, fkSemester, fkGroup, fkPeriod);
  
                JSONArray content = new JSONArray();
                for(int i=0;i<listStudents.size();i++) {
                    JSONObject datos = new JSONObject();
                    datos.put("dataPkStudent", listStudents.get(i).getPK_STUDENT());                    
                    datos.put("dataName", listStudents.get(i).getFL_NAME());
                    datos.put("dataEnrollment", listStudents.get(i).getFL_ENROLLMENT());
                    if(listStudents.get(i).getFL_DOWN()==1){
                        datos.put("dataDown", "Si");
                    }else{
                        datos.put("dataDown", "No");
                    }                  
                    content.add(datos); 
                }                
                response.setContentType("application/json"); 
                out.print(content);
                out.flush(); 
                out.close();               
            }
            if(request.getParameter("selectDetailDowns")!=null){
                ArrayList<downDetailModel> listDetails=new downDetailControl().SelectDownDetails();
                JSONObject datos = new JSONObject();
                for(int i=0;i<listDetails.size();i++){
                    datos.put("dataPkDownDetail", listDetails.get(i).getPK_DOWN_DETAIL());
                    datos.put("dataProgresivNumber", i+1);
                    datos.put("dataDescription", listDetails.get(i).getFL_DESCRIPTION());
                    response.setContentType("application/json"); 
                    out.print(datos);
                    out.flush(); 
                    out.close();
                }                
            }
            if(request.getParameter("generateDown")!=null){
                int fkStudent = Integer.parseInt(request.getParameter("fkStudent"));
                out.print(new studentControl().GenerateDownStudent(fkStudent));
                out.flush(); 
                out.close();         
            }
            if(request.getParameter("removeDown")!=null){
                int fkStudent = Integer.parseInt(request.getParameter("fkStudent"));
                out.print(new studentControl().RemoveDownStudent(fkStudent));
                out.flush(); 
                out.close();         
            }
            if(request.getParameter("detailDown")!=null){
                int fkStudent = Integer.parseInt(request.getParameter("fkStudent"));
                int fkDownDetail = Integer.parseInt(request.getParameter("fkDownDetail"));
                String motive = request.getParameter("fkStudent");
                int fkPeriod = Integer.parseInt(request.getParameter("fkPeriod"));
                response.setContentType("application/json"); 
                out.print(new studentControl().DetailDownStudent(fkStudent, fkDownDetail, motive, fkPeriod));
                out.flush(); 
                out.close();         
            }
            if(request.getParameter("selectAllStudents")!=null){
                ArrayList<studentModel> listStudent=new studentControl().SelectAllStudents();      
                JSONArray content = new JSONArray();
                for(int i=0;i<listStudent.size();i++){
                    JSONObject datos = new JSONObject();
                    datos.put("dataProgresivNumber", i+1);
                    datos.put("dataPkStudent", listStudent.get(i).getPK_STUDENT());
                    datos.put("dataName", listStudent.get(i).getFL_NAME());
                    datos.put("dataEnrollment", listStudent.get(i).getFL_ENROLLMENT());
                    datos.put("dataNameCareer", listStudent.get(i).getFL_NAME_CAREER());
                    datos.put("dataNameCareerAbbreviated", listStudent.get(i).getFL_NAME_ABBREVIATED());
                    datos.put("dataNameGroup", listStudent.get(i).getFL_NAME_GROUP());
                    datos.put("dataNameSemester", listStudent.get(i).getSemesterMl().getFL_NAME_SEMESTER());
                    content.add(datos);                    
                }     
                response.setContentType("application/json"); 
                out.print(content);
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
                    datos.put("dataPkStudent", listStudent.get(i).getPK_STUDENT());
                    datos.put("dataName", listStudent.get(i).getFL_NAME());
                    datos.put("dataEnrollment", listStudent.get(i).getFL_ENROLLMENT());
                    datos.put("dataModify", listStudent.get(i).getFL_MODIFY());
                    datos.put("dataPaternName", listStudent.get(i).getFL_PATERN_NAME());
                    datos.put("dataMaternName", listStudent.get(i).getFL_MATERN_NAME());
                    datos.put("dataPkLevelStudy", listStudent.get(i).getPK_LEVEL_STUDY());
                    datos.put("dataPkCareerLevelStudy1", listStudent.get(i).getPK_CAREER_LEVEL_STUDY1());
                    datos.put("dataPkCareerLevelStudy2", listStudent.get(i).getPK_CAREER_LEVEL_STUDY2());
                    datos.put("dataFkCareer", listStudent.get(i).getFK_CAREER());
                    datos.put("dataPkEntity", listStudent.get(i).getPK_ENTITY());
                    datos.put("dataPkMunicipality", listStudent.get(i).getPK_MUNICIPALITY());
                    datos.put("dataPkLocality", listStudent.get(i).getPK_LOCALITY());
                    datos.put("dataFkPreparatory", listStudent.get(i).getFK_PREPARATORY());
                    datos.put("dataBirthCertificate", listStudent.get(i).getFL_BIRTH_CERTIFICATE_NUMBER());
                    datos.put("dataHightSchoolCertificate", listStudent.get(i).getFL_HIGH_SCHOOL_CERTIFICATE());
                    response.setContentType("application/json"); 
                    out.print(datos);
                    out.flush(); 
                    out.close();
                }                
            }
            if(request.getParameter("selectStudentPayment")!=null){
                String enrollment = request.getParameter("enrollment");
                ArrayList<studentModel> listStudent=new studentControl().SelectStudentPayment(enrollment);
                JSONObject datos = new JSONObject();
                for(int i=0;i<listStudent.size();i++){
                    datos.put("dataProgresivNumber", i+1);
                    datos.put("dataPkStudent", listStudent.get(i).getPK_STUDENT());
                    datos.put("dataEnrollment", listStudent.get(i).getFL_ENROLLMENT());
                    datos.put("dataName", listStudent.get(i).getFL_NAME());
                    datos.put("dataPkLevelStudy", listStudent.get(i).getPK_LEVEL_STUDY());
                    datos.put("dataNameLevel", listStudent.get(i).getFL_NAME_ABBREVIATED());
                    datos.put("dataPkCareer", listStudent.get(i).getFK_CAREER());
                    datos.put("dataNameCareer", listStudent.get(i).getFL_NAME_CAREER());
                    response.setContentType("application/json"); 
                    out.print(datos);
                    out.flush(); 
                    out.close();
                }                
            }
            if(request.getParameter("selectStudentConstancy")!=null){
                String enrollment = request.getParameter("enrollment");
                ArrayList<studentModel> listStudent=new studentControl().SelectStudentConstancy(enrollment);
                JSONObject datos = new JSONObject();
                for(int i=0;i<listStudent.size();i++){
                    datos.put("dataProgresivNumber", i+1);
                    datos.put("dataPkStudent", listStudent.get(i).getPK_STUDENT());
                    datos.put("dataEnrollment", listStudent.get(i).getFL_ENROLLMENT());
                    datos.put("dataName", listStudent.get(i).getFL_NAME());
                    datos.put("dataPkLevelStudy", listStudent.get(i).getPK_LEVEL_STUDY());
                    datos.put("dataNameLevel", listStudent.get(i).getFL_NAME_ABBREVIATED());
                    datos.put("dataPkCareer", listStudent.get(i).getFK_CAREER());
                    datos.put("dataNameCareer", listStudent.get(i).getFL_NAME_CAREER());
                    response.setContentType("application/json"); 
                    out.print(datos);
                    out.flush(); 
                    out.close();
                }                
            }
            if(request.getParameter("selectStudentExpedient")!=null){
                int pk_student = Integer.parseInt(request.getParameter("pt_pk_student"));
                ArrayList<requirementsModel> listStudent=new studentControl().SelectStudentExpedient(pk_student);
                JSONArray content = new JSONArray();
                for(int i=0;i<listStudent.size();i++){
                    String fulfillment = listStudent.get(i).getFL_FULFILLMENT();
                    if(fulfillment.equals("Si")){
                        fulfillment="true";
                    }else{
                        fulfillment="false";
                    }
                    JSONObject datos = new JSONObject();
                    datos.put("id", listStudent.get(i).getFL_ORDER());
                    datos.put("dataPkRequirement", listStudent.get(i).getPK_REQUIREMENT());
                    datos.put("dataPkStudent", listStudent.get(i).getPK_STUDENT());
                    datos.put("dataProgresivNumber", i+1);
                    datos.put("dataName", listStudent.get(i).getFL_NAME_REQUIRIMENT());
                    datos.put("dataFulfillment",  fulfillment);
                    datos.put("dataParent", listStudent.get(i).getFL_PARENT());
                    datos.put("dataOther", listStudent.get(i).getFL_OTHER_FLAG());
                    content.add(datos);
                }      
                response.setContentType("application/json"); 
                out.print(content);
                out.flush(); 
                out.close();
            }
            if(request.getParameter("updateStudentExpedient")!=null){
                int pk_student = Integer.parseInt(request.getParameter("pk_student"));
                int pk_requirement = Integer.parseInt(request.getParameter("pk_requirement"));  
                out.print(new studentControl().updateStudentExpedient(pk_requirement, pk_student));
                out.flush(); 
                out.close();
            }
            if(request.getParameter("deleteStudentExpedient")!=null){
                int pk_student = Integer.parseInt(request.getParameter("pk_student"));
                int pk_requirement = Integer.parseInt(request.getParameter("pk_requirement")); 
                out.print(new studentControl().deleteStudentExpedient(pk_requirement, pk_student));
                out.flush(); 
                out.close();
            }
            if(request.getParameter("selectStudentsING")!=null){
                if(request.getParameter("pt_period")!=null && request.getParameter("pt_career")!=null){
                    int pt_period = Integer.parseInt(request.getParameter("pt_period"));
                    int pt_career = Integer.parseInt(request.getParameter("pt_career")); 
                    ArrayList<studentModel> listStudents=new studentControl().SelectStudentsING(pt_period, pt_career);
                    JSONArray content = new JSONArray();
                    for(int i=0;i<listStudents.size();i++) {
                        JSONObject datos = new JSONObject();
                        datos.put("id", listStudents.get(i).getPK_STUDENT());
                        datos.put("pk_student", listStudents.get(i).getPK_STUDENT());
                        datos.put("fl_enrollment", listStudents.get(i).getFL_ENROLLMENT());
                        datos.put("fl_folio_utsem", listStudents.get(i).getFL_UTSEM_FOLIO());
                        datos.put("fl_name", listStudents.get(i).getFL_NAME());
                        content.add(datos); 
                    }                
                    response.setContentType("application/json"); 
                    out.print(content);
                    out.flush(); 
                    out.close();
                }     
            }  
            if(request.getParameter("selectStudents")!=null){
                if(request.getParameter("pt_period")!=null && request.getParameter("pt_career")!=null){
                    int pt_period = Integer.parseInt(request.getParameter("pt_period"));
                    int pt_career = Integer.parseInt(request.getParameter("pt_career")); 
                    ArrayList<studentModel> listStudents=new studentControl().SelectStudents(pt_period, pt_career);
                    JSONArray content = new JSONArray();
                    for(int i=0;i<listStudents.size();i++) {
                        JSONObject datos = new JSONObject();
                        datos.put("id", listStudents.get(i).getPK_STUDENT());
                        datos.put("pk_student", listStudents.get(i).getPK_STUDENT());
                        datos.put("fl_enrollment", listStudents.get(i).getFL_ENROLLMENT());
                        datos.put("fl_folio_utsem", listStudents.get(i).getFL_UTSEM_FOLIO());
                        datos.put("fl_name", listStudents.get(i).getFL_NAME());
                        content.add(datos); 
                    }                
                    response.setContentType("application/json"); 
                    out.print(content);
                    out.flush(); 
                    out.close();
                }     
            }  
            if(request.getParameter("selectStudentsMissingMetadata")!=null){
                if(request.getParameter("pt_career")!=null && request.getParameter("pt_group")!=null){
                    int pt_career = Integer.parseInt(request.getParameter("pt_career"));
                    int pt_group = Integer.parseInt(request.getParameter("pt_group")); 
                    ArrayList<studentModel> listStudents=new studentControl().SelectStudentsMetadata(pt_career, pt_group);
                    JSONArray content = new JSONArray();
                    for(int i=0;i<listStudents.size();i++) {
                        JSONObject datos = new JSONObject();
                        datos.put("dataProgresivNumber", i+1);
                        datos.put("dataEnrollment", listStudents.get(i).getFL_ENROLLMENT());
                        datos.put("dataStudentName", listStudents.get(i).getFL_NAME());
                        content.add(datos); 
                    }                
                    response.setContentType("application/json"); 
                    out.print(content);
                    out.flush(); 
                    out.close();
                }     
            }
            if(request.getParameter("selectStudentByPkStudent")!=null){
                String enrollmentStudent="";
                if(session.getAttribute("enrollmentStudent")!=null){
                    enrollmentStudent=session.getAttribute("enrollmentStudent").toString();
                }
                if(request.getParameter("enrollmentStudent")!=null){
                    enrollmentStudent=request.getParameter("enrollmentStudent");
                }
                ArrayList<studentModel> listStudent=new studentControl().SelectStudent(enrollmentStudent, "allData");
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
                    
                    datos.put("fl_where_work_place_address", listStudent.get(i).getFL_WHERE_WORK_PLACE_ADDRESS());
                    datos.put("fl_company_type", listStudent.get(i).getFL_COMPANY_TYPE());
                    datos.put("fl_telephone_place_work", listStudent.get(i).getFL_TELEPHONE_PLACE_WORK());
                    
                    datos.put("fl_bacherol_type", listStudent.get(i).getFL_BACHEROL_TYPE());
                    datos.put("fl_school_type", listStudent.get(i).getFL_SCHOOL_TYPE());
                    datos.put("fl_above_average", listStudent.get(i).getFL_ABOVE_AVERAGE());
                    datos.put("fl_period_bacherol", listStudent.get(i).getFL_PERIOD_BACHEROL());
                    
                    datos.put("fl_name_university_studied", listStudent.get(i).getFL_NAME_UNIVERSITY_STUDIED());
                    datos.put("fl_period_tsu", listStudent.get(i).getFL_PERIOD_TSU());
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
                    datos.put("fl_patern_name_father", listStudent.get(i).getFL_PATERN_NAME_FATHER());
                    datos.put("fl_matern_name_father", listStudent.get(i).getFL_MATERN_NAME_FATHER());
                    datos.put("fl_name_father", listStudent.get(i).getFL_NAME_FATHER());
                    datos.put("fl_born_date_father", listStudent.get(i).getFL_BORN_DATE_FATHER());
                    datos.put("fl_maritial_state_father", listStudent.get(i).getFL_MARITIAL_STATE_FATHER());
                    datos.put("fl_level_education_father", listStudent.get(i).getFL_LEVEL_EDUCATION_FATHER());
                    datos.put("fl_patern_name_mother", listStudent.get(i).getFL_PATERN_NAME_MOTHER());
                    datos.put("fl_matern_name_mother", listStudent.get(i).getFL_MATERN_NAME_MOTHER());
                    datos.put("fl_name_mother", listStudent.get(i).getFL_NAME_MOTHER());
                    datos.put("fl_born_date_mother", listStudent.get(i).getFL_BORN_DATE_MOTHER());
                    datos.put("fl_maritial_state_mother", listStudent.get(i).getFL_MARITIAL_STATE_MOTHER());
                    datos.put("fl_level_education_mother", listStudent.get(i).getFL_LEVEL_EDUCATION_MOTHER());
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
                    datos.put("fl_whom_depend",listStudent.get(i).getFL_WHOM_DEPEND());
                    datos.put("fl_depend_economically_work",listStudent.get(i).getFL_DEPEND_ECONOMICALLY_WORK());
                    datos.put("fl_where_work",listStudent.get(i).getFL_WHERE_WORK());
                    datos.put("fl_what_work",listStudent.get(i).getFL_WHAT_WORK());
                    datos.put("fl_acept_term", listStudent.get(i).getFL_ACEPT_TERM()); 
                    response.setContentType("application/json"); 
                    out.print(datos);
                    out.flush(); 
                    out.close();
                }                
            }
            if(request.getParameter("descryptUrl")!=null){
                if(request.getParameter("ac")!=null){
                    String ac = request.getParameter("ac").replace(" ", "+");
                    aes sec = new aes();
                    sec.addKey("2015"); 
                    JSONObject data = new JSONObject();   
                    ac = sec.desencriptar(ac);
                    if(ac.contains("userName") && ac.contains("mail") && ac.contains("password") && ac.contains("pkStudent")){
                        int pt_pkStudent;
                        String pt_mail;
                        String[] acSplit=ac.split("&&");
                        pt_pkStudent = Integer.parseInt(acSplit[3].split("=")[1]);
                        pt_mail = acSplit[1].split("=")[1];
                        data.put("status", new studentControl().StudentActivateAcount(pt_pkStudent, "FL_MAIL_VALIDATE", pt_mail));
                    }else{
                        data.put("status", "linkBroken");
                    }
                    response.setContentType("application/json"); 
                    out.print(data);
                }
            }
            if(request.getParameter("selectLoginStudent")!=null){
                String statusLogin = request.getParameter("statusLogin");
                if(statusLogin.equals("in")){
                    String enrollment = request.getParameter("userName");
                    String password = request.getParameter("password");
                    String folio ="";
                    int pkStudent = 0;
                    String name = "";
                    String nameSmall ="";
                    String mail = "";
                    String career ="";
                    String gender = "";
                    String nameGroup = "";
                    int autorized =0;
                    int pkGroup = 0;
                    int fkLevel = 0;
                    studentModel dataUser=new studentModel();
                    dataUser.setFL_ENROLLMENT(enrollment);
                    dataUser.setFL_PASSWORD(password);
                    JSONObject data = new JSONObject();
                    ArrayList<studentModel> list=new studentControl().SelectUserLogin(dataUser);                    
                    if(enrollment != null && password != null){
                        if(list.size()==1){
                            for (studentModel list1 : list) {
                                pkStudent = list1.getPK_STUDENT();
                                name = list1.getFL_NAME();
                                nameSmall = list1.getFL_NAME_FATHER();
                                enrollment = list1.getFL_ENROLLMENT();
                                folio = list1.getFL_UTSEM_FOLIO();
                                mail = list1.getFL_MAIL();
                                career = list1.getFL_NAME_ABBREVIATED();
                                gender = list1.getFL_GENDER();
                                nameGroup = list1.getFL_NAME_GROUP();
                                pkGroup = list1.getPK_GROUP();
                                fkLevel = list1.getFK_LEVEL();
                                autorized = list1.getFL_AUTHORIZED_ACCESS_PREREGISTER_ING();
                            }
                            if(request.getParameter("typeLogin")!=null&&request.getParameter("typeLogin").equals("metadata")){                                
                                session.setAttribute("pkStudent", pkStudent);
                                session.setAttribute("enrollmentStudent", enrollment);
                                session.setAttribute("mailStudent", mail);
                                session.setAttribute("passwordStudent", password);
                                session.setAttribute("logueadoStudentMetadata", name);
                                session.setAttribute("careerStudent", career);
                                data.put("statusLogin", "logeado");
                            }else if(request.getParameter("typeLogin")!=null&&request.getParameter("typeLogin").equals("preregister")){   
                                if(autorized==1){
                                    session.setAttribute("pkStudent", pkStudent);
                                    session.setAttribute("enrollmentStudent", enrollment);
                                    session.setAttribute("folioSystemIng", folio);
                                    session.setAttribute("mailStudent", mail);
                                    session.setAttribute("passwordStudent", password);
                                    session.setAttribute("logueadoStudentPreregister", name);
                                    session.setAttribute("careerStudent", career);
                                    data.put("statusLogin", "logeado");
                                }else{
                                    data.put("statusLogin", "noAutorized");
                                }                                
                            }else{  
                                String statusMailActive=new studentControl().SelectUserLoginMail(dataUser);  
                                if(statusMailActive.equals("0")){
                                    data.put("statusLogin", "notMailActive");
                                    data.put("pkStudent", pkStudent);
                                    data.put("userNameStudent", enrollment);
                                    data.put("mailStudent", mail);
                                    data.put("passwordStudent", password);
                                    data.put("logueadoStudentCal", name);  
                                    data.put("careerStudent", career);
                                    data.put("nameSmall", nameSmall);
                                    data.put("genderStudent", gender);
                                    data.put("nameGroup", nameGroup);
                                    data.put("pkGroup", pkGroup);
                                    data.put("fkLevel", fkLevel);
                                    session.setAttribute("careerStudent", career);
                                }else if(statusMailActive.equals("1")){
                                    data.put("statusLogin", "logeado");
                                    data.put("pkStudent", pkStudent);
                                    data.put("userNameStudent", enrollment);
                                    data.put("mailStudent", mail);
                                    data.put("passwordStudent", password);
                                    data.put("logueadoStudentCal", name);   
                                    data.put("careerStudent", career);
                                    data.put("nameSmall", nameSmall);
                                    data.put("genderStudent", gender);
                                    data.put("nameGroup", nameGroup);
                                    data.put("pkGroup", pkGroup);
                                    data.put("fkLevel", fkLevel);
                                    session.setAttribute("pkStudent", pkStudent);
                                    session.setAttribute("userNameStudent", enrollment);
                                    session.setAttribute("mailStudent", mail);
                                    session.setAttribute("passwordStudent", password);
                                    session.setAttribute("logueadoStudentCal", name);
                                    session.setAttribute("careerStudent", career);
                                    session.setAttribute("careerStudent", career);
                                    session.setAttribute("nameGroup", nameGroup);
                                    session.setAttribute("pkGroup", pkGroup);
                                    session.setAttribute("fkLevel", pkGroup);
                                }                                     
                            }
                        }else{
                            data.put("statusLogin", "notExit");
                            session.invalidate();
                        }
                    }
                    response.setHeader("Access-Control-Allow-Origin", "*");
                    response.setHeader("Access-Control-Allow-Methods", "POST,PUT, GET, OPTIONS, DELETE");
                    response.setHeader("Access-Control-Max-Age", "3600");
                    response.setHeader("Access-Control-Allow-Headers"," Origin, X-Requested-With, Content-Type, Accept,AUTH-TOKEN");
                    response.setContentType("application/json"); 
                    out.print(data);
                }else if(statusLogin.equals("logged")){
                    JSONObject status = new JSONObject();
                    response.setContentType("application/json");
                    if(request.getParameter("typeLogin")!=null){
                        if(request.getParameter("typeLogin").equals("metadata")){  
                            if(session.getAttribute("logueadoStudentMetadata")!=null){
                                status.put("status", true);
                            }else{
                                status.put("status", false);                     
                            }
                        }else if(request.getParameter("typeLogin").equals("preregister")){                                
                            if(session.getAttribute("logueadoStudentPreregister")!=null){
                                status.put("status", true);
                            }else{
                                status.put("status", false);                     
                            }
                        }
                    }     
                    out.print(status);   
                }else if(statusLogin.equals("outPreIng")){
                    session.removeAttribute("pkStudent");
                    session.removeAttribute("logueadoStudentPreregister");
                    session.removeAttribute("folioSystemIng");
                    session.removeAttribute("mailStudent");
                    session.removeAttribute("enrollmentStudent");
                    session.removeAttribute("passwordStudent");
                    response.sendRedirect("/preregistro-ing");
                }else if(statusLogin.equals("out")){
                    session.removeAttribute("pkStudent");
                    session.removeAttribute("logueadoStudentMetadata");
                    session.removeAttribute("folioSystemIng");
                    session.removeAttribute("mailStudent");
                    session.removeAttribute("enrollmentStudent");
                    session.removeAttribute("passwordStudent");
                    response.sendRedirect("/metadato");
                }else{
                    session.removeAttribute("pkStudent");
                    session.removeAttribute("logueadoStudentMetadata");
                    session.removeAttribute("logueadoStudentPreregister");
                    session.removeAttribute("folioSystemIng");
                    session.removeAttribute("mailStudent");
                    session.removeAttribute("enrollmentStudent");
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
                    String birth_certificate=request.getParameter("birthCertificate");
                    String hight_school_certificate=request.getParameter("hightSchoolCertificate");
                    dataStudent.setFL_ENROLLMENT(enrollment);
                    dataStudent.setFL_UTSEM_FOLIO(utsemFolio);
                    dataStudent.setFL_BIRTH_CERTIFICATE_NUMBER(birth_certificate);
                    dataStudent.setFL_HIGH_SCHOOL_CERTIFICATE(hight_school_certificate);
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
                String birth_certificate=request.getParameter("birthCertificate");
                String hight_school_certificate=request.getParameter("hightSchoolCertificate");
                int fk_preparatory=Integer.parseInt(request.getParameter("fkPreparatoryUpdate"));
                dataStudent.setFL_ENROLLMENT(enrollment);
                dataStudent.setFK_CAREER(career);
                dataStudent.setFL_NAME(name);
                dataStudent.setFL_MATERN_NAME(mater_name);
                dataStudent.setFL_PATERN_NAME(patern_name);
                dataStudent.setFK_PREPARATORY(fk_preparatory);
                dataStudent.setFL_BIRTH_CERTIFICATE_NUMBER(birth_certificate);
                dataStudent.setFL_HIGH_SCHOOL_CERTIFICATE(hight_school_certificate);
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
                out.print(session.getAttribute("passwordStudent"));                
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
