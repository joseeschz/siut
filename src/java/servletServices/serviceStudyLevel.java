/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletServices;

import control.studyLevelControl;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.studyLevelModel;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author CARLOS
 */
@WebServlet(name = "serviceStudyLevel", urlPatterns = {"/serviceStudyLevel"})
public class serviceStudyLevel extends HttpServlet {

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
                ArrayList<studyLevelModel> listStudyLevel;
                JSONArray principal = new JSONArray();
                JSONObject settings = new JSONObject();
                JSONArray content = new JSONArray();
                int pkUser=0;
                settings.put("__careerModel","StudyLevel");
                if(request.getParameter("view").equals("combo")){                    
                    if(request.getParameter("teacher")!=null){
                        if(session.getAttribute("logueado")!=null){
                            pkUser=Integer.parseInt(session.getAttribute("pkUser").toString());
                        }
                        listStudyLevel = new studyLevelControl().SelectStudyLevelByTeacher(pkUser);
                    }else if(request.getParameter("teacherTutor")!=null){
                        if(session.getAttribute("logueado")!=null){
                            pkUser=Integer.parseInt(session.getAttribute("pkUser").toString());
                        }
                        listStudyLevel = new studyLevelControl().SelectStudyLevelByTeacherTutor(pkUser);
                    }else if(request.getParameter("director")!=null){
                        if(session.getAttribute("logueado")!=null){
                            pkUser=Integer.parseInt(session.getAttribute("pkUser").toString());
                        }
                        listStudyLevel = new studyLevelControl().SelectStudyLevelByDirector(pkUser);
                    }else{
                        listStudyLevel = new studyLevelControl().SelectStudyLevel("byStatus");
                    }
                }else{
                    listStudyLevel = new studyLevelControl().SelectStudyLevel("all");
                }  
                for(int i=0;i<listStudyLevel.size();i++){
                    JSONObject data = new JSONObject();
                    data.put("id", listStudyLevel.get(i).getPK_LEVEL_STUDY());
                    data.put("dataProgresivNumber", i+1);
                    data.put("dataPkStudyLevel", listStudyLevel.get(i).getPK_LEVEL_STUDY());
                    data.put("dataNameStudyLevel", listStudyLevel.get(i).getFL_NAME_LEVEL());
                    data.put("dataStatus", listStudyLevel.get(i).getFL_STATUS());
                    content.add(data); 
                }
                settings.put("__ENTITIES", content);
                principal.add(settings);
                response.setContentType("application/json"); 
                out.print(principal);
                out.flush(); 
                out.close();
            }
            if(request.getParameter("insert")!=null){
                if(request.getParameter("nameStudyLevel") != null){
                    studyLevelModel dataStudyLevel=new studyLevelModel();
                    dataStudyLevel.setFL_NAME_LEVEL(request.getParameter("nameStudyLevel"));
                    dataStudyLevel.setFL_STATUS(request.getParameter("status"));
                    out.print(new studyLevelControl().InsertStudyLevel(dataStudyLevel));
                }                
            }
            if(request.getParameter("update")!=null){       
                if(request.getParameter("pkStudyLevel") != null){
                    studyLevelModel dataStudyLevel=new studyLevelModel();
                    dataStudyLevel.setPK_LEVEL_STUDY(Integer.parseInt(request.getParameter("pkStudyLevel")));
                    dataStudyLevel.setFL_NAME_LEVEL(request.getParameter("nameStudyLevel"));
                    dataStudyLevel.setFL_STATUS(request.getParameter("status"));
                    out.print(new studyLevelControl().UpdateStudyLevel(dataStudyLevel));
                }                
            }
            if(request.getParameter("delete")!=null){       
                if(request.getParameter("pkStudyLevel") != null){
                    out.print(new studyLevelControl().DeleteStudyLevel(Integer.parseInt(request.getParameter("pkStudyLevel"))));
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
