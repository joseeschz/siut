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
import model.groupStudentModel;

/**
 *
 * @author Carlos
 */
public class groupStudentControl {
    public static void main(String[] args) {
        /*ArrayList<groupStudentModel> list=new groupStudentControl().SelectGroupStudent(2, 8, 2, 4);
        for(int i=0;i<list.size();i++){
            System.out.println(list.get(i).getFL_ENROLLMENT());
        }*/
        groupStudentModel dataStudent = new groupStudentModel();
        dataStudent.setFL_ENROLLMENT("UTS12S-003661k");
        dataStudent.setFK_CAREER(1);
        dataStudent.setFK_SEMESTER(2);
        dataStudent.setFK_SEMESTER(2);
        dataStudent.setFK_GROUP(2);
        dataStudent.setFK_PERIOD(2);
        dataStudent.setFK_TUTOR_TEACHER(1);
        System.out.println(new groupStudentControl().InsertGroupStudent(dataStudent));
    }
    public ArrayList<groupStudentModel> SelectGroupStudent(int pt_fk_career, int pt_fk_semester, int pt_fk_group, int pt_fk_period){
        ArrayList<groupStudentModel> list=new ArrayList<>();
        try {
            //Was removed the parameter pt_fk_semester because is not necesary...
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_GROUP_BY_STUDENTS`('filterable', '"+pt_fk_career+"', '"+pt_fk_semester+"' ,'"+pt_fk_group+"', '"+pt_fk_period+"')"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    groupStudentModel allGroupStudent=new groupStudentModel();
                    allGroupStudent.setPK_GRUPOS_BY_STUDENT(res.getInt("PK_GRUPOS_BY_STUDENT"));
                    allGroupStudent.setFL_ENROLLMENT(res.getString("FL_ENROLLMENT"));
                    allGroupStudent.setFL_STUDENT_NAME(res.getString("FL_STUDENT_NAME"));
                    allGroupStudent.setFK_TUTOR_TEACHER(res.getInt("FK_TUTOR_TEACHER"));
                    list.add(allGroupStudent);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(groupStudentModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public String InsertGroupStudent(groupStudentModel dataGroupStudent){
        String request="";
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `SET_GROUP_BY_STUDENT`('insert', NULL, '"+dataGroupStudent.getFL_ENROLLMENT()+"', "+dataGroupStudent.getFK_CAREER()+", "+dataGroupStudent.getFK_SEMESTER()+", "+dataGroupStudent.getFK_GROUP()+", "+dataGroupStudent.getFK_PERIOD()+", "+dataGroupStudent.getFK_TUTOR_TEACHER()+")"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    request = res.getString("FL_RESULT");
                }
                res.close();
                ps.close();
                conn.close();
            }
            return request;
        } catch (SQLException ex) {
            request=""+ex.getMessage();
            Logger.getLogger(groupStudentModel.class.getName()).log(Level.SEVERE, null, ex);
        }  
        return request;
    }
    
    public String UpdateGroupStudent(groupStudentModel dataGroupStudent){
        String request="";
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `SET_GROUP_BY_STUDENT`('update', NULL, '"+dataGroupStudent.getFL_ENROLLMENT()+"', "+dataGroupStudent.getFK_CAREER()+", "+dataGroupStudent.getFK_SEMESTER()+", "+dataGroupStudent.getFK_GROUP()+", "+dataGroupStudent.getFK_PERIOD()+", "+dataGroupStudent.getFK_TUTOR_TEACHER()+")"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    request = res.getString("FL_RESULT");
                }
                res.close();
                ps.close();
                conn.close();
            }
            return request;
        } catch (SQLException ex) {
            request=""+ex.getMessage();
            Logger.getLogger(groupStudentModel.class.getName()).log(Level.SEVERE, null, ex);
        }  
        return request;
    }
    
    public String DeleteGroupStudent(int pkGroupByStudent){
        String request="";
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `SET_GROUP_BY_STUDENT`('delete', "+pkGroupByStudent+", NULL, NULL, NULL, NULL, NULL, NULL)"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    request = res.getString("FL_RESULT");
                }
                res.close();
                ps.close();
                conn.close();
            }
            return request;
        } catch (SQLException ex) {
            request=""+ex.getMessage();
            Logger.getLogger(groupStudentModel.class.getName()).log(Level.SEVERE, null, ex);
        }  
        return request;
    }
}
