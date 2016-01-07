/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletServices;

import control.municipalityControl;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.municipalityModel;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author CARLOS
 */
@WebServlet(name = "getMunicipality", urlPatterns = {"/getMunicipality"})
public class getMunicipality extends HttpServlet {

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
                ArrayList<municipalityModel> listMunicipality;
                if(request.getParameter("filtrable")!=null){
                    String fk_enity=(request.getParameter("filtrable"));
                    String action = request.getParameter("action");
                    listMunicipality=new municipalityControl().SelectMunicipality(action, fk_enity);
                }else{
                    listMunicipality=new municipalityControl().SelectMunicipality();
                }
                JSONArray principal = new JSONArray();
                JSONObject settings = new JSONObject();
                JSONArray content = new JSONArray();
                settings.put("__municipalityModel","Municipality");
                if(request.getParameter("view").equals("combo")){
                    JSONObject datos = new JSONObject();
                    datos.put("id", 0);
                    datos.put("dataProgresivNumber",0);
                    datos.put("dataPkMunicipality","0");
                    datos.put("dataNameMunicipality", "SELECCIONAR");
                    datos.put("dataFkEntity", "0");
                    content.add(datos); 
                } 
                for(int i=0;i<listMunicipality.size();i++){
                    JSONObject datos = new JSONObject();
                    datos.put("id", listMunicipality.get(i).getPK_MUNICIPALITY());
                    datos.put("dataProgresivNumber", i+1);
                    datos.put("dataPkMunicipality", listMunicipality.get(i).getPK_MUNICIPALITY());
                    datos.put("dataNameMunicipality", listMunicipality.get(i).getFL_NAME());
                    datos.put("dataFkEntity", listMunicipality.get(i).getFK_ENTITY());
                    datos.put("dataNameEntityMunicipality", listMunicipality.get(i).getFL_NAME_ENTITY());
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
                if(request.getParameter("nameMunisipality") != null){
                    municipalityModel dataMunicipality=new municipalityModel();
                    dataMunicipality.setFL_NAME(request.getParameter("nameMunisipality"));
                    dataMunicipality.setFK_ENTITY(request.getParameter("pkEntity"));
                    out.print(new municipalityControl().InsertMunicipality(dataMunicipality));
                }                
            }
            if(request.getParameter("update")!=null){       
                if(request.getParameter("nameMunisipality") != null && request.getParameter("nameMunisipality") != null){
                    municipalityModel dataMunicipality=new municipalityModel();
                    dataMunicipality.setPK_MUNICIPALITY(Integer.parseInt(request.getParameter("pkMunicipality")));
                    dataMunicipality.setFL_NAME(request.getParameter("nameMunisipality"));
                    dataMunicipality.setFK_ENTITY(request.getParameter("fkEntity"));
                    out.print(new municipalityControl().UpdateMunicipality(dataMunicipality));
                }                
            }
            if(request.getParameter("delete")!=null){       
                if(request.getParameter("pkMunicipality") != null){
                    out.print(new municipalityControl().DeleteMunicipality(Integer.parseInt(request.getParameter("pkMunicipality"))));
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
