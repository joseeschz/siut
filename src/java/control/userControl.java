/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package control;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.userModel;

/**
 *
 * @author CARLOS
 */
public class userControl {
    public static void main(String[] args) {
        userModel prueba=new userModel();
        prueba.setFL_MAIL("admin@mail.com");
        prueba.setFL_PASSWORD("admin");
        prueba.setFL_USER_NAME("admin");
        ArrayList<userModel> list=new userControl().SelectUserLogin(prueba);
        for(int i=0;i<list.size();i++){
            System.out.println(list.get(i).getFL_NAME_USER());
            System.out.println();
        }
    }
    public ArrayList<userModel> SelectUserLogin(userModel dataUser){
        ArrayList<userModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_LOGIN`('worker', '"+dataUser.getFL_MAIL()+"', '"+dataUser.getFL_PASSWORD()+"')"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    userModel userLogin=new userModel();
                    userLogin.setPK_USER(res.getInt("PK_USER"));
                    userLogin.setFL_NAME_USER(res.getString("FL_NAME_USER"));
                    userLogin.setFL_MAIL(res.getString("FL_MAIL"));
                    userLogin.setFL_USER_NAME(res.getString("FL_USER_NAME"));
                    userLogin.setFK_ROL(res.getInt("FK_ROL"));
                    userLogin.setFL_NAME_ROL(res.getString("FL_NAME_ROL"));
                    list.add(userLogin);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(userModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<userModel> SelectUsers(){
        ArrayList<userModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(""); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    userModel userAll=new userModel();
                    userAll.setPK_USER(res.getInt("PK_USER"));
                    list.add(userAll);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(userModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public String InsertUser(userModel dataUser){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("")) {
                ps.executeUpdate();
                request="Datos Guardados";
                ps.close();
                conn.close();
            }
        } catch (SQLException e) {
            request=""+e.getMessage();
            e.getMessage();
        }   
        return request;
    }
    public String DeleteUser(int pkUser){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("")) {
                ps.executeUpdate();
                request="Dato Eliminado";
                ps.close();
                conn.close();
            }
        } catch (SQLException e) {
            request=""+e.getMessage();
            e.getMessage();
        }   
        return request;
    }
    public String UpdateUser(userModel dataUser){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("")) {
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
