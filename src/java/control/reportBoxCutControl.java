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
import model.reportBoxCutModel;

/**
 *
 * @author Lab5-E
 */
public class reportBoxCutControl {
    public static void main(String[] args) {
        ArrayList<reportBoxCutModel> list=new reportBoxCutControl().SelectReportBoxCut();
        list.stream().forEach((boxCutModel) -> {
            System.out.print(boxCutModel.getFL_DATE_ROW());
        });
    }
    private String procedure;
    public ArrayList<reportBoxCutModel> SelectReportBoxCut(){
        ArrayList<reportBoxCutModel> list=new ArrayList<>();
        procedure = "CALL `GET_BOX_CUT_REPORT`(?, NULL, NULL, NULL, NULL)";
        try (Connection conn = new connectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure)) { 
            ps.setString(1, "reportRows");           
            try (ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    reportBoxCutModel model=new reportBoxCutModel();                    
                    model.setPK_BOX_CUT(res.getInt("PK_BOX_CUT"));
                    model.setFL_NUMBER(res.getString("FL_NUMBER"));
                    model.setFL_DATE_BEGIN(res.getString("FL_DATE_BEGIN"));
                    model.setFL_DATE_END(res.getString("FL_DATE_END"));
                    model.setFL_DATE_ROW(res.getString("FL_DATE_ROW"));
                    model.setFK_PERIOD(res.getInt("FK_PERIOD"));
                    list.add(model);
                }
            }
        } catch (SQLException ex) {
            System.err.println(ex);
        }
        return list;
    }
    public String CommitFalseBoxCute(int pkBoxCut){
        String request;
        procedure = "CALL `SET_BOX_CUT_REPORT`(?, null, ?, ?, ?)";
        try {
            Connection conn=new connectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement(procedure)) {
                ps.setString(1, "commitBack");
                ps.setInt(2, pkBoxCut);
                ps.executeUpdate();
                request="Commited";
                ps.close();
                conn.close();
            }
        } catch (SQLException e) {
            request=""+e.getMessage();
            e.getMessage();
        }   
        return request;
    }
    public String[] InsertReportBoxCut(reportBoxCutModel dataModel){
        String[] request = new String[2];
        String key = null;
        procedure = "CALL `SET_BOX_CUT_REPORT`(?, null, ?, ?, ?)";
        try {
            Connection conn=new connectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement(procedure)) {
                ps.setString(1, "insert");
                ps.setInt(2, 0);
                ps.setString(3, dataModel.getFL_DATE_BEGIN());
                ps.setString(4, dataModel.getFL_DATE_END());
                ps.setInt(5, dataModel.getFK_PERIOD());
                ps.executeUpdate();
                ResultSet rs = ps.getResultSet(); 
                while (rs.next()) {  
                    key = ""+rs.getString("LAST_INSERT_ID");
                }   
                request[0]="Inserted";
                request[1]=""+key;
                ps.close();
                conn.close();
            }
        } catch (SQLException e) {
            request[0]=""+e;
            request[1]=null;
        }   
        return request;
    }
    public String DeleteReportBoxCut(int pkBoxCut){
        String request;
        procedure = "CALL `SET_BOX_CUT_REPORT`(?, ?, null, null, null)";
        try {
            Connection conn=new connectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement(procedure)) {
                ps.setString(1, "delete");
                ps.setInt(2, pkBoxCut);
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
