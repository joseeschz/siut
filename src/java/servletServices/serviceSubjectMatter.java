/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletServices;

import control.subjectMattersControl;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.subjectMattersModel;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author CARLOS
 */
@WebServlet(name = "serviceSubjectMatter", urlPatterns = {"/serviceSubjectMatter"})
public class serviceSubjectMatter extends HttpServlet {

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
            if(request.getParameter("view")!=null){
                int pkTeacher=0;
                int pkPeriod;
                int pkGroup;
                int pkCareer;
                int pkSemester;
                int pkStudyPlan;
                ArrayList<subjectMattersModel> listSubjectMatters=null;
                JSONArray principal = new JSONArray();
                JSONObject settings = new JSONObject();
                JSONArray content = new JSONArray();
                settings.put("__subjetMatterModel","SubjetMatter");
                if(request.getParameter("view").equals("combo")){
                    pkSemester = Integer.parseInt(request.getParameter("pkSemester"));
                    if(request.getParameter("teacher")!=null){
                        pkCareer = Integer.parseInt(request.getParameter("pkCareer"));
                        pkPeriod = Integer.parseInt(request.getParameter("pkPeriod"));
                        pkGroup = Integer.parseInt(request.getParameter("pkGroup"));
                        if(session.getAttribute("logueado")!=null){
                            pkTeacher=Integer.parseInt(session.getAttribute("pkUser").toString());
                        }
                        listSubjectMatters=new subjectMattersControl().SelectSubjectMattersByTeacher(pkTeacher, pkCareer, pkPeriod, pkSemester, pkGroup);
                    }else if(request.getParameter("byGroup")!=null){
                        pkCareer = Integer.parseInt(request.getParameter("pkCareer"));
                        pkGroup = Integer.parseInt(request.getParameter("pkGroup"));
                        pkPeriod = Integer.parseInt(request.getParameter("pkPeriod"));
                        listSubjectMatters=new subjectMattersControl().SelectSubjectMattersByGroup(pkCareer, pkSemester, pkGroup, pkPeriod);
                    }else if(request.getParameter("comboByCurrentSemester")!=null){
                        pkCareer = Integer.parseInt(request.getParameter("pkCareer"));
                        pkStudyPlan = Integer.parseInt(request.getParameter("pkStudyPlan"));
                        pkSemester = Integer.parseInt(request.getParameter("pkSemester"));                        
                        pkPeriod = Integer.parseInt(request.getParameter("pkPeriod"));
                        listSubjectMatters=new subjectMattersControl().SelectSubjectMattersByCurrentSemester(pkCareer, pkSemester, pkStudyPlan, pkPeriod);
                    }else{
                        pkCareer = Integer.parseInt(request.getParameter("pkCareer"));
                        pkGroup = Integer.parseInt(request.getParameter("pkGroup"));
                        pkStudyPlan = Integer.parseInt(request.getParameter("pkStudyPlan"));
                        pkPeriod = Integer.parseInt(request.getParameter("pkPeriod"));
                        listSubjectMatters=new subjectMattersControl().SelectSubjectMatters(pkCareer, pkSemester, pkGroup, pkStudyPlan, pkPeriod);
                    }
                }else if(request.getParameter("view").equals("comboMattersByStudent")){
                    int pkStudent = 0;
                    if(session.getAttribute("pkStudent")!=null){
                        pkStudent = Integer.parseInt(session.getAttribute("pkStudent").toString());
                    }
                    if(request.getParameter("pkStudent")!=null){
                        pkStudent = Integer.parseInt(request.getParameter("pkStudent"));
                    }
                    listSubjectMatters=new subjectMattersControl().SelectListSubjectMattersByStudents(pkStudent);
                }else if(request.getParameter("view").equals("comboWithoutGroup")){
                    pkSemester = Integer.parseInt(request.getParameter("pkSemester"));
                    if(request.getParameter("teacher")!=null){
                        pkCareer = Integer.parseInt(request.getParameter("pkCareer"));
                        pkPeriod = Integer.parseInt(request.getParameter("pkPeriod"));
                        if(session.getAttribute("logueado")!=null){
                            pkTeacher=Integer.parseInt(session.getAttribute("pkUser").toString());
                        }
                        listSubjectMatters=new subjectMattersControl().SelectSubjectMattersByTeacher(pkTeacher, pkCareer, pkPeriod, pkSemester, 0);
                    }
                }else{
                    pkSemester = Integer.parseInt(request.getParameter("pkSemester"));
                    pkCareer = Integer.parseInt(request.getParameter("pkCareer"));
                    pkStudyPlan = Integer.parseInt(request.getParameter("pkStudyPlan"));
                    listSubjectMatters=new subjectMattersControl().SelectSubjectMatters(pkCareer, pkSemester, 0, pkStudyPlan, 0);
                }  
                for(int i=0;i<listSubjectMatters.size();i++){
                    JSONObject data = new JSONObject();
                    data.put("id", listSubjectMatters.get(i).getPK_SUBJECT_MATTER());
                    data.put("dataProgresivNumber", i+1);
                    data.put("dataPkTeacher", listSubjectMatters.get(i).getPK_WORKER());
                    data.put("dataPkSubjectMatter", listSubjectMatters.get(i).getPK_SUBJECT_MATTER());
                    data.put("dataNameSubjectMatter", listSubjectMatters.get(i).getFL_NAME_SUBJECT_MATTER());
                    data.put("dataNameWorker", listSubjectMatters.get(i).getFL_NAME_WORKER());
                    data.put("dataIntegradora", listSubjectMatters.get(i).getFL_INTEGRADORA());
                    data.put("dataCantHous", listSubjectMatters.get(i).getFL_CANT_HOURS());
                    data.put("dataFkStudyPlan", listSubjectMatters.get(i).getFK_STUDY_PLAN());
                    data.put("dataNamePlan", listSubjectMatters.get(i).getFL_NAME_PLAN());
                    data.put("dataFkSemester", listSubjectMatters.get(i).getFK_SEMESTER());
                    data.put("dataNameSemester", listSubjectMatters.get(i).getFL_NAME_SEMESTER());
                    content.add(data); 
                }
                settings.put("__ENTITIES", content);
                principal.add(settings);
                response.setHeader("Access-Control-Allow-Origin", "*");
                response.setHeader("Access-Control-Allow-Methods", "POST,PUT, GET, OPTIONS, DELETE");
                response.setHeader("Access-Control-Max-Age", "3600");
                response.setHeader("Access-Control-Allow-Headers"," Origin, X-Requested-With, Content-Type, Accept,AUTH-TOKEN");
                response.setContentType("application/json");
                out.print(principal);
                out.flush(); 
                out.close();
            }
            if(request.getParameter("insert")!=null){
                if(request.getParameter("fkSemester") != null && request.getParameter("fkStudyPlan") != null ){
                    subjectMattersModel dataSubjectMatters=new subjectMattersModel();
                    dataSubjectMatters.setFL_NAME_SUBJECT_MATTER(request.getParameter("nameSubjectMatter"));
                    dataSubjectMatters.setFL_INTEGRADORA(request.getParameter("integradora"));
                    dataSubjectMatters.setFK_SEMESTER(Integer.parseInt(request.getParameter("fkSemester")));
                    dataSubjectMatters.setFK_STUDY_PLAN(Integer.parseInt(request.getParameter("fkStudyPlan")));
                    dataSubjectMatters.setFL_CANT_HOURS(Integer.parseInt(request.getParameter("cantHours")));
                    out.print(new subjectMattersControl().InsertSubjectMatters(dataSubjectMatters));
                }                
            }
            if(request.getParameter("update")!=null){       
                if(request.getParameter("pkSubjectMatter") != null && request.getParameter("fkSemester") != null && request.getParameter("fkStudyPlan") != null){
                    subjectMattersModel dataSubjectMatters=new subjectMattersModel();
                    dataSubjectMatters.setPK_SUBJECT_MATTER(Integer.parseInt(request.getParameter("pkSubjectMatter")));
                    dataSubjectMatters.setFL_NAME_SUBJECT_MATTER(request.getParameter("nameSubjectMatter"));
                    dataSubjectMatters.setFL_INTEGRADORA(request.getParameter("integradora"));
                    dataSubjectMatters.setFK_SEMESTER(Integer.parseInt(request.getParameter("fkSemester")));
                    dataSubjectMatters.setFK_STUDY_PLAN(Integer.parseInt(request.getParameter("fkStudyPlan")));
                    dataSubjectMatters.setFL_CANT_HOURS(Integer.parseInt(request.getParameter("cantHours")));
                    out.print(new subjectMattersControl().UpdateSubjectMatters(dataSubjectMatters));
                }                
            }
            if(request.getParameter("delete")!=null){       
                if(request.getParameter("pkSubjectMatter") != null){
                    out.print(new subjectMattersControl().DeleteSubjectMatters(Integer.parseInt(request.getParameter("pkSubjectMatter"))));
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
