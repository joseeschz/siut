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
import model.schoolYearModel;


/**
 *
 * @author CARLOS
 */
public class schoolYearControl {
    public static void main(String[] args) {
        ArrayList<schoolYearModel> list=new schoolYearControl().SelectSchoolYear("all");
        for(int i=0;i<list.size();i++){
            System.out.println(list.get(i).getFL_ACTIVE());
        }
    }
    public ArrayList<schoolYearModel> SelectSchoolYear(String condition){
        ArrayList<schoolYearModel> list=new ArrayList<>();
        try {
            String procedure="CALL `GET_SCHOOL_YEAR`('"+condition+"', null, null, null, null)";
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    schoolYearModel listSchoolYear=new schoolYearModel();
                    listSchoolYear.setPK_SCHOOL_YEAR(res.getInt("PK_SCHOOL_YEAR"));
                    listSchoolYear.setFL_UNIQUE(res.getString("FL_UNIQUE"));
                    listSchoolYear.setFL_SCHOOL_YEAR_NAME(res.getString("FL_SCHOOL_YEAR_NAME"));
                    listSchoolYear.setFL_YEAR_BEGIN(res.getString("FL_YEAR_BEGIN"));
                    listSchoolYear.setFL_YEAR_END(res.getString("FL_YEAR_END"));
                    listSchoolYear.setFL_ACTIVE(res.getString("FL_ACTIVE"));
                    list.add(listSchoolYear);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        }catch (SQLException ex) {
            Logger.getLogger(schoolYearModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public String InsertSchoolYear(schoolYearModel dataSchoolYear){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_SCHOOL_YEAR`('insert', null, null, '"+dataSchoolYear.getFL_YEAR_BEGIN()+"', '"+dataSchoolYear.getFL_YEAR_END()+"', null)")) {
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
    public String DeleteSchoolYear(int pkSchoolYear){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_SCHOOL_YEAR`('delete', "+pkSchoolYear+", null, null, null, null)")) {
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
    public String UpdateSchoolYear(schoolYearModel dataSchoolYear){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_SCHOOL_YEAR`('update', "+dataSchoolYear.getPK_SCHOOL_YEAR()+", '', '', '', "+dataSchoolYear.getFL_ACTIVE()+")")) {
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
