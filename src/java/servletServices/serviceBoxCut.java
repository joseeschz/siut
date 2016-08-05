/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletServices;

import control.reportBoxCutControl;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.categoryPaymentsModel;
import model.periodModel;
import model.semesterModel;
import model.studentModel;
import model.reportBoxCutModel;
import model.typeFormatModel;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author Lab5-E
 */
@WebServlet(name = "serviceBoxCut", urlPatterns = {"/serviceBoxCut"})
public class serviceBoxCut extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            if(request.getParameter("view")!=null){
                ArrayList<reportBoxCutModel> listReportBoxCut;
                JSONArray principal = new JSONArray();
                JSONObject settings = new JSONObject();
                JSONArray content = new JSONArray();
                
                settings.put("__reportBoxCutModel","ReportBoxCut");
                listReportBoxCut = new reportBoxCutControl().SelectReportBoxCut();
                for(int i=0;i<listReportBoxCut.size();i++){
                    JSONObject data = new JSONObject();
                    data.put("dataProgresivNumber", i+1);
                    data.put("dataPkBoxCute", listReportBoxCut.get(i).getPK_BOX_CUT());
                    data.put("dataDateBegin", listReportBoxCut.get(i).getFL_DATE_BEGIN());
                    data.put("dataDateEnd", listReportBoxCut.get(i).getFL_DATE_END());
                    data.put("dataDateRow", listReportBoxCut.get(i).getFL_DATE_ROW());
                    data.put("dataNumber", listReportBoxCut.get(i).getFL_NUMBER());                    
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
                response.setContentType("application/json"); 
                JSONObject data = new JSONObject();
                if(request.getParameter("commit").equals("false")){                    
                    try {               
                        int pt_pk_box_cut = Integer.parseInt(request.getParameter("pt_pk_box_cut"));
                        String result =  new reportBoxCutControl().CommitFalseBoxCute(pt_pk_box_cut);
                        if(result.equals("Commited")) {
                            data.put("Success", result);
                        }else{
                            data.put("Fail", result);
                        }
                    } catch (Exception e) {
                        data.put("Fail", "paramsEmpty");
                    }
                }else{
                    try {
                        reportBoxCutModel dataModel = new reportBoxCutModel();
                        String[] result =  new reportBoxCutControl().InsertReportBoxCut(dataModel);
                        if(result[0].equals("Inserted")) {
                            data.put(result[0], ""+result[1]+"");
                        }else{
                            data.put("Fail", ""+result[0]+"");
                        }
                    } catch (Exception e) {
                        data.put("Fail", "paramsEmpty");
                    }
                }
                out.print(data);
            }
            if(request.getParameter("update")!=null){      
                response.setContentType("text/html;charset=UTF-8");              
            }
            if(request.getParameter("delete")!=null){  
                response.setContentType("application/json"); 
                JSONObject data = new JSONObject();
                int pt_pk_box_cut = Integer.parseInt(request.getParameter("pt_pk_box_cut"));
                String result =  new reportBoxCutControl().DeleteReportBoxCut(pt_pk_box_cut);
                if(result.equals("Deleted")) {
                    data.put("Success", result);
                }else{
                    data.put("Fail", result);
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
