/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletServices;

import control.studentsPenaltyPaymentsDetailControl;
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
import model.studentModel;
import model.studentsPenaltyPaymentsDetailModel;
import model.studentsPenaltyPaymentsModel;
import model.typeConceptModel;
import model.typeFormatModel;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author Lab5-E
 */
@WebServlet(name = "serviceStudentsPenaltyPaymentsDetail", urlPatterns = {"/serviceStudentsPenaltyPaymentsDetail"})
public class serviceStudentsPenaltyPaymentsDetail extends HttpServlet {

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
                 response.setContentType("application/json"); 
                JSONObject message = new JSONObject();
                try {
                    ArrayList<studentsPenaltyPaymentsDetailModel> listStudentsPenalityPayments;
                    JSONArray principal = new JSONArray();
                    JSONObject settings = new JSONObject();
                    JSONArray content = new JSONArray();
                    settings.put("__studentsPenaltyPaymentsDetailModel","StudentsPenalityPayments");
                    if(request.getParameter("view").equals("viewHeader")){
                        int pk_student_payment_penality_header=Integer.parseInt(request.getParameter("pk_student_payment_penality_header"));
                        listStudentsPenalityPayments = new studentsPenaltyPaymentsDetailControl().SelectStudentsAllStatusPaymentDetailByHeader(pk_student_payment_penality_header);                        
                    }else{
                        int fkPeriod=Integer.parseInt(request.getParameter("pt_fkPeriod"));
                        int fkSemester=Integer.parseInt(request.getParameter("pt_fkSemester"));
                        int fkTypeFormat=Integer.parseInt(request.getParameter("pt_fkTypeFormat"));
                        int fkStudent=Integer.parseInt(request.getParameter("pt_fkStudent"));                        
                        listStudentsPenalityPayments = new studentsPenaltyPaymentsDetailControl().SelectStudentsAllStatusPaymentDetail(fkPeriod, fkSemester, fkTypeFormat, fkStudent);
                    }
                    
                    for(int i=0;i<listStudentsPenalityPayments.size();i++){
                        JSONObject data = new JSONObject();
                        data.put("dataProgresivNumber", i+1);
                        data.put("dataPkStudentPenaltyPaymentDetail", listStudentsPenalityPayments.get(i).getPK_STUDENT_PENALTY_PAYMENT_DETAIL());
                        data.put("dataAmountPenalty", listStudentsPenalityPayments.get(i).getFL_AMOUNT_PENALITY());
                        data.put("dataReferenceNumber", listStudentsPenalityPayments.get(i).getFL_REFERENCE_NUMBER());
                        data.put("dataStatusPay", listStudentsPenalityPayments.get(i).getFL_STATUS_PAY());
                        data.put("dataStatusPayFlag", listStudentsPenalityPayments.get(i).getFL_STATUS_PAY());
                        data.put("dataCant", 0);
                        data.put("dataPkTypeConcept", listStudentsPenalityPayments.get(i).getTypeConcept().getPK_TYPE_CONCEPT());
                        data.put("dataNameConcept", listStudentsPenalityPayments.get(i).getTypeConcept().getFL_NAME_CONCEPT());
                        data.put("dataPkTypeFormat", listStudentsPenalityPayments.get(i).getTypeFormat().getPK_TYPE_FORMAT());
                        data.put("dataNameFormat", listStudentsPenalityPayments.get(i).getTypeFormat().getFL_NAME_FORMAT());
                        data.put("dataUnique", listStudentsPenalityPayments.get(i).getFL_UNIQUE());
                        data.put("dataPkStudent", listStudentsPenalityPayments.get(i).getStudent().getPK_STUDENT());
                        data.put("dataPkSemester", listStudentsPenalityPayments.get(i).getSemester().getPK_SEMESTER());
                        data.put("dataNameSemester", listStudentsPenalityPayments.get(i).getSemester().getFL_NAME_SEMESTER());
                        data.put("dataPkPeriod", listStudentsPenalityPayments.get(i).getPeriod().getPK_PERIOD());
                        data.put("dataNamePeriod", listStudentsPenalityPayments.get(i).getPeriod().getFL_NAME());
                        data.put("dataPkStudentPaymentPenalty", listStudentsPenalityPayments.get(i).getStudentPenalityPayment().getPK_STUDENT_PAYMENT_PENALTY());
                        data.put("dataPkPaymentPenaltyType", listStudentsPenalityPayments.get(i).getPaymentTypes().getPK_PAYMENT_PENALTY_TYPE());
                        data.put("dataPkCategory", listStudentsPenalityPayments.get(i).getCategoryPayments().getPK_CATEGORY_PAYMENT());
                        data.put("dataNamePenalty", listStudentsPenalityPayments.get(i).getPaymentTypes().getFL_NAME_PENALTY());
                        data.put("dataSubTotal", 0);
                        data.put("dataTariff", listStudentsPenalityPayments.get(i).getPaymentTypes().getFL_TARIFF());
                        content.add(data); 
                    }
                    settings.put("__ENTITIES", content);
                    principal.add(settings);
                    out.print(principal);
                    out.flush(); 
                    out.close();
                   
                } catch (Exception e) {
                    message.put("request", "'"+e+"'");
                    out.print(message);
                } 
            }
            if(request.getParameter("insert")!=null){
                response.setContentType("application/json"); 
                JSONObject data = new JSONObject();
                try {
                    studentsPenaltyPaymentsDetailModel dataStudentsPenalityPayments=new studentsPenaltyPaymentsDetailModel();
                    periodModel period = new periodModel();
                    semesterModel semester = new semesterModel();
                    studentModel student = new studentModel();
                    studentsPenaltyPaymentsModel studentPenalityPayment = new studentsPenaltyPaymentsModel();
                    paymentsPenaltyTypesModel paymentTypes = new paymentsPenaltyTypesModel();
                    categoryPaymentsModel categoryPayments = new categoryPaymentsModel();
                    typeConceptModel typeConcept = new typeConceptModel();
                    typeFormatModel typeFormat = new typeFormatModel();
                    
                    student.setPK_STUDENT(Integer.parseInt(request.getParameter("pt_pk_student")));
                    dataStudentsPenalityPayments.setStudent(student);
                    
                    semester.setPK_SEMESTER(Integer.parseInt(request.getParameter("pt_pk_semester")));
                    dataStudentsPenalityPayments.setSemester(semester);
                    
                    period.setPK_PERIOD(Integer.parseInt(request.getParameter("pt_pk_period")));
                    dataStudentsPenalityPayments.setPeriod(period);
                    
                    studentPenalityPayment.setPK_STUDENT_PAYMENT_PENALTY(Integer.parseInt(request.getParameter("pt_pk_student_payment_penality")));
                    dataStudentsPenalityPayments.setStudentPenalityPayment(studentPenalityPayment);
                    
                    paymentTypes.setPK_PAYMENT_PENALTY_TYPE(Integer.parseInt(request.getParameter("pt_pk_payment_penality_type")));
                    dataStudentsPenalityPayments.setPaymentTypes(paymentTypes);
                    
                    categoryPayments.setPK_CATEGORY_PAYMENT(Integer.parseInt(request.getParameter("pt_pk_category_payment")));
                    dataStudentsPenalityPayments.setCategoryPayments(categoryPayments);
                    
                    dataStudentsPenalityPayments.setFL_AMOUNT_PENALITY(request.getParameter("pt_amount_penality"));
                    dataStudentsPenalityPayments.setFL_REFERENCE_NUMBER(request.getParameter("pt_reference_number"));
                    
                    typeConcept.setPK_TYPE_CONCEPT(Integer.parseInt(request.getParameter("pt_pk_type_concept")));
                    dataStudentsPenalityPayments.setTypeConcept(typeConcept);
                    
                    typeFormat.setPK_TYPE_FORMAT(Integer.parseInt(request.getParameter("pt_pk_type_format")));
                    dataStudentsPenalityPayments.setTypeFormat(typeFormat);                    
                    
                    String result = new studentsPenaltyPaymentsDetailControl().InsertStudentsPenaltyPaymentDetail(dataStudentsPenalityPayments);
                    if(result.equals("Inserted")) {
                        data.put("status", "Success");
                    }else{
                        data.put("status", ""+result+"");
                    }
                } catch (Exception e) {
                    data.put("Fail", "paramsEmpty");
                }
                out.print(data);
            }
            if(request.getParameter("update")!=null){      
                
            }
            if(request.getParameter("delete")!=null){     
                response.setContentType("text/html;charset=UTF-8");
                if(request.getParameter("pt_pk_student_penality_payment_detail") != null){                    
                    out.print(new studentsPenaltyPaymentsDetailControl().DeleteStudentsPenaltyPaymentDetail(Integer.parseInt(request.getParameter("pt_pk_student_penality_payment_detail"))));
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
