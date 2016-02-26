/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletServices;

import control.studentControl;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.studentModel;

/**
 *
 * @author Lab5-E
 */
@WebServlet(name = "activeMail", urlPatterns = {"/activeMail"})
public class activeMail extends HttpServlet {

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
            if(request.getParameter("selectLoginStudent")!=null){
                String statusLogin = request.getParameter("statusLogin");
                if(statusLogin.equals("in")){                    
                    String enrollment = request.getParameter("enrollment");
                    String password = request.getParameter("password");
                    int pkStudent = 0;
                    String name = "";
                    String mail;
                    studentModel dataUser=new studentModel();
                    dataUser.setFL_ENROLLMENT(enrollment);
                    dataUser.setFL_PASSWORD(password);
                    ArrayList<studentModel> list=new studentControl().SelectUserLogin(dataUser); 
                    if(enrollment != null && password != null){
                        if(list.size()==1){
                            for (studentModel list1 : list) {
                                pkStudent = list1.getPK_STUDENT();
                                name = list1.getFL_NAME();
                                mail = list1.getFL_MAIL();
                                if(mail.equals("")){
                                    out.print("Sin correo");
                                }else{
                                    out.print(mail);
                                }
                            }    
                        }else{
                            out.print("notExit");                            
                        }
                    }
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
        response.sendRedirect("");
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
