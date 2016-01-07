/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletServices;

import control.semesterControl;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.semesterModel;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author CARLOS
 */
@WebServlet(name = "serviceSemester", urlPatterns = {"/serviceSemester"})
public class serviceSemester extends HttpServlet {

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
            int pkStudyLevel=Integer.parseInt(request.getParameter("pkStudyLevel"));
            int pkUser=0;
            int pkPeriod;
            if(request.getParameter("view")!=null){
                ArrayList<semesterModel> listSemester;
                JSONArray principal = new JSONArray();
                JSONObject settings = new JSONObject();
                JSONArray content = new JSONArray();
                settings.put("__semesterModel","Semester");
                if(request.getParameter("view").equals("combo")){
                    if(request.getParameter("teacher")!=null){
                        pkPeriod=Integer.parseInt(request.getParameter("pkPeriod"));
                        if(session.getAttribute("logueado")!=null){
                            pkUser = Integer.parseInt(session.getAttribute("pkUser").toString());
                        }
                        listSemester=new semesterControl().SelectSemesterByTeacher(pkUser, pkStudyLevel, pkPeriod);
                    }else if(request.getParameter("teacherTutor")!=null){
                        pkPeriod=Integer.parseInt(request.getParameter("pkPeriod"));
                        if(session.getAttribute("logueado")!=null){
                            pkUser = Integer.parseInt(session.getAttribute("pkUser").toString());
                        }
                        listSemester=new semesterControl().SelectSemesterByTeacherTutor(pkUser, pkStudyLevel, pkPeriod);
                    }else if(request.getParameter("director")!=null){
                        pkPeriod=Integer.parseInt(request.getParameter("pkPeriod"));
                        if(session.getAttribute("logueado")!=null){
                            pkUser = Integer.parseInt(session.getAttribute("pkUser").toString());
                        }
                        listSemester=new semesterControl().SelectSemesterByDirector(pkUser, pkStudyLevel, pkPeriod);
                    }else{
                        listSemester=new semesterControl().SelectSemester(pkStudyLevel);
                    }
                    for(int i=0;i<listSemester.size();i++){
                        JSONObject datos = new JSONObject();
                        datos.put("id", listSemester.get(i).getPK_SEMESTER());
                        datos.put("dataProgresivNumber", i+1);
                        datos.put("dataValueSemester", listSemester.get(i).getPK_SEMESTER());
                        datos.put("dataNameSemester", listSemester.get(i).getFL_NAME_SEMESTER());
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
