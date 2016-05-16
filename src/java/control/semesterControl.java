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
import model.semesterModel;

/**
 *
 * @author CARLOS
 */
public class semesterControl {
    public static void main(String[] args) {
        ArrayList<semesterModel> list=new semesterControl().SelectCurrentSemester(1, 1, 13);
        for(int i=0;i<list.size();i++){
            System.out.println(list.get(i).getFL_NAME_SEMESTER());
        }
    }
    public ArrayList<semesterModel> SelectCurrentSemester(int pkCareer, int pkStudyPlan, int pkPeriod){
        ArrayList<semesterModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_SEMESTER`('currentSemester', null, "+pkCareer+", "+pkStudyPlan+", "+pkPeriod+")"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    semesterModel allSemesters=new semesterModel();
                    allSemesters.setPK_SEMESTER(res.getInt("PK_SEMESTER"));
                    allSemesters.setFL_NAME_SEMESTER(res.getString("FL_NAME_SEMESTER"));
                    list.add(allSemesters);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(semesterModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<semesterModel> SelectSemester(int pkStudyLevel){
        ArrayList<semesterModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_SEMESTER`('all', "+pkStudyLevel+", null, null, null)"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    semesterModel allSemesters=new semesterModel();
                    allSemesters.setPK_SEMESTER(res.getInt("PK_SEMESTER"));
                    allSemesters.setFL_NAME_SEMESTER(res.getString("FL_NAME_SEMESTER"));
                    list.add(allSemesters);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(semesterModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<semesterModel> SelectSemesterByTeacher(int pkTeacher, int pkStudyLevel, int pkCareer, int pkPeriod){
        ArrayList<semesterModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_CAREER_SEMESTER_GROUP_MATTER_BY_TEACHER`('semesterByTeacher', "+pkTeacher+", "+pkStudyLevel+", "+pkCareer+", "+pkPeriod+", null, null, null)"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    semesterModel allSemesters=new semesterModel();
                    allSemesters.setPK_SEMESTER(res.getInt("PK_SEMESTER"));
                    allSemesters.setFL_NAME_SEMESTER(res.getString("FL_NAME_SEMESTER"));
                    list.add(allSemesters);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(semesterModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public ArrayList<semesterModel> SelectSemesterByTeacherTutor(int pkTeacher, int pkStudyLevel, int pkPeriod){
        ArrayList<semesterModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_CAREER_SEMESTER_GROUP_MATTER_BY_TEACHER`('semesterByTeacherTutor', "+pkTeacher+", "+pkStudyLevel+", null, "+pkPeriod+", null, null, null)"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    semesterModel allSemesters=new semesterModel();
                    allSemesters.setPK_SEMESTER(res.getInt("PK_SEMESTER"));
                    allSemesters.setFL_NAME_SEMESTER(res.getString("FL_NAME_SEMESTER"));
                    list.add(allSemesters);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(semesterModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public ArrayList<semesterModel> SelectSemesterByDirector(int pkTeacher, int pkStudyLevel, int pkPeriod){
        ArrayList<semesterModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_CAREER_SEMESTER_GROUP_MATTER_BY_TEACHER`('semesterByDirector', "+pkTeacher+", "+pkStudyLevel+", null, "+pkPeriod+", null, null, null)"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    semesterModel allSemesters=new semesterModel();
                    allSemesters.setPK_SEMESTER(res.getInt("PK_SEMESTER"));
                    allSemesters.setFL_NAME_SEMESTER(res.getString("FL_NAME_SEMESTER"));
                    list.add(allSemesters);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(semesterModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
}
