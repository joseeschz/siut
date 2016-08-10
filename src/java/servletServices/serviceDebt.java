/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletServices;

import control.debtControl;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.debtDetailModel;
import model.debtModel;
import model.periodModel;
import model.studentModel;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author Lab5-E
 */
@WebServlet(name = "serviceDebt", urlPatterns = {"/serviceDebt"})
public class serviceDebt extends HttpServlet {

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
            if(request.getParameter("selectDetailDebts")!=null){
                int pk_debt_detail=Integer.parseInt(request.getParameter("pt_pk_debt_detail"));
                ArrayList<debtDetailModel> listDebt=new debtControl().SelectDebtsDetail(pk_debt_detail);
                JSONArray content = new JSONArray();
                int i=0;
                for (debtDetailModel debtMdl : listDebt) {
                    i+=1;
                    JSONObject data = new JSONObject();
                    data.put("dataProgresivNumber", i);
                    data.put("dataPkDebtDetail", debtMdl.getPK_DEBT_DETAIL());
                    data.put("dataPkStudent", debtMdl.getStudentMdl().getPK_STUDENT());                    
                    data.put("dataRowDate", debtMdl.getFL_ROW_DATE());
                    data.put("dataMount", debtMdl.getFL_MOUNT());
                    data.put("dataFkDebt", debtMdl.getDebtMdl().getPK_DEBT());
                    data.put("dataMotive", debtMdl.getFL_MOTIVE());
                    data.put("dataPkPeriod", debtMdl.getPeriodMdl().getPK_PERIOD());
                    data.put("dataPeriod", debtMdl.getPeriodMdl().getFL_NAME());
                    data.put("dataStatusNowDebt", debtMdl.getFL_STATUS_NOW_DEBT());
                    content.add(data);
                }              
                response.setContentType("application/json"); 
                out.print(content);
                out.flush(); 
                out.close();               
            }
            if(request.getParameter("selectDebts")!=null){
                ArrayList<debtModel> listDebt=new debtControl().SelectDebts();  
                JSONArray content = new JSONArray();
                int i = 0;
                for (debtModel debtMdl : listDebt) {
                    i+=1;
                    JSONObject data = new JSONObject();
                    data.put("dataProgresivNumber", i);
                    data.put("dataPkDebt", debtMdl.getPK_DEBT());
                    data.put("dataPkStudent", debtMdl.getStudentMdl().getPK_STUDENT());                    
                    data.put("dataName", debtMdl.getStudentMdl().getFL_NAME());
                    data.put("dataEnrollment", debtMdl.getStudentMdl().getFL_ENROLLMENT());
                    data.put("dataCareer", debtMdl.getCareerMdl().getFL_NAME_CAREER());
                    data.put("dataStudyLevel", debtMdl.getStudyLevelMdl().getFL_NAME_LEVEL());
                    content.add(data);
                }              
                response.setContentType("application/json"); 
                out.print(content);
                out.flush(); 
                out.close();               
            }
            if(request.getParameter("insert")!=null){
                response.setContentType("application/json"); 
                if(true){
                    int pk_student = Integer.parseInt(request.getParameter("pt_pk_student"));
                    int pk_period = Integer.parseInt(request.getParameter("pt_pk_period"));
                    String mount = request.getParameter("pt_total");
                    String motive = request.getParameter("pt_motive");
                    String status = request.getParameter("pt_debt_status");
                    JSONObject data = new JSONObject();
                    debtDetailModel debtDetailMdl=new debtDetailModel();
                    studentModel studentMdl=new studentModel();
                    periodModel periodMdl=new periodModel();
                    
                    studentMdl.setPK_STUDENT(pk_student);
                    
                    debtDetailMdl.setFL_MOUNT(mount);
                    debtDetailMdl.setFL_MOTIVE(motive);                    
                    periodMdl.setPK_PERIOD(pk_period);
                    debtDetailMdl.setFL_STATUS_NOW_DEBT(status);
                    
                    debtDetailMdl.setStudentMdl(studentMdl);
                    debtDetailMdl.setPeriodMdl(periodMdl);  
                    
                    data.put("status", new debtControl().InsertDebt(debtDetailMdl));
                    out.print(data);
                }                
            }
            if(request.getParameter("update")!=null){      
                response.setContentType("application/json"); 
                if(true){
                    JSONObject data = new JSONObject();
                    int pt_pk_debt_detail = Integer.parseInt(request.getParameter("dataPkDebtDetail"));
                    int pk_student = Integer.parseInt(request.getParameter("dataPkStudent"));
                    int pk_period = Integer.parseInt(request.getParameter("dataPkPeriod"));
                    String mount = request.getParameter("dataMount");
                    String motive = request.getParameter("dataMotive");
                    String status = request.getParameter("dataStatusNowDebt");
                    if (status.equals("true")) {
                        status="1";
                    }else{
                        status="0";
                    }
                    
                    debtDetailModel debtDetailMdl=new debtDetailModel();
                    studentModel studentMdl=new studentModel();
                    periodModel periodMdl=new periodModel();
                    
                    debtDetailMdl.setPK_DEBT_DETAIL(pt_pk_debt_detail);
                    studentMdl.setPK_STUDENT(pk_student);                    
                    debtDetailMdl.setFL_MOUNT(mount);
                    debtDetailMdl.setFL_MOTIVE(motive);                    
                    periodMdl.setPK_PERIOD(pk_period);
                    debtDetailMdl.setFL_STATUS_NOW_DEBT(status);
                    
                    debtDetailMdl.setStudentMdl(studentMdl);
                    debtDetailMdl.setPeriodMdl(periodMdl);                
                    
                    data.put("status", new debtControl().UpdateDebt(debtDetailMdl));
                    out.print(data);
                }                
            }
            if(request.getParameter("delete")!=null){   
                response.setContentType("application/json"); 
                if(request.getParameter("pt_pk_debt_detail") != null){
                    JSONObject data = new JSONObject();
                    int pk_debt_detail=Integer.parseInt(request.getParameter("pt_pk_debt_detail"));
                    data.put("status", new debtControl().DeleteDebt(pk_debt_detail));
                    out.print(data);
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
