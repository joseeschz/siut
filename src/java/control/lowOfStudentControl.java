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
import model.careerModel;
import model.debtModel;
import model.groupModel;
import model.lowOfStudentModel;
import model.periodModel;
import model.schoolarshipStudentsModel;
import model.semesterModel;
import model.studentModel;
import model.workerModel;

/**
 *
 * @author Lab5-E
 */
public class lowOfStudentControl {
    public static void main(String[] args) {
        ArrayList<lowOfStudentModel> list=new lowOfStudentControl().SelectStudentsLowsAuthorizedByDirector(6, 14);
        list.stream().forEach((ofStudentModel) -> {
            System.out.print(ofStudentModel.getPK_LOW_STUDENT());
        });
    }
    String procedure;
    
    public ArrayList<lowOfStudentModel> SelectStudentsLows(int fkPeriod){
        procedure="CALL `GET_LOW_STUDENT`(?, null, null, null, null, ?)";
        ArrayList<lowOfStudentModel> list=new ArrayList<>();        
        try (Connection conn = new connectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure)) { 
            ps.setString(1, "studentsLowsDir"); 
            ps.setInt(2, fkPeriod); 
            try (ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){                    
                    lowOfStudentModel lowOfStudentMdl = new lowOfStudentModel();
                    careerModel careerMdl = new careerModel();
                    studentModel  studentMdl= new studentModel();
                    semesterModel semesterMdl=new semesterModel();
                    groupModel groupModel=new groupModel();
                    lowOfStudentMdl.setPK_LOW_STUDENT(res.getInt("PK_LOW_STUDENT"));
                    studentMdl.setPK_STUDENT(res.getInt("PK_STUDENT"));
                    lowOfStudentMdl.setFL_FOLIO_LOW(res.getString("FL_FOLIO_LOW"));
                    studentMdl.setFL_ENROLLMENT(res.getString("FL_ENROLLMENT"));
                    studentMdl.setFL_NAME(res.getString("FL_STUDENT_NAME"));
                    studentMdl.setFL_DOWN(res.getInt("FL_DOWN"));                    
                    lowOfStudentMdl.setStudentMdl(studentMdl);       
                    semesterMdl.setFL_NAME_SEMESTER(res.getString("FL_NAME_SEMESTER"));
                    careerMdl.setFL_NAME_ABBREVIATED(res.getString("FL_NAME_ABBREVIATED"));
                    lowOfStudentMdl.setCareerMdl(careerMdl);
                    lowOfStudentMdl.setSemesterMdl(semesterMdl);
                    groupModel.setFL_NAME_GROUP(res.getString("FL_NAME_GROUP"));
                    lowOfStudentMdl.setGroupMdl(groupModel);
                    list.add(lowOfStudentMdl);
                }
                res.close();
                ps.close();
                conn.close();
            }
        } catch (SQLException ex) {
            Logger.getLogger(lowOfStudentModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public ArrayList<lowOfStudentModel> SelectStudentsLowsAuthorizedByDirector(int fkCarrer, int fkPeriod){
        procedure="CALL `GET_LOW_STUDENT`(?, null, ?, null, null, ?)";
        ArrayList<lowOfStudentModel> list=new ArrayList<>();        
        try (Connection conn = new connectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure)) { 
            ps.setString(1, "studentsLowsAuthorizedByDirector"); 
            ps.setInt(2, fkCarrer); 
            ps.setInt(3, fkPeriod); 
            try (ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){                    
                    lowOfStudentModel lowOfStudentMdl = new lowOfStudentModel();
                    studentModel  studentMdl= new studentModel();
                    semesterModel semesterMdl=new semesterModel();
                    groupModel groupModel=new groupModel();
                    lowOfStudentMdl.setPK_LOW_STUDENT(res.getInt("PK_LOW_STUDENT"));
                    studentMdl.setPK_STUDENT(res.getInt("PK_STUDENT"));
                    lowOfStudentMdl.setFL_FOLIO_LOW(res.getString("FL_FOLIO_LOW"));
                    studentMdl.setFL_ENROLLMENT(res.getString("FL_ENROLLMENT"));
                    studentMdl.setFL_NAME(res.getString("FL_STUDENT_NAME"));
                    studentMdl.setFL_DOWN(res.getInt("FL_DOWN"));                    
                    lowOfStudentMdl.setStudentMdl(studentMdl);       
                    semesterMdl.setFL_NAME_SEMESTER(res.getString("FL_NAME_SEMESTER"));
                    lowOfStudentMdl.setSemesterMdl(semesterMdl);
                    groupModel.setFL_NAME_GROUP(res.getString("FL_NAME_GROUP"));
                    lowOfStudentMdl.setGroupMdl(groupModel);
                    list.add(lowOfStudentMdl);
                }
                res.close();
                ps.close();
                conn.close();
            }
        } catch (SQLException ex) {
            Logger.getLogger(lowOfStudentModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public ArrayList<lowOfStudentModel> SelectStudentsLowsArchivedES(int fkPeriod){
        procedure="CALL `GET_LOW_STUDENT`(?, null, null, null, null, ?)";
        ArrayList<lowOfStudentModel> list=new ArrayList<>();        
        try (Connection conn = new connectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure)) { 
            ps.setString(1, "studentsLowsArchivedES"); 
            ps.setInt(2, fkPeriod); 
            try (ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){                    
                    lowOfStudentModel lowOfStudentMdl = new lowOfStudentModel();
                    careerModel careerMdl = new careerModel();
                    studentModel  studentMdl= new studentModel();
                    semesterModel semesterMdl=new semesterModel();
                    groupModel groupModel=new groupModel();
                    lowOfStudentMdl.setPK_LOW_STUDENT(res.getInt("PK_LOW_STUDENT"));
                    studentMdl.setPK_STUDENT(res.getInt("PK_STUDENT"));
                    lowOfStudentMdl.setFL_FOLIO_LOW(res.getString("FL_FOLIO_LOW"));
                    studentMdl.setFL_ENROLLMENT(res.getString("FL_ENROLLMENT"));
                    studentMdl.setFL_NAME(res.getString("FL_STUDENT_NAME"));
                    studentMdl.setFL_DOWN(res.getInt("FL_DOWN"));                    
                    lowOfStudentMdl.setStudentMdl(studentMdl);       
                    semesterMdl.setFL_NAME_SEMESTER(res.getString("FL_NAME_SEMESTER"));
                    careerMdl.setFL_NAME_ABBREVIATED(res.getString("FL_NAME_ABBREVIATED"));
                    lowOfStudentMdl.setCareerMdl(careerMdl);
                    lowOfStudentMdl.setSemesterMdl(semesterMdl);
                    groupModel.setFL_NAME_GROUP(res.getString("FL_NAME_GROUP"));
                    lowOfStudentMdl.setGroupMdl(groupModel);
                    list.add(lowOfStudentMdl);
                }
                res.close();
                ps.close();
                conn.close();
            }
        } catch (SQLException ex) {
            Logger.getLogger(lowOfStudentModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public ArrayList<lowOfStudentModel> SelectStudentsLowsESAuthorizedDirector(int fkPeriod){
        procedure="CALL `GET_LOW_STUDENT`(?, null, null, null, null, ?)";
        ArrayList<lowOfStudentModel> list=new ArrayList<>();        
        try (Connection conn = new connectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure)) { 
            ps.setString(1, "studentsLowsES"); 
            ps.setInt(2, fkPeriod); 
            try (ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){                    
                    lowOfStudentModel lowOfStudentMdl = new lowOfStudentModel();
                    careerModel careerMdl = new careerModel();
                    studentModel  studentMdl= new studentModel();
                    semesterModel semesterMdl=new semesterModel();
                    groupModel groupModel=new groupModel();
                    lowOfStudentMdl.setPK_LOW_STUDENT(res.getInt("PK_LOW_STUDENT"));
                    studentMdl.setPK_STUDENT(res.getInt("PK_STUDENT"));
                    lowOfStudentMdl.setFL_FOLIO_LOW(res.getString("FL_FOLIO_LOW"));
                    studentMdl.setFL_ENROLLMENT(res.getString("FL_ENROLLMENT"));
                    studentMdl.setFL_NAME(res.getString("FL_STUDENT_NAME"));
                    studentMdl.setFL_DOWN(res.getInt("FL_DOWN"));                    
                    lowOfStudentMdl.setStudentMdl(studentMdl);       
                    semesterMdl.setFL_NAME_SEMESTER(res.getString("FL_NAME_SEMESTER"));
                    careerMdl.setFL_NAME_ABBREVIATED(res.getString("FL_NAME_ABBREVIATED"));
                    lowOfStudentMdl.setCareerMdl(careerMdl);
                    lowOfStudentMdl.setSemesterMdl(semesterMdl);
                    groupModel.setFL_NAME_GROUP(res.getString("FL_NAME_GROUP"));
                    lowOfStudentMdl.setGroupMdl(groupModel);
                    list.add(lowOfStudentMdl);
                }
                res.close();
                ps.close();
                conn.close();
            }
        } catch (SQLException ex) {
            Logger.getLogger(lowOfStudentModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<lowOfStudentModel> SelectStudentsLowsDirector(int fkCareer, int fkPeriod){
        procedure="CALL `GET_LOW_STUDENT`(?, null, ?, null, null, ?)";
        ArrayList<lowOfStudentModel> list=new ArrayList<>();        
        try (Connection conn = new connectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure)) { 
            ps.setString(1, "studentsLowsDirector");   
            ps.setInt(2, fkCareer);  
            ps.setInt(3, fkPeriod); 
            try (ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){                    
                    lowOfStudentModel lowOfStudentMdl = new lowOfStudentModel();
                    studentModel  studentMdl= new studentModel();
                    semesterModel semesterMdl=new semesterModel();
                    groupModel groupModel=new groupModel();
                    lowOfStudentMdl.setPK_LOW_STUDENT(res.getInt("PK_LOW_STUDENT"));
                    studentMdl.setPK_STUDENT(res.getInt("PK_STUDENT"));
                    studentMdl.setFL_ENROLLMENT(res.getString("FL_ENROLLMENT"));
                    studentMdl.setFL_NAME(res.getString("FL_STUDENT_NAME"));
                    studentMdl.setFL_DOWN(res.getInt("FL_DOWN"));                    
                    lowOfStudentMdl.setStudentMdl(studentMdl);       
                    lowOfStudentMdl.setFL_STATUS_ES(res.getString("FL_STATUS_ES"));
                    semesterMdl.setFL_NAME_SEMESTER(res.getString("FL_NAME_SEMESTER"));
                    lowOfStudentMdl.setSemesterMdl(semesterMdl);
                    groupModel.setFL_NAME_GROUP(res.getString("FL_NAME_GROUP"));
                    lowOfStudentMdl.setGroupMdl(groupModel);
                    list.add(lowOfStudentMdl);
                }
                res.close();
                ps.close();
                conn.close();
            }
        } catch (SQLException ex) {
            Logger.getLogger(lowOfStudentModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<lowOfStudentModel> SelectStudentsLows(int fkCareer, int fkSemester, int fkGroup, int fkPeriod){
        procedure="CALL `GET_LOW_STUDENT`(?, null, ?, ?, ?, ?)";
        ArrayList<lowOfStudentModel> list=new ArrayList<>();        
        try (Connection conn = new connectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure)) { 
            ps.setString(1, "studentsLows");   
            ps.setInt(2, fkCareer);  
            ps.setInt(3, fkSemester);   
            ps.setInt(4, fkGroup);   
            ps.setInt(5, fkPeriod); 
            try (ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){                    
                    lowOfStudentModel lowOfStudentMdl = new lowOfStudentModel();
                    studentModel  studentMdl= new studentModel();
                    lowOfStudentMdl.setPK_LOW_STUDENT(res.getInt("PK_LOW_STUDENT"));
                    studentMdl.setPK_STUDENT(res.getInt("PK_STUDENT"));
                    studentMdl.setFL_ENROLLMENT(res.getString("FL_ENROLLMENT"));
                    studentMdl.setFL_NAME(res.getString("FL_STUDENT_NAME"));
                    studentMdl.setFL_DOWN(res.getInt("FL_DOWN"));                    
                    lowOfStudentMdl.setStudentMdl(studentMdl);       
                    lowOfStudentMdl.setFL_STATUS_DIR(res.getString("FL_STATUS_DIR"));
                    lowOfStudentMdl.setFL_STATUS_ES(res.getString("FL_STATUS_ES"));
                    list.add(lowOfStudentMdl);
                }
                res.close();
                ps.close();
                conn.close();
            }
        } catch (SQLException ex) {
            Logger.getLogger(lowOfStudentModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<lowOfStudentModel> SelectLowOfStudent(int pt_pk_student, int pt_pk_period){
        procedure="CALL `GET_LOW_STUDENT`(?, ?, null, null, null, ?)";
        ArrayList<lowOfStudentModel> list=new ArrayList<>();
        try (Connection conn = new connectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure)) { 
            ps.setString(1, "byStudentPeriod");   
            ps.setInt(2, pt_pk_student);  
            ps.setInt(3, pt_pk_period);    
            try (ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    lowOfStudentModel allData=new lowOfStudentModel();
                    schoolarshipStudentsModel schoolarshipStudentsMdl = new schoolarshipStudentsModel();
                    debtModel debtMdl = new debtModel();
                    studentModel studentMdl = new studentModel();
                    workerModel workerDirectorMdl = new workerModel();
                    workerModel workerTutorMdl = new workerModel();
                    workerModel workerESMdl = new workerModel();
                    workerModel workerCPMdl = new workerModel();    
                    periodModel periodMdl = new periodModel();
                    careerModel careerMdl = new careerModel();
                    groupModel groupMdl = new groupModel();
                    allData.setPK_LOW_STUDENT(res.getInt("PK_LOW_STUDENT"));
                    allData.setFL_FOLIO_LOW(res.getString("FL_FOLIO_LOW"));
                    allData.setFL_AUTORIZATION_DATE(res.getString("FL_AUTORIZATION_DATE"));
                    allData.setFL_HAS_SCHOOLARSHIP(res.getBoolean("FL_HAS_SCHOOLARSHIP"));
                    schoolarshipStudentsMdl.setPK_SCHOOLARSHIP_STUDENT(res.getInt("FK_SCHOLARSHIP"));
                    allData.setSchoolarshipStudentsMdl(schoolarshipStudentsMdl);
                    allData.setFL_HAS_DEBT(res.getBoolean("FL_HAS_DEBT"));
                    debtMdl.setPK_DEBT(res.getInt("FK_DEBT"));
                    allData.setDebtMdl(debtMdl);
                    studentMdl.setPK_STUDENT(res.getInt("FK_STUDENT"));
                    studentMdl.setFL_NAME(res.getString("FL_STUDENT_NAME"));
                    studentMdl.setFL_ENROLLMENT(res.getString("FL_ENROLLMENT"));
                    allData.setStudentMdl(studentMdl);
                    allData.setFL_ULTIMATE_LOW(res.getBoolean("FL_ULTIMATE_LOW"));
                    allData.setFL_TEMPORALY_LOW(res.getBoolean("FL_TEMPORALY_LOW"));
                    allData.setFL_REQUEST_FOR_STUDENT(res.getBoolean("FL_REQUEST_FOR_STUDENT"));
                    allData.setFL_REPPROBED(res.getBoolean("FL_REPPROBED"));
                    allData.setFL_BACKGROUND_ACADEMICS_STUDENT(res.getBoolean("FL_BACKGROUND_ACADEMICS_STUDENT"));
                    allData.setFL_UTSEM_NOT_FIRST_OPTION(res.getBoolean("FL_UTSEM_NOT_FIRST_OPTION"));
                    allData.setFL_MISTAKES_REGULATION_SCHOOL(res.getBoolean("FL_MISTAKES_REGULATION_SCHOOL"));
                    allData.setFL_DIFFICULTY_MATTERS_SCHOOL(res.getBoolean("FL_DIFFICULTY_MATTERS_SCHOOL"));
                    allData.setFL_THAT_MATTERS(res.getString("FL_THAT_MATTERS"));
                    allData.setFL_ABSENCE(res.getBoolean("FL_ABSENCE"));
                    allData.setFL_DISSATISFACTION_OF_EXPECTATIONS(res.getBoolean("FL_DISSATISFACTION_OF_EXPECTATIONS"));
                    allData.setFL_DEFICIENT_ORIENTATION_VOCATIONAL(res.getBoolean("FL_DEFICIENT_ORIENTATION_VOCATIONAL"));
                    allData.setFL_CAREER_NOT_FIRST_OPTION(res.getBoolean("FL_CAREER_NOT_FIRST_OPTION"));
                    allData.setFL_OTHERS_FACTORS_ACADEMICS(res.getBoolean("FL_OTHERS_FACTORS_ACADEMICS"));
                    allData.setFL_THAT_OTHERS_FACTORS_ACADEMICS(res.getString("FL_THAT_OTHERS_FACTORS_ACADEMICS"));
                    allData.setFL_SITUATION_ECONOMIC_UNFAVORABLE(res.getBoolean("FL_SITUATION_ECONOMIC_UNFAVORABLE"));
                    allData.setFL_STUDENT_WORK(res.getBoolean("FL_STUDENT_WORK"));
                    allData.setFL_MARRIAGE_AFFECTS_SITUATION_ECONOMIC(res.getBoolean("FL_MARRIAGE_AFFECTS_SITUATION_ECONOMIC"));
                    allData.setFL_PROBLEMS_BAD_NUTRITION(res.getBoolean("FL_PROBLEMS_BAD_NUTRITION"));
                    allData.setFL_LOSS_EMPLOYMENT_WHO_DEPENDS_STUDENT(res.getBoolean("FL_LOSS_EMPLOYMENT_WHO_DEPENDS_STUDENT"));
                    allData.setFL_INCOMPATIBILITY_OF_SCHEDULES_WORK_STUDIES(res.getBoolean("FL_INCOMPATIBILITY_OF_SCHEDULES_WORK_STUDIES"));
                    allData.setFL_CHANGE_RESIDENCE(res.getBoolean("FL_CHANGE_RESIDENCE"));
                    allData.setFL_FEATURES_SOCIOCULTURALES_STUDENT(res.getBoolean("FL_FEATURES_SOCIOCULTURALES_STUDENT"));
                    allData.setFL_LACK_MOTIVATION(res.getBoolean("FL_LACK_MOTIVATION"));
                    allData.setFL_DISTANCE_OF_UTSEM(res.getBoolean("FL_DISTANCE_OF_UTSEM"));
                    allData.setFL_PROBLEMS_HEALTH(res.getBoolean("FL_PROBLEMS_HEALTH"));
                    allData.setFL_NOT_PRESENT_CLASSES(res.getBoolean("FL_NOT_PRESENT_CLASSES"));
                    allData.setFL_PROBLEMS_WITH_COLLAGUES_OF_CLASS(res.getBoolean("FL_PROBLEMS_WITH_COLLAGUES_OF_CLASS"));
                    allData.setFL_PROBLEMS_EMOTIONALS(res.getBoolean("FL_PROBLEMS_EMOTIONALS"));
                    allData.setFL_ADDICTIONS(res.getBoolean("FL_ADDICTIONS"));
                    allData.setFL_PROBLEMS_WITH_TEACHERS(res.getBoolean("FL_PROBLEMS_WITH_TEACHERS"));
                    allData.setFL_OTHERS_FACTORS_PERSONALS(res.getBoolean("FL_OTHERS_FACTORS_PERSONALS"));
                    allData.setFL_THAT_OTHERS_FACTORS_PERSONALS(res.getString("FL_THAT_OTHERS_FACTORS_PERSONALS"));
                    workerDirectorMdl.setFL_NAME_WORKER(res.getString("FL_NAME_DIRECTOR_CAREER"));
                    allData.setWorkerDirectorMdl(workerDirectorMdl);
                    workerTutorMdl.setFL_NAME_WORKER(res.getString("FL_NAME_TUTOR"));
                    allData.setWorkerTutorMdl(workerTutorMdl);
                    workerESMdl.setFL_NAME_WORKER(res.getString("FL_NAME_HEAD_ES"));
                    allData.setWorkerESMdl(workerESMdl);
                    workerCPMdl.setFL_NAME_WORKER(res.getString("FL_NAME_HEAD_CP"));
                    allData.setWorkerCPMdl(workerCPMdl);
                    periodMdl.setPK_PERIOD(res.getInt("FK_PERIOD_LOW"));
                    allData.setPeriodMdl(periodMdl);
                    allData.setFL_AUTHORIZATION_DIRECTOR(res.getBoolean("FL_AUTHORIZATION_DIRECTOR"));
                    allData.setFL_AUTHORIZATION_ES(res.getBoolean("FL_AUTHORIZATION_ES"));
                    careerMdl.setFL_NAME_CAREER(res.getString("FL_NAME_CAREER"));
                    allData.setCareerMdl(careerMdl);
                    groupMdl.setFL_NAME_GROUP(res.getString("FL_NAME_GROUP"));
                    allData.setGroupMdl(groupMdl);
                    list.add(allData);
                }
                res.close();
                ps.close();
                conn.close();
            }
        } catch (SQLException ex) {
            Logger.getLogger(lowOfStudentModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public String InsertLowOfStudent(int pt_pk_student, int pt_pk_period){
        String request;
        procedure = "CALL `SET_LOW_STUDENT`(?, null, ?, ?, null, null)";
        try {
            Connection conn=new connectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement(procedure)) {
                ps.setString(1, "insert");
                ps.setInt(2, pt_pk_student);
                ps.setInt(3, pt_pk_period);
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
    public String UpdateLowOfStudent(int pk_low_student, String pt_field_name, String field_value){
        String request;
        procedure = "CALL `SET_LOW_STUDENT`(?, ?, null, null, ?, ?)";
        try {
            Connection conn=new connectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement(procedure)) {
                ps.setString(1, "update");
                ps.setInt(2, pk_low_student);
                ps.setString(3, pt_field_name);
                ps.setString(4, field_value);
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
    public String DeleteLowOfStudent(int pkLowOfStudent){
        String request;
        procedure = "CALL `SET_LOW_STUDENT`(?, ?, null, null, null, null)";
        try {
            Connection conn=new connectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement(procedure)) {
                ps.setString(1, "delete");
                ps.setInt(2, pkLowOfStudent);
                ps.executeUpdate();
                request="Deleted";
                ps.close();
                conn.close();
            }
        } catch (SQLException e) {
            request="'"+e.getMessage()+"'";
            e.getMessage();
        }   
        return request;
    }
}
