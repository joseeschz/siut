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
import model.studyLevelModel;


/**
 *
 * @author CARLOS
 */
public class studyLevelControl {
    public static void main(String[] args) {
        ArrayList<studyLevelModel> list=new studyLevelControl().SelectStudyLevel("byStatus");
        for(int i=0;i<list.size();i++){
            System.out.println(list.get(i).getFL_NAME_LEVEL());
        }
    }
    public ArrayList<studyLevelModel> SelectStudyLevel(String condition){
        ArrayList<studyLevelModel> list=new ArrayList<>();
        try {
            String procedure="CALL `GET_LEVEL_STUDY`('"+condition+"')";
            try (Connection conn = new connectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    studyLevelModel listStudyLevel=new studyLevelModel();
                    listStudyLevel.setPK_LEVEL_STUDY(res.getInt("PK_LEVEL_STUDY"));
                    listStudyLevel.setFL_NAME_LEVEL(res.getString("FL_NAME_LEVEL"));
                    listStudyLevel.setFL_STATUS(res.getString("FL_STATUS"));
                    list.add(listStudyLevel);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        }catch (SQLException ex) {
            Logger.getLogger(studyLevelModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public ArrayList<studyLevelModel> SelectStudyLevelByTeacher(int pkTeacher){
        ArrayList<studyLevelModel> list=new ArrayList<>();
        try {
            String procedure="CALL `GET_CAREER_SEMESTER_GROUP_MATTER_BY_TEACHER`('studyLevelByTeacher', "+pkTeacher+", null, null, null, null, null, null)";
            try (Connection conn = new connectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    studyLevelModel listStudyLevel=new studyLevelModel();
                    listStudyLevel.setPK_LEVEL_STUDY(res.getInt("PK_LEVEL_STUDY"));
                    listStudyLevel.setFL_NAME_LEVEL(res.getString("FL_NAME_LEVEL"));
                    listStudyLevel.setFL_STATUS(res.getString("FL_STATUS"));
                    list.add(listStudyLevel);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        }catch (SQLException ex) {
            Logger.getLogger(studyLevelModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public ArrayList<studyLevelModel> SelectStudyLevelByDirector(int pkDirector){
        ArrayList<studyLevelModel> list=new ArrayList<>();
        try {
            String procedure="CALL `GET_CAREER_SEMESTER_GROUP_MATTER_BY_TEACHER`('studyLevelByDirector', "+pkDirector+", null, null, null, null, null, null)";
            try (Connection conn = new connectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    studyLevelModel listStudyLevel=new studyLevelModel();
                    listStudyLevel.setPK_LEVEL_STUDY(res.getInt("PK_LEVEL_STUDY"));
                    listStudyLevel.setFL_NAME_LEVEL(res.getString("FL_NAME_LEVEL"));
                    listStudyLevel.setFL_STATUS(res.getString("FL_STATUS"));
                    list.add(listStudyLevel);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        }catch (SQLException ex) {
            Logger.getLogger(studyLevelModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public ArrayList<studyLevelModel> SelectStudyLevelByTeacherTutor(int pkTeacher){
        ArrayList<studyLevelModel> list=new ArrayList<>();
        try {
            String procedure="CALL `GET_CAREER_SEMESTER_GROUP_MATTER_BY_TEACHER`('studyLevelByTeacherTutor', "+pkTeacher+", null, null, null, null, null, null)";
            try (Connection conn = new connectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    studyLevelModel listStudyLevel=new studyLevelModel();
                    listStudyLevel.setPK_LEVEL_STUDY(res.getInt("PK_LEVEL_STUDY"));
                    listStudyLevel.setFL_NAME_LEVEL(res.getString("FL_NAME_LEVEL"));
                    listStudyLevel.setFL_STATUS(res.getString("FL_STATUS"));
                    list.add(listStudyLevel);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        }catch (SQLException ex) {
            Logger.getLogger(studyLevelModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public String InsertStudyLevel(studyLevelModel dataStudyLevel){
        String request;
        try {
            Connection conn=new connectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_STUDY_LEVEL`('insert', null, '"+dataStudyLevel.getFL_NAME_LEVEL()+"', '"+dataStudyLevel.getFL_STATUS()+"')")) {
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
    public String DeleteStudyLevel(int pkStudyLevel){
        String request;
        try {
            Connection conn=new connectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_STUDY_LEVEL`('delete', '"+pkStudyLevel+"', null, null)")) {
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
    public String UpdateStudyLevel(studyLevelModel dataStudyLevel){
        String request;
        try {
            Connection conn=new connectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_STUDY_LEVEL`('update', '"+dataStudyLevel.getPK_LEVEL_STUDY()+"', '"+dataStudyLevel.getFL_NAME_LEVEL()+"', '"+dataStudyLevel.getFL_STATUS()+"')")) {
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
