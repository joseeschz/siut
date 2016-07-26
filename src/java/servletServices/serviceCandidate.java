/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletServices;

import control.candidateControl;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.propetiesTableModel;
import model.studentModel;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author CARLOS
 */
@WebServlet(name = "serviceCandidate", urlPatterns = {"/serviceCandidate"})
public class serviceCandidate extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.v
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
                ArrayList<propetiesTableModel> listColumns=new candidateControl().SelectReportColums();
                JSONArray contentRowsCal=new candidateControl().SelectMetadataRows();
                JSONArray contentColums = new JSONArray();
                JSONArray contentDataFields = new JSONArray();
                JSONArray bulding = new JSONArray();
                JSONObject rowsCal = new JSONObject();
                JSONObject columns = new JSONObject();
                JSONObject dataFields = new JSONObject();
              
                for(int i=0;i<listColumns.size();i++){
                    JSONObject dataColums = new JSONObject();
                    dataColums.put("cellclassname", "cellclassname");
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
            if(request.getParameter("generateFolioUtsem")!=null){
                String period = request.getParameter("period");
                String type = request.getParameter("type");
                out.print(new candidateControl().GenerateFolioUtsem(period, type));   
            }
            if(request.getParameter("consultAllFoliosSystem")!=null){
                ArrayList<studentModel> listCandidate=new candidateControl().SelectFoliosSystem();
                JSONArray principal = new JSONArray();
                JSONObject settings = new JSONObject();
                JSONArray content = new JSONArray();
                settings.put("__entityModel","Folios");
                for(int i=0;i<listCandidate.size();i++){
                    JSONObject datos = new JSONObject();
                    datos.put("dataProgresivNumber", i+1);
                    datos.put("dataNameFolio", listCandidate.get(i).getFL_FOLIO_TEMP_SYSTEM());
                    content.add(datos); 
                }
                settings.put("__ENTITIES", content);
                principal.add(settings);
                response.setContentType("application/json"); 
                out.print(principal);
                out.flush(); 
                out.close();
            }
            if(request.getParameter("consultAllFoliosSystemAll")!=null){
                ArrayList<studentModel> listCandidate=new candidateControl().SelectFoliosSystemAll();
                JSONArray principal = new JSONArray();
                JSONObject settings = new JSONObject();
                JSONArray content = new JSONArray();
                settings.put("__entityModel","Folios");
                for(int i=0;i<listCandidate.size();i++){
                    JSONObject datos = new JSONObject();
                    datos.put("dataProgresivNumber", i+1);
                    datos.put("dataNameFolio", listCandidate.get(i).getFL_FOLIO_TEMP_SYSTEM());
                    content.add(datos); 
                }
                settings.put("__ENTITIES", content);
                principal.add(settings);
                response.setContentType("application/json"); 
                out.print(principal);
                out.flush(); 
                out.close();
            }
            if(request.getParameter("consultAllFoliosUtsem")!=null){
                ArrayList<studentModel> listCandidate=new candidateControl().SelectFoliosUtsem();
                JSONArray principal = new JSONArray();
                JSONObject settings = new JSONObject();
                JSONArray content = new JSONArray();
                settings.put("__entityModel","Folios");
                for(int i=0;i<listCandidate.size();i++){
                    JSONObject datos = new JSONObject();
                    datos.put("dataProgresivNumber", i+1);
                    datos.put("dataNameFolio", listCandidate.get(i).getFL_UTSEM_FOLIO());
                    content.add(datos); 
                }
                settings.put("__ENTITIES", content);
                principal.add(settings);
                response.setContentType("application/json"); 
                out.print(principal);
                out.flush(); 
                out.close();
            }
            if(request.getParameter("validateUserName")!=null){
                if (request.getParameter("dataUserName")!=null) {
                    out.print(new candidateControl().ValidateUserName(request.getParameter("dataUserName")));
                }
            }
            if(request.getParameter("validateEmail")!=null){
                if (request.getParameter("dataEmail")!=null) {
                    out.print(new candidateControl().ValidateEmail(request.getParameter("dataEmail")));
                }
            }
            if(request.getParameter("selectCandidatesMissingInscription")!=null){
                ArrayList<studentModel> listCandidate=new candidateControl().SelectCandidatesMissingPreinscription();
                JSONArray content = new JSONArray();
                for(int i=0;i<listCandidate.size();i++) {
                    JSONObject datos = new JSONObject();
                    datos.put("fl_progressiv_number", i+1);
                    datos.put("id", listCandidate.get(i).getPK_STUDENT());
                    datos.put("fl_folioSystem_temp_system", listCandidate.get(i).getFL_FOLIO_TEMP_SYSTEM());
                    datos.put("fl_register_date", listCandidate.get(i).getFL_REGISTER_DATE());
                    datos.put("fl_name", listCandidate.get(i).getFL_NAME());
                    datos.put("fl_user_name", listCandidate.get(i).getFL_ENROLLMENT());
                    datos.put("fl_password", listCandidate.get(i).getFL_PASSWORD());
                    datos.put("fl_career", listCandidate.get(i).getFL_NAME_ABBREVIATED());
                    content.add(datos); 
                }                
                response.setContentType("application/json"); 
                out.print(content);
                out.flush(); 
                out.close();
            }
            if(request.getParameter("selectCandidatesInscription")!=null){
                ArrayList<studentModel> listCandidate=new candidateControl().SelectCandidates();
                JSONArray content = new JSONArray();
                for(int i=0;i<listCandidate.size();i++) {
                    JSONObject datos = new JSONObject();
                    datos.put("id", listCandidate.get(i).getPK_STUDENT());
                    datos.put("fl_folioSystem_temp_system", listCandidate.get(i).getFL_FOLIO_TEMP_SYSTEM());
                    datos.put("fl_utsem_folioSystem", listCandidate.get(i).getFL_UTSEM_FOLIO());
                    datos.put("fl_register_date", listCandidate.get(i).getFL_REGISTER_DATE());
                    datos.put("fl_name", listCandidate.get(i).getFL_NAME());
                    datos.put("fl_career", listCandidate.get(i).getFL_NAME_ABBREVIATED());
                    content.add(datos); 
                }                
                response.setContentType("application/json"); 
                out.print(content);
                out.flush(); 
                out.close();
            }           
            if(request.getParameter("selectCandidateByPkCandidate")!=null){
                String folioSystemCandidate = "";
                String folioUtsemCandidate = "";
                ArrayList<studentModel> listCandidate;
                if(session.getAttribute("folioSystem")!=null){
                    folioSystemCandidate=session.getAttribute("folioSystem").toString();
                }
                if(request.getParameter("folioSystem")!=null){
                    folioSystemCandidate=request.getParameter("folioSystem");
                    session.setAttribute("folioSystem", folioSystemCandidate);
                }
                if(request.getParameter("folioUtsem")!=null){
                    folioUtsemCandidate = request.getParameter("folioUtsem");
                    listCandidate = new candidateControl().SelectCandidate("folioUtsem", folioUtsemCandidate);
                }else{
                    listCandidate = new candidateControl().SelectCandidate("folioSystem", folioSystemCandidate);
                }               
                JSONObject datos = new JSONObject();
                for(int i=0;i<listCandidate.size();i++){
                    datos.put("fl_folioSystem_temp_system", listCandidate.get(i).getFL_FOLIO_TEMP_SYSTEM());
                    datos.put("fl_utsem_folioSystem", listCandidate.get(i).getFL_UTSEM_FOLIO());
                    datos.put("fk_career", listCandidate.get(i).getFK_CAREER());
                    datos.put("fk_entity", listCandidate.get(i).getPK_ENTITY());
                    datos.put("fk_municipality", listCandidate.get(i).getPK_MUNICIPALITY());
                    datos.put("fk_locality", listCandidate.get(i).getPK_LOCALITY());
                    datos.put("fk_preparatory", listCandidate.get(i).getFK_PREPARATORY());
                    datos.put("fl_register_date", listCandidate.get(i).getFL_REGISTER_DATE());
                    datos.put("fl_name", listCandidate.get(i).getFL_NAME());
                    datos.put("fl_matern_name", listCandidate.get(i).getFL_MATERN_NAME());
                    datos.put("fl_patern_name", listCandidate.get(i).getFL_PATERN_NAME());
                    datos.put("fl_date_born", listCandidate.get(i).getFL_DATE_BORN());
                    datos.put("fl_gender", listCandidate.get(i).getFL_GENDER());
                    datos.put("fl_photography", listCandidate.get(i).getFL_PHOTOGRAPHY());
                    datos.put("fl_maritial_status", listCandidate.get(i).getFL_MARITIAL_STATUS());
                    datos.put("fl_working", listCandidate.get(i).getFL_WORKING());
                    datos.put("fl_bacherol_type", listCandidate.get(i).getFL_BACHEROL_TYPE());
                    datos.put("fl_school_type", listCandidate.get(i).getFL_SCHOOL_TYPE());
                    datos.put("fl_above_average", listCandidate.get(i).getFL_ABOVE_AVERAGE());
                    datos.put("fl_period_bacherol", listCandidate.get(i).getFL_PERIOD_BACHEROL());
                    datos.put("fl_file_id_oficial", ""/*listCandidate.get(i).getFL_FILE_ID_OFICIAL()*/);
                    datos.put("fl_file_document_born", ""/* listCandidate.get(i).getFL_FILE_DOCUMENT_BORN()*/);
                    datos.put("fl_curp", listCandidate.get(i).getFL_CURP());
                    datos.put("fl_file_curp", ""/*listCandidate.get(i).getFL_FILE_CURP()*/);
                    datos.put("fk_born_entity", listCandidate.get(i).getFK_BORN_ENTITY());
                    datos.put("fk_born_municipality", listCandidate.get(i).getFK_BORN_MUNICIPALITY());
                    datos.put("fk_born_locality", listCandidate.get(i).getFK_BORN_LOCALITY());
                    datos.put("fl_name_street", listCandidate.get(i).getFL_NAME_STREET());
                    datos.put("fl_external_number", listCandidate.get(i).getFL_EXTERNAL_NUMBER());
                    datos.put("fl_internal_number", listCandidate.get(i).getFL_INTERNAL_NUMBER());
                    datos.put("fl_between_street1", listCandidate.get(i).getFL_BETWEEN_STREET1());
                    datos.put("fl_between_street2", listCandidate.get(i).getFL_BETWEEN_STREET2());
                    datos.put("fl_reference", listCandidate.get(i).getFL_REFERENCE());
                    datos.put("fk_current_entity", listCandidate.get(i).getFK_CURRENT_ENTITY());
                    datos.put("fk_current_municipality", listCandidate.get(i).getFK_CURRENT_MUNICIPALITY());
                    datos.put("fk_current_locality", listCandidate.get(i).getFK_CURRENT_LOCALITY());
                    datos.put("fl_current_colony", listCandidate.get(i).getFL_CURRENT_COLONY());
                    datos.put("fl_zip_code", listCandidate.get(i).getFL_ZIP_CODE());
                    datos.put("fl_phone_home", listCandidate.get(i).getFL_PHONE_HOME());
                    datos.put("fl_cell_phone", listCandidate.get(i).getFL_CELL_PHONE());
                    datos.put("fl_mail", listCandidate.get(i).getFL_MAIL());
                    datos.put("fl_facebook", listCandidate.get(i).getFL_FACEBOOK());
                    datos.put("fl_twitter", listCandidate.get(i).getFL_TWITTER());
                    
                    datos.put("fl_patern_name_father", listCandidate.get(i).getFL_PATERN_NAME_FATHER());
                    datos.put("fl_matern_name_father", listCandidate.get(i).getFL_MATERN_NAME_FATHER());
                    datos.put("fl_name_father", listCandidate.get(i).getFL_NAME_FATHER());
                    datos.put("fl_born_date_father", listCandidate.get(i).getFL_BORN_DATE_FATHER());
                    datos.put("fl_maritial_state_father", listCandidate.get(i).getFL_MARITIAL_STATE_FATHER());
                    datos.put("fl_level_education_father", listCandidate.get(i).getFL_LEVEL_EDUCATION_FATHER());
                    datos.put("fl_patern_name_mother", listCandidate.get(i).getFL_PATERN_NAME_MOTHER());
                    datos.put("fl_matern_name_mother", listCandidate.get(i).getFL_MATERN_NAME_MOTHER());
                    datos.put("fl_name_mother", listCandidate.get(i).getFL_NAME_MOTHER());
                    datos.put("fl_born_date_mother", listCandidate.get(i).getFL_BORN_DATE_MOTHER());
                    datos.put("fl_maritial_state_mother", listCandidate.get(i).getFL_MARITIAL_STATE_MOTHER());
                    datos.put("fl_level_education_mother", listCandidate.get(i).getFL_LEVEL_EDUCATION_MOTHER());
                    
                    datos.put("fl_tutor_relationship", listCandidate.get(i).getFL_TUTOR_RELATIONSHIP());
                    datos.put("fl_patern_name_tutor", listCandidate.get(i).getFL_PATERN_NAME_TUTOR());
                    datos.put("fl_matern_name_tutor", listCandidate.get(i).getFL_MATERN_NAME_TUTOR());
                    datos.put("fl_name_tutor", listCandidate.get(i).getFL_NAME_TUTOR());
                    datos.put("fl_born_date_tutor", listCandidate.get(i).getFL_BORN_DATE_TUTOR());
                    datos.put("fl_gender_tutor", listCandidate.get(i).getFL_GENDER_TUTOR());
                    datos.put("fl_maritial_state_tutor", listCandidate.get(i).getFL_MARITIAL_STATE_TUTOR());
                    datos.put("fk_born_entity_tutor", listCandidate.get(i).getFK_BORN_ENTITY_TUTOR());
                    datos.put("fk_born_municipality_tutor", listCandidate.get(i).getFK_BORN_MUNICIPALITY_TUTOR());
                    datos.put("fk_born_locality_tutor", listCandidate.get(i).getFK_BORN_LOCALITY_TUTOR());
                    datos.put("fl_occupation_tutor", listCandidate.get(i).getFL_OCCUPATION_TUTOR());
                    datos.put("fl_level_education", listCandidate.get(i).getFL_LEVEL_EDUCATION());
                    datos.put("fl_file_id_oficial_tutor", ""/*listCandidate.get(i).getFL_FILE_ID_OFICIAL_TUTOR()*/);
                    datos.put("fl_curp_tutor", listCandidate.get(i).getFL_CURP_TUTOR());
                    datos.put("fl_file_curp_tutor", ""/*listCandidate.get(i).getFL_FILE_CURP_TUTOR()*/);
                    datos.put("fl_street_name_tutor", listCandidate.get(i).getFL_STREET_NAME_TUTOR());
                    datos.put("fl_external_number_tutor", listCandidate.get(i).getFL_EXTERNAL_NUMBER_TUTOR());
                    datos.put("fl_internal_number_tutor", listCandidate.get(i).getFL_INTERNAL_NUMBER_TUTOR());
                    datos.put("fl_between_street1_tutor", listCandidate.get(i).getFL_BETWEEN_STREET1_TUTOR());
                    datos.put("fl_between_street2_tutor", listCandidate.get(i).getFL_BETWEEN_STREET2_TUTOR());
                    datos.put("fl_reference_tutor", listCandidate.get(i).getFL_REFERENCE_TUTOR());
                    datos.put("fk_current_entity_tutor", listCandidate.get(i).getFK_CURRENT_ENTITY_TUTOR());
                    datos.put("fk_current_municipality_tutor", listCandidate.get(i).getFK_CURRENT_MUNICIPALITY_TUTOR());
                    datos.put("fk_current_locality_tutor", listCandidate.get(i).getFK_CURRENT_LOCALITY_TUTOR());
                    datos.put("fl_colony_tutor", listCandidate.get(i).getFL_COLONY_TUTOR());
                    datos.put("fl_zip_code_tutor", listCandidate.get(i).getFL_ZIP_CODE_TUTOR());
                    datos.put("fl_phone_home_tutor", listCandidate.get(i).getFL_PHONE_HOME_TUTOR());
                    datos.put("fl_cell_phone_tutor", listCandidate.get(i).getFL_CELL_PHONE_TUTOR());
                    datos.put("fl_mail_tutor", listCandidate.get(i).getFL_MAIL_TUTOR());
                    datos.put("fl_facebook_tutor", listCandidate.get(i).getFL_FACEBOOK_TUTOR());
                    datos.put("fl_twitter_tutor", listCandidate.get(i).getFL_TWITTER_TUTOR());
                    datos.put("fl_emergency_phone1", listCandidate.get(i).getFL_EMERGENCY_PHONE1());
                    datos.put("fl_emergency_phone2", listCandidate.get(i).getFL_EMERGENCY_PHONE2());
                    datos.put("fl_house_status", listCandidate.get(i).getFL_HOUSE_STATUS());
                    datos.put("fl_wall_material", listCandidate.get(i).getFL_WALL_MATERIAL());
                    datos.put("fl_roof_material", listCandidate.get(i).getFL_ROOF_MATERIAL());
                    datos.put("fl_floor_material", listCandidate.get(i).getFL_FLOOR_MATERIAL());
                    datos.put("fl_room", listCandidate.get(i).getFL_ROOM());
                    datos.put("fl_dining_room", listCandidate.get(i).getFL_DINING_ROOM());
                    datos.put("fl_kitchen", listCandidate.get(i).getFL_KITCHEN());
                    datos.put("fl_toilet", listCandidate.get(i).getFL_TOILET());
                    datos.put("fl_television", listCandidate.get(i).getFL_TELEVISION());
                    datos.put("fl_stereo", listCandidate.get(i).getFL_STEREO());
                    datos.put("fl_dvd", listCandidate.get(i).getFL_DVD());
                    datos.put("fl_computer", listCandidate.get(i).getFL_COMPUTER());
                    datos.put("fl_number_members_famly", listCandidate.get(i).getFL_NUMBER_MEMBERS_FAMLY());
                    datos.put("fl_laptop", listCandidate.get(i).getFL_LAPTOP());
                    datos.put("fl_refrigerator", listCandidate.get(i).getFL_REFRIGERATOR());
                    datos.put("fl_washer", listCandidate.get(i).getFL_WASHER());
                    datos.put("fl_stove", listCandidate.get(i).getFL_STOVE());
                    datos.put("fl_family_monthly_income", listCandidate.get(i).getFL_FAMILY_MONTHLY_INCOME());
                    datos.put("fl_family_monthly_discharge", listCandidate.get(i).getFL_FAMILY_MONTHLY_DISCHARGE());
                    datos.put("fl_candidate_montgly_income", listCandidate.get(i).getFL_STUDENT_MONTGLY_INCOME());
                    datos.put("fl_candidate_montgly_discharge", listCandidate.get(i).getFL_STUDENT_MONTGLY_DISCHARGE());
                    datos.put("fl_diffusion_call", listCandidate.get(i).getFL_DIFFUSION_CALL());
                    datos.put("fl_diffusion_cartel", listCandidate.get(i).getFL_DIFFUSION_CARTEL());
                    datos.put("fl_diffusion_plantel_talks", listCandidate.get(i).getFL_DIFFUSION_PLANTEL_TALKS());
                    datos.put("fl_diffusion_personal_ut", listCandidate.get(i).getFL_DIFFUSION_PERSONAL_UT());
                    datos.put("fl_diffusion_graduates", listCandidate.get(i).getFL_DIFFUSION_GRADUATES());
                    datos.put("fl_diffusion_family_friends", listCandidate.get(i).getFL_DIFFUSION_FAMILY_FRIENDS());
                    datos.put("fl_diffusion_directlt_ut", listCandidate.get(i).getFL_DIFFUSION_DIRECTLT_UT());
                    datos.put("fl_diffusion_brochure", listCandidate.get(i).getFL_DIFFUSION_BROCHURE());
                    datos.put("fl_diffusion_newspaper", listCandidate.get(i).getFL_DIFFUSION_NEWSPAPER());
                    datos.put("fl_diffusion_candidates_ut", listCandidate.get(i).getFL_DIFFUSION_STUDENTS_UT());
                    datos.put("fl_diffusion_manta", listCandidate.get(i).getFL_DIFFUSION_MANTA());
                    datos.put("fl_diffusion_triptych", listCandidate.get(i).getFL_DIFFUSION_TRIPTYCH());
                    datos.put("fl_diffusion_guided_visits", listCandidate.get(i).getFL_DIFFUSION_GUIDED_VISITS());
                    datos.put("fl_diffusion_exhibitions", listCandidate.get(i).getFL_DIFFUSION_EXHIBITIONS());
                    datos.put("fl_diffusion_other", listCandidate.get(i).getFL_DIFFUSION_OTHER());
                    datos.put("fl_diffusion_other_name", listCandidate.get(i).getFL_DIFFUSION_OTHER_NAME());
                    datos.put("fl_option_utsem_study", listCandidate.get(i).getFL_OPTION_UTSEM_STUDY());
                    datos.put("fl_physical_disability", listCandidate.get(i).getFL_PHYSICAL_DISABILITY());
                    datos.put("fl_disability_name", listCandidate.get(i).getFL_DISABILITY_NAME());
                    datos.put("fl_indigenous_group", listCandidate.get(i).getFL_INDIGENOUS_GROUP());
                    datos.put("fl_indigenous_group_name", listCandidate.get(i).getFL_INDIGENOUS_GROUP_NAME());
                    datos.put("fl_secutity_medical", listCandidate.get(i).getFL_SECUTITY_MEDICAL());
                    datos.put("fl_security_name", listCandidate.get(i).getFL_SECURITY_NAME());
                    datos.put("fl_number_security_medical", listCandidate.get(i).getFL_NUMBER_SECURITY_MEDICAL());
                    
                    datos.put("fl_whom_depend",listCandidate.get(i).getFL_WHOM_DEPEND());
                    datos.put("fl_depend_economically_work",listCandidate.get(i).getFL_DEPEND_ECONOMICALLY_WORK());
                    datos.put("fl_where_work",listCandidate.get(i).getFL_WHERE_WORK());
                    datos.put("fl_what_work",listCandidate.get(i).getFL_WHAT_WORK());
                        
                    datos.put("fl_acept_term", listCandidate.get(i).getFL_ACEPT_TERM()); 
                    response.setContentType("application/json"); 
                    out.print(datos);
                    out.flush(); 
                    out.close();
                }                
            }
            if(request.getParameter("statusAcount")!=null){
                if(request.getParameter("statusLogin")!=null){                    
                    String statusLogin = request.getParameter("statusLogin");
                    switch (statusLogin) {
                        case "in":
                            String userName = request.getParameter("userName");
                            String password = request.getParameter("password");
                            int status = new candidateControl().SelectUserStatusAcount(userName, password);
                            String name = "";
                            String mail = "";
                            String folioSystem ="";
                            ArrayList<studentModel> list=new candidateControl().SelectUserLogin(userName, password);
                            for (studentModel list1 : list) {
                                name = list1.getFL_NAME();
                                folioSystem = list1.getFL_FOLIO_TEMP_SYSTEM();
                                mail = list1.getFL_MAIL();
                            }   
                            if(userName != null && password != null){
                                if(list.size()==1){
                                    if(status==1){
                                        session.setAttribute("folioSystem", folioSystem);
                                        session.setAttribute("mailCandidate", mail);
                                        session.setAttribute("passwordCandidate", password);
                                        session.setAttribute("logueadoCandidate", name);
                                        out.print(status+"logeado");
                                    }else{
                                        out.print(status+"noLogeado");
                                    }                                        
                                }else{
                                    out.print(status+"notExit");
                                    session.removeAttribute("folioSystem");
                                    session.removeAttribute("mailCandidate");
                                    session.removeAttribute("passwordCandidate");
                                    session.removeAttribute("logueadoCandidate");
                                }
                            }   
                            break;
                        case "logged":
                            JSONObject statusl = new JSONObject();
                            response.setContentType("application/json");
                            if(session.getAttribute("logueadoCandidate")!=null){
                                statusl.put("status", true);
                            }else{
                                statusl.put("status", false);                     
                            }
                            out.print(statusl);  
                            break;
                        case "out":
                            session.removeAttribute("folioSystem");
                            session.removeAttribute("mailCandidate");
                            session.removeAttribute("passwordCandidate");
                            session.removeAttribute("logueadoCandidate");
                            response.sendRedirect("http://www.utsem.edu.mx/ut/?correcto");
                            break;
                        default:
                            session.removeAttribute("folioSystem");
                            session.removeAttribute("mailCandidate");
                            session.removeAttribute("passwordCandidate");
                            session.removeAttribute("logueadoCandidate");
                            response.sendRedirect("http://www.utsem.edu.mx/ut/");
                            break;
                    }
                }
            }     
            if(request.getParameter("insert")!=null){
                if(request.getParameter("userNameRegister")!=null && request.getParameter("email")!=null && request.getParameter("password1")!=null){
                    String inserted=new candidateControl().InsertCandidate(request.getParameter("userNameRegister"), request.getParameter("email"), request.getParameter("password1"));
                    out.print(inserted);
                }
            }
            if(request.getParameter("updateField")!=null){
                String folioSystem =(session.getAttribute("folioSystem").toString());
                String field_name=request.getParameter("field_name"); 
                String field_value=request.getParameter("field_value");
                out.print(new candidateControl().UpdateCandidate(folioSystem, field_name, field_value));
            }
            if(request.getParameter("preregister")!=null){     
                String folioSystem =request.getParameter("folioSystem");
                String folioUtsem=request.getParameter("folioUtsem"); 
                String period=request.getParameter("period");
                out.print(new candidateControl().Preregister(folioSystem, folioUtsem, period));
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