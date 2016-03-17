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
import model.subjectMattersModel;


/**
 *
 * @author CARLOS
 */
public class subjectMattersControl {
    public static void main(String[] args) {
        ArrayList<subjectMattersModel> list=new subjectMattersControl().SelectSubjectMattersByTeacher(33, 5, 6, 9, 82);
        for(int i=0;i<list.size();i++){
            System.out.println(list.get(i).getFL_NAME_SUBJECT_MATTER());
        }
    }
    public ArrayList<subjectMattersModel> SelectSubjectMatters(int pkCareer, int pkSemester, int pkGroup, int pkStudyPlan, int pkPeriod){
        ArrayList<subjectMattersModel> list=new ArrayList<>();
        String procedure;
        if(pkGroup==0){
            procedure = "CALL `GET_SUBJECT_MATTERS`('all', "+pkCareer+", "+pkSemester+", null ,"+pkStudyPlan+", null, null)";
        }else{
            procedure = "CALL `GET_SUBJECT_MATTERS`('matterToGroup', "+pkCareer+", "+pkSemester+", "+pkGroup+" ,"+pkStudyPlan+", null, "+pkPeriod+")";
        }        
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    subjectMattersModel listSubjectMatters=new subjectMattersModel();
                    listSubjectMatters.setPK_SUBJECT_MATTER(res.getInt("PK_SUBJECT_MATTER"));
                    listSubjectMatters.setFL_NAME_SUBJECT_MATTER(res.getString("FL_NAME_SUBJECT_MATTER"));
                    listSubjectMatters.setFL_INTEGRADORA(res.getString("FL_INTEGRADORA"));
                    list.add(listSubjectMatters);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(subjectMattersModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<subjectMattersModel> SelectListSubjectMattersByStudents(int pkStudent){
        ArrayList<subjectMattersModel> list=new ArrayList<>();
        String procedure="CALL `GET_SUBJECT_MATTERS`('byStudentPeriodNow', null, null, null, null, "+pkStudent+", null)";        
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    subjectMattersModel listSubjectMatters=new subjectMattersModel();
                    listSubjectMatters.setPK_SUBJECT_MATTER(res.getInt("PK_SUBJECT_MATTER"));
                    listSubjectMatters.setFL_NAME_SUBJECT_MATTER(res.getString("FL_NAME_SUBJECT_MATTER"));
                    listSubjectMatters.setPK_WORKER(res.getInt("PK_WORKER"));
                    list.add(listSubjectMatters);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(subjectMattersModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<subjectMattersModel> SelectSubjectMattersByTeacher(int pkTeacher, int pkCareer, int pkPeriod, int pkSemester, int pkGroup){
        ArrayList<subjectMattersModel> list=new ArrayList<>();
        String procedure;
        if(pkGroup==0){
            procedure="CALL `GET_CAREER_SEMESTER_GROUP_MATTER_BY_TEACHER`('matterByTeacherWithoutGroup', "+pkTeacher+", null, "+pkCareer+", "+pkPeriod+", "+pkSemester+", null, null)";
        }else{
            procedure="CALL `GET_CAREER_SEMESTER_GROUP_MATTER_BY_TEACHER`('matterByTeacher', "+pkTeacher+", null, "+pkCareer+","+pkPeriod+", "+pkSemester+", "+pkGroup+", null)";
        }
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    subjectMattersModel listSubjectMatters=new subjectMattersModel();
                    listSubjectMatters.setPK_SUBJECT_MATTER(res.getInt("PK_SUBJECT_MATTER"));
                    listSubjectMatters.setFL_NAME_SUBJECT_MATTER(res.getString("FL_NAME_SUBJECT_MATTER"));
                    list.add(listSubjectMatters);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(subjectMattersModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    
    public String InsertSubjectMatters(subjectMattersModel dataSubjectMatters){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_SUBJECT_MATTERS`('insert', null, '"+dataSubjectMatters.getFL_NAME_SUBJECT_MATTER()+"', '"+dataSubjectMatters.getFL_INTEGRADORA()+"', '"+dataSubjectMatters.getFK_SEMESTER()+"', '"+dataSubjectMatters.getFK_STUDY_PLAN()+"')")) {
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
    public String DeleteSubjectMatters(int pkSubjectMatters){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_SUBJECT_MATTERS`('delete', '"+pkSubjectMatters+"', null, null, null, null)")) {
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
    public String UpdateSubjectMatters(subjectMattersModel dataSubjectMatters){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_SUBJECT_MATTERS`('update', '"+dataSubjectMatters.getPK_SUBJECT_MATTER()+"', '"+dataSubjectMatters.getFL_NAME_SUBJECT_MATTER()+"', '"+dataSubjectMatters.getFL_INTEGRADORA()+"', '"+dataSubjectMatters.getFK_SEMESTER()+"', '"+dataSubjectMatters.getFK_STUDY_PLAN()+"')")) {
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
