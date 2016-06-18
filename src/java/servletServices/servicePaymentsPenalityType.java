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
            if(request.getParameter("view")!=null){
                ArrayList<paymentsPenaltyTypesModel> listPaymentsPenaltyType;
                JSONArray principal = new JSONArray();
                JSONObject settings = new JSONObject();
                JSONArray content = new JSONArray();
                settings.put("__paymentsPenaltyTypesModel","PaymentsPenaltyType");
                int pt_pk_category = Integer.parseInt(request.getParameter("pt_pk_category"));
                int pt_pk_period = Integer.parseInt(request.getParameter("pt_pk_period"));                  
                if(request.getParameter("view").equals("NotPrepai")){
                    int pt_pk_level_study = Integer.parseInt(request.getParameter("pt_pk_level_study"));
                    int pt_pk_semester = Integer.parseInt(request.getParameter("pt_pk_semester"));
                    listPaymentsPenaltyType = new paymentsPenaltyTypesControl().SelectPaymentsPenaltyTypesNotPrepai(pt_pk_level_study, pt_pk_semester, pt_pk_category, pt_pk_period);
                }else if(request.getParameter("view").equals("Prepai")){
                    int pt_pk_level_study = Integer.parseInt(request.getParameter("pt_pk_level_study"));
                    int pt_pk_semester = Integer.parseInt(request.getParameter("pt_pk_semester"));
                    listPaymentsPenaltyType = new paymentsPenaltyTypesControl().SelectPaymentsPenaltyTypesPrepai(pt_pk_level_study, pt_pk_semester, pt_pk_category, pt_pk_period);
                }else{
                    listPaymentsPenaltyType = new paymentsPenaltyTypesControl().SelectPaymentsPenaltyTypesServices(pt_pk_category, pt_pk_period);
                }
                
                
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
                response.setContentType("application/json"); 
                out.print(principal);
                out.flush(); 
                out.close();
            }
            if(request.getParameter("insert")!=null){
                paymentsPenaltyTypesModel allPaymentsPenaltyType=new paymentsPenaltyTypesModel();
                studyLevelModel studyLevelModel =  new studyLevelModel();
                semesterModel semesterModel =  new semesterModel();
                categoryPaymentsModel categoryModel = new categoryPaymentsModel();
                periodModel periodModel =  new periodModel();

                allPaymentsPenaltyType.setFL_NAME_PENALTY(request.getParameter("pt_name_penalty"));
                allPaymentsPenaltyType.setFL_TARIFF(request.getParameter("pt_tariff"));
                allPaymentsPenaltyType.setFL_STATUS_PREPAI(Integer.parseInt(request.getParameter("pt_prepai")));
                studyLevelModel.setPK_LEVEL_STUDY(Integer.parseInt(request.getParameter("pt_pk_level_study")));
                allPaymentsPenaltyType.setStudyLevel(studyLevelModel);

                semesterModel.setPK_SEMESTER(Integer.parseInt(request.getParameter("pt_pk_semester")));
                allPaymentsPenaltyType.setSemester(semesterModel);

                categoryModel.setPK_CATEGORY_PAYMENT(Integer.parseInt(request.getParameter("pt_pk_category")));
                allPaymentsPenaltyType.setCategory(categoryModel);
                periodModel.setPK_PERIOD(Integer.parseInt(request.getParameter("pt_pk_period")));
                allPaymentsPenaltyType.setPeriod(periodModel);
                out.print(new paymentsPenaltyTypesControl().InsertPaymentsPenaltyType(allPaymentsPenaltyType));             
            }
            if(request.getParameter("insertServices")!=null){
                paymentsPenaltyTypesModel allPaymentsPenaltyType=new paymentsPenaltyTypesModel();
                studyLevelModel studyLevelModel =  new studyLevelModel();
                semesterModel semesterModel =  new semesterModel();
                categoryPaymentsModel categoryModel = new categoryPaymentsModel();
                periodModel periodModel =  new periodModel();

                allPaymentsPenaltyType.setFL_NAME_PENALTY(request.getParameter("pt_name_penalty"));
                allPaymentsPenaltyType.setFL_TARIFF(request.getParameter("pt_tariff"));
                allPaymentsPenaltyType.setFL_STATUS_PREPAI(Integer.parseInt(request.getParameter("pt_prepai")));
                studyLevelModel.setPK_LEVEL_STUDY(0);
                allPaymentsPenaltyType.setStudyLevel(studyLevelModel);

                semesterModel.setPK_SEMESTER(0);
                allPaymentsPenaltyType.setSemester(semesterModel);

                categoryModel.setPK_CATEGORY_PAYMENT(Integer.parseInt(request.getParameter("pt_pk_category")));
                allPaymentsPenaltyType.setCategory(categoryModel);
                periodModel.setPK_PERIOD(Integer.parseInt(request.getParameter("pt_pk_period")));
                allPaymentsPenaltyType.setPeriod(periodModel);     
                out.print(new paymentsPenaltyTypesControl().InsertPaymentsPenaltyTypeServices(allPaymentsPenaltyType));             
            }
            if(request.getParameter("update")!=null){      
                response.setContentType("text/html;charset=UTF-8");
                if(request.getParameter("pt_pk_payment_penalty") != null){
                    paymentsPenaltyTypesModel allPaymentsPenaltyType=new paymentsPenaltyTypesModel();
                    allPaymentsPenaltyType.setPK_PAYMENT_PENALTY_TYPE(Integer.parseInt(request.getParameter("pt_pk_payment_penalty")));
                    allPaymentsPenaltyType.setFL_NAME_PENALTY(request.getParameter("pt_name_penalty"));
                    allPaymentsPenaltyType.setFL_TARIFF(request.getParameter("pt_tariff"));
                    out.print(new paymentsPenaltyTypesControl().UpdatePaymentsPenaltyType(allPaymentsPenaltyType));
                }                
            }
            if(request.getParameter("delete")!=null){     
                response.setContentType("text/html;charset=UTF-8");
                if(request.getParameter("pt_pkPaymentsPenaltyType") != null){
                    out.print(new paymentsPenaltyTypesControl().DeletePaymentsPenaltyType(Integer.parseInt(request.getParameter("pt_pkPaymentsPenaltyType"))));
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
