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
        ArrayList<subjectMattersModel> list=new subjectMattersControl().SelectSubjectMattersMissingWorkingPlanning(6, 14);
        for(int i=0;i<list.size();i++){
            System.out.println(list.get(i).getFL_NAME_SUBJECT_MATTER());
        }
    }
    public ArrayList<subjectMattersModel> SelectSubjectMattersMissingClose(int pkCareer, int pkPeriod){
        ArrayList<subjectMattersModel> list=new ArrayList<>();
        String procedure;
        procedure = "CALL `GET_PROGRESS_WORK_REPORT`('missingClose',"+pkCareer+", "+pkPeriod+")";
        try {
            try (Connection conn = new connectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    subjectMattersModel listSubjectMatters=new subjectMattersModel();
                    listSubjectMatters.setPK_SUBJECT_MATTER(res.getInt("PK_SUBJECT_MATTER"));
                    listSubjectMatters.setFL_NAME_SUBJECT_MATTER(res.getString("FL_NAME_SUBJECT_MATTER"));
                    listSubjectMatters.setFL_NAME_WORKER(res.getString("FL_NAME_WORKER"));
                    listSubjectMatters.setPK_WORKER(res.getInt("PK_WORKER"));
                    listSubjectMatters.setFK_SEMESTER(res.getInt("PK_SEMESTER"));
                    listSubjectMatters.setFL_ACTIVITIES_BE(res.getString("FL_ACTIVITIES_BE"));
                    listSubjectMatters.setFL_ACTIVITIES_KNOW(res.getString("FL_ACTIVITIES_KNOW"));
                    listSubjectMatters.setFL_ACTIVITIES_DO(res.getString("FL_ACTIVITIES_DO"));
                    listSubjectMatters.setFL_CLOSED_BE(res.getString("FL_CLOSED_BE"));
                    listSubjectMatters.setFL_CLOSED_KNOW(res.getString("FL_CLOSED_KNOW"));
                    listSubjectMatters.setFL_CLOSED_DO(res.getString("FL_CLOSED_DO"));
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
    public ArrayList<subjectMattersModel> SelectSubjectMattersMissingWorkingPlanning(int pkCareer, int pkPeriod){
        ArrayList<subjectMattersModel> list=new ArrayList<>();
        String procedure;
        procedure = "CALL `GET_PROGRESS_WORK_REPORT`('missingAll',"+pkCareer+", "+pkPeriod+")";
        try {
            try (Connection conn = new connectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    subjectMattersModel listSubjectMatters=new subjectMattersModel();
                    listSubjectMatters.setPK_SUBJECT_MATTER(res.getInt("PK_SUBJECT_MATTER"));
                    listSubjectMatters.setFL_NAME_SUBJECT_MATTER(res.getString("FL_NAME_SUBJECT_MATTER"));
                    listSubjectMatters.setFL_NAME_WORKER(res.getString("FL_NAME_WORKER"));
                    listSubjectMatters.setPK_WORKER(res.getInt("PK_WORKER"));
                    listSubjectMatters.setFK_SEMESTER(res.getInt("PK_SEMESTER"));
                    listSubjectMatters.setFL_NAME_SEMESTER(res.getString("FL_NAME_SEMESTER"));
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
    public ArrayList<subjectMattersModel> SelectSubjectMattersByCurrentSemester(int pkCareer, int pkSemester, int pkStudyPlan, int pkPeriod){
        ArrayList<subjectMattersModel> list=new ArrayList<>();
        String procedure;
        procedure = "CALL `GET_SUBJECT_MATTERS`('subjectMattersByCurrentSemester', "+pkCareer+", "+pkSemester+", null , "+pkStudyPlan+", null, "+pkPeriod+")";
        try {
            try (Connection conn = new connectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    subjectMattersModel listSubjectMatters=new subjectMattersModel();
                    listSubjectMatters.setPK_SUBJECT_MATTER(res.getInt("PK_SUBJECT_MATTER"));
                    listSubjectMatters.setPK_WORKER(res.getInt("PK_WORKER"));
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
    public ArrayList<subjectMattersModel> SelectSubjectMatters(int pkCareer, int pkSemester, int pkGroup, int pkStudyPlan, int pkPeriod){
        ArrayList<subjectMattersModel> list=new ArrayList<>();
        String procedure;
        if(pkGroup==0){
            procedure = "CALL `GET_SUBJECT_MATTERS`('all', "+pkCareer+", "+pkSemester+", null ,"+pkStudyPlan+", null, null)";
        }else{
            procedure = "CALL `GET_SUBJECT_MATTERS`('matterToGroup', "+pkCareer+", "+pkSemester+", "+pkGroup+" ,"+pkStudyPlan+", null, "+pkPeriod+")";
        }        
        try {
            try (Connection conn = new connectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    subjectMattersModel listSubjectMatters=new subjectMattersModel();
                    listSubjectMatters.setPK_SUBJECT_MATTER(res.getInt("PK_SUBJECT_MATTER"));
                    listSubjectMatters.setFL_NAME_SUBJECT_MATTER(res.getString("FL_NAME_SUBJECT_MATTER"));
                    listSubjectMatters.setFL_INTEGRADORA(res.getString("FL_INTEGRADORA"));
                    listSubjectMatters.setFL_CANT_HOURS(res.getInt("FL_CANT_HOURS"));
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
    public ArrayList<subjectMattersModel> SelectSubjectMattersByGroup(int pkCareer, int pkSemester, int pkGroup, int pkPeriod){
        ArrayList<subjectMattersModel> list=new ArrayList<>();
        String procedure;
        procedure = "CALL `GET_SUBJECT_MATTERS`('mattersByGroup', "+pkCareer+", "+pkSemester+", "+pkGroup+" , null, null, "+pkPeriod+")";
        try {
            try (Connection conn = new connectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
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
            try (Connection conn = new connectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    subjectMattersModel listSubjectMatters=new subjectMattersModel();
                    listSubjectMatters.setPK_SUBJECT_MATTER(res.getInt("PK_SUBJECT_MATTER"));
                    listSubjectMatters.setFL_NAME_SUBJECT_MATTER(res.getString("FL_NAME_SUBJECT_MATTER"));
                    listSubjectMatters.setFL_NAME_WORKER(res.getString("FL_NAME_WORKER"));
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
            try (Connection conn = new connectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
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
            Connection conn=new connectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_SUBJECT_MATTERS`('insert', null, '"+dataSubjectMatters.getFL_NAME_SUBJECT_MATTER()+"', '"+dataSubjectMatters.getFL_INTEGRADORA()+"', '"+dataSubjectMatters.getFL_CANT_HOURS()+"', '"+dataSubjectMatters.getFK_SEMESTER()+"', '"+dataSubjectMatters.getFK_STUDY_PLAN()+"')")) {
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
            Connection conn=new connectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_SUBJECT_MATTERS`('delete', '"+pkSubjectMatters+"', null, null, null, null, null)")) {
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
            Connection conn=new connectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_SUBJECT_MATTERS`('update', '"+dataSubjectMatters.getPK_SUBJECT_MATTER()+"', '"+dataSubjectMatters.getFL_NAME_SUBJECT_MATTER()+"', '"+dataSubjectMatters.getFL_INTEGRADORA()+"', '"+dataSubjectMatters.getFL_CANT_HOURS()+"', '"+dataSubjectMatters.getFK_SEMESTER()+"', '"+dataSubjectMatters.getFK_STUDY_PLAN()+"')")) {
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
