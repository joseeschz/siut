/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletServices;

import control.prepararoryControl;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.preparatoryModel;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author CARLOS
 */
@WebServlet(name = "getPreparatory", urlPatterns = {"/getPreparatory"})
public class getPreparatory extends HttpServlet {

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
                ArrayList<preparatoryModel> listPreparatory;
                if(request.getParameter("filtrable")!=null){
                    String fk_locality=(request.getParameter("filtrable"));
                    listPreparatory=new prepararoryControl().SelectPreparatory("byLocality", fk_locality);
                }else{
                    listPreparatory=new prepararoryControl().SelectPreparatory("all", "0");
                }
                JSONArray principal = new JSONArray();
                JSONObject settings = new JSONObject();
                JSONArray content = new JSONArray();
                settings.put("__entityModel","Preparatory");
                if(request.getParameter("view").equals("combo")){
                    JSONObject datos = new JSONObject();
                    datos.put("id", 0);
                    datos.put("dataProgresivNumber","0");
                    datos.put("dataPkPreparatory","0");
                    datos.put("dataNamePreparatory", "SELECCIONAR");
                    content.add(datos);
                } 
                for(int i=0;i<listPreparatory.size();i++){
                    JSONObject datos = new JSONObject();
                    datos.put("id", listPreparatory.get(i).getPK_PREPARATORY());
                    datos.put("dataProgresivNumber", i+1);
                    datos.put("dataPkPreparatory", listPreparatory.get(i).getPK_PREPARATORY());
                    datos.put("dataFkEntity", listPreparatory.get(i).getFK_ENTITY());
                    datos.put("dataFkMunicipality", listPreparatory.get(i).getFK_MUNICIPALITY());
                    datos.put("dataFkLocality", listPreparatory.get(i).getFK_LOCALITY());
                    datos.put("dataAltitude", listPreparatory.get(i).getFL_ALTITUDE());
                    datos.put("dataAltitudeMsnm", listPreparatory.get(i).getFL_ALTITUDE_msnm());
                    datos.put("dataAndStreet", listPreparatory.get(i).getFL_AND_STREET());
                    datos.put("dataBetweenStreet", listPreparatory.get(i).getFL_BETWEEN_STREET());
                    datos.put("dataCct", listPreparatory.get(i).getFL_CCT());
                    datos.put("dataControl", listPreparatory.get(i).getFL_CONTROL());
                    datos.put("dataDomicile", listPreparatory.get(i).getFL_DOMICILE());
                    datos.put("dataLatitude", listPreparatory.get(i).getFL_LATITUDE());
                    datos.put("dataLatitudeGms", listPreparatory.get(i).getFL_LATITUDE_gms());
                    datos.put("dataLongitude", listPreparatory.get(i).getFL_LONGITUDE());
                    datos.put("dataLongitudeGms", listPreparatory.get(i).getFL_LONGITUDE_gms());
                    datos.put("dataNameEntity", listPreparatory.get(i).getFL_NAME_ENTITY());
                    datos.put("dataNameLocality", listPreparatory.get(i).getFL_NAME_LOCALITY());
                    datos.put("dataNameMunicipality", listPreparatory.get(i).getFL_NAME_MUNICIPALITY());
                    datos.put("dataNamePreparatory", listPreparatory.get(i).getFL_NAME_PREPARATORY());
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
                if(request.getParameter("namePreparatory") != null && request.getParameter("fk_locality") != null){
                    preparatoryModel dataPreparatory=new preparatoryModel();
                    dataPreparatory.setFK_LOCALITY(Integer.parseInt(request.getParameter("fk_locality")));
                    dataPreparatory.setFL_ALTITUDE("");
                    dataPreparatory.setFL_ALTITUDE_msnm("");
                    dataPreparatory.setFL_AND_STREET(request.getParameter("andStreet"));
                    dataPreparatory.setFL_BETWEEN_STREET(request.getParameter("betweenStreet"));
                    dataPreparatory.setFL_CCT(request.getParameter("cct"));
                    dataPreparatory.setFL_CONTROL(request.getParameter("control"));
                    dataPreparatory.setFL_DOMICILE(request.getParameter("domicile"));
                    dataPreparatory.setFL_LATITUDE("");
                    dataPreparatory.setFL_LATITUDE_gms("");
                    dataPreparatory.setFL_LONGITUDE("");
                    dataPreparatory.setFL_LONGITUDE_gms("");
                    dataPreparatory.setFL_NAME_PREPARATORY(request.getParameter("namePreparatory"));
                    out.print(new prepararoryControl().InsertPreparatory(dataPreparatory));
                }                
            }
            if(request.getParameter("update")!=null){       
                if(request.getParameter("namePreparatory") != null && request.getParameter("fk_locality") != null){
                    preparatoryModel dataPreparatory=new preparatoryModel();
                    dataPreparatory.setPK_PREPARATORY(Integer.parseInt(request.getParameter("pk_preparatory")));
                    dataPreparatory.setFK_LOCALITY(Integer.parseInt(request.getParameter("fk_locality")));
                    dataPreparatory.setFL_ALTITUDE("");
                    dataPreparatory.setFL_ALTITUDE_msnm("");
                    dataPreparatory.setFL_AND_STREET(request.getParameter("andStreet"));
                    dataPreparatory.setFL_BETWEEN_STREET(request.getParameter("betweenStreet"));
                    dataPreparatory.setFL_CCT(request.getParameter("cct"));
                    dataPreparatory.setFL_CONTROL(request.getParameter("control"));
                    dataPreparatory.setFL_DOMICILE(request.getParameter("domicile"));
                    dataPreparatory.setFL_LATITUDE("");
                    dataPreparatory.setFL_LATITUDE_gms("");
                    dataPreparatory.setFL_LONGITUDE("");
                    dataPreparatory.setFL_LONGITUDE_gms("");
                    dataPreparatory.setFL_NAME_PREPARATORY(request.getParameter("namePreparatory"));
                    out.print(new prepararoryControl().UpdatePreparatory(dataPreparatory));
                }                
            }
            if(request.getParameter("delete")!=null){       
                if(request.getParameter("pkPreparatory") != null){
                    out.print(new prepararoryControl().DeletePreparatory(Integer.parseInt(request.getParameter("pkPreparatory"))));
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
