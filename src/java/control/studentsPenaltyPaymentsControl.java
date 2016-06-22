/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package control;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import model.careerModel;
import model.categoryPaymentsModel;
import model.periodModel;
import model.semesterModel;
import model.studentModel;
import model.studentsPenaltyPaymentsModel;
import model.studyLevelModel;

/**
 *
 * @author Lab5-E
 */
public class studentsPenaltyPaymentsControl {
    public static void main(String[] args) {
        ArrayList<studentsPenaltyPaymentsModel> listStudentsPenalityPayments;
        listStudentsPenalityPayments = new studentsPenaltyPaymentsControl().SelectStudentsPenaltyPayments(1,1,1, 14);
        for(int i=0;i<listStudentsPenalityPayments.size();i++){
            System.out.println(listStudentsPenalityPayments.get(i).getPK_STUDENT_PAYMENT_PENALTY());
        }
//        studentsPenaltyPaymentsModel dataStudentsPenalityPayments=new studentsPenaltyPaymentsModel();
//        periodModel period = new periodModel();
//        semesterModel semester = new semesterModel();
//        studentModel student = new studentModel();
//        period.setPK_PERIOD(14);
//        dataStudentsPenalityPayments.setPeriod(period);
//
//
//        semester.setPK_SEMESTER(7);
//        dataStudentsPenalityPayments.setSemester(semester);
//
//        student.setPK_STUDENT(819);
//        dataStudentsPenalityPayments.setStudent(student);
//
//        dataStudentsPenalityPayments.setFK_TYPE_CONCEPT(1);
//        dataStudentsPenalityPayments.setFK_TYPE_FORMAT(0);
//        System.err.println(Arrays.toString(new studentsPenaltyPaymentsControl().InsertStudentsPenaltyPayment(dataStudentsPenalityPayments)));
    }
    private String procedure;

