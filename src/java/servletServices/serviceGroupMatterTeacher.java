/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletServices;

import control.groupMatterTeacherControl;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.groupMatterTeacherModel;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author CARLOS
 */
@WebServlet(name = "serviceGroupMatterTeacher", urlPatterns = {"/serviceGroupMatterTeacher"})
public class serviceGroupMatterTeacher extends HttpServlet {

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
                int pk_career = Integer.parseInt(request.getParameter("pk_career"));
                int pk_period = Integer.parseInt(request.getParameter("pk_period"));
                int pk_semester = Integer.parseInt(request.getParameter("pk_semester"));
                int pk_group = Integer.parseInt(request.getParameter("pk_group"));
                ArrayList<groupMatterTeacherModel> listGroupMatterTeacher=new groupMatterTeacherControl().SelectGroupMatterTecher("filterable",pk_career, pk_semester, pk_group, pk_period);
                JSONArray principal = new JSONArray();
                JSONObject settings = new JSONObject();
                JSONArray content = new JSONArray();
                settings.put("__groupMatterTeacherModel","");
                if(request.getParameter("view").equals("combo")){
                }  
                for(int i=0;i<listGroupMatterTeacher.size();i++){
                    JSONObject datos = new JSONObject();
                    datos.put("id", listGroupMatterTeacher.get(i).getPK_GROUP_MATTER_TECHER());
                    datos.put("dataProgresivNumber", i+1);
                    datos.put("dataSubjectMatterName", listGroupMatterTeacher.get(i).getFL_NAME_SUBJECT_MATTER());
                    datos.put("dataTeacherName", listGroupMatterTeacher.get(i).getFL_NAME_TEACHER());
                    content.add(datos); 
                }
                settings.put("__ENTITIES", content);
                principal.add(settings);
                response.setContentType("application/json"); 
                out.print(principal);
                out.flush(); 
                out.close();
            }
            if(request.getParameter("insert")!=null){
                if(request.getParameter("fkSemester") != null && request.getParameter("fkGroup") != null && request.getParameter("fkMatter") != null && request.getParameter("fkTeacher") != null){
                    groupMatterTeacherModel dataGroupMatterTeacher=new groupMatterTeacherModel();
                    dataGroupMatterTeacher.setFK_CAREER(Integer.parseInt(request.getParameter("fkCareer")));
                    dataGroupMatterTeacher.setFK_PERIOD(Integer.parseInt(request.getParameter("fkPeriod")));
                    dataGroupMatterTeacher.setFK_SEMESTER(Integer.parseInt(request.getParameter("fkSemester")));
                    dataGroupMatterTeacher.setFK_GROUP(Integer.parseInt(request.getParameter("fkGroup")));
                    dataGroupMatterTeacher.setFK_SUBJECT_MATTER(Integer.parseInt(request.getParameter("fkMatter")));
                    dataGroupMatterTeacher.setFK_TEACHER(Integer.parseInt(request.getParameter("fkTeacher")));
                    out.print(new groupMatterTeacherControl().InsertGroupMatterTeacher(dataGroupMatterTeacher));
                }                
            }
            if(request.getParameter("update")!=null){       
                if(request.getParameter("pkGroupMatterTeacher") != null && request.getParameter("pkGroupMatterTeacher") != null){
                    groupMatterTeacherModel dataGroupMatterTeacher=new groupMatterTeacherModel();
                    dataGroupMatterTeacher.setPK_GROUP_MATTER_TECHER(Integer.parseInt(request.getParameter("pkGroupMatterTeacher")));
                    dataGroupMatterTeacher.setFK_SEMESTER(Integer.parseInt(request.getParameter("fkSemester")));
                    dataGroupMatterTeacher.setFK_GROUP(Integer.parseInt(request.getParameter("fkGroup")));
                    dataGroupMatterTeacher.setFK_SUBJECT_MATTER(Integer.parseInt(request.getParameter("fkMatter")));
                    dataGroupMatterTeacher.setFK_TEACHER(Integer.parseInt(request.getParameter("fkTeacher")));
                    out.print(new groupMatterTeacherControl().UpdateGroupMatterTeacher(dataGroupMatterTeacher));
                }                
            }
            if(request.getParameter("delete")!=null){       
                if(request.getParameter("pkGroupMatterTeacher") != null){
                    out.print(new groupMatterTeacherControl().DeleteGroupMatterTeacher(Integer.parseInt(request.getParameter("pkGroupMatterTeacher"))));
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
