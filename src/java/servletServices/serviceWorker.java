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
@WebServlet(name = "serviceWorker", urlPatterns = {"/serviceWorker"})
public class serviceWorker extends HttpServlet {

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
                int fkRol= Integer.parseInt(request.getParameter("fkRol"));
                ArrayList<workerModel> listWorkers=new workerControl().SelectWorker(null, fkRol);
                JSONArray principal = new JSONArray();
                JSONObject settings = new JSONObject();
                JSONArray content = new JSONArray();
                settings.put("__WorkerModel","Worker");
                if(request.getParameter("view").equals("combo")){
                    
                }  
                for(int i=0;i<listWorkers.size();i++){
                    JSONObject data = new JSONObject();
                    data.put("id", listWorkers.get(i).getPK_WORKER());
                    data.put("dataProgresivNumber", i+1);
                    data.put("dataPkWorker", listWorkers.get(i).getPK_WORKER());
                    data.put("dataNameWorker", listWorkers.get(i).getFL_NAME_WORKER());
                    data.put("dataMaternName", listWorkers.get(i).getFL_MATERN_NAME());
                    data.put("dataPaternName", listWorkers.get(i).getFL_PATERN_NAME());
                    data.put("dataKeySp", listWorkers.get(i).getFL_KEY_SP());
                    data.put("dataTelphoneNumber", listWorkers.get(i).getFL_TELEHONE_NUMBER());
                    data.put("dataAddres", listWorkers.get(i).getFL_ADDRES());
                    data.put("dataPhoto", listWorkers.get(i).getFL_PHOTO());
                    data.put("dataUserName", listWorkers.get(i).getFL_USER_NAME());
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
                if(request.getParameter("fkRol") != null){
                    workerModel dataWorker=new workerModel();
                    dataWorker.setFL_NAME_WORKER(request.getParameter("nameWorker"));
                    dataWorker.setFL_MATERN_NAME(request.getParameter("maternName"));
                    dataWorker.setFL_PATERN_NAME(request.getParameter("paternName"));
                    dataWorker.setFL_KEY_SP(request.getParameter("keySp"));
                    dataWorker.setFL_TELEHONE_NUMBER(request.getParameter("telphoneNumber"));
                    dataWorker.setFL_ADDRES(request.getParameter("addres"));
                    dataWorker.setFL_PHOTO(request.getParameter("photo"));
                    dataWorker.setFK_ROL(Integer.parseInt(request.getParameter("fkRol")));
                    out.print(new workerControl().InsertWorker(dataWorker));
                }                
            }
            if(request.getParameter("update")!=null){       
                if(request.getParameter("pkWorker") != null  && request.getParameter("fkRol") != null){
                    workerModel dataWorker=new workerModel();
                    dataWorker.setPK_WORKER(Integer.parseInt(request.getParameter("pkWorker")));
                    dataWorker.setFL_NAME_WORKER(request.getParameter("nameWorker"));
                    dataWorker.setFL_MATERN_NAME(request.getParameter("maternName"));
                    dataWorker.setFL_PATERN_NAME(request.getParameter("paternName"));
                    dataWorker.setFL_KEY_SP(request.getParameter("keySp"));
                    dataWorker.setFL_TELEHONE_NUMBER(request.getParameter("telephoneNumber"));
                    dataWorker.setFL_ADDRES(request.getParameter("addres"));
                    dataWorker.setFL_PHOTO(request.getParameter("photo"));
                    dataWorker.setFK_ROL(Integer.parseInt(request.getParameter("fkRol")));
                    out.print(new workerControl().UpdateWorker("worker",dataWorker));
                }                
            }
            if(request.getParameter("delete")!=null){       
                if(request.getParameter("pkWorker") != null){
                    out.print(new workerControl().DeleteWorker(Integer.parseInt(request.getParameter("pkWorker"))));
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
