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
import model.groupMatterTeacherModel;

/**
 *
 * @author Carlos
 */
public class groupMatterTeacherControl {
    public static void main(String[] args) {
        ArrayList<groupMatterTeacherModel> list=new groupMatterTeacherControl().SelectGroupMatterTecher("filterable", 11, 1, 8,72,2);
        for(int i=0;i<list.size();i++){
            System.out.println(list.get(i).getFL_NAME_GROUP());
        }
    }
    public ArrayList<groupMatterTeacherModel> SelectGroupMatterTecher(String command, int pk_career, int pk_study_plan, int pk_semester, int pk_group, int pk_period){
        ArrayList<groupMatterTeacherModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_GROUP_MATTER_TEACHER`('"+command+"','"+pk_career+"','"+pk_study_plan+"','"+pk_semester+"', '"+pk_group+"', '"+pk_period+"')"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    groupMatterTeacherModel allGroupMatterTecher=new groupMatterTeacherModel();
                    allGroupMatterTecher.setPK_GROUP_MATTER_TECHER(res.getInt("PK_GROUP_MATTER_TECHER"));
                    allGroupMatterTecher.setFL_NAME_SUBJECT_MATTER(res.getString("FL_NAME_SUBJECT_MATTER"));
                    allGroupMatterTecher.setFL_NAME_TEACHER(res.getString("FL_NAME_TEACHER"));
                    list.add(allGroupMatterTecher);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(groupMatterTeacherModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public String InsertGroupMatterTeacher(groupMatterTeacherModel dataGroupMatterTecher){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_GROUP_MATTER_TEACHER`('insert', null,'"+dataGroupMatterTecher.getFK_CAREER()+"', '"+dataGroupMatterTecher.getFK_SEMESTER()+"', '"+dataGroupMatterTecher.getFK_GROUP()+"', '"+dataGroupMatterTecher.getFK_SUBJECT_MATTER()+"', '"+dataGroupMatterTecher.getFK_TEACHER()+"', '"+dataGroupMatterTecher.getFK_PERIOD()+"')")) {
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
    public String DeleteGroupMatterTeacher(int pkGroupMatterTecher){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_GROUP_MATTER_TEACHER`('delete', '"+pkGroupMatterTecher+"', null, null, null, null, null, null)")) {
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
    public String UpdateGroupMatterTeacher(groupMatterTeacherModel dataGroupMatterTecher){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_GROUP_MATTER_TEACHER`('update', '"+dataGroupMatterTecher.getPK_GROUP_MATTER_TECHER()+"', '"+dataGroupMatterTecher.getFK_SEMESTER()+"', '"+dataGroupMatterTecher.getFK_GROUP()+"', '"+dataGroupMatterTecher.getFK_SUBJECT_MATTER()+"', '"+dataGroupMatterTecher.getFK_TEACHER()+"', '"+dataGroupMatterTecher.getFK_PERIOD()+"')")) {
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
