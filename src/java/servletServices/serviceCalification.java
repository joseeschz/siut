/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletServices;

import control.calificationControl;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.calificationModel;
import model.propetiesTableModel;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author Carlos
 */
@WebServlet(name = "serviceCalification", urlPatterns = {"/serviceCalification"})
public class serviceCalification extends HttpServlet {

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
                if(request.getParameter("view").equals("calificationsNow")){
                    int fkPeriod = Integer.parseInt(request.getParameter("fkPeriod"));
                    int fkMatter = Integer.parseInt(request.getParameter("fkMatter"));
                    int fkGroup = Integer.parseInt(request.getParameter("fkGroup"));
                    ArrayList<calificationModel> listStudents=new calificationControl().SelectCalificationNow(fkGroup, fkMatter, fkPeriod);
                    JSONArray principal = new JSONArray();
                    JSONObject settings = new JSONObject();
                    JSONArray content = new JSONArray();
                    settings.put("__entityModel","Students"); 
                    for(int i=0;i<listStudents.size();i++){
                        JSONObject datos = new JSONObject();
                        datos.put("id", i+1);
                        datos.put("dataProgresivNumber", i+1);
                        datos.put("dataPkCalification", listStudents.get(i).getPK_CALIFICATION());
                        datos.put("dataEnrollment", listStudents.get(i).getFL_ENROLLMENT());
                        datos.put("dataFkStudent", listStudents.get(i).getFK_STUDENT());
                        datos.put("dataStudentName", listStudents.get(i).getFL_NAME());
                        datos.put("dataCalificationBe", listStudents.get(i).getFL_CALIFICATION_BE());
                        datos.put("dataCalificationKnow", listStudents.get(i).getFL_CALIFICATION_KNOW());
                        datos.put("dataCalificationDo", listStudents.get(i).getFL_CALIFICATION_DO());
                        datos.put("dataAvg", listStudents.get(i).getFL_AVG());
                        content.add(datos); 
                    }
                    settings.put("__ENTITIES", content);
                    principal.add(settings);
                    response.setContentType("application/json"); 
                    out.print(principal);
                    out.flush(); 
                    out.close();
                }else if(request.getParameter("view").equals("recordsCalificationsAverage")){
                    int fkPeriod = Integer.parseInt(request.getParameter("fkPeriod"));
                    int fkMatter = Integer.parseInt(request.getParameter("fkMatter"));
                    int fkGroup = Integer.parseInt(request.getParameter("fkGroup"));
                    ArrayList<calificationModel> listStudents=new calificationControl().SelectCalificationRecordsAverage(fkGroup, fkMatter, fkPeriod);
                    JSONArray principal = new JSONArray();
                    JSONObject settings = new JSONObject();
                    JSONArray content = new JSONArray();
                    settings.put("__entityModel","Students"); 
                    for(int i=0;i<listStudents.size();i++){
                        JSONObject datos = new JSONObject();
                        datos.put("id", i+1);
                        datos.put("dataProgresivNumber", i+1);
                        datos.put("dataPkCalification", listStudents.get(i).getPK_CALIFICATION());
                        datos.put("dataEnrollment", listStudents.get(i).getFL_ENROLLMENT());
                        datos.put("dataFkStudent", listStudents.get(i).getFK_STUDENT());
                        datos.put("dataStudentName", listStudents.get(i).getFL_NAME());
                        datos.put("dataCalificationBe", listStudents.get(i).getFL_CALIFICATION_BE());
                        datos.put("dataCalificationKnow", listStudents.get(i).getFL_CALIFICATION_KNOW());
                        datos.put("dataCalificationDo", listStudents.get(i).getFL_CALIFICATION_DO());
                        datos.put("dataLetter", listStudents.get(i).getFL_LETTER());
                        datos.put("dataAvg", listStudents.get(i).getFL_AVG());
                        content.add(datos); 
                    }
                    settings.put("__ENTITIES", content);
                    principal.add(settings);
                    response.setContentType("application/json"); 
                    out.print(principal);
                    out.flush(); 
                    out.close();
                }else if(request.getParameter("view").equals("recordsCalificationsRegula")){
                    int fkPeriod = Integer.parseInt(request.getParameter("fkPeriod"));
                    int fkMatter = Integer.parseInt(request.getParameter("fkMatter"));
                    int fkGroup = Integer.parseInt(request.getParameter("fkGroup"));
                    ArrayList<calificationModel> listStudents=new calificationControl().SelectCalificationRecordsRegularization(fkGroup, fkMatter, fkPeriod);
                    JSONArray principal = new JSONArray();
                    JSONObject settings = new JSONObject();
                    JSONArray content = new JSONArray();
                    settings.put("__entityModel","Students"); 
                    for(int i=0;i<listStudents.size();i++){
                        JSONObject datos = new JSONObject();
                        datos.put("id", i+1);
                        datos.put("dataProgresivNumber", i+1);
                        datos.put("dataPkCalification", listStudents.get(i).getPK_CALIFICATION());
                        datos.put("dataEnrollment", listStudents.get(i).getFL_ENROLLMENT());
                        datos.put("dataFkStudent", listStudents.get(i).getFK_STUDENT());
                        datos.put("dataStudentName", listStudents.get(i).getFL_NAME());
                        datos.put("dataCalificationBe", listStudents.get(i).getFL_CALIFICATION_BE());
                        datos.put("dataCalificationKnow", listStudents.get(i).getFL_CALIFICATION_KNOW());
                        datos.put("dataCalificationDo", listStudents.get(i).getFL_CALIFICATION_DO());
                        datos.put("dataLetter", listStudents.get(i).getFL_LETTER());
                        datos.put("dataAvg", listStudents.get(i).getFL_AVG());
                        content.add(datos); 
                    }
                    settings.put("__ENTITIES", content);
                    principal.add(settings);
                    response.setContentType("application/json"); 
                    out.print(principal);
                    out.flush(); 
                    out.close();
                }else if(request.getParameter("view").equals("recordsCalificationsGlobal")){
                    int fkPeriod = Integer.parseInt(request.getParameter("fkPeriod"));
                    int fkMatter = Integer.parseInt(request.getParameter("fkMatter"));
                    int fkGroup = Integer.parseInt(request.getParameter("fkGroup"));
                    ArrayList<calificationModel> listStudents=new calificationControl().SelectCalificationRecordsGlobal(fkGroup, fkMatter, fkPeriod);
                    JSONArray principal = new JSONArray();
                    JSONObject settings = new JSONObject();
                    JSONArray content = new JSONArray();
                    settings.put("__entityModel","Students"); 
                    for(int i=0;i<listStudents.size();i++){
                        JSONObject datos = new JSONObject();
                        datos.put("id", i+1);
                        datos.put("dataProgresivNumber", i+1);
                        datos.put("dataPkCalification", listStudents.get(i).getPK_CALIFICATION());
                        datos.put("dataEnrollment", listStudents.get(i).getFL_ENROLLMENT());
                        datos.put("dataFkStudent", listStudents.get(i).getFK_STUDENT());
                        datos.put("dataStudentName", listStudents.get(i).getFL_NAME());
                        datos.put("dataCalificationBe", listStudents.get(i).getFL_CALIFICATION_BE());
                        datos.put("dataCalificationKnow", listStudents.get(i).getFL_CALIFICATION_KNOW());
                        datos.put("dataCalificationDo", listStudents.get(i).getFL_CALIFICATION_DO());
                        datos.put("dataLetter", listStudents.get(i).getFL_LETTER());
                        datos.put("dataAvg", listStudents.get(i).getFL_AVG());
                        content.add(datos); 
                    }
                    settings.put("__ENTITIES", content);
                    principal.add(settings);
                    response.setContentType("application/json"); 
                    out.print(principal);
                    out.flush(); 
                    out.close();
                }else if(request.getParameter("view").equals("recordsCalificationsDescription")){
                    ArrayList<calificationModel> listStudents=new calificationControl().SelectCalificationRecordsDescription();
                    JSONArray principal = new JSONArray();
                    JSONObject settings = new JSONObject();
                    JSONArray content = new JSONArray();
                    settings.put("__entityModel","Students"); 
                    for(int i=0;i<listStudents.size();i++){
                        JSONObject datos = new JSONObject();
                        datos.put("id", i+1);
                        datos.put("dataNoIntegradora", listStudents.get(i).getFL_NAME_DESCRIPTION_NOT_INTEGRADORAS());
                        datos.put("dataIntegradora", listStudents.get(i).getFL_NAME_DESCRIPTION_INTEGRADORAS());
                        content.add(datos);
                    }
                    settings.put("__ENTITIES", content);
                    principal.add(settings);
                    response.setContentType("application/json"); 
                    out.print(principal);
                    out.flush(); 
                    out.close();
                }
            }
            if(request.getParameter("setObservations")!=null){
                int fkMatter = Integer.parseInt(request.getParameter("fkMatter"));
                int fkGroup = Integer.parseInt(request.getParameter("fkGroup"));
                int fkPeriod = Integer.parseInt(request.getParameter("fkPeriod"));  
                int fkType = Integer.parseInt(request.getParameter("fkType"));  
                String flObservations = request.getParameter("flObservations");
                response.setContentType("text/html;charset=UTF-8"); 
                out.print(new calificationControl().SetObservations(fkType, fkMatter, fkGroup, fkPeriod, flObservations));               
            }
            if(request.getParameter("getObservations")!=null){
                int fkMatter = Integer.parseInt(request.getParameter("fkMatter"));
                int fkGroup = Integer.parseInt(request.getParameter("fkGroup"));
                int fkPeriod = Integer.parseInt(request.getParameter("fkPeriod")); 
                int fkType = Integer.parseInt(request.getParameter("fkType"));  
                response.setContentType("text/html;charset=UTF-8"); 
                out.print(new calificationControl().GetObservations(fkType, fkMatter, fkGroup, fkPeriod));               
            }
            if(request.getParameter("closeWorkPlanning")!=null){
                int fkMatter = Integer.parseInt(request.getParameter("fkMatter"));
                int fkGroup = Integer.parseInt(request.getParameter("fkGroup"));
                int fkPeriod = Integer.parseInt(request.getParameter("fkPeriod"));   
                int fkType = Integer.parseInt(request.getParameter("fkType"));  
                response.setContentType("text/html;charset=UTF-8"); 
                out.print(new calificationControl().CloseWorkPlanningByGroupMatter(fkType, fkMatter, fkGroup, fkPeriod));               
            }
            if(request.getParameter("isCloseWorkPlanning")!=null){
                int fkMatter = Integer.parseInt(request.getParameter("fkMatter"));
                int fkGroup = Integer.parseInt(request.getParameter("fkGroup"));
                int fkPeriod = Integer.parseInt(request.getParameter("fkPeriod"));
                int fkType = Integer.parseInt(request.getParameter("fkType"));  
                response.setContentType("text/html;charset=UTF-8"); 
                out.print(new calificationControl().IsCloseWorkPlanningByGroupMatter(fkType, fkMatter, fkGroup, fkPeriod));               
            }
            if(request.getParameter("table")!=null){
                int fkCareer = Integer.parseInt(request.getParameter("fkCareer"));
                int fkGroup = Integer.parseInt(request.getParameter("fkGroup"));
                int fkPeriod = Integer.parseInt(request.getParameter("fkPeriod"));                
                ArrayList<calificationModel> listStudents=new calificationControl().SelectCalificationNowTutoring(fkCareer, fkGroup, fkPeriod);
                ArrayList<calificationModel> listRowsCal=new calificationControl().SelectCalificationRows(fkCareer, fkGroup, fkPeriod);
                ArrayList<propetiesTableModel> listColumns=new calificationControl().SelectCalificationNowTutoringColumns(fkCareer, fkGroup, fkPeriod);
                JSONArray contentColums = new JSONArray();
                JSONArray contentRows = new JSONArray();
                JSONArray contentRowsCal = new JSONArray();
                JSONArray bulding = new JSONArray();
                JSONObject rows = new JSONObject();
                JSONObject rowsCal = new JSONObject();
                JSONObject columns = new JSONObject();
                for(int i=0;i<listRowsCal.size();i++){
                    JSONObject datos = new JSONObject();
                    datos.put("dataNameMatter", listRowsCal.get(i).getFL_NAME_ALIAS_SUBJECT_MATTER());
                    datos.put("dataCalMatters", listRowsCal.get(i).getFL_AVG());
                    datos.put("dataFkStudent", listRowsCal.get(i).getFK_STUDENT());
                    contentRowsCal.add(datos); 
                }
                for(int i=0;i<listStudents.size();i++){
                    JSONObject datos = new JSONObject();
                    datos.put("id", i+1);
                    datos.put("dataProgresivNumber", i+1);
                    datos.put("dataEnrollment", listStudents.get(i).getFL_ENROLLMENT());
                    datos.put("dataFkStudent", listStudents.get(i).getFK_STUDENT());
                    datos.put("dataStudentName", listStudents.get(i).getFL_NAME());
                    contentRows.add(datos); 
                }
                
                
                for(int i=0;i<listColumns.size();i++){
                    JSONObject dataColums = new JSONObject();
                    dataColums.put("text", listColumns.get(i).getFL_TEXT());
                    dataColums.put("datafield", listColumns.get(i).getFL_DATA_FIELD());
                    dataColums.put("align", listColumns.get(i).getFL_ALIGN());
                    dataColums.put("cellsalign", listColumns.get(i).getFL_CELLSALING());
                    dataColums.put("width", listColumns.get(i).getFL_WIDHT());
                    contentColums.add(dataColums); 
                }
                rows.put("rows", contentRows);
                rowsCal.put("rowsCal", contentRowsCal);
                columns.put("columns", contentColums);
                bulding.add(columns);
                bulding.add(rows);
                bulding.add(rowsCal);
                out.print(bulding);
                out.flush(); 
                out.close();
            }
            if(request.getParameter("tableDescription")!=null){
                int fkCareer = Integer.parseInt(request.getParameter("fkCareer"));
                int fkGroup = Integer.parseInt(request.getParameter("fkGroup"));
                int fkPeriod = Integer.parseInt(request.getParameter("fkPeriod"));                
                ArrayList<propetiesTableModel> listColumns=new calificationControl().SelectCalificationNowTutoringColumnsDescription(fkCareer, fkGroup, fkPeriod);
                JSONArray contentColums = new JSONArray();
                JSONArray bulding = new JSONArray();
                JSONObject columns = new JSONObject();
                for(int i=0;i<listColumns.size();i++){
                    JSONObject dataColums = new JSONObject();
                    dataColums.put("text", listColumns.get(i).getFL_TEXT());
                    dataColums.put("textExtends", listColumns.get(i).getFL_TEXT_EXTENDS());
                    contentColums.add(dataColums); 
                }
                columns.put("columns", contentColums);
                bulding.add(columns);                
                out.print(bulding);
                out.flush(); 
                out.close();
            }
            if(request.getParameter("tableCalMattersStudent")!=null){
                int pkStudent = Integer.parseInt(session.getAttribute("pkStudent").toString());                
                ArrayList<calificationModel> listColumns=new calificationControl().SelectCalificationNowStudent(pkStudent);
                JSONArray contentRows = new JSONArray();
                JSONArray bulding = new JSONArray();
                JSONObject rows = new JSONObject();
                for(int i=0;i<listColumns.size();i++){
                    JSONObject dataRows = new JSONObject();
                    dataRows.put("dataNameSubjectMatter", listColumns.get(i).getFL_NAME_SUBJECT_MATTER());
                    dataRows.put("dataAvg", listColumns.get(i).getFL_AVG());
                    contentRows.add(dataRows); 
                }
                rows.put("rows", contentRows);
                bulding.add(rows);                
                out.print(bulding);
                out.flush(); 
                out.close();
            }
            if(request.getParameter("tableCalMattersStudentHistory")!=null){
                int pkStudent = Integer.parseInt(session.getAttribute("pkStudent").toString()); 
                int pkPeriod = Integer.parseInt(request.getParameter("pkPeriod")); 
                ArrayList<calificationModel> listColumns=new calificationControl().SelectCalificationHistoryStudent(pkStudent, pkPeriod);
                JSONArray contentRows = new JSONArray();
                JSONArray bulding = new JSONArray();
                JSONObject rows = new JSONObject();
                for(int i=0;i<listColumns.size();i++){
                    JSONObject dataRows = new JSONObject();
                    dataRows.put("dataNameSubjectMatter", listColumns.get(i).getFL_NAME_SUBJECT_MATTER());
                    dataRows.put("dataAvg", listColumns.get(i).getFL_AVG());
                    contentRows.add(dataRows); 
                }
                rows.put("rows", contentRows);
                bulding.add(rows);                
                out.print(bulding);
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