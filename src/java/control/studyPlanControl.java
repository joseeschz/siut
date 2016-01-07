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
import model.studyPlanModel;


/**
 *
 * @author CARLOS
 */
public class studyPlanControl {
    public static void main(String[] args) {
        ArrayList<studyPlanModel> list=new studyPlanControl().SelectStudyPlan(1);
        for(int i=0;i<list.size();i++){
            System.out.println(list.get(i).getFL_NAME_PLAN());
        }
    }
    public ArrayList<studyPlanModel> SelectStudyPlan(int fkCareer){
        ArrayList<studyPlanModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_STUDY_PLANS`('byCareer', '"+fkCareer+"')"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    studyPlanModel listStudyPlan=new studyPlanModel();
                    listStudyPlan.setPK_STUDY_PLAN(res.getInt("PK_STUDY_PLAN"));
                    listStudyPlan.setFL_NAME_PLAN(res.getString("FL_NAME_PLAN"));
                    list.add(listStudyPlan);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(studyPlanModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public String InsertStudyPlan(studyPlanModel dataStudyPlan){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_STUDY_PLANS`('insert', null, '"+dataStudyPlan.getFL_NAME_PLAN()+"', '"+dataStudyPlan.getFK_CAREER()+"')")) {
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
    public String DeleteStudyPlan(int pkStudyPlan){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_STUDY_PLANS`('delete', '"+pkStudyPlan+"', null, null)")) {
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
    public String UpdateStudyPlan(studyPlanModel dataStudyPlan){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_STUDY_PLANS`('update', '"+dataStudyPlan.getPK_STUDY_PLAN()+"', '"+dataStudyPlan.getFL_NAME_PLAN()+"', '"+dataStudyPlan.getFK_CAREER()+"')")) {
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
