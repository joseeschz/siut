/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletServices;

import control.groupControl;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.groupModel;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author CARLOS
 */
@WebServlet(name = "serviceGroup", urlPatterns = {"/serviceGroup"})
public class serviceGroup extends HttpServlet {

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
                int fkSemester = Integer.parseInt(request.getParameter("fkSemester"));
                int pkCareer = 0;
                int pkPeriod;
                int pkUser=0;
                String pkMatter;
                ArrayList<groupModel> listGruop;
                JSONArray principal = new JSONArray();
                JSONObject settings = new JSONObject();
                JSONArray  content = new JSONArray();
                settings.put("__serviceGroup","Group");
                switch (request.getParameter("view")) {
                    case "combo":
                        if(session.getAttribute("logueado")!=null){
                            pkUser=Integer.parseInt(session.getAttribute("pkUser").toString());
                        }if(request.getParameter("teacher")!=null){
                            pkCareer = Integer.parseInt(request.getParameter("pkCareer"));
                            pkPeriod = Integer.parseInt(request.getParameter("pkPeriod"));
                            listGruop=new groupControl().SelectGroupByTeacher(pkUser, pkCareer, pkPeriod, fkSemester, null);
                        }else if(request.getParameter("teacherTutor")!=null){
                            pkPeriod = Integer.parseInt(request.getParameter("pkPeriod"));
                            listGruop=new groupControl().SelectGroupByTeacherTutor(pkUser, pkPeriod, fkSemester);
                        }else if(request.getParameter("director")!=null){
                            pkPeriod = Integer.parseInt(request.getParameter("pkPeriod"));
                            listGruop=new groupControl().SelectGroupByDirector(pkUser, pkPeriod, fkSemester);
                        }else{
                            listGruop=new groupControl().SelectGroup("bySemester", fkSemester);
                        }   
                        break;
                    case "comboByMatter":
                        if(session.getAttribute("logueado")!=null){
                            pkUser=Integer.parseInt(session.getAttribute("pkUser").toString());
                        }
                        if(request.getParameter("teacher")!=null){
                            //pkCareer = Integer.parseInt(request.getParameter("pkCareer"));
                            pkPeriod = Integer.parseInt(request.getParameter("pkPeriod"));
                            pkMatter = request.getParameter("pkMatter");
                            listGruop=new groupControl().SelectGroupByTeacher(pkUser, pkCareer, pkPeriod, fkSemester, pkMatter);
                        }else{
                            listGruop=new groupControl().SelectGroup("bySemester", fkSemester);
                        }   
                        break;
                    case "comboByCurrentSemester":
                        pkCareer = Integer.parseInt(request.getParameter("pkCareer"));     
                        pkPeriod = Integer.parseInt(request.getParameter("pkPeriod"));
                        listGruop=new groupControl().SelectGroupByCurrentSemester(pkCareer, fkSemester, pkPeriod);  
                        break;
                    default:
                        listGruop=new groupControl().SelectGroup("bySemester", fkSemester);
                        break;
                }  
                for(int i=0;i<listGruop.size();i++){
                    JSONObject data = new JSONObject();
                    data.put("id", listGruop.get(i).getPK_GROUP());
                    data.put("dataProgresivNumber", i+1);
                    data.put("dataPkGruop", listGruop.get(i).getPK_GROUP());
                    data.put("dataNameGroup", listGruop.get(i).getFL_NAME_GROUP());
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
                if(request.getParameter("fkSemester") != null){
                    groupModel dataGroup=new groupModel();
                    dataGroup.setFK_SEMESTER(Integer.parseInt(request.getParameter("fkSemester")));
                    out.print(new groupControl().InsertGroup(dataGroup));
                }                
            }
            if(request.getParameter("update")!=null){       
                if(request.getParameter("pkGroup") != null && request.getParameter("nameGroup") != null && request.getParameter("fkSemester") != null){
                    groupModel dataGroup=new groupModel();
                    dataGroup.setPK_GROUP(Integer.parseInt(request.getParameter("pkGroup")));
                    dataGroup.setFL_NAME_GROUP(request.getParameter("nameGroup"));
                    dataGroup.setFK_SEMESTER(Integer.parseInt(request.getParameter("fkSemester")));
                    out.print(new groupControl().UpdateGroup(dataGroup));
                }                
            }
            if(request.getParameter("delete")!=null){       
                if(request.getParameter("pkGroup") != null){
                    int pkGroup = Integer.parseInt(request.getParameter("pkGroup"));
                    out.print(new groupControl().DeleteGroup(pkGroup));
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
