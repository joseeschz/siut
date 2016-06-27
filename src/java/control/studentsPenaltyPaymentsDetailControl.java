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
import model.categoryPaymentsModel;
import model.paymentsPenaltyTypesModel;
import model.periodModel;
import model.semesterModel;
import model.studentModel;
import model.studentsPenaltyPaymentsDetailModel;
import model.studentsPenaltyPaymentsModel;
import model.typeConceptModel;
import model.typeFormatModel;
/**
 *
 * @author Lab5-E
 */
public class studentsPenaltyPaymentsDetailControl {
    public static void main(String[] args) {
        ArrayList<studentsPenaltyPaymentsDetailModel> listStudentsPenalityPaymentsDetail;
        listStudentsPenalityPaymentsDetail = new studentsPenaltyPaymentsDetailControl().SelectStudentsAllStatusPaymentDetail(0, 0, 0, 0);
        for(int i=0;i<listStudentsPenalityPaymentsDetail.size();i++){
            System.out.println(listStudentsPenalityPaymentsDetail.get(i).getFL_REFERENCE_NUMBER());
        }
    }
    private String procedure;
    public ArrayList<studentsPenaltyPaymentsDetailModel> SelectStudentsAllStatusPaymentDetailByHeader(int pt_pk_student_payment_penality_header){
        ArrayList<studentsPenaltyPaymentsDetailModel> list=new ArrayList<>();
        procedure = "CALL `GET_STUDENT_PENALTY_PAYMENTS_DETAIL`(?, ?, null, null, null, null, null, null)";
        try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure)) { 
            ps.setString(1, "allByHeader");
            ps.setInt(2, pt_pk_student_payment_penality_header);      
            try (ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    studentsPenaltyPaymentsDetailModel allStudentsPenaltyPaymentDetail=new studentsPenaltyPaymentsDetailModel();
                    studentModel student= new studentModel();
                    semesterModel semester = new semesterModel();
                    periodModel period = new periodModel();
                    studentsPenaltyPaymentsModel studentPenalityPayment = new studentsPenaltyPaymentsModel();
                    paymentsPenaltyTypesModel paymentTypes = new paymentsPenaltyTypesModel();
                    categoryPaymentsModel category =  new categoryPaymentsModel();
                    typeConceptModel typeConcept = new typeConceptModel();
                    typeFormatModel typeFormat = new typeFormatModel();
                    
                    allStudentsPenaltyPaymentDetail.setPK_STUDENT_PENALTY_PAYMENT_DETAIL(res.getInt("PK_STUDENT_PENALTY_PAYMENT_DETAIL"));
                    allStudentsPenaltyPaymentDetail.setFL_AMOUNT_PENALITY(res.getString("FL_AMOUNT_PENALITY"));
                    allStudentsPenaltyPaymentDetail.setFL_REFERENCE_NUMBER(res.getString("FL_REFERENCE_NUMBER"));
                    allStudentsPenaltyPaymentDetail.setFL_UNIQUE(res.getString("FL_UNIQUE"));
                    allStudentsPenaltyPaymentDetail.setFL_STATUS_PAY(res.getString("FL_STATUS_PAY"));
                    
                    typeConcept.setPK_TYPE_CONCEPT(res.getInt("PK_TYPE_CONCEPT"));
                    typeConcept.setFL_NAME_CONCEPT(res.getString("FL_NAME_CONCEPT"));
                    allStudentsPenaltyPaymentDetail.setTypeConcept(typeConcept);
                    
                    typeFormat.setPK_TYPE_FORMAT(res.getInt("PK_TYPE_FORMAT"));
                    typeFormat.setFL_NAME_FORMAT(res.getString("FL_NAME_FORMAT"));
                    allStudentsPenaltyPaymentDetail.setTypeFormat(typeFormat);
                    student.setPK_STUDENT(res.getInt("PK_STUDENT"));
                    allStudentsPenaltyPaymentDetail.setStudent(student);
                    
                    semester.setPK_SEMESTER(res.getInt("PK_SEMESTER"));
                    semester.setFL_NAME_SEMESTER(res.getString("FL_NAME_SEMESTER"));
                    allStudentsPenaltyPaymentDetail.setSemester(semester);
                    
                    period.setPK_PERIOD(res.getInt("PK_PERIOD"));
                    period.setFL_NAME(res.getString("FL_NAME"));
                    allStudentsPenaltyPaymentDetail.setPeriod(period);
                    
                    studentPenalityPayment.setPK_STUDENT_PAYMENT_PENALTY(res.getInt("PK_STUDENT_PAYMENT_PENALTY"));
                    allStudentsPenaltyPaymentDetail.setStudentPenalityPayment(studentPenalityPayment);
                    
                    paymentTypes.setPK_PAYMENT_PENALTY_TYPE(res.getInt("PK_PAYMENT_PENALTY_TYPE"));
                    paymentTypes.setFL_NAME_PENALTY(res.getString("FL_NAME_PENALTY"));
                    paymentTypes.setFL_TARIFF(res.getString("FL_TARIFF"));
                    allStudentsPenaltyPaymentDetail.setPaymentTypes(paymentTypes);
                    
                    category.setPK_CATEGORY_PAYMENT(res.getInt("PK_CATEGORY_PAYMENT"));
                    allStudentsPenaltyPaymentDetail.setCategoryPayments(category);                    
                    
                    list.add(allStudentsPenaltyPaymentDetail);
                }
            }
        } catch (SQLException ex) {
            System.err.println(ex);
        }
        return list;
    }
    public ArrayList<studentsPenaltyPaymentsDetailModel> SelectStudentsAllStatusPaymentDetail(int pt_fk_period, int pt_fk_semester, int pt_type_format, int pt_fk_student){
        ArrayList<studentsPenaltyPaymentsDetailModel> list=new ArrayList<>();
        procedure = "CALL `GET_STUDENT_PENALTY_PAYMENTS_DETAIL`(?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure)) { 
            ps.setString(1, "all");
            ps.setInt(2, 0);      
            ps.setInt(3, pt_fk_period);      
            ps.setInt(4, pt_fk_semester);
            ps.setInt(5, 0);
            ps.setInt(6, 0);
            ps.setInt(7, pt_type_format);
            ps.setInt(8, pt_fk_student);
            try (ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    studentsPenaltyPaymentsDetailModel allStudentsPenaltyPaymentDetail=new studentsPenaltyPaymentsDetailModel();
                    studentModel student= new studentModel();
                    semesterModel semester = new semesterModel();
                    periodModel period = new periodModel();
                    studentsPenaltyPaymentsModel studentPenalityPayment = new studentsPenaltyPaymentsModel();
                    paymentsPenaltyTypesModel paymentTypes = new paymentsPenaltyTypesModel();
                    categoryPaymentsModel category =  new categoryPaymentsModel();
                    typeConceptModel typeConcept = new typeConceptModel();
                    typeFormatModel typeFormat = new typeFormatModel();
                    
                    allStudentsPenaltyPaymentDetail.setPK_STUDENT_PENALTY_PAYMENT_DETAIL(res.getInt("PK_STUDENT_PENALTY_PAYMENT_DETAIL"));
                    allStudentsPenaltyPaymentDetail.setFL_AMOUNT_PENALITY(res.getString("FL_AMOUNT_PENALITY"));
                    allStudentsPenaltyPaymentDetail.setFL_REFERENCE_NUMBER(res.getString("FL_REFERENCE_NUMBER"));
                    allStudentsPenaltyPaymentDetail.setFL_UNIQUE(res.getString("FL_UNIQUE"));
                    allStudentsPenaltyPaymentDetail.setFL_STATUS_PAY(res.getString("FL_STATUS_PAY"));
                    
                    typeConcept.setPK_TYPE_CONCEPT(res.getInt("PK_TYPE_CONCEPT"));
                    typeConcept.setFL_NAME_CONCEPT(res.getString("FL_NAME_CONCEPT"));
                    allStudentsPenaltyPaymentDetail.setTypeConcept(typeConcept);
                    
                    typeFormat.setPK_TYPE_FORMAT(res.getInt("PK_TYPE_FORMAT"));
                    typeFormat.setFL_NAME_FORMAT(res.getString("FL_NAME_FORMAT"));
                    allStudentsPenaltyPaymentDetail.setTypeFormat(typeFormat);
                    student.setPK_STUDENT(res.getInt("PK_STUDENT"));
                    allStudentsPenaltyPaymentDetail.setStudent(student);
                    
                    semester.setPK_SEMESTER(res.getInt("PK_SEMESTER"));
                    semester.setFL_NAME_SEMESTER(res.getString("FL_NAME_SEMESTER"));
                    allStudentsPenaltyPaymentDetail.setSemester(semester);
                    
                    period.setPK_PERIOD(res.getInt("PK_PERIOD"));
                    period.setFL_NAME(res.getString("FL_NAME"));
                    allStudentsPenaltyPaymentDetail.setPeriod(period);
                    
                    studentPenalityPayment.setPK_STUDENT_PAYMENT_PENALTY(res.getInt("PK_STUDENT_PAYMENT_PENALTY"));
                    allStudentsPenaltyPaymentDetail.setStudentPenalityPayment(studentPenalityPayment);
                    
                    paymentTypes.setPK_PAYMENT_PENALTY_TYPE(res.getInt("PK_PAYMENT_PENALTY_TYPE"));
                    paymentTypes.setFL_NAME_PENALTY(res.getString("FL_NAME_PENALTY"));
                    paymentTypes.setFL_TARIFF(res.getString("FL_TARIFF"));
                    allStudentsPenaltyPaymentDetail.setPaymentTypes(paymentTypes);
                    
                    category.setPK_CATEGORY_PAYMENT(res.getInt("PK_CATEGORY_PAYMENT"));
                    allStudentsPenaltyPaymentDetail.setCategoryPayments(category);                    
                    
                    list.add(allStudentsPenaltyPaymentDetail);
                }
            }
        } catch (SQLException ex) {
            System.err.println(ex);
        }
        return list;
    }
    
    public String InsertStudentsPenaltyPaymentDetail(studentsPenaltyPaymentsDetailModel dataStudentsPenaltyPayment){
        String request;
        procedure = "CALL `SET_STUDENT_PENALTY_PAYMENTS_DETAIL`(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement(procedure)) {
                ps.setString(1, "insert");
                ps.setInt(2, 0);
                ps.setInt(3, dataStudentsPenaltyPayment.getStudent().getPK_STUDENT());
                ps.setInt(4, dataStudentsPenaltyPayment.getSemester().getPK_SEMESTER());
                ps.setInt(5, dataStudentsPenaltyPayment.getPeriod().getPK_PERIOD());
                ps.setInt(6, dataStudentsPenaltyPayment.getStudentPenalityPayment().getPK_STUDENT_PAYMENT_PENALTY());
                ps.setInt(7, dataStudentsPenaltyPayment.getPaymentTypes().getPK_PAYMENT_PENALTY_TYPE());
                ps.setInt(8, dataStudentsPenaltyPayment.getCategoryPayments().getPK_CATEGORY_PAYMENT());
                ps.setInt(9, dataStudentsPenaltyPayment.getTypeConcept().getPK_TYPE_CONCEPT());
                ps.setInt(10, dataStudentsPenaltyPayment.getTypeFormat().getPK_TYPE_FORMAT());
                ps.setString(11, dataStudentsPenaltyPayment.getFL_AMOUNT_PENALITY());
                ps.setString(12, dataStudentsPenaltyPayment.getFL_REFERENCE_NUMBER());             
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
    public String UpdateStudentsPenaltyPaymentDetail(studentsPenaltyPaymentsDetailModel dataStudentsPenaltyPayment){
        String request;
        procedure = "CALL `SET_STUDENT_PENALTY_PAYMENTS_DETAIL`(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            Connection conn=new conectionControl().getConexion();
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
    public String DeleteStudentsPenaltyPaymentDetail(int pkStudentsPenaltyPayment){
        String request;
        procedure = "CALL `SET_STUDENT_PENALTY_PAYMENTS_DETAIL`(?, ?, null, null, null, null, null, null, null, null, null, null)";
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement(procedure)) {
                ps.setString(1, "delete");
                ps.setInt(2, pkStudentsPenaltyPayment);
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
