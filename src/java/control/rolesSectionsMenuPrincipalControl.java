/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package control;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author Carlos
 */
public class rolesSectionsMenuPrincipalControl {
    public String UpdateRolesSectionsMenuPrincipalControl(int pkRol, int pkSection, int access){
        String request;
        try {
            Connection conn=new connectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_ROLES_SECTION_MENU_PRINCIPAL`('update', "+pkRol+", "+pkSection+", "+access+")")) {
                ps.executeUpdate();
                request="Datos Modificados";
                ps.close();
                conn.close();
            }
        } catch (SQLException e) {
            request=""+e.getMessage();
            e.getMessage();
        }   
        return request;
    }
}
