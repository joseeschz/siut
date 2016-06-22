/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletServices;

import control.paymentsPenaltyTypesControl;
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
import model.paymentsPenaltyTypesModel;
import model.periodModel;
import model.semesterModel;
import model.studyLevelModel;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author CARLOS
 */
@WebServlet(name = "servicePaymentsPenaltyType", urlPatterns = {"/servicePaymentsPenaltyType"})
public class servicePaymentsPenalityType extends HttpServlet {

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
            response.setContentType("application/json"); 
            JSONObject message = new JSONObject();
            if(request.getParameter("view")!=null){       
                try {
                    ArrayList<paymentsPenaltyTypesModel> listPaymentsPenaltyType;
                    JSONArray principal = new JSONArray();
                    JSONObject settings = new JSONObject();
                    JSONArray content = new JSONArray();
                    settings.put("__paymentsPenaltyTypesModel","PaymentsPenaltyType");
                    int pt_pk_category = Integer.parseInt(request.getParameter("pt_pk_category"));
                    int pt_pk_period = Integer.parseInt(request.getParameter("pt_pk_period"));                  
                    int pt_pk_level_study = Integer.parseInt(request.getParameter("pt_pk_level_study"));
                    int pt_pk_semester = Integer.parseInt(request.getParameter("pt_pk_semester"));
                    int pt_pk_type_concept = Integer.parseInt(request.getParameter("pt_pk_type_concept"));
                    int pt_pk_type_format = Integer.parseInt(request.getParameter("pt_pk_type_format"));
                    listPaymentsPenaltyType = new paymentsPenaltyTypesControl().SelectPaymentsPenaltyTypes(pt_pk_level_study, pt_pk_semester, pt_pk_category, pt_pk_type_concept, pt_pk_type_format, pt_pk_period);


                    for(int i=0;i<listPaymentsPenaltyType.size();i++){
                        JSONObject data = new JSONObject();
                        data.put("dataProgresivNumber", i+1);
                        data.put("dataPkPaymentPenaltyType", listPaymentsPenaltyType.get(i).getPK_PAYMENT_PENALTY_TYPE());
                        data.put("dataNamePenalty", listPaymentsPenaltyType.get(i).getFL_NAME_PENALTY());
                        data.put("dataTariff", listPaymentsPenaltyType.get(i).getFL_TARIFF());
                        data.put("dataPkLevelStudy", listPaymentsPenaltyType.get(i).getStudyLevel().getPK_LEVEL_STUDY());
                        data.put("dataPkSemester", listPaymentsPenaltyType.get(i).getSemester().getPK_SEMESTER());
                        data.put("dataPkCategory", listPaymentsPenaltyType.get(i).getCategory().getPK_CATEGORY_PAYMENT());
                        data.put("dataPkPeriod", listPaymentsPenaltyType.get(i).getPeriod().getPK_PERIOD());
                        content.add(data); 
                    }
                    settings.put("__ENTITIES", content);
                    principal.add(settings);                    
                    out.print(principal);
                    out.flush(); 
                    out.close();
                } catch (Exception e) {
                    message.put("status", "'"+e+"'");
                    out.print(message);
                }               
            }
            if(request.getParameter("insert")!=null){
                try {
                    paymentsPenaltyTypesModel allPaymentsPenaltyType=new paymentsPenaltyTypesModel();
                    studyLevelModel studyLevelModel =  new studyLevelModel();
                    semesterModel semesterModel =  new semesterModel();
                    categoryPaymentsModel categoryModel = new categoryPaymentsModel();
                    periodModel periodModel =  new periodModel();

                    allPaymentsPenaltyType.setFL_NAME_PENALTY(request.getParameter("pt_name_penalty"));
                    allPaymentsPenaltyType.setFL_TARIFF(request.getParameter("pt_tariff"));
                    allPaymentsPenaltyType.setFK_TYPE_CONCEPT(Integer.parseInt(request.getParameter("pt_pk_type_concept")));
                    allPaymentsPenaltyType.setFK_TYPE_FORMAT(Integer.parseInt(request.getParameter("pt_pk_type_format")));
                    studyLevelModel.setPK_LEVEL_STUDY(Integer.parseInt(request.getParameter("pt_pk_level_study")));
                    allPaymentsPenaltyType.setStudyLevel(studyLevelModel);

                    semesterModel.setPK_SEMESTER(Integer.parseInt(request.getParameter("pt_pk_semester")));
                    allPaymentsPenaltyType.setSemester(semesterModel);

                    categoryModel.setPK_CATEGORY_PAYMENT(Integer.parseInt(request.getParameter("pt_pk_category")));
                    allPaymentsPenaltyType.setCategory(categoryModel);
                    periodModel.setPK_PERIOD(Integer.parseInt(request.getParameter("pt_pk_period")));
                    allPaymentsPenaltyType.setPeriod(periodModel);
                    String statusInserted = new paymentsPenaltyTypesControl().InsertPaymentsPenaltyType(allPaymentsPenaltyType);
                    message.put("status", statusInserted);
                } catch (Exception e) {
                    message.put("status", "'"+e+"'");
                }           
                out.print(message);   
            }
            if(request.getParameter("update")!=null){      
                try {
                    if(request.getParameter("pt_pk_payment_penalty") != null){
                        paymentsPenaltyTypesModel allPaymentsPenaltyType=new paymentsPenaltyTypesModel();
                        allPaymentsPenaltyType.setPK_PAYMENT_PENALTY_TYPE(Integer.parseInt(request.getParameter("pt_pk_payment_penalty")));
                        allPaymentsPenaltyType.setFL_NAME_PENALTY(request.getParameter("pt_name_penalty"));
                        allPaymentsPenaltyType.setFL_TARIFF(request.getParameter("pt_tariff"));
                        String statusInserted = new paymentsPenaltyTypesControl().UpdatePaymentsPenaltyType(allPaymentsPenaltyType);
                        message.put("status", statusInserted);
                    } 
                } catch (Exception e) {
                    message.put("status", "'"+e+"'");
                }
                out.print(message);            
            }
            if(request.getParameter("delete")!=null){   
                try {
                    if(request.getParameter("pt_pkPaymentsPenaltyType") != null){
                        String statusInserted = new paymentsPenaltyTypesControl().DeletePaymentsPenaltyType(Integer.parseInt(request.getParameter("pt_pkPaymentsPenaltyType")));
                        message.put("status", statusInserted);
                    }    
                } catch (Exception e) {
                    message.put("status", "'"+e+"'");
                }
                out.print(message);
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
