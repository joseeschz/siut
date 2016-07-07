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
import model.tempReportPaymentsGobModel;

/**
 *
 * @author Lab5-E
 */
public class tempReportPaymentsGobControl {
    public static void main(String[] args) {
        new tempReportPaymentsGobControl().DeleteReportPaymentsGob();
        System.out.println(new tempReportPaymentsGobControl().InsertReportPaymentsGobOfFileCSV("C:/temp/Loads-Paymenst/fileToUploadCSV.csv"));
    }
    private String procedure;
    public ArrayList<tempReportPaymentsGobModel> SelectReportPaymentsGob(){
        ArrayList<tempReportPaymentsGobModel> list=new ArrayList<>();
        procedure="CALL `GET_TEMP_REPORT_PAYMENT_GOB`(?)";
        try (Connection conn = new connectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure)) { 
            ps.setString(1, "all");     
            try (ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    tempReportPaymentsGobModel listReportPaymentsGob=new tempReportPaymentsGobModel();
                    listReportPaymentsGob.setPK_TEMP_REPORT_PAYMENTS_GOB(res.getInt("PK_TEMP_REPORT_PAYMENTS_GOB"));
                    listReportPaymentsGob.setFL_BANK(res.getString("FL_BANK"));
                    listReportPaymentsGob.setFL_COMMISSION(res.getString("FL_COMMISSION"));
                    listReportPaymentsGob.setFL_DATE_LOADED(res.getString("FL_DATE_LOADED"));
                    listReportPaymentsGob.setFL_DATE_PAYMENT(res.getString("FL_DATE_PAYMENT"));
                    listReportPaymentsGob.setFL_DAY_TERM(res.getString("FL_DAY_TERM"));
                    listReportPaymentsGob.setFL_FORM_TO_PAY(res.getString("FL_FORM_TO_PAY"));
                    listReportPaymentsGob.setFL_IMPORT(res.getString("FL_IMPORT"));
                    listReportPaymentsGob.setFL_ORGANISM(res.getString("FL_ORGANISM"));
                    listReportPaymentsGob.setFL_PAYMENT_METHOD(res.getString("FL_PAYMENT_METHOD"));
                    listReportPaymentsGob.setFL_REFERENCE(res.getString("FL_REFERENCE"));
                    listReportPaymentsGob.setFL_STATUS_LOAD(res.getString("FL_STATUS_LOAD"));
                    listReportPaymentsGob.setFL_SUBTOTAL(res.getString("FL_SUBTOTAL"));
                    list.add(listReportPaymentsGob);
                }
            }
        } catch (SQLException ex) {
            System.err.println(ex);
        }
        return list;
    }
    public String InsertReportPaymentsGobOfFileCSV(String file){
        String request;
        DeleteReportPaymentsGob();
        String query="LOAD DATA LOW_PRIORITY LOCAL INFILE '"+file+"' REPLACE INTO TABLE tb_temp_report_payments_gob CHARACTER SET latin2 FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' ESCAPED BY '\"' LINES TERMINATED BY '\\r\\n' IGNORE 1 LINES (FL_ORGANISM, FL_STATUS_LOAD, FL_REFERENCE, FL_IMPORT, FL_DATE_PAYMENT, FL_DATE_LOADED, FL_BANK, FL_PAYMENT_METHOD, FL_FORM_TO_PAY, FL_DAY_TERM, FL_COMMISSION, FL_SUBTOTAL);";
        try {
            Connection conn=new connectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ps.executeUpdate();
                request="Inserted";
                ps.close();
                conn.close();
                UpdateReportPaymentsGob();
            }
        } catch (SQLException e) {
            request=""+e.getMessage();
            e.getMessage();
        }   
        return request;
    }
    public String InsertReportPaymentsGob(tempReportPaymentsGobModel dataReportPaymentsGob){
        String request;
        procedure="";
        try {
            Connection conn=new connectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement(procedure)) {
                ps.setString(1, "insert");
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
    public String DeleteReportPaymentsGob(){
        String request;
        procedure="CALL `SET_TEMP_REPORT_PAYMENT_GOB`('delete')";
        try {
            Connection conn=new connectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement(procedure)) {
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
    public String UpdateReportPaymentsGob(){
        String request;
        procedure="CALL `SET_TEMP_REPORT_PAYMENT_GOB`(?)";
        try {
            Connection conn=new connectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement(procedure)) {
                ps.setString(1, "update");
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
}
