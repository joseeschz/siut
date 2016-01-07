/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletServices;

import control.periodControl;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.periodModel;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author CARLOS
 */
@WebServlet(name = "servicePeriod", urlPatterns = {"/servicePeriod"})
public class servicePeriod extends HttpServlet {

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
            if(request.getParameter("view")!=null){                
                ArrayList<periodModel> listPeriod;
                JSONArray principal = new JSONArray();
                JSONObject settings = new JSONObject();
                JSONArray content = new JSONArray();
                settings.put("__periodModel","Period");
                if(request.getParameter("view").equals("comboActiveYear")){
                    listPeriod=new periodControl().SelectPeriod("activeYear");
                    for(int i=0;i<listPeriod.size();i++){
                        JSONObject data = new JSONObject();
                        data.put("id", listPeriod.get(i).getPK_PERIOD());
                        data.put("dataProgresivNumber", i+1);
                        data.put("dataPkPeriod", listPeriod.get(i).getPK_PERIOD());
                        data.put("dataNamePeriod", listPeriod.get(i).getFL_NAME());
                        data.put("dataNamePeriodAbbreviated", listPeriod.get(i).getFL_NAME_ABBREVIATED());
                        content.add(data); 
                    }
                    settings.put("__ENTITIES", content);
                    principal.add(settings);
                    response.setContentType("application/json"); 
                    out.print(principal);
                    out.flush(); 
                    out.close();
                }  
                if(request.getParameter("view").equals("activePeriodInscription")){
                    out.print(new periodControl().SelectPeriodActive("activeInscription"));
                }
                if(request.getParameter("view").equals("comboAll")){
                    listPeriod=new periodControl().SelectPeriod("comboAll");
                    for(int i=0;i<listPeriod.size();i++){
                        JSONObject data = new JSONObject();
                        data.put("id", listPeriod.get(i).getPK_PERIOD());
                        data.put("dataProgresivNumber", i+1);
                        data.put("dataPkPeriod", listPeriod.get(i).getPK_PERIOD());
                        data.put("dataNamePeriod", listPeriod.get(i).getFL_NAME());
                        data.put("dataNamePeriodAbbreviated", listPeriod.get(i).getFL_NAME_ABBREVIATED());
                        content.add(data); 
                    }
                    settings.put("__ENTITIES", content);
                    principal.add(settings);
                    response.setContentType("application/json"); 
                    out.print(principal);
                    out.flush(); 
                    out.close();
                }
                if(request.getParameter("view").equals("comboAllByStudent")){
                    String condition;
                    condition=request.getParameter("view")+"-"+session.getAttribute("pkStudent").toString();
                    listPeriod=new periodControl().SelectPeriod(condition);
                    for(int i=0;i<listPeriod.size();i++){
                        JSONObject data = new JSONObject();
                        data.put("id", listPeriod.get(i).getPK_PERIOD());
                        data.put("dataProgresivNumber", i+1);
                        data.put("dataPkPeriod", listPeriod.get(i).getPK_PERIOD());
                        data.put("dataNamePeriod", listPeriod.get(i).getFL_NAME());
                        data.put("dataNamePeriodAbbreviated", listPeriod.get(i).getFL_NAME_ABBREVIATED());
                        content.add(data); 
                    }
                    settings.put("__ENTITIES", content);
                    principal.add(settings);
                    response.setContentType("application/json"); 
                    out.print(principal);
                    out.flush(); 
                    out.close();
                }
                if(request.getParameter("view").equals("periodByTeacherByMatterHistory")){
                    int pkTeacher = Integer.parseInt(session.getAttribute("pkUser").toString());
                    int pkCareer = Integer.parseInt(request.getParameter("pkCareer"));
                    int pkSemester = Integer.parseInt(request.getParameter("pkSemester"));
                    int pkMatter = Integer.parseInt(request.getParameter("pkMatter"));
                    int pkTypeEval = Integer.parseInt(request.getParameter("pkTypeEval"));
                    listPeriod=new periodControl().SelectPeriodByTeacher(pkTeacher, pkCareer, pkSemester, pkMatter, pkTypeEval);
                    for(int i=0;i<listPeriod.size();i++){
                        JSONObject data = new JSONObject();
                        data.put("id", listPeriod.get(i).getPK_PERIOD());
                        data.put("dataProgresivNumber", i+1);
                        data.put("dataPkPeriod", listPeriod.get(i).getPK_PERIOD());
                        data.put("dataNamePeriod", listPeriod.get(i).getFL_NAME());
                        data.put("dataNamePeriodAbbreviated", listPeriod.get(i).getFL_NAME_ABBREVIATED());
                        content.add(data); 
                    }
                    settings.put("__ENTITIES", content);
                    principal.add(settings);
                    response.setContentType("application/json"); 
                    out.print(principal);
                    out.flush(); 
                    out.close();
                }
                if(request.getParameter("view").equals("inscription")){
                    listPeriod=new periodControl().SelectPeriod("byInscription");
                    for(int i=0;i<listPeriod.size();i++){
                        JSONObject data = new JSONObject();
                        data.put("id", listPeriod.get(i).getPK_PERIOD());
                        data.put("dataProgresivNumber", i+1);
                        data.put("dataPkPeriod", listPeriod.get(i).getPK_PERIOD());
                        data.put("dataNamePeriod", listPeriod.get(i).getFL_NAME());
                        data.put("dataNamePeriodAbbreviated", listPeriod.get(i).getFL_NAME_ABBREVIATED());
                        content.add(data); 
                    }
                    settings.put("__ENTITIES", content);
                    principal.add(settings);
                    response.setContentType("application/json"); 
                    out.print(principal);
                    out.flush(); 
                    out.close();
                }
                if(request.getParameter("view").equals("activePeriodYear")){
                    out.print(new periodControl().SelectPeriodActive("activePeriodYear"));
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
