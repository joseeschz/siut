/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletServices;

import control.userControl;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.userModel;
import org.json.simple.JSONObject;

/**
 *
 * @author CARLOS
 */
@WebServlet(name = "login", urlPatterns = {"/login"})
public class login extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        String statusLogin = request.getParameter("statusLogin");
        if(statusLogin.equals("in")){
            try (PrintWriter out = response.getWriter()) {
                String userName = request.getParameter("userName");
                String password = request.getParameter("password");
                int pkUser = 0;
                String name = "";
                int userRol = 0;
                String userRolName = "";
                userModel dataUser=new userModel();
                dataUser.setFL_MAIL(userName);
                dataUser.setFL_PASSWORD(password);
                ArrayList<userModel> list=new userControl().SelectUserLogin(dataUser);
                for(int i=0;i<list.size();i++){
                    pkUser = list.get(i).getPK_USER();
                    name = list.get(i).getFL_NAME_USER();
                    userRol = list.get(i).getFK_ROL();
                    userRolName = list.get(i).getFL_NAME_ROL();
                }
                if(userName != null && password != null){
                    if(list.size()==1){
                        session.setAttribute("pkUser", pkUser);
                        session.setAttribute("logueado", name);
                        session.setAttribute("userRol", userRol);
                        session.setAttribute("userRolName", userRolName);
                        session.setAttribute("userName", userName);
                        out.print("logeado");                   
                    }else{
                        out.print("notExit");
                        session.removeAttribute("pkUser");
                        session.removeAttribute("logueado");
                        session.removeAttribute("userRol");
                        session.removeAttribute("userRolName");
                        session.removeAttribute("userName");
                    }
                }
            }
        }else if(statusLogin.equals("logged")){
            JSONObject status = new JSONObject();
            try (PrintWriter out = response.getWriter()) {
                response.setContentType("application/json");
                if(session.getAttribute("logueado")!=null){
                    status.put("status", true);
                }else{
                    status.put("status", false);                     
                }
                out.print(status);   
            }
        }else{
            session.removeAttribute("pkUser");
            session.removeAttribute("logueado");
            session.removeAttribute("userRol");
            session.removeAttribute("userRolName");
            session.removeAttribute("userName");
            response.sendRedirect("/admin/login.jsp");
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