    public ArrayList<studentsPenaltyPaymentsModel> SelectStudentsPenaltyPayments(int pt_fk_category_type, int pt_fk_type_concept, int pt_fk_type_format, int pt_fk_period){
        ArrayList<studentsPenaltyPaymentsModel> list=new ArrayList<>();
        procedure = "CALL `GET_STUDENT_PENALTY_PAYMENTS`(?, ?, ?, ?, ?)";
        try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure)) { 
            ps.setString(1, "all"); 
            ps.setInt(2, pt_fk_category_type);      
            ps.setInt(3, pt_fk_type_concept);      
            ps.setInt(4, pt_fk_type_format);      
            ps.setInt(5, pt_fk_period);      
            try (ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    studentsPenaltyPaymentsModel allStudentsPenaltyPayment=new studentsPenaltyPaymentsModel();
                    studentModel student = new studentModel();
                    careerModel career = new careerModel();
                    categoryPaymentsModel categoryPayment = new categoryPaymentsModel();
                    studyLevelModel studyLevel = new studyLevelModel();
                    semesterModel semester = new semesterModel();
                    periodModel period = new periodModel();     
                    
                    allStudentsPenaltyPayment.setPK_STUDENT_PAYMENT_PENALTY(res.getInt("PK_STUDENT_PAYMENT_PENALTY"));
                    allStudentsPenaltyPayment.setFL_DATE_PAYMENT(res.getString("FL_DATE_PAYMENT"));
                    allStudentsPenaltyPayment.setFL_UNIQUE(res.getString("FL_UNIQUE"));
                    categoryPayment.setPK_CATEGORY_PAYMENT(res.getInt("FK_CATEGORY_PAYMENT"));
                    allStudentsPenaltyPayment.setCategoryPayment(categoryPayment);
                    
                    allStudentsPenaltyPayment.setFK_TYPE_CONCEPT(res.getInt("FK_TYPE_CONCEPT"));
                    allStudentsPenaltyPayment.setFK_TYPE_FORMAT(res.getInt("FK_TYPE_FORMAT"));
                    allStudentsPenaltyPayment.setFL_STATUS_PAYMENT(res.getString("FL_STATUS_PAYMENT"));
                    student.setPK_STUDENT(res.getInt("PK_STUDENT"));
                    student.setFL_NAME(res.getString("FL_NAME_STUDENT"));
                    student.setFL_ENROLLMENT(res.getString("FL_ENROLLMENT"));
                    allStudentsPenaltyPayment.setStudent(student);
                    
                    career.setPK_CAREER(res.getInt("PK_CAREER"));
                    career.setFL_NAME_ABBREVIATED(res.getString("FL_NAME_ABBREVIATED"));
                    career.setFL_NAME_CAREER(res.getString("FL_NAME_CAREER"));
                    allStudentsPenaltyPayment.setCareer(career);
                    
                    studyLevel.setPK_LEVEL_STUDY(res.getInt("PK_LEVEL_STUDY"));
                    studyLevel.setFL_NAME_LEVEL(res.getString("FL_NAME_LEVEL"));
                    allStudentsPenaltyPayment.setStudyLevel(studyLevel);
                    
                    semester.setPK_SEMESTER(res.getInt("PK_SEMESTER"));
                    semester.setFL_NAME_SEMESTER(res.getString("FL_NAME_SEMESTER"));
                    allStudentsPenaltyPayment.setSemester(semester);
                    
                    period.setPK_PERIOD(res.getInt("PK_PERIOD"));
                    period.setFL_NAME(res.getString("FL_NAME"));
                    allStudentsPenaltyPayment.setPeriod(period);
                    
                    list.add(allStudentsPenaltyPayment);
                }
            }
        } catch (SQLException ex) {
            System.err.println(ex);
        }
        return list;
    }
    
    public String[] InsertStudentsPenaltyPayment(studentsPenaltyPaymentsModel dataStudentsPenaltyPayment){
        String[] request = new String[2];
        String key = null;
        procedure = "CALL `SET_STUDENT_PENALTY_PAYMENTS`(?, ?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement ps;
        Connection conn=new conectionControl().getConexion();
        try {
            ps = conn.prepareStatement(procedure);
            ps.setString(1, "insert");
            ps.setInt(2, 0);
            ps.setInt(3, dataStudentsPenaltyPayment.getPeriod().getPK_PERIOD());
            ps.setInt(4, dataStudentsPenaltyPayment.getSemester().getPK_SEMESTER());
            ps.setInt(5, dataStudentsPenaltyPayment.getStudent().getPK_STUDENT());
            ps.setInt(6, dataStudentsPenaltyPayment.getCategoryPayment().getPK_CATEGORY_PAYMENT());
            ps.setInt(7, dataStudentsPenaltyPayment.getFK_TYPE_CONCEPT());
            ps.setInt(8, dataStudentsPenaltyPayment.getFK_TYPE_FORMAT());
            ps.setString(9, dataStudentsPenaltyPayment.getFL_STATUS_PAYMENT());
            ps.executeUpdate();
            ResultSet rs = ps.getResultSet(); 
            while (rs.next()) {  
                key = ""+rs.getString("LAST_INSERT_ID");
            }   
            request[0]="Inserted";
            request[1]=""+key;
            ps.close();
            conn.close();
            
        } catch (SQLException e) {
            request[0]=""+e;
            request[1]=null;
        }   
        return request;
    }
    public String UpdateStudentsPenaltyPayment(studentsPenaltyPaymentsModel dataStudentsPenaltyPayment){
        String request;
        procedure = "CALL `SET_STUDENT_PENALTY_PAYMENTS`(?, ?, ?, ?, ?, ?, ?, ?, ?)";
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
    public String DeleteStudentsPenaltyPayment(int pkStudentsPenaltyPayment){
        String request;
        procedure = "CALL `SET_STUDENT_PENALTY_PAYMENTS`(?, ?, null, null, null, null, null, null, null)";
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
