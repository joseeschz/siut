/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletServices;

import control.workerControl;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.workerModel;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author CARLOS
 */
@WebServlet(name = "serviceTeacher", urlPatterns = {"/serviceTeacher"})
public class serviceTeacher extends HttpServlet {

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
                ArrayList<workerModel> listWorkers;
                JSONArray principal = new JSONArray();
                JSONObject settings = new JSONObject();
                JSONArray content = new JSONArray();
                settings.put("__WorkerModel","Worker");
                if(request.getParameter("view").equals("combo")){
                    listWorkers=new workerControl().SelectWorker("byTeacherTutor",3);
                    for(int i=0;i<listWorkers.size();i++){
                        JSONObject data = new JSONObject();
                        data.put("id", listWorkers.get(i).getPK_WORKER());
                        data.put("dataProgresivNumber", i+1);
                        data.put("dataPkWorker", listWorkers.get(i).getPK_WORKER());
                        data.put("dataNameWorker", listWorkers.get(i).getFL_NAME_WORKER());
                        data.put("dataTutor", listWorkers.get(i).getFL_TUTOR());
                        data.put("dataJobFuntional", listWorkers.get(i).getFL_JOB_FUNCTIONAL());
                        content.add(data); 
                    }
                }else{  
                    listWorkers=new workerControl().SelectWorker("byTeacherWorker",3);
                    for(int i=0;i<listWorkers.size();i++){
                        JSONObject data = new JSONObject();
                        data.put("id", listWorkers.get(i).getPK_WORKER());
                        data.put("dataProgresivNumber", i+1);
                        data.put("dataPkWorker", listWorkers.get(i).getPK_WORKER());
                        data.put("dataNameWorker", listWorkers.get(i).getFL_NAME_WORKER());
                        data.put("dataTutor", listWorkers.get(i).getFL_TUTOR());
                        data.put("dataJobFuntional", listWorkers.get(i).getFL_JOB_FUNCTIONAL());
                        content.add(data); 
                    }
                }
                settings.put("__ENTITIES", content);
                principal.add(settings);
                response.setContentType("application/json"); 
                out.print(principal);
                out.flush(); 
                out.close();
            }
            if(request.getParameter("update")!=null){       
                if(request.getParameter("pkWorker")!=null){
                    workerModel dataWorker=new workerModel();
                    dataWorker.setFL_TUTOR(request.getParameter("tutor"));
                    dataWorker.setPK_WORKER(Integer.parseInt(request.getParameter("pkWorker")));
                    dataWorker.setFL_JOB_FUNCTIONAL(request.getParameter("jobFuntional"));
                    out.print(new workerControl().UpdateWorker("teacher",dataWorker));
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
