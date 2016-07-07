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
import model.generationsModel;


/**
 *
 * @author CARLOS
 */
public class generationsControl {
    public static void main(String[] args) {
        ArrayList<generationsModel> list=new generationsControl().SelectGenerations("all");
        for(int i=0;i<list.size();i++){
            System.out.println(list.get(i).getFL_ACTIVE());
        }
    }
    public ArrayList<generationsModel> SelectGenerations(String condition){
        ArrayList<generationsModel> list=new ArrayList<>();
        try {
            String procedure="CALL `GET_GENERATIONS`('"+condition+"')";
            try (Connection conn = new connectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    generationsModel listGenerations=new generationsModel();
                    listGenerations.setPK_GENERATION(res.getInt("PK_GENERATION"));
                    listGenerations.setFL_UNIQUE(res.getString("FL_UNIQUE"));
                    listGenerations.setFL_GENERATION_NAME(res.getString("FL_GENERATION_NAME"));
                    listGenerations.setFL_STATUS_ACTIVE(res.getString("FL_STATUS_ACTIVE"));
                    listGenerations.setFL_YEAR_BEGIN(res.getString("FL_YEAR_BEGIN"));
                    listGenerations.setFL_YEAR_END(res.getString("FL_YEAR_END"));
                    list.add(listGenerations);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        }catch (SQLException ex) {
            Logger.getLogger(generationsModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public String InsertGenerations(generationsModel dataGenerations){
        String request = null;
        try {
            String procedure="CALL `SET_GENERATIONS`('insert', null, null, null, '"+dataGenerations.getFL_YEAR_BEGIN()+"', '"+dataGenerations.getFL_YEAR_END()+"')";
            try (Connection conn = new connectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    request = res.getString("FL_RESULT");
                }
                res.close();
                ps.close();
                conn.close();
            }
        }catch (SQLException ex) {
            request=""+ex.getMessage();
            ex.getMessage();
        }   
        return request;
    }
    public String DeleteGenerations(int pkGenerations){
        String request;
        try {
            Connection conn=new connectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_GENERATIONS`('delete', "+pkGenerations+", null, null, null, null)")) {
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
    public String UpdateGenerations(generationsModel dataGenerations){
        String request;
        try {
            Connection conn=new connectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_GENERATIONS`('update', "+dataGenerations.getPK_GENERATION()+", null, "+dataGenerations.getFL_STATUS_ACTIVE()+", null, null)")) {
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
