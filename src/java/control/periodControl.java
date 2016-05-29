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
import model.periodModel;

/**
 *
 * @author CARLOS
 */
public class periodControl {
    public static void main(String[] args) {
        ArrayList<periodModel> list=new periodControl().SelectAllPeriods("allBySchoolYear", 16);
        for(int i=0;i<list.size();i++){
            System.out.println(list.get(i).getFL_NAME());
        }
    }
    public ArrayList<periodModel> SelectAllPeriods(String condition, int pt_fk_school_year){
        ArrayList<periodModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_PERIOD`('"+condition+"', '"+pt_fk_school_year+"')"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    periodModel listPeriod=new periodModel();
                    listPeriod.setPK_PERIOD(res.getInt("PK_PERIOD"));
                    listPeriod.setFL_UNIQUE(res.getString("FL_UNIQUE"));
                    listPeriod.setFL_NAME(res.getString("FL_NAME"));
                    listPeriod.setFL_NAME_ABBREVIATED(res.getString("FL_NAME_ABBREVIATED"));
                    listPeriod.setFL_ACTIVE(res.getString("FL_ACTIVE"));
                    listPeriod.setFL_YEAR_ACTIVE(res.getString("FL_YEAR_ACTIVE"));
                    listPeriod.setFL_YEAR(res.getString("FL_YEAR"));
                    listPeriod.setFL_PERIOD_TYPE(res.getInt("FL_PERIOD_TYPE"));
                    listPeriod.setFK_SCHOOL_YEAR(res.getInt("FK_SCHOOL_YEAR"));
                    list.add(listPeriod);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(periodModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    
    public ArrayList<periodModel> SelectPeriod(String condition){
        ArrayList<periodModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_PERIOD`('"+condition+"', null)"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    periodModel listPeriod=new periodModel();
                    listPeriod.setPK_PERIOD(res.getInt("PK_PERIOD"));
                    listPeriod.setFL_ACTIVE(res.getString("FL_ACTIVE"));
                    listPeriod.setFL_NAME(res.getString("FL_NAME"));
                    listPeriod.setFL_NAME_ABBREVIATED(res.getString("FL_NAME_ABBREVIATED"));
                    listPeriod.setFL_YEAR_ACTIVE(res.getString("FL_YEAR_ACTIVE"));
                    list.add(listPeriod);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(periodModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<periodModel> SelectPeriodByStudentsAdjustmentCalifications(int pkStudent, int fkSemester){
        ArrayList<periodModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_PERIOD_BY_STUDENT_CALIFICATIONS`("+pkStudent+", "+fkSemester+")"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    periodModel listPeriod=new periodModel();
                    listPeriod.setPK_PERIOD(res.getInt("PK_PERIOD"));
                    listPeriod.setFL_ACTIVE(res.getString("FL_ACTIVE"));
                    listPeriod.setFL_NAME(res.getString("FL_NAME"));
                    listPeriod.setFL_NAME_ABBREVIATED(res.getString("FL_NAME_ABBREVIATED"));
                    listPeriod.setFL_YEAR_ACTIVE(res.getString("FL_YEAR_ACTIVE"));
                    list.add(listPeriod);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(periodModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<periodModel> SelectPeriodByTeacher(int pkTeacher, int pkCareer, int pkSemester, int pkMatter, int pkTypeEval){
        ArrayList<periodModel> list=new ArrayList<>();
        String procedure = "CALL `GET_PERIOD_BY_TEACHER`('periodByTeacherByMatterHistory', "+pkTeacher+", "+pkCareer+", "+pkSemester+", "+pkMatter+", "+pkTypeEval+")";
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    periodModel listPeriod=new periodModel();
                    listPeriod.setPK_PERIOD(res.getInt("PK_PERIOD"));
                    listPeriod.setFL_ACTIVE(res.getString("FL_ACTIVE"));
                    listPeriod.setFL_NAME(res.getString("FL_NAME"));
                    listPeriod.setFL_NAME_ABBREVIATED(res.getString("FL_NAME_ABBREVIATED"));
                    listPeriod.setFL_YEAR_ACTIVE(res.getString("FL_YEAR_ACTIVE"));
                    list.add(listPeriod);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(periodModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public int SelectPeriodActive(String command){
        int period_active = 0;
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_PERIOD`('"+command+"', null)"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    period_active = (res.getInt("PK_PERIOD"));
                }
                res.close();
                ps.close();
                conn.close();
            }
            return period_active;
        } catch (SQLException ex) {
            Logger.getLogger(periodModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return period_active;
    }
    public String InsertPeriod(periodModel dataPeriod){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_PERIOD`('insert', null, null, null, null, null, '"+dataPeriod.getFL_YEAR()+"', "+dataPeriod.getFL_PERIOD_TYPE()+", "+dataPeriod.getFK_SCHOOL_YEAR()+")")) {
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
    public String DeletePeriod(int pkPeriod){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_PERIOD`('delete', "+pkPeriod+", null, null, null, null, null, null, null)")) {
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
    public String UpdatePeriod(periodModel dataPeriod){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_PERIOD`('update', "+dataPeriod.getPK_PERIOD()+", null, null, null, null, null, null, null)")) {
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
