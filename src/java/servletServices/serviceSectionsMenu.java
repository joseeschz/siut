/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletServices;

import control.rolesSectionsMenuPrincipalControl;
import control.sectionControl;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.sectionModel;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author CARLOS
 */
@WebServlet(name = "serviceSectionsMenu", urlPatterns = {"/serviceSectionsMenu"})
public class serviceSectionsMenu extends HttpServlet {

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
            int pt_rol;
            JSONArray content = new JSONArray();
            ArrayList<sectionModel> listSectionMenu;
            if(request.getParameter("view")!=null){
                switch (request.getParameter("view")) {
                    case "amissibleness":
                        pt_rol= Integer.parseInt(request.getParameter("userRol"));
                        listSectionMenu=new sectionControl().SelectSectionsAmissiblenessByRol(pt_rol);
                        String descriptionAccess;
                        for(int i=0;i<listSectionMenu.size();i++){
                            JSONObject data = new JSONObject();
                            if(listSectionMenu.get(i).getFL_ACCESS()==1){
                                descriptionAccess="Permitido";
                            }else{
                                descriptionAccess="Denegado";
                            }
                            data.put("dataProgresivNumber", i+1);
                            data.put("id", listSectionMenu.get(i).getPK_SECTION_MENU_PRINCIPAL());
                            data.put("dataFkParent", listSectionMenu.get(i).getPK_PARENT());
                            data.put("dataNamePage", "<img width=16 src='"+listSectionMenu.get(i).getFL_ICON()+"' /> "+listSectionMenu.get(i).getFL_NAME_SECTION());
                            data.put("dataAccess", listSectionMenu.get(i).getFL_ACCESS());
                            data.put("dataAccessDescription", descriptionAccess);
                            content.add(data);
                        }   break;
                    case "byPk":
                    {
                        int pkParent= Integer.parseInt(request.getParameter("pkParent"));
                        pt_rol= Integer.parseInt(request.getParameter("userRol"));
                        listSectionMenu=new sectionControl().SelectSection(pkParent, pt_rol);
                        for(int i=0;i<listSectionMenu.size();i++){
                            JSONObject data = new JSONObject();
                            data.put("id", listSectionMenu.get(i).getPK_SECTION_MENU_PRINCIPAL());
                            data.put("parentid", listSectionMenu.get(i).getPK_PARENT());
                            data.put("text", "<img width=16 src='"+listSectionMenu.get(i).getFL_ICON()+"' /> <span class='itemsMenu2' itemid='"+listSectionMenu.get(i).getFL_ITEM_ID()+"' parent='"+listSectionMenu.get(i).getPK_PARENT()+"'  dir='"+listSectionMenu.get(i).getFL_URL()+"'> "+listSectionMenu.get(i).getFL_NAME_SECTION()+"</span>");
                            content.add(data);
                    }       break;
                        }
                    case "selectItem":
                    {
                        int pkParent= Integer.parseInt(request.getParameter("pkParent"));
                        listSectionMenu=new sectionControl().SelectItem(pkParent);
                        for(int i=0;i<listSectionMenu.size();i++){
                            JSONObject data = new JSONObject();
                            data.put("id", listSectionMenu.get(i).getPK_SECTION_MENU_PRINCIPAL());
                            data.put("parentid", listSectionMenu.get(i).getPK_PARENT());
                            data.put("text", "<img width=16 src='"+listSectionMenu.get(i).getFL_ICON()+"' /> <span class='itemsMenu' itemid='"+listSectionMenu.get(i).getFL_ITEM_ID()+"' parent='"+listSectionMenu.get(i).getPK_PARENT()+"'  dir='"+listSectionMenu.get(i).getFL_URL()+"'> "+listSectionMenu.get(i).getFL_NAME_SECTION()+"</span>");
                            content.add(data);
                    }       break;
                    }
                    default:
                        int pt_pk_user = Integer.parseInt(session.getAttribute("pkUser").toString());
                        pt_rol = Integer.parseInt(session.getAttribute("userRol").toString());
                        listSectionMenu=new sectionControl().SelectSections(pt_pk_user, pt_rol);
                        for(int i=0;i<listSectionMenu.size();i++){
                            JSONObject data = new JSONObject();
                            data.put("id", listSectionMenu.get(i).getPK_SECTION_MENU_PRINCIPAL());
                            data.put("parentid", listSectionMenu.get(i).getPK_PARENT());
                            data.put("text", "<span class='itemsMenu' itemid='"+listSectionMenu.get(i).getFL_ITEM_ID()+"' parent='"+listSectionMenu.get(i).getPK_PARENT()+"'  dir='"+listSectionMenu.get(i).getFL_URL()+"'>"+listSectionMenu.get(i).getFL_NAME_SECTION()+"</span>");
                            data.put("icon", listSectionMenu.get(i).getFL_ICON());
                            content.add(data);
                    }   break;
                }
                
                response.setContentType("application/json"); 
                out.print(content);
                out.flush(); 
                out.close();
            }
            
            if(request.getParameter("amissiblenessUpdate")!=null){
                if(request.getParameter("pkRol") != null){
                    int pkRol=Integer.parseInt(request.getParameter("pkRol"));
                    int pkSection=Integer.parseInt(request.getParameter("pkSection")); 
                    int access=Integer.parseInt(request.getParameter("access"));
                    JSONObject data = new JSONObject();
                    data.put("retult", new rolesSectionsMenuPrincipalControl().UpdateRolesSectionsMenuPrincipalControl(pkRol, pkSection, access));
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
