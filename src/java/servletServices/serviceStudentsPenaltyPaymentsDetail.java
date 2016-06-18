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
                ArrayList<studentsPenaltyPaymentsDetailModel> listStudentsPenalityPayments;
                JSONArray principal = new JSONArray();
                JSONObject settings = new JSONObject();
                JSONArray content = new JSONArray();
                int fkPeriod=Integer.parseInt(request.getParameter("pt_fkPeriod"));
                int fkSemester=Integer.parseInt(request.getParameter("pt_fkSemester"));
                int fkCategory=Integer.parseInt(request.getParameter("pt_fkCategory"));
                int fkStudent=Integer.parseInt(request.getParameter("pt_fkStudent"));
                settings.put("__studentsPenaltyPaymentsDetailModel","StudentsPenalityPayments");
                if(request.getParameter("view").equals("studentsAllStatusPaymentNotPrepaid")){
                    listStudentsPenalityPayments = new studentsPenaltyPaymentsDetailControl().SelectStudentsAllStatusPaymentNotPrepaid(fkPeriod, fkSemester, fkCategory, fkStudent);
                }else{
                    listStudentsPenalityPayments = new studentsPenaltyPaymentsDetailControl().SelectStudentsAllStatusPaymentNotPrepaid(fkPeriod, fkPeriod, fkPeriod,  fkPeriod);
                }
                for(int i=0;i<listStudentsPenalityPayments.size();i++){
                    JSONObject data = new JSONObject();
                    data.put("dataProgresivNumber", i+1);
                    data.put("dataPkStudentPenaltyPaymentDetail", listStudentsPenalityPayments.get(i).getPK_STUDENT_PENALTY_PAYMENT_DETAIL());
                    data.put("dataAmountPenalty", listStudentsPenalityPayments.get(i).getFL_AMOUNT_PENALITY());
                    data.put("dataMotiveJustify", listStudentsPenalityPayments.get(i).getFL_MOTIVE_JUSTIFY());
                    data.put("dataReferenceNumber", listStudentsPenalityPayments.get(i).getFL_REFERENCE_NUMBER());
                    data.put("dataStatusJustify", listStudentsPenalityPayments.get(i).getFL_STATUS_JUSTIFY());
                    data.put("dataStatusPay", listStudentsPenalityPayments.get(i).getFL_STATUS_PAY());
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
                    data.put("dataTariff", listStudentsPenalityPayments.get(i).getPaymentTypes().getFL_TARIFF());
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
                try {
                    studentsPenaltyPaymentsDetailModel dataStudentsPenalityPayments=new studentsPenaltyPaymentsDetailModel();
                    periodModel period = new periodModel();
                    semesterModel semester = new semesterModel();
                    studentModel student = new studentModel();
                    studentsPenaltyPaymentsModel studentPenalityPayment = new studentsPenaltyPaymentsModel();
                    paymentsPenaltyTypesModel paymentTypes = new paymentsPenaltyTypesModel();
                    categoryPaymentsModel categoryPayments = new categoryPaymentsModel();
                    
                    student.setPK_STUDENT(Integer.parseInt(request.getParameter("pt_pk_student")));
                    dataStudentsPenalityPayments.setStudent(student);
                    
                    semester.setPK_SEMESTER(Integer.parseInt(request.getParameter("pt_pk_semester")));
                    dataStudentsPenalityPayments.setSemester(semester);
                    
                    period.setPK_PERIOD(Integer.parseInt(request.getParameter("pt_pk_period")));
                    dataStudentsPenalityPayments.setPeriod(period);
                    
                    studentPenalityPayment.setPK_STUDENT_PAYMENT_PENALTY(Integer.parseInt(request.getParameter("pt_pk_student_payment_penality")));
                    dataStudentsPenalityPayments.setStudentPenalityPayment(studentPenalityPayment);
                    
                    paymentTypes.setPK_PAYMENT_PENALTY_TYPE(Integer.parseInt(request.getParameter("pt_payment_penality_type")));
                    dataStudentsPenalityPayments.setPaymentTypes(paymentTypes);
                    
                    categoryPayments.setPK_CATEGORY_PAYMENT(Integer.parseInt(request.getParameter("pt_category_payment")));
                    dataStudentsPenalityPayments.setCategoryPayments(categoryPayments);
                    
                    dataStudentsPenalityPayments.setFL_AMOUNT_PENALITY("");
                    dataStudentsPenalityPayments.setFL_REFERENCE_NUMBER(request.getParameter("pt_reference_number"));
                    dataStudentsPenalityPayments.setFL_STATUS_PAY("1");                  
                    
                    String result = new studentsPenaltyPaymentsDetailControl().InsertStudentsPenaltyPaymentDetail(dataStudentsPenalityPayments);
                    if(result.equals("Inserted")) {
                        data.put("status", "Success");
                    }else{
                        data.put("status", "Success");
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
