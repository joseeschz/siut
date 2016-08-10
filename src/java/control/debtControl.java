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
import model.careerModel;
import model.debtDetailModel;
import model.studentModel;
import model.debtModel;
import model.periodModel;
import model.studyLevelModel;

/**
 *
 * @author Lab5-E
 */
public class debtControl {
    public static void main(String[] args) {
        ArrayList<debtDetailModel> list = new debtControl().SelectDebtsDetail(4097);
        int i=0;
        for (debtDetailModel detailModel : list) {
            System.out.print(detailModel.getFL_MOTIVE());
        }
    }
    private String procedure;
    public ArrayList<debtModel> SelectDebts(){
        ArrayList<debtModel> list=new ArrayList<>();
        procedure = "CALL `GET_DEBT`(?, null)";
        try (Connection conn = new connectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure)) { 
            ps.setString(1, "debtsHeader");         
            try (ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){                    
                    debtModel debtMdl=new debtModel();
                    studentModel studentMdl = new studentModel();
                    careerModel careerMdl = new careerModel();
                    studyLevelModel studyLevelMdl = new studyLevelModel();
                    debtMdl.setPK_DEBT(res.getInt("PK_DEBT"));
                    studentMdl.setPK_STUDENT(res.getInt("PK_STUDENT"));
                    studentMdl.setFL_ENROLLMENT(res.getString("FL_ENROLLMENT"));
                    studentMdl.setFL_NAME(res.getString("FL_NAME"));
                    careerMdl.setFL_NAME_CAREER(res.getString("FL_NAME_CAREER"));
                    studyLevelMdl.setFL_NAME_LEVEL(res.getString("FL_NAME_LEVEL"));                    
                    debtMdl.setStudentMdl(studentMdl);
                    debtMdl.setCareerMdl(careerMdl);
                    debtMdl.setStudyLevelMdl(studyLevelMdl);
                    list.add(debtMdl);
                }
            }
        } catch (SQLException ex) {
            System.err.println(ex);
        }
        return list;
    }
    
    public ArrayList<debtDetailModel> SelectDebtsDetail(int pt_fk_debt){
        ArrayList<debtDetailModel> list=new ArrayList<>();
        procedure = "CALL `GET_DEBT`(?, ?)";
        try (Connection conn = new connectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure)) { 
            ps.setString(1, "debtDetail");         
            ps.setInt(2, pt_fk_debt);     
            try (ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){   
                    debtDetailModel debtDetailMdl =new debtDetailModel();
                    debtModel debtMdl=new debtModel();
                    studentModel studentMdl = new studentModel();
                    periodModel periodMdl = new periodModel();
                    debtDetailMdl.setPK_DEBT_DETAIL(res.getInt("PK_DEBT_DETAIL"));
                    studentMdl.setPK_STUDENT(res.getInt("FK_STUDENT"));
                    debtDetailMdl.setFL_ROW_DATE(res.getString("FL_ROW_DATE"));
                    debtDetailMdl.setFL_MOUNT(res.getString("FL_MOUNT"));
                    debtMdl.setPK_DEBT(res.getInt("FK_DEBT"));
                    debtDetailMdl.setFL_MOTIVE(res.getString("FL_MOTIVE"));
                    periodMdl.setPK_PERIOD(res.getInt("PK_PERIOD"));
                    periodMdl.setFL_NAME(res.getString("FL_NAME"));
                    debtDetailMdl.setFL_STATUS_NOW_DEBT(res.getString("FL_STATUS_NOW_DEBT"));  
                    
                    debtDetailMdl.setDebtMdl(debtMdl);
                    debtDetailMdl.setStudentMdl(studentMdl);
                    debtDetailMdl.setPeriodMdl(periodMdl);
                    list.add(debtDetailMdl);
                }
            }
        } catch (SQLException ex) {
            System.err.println(ex);
        }
        return list;
    }
    
    public String InsertDebt(debtDetailModel debtDetailMdl){
        String request;
        procedure = "CALL `SET_DEBT`(?, null, ?, ?, ?, ?, ?)";
        PreparedStatement ps;
        Connection conn=new connectionControl().getConexion();
        try {
            ps = conn.prepareStatement(procedure);
            ps.setString(1, "insert");
            ps.setInt(2, debtDetailMdl.getStudentMdl().getPK_STUDENT());
            ps.setString(3, debtDetailMdl.getFL_MOUNT());
            ps.setString(4, debtDetailMdl.getFL_MOTIVE());
            ps.setInt(5, debtDetailMdl.getPeriodMdl().getPK_PERIOD());
            ps.setString(6, debtDetailMdl.getFL_STATUS_NOW_DEBT());
            ps.executeUpdate();
            request="Inserted";
            ps.close();
            conn.close();
            
        } catch (SQLException e) {
            request=""+e;
        }   
        return request;
    }
    public String UpdateDebt(debtDetailModel debtDetailMdl){
        String request;
        procedure = "CALL `SET_DEBT`(?, ?, ?, ?, ?, ?, ?)";
        try {
            Connection conn=new connectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement(procedure)) {
                ps.setString(1, "update");
                ps.setInt(2, debtDetailMdl.getPK_DEBT_DETAIL());
                ps.setInt(3, debtDetailMdl.getStudentMdl().getPK_STUDENT());
                ps.setString(4, debtDetailMdl.getFL_MOUNT());
                ps.setString(5, debtDetailMdl.getFL_MOTIVE());
                ps.setInt(6, debtDetailMdl.getPeriodMdl().getPK_PERIOD());
                ps.setString(7, debtDetailMdl.getFL_STATUS_NOW_DEBT());
                ps.executeUpdate();
                request="Updated";
                ps.close();
                conn.close();
            }
        } catch (SQLException e) {
            request=""+e.getMessage();
            e.getMessage();
        }   
        return request;
    }
    public String DeleteDebt(int pkDebt){
        String request;
        procedure = "CALL `SET_DEBT`(?, ?, null, null, null, null, null)";
        try {
            Connection conn=new connectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement(procedure)) {
                ps.setString(1, "delete");
                ps.setInt(2, pkDebt);
                ps.executeUpdate();
                request="Deleted";
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
