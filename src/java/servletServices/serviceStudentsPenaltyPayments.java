/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletServices;

import control.studentsPenaltyPaymentsControl;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.periodModel;
import model.semesterModel;
import model.studentModel;
import model.studentsPenaltyPaymentsModel;
import model.typeFormatModel;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author Lab5-E
 */
@WebServlet(name = "serviceStudentsPenaltyPayments", urlPatterns = {"/serviceStudentsPenaltyPayments"})
public class serviceStudentsPenaltyPayments extends HttpServlet {

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
                ArrayList<studentsPenaltyPaymentsModel> listStudentsPenalityPayments;
                JSONArray principal = new JSONArray();
                JSONObject settings = new JSONObject();
                JSONArray content = new JSONArray();
                int fkPeriod=Integer.parseInt(request.getParameter("pt_fkPeriod"));
                int fkTypeFormat=Integer.parseInt(request.getParameter("pt_fkTypeFormat"));
                settings.put("__studentsPenaltyPaymentsModel","StudentsPenalityPayments");
                listStudentsPenalityPayments = new studentsPenaltyPaymentsControl().SelectStudentsPenaltyPayments(fkTypeFormat, fkPeriod);
                for(int i=0;i<listStudentsPenalityPayments.size();i++){
                    JSONObject data = new JSONObject();
                    data.put("dataProgresivNumber", i+1);
                    data.put("dataPkPaymentPanalty", listStudentsPenalityPayments.get(i).getPK_STUDENT_PAYMENT_PENALTY());
                    data.put("dataDatePayment", listStudentsPenalityPayments.get(i).getFL_DATE_PAYMENT());
                    data.put("dataUnique", listStudentsPenalityPayments.get(i).getFL_UNIQUE());
                    data.put("dataPkTypeFormat", listStudentsPenalityPayments.get(i).getTypeFormat().getPK_TYPE_FORMAT());
                    data.put("dataNameTypeFormat", listStudentsPenalityPayments.get(i).getTypeFormat().getFL_NAME_FORMAT());
                    data.put("dataTotal", listStudentsPenalityPayments.get(i).getFL_TOTAL());
                    data.put("dataPkStudent", listStudentsPenalityPayments.get(i).getStudent().getPK_STUDENT());
                    data.put("dataNameStudent", listStudentsPenalityPayments.get(i).getStudent().getFL_NAME());
                    data.put("dataEnrollment", listStudentsPenalityPayments.get(i).getStudent().getFL_ENROLLMENT());
                    data.put("dataPkStudyLevel", listStudentsPenalityPayments.get(i).getStudyLevel().getPK_LEVEL_STUDY());
                    data.put("dataNameLevel", listStudentsPenalityPayments.get(i).getStudyLevel().getFL_NAME_LEVEL());
                    data.put("dataPkCareer", listStudentsPenalityPayments.get(i).getCareer().getPK_CAREER());
                    data.put("dataNameAbbreviated", listStudentsPenalityPayments.get(i).getCareer().getFL_NAME_ABBREVIATED());
                    data.put("dataNameCareer", listStudentsPenalityPayments.get(i).getCareer().getFL_NAME_CAREER());
                    data.put("dataPkSemester", listStudentsPenalityPayments.get(i).getSemester().getPK_SEMESTER());
                    data.put("dataNameSemester", listStudentsPenalityPayments.get(i).getSemester().getFL_NAME_SEMESTER());
                    data.put("dataPkPeriod", listStudentsPenalityPayments.get(i).getPeriod().getPK_PERIOD());
                    data.put("dataNamePeriod", listStudentsPenalityPayments.get(i).getPeriod().getFL_NAME());
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
                        int pt_pk_students_penalty_payment = Integer.parseInt(request.getParameter("pt_pk_students_penalty_payment"));
                        String result =  new studentsPenaltyPaymentsControl().CommitFalseStudentsPenaltyPayment(pt_pk_students_penalty_payment);
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
                        studentsPenaltyPaymentsModel dataStudentsPenalityPayments=new studentsPenaltyPaymentsModel();
                        periodModel period = new periodModel();
                        semesterModel semester = new semesterModel();
                        studentModel student = new studentModel();
                        typeFormatModel typeFormat = new typeFormatModel();
                        period.setPK_PERIOD(Integer.parseInt(request.getParameter("pt_pk_period")));
                        dataStudentsPenalityPayments.setPeriod(period);
                        semester.setPK_SEMESTER(Integer.parseInt(request.getParameter("pt_pk_semester")));
                        dataStudentsPenalityPayments.setSemester(semester);
                        student.setPK_STUDENT(Integer.parseInt(request.getParameter("pt_pk_student")));
                        dataStudentsPenalityPayments.setStudent(student);

                        typeFormat.setPK_TYPE_FORMAT(Integer.parseInt(request.getParameter("pt_fk_type_format")));
                        dataStudentsPenalityPayments.setTypeFormat(typeFormat);
                        dataStudentsPenalityPayments.setFL_TOTAL(request.getParameter("pt_total"));
                        String[] result =  new studentsPenaltyPaymentsControl().InsertStudentsPenaltyPayment(dataStudentsPenalityPayments);
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
                response.setContentType("text/html;charset=UTF-8");             
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
