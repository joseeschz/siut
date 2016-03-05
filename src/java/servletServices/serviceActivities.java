/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletServices;

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
import model.activitiesToGroupModel;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author CARLOS
 */
@WebServlet(name = "serviceActivities", urlPatterns = {"/serviceActivities"})
public class serviceActivities extends HttpServlet {
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
        HttpSession session = request.getSession();
        try (PrintWriter out = response.getWriter()) {
            if(request.getParameter("listActivities")!=null){
                int fk_period = Integer.parseInt(request.getParameter("fk_period"));
                int fk_study_level = Integer.parseInt(request.getParameter("fk_study_level"));
                int fk_subject_matter = Integer.parseInt(request.getParameter("fk_subject_matter"));
                int fk_scale_evaluation = Integer.parseInt(request.getParameter("fk_scale_evaluation"));
                ArrayList<activitiesToGroupModel> listActivity=new activitiesToGroupControl().SelectActivitiesByScale(fk_period, fk_study_level, fk_subject_matter, fk_scale_evaluation);
                JSONArray principal = new JSONArray();
                JSONObject settings = new JSONObject();
                JSONArray content = new JSONArray();
                settings.put("__ActivityToWorkModel","ActivityToWork");
                for(int i=0;i<listActivity.size();i++){
                    JSONObject data = new JSONObject();
                    data.put("id", listActivity.get(i).getPK_ACTIVITY());
                    data.put("dataProgresivNumber", i+1);
                    data.put("dataPkActivity", listActivity.get(i).getPK_ACTIVITY());
                    data.put("dataNameActivity", listActivity.get(i).getFL_NAME_ACTIVITY());
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
            if(request.getParameter("view")!=null){
                int pkWorkPlanning = Integer.parseInt(request.getParameter("pkWorkPlanning"));
                int fk_period = Integer.parseInt(request.getParameter("fk_period"));
                int fk_teacher = Integer.parseInt(session.getAttribute("pkUser").toString());
                int fk_study_level = Integer.parseInt(request.getParameter("fk_study_level"));
                int fk_subject_matter = Integer.parseInt(request.getParameter("fk_subject_matter"));
                int fk_scale_evaluation = Integer.parseInt(request.getParameter("fk_scale_evaluation"));
                ArrayList<activitiesToGroupModel> listActivity=new activitiesToGroupControl().SelectActivitiesToGroup(pkWorkPlanning, fk_period, fk_teacher, fk_study_level, fk_subject_matter, fk_scale_evaluation);
                JSONArray principal = new JSONArray();
                JSONObject settings = new JSONObject();
                JSONArray content = new JSONArray();
                settings.put("__ActivityToWorkModel","ActivityToWork");
                for(int i=0;i<listActivity.size();i++){
                    JSONObject data = new JSONObject();
                    data.put("id", listActivity.get(i).getPK_ACTIVITY());
                    data.put("dataProgresivNumber", i+1);
                    data.put("dataPkActivity", listActivity.get(i).getPK_ACTIVITY());
                    data.put("dataNumActivity", listActivity.get(i).getFL_NUM());
                    data.put("dataNameActivity", listActivity.get(i).getFL_NAME_ACTIVITY());
                    data.put("dataDescriptionActivity", listActivity.get(i).getFL_DESCRIPTION());
                    data.put("dataCreationDate", listActivity.get(i).getFL_CREATION_DATE());
                    data.put("dataLastDateUpdate", listActivity.get(i).getFL_LAST_DATE_UPDATE());
                    data.put("dataValueActivity", listActivity.get(i).getFL_VALUE_ACTIVITY());
                    data.put("dataValueActivityPercent",listActivity.get(i).getFL_VALUE_ACTIVITY_PERCENT());
                    data.put("dataPkScaleEvaluation", listActivity.get(i).getPK_SCALE_EVALUATION());
                    data.put("dataNameScale", listActivity.get(i).getFL_NAME_SCALE());
                    data.put("dataMaxValue", listActivity.get(i).getFL_MAX_VALUE());
                    data.put("dataPkWorkPlanning", listActivity.get(i).getPK_WORK_PLANNING());
                    content.add(data); 
                }
                settings.put("__ENTITIES", content);
                principal.add(settings);
                response.setContentType("application/json"); 
                out.print(principal);
                out.flush(); 
                out.close();
            }
            if(request.getParameter("valueMaxActiity")!=null){
                int pkActivity = Integer.parseInt(request.getParameter("pkActivity"));
                ArrayList<activitiesToGroupModel> listActivity=new activitiesToGroupControl().SelectActivityToGroup(pkActivity);
                JSONArray principal = new JSONArray();
                JSONObject settings = new JSONObject();
                JSONArray content = new JSONArray();
                settings.put("__ActivityToWorkModel","ActivityToWork");
                for(int i=0;i<listActivity.size();i++){
                    JSONObject data = new JSONObject();
                    data.put("id", listActivity.get(i).getPK_ACTIVITY());
                    data.put("dataProgresivNumber", i+1);
                    data.put("dataPkActivity", listActivity.get(i).getPK_ACTIVITY());
                    data.put("dataNameActivity", listActivity.get(i).getFL_NAME_ACTIVITY());
                    data.put("dataDescriptionActivity", listActivity.get(i).getFL_DESCRIPTION());
                    data.put("dataCreationDate", listActivity.get(i).getFL_CREATION_DATE());
                    data.put("dataLastDateUpdate", listActivity.get(i).getFL_LAST_DATE_UPDATE());
                    data.put("dataValueActivity", listActivity.get(i).getFL_VALUE_ACTIVITY());
                    content.add(data); 
                }
                settings.put("__ENTITIES", content);
                principal.add(settings);
                response.setContentType("application/json"); 
                out.print(content);
                out.flush(); 
                out.close();
            }
            if(request.getParameter("exitWorkPlanning")!=null){
                int fk_period = Integer.parseInt(request.getParameter("fk_period"));
                int fk_teacher = Integer.parseInt(session.getAttribute("pkUser").toString());
                int fk_study_level = Integer.parseInt(request.getParameter("fk_study_level"));
                int fk_subject_matter = Integer.parseInt(request.getParameter("fk_subject_matter"));
                int fk_scale_evaluation = Integer.parseInt(request.getParameter("fk_scale_evaluation"));
                JSONObject data = new JSONObject();
                String[] result = new activitiesToGroupControl().SelectWorkPlanning(fk_teacher, fk_study_level, fk_subject_matter, fk_scale_evaluation, fk_period);
                data.put("dataResult",result[0]);
                data.put("dataPkWorkPlanning",result[1]);
                data.put("dataIndication",result[2]);
                data.put("dataRealized",result[3]);
                data.put("dataRealizedBlock",result[4]);
                data.put("dataObservations",result[5]);
                data.put("dataPrintDate",result[6]);
                out.print(data);
            }
            if(request.getParameter("disponibilityValueByWorkPlanning")!=null){
                int fk_work_planning = Integer.parseInt(request.getParameter("fk_work_planning"));
                int fk_scale_evaluation = Integer.parseInt(request.getParameter("fk_scale_evaluation"));
                JSONObject data = new JSONObject();
                String[] result = new activitiesToGroupControl().SelectDisponibilityValueByWorkPlanning(fk_work_planning, fk_scale_evaluation);
                data.put("dataResult",result[0]);
                out.print(data);
            }
            if(request.getParameter("lockWorkPlanning")!=null){
                int fk_work_planning = Integer.parseInt(request.getParameter("fk_work_planning"));
                JSONObject data = new JSONObject();
                String[] result = new activitiesToGroupControl().BlockWorkPlanning(fk_work_planning);
                data.put("dataResult",result[0]);
                data.put("dataStatusResult",result[1]);
                out.print(data);
            }  
            if(request.getParameter("unlockWorkPlanning")!=null){
                int fk_work_planning = Integer.parseInt(request.getParameter("fk_work_planning"));
                JSONObject data = new JSONObject();
                String[] result = new activitiesToGroupControl().UnblockWorkPlanning(fk_work_planning);
                data.put("dataResult",result[0]);
                data.put("dataStatusResult",result[1]);
                out.print(data);
            } 
            if(request.getParameter("insert")!=null){
                activitiesToGroupModel dataActivitiesToGroup=new activitiesToGroupModel();
                int pkWorkPlanning = Integer.parseInt(request.getParameter("pkWorkPlanning"));
                int pkScaleEvaluation = Integer.parseInt(request.getParameter("pkScaleEvaluation"));
                String nameActivity=request.getParameter("nameActivity");
                double valueActivity=Double.parseDouble(request.getParameter("valueActivity"));
                String descriptionActivity=request.getParameter("descriptionActivity");
                dataActivitiesToGroup.setFL_NAME_ACTIVITY(nameActivity);
                dataActivitiesToGroup.setFL_VALUE_ACTIVITY(valueActivity);
                dataActivitiesToGroup.setFL_DESCRIPTION(descriptionActivity);
                dataActivitiesToGroup.setPK_WORK_PLANNING(pkWorkPlanning);
                dataActivitiesToGroup.setFK_SCALE_EVALUATION(pkScaleEvaluation);
                out.print(new activitiesToGroupControl().InsertActivitiesToGroup(dataActivitiesToGroup));               
            }
            if(request.getParameter("insertImported")!=null){
                activitiesToGroupModel dataActivitiesToGroup=new activitiesToGroupModel();
                int pkWorkPlanning = Integer.parseInt(request.getParameter("pkWorkPlanning"));
                String pkActivity = request.getParameter("pkActivity");
                dataActivitiesToGroup.setPK_ACTIVITY(pkActivity);
                dataActivitiesToGroup.setPK_WORK_PLANNING(pkWorkPlanning);
                out.print(new activitiesToGroupControl().InsertActivitiesToGroupImported(dataActivitiesToGroup));               
            }
            if(request.getParameter("insertImportedAll")!=null){
                int pkWorkPlanningNew = Integer.parseInt(request.getParameter("pkWorkPlanningNew"));
                int pkWorkPlanningOld = Integer.parseInt(request.getParameter("pkWorkPlanningOld"));
                out.print(new activitiesToGroupControl().InsertActivitiesToGroupImportedAll(pkWorkPlanningNew, pkWorkPlanningOld));               
            }
            if(request.getParameter("insertWorkPlanning")!=null){
                int fk_period = Integer.parseInt(request.getParameter("fk_period"));
                int fk_teacher = Integer.parseInt(session.getAttribute("pkUser").toString());
                int fk_study_level = Integer.parseInt(request.getParameter("fk_study_level"));
                int fk_subject_matter = Integer.parseInt(request.getParameter("fk_subject_matter"));
                int fk_scale_evaluation = Integer.parseInt(request.getParameter("fk_scale_evaluation"));
                JSONObject data = new JSONObject();
                String[] result = new activitiesToGroupControl().InsertWorkPlanning(fk_teacher, fk_study_level, fk_subject_matter, fk_scale_evaluation, fk_period);
                data.put("dataResult", result[0]);
                data.put("dataPkWorkPlanning", result[1]);
                out.print(data);
            }
            if(request.getParameter("setObservations")!=null){
                int fk_period = Integer.parseInt(request.getParameter("fkPeriod"));
                int fk_teacher = Integer.parseInt(session.getAttribute("pkUser").toString());
                int fk_study_level = Integer.parseInt(request.getParameter("fkStudyLevel"));
                int fk_subject_matter = Integer.parseInt(request.getParameter("fkMatter"));
                String fl_observations = request.getParameter("flObservations");
                out.print(new activitiesToGroupControl().SetObservations(fk_teacher, fk_study_level, fk_subject_matter, fk_period, fl_observations));
            }
            if(request.getParameter("setPrintDate")!=null){
                int fk_period = Integer.parseInt(request.getParameter("fkPeriod"));
                int fk_teacher = Integer.parseInt(session.getAttribute("pkUser").toString());
                int fk_study_level = Integer.parseInt(request.getParameter("fkStudyLevel"));
                int fk_subject_matter = Integer.parseInt(request.getParameter("fkMatter"));
                String fl_date_print = request.getParameter("flPrintDate");
                out.print(new activitiesToGroupControl().SetPrintDate(fk_teacher, fk_study_level, fk_subject_matter, fk_period, fl_date_print));
            }
            if(request.getParameter("update")!=null){       
                if(request.getParameter("pkActivity") != null){
                    activitiesToGroupModel dataActivitiesToGroup=new activitiesToGroupModel();
                    String pkActivity = request.getParameter("pkActivity");
                    int pkWorkPlanning = Integer.parseInt(request.getParameter("pkWorkPlanning"));
                    int pkScaleEvaluation = Integer.parseInt(request.getParameter("pkScaleEvaluation"));
                    String nameActivity=request.getParameter("nameActivity");
                    double valueActivity=Double.parseDouble(request.getParameter("valueActivity"));
                    String descriptionActivity=request.getParameter("descriptionActivity");
                    dataActivitiesToGroup.setPK_ACTIVITY(pkActivity);
                    dataActivitiesToGroup.setFL_NAME_ACTIVITY(nameActivity);
                    dataActivitiesToGroup.setFL_VALUE_ACTIVITY(valueActivity);
                    dataActivitiesToGroup.setFL_DESCRIPTION(descriptionActivity);
                    dataActivitiesToGroup.setPK_WORK_PLANNING(pkWorkPlanning);
                    dataActivitiesToGroup.setFK_SCALE_EVALUATION(pkScaleEvaluation);
                    out.print(new activitiesToGroupControl().UpdateActivitiesToGroup(dataActivitiesToGroup));
                }                
            }
            if(request.getParameter("delete")!=null){       
                if(request.getParameter("pkActivitiesToWork") != null){
                    out.print(new activitiesToGroupControl().DeleteActivitiesToGroup(Integer.parseInt(request.getParameter("pkActivitiesToWork"))));
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
