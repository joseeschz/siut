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
import model.groupModel;

/**
 *
 * @author CARLOS
 */
public class groupControl {
    public static void main(String[] args) {
        ArrayList<groupModel> list=new groupControl().SelectGroupByTeacher(30, 6, 13, 2, null);
        for(int i=0;i<list.size();i++){
            System.out.println(list.get(i).getFL_NAME_GROUP());
        }
    }
    public ArrayList<groupModel> SelectGroup(String action, int fkSemester){
        ArrayList<groupModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_GROUP`('"+action+"', '"+fkSemester+"')"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    groupModel listGroup=new groupModel();
                    listGroup.setPK_GROUP(res.getInt("PK_GROUP"));
                    listGroup.setFL_NAME_GROUP(res.getString("FL_NAME_GROUP"));
                    list.add(listGroup);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(groupModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public ArrayList<groupModel> SelectGroupByTeacher(int pkTeacher, int pkCareer, int fkPeriod, int fkSemester, String fkMatter){
        ArrayList<groupModel> list=new ArrayList<>();
        String procedure = null;
        if(fkMatter!=null){
            procedure="CALL `GET_CAREER_SEMESTER_GROUP_MATTER_BY_TEACHER`('groupByTeacherByMatter', "+pkTeacher+", null, "+pkCareer+", "+fkPeriod+", "+fkSemester+", null, "+fkMatter+")";
        }else{
            procedure="CALL `GET_CAREER_SEMESTER_GROUP_MATTER_BY_TEACHER`('groupByTeacher', "+pkTeacher+", null, "+pkCareer+", "+fkPeriod+", "+fkSemester+", null, null)";
        }
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    groupModel listGroup=new groupModel();
                    listGroup.setPK_GROUP(res.getInt("PK_GROUP"));
                    listGroup.setFL_NAME_GROUP(res.getString("FL_NAME_GROUP"));
                    list.add(listGroup);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(groupModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public ArrayList<groupModel> SelectGroupByTeacherTutor(int pkTeacher, int fkPeriod, int fkSemester){
        ArrayList<groupModel> list=new ArrayList<>();
        String procedure="CALL `GET_CAREER_SEMESTER_GROUP_MATTER_BY_TEACHER`('groupByTeacherTutor', "+pkTeacher+", null, null, "+fkPeriod+", "+fkSemester+", null, null)";
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    groupModel listGroup=new groupModel();
                    listGroup.setPK_GROUP(res.getInt("PK_GROUP"));
                    listGroup.setFL_NAME_GROUP(res.getString("FL_NAME_GROUP"));
                    list.add(listGroup);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(groupModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public ArrayList<groupModel> SelectGroupByDirector(int pkTeacher, int fkPeriod, int fkSemester){
        ArrayList<groupModel> list=new ArrayList<>();
        String procedure="CALL `GET_CAREER_SEMESTER_GROUP_MATTER_BY_TEACHER`('groupByDirector', "+pkTeacher+", null, null, "+fkPeriod+", "+fkSemester+", null, null)";
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    groupModel listGroup=new groupModel();
                    listGroup.setPK_GROUP(res.getInt("PK_GROUP"));
                    listGroup.setFL_NAME_GROUP(res.getString("FL_NAME_GROUP"));
                    list.add(listGroup);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(groupModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public String InsertGroup(groupModel dataGroup){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_GROUP`('insert', null, '"+dataGroup.getFL_NAME_GROUP()+"', '"+dataGroup.getFK_SEMESTER()+"')")) {
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
    public String DeleteGroup(int pkGroup){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_GROUP`('delete', '"+pkGroup+"', null, null)")) {
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
    public String UpdateGroup(groupModel dataGroup){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_GROUP`('update', '"+dataGroup.getPK_GROUP()+"','"+dataGroup.getFL_NAME_GROUP()+"', '"+dataGroup.getFK_SEMESTER()+"')")) {
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
