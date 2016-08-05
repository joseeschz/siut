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
import model.reportBoxCutDetailModel;

/**
 *
 * @author Lab5-E
 */
public class reportBoxCutDetailControl {
    public static void main(String[] args) {
        reportBoxCutDetailModel model=new reportBoxCutDetailModel();
        ArrayList<reportBoxCutDetailModel> list=new reportBoxCutDetailControl().SelectReportBoxCutDetailBills(1);
        list.stream().forEach((boxCutModel) -> {
            System.out.println(boxCutModel.getFL_CANT());
        });
    }
    private String procedure;
    public ArrayList<reportBoxCutDetailModel> SelectReportBoxCutDetailBills(int fk_boxCut){
        ArrayList<reportBoxCutDetailModel> list=new ArrayList<>();
        procedure = "CALL `GET_BOX_CUT_REPORT`(?, ?, null, null, null)";
        try (Connection conn = new connectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure)) { 
            ps.setString(1, "nominationBills"); 
            ps.setInt(2, fk_boxCut); 
            try (ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    reportBoxCutDetailModel model=new reportBoxCutDetailModel();                    
                    model.setPK_REPORT_BOX_CUT_DETAIL(res.getInt("PK_REPORT_BOX_CUT_DETAIL"));
                    model.setFL_CONCEPT(res.getString("FL_CONCEPT"));
                    model.setFL_CANT(res.getInt("FL_CANT"));
                    model.setFL_TOTAL(res.getString("FL_TOTAL"));
                    list.add(model);
                }
            }
        } catch (SQLException ex) {
            System.err.println(ex);
        }
        return list;
    }
    public String InsertReportBoxCutDetail(reportBoxCutDetailModel dataModel){
        String request;
        procedure = "CALL `SET_BOX_CUT_REPORT_DETAIL`(?, null, ?, ?, ?)";
        try {
            Connection conn=new connectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement(procedure)) {
                ps.setString(1, "insert");
                ps.setInt(2, dataModel.getFK_DENOMINATION());
                ps.setInt(3, dataModel.getFL_CANT());
                ps.setInt(4, dataModel.getFK_REPORT_BOX_CUT());
                ps.executeUpdate();
                request="Inserted";
                ps.close();
                conn.close();
            }
        } catch (SQLException e) {
            request=""+e.getMessage();
            e.getMessage();
        }   
        return request;
    }
    public String UpdateReportBoxCutDetail(reportBoxCutDetailModel dataModel){
        String request;
        procedure = "CALL `SET_BOX_CUT_REPORT_DETAIL`(?, ?, null, ?, null)";
        try {
            Connection conn=new connectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement(procedure)) {
                ps.setString(1, "update");
                ps.setInt(2, dataModel.getPK_REPORT_BOX_CUT_DETAIL());
                ps.setInt(3, dataModel.getFL_CANT());
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
    public String DeleteReportBoxCutDetail(int pkBoxCutDetail){
        String request;
        procedure = "CALL `SET_BOX_CUT_REPORT_DETAIL`(?, ?, null, null, null)";
        try {
            Connection conn=new connectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement(procedure)) {
                ps.setString(1, "delete");
                ps.setInt(2, pkBoxCutDetail);
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
