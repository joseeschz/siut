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
import model.activitiesByStudentsModel;

/**
 *
 * @author Carlos
 */
public class activitiesByStudentsControl {
    public static void main(String[] args) {
        ArrayList<activitiesByStudentsModel> list=new activitiesByStudentsControl().SelectListActivitiesByStudents(12990, 325, 1, 0);
        for(int i=0;i<list.size();i++){
            System.out.println(list.get(i).getFL_NAME_ACTIVITY());
        }
        //System.out.print(new activitiesByStudentsControl().UpdateActivitiesByStudents(1, 0));
    }
    public ArrayList<activitiesByStudentsModel> SelectActivitiesByStudents(int pkCareer, int pkSemester, int pkGroup, int pkActivity, int pkPeriod){
        ArrayList<activitiesByStudentsModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_ACTIVITIES_CAL_BY_STUDENTS`('allFilter', "+pkCareer+", "+pkSemester+", "+pkGroup+", "+pkActivity+" ,"+pkPeriod+")"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    activitiesByStudentsModel listActivitiesByStudents=new activitiesByStudentsModel();
                    listActivitiesByStudents.setPK_ACTIVITY_BY_STUDENT(res.getInt("PK_ACTIVITY_BY_STUDENT"));
                    listActivitiesByStudents.setFK_STUDENT(res.getInt("PK_STUDENT"));
                    listActivitiesByStudents.setFL_ENROLLMENT(res.getString("FL_ENROLLMENT"));
                    listActivitiesByStudents.setFL_NAME_STUDENT(res.getString("FL_NAME_STUDENT"));
                    listActivitiesByStudents.setFL_VALUE_OBTANIED(res.getString("FL_VALUE_OBTANIED"));
                    listActivitiesByStudents.setFL_ACUMULATED_NOW(res.getString("FL_ACUMULATED_NOW"));
                    list.add(listActivitiesByStudents);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(activitiesByStudentsModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<activitiesByStudentsModel> SelectActivitiesByStudentsRegularization(int pkCareer, int pkSemester, int pkGroup, int pkActivity, int pkPeriod){
        ArrayList<activitiesByStudentsModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_ACTIVITIES_CAL_BY_STUDENTS`('allFilterRegularization', "+pkCareer+", "+pkSemester+", "+pkGroup+", "+pkActivity+" ,"+pkPeriod+")"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    activitiesByStudentsModel listActivitiesByStudents=new activitiesByStudentsModel();
                    listActivitiesByStudents.setPK_ACTIVITY_BY_STUDENT(res.getInt("PK_ACTIVITY_BY_STUDENT"));
                    listActivitiesByStudents.setFK_STUDENT(res.getInt("PK_STUDENT"));
                    listActivitiesByStudents.setFL_ENROLLMENT(res.getString("FL_ENROLLMENT"));
                    listActivitiesByStudents.setFL_NAME_STUDENT(res.getString("FL_NAME_STUDENT"));
                    listActivitiesByStudents.setFL_VALUE_OBTANIED_OLD(res.getString("FL_VALUE_OBTANIED_OLD"));
                    listActivitiesByStudents.setFL_VALUE_OBTANIED(res.getString("FL_VALUE_OBTANIED"));
                    listActivitiesByStudents.setFL_APPROVED(res.getString("FL_APPROVED"));
                    listActivitiesByStudents.setFL_ACUMULATED_NOW(res.getString("FL_ACUMULATED_NOW"));
                    list.add(listActivitiesByStudents);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(activitiesByStudentsModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<activitiesByStudentsModel> SelectActivitiesByStudentsGlobal(int pkCareer, int pkSemester, int pkGroup, int pkActivity, int pkPeriod){
        ArrayList<activitiesByStudentsModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_ACTIVITIES_CAL_BY_STUDENTS`('allFilterGlobal', "+pkCareer+", "+pkSemester+", "+pkGroup+", "+pkActivity+" ,"+pkPeriod+")"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    activitiesByStudentsModel listActivitiesByStudents=new activitiesByStudentsModel();
                    listActivitiesByStudents.setPK_ACTIVITY_BY_STUDENT(res.getInt("PK_ACTIVITY_BY_STUDENT"));
                    listActivitiesByStudents.setFK_STUDENT(res.getInt("PK_STUDENT"));
                    listActivitiesByStudents.setFL_ENROLLMENT(res.getString("FL_ENROLLMENT"));
                    listActivitiesByStudents.setFL_NAME_STUDENT(res.getString("FL_NAME_STUDENT"));
                    listActivitiesByStudents.setFL_VALUE_OBTANIED_OLD(res.getString("FL_VALUE_OBTANIED_OLD"));
                    listActivitiesByStudents.setFL_VALUE_OBTANIED(res.getString("FL_VALUE_OBTANIED"));
                    listActivitiesByStudents.setFL_APPROVED(res.getString("FL_APPROVED"));
                    listActivitiesByStudents.setFL_ACUMULATED_NOW(res.getString("FL_ACUMULATED_NOW"));
                    list.add(listActivitiesByStudents);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(activitiesByStudentsModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<activitiesByStudentsModel> SelectListActivitiesByStudents(int pkStudent,int pkMatter, int pkScale, int pkPeriod){
        ArrayList<activitiesByStudentsModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_CALIFICATIONS_BY_STUDENTS`('byMatter', "+pkStudent+","+pkMatter+" ,"+pkScale+", null)"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    activitiesByStudentsModel listActivitiesByStudents=new activitiesByStudentsModel();
                    listActivitiesByStudents.setFK_SCALE_EVALUATION(res.getInt("PK_SCALE_EVALUATION"));
                    listActivitiesByStudents.setFL_NAME_SCALE(res.getString("FL_NAME_SCALE"));
                    listActivitiesByStudents.setPK_ACTIVITY(res.getInt("PK_ACTIVITY"));
                    listActivitiesByStudents.setFL_NAME_ACTIVITY(res.getString("FL_NAME_ACTIVITY"));
                    listActivitiesByStudents.setPK_ACTIVITY_BY_STUDENT(res.getInt("PK_ACTIVITY_BY_STUDENT"));
                    listActivitiesByStudents.setFL_VALUE_OBTANIED(res.getString("FL_VALUE_OBTANIED"));
                    listActivitiesByStudents.setFL_VALUE_ACTIVITY(res.getDouble("FL_VALUE_ACTIVITY"));
                    list.add(listActivitiesByStudents);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(activitiesByStudentsModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<activitiesByStudentsModel> SelectListActivitiesByStudent(int pkStudent,int pkMatter, int pkScale, int pkPeriod){
        ArrayList<activitiesByStudentsModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_CALIFICATIONS_BY_STUDENTS`('byMatterByStudent', "+pkStudent+","+pkMatter+" ,"+pkScale+", null)"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    activitiesByStudentsModel listActivitiesByStudents=new activitiesByStudentsModel();
                    listActivitiesByStudents.setFK_SCALE_EVALUATION(res.getInt("PK_SCALE_EVALUATION"));
                    listActivitiesByStudents.setFL_NAME_SCALE(res.getString("FL_NAME_SCALE"));
                    listActivitiesByStudents.setPK_ACTIVITY(res.getInt("PK_ACTIVITY"));
                    listActivitiesByStudents.setFL_NAME_ACTIVITY(res.getString("FL_NAME_ACTIVITY"));
                    listActivitiesByStudents.setPK_ACTIVITY_BY_STUDENT(res.getInt("PK_ACTIVITY_BY_STUDENT"));
                    listActivitiesByStudents.setFL_VALUE_OBTANIED(res.getString("FL_VALUE_OBTANIED"));
                    listActivitiesByStudents.setFL_VALUE_ACTIVITY(res.getDouble("FL_VALUE_ACTIVITY"));
                    list.add(listActivitiesByStudents);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(activitiesByStudentsModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public String InsertActivitiesByStudents(int pkCareer, int pkSemester, int pkGroup, int pkMatter, int pkActivity, int pkPeriod){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_ACTIVITIES_CAL_BY_STUDENTS`('insert', null, "+pkCareer+", "+pkSemester+", "+pkGroup+", "+pkMatter+", "+pkPeriod+", "+pkActivity+", null)")) {
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
    public String UpdateActivitiesByStudents(int updateType, int pkActivityByStudent, double valueOptanied ){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_ACTIVITIES_CAL_BY_STUDENTS`('update"+updateType+"', "+pkActivityByStudent+", null, null, null, null, null, null, '"+valueOptanied+"')")) {
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