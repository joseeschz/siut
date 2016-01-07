/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletServices;

import control.careerControl;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.careerModel;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author CARLOS
 */
@WebServlet(name = "serviceCareer", urlPatterns = {"/serviceCareer"})
public class serviceCareer extends HttpServlet {

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
                int fkLevel = 0;
                int fkTeacher =0;
                if(session.getAttribute("logueado")!=null){
                    fkTeacher=Integer.parseInt(session.getAttribute("pkUser").toString());
                }
                if(request.getParameter("fkLevel")!=null){
                    fkLevel = Integer.parseInt(request.getParameter("fkLevel"));
                }                
                ArrayList<careerModel> listCareer;
                JSONArray principal = new JSONArray();
                JSONObject settings = new JSONObject();
                JSONArray content = new JSONArray();
                settings.put("__careerModel","Career");
                if(request.getParameter("view").equals("combo")){
                    if(request.getParameter("teacher") != null){
                        listCareer=new careerControl().SelectCareerByTeacher(fkTeacher, fkLevel);
                    }else if(request.getParameter("teacherTutor") != null){
                        listCareer=new careerControl().SelectCareerByTeacherTutor(fkTeacher, fkLevel);
                    }else if(request.getParameter("director") != null){
                        listCareer=new careerControl().SelectCareerByDirector(fkTeacher, fkLevel);
                    }else if(request.getParameter("statusInscription") != null){
                        listCareer=new careerControl().SelectCareer("byStatusInscription",0);
                    }else{
                        listCareer=new careerControl().SelectCareer("byStatus",fkLevel);
                    }
                }else{
                    listCareer=new careerControl().SelectCareer("byLevel",fkLevel);
                }  
                for(int i=0;i<listCareer.size();i++){
                    JSONObject data = new JSONObject();
                    data.put("id", listCareer.get(i).getPK_CAREER());
                    data.put("dataProgresivNumber", i+1);
                    data.put("dataPkCareer", listCareer.get(i).getPK_CAREER());
                    data.put("dataNameCareer", listCareer.get(i).getFL_NAME_CAREER());
                    data.put("dataNameCareerAbbreviated", listCareer.get(i).getFL_NAME_ABBREVIATED());
                    data.put("dataStatus", listCareer.get(i).getFL_STATUS());
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
                if(request.getParameter("fkLevel") != null){
                    careerModel dataCareer=new careerModel();
                    dataCareer.setFL_NAME_CAREER(request.getParameter("nameCareer"));
                    dataCareer.setFL_NAME_ABBREVIATED(request.getParameter("nameCareerAbreiated"));
                    dataCareer.setFL_STATUS(request.getParameter("status"));
                    dataCareer.setFK_LEVEL(Integer.parseInt(request.getParameter("fkLevel")));
                    out.print(new careerControl().InsertCareer(dataCareer));
                }                
            }
            if(request.getParameter("update")!=null){       
                if(request.getParameter("pkCareer") != null && request.getParameter("fkLevel") != null){
                    careerModel dataCareer=new careerModel();
                    dataCareer.setPK_CAREER(Integer.parseInt(request.getParameter("pkCareer")));
                    dataCareer.setFL_NAME_CAREER(request.getParameter("nameCareer"));
                    dataCareer.setFL_NAME_ABBREVIATED(request.getParameter("nameCareerAbreiated"));
                    dataCareer.setFL_STATUS(request.getParameter("status"));
                    dataCareer.setFK_LEVEL(Integer.parseInt(request.getParameter("fkLevel")));
                    out.print(new careerControl().UpdateCareer(dataCareer));
                }                
            }
            if(request.getParameter("delete")!=null){       
                if(request.getParameter("pkCareer") != null){
                    out.print(new careerControl().DeleteCareer(Integer.parseInt(request.getParameter("pkCareer"))));
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
