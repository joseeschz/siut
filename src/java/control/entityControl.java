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
import model.entityModel;

/**
 *
 * @author CARLOS
 */
public class entityControl {
    public static void main(String[] args) {
        ArrayList<entityModel> list=new entityControl().SelectEntity("inegi");
        for(int i=0;i<list.size();i++){
            System.out.println(list.get(i).getFL_NAME_ENTITY());
        }
    }
    public ArrayList<entityModel> SelectEntity(String action){
        ArrayList<entityModel> list=new ArrayList<>();
        try {
            try (Connection conn = new connectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_ENTITY`('"+action+"')"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    entityModel allStates=new entityModel();
                    allStates.setPK_ENTITY(res.getInt("PK_ENTITY"));
                    allStates.setFL_NAME_ENTITY(res.getString("FL_NAME"));
                    list.add(allStates);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(entityModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public String InsertEntity(entityModel dataEntity){
        String request;
        try {
            Connection conn=new connectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_ENTITY`('insert',null,'"+dataEntity.getFL_NAME_ENTITY()+"')")) {
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
    public String DeleteEntity(int pkEntity){
        String request;
        try {
            Connection conn=new connectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_ENTITY`('delete','"+pkEntity+"','')")) {
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
    public String UpdateEntity(entityModel dataEntity){
        String request;
        try {
            Connection conn=new connectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_ENTITY`('update','"+dataEntity.getPK_ENTITY()+"','"+dataEntity.getFL_NAME_ENTITY()+"')")) {
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
