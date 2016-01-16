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
import model.careerModel;

/**
 *
 * @author CARLOS
 */
public class careerControl {
    public static void main(String[] args) {
        ArrayList<careerModel> list=new careerControl().SelectCareerByTeacher(64, 3);
        for(int i=0;i<list.size();i++){
            System.out.println(list.get(i).getFL_NAME_CAREER());
        }
    }
    public ArrayList<careerModel> SelectCareer(String condition, int fkLevel){
        ArrayList<careerModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_CAREER`('"+condition+"','"+fkLevel+"')"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    careerModel listCareer=new careerModel();
                    listCareer.setPK_CAREER(res.getInt("PK_CAREER"));
                    listCareer.setFL_NAME_ABBREVIATED(res.getString("FL_NAME_ABBREVIATED"));
                    listCareer.setFL_NAME_CAREER(res.getString("FL_NAME_CAREER"));
                    listCareer.setFL_STATUS(res.getString("FL_STATUS"));
                    list.add(listCareer);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(careerModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<careerModel> SelectCareerByTeacher(int pk_teacher, int fkLevel){
        ArrayList<careerModel> list=new ArrayList<>();
        try {
            String procedure="CALL `GET_CAREER_SEMESTER_GROUP_MATTER_BY_TEACHER`('careerByTeacher', "+pk_teacher+", "+fkLevel+", null, null, null, null, null)";
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    careerModel listCareer=new careerModel();
                    listCareer.setPK_CAREER(res.getInt("PK_CAREER"));
                    listCareer.setFL_NAME_ABBREVIATED(res.getString("FL_NAME_ABBREVIATED"));
                    listCareer.setFL_NAME_CAREER(res.getString("FL_NAME_CAREER"));
                    listCareer.setFL_STATUS(res.getString("FL_STATUS"));
                    list.add(listCareer);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(careerModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public ArrayList<careerModel> SelectCareerByTeacherTutor(int pk_teacher, int fkLevel){
        ArrayList<careerModel> list=new ArrayList<>();
        try {
            String procedure="CALL `GET_CAREER_SEMESTER_GROUP_MATTER_BY_TEACHER`('careerByTeacherTutor', "+pk_teacher+", "+fkLevel+", null, null, null, null, null)";
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    careerModel listCareer=new careerModel();
                    listCareer.setPK_CAREER(res.getInt("PK_CAREER"));
                    listCareer.setFL_NAME_ABBREVIATED(res.getString("FL_NAME_ABBREVIATED"));
                    listCareer.setFL_NAME_CAREER(res.getString("FL_NAME_CAREER"));
                    listCareer.setFL_STATUS(res.getString("FL_STATUS"));
                    list.add(listCareer);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(careerModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public ArrayList<careerModel> SelectCareerByDirector(int pk_teacher, int fkLevel){
        ArrayList<careerModel> list=new ArrayList<>();
        try {
            String procedure="CALL `GET_CAREER_SEMESTER_GROUP_MATTER_BY_TEACHER`('careerByDirector', "+pk_teacher+", "+fkLevel+", null, null, null, null, null)";
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    careerModel listCareer=new careerModel();
                    listCareer.setPK_CAREER(res.getInt("PK_CAREER"));
                    listCareer.setFL_NAME_ABBREVIATED(res.getString("FL_NAME_ABBREVIATED"));
                    listCareer.setFL_NAME_CAREER(res.getString("FL_NAME_CAREER"));
                    listCareer.setFL_STATUS(res.getString("FL_STATUS"));
                    list.add(listCareer);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(careerModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public String InsertCareer(careerModel dataCareer){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_CAREER`('insert', null, '"+dataCareer.getFL_NAME_CAREER()+"', '"+dataCareer.getFL_NAME_ABBREVIATED()+"','"+dataCareer.getFL_STATUS()+"', '"+dataCareer.getFK_LEVEL()+"')")) {
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
    public String DeleteCareer(int pkCareer){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_CAREER`('delete', '"+pkCareer+"', null, null,null, null)")) {
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
    public String UpdateCareer(careerModel dataCareer){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_CAREER`('update', '"+dataCareer.getPK_CAREER()+"', '"+dataCareer.getFL_NAME_CAREER()+"', '"+dataCareer.getFL_NAME_ABBREVIATED()+"','"+dataCareer.getFL_STATUS()+"', '"+dataCareer.getFK_LEVEL()+"')")) {
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
