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
import model.categoryPaymentsModel;
import model.paymentsPenaltyTypesModel;
import model.periodModel;
import model.semesterModel;
import model.studyLevelModel;

/**
 *
 * @author Lab5-E
 */
public class paymentsPenaltyTypesControl {
    public static void main(String[] args) {
        paymentsPenaltyTypesModel allPaymentsPenaltyType=new paymentsPenaltyTypesModel();
        categoryPaymentsModel categoryModel = new categoryPaymentsModel();

        allPaymentsPenaltyType.setFL_NAME_PENALTY("pt_name_penalty");
        allPaymentsPenaltyType.setFL_TARIFF("pt_tariff");
        allPaymentsPenaltyType.setFK_TYPE_FORMAT(0);

        categoryModel.setPK_CATEGORY_PAYMENT(1);
        allPaymentsPenaltyType.setCategory(categoryModel);
        System.out.print(new paymentsPenaltyTypesControl().InsertPaymentsPenaltyTypeServices(allPaymentsPenaltyType));
    }
    private String procedure;
    public ArrayList<paymentsPenaltyTypesModel> SelectPaymentsPenaltyType(int pk){
        procedure = "";

        ArrayList<paymentsPenaltyTypesModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(paymentsPenaltyTypesModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<paymentsPenaltyTypesModel> SelectPaymentsPenaltyTypes(int pt_fk_level_study, int pt_fk_semester, int pt_fk_category_payment, int pt_fk_type_concept, int pt_fk_type_format, int pt_fk_period){
        ArrayList<paymentsPenaltyTypesModel> list=new ArrayList<>();
        procedure = "CALL `GET_PAYMENTS_PENALITY_TYPE`(?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure)) { 
            ps.setString(1, "all");
            ps.setInt(2, 0);
            ps.setInt(3, pt_fk_level_study);
            ps.setInt(4, pt_fk_semester);
            ps.setInt(5, pt_fk_category_payment);
            ps.setInt(6, pt_fk_type_concept);   
            ps.setInt(7, pt_fk_type_format);   
            ps.setInt(8, pt_fk_period);            
            try (ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    paymentsPenaltyTypesModel allPaymentsPenaltyType=new paymentsPenaltyTypesModel();
                    studyLevelModel studyLevelModel =  new studyLevelModel();
                    semesterModel semesterModel =  new semesterModel();
                    categoryPaymentsModel categoryModel = new categoryPaymentsModel();
                    periodModel periodModel =  new periodModel();
                    
                    allPaymentsPenaltyType.setPK_PAYMENT_PENALTY_TYPE(res.getInt("PK_PAYMENT_PENALTY_TYPE"));
                    allPaymentsPenaltyType.setFL_NAME_PENALTY(res.getString("FL_NAME_PENALTY"));
                    allPaymentsPenaltyType.setFL_TARIFF(res.getString("FL_TARIFF"));
                    studyLevelModel.setPK_LEVEL_STUDY(res.getInt("PK_LEVEL_STUDY"));
                    allPaymentsPenaltyType.setStudyLevel(studyLevelModel);
                    
                    semesterModel.setPK_SEMESTER(res.getInt("PK_SEMESTER"));
                    allPaymentsPenaltyType.setSemester(semesterModel);
                    
                    categoryModel.setPK_CATEGORY_PAYMENT(res.getInt("PK_CATEGORY_PAYMENT"));
                    allPaymentsPenaltyType.setCategory(categoryModel);
                    periodModel.setPK_PERIOD(res.getInt("PK_PERIOD"));
                    allPaymentsPenaltyType.setPeriod(periodModel);
                    list.add(allPaymentsPenaltyType);
                }
            }
        } catch (SQLException ex) {
            System.err.println(ex);
        }
        return list;
    }
    public String InsertPaymentsPenaltyType(paymentsPenaltyTypesModel dataPaymentsPenaltyType){
        String request;
        procedure = "CALL `SET_PAYMENTS_PENALITY_TYPE`(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement(procedure)) {
                ps.setString(1, "insert");
                ps.setInt(2, 0);
                ps.setString(3, dataPaymentsPenaltyType.getFL_NAME_PENALTY());
                ps.setString(4, dataPaymentsPenaltyType.getFL_TARIFF());
                ps.setInt(5, dataPaymentsPenaltyType.getStudyLevel().getPK_LEVEL_STUDY());
                ps.setInt(6, dataPaymentsPenaltyType.getSemester().getPK_SEMESTER());
                ps.setInt(7, dataPaymentsPenaltyType.getCategory().getPK_CATEGORY_PAYMENT());
                ps.setInt(8, dataPaymentsPenaltyType.getFK_TYPE_CONCEPT());
                 ps.setInt(9, dataPaymentsPenaltyType.getFK_TYPE_FORMAT());
                ps.setInt(10, dataPaymentsPenaltyType.getPeriod().getPK_PERIOD());
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
    public String InsertPaymentsPenaltyTypeServices(paymentsPenaltyTypesModel dataPaymentsPenaltyType){
        String request;
        procedure = "CALL `SET_PAYMENTS_PENALITY_TYPE`(?, ?, ?, ?, null, null, ?, ?, ?, ?)";
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement(procedure)) {
                ps.setString(1, "insert");
                ps.setInt(2, 0);
                ps.setString(3, dataPaymentsPenaltyType.getFL_NAME_PENALTY());
                ps.setString(4, dataPaymentsPenaltyType.getFL_TARIFF());
                ps.setInt(5, dataPaymentsPenaltyType.getCategory().getPK_CATEGORY_PAYMENT());
                ps.setInt(6, dataPaymentsPenaltyType.getFK_TYPE_CONCEPT());
                ps.setInt(7, dataPaymentsPenaltyType.getFK_TYPE_FORMAT());
                ps.setInt(8, dataPaymentsPenaltyType.getPeriod().getPK_PERIOD());
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
    public String UpdatePaymentsPenaltyType(paymentsPenaltyTypesModel dataPaymentsPenaltyType){
        String request;
        procedure = "CALL `SET_PAYMENTS_PENALITY_TYPE`(?, ?, ?, ?, null, null, null, null, null, null)";
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement(procedure)) {
                ps.setString(1, "update");
                ps.setInt(2, dataPaymentsPenaltyType.getPK_PAYMENT_PENALTY_TYPE());
                ps.setString(3, dataPaymentsPenaltyType.getFL_NAME_PENALTY());
                ps.setDouble(4, Double.parseDouble(dataPaymentsPenaltyType.getFL_TARIFF()));
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
    public String DeletePaymentsPenaltyType(int pkPaymentsPenaltyType){
        String request;
        procedure = "CALL `SET_PAYMENTS_PENALITY_TYPE`(?, ?, null, null, null, null, null, null, null, null)";
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement(procedure)) {
                ps.setString(1, "delete");
                ps.setInt(2, pkPaymentsPenaltyType);
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
