/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletServices;

import control.localityControl;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.localityModel;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author CARLOS
 */
@WebServlet(name = "getLocality", urlPatterns = {"/getLocality"})
public class getLocality extends HttpServlet {

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
                ArrayList<localityModel> listLocality;
                if(request.getParameter("filtrable")!=null){
                    String action = request.getParameter("action");
                    String fk_municipality=(request.getParameter("filtrable"));
                    listLocality=new localityControl().SelectLocality(action, fk_municipality);
                }else{
                    String action = request.getParameter("action");
                    listLocality=new localityControl().SelectLocality(action, "0");
                }
                JSONArray principal = new JSONArray();
                JSONObject settings = new JSONObject();
                JSONArray content = new JSONArray();
                settings.put("__entityModel","Locality");
                if(request.getParameter("view").equals("combo")){
                    JSONObject datos = new JSONObject();
                    datos.put("id", 0);
                    datos.put("dataProgresivNumber",0);
                    datos.put("dataPkLocality","0");
                    datos.put("dataNameLocality", "SELECCIONAR");
                    content.add(datos); 
                }  
                for(int i=0;i<listLocality.size();i++){
                    JSONObject datos = new JSONObject();
                    datos.put("id", listLocality.get(i).getPK_LOCALITY());
                    datos.put("dataProgresivNumber", i+1);
                    datos.put("dataPkLocality", listLocality.get(i).getPK_LOCALITY());
                    datos.put("dataNameLocality", listLocality.get(i).getFL_NAME());
                    datos.put("dataFkEntity", listLocality.get(i).getFK_ENTITY());
                    datos.put("dataFkMunicipality", listLocality.get(i).getFK_MUNICIPALITY());
                    datos.put("dataNameMunicipality", listLocality.get(i).getFL_NAME_MUNICIPALITY());
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
                if(request.getParameter("nameLocality") != null){
                    localityModel dataLocality=new localityModel();
                    dataLocality.setFL_NAME(request.getParameter("nameLocality"));
                    dataLocality.setFK_MUNICIPALITY(request.getParameter("pkMunicipality"));
                    out.print(new localityControl().InsertLocality(dataLocality));
                }                
            }
            if(request.getParameter("update")!=null){       
                if(request.getParameter("nameLocality") != null && request.getParameter("nameLocality") != null){
                    localityModel dataLocality=new localityModel();
                    dataLocality.setPK_LOCALITY(Integer.parseInt(request.getParameter("pkLocality")));
                    dataLocality.setFL_NAME(request.getParameter("nameLocality"));
                    dataLocality.setFK_MUNICIPALITY(request.getParameter("fkMunicipality"));
                    out.print(new localityControl().UpdateLocality(dataLocality));
                }                
            }
            if(request.getParameter("delete")!=null){       
                if(request.getParameter("pkLocality") != null){
                    out.print(new localityControl().DeleteLocality(Integer.parseInt(request.getParameter("pkLocality"))));
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
