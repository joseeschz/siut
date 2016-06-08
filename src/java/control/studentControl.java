/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package control;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.propetiesTableModel;
import model.requirementsModel;
import model.studentModel;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author CARLOS
 */
public class studentControl {
    public static void main(String[] args) {
        studentModel obj = new studentModel();
        obj.setFL_MAIL("karlos.antoni-1994@hotmail.com");
        obj.setFL_ENROLLMENT("UTS12S-003661");
        ArrayList<propetiesTableModel> listColumns=new studentControl().SelectReportColums();
        for(int i=0;i<listColumns.size();i++){
            System.out.println(listColumns.get(i).getFL_TEXT());
        }
    }
    public ArrayList<propetiesTableModel> SelectReportColums(){
        ArrayList<propetiesTableModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_STUDENTS`('columsMetadata', '')"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    propetiesTableModel allData=new propetiesTableModel();
                    allData.setFL_TEXT(res.getString("FL_TEXT"));
                    allData.setFL_DATA_FIELD(res.getString("FL_DATA_FIELD"));
                    allData.setFL_ALIGN(res.getString("FL_ALIGN"));
                    allData.setFL_CELLSALING(res.getString("FL_CELLSALING"));
                    allData.setFL_CELLSRENDERER(res.getString("FL_CELLSRENDERER"));
                    allData.setFL_RENDERED(res.getString("FL_RENDERED"));
                    allData.setFL_COLUMNGROUP(res.getString("FL_COLUMNGROUP"));
                    allData.setFL_WIDHT(res.getString("FL_WIDHT"));
                    allData.setFL_PINNED(res.getString("FL_PINNED"));
                    allData.setFL_FILTERTYPE(res.getString("FL_FILTERTYPE"));
                    allData.setFL_SORTABLE(res.getString("FL_SORTABLE"));
                    allData.setFL_RESIZABLE(res.getString("FL_RESIZABLE"));
                    allData.setFL_CREATEFILTERPANE(res.getString("FL_CREATEFILTERPANE"));
                    allData.setFL_FILTERABLE(res.getString("FL_FILTERABLE"));
                    allData.setFL_COLUMNTYPE(res.getString("FL_COLUMNTYPE"));
                    
                    list.add(allData);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(studentModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public JSONArray SelectMetadataRows(){
        JSONArray contentColums = new JSONArray();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_STUDENTS`('rowsMetadata', '')"); ResultSet res = ps.executeQuery()) {
                ResultSetMetaData rsmd = res.getMetaData();
                JSONObject columns;
                while(res!=null&&res.next()){
                    columns = new JSONObject();
                    for(int col=1; col<rsmd.getColumnCount()+1; col++){  
                        String value = res.getString(rsmd.getColumnLabel(col));
                        columns.put(rsmd.getColumnName(col),value);
                    }
                    contentColums.add(columns);
                }
                res.close();
                ps.close();
                conn.close();
            }
        } catch (SQLException ex) {
            Logger.getLogger(studentModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return contentColums;
    }
    public ArrayList<studentModel> SelectStudentLogin(studentModel dataStudent){
        ArrayList<studentModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("'"+dataStudent.getFL_MAIL()+"', '"+dataStudent.getFL_PASSWORD()+"')"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    studentModel StudentLogin=new studentModel();
                    StudentLogin.setPK_STUDENT(res.getInt("PK_STUDENT"));
                    list.add(StudentLogin);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(studentModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<studentModel> SelectAllStudents(){
        ArrayList<studentModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_ENROLLED`('allStudentsInformativeData', '', null, null)"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    studentModel CandidateAll=new studentModel();
                    CandidateAll.setPK_STUDENT(res.getInt("PK_STUDENT"));
                    CandidateAll.setFL_ENROLLMENT(res.getString("FL_ENROLLMENT"));
                    CandidateAll.setFL_NAME(res.getString("FL_NAME"));
                    CandidateAll.setFL_NAME_CAREER(res.getString("FL_NAME_CAREER"));
                    CandidateAll.setFL_NAME_ABBREVIATED(res.getString("FL_NAME_ABBREVIATED"));
                    CandidateAll.setFL_NAME_GROUP(res.getString("FL_CRURRENT_GROUP"));
                    CandidateAll.setFL_DOWN(res.getInt("FL_DOWN"));
                    list.add(CandidateAll);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(studentModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<studentModel> SelectStudents(int pt_period, int pt_career){
        ArrayList<studentModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_ENROLLED`('studentsInscription', '', "+pt_career+", "+pt_period+")"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    studentModel CandidateAll=new studentModel();
                    CandidateAll.setPK_STUDENT(res.getInt("PK_STUDENT"));
                    CandidateAll.setFL_UTSEM_FOLIO(res.getString("FL_UTSEM_FOLIO"));
                    CandidateAll.setFL_ENROLLMENT(res.getString("FL_ENROLLMENT"));
                    CandidateAll.setFL_NAME(res.getString("FL_NAME"));
                    list.add(CandidateAll);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(studentModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<studentModel> SelectStudentsMetadata(int pt_career, int pt_group){
        ArrayList<studentModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_METADATA_STUDENTS`('missing', "+pt_career+", "+pt_group+")"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    studentModel StudentsAll=new studentModel();
                    StudentsAll.setFL_ENROLLMENT(res.getString("FL_ENROLLMENT"));
                    StudentsAll.setFL_NAME(res.getString("FL_STUDENT_NAME"));
                    list.add(StudentsAll);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(studentModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<requirementsModel> SelectStudentExpedient(int pt_pk_student){
        ArrayList<requirementsModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_REQUIREMENTS`('reportByStudent', "+pt_pk_student+")"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    requirementsModel requirementAll=new requirementsModel();
                    requirementAll.setPK_REQUIREMENT(res.getInt("PK_REQUIREMENT"));
                    requirementAll.setPK_STUDENT(pt_pk_student);
                    requirementAll.setFL_ORDER(res.getString("FL_ORDER"));
                    requirementAll.setFL_NAME_REQUIRIMENT(res.getString("FL_NAME"));
                    if(res.getString("FL_FULFILLMENT").equals("CUMPLIMIENTO DE REQUISITOS")){
                        requirementAll.setFL_FULFILLMENT("");
                    }else{
                        requirementAll.setFL_FULFILLMENT(res.getString("FL_FULFILLMENT"));
                    }      
                    requirementAll.setFL_PARENT(res.getString("FL_PARENT"));
                    requirementAll.setFL_OTHER_FLAG(res.getString("FL_OTHERS_FLAG"));
                    list.add(requirementAll);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(studentModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public String updateStudentExpedient(int pt_pk_requirement, int pt_pk_student){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_REQUIREMENTS_BY_STUDENT`('insert', '', '', "+pt_pk_student+", "+pt_pk_requirement+")")) {
                ps.executeUpdate();
                request="Dato Insertado";
                ps.close();
                conn.close();
            }
        } catch (SQLException e) {
            request=""+e.getMessage();
            e.getMessage();
        }   
        return request;
    }
    public String deleteStudentExpedient(int pt_pk_requirement, int pt_pk_student){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_REQUIREMENTS_BY_STUDENT`('delete', '', '', "+pt_pk_student+", "+pt_pk_requirement+")")) {
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
    public ArrayList<studentModel> SelectStudentsCareerSemesterGroup(int fkCareer, int fkSemester, int fkGroup, int fkPeriod){
        ArrayList<studentModel> list=new ArrayList<>();
        String procedure = "CALL `GET_STUDENTS_DOWN`('studentsDown', "+fkCareer+", "+fkSemester+", "+fkGroup+", "+fkPeriod+")";
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    studentModel Student=new studentModel();
                    Student.setPK_STUDENT(res.getInt("PK_STUDENT"));
                    Student.setFL_ENROLLMENT(res.getString("FL_ENROLLMENT"));
                    Student.setFL_NAME(res.getString("FL_STUDENT_NAME"));
                    Student.setFL_DOWN(res.getInt("FL_DOWN"));
                    list.add(Student);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(studentModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<studentModel> SelectStudentConstancy(String enrollment){
        ArrayList<studentModel> list=new ArrayList<>();
        String procedure;
        procedure = "CALL `GET_STUDENTS`('studentByEnrollmentConstancy', '"+enrollment+"')";
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    studentModel Student=new studentModel();
                    Student.setPK_STUDENT(res.getInt("PK_STUDENT"));
                    Student.setFL_ENROLLMENT(res.getString("FL_ENROLLMENT"));
                    Student.setFL_NAME(res.getString("FL_NAME"));
                    Student.setFL_NAME_ABBREVIATED(res.getString("FL_NAME_LEVEL"));
                    Student.setPK_LEVEL_STUDY(res.getInt("PK_LEVEL_STUDY"));
                    Student.setFL_NAME_CAREER(res.getString("FL_NAME_CAREER"));
                    Student.setFK_CAREER(res.getInt("FK_CAREER"));                    
                    list.add(Student);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(studentModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<studentModel> SelectStudent(String enrollment, String condition){
        ArrayList<studentModel> list=new ArrayList<>();
        String procedure;
        if(condition.equals("onlyDataBasic")){
            procedure = "CALL `GET_STUDENTS`('studentByEnrollment', '"+enrollment+"')";
            try {
                try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                    while(res!=null&&res.next()){
                        studentModel Student=new studentModel();
                        Student.setPK_STUDENT(res.getInt("PK_STUDENT"));
                        Student.setFL_ENROLLMENT(res.getString("FL_ENROLLMENT"));
                        Student.setFL_NAME(res.getString("FL_NAME"));
                        Student.setFL_PATERN_NAME(res.getString("FL_PATERN_NAME"));
                        Student.setFL_MATERN_NAME(res.getString("FL_MATERN_NAME"));
                        Student.setPK_LEVEL_STUDY(res.getInt("PK_LEVEL_STUDY_CURRENT"));
                        Student.setPK_CAREER_LEVEL_STUDY1(res.getInt("PK_CAREER_LEVEL_STUDY1"));
                        Student.setPK_CAREER_LEVEL_STUDY2(res.getInt("PK_CAREER_LEVEL_STUDY2"));
                        Student.setFK_CAREER(res.getInt("FK_CAREER"));
                        Student.setPK_ENTITY(res.getInt("FK_ENTITY"));
                        Student.setPK_MUNICIPALITY(res.getInt("FK_MUNICIPALITY"));
                        Student.setPK_LOCALITY(res.getInt("FK_LOCALITY"));
                        Student.setFK_PREPARATORY(res.getInt("FK_PREPARATORY"));
                        Student.setFL_BIRTH_CERTIFICATE_NUMBER(res.getString("FL_BIRTH_CERTIFICATE_NUMBER"));
                        Student.setFL_HIGH_SCHOOL_CERTIFICATE(res.getString("FL_HIGH_SCHOOL_CERTIFICATE"));
                        list.add(Student);
                    }
                    res.close();
                    ps.close();
                    conn.close();
                }
                return list;
            } catch (SQLException ex) {
                Logger.getLogger(studentModel.class.getName()).log(Level.SEVERE, null, ex);
            }
        }else if(condition.equals("allData")){
            procedure = "CALL `GET_STUDENTS`('studentByPk', '"+enrollment+"')";
            try {
                try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                    while(res!=null&&res.next()){
                        studentModel Student=new studentModel();
                        Student.setPK_STUDENT(res.getInt("PK_STUDENT"));
                        Student.setFL_ENROLLMENT(res.getString("FL_ENROLLMENT"));
                        Student.setFK_CAREER(res.getInt("FK_CAREER"));
                        Student.setPK_ENTITY(res.getInt("FK_ENTITY"));
                        Student.setPK_MUNICIPALITY(res.getInt("FK_MUNICIPALITY"));
                        Student.setPK_LOCALITY(res.getInt("FK_LOCALITY"));
                        Student.setFK_PREPARATORY(res.getInt("FK_PREPARATORY"));
                        Student.setFL_REGISTER_DATE(res.getString("FL_REGISTER_DATE"));
                        Student.setFL_UTSEM_FOLIO(res.getString("FL_UTSEM_FOLIO"));
                        Student.setFL_CENEVAL_FOLIO(res.getString("FL_CENEVAL_FOLIO"));
                        Student.setFL_NAME(res.getString("FL_NAME"));
                        Student.setFL_MATERN_NAME(res.getString("FL_MATERN_NAME"));
                        Student.setFL_PATERN_NAME(res.getString("FL_PATERN_NAME"));
                        Student.setFL_DATE_BORN(res.getString("FL_DATE_BORN"));
                        Student.setFL_GENDER(res.getString("FL_GENDER"));
                        Student.setFL_PHOTOGRAPHY(res.getString("FL_PHOTOGRAPHY"));
                        Student.setFL_MARITIAL_STATUS(res.getString("FL_MARITIAL_STATUS"));
                        Student.setFL_WORKING(res.getString("FL_WORKING"));
                        Student.setFL_BACHEROL_TYPE(res.getString("FL_BACHEROL_TYPE"));
                        Student.setFL_SCHOOL_TYPE(res.getString("FL_SCHOOL_TYPE"));
                        Student.setFL_ABOVE_AVERAGE(res.getDouble("FL_ABOVE_AVERAGE"));
                        Student.setFL_PERIOD_BACHEROL(res.getString("FL_PERIOD_BACHEROL"));
                        Student.setFL_FILE_ID_OFICIAL(res.getString("FL_FILE_ID_OFICIAL"));
                        Student.setFL_FILE_DOCUMENT_BORN(res.getString("FL_FILE_DOCUMENT_BORN"));
                        Student.setFL_CURP(res.getString("FL_CURP"));
                        Student.setFL_FILE_CURP(res.getString("FL_FILE_CURP"));
                        Student.setFK_BORN_ENTITY(res.getInt("FK_BORN_ENTITY"));
                        Student.setFK_BORN_MUNICIPALITY(res.getInt("FK_BORN_MUNICIPALITY"));
                        Student.setFK_BORN_LOCALITY(res.getInt("FK_BORN_LOCALITY"));
                        Student.setFL_NAME_STREET(res.getString("FL_NAME_STREET"));
                        Student.setFL_EXTERNAL_NUMBER(res.getString("FL_EXTERNAL_NUMBER"));
                        Student.setFL_INTERNAL_NUMBER(res.getString("FL_INTERNAL_NUMBER"));
                        Student.setFL_BETWEEN_STREET1(res.getString("FL_BETWEEN_STREET1"));
                        Student.setFL_BETWEEN_STREET2(res.getString("FL_BETWEEN_STREET2"));
                        Student.setFL_REFERENCE(res.getString("FL_REFERENCE"));
                        Student.setFK_CURRENT_ENTITY(res.getString("FK_CURRENT_ENTITY"));
                        Student.setFK_CURRENT_MUNICIPALITY(res.getString("FK_CURRENT_MUNICIPALITY"));
                        Student.setFK_CURRENT_LOCALITY(res.getString("FK_CURRENT_LOCALITY"));
                        Student.setFL_CURRENT_COLONY(res.getString("FL_CURRENT_COLONY"));
                        Student.setFL_ZIP_CODE(res.getString("FL_ZIP_CODE"));
                        Student.setFL_PHONE_HOME(res. getString("FL_PHONE_HOME"));
                        Student.setFL_CELL_PHONE(res.getString("FL_CELL_PHONE"));
                        Student.setFL_MAIL(res.getString("FL_MAIL"));
                        Student.setFL_FACEBOOK(res.getString("FL_FACEBOOK"));
                        Student.setFL_TWITTER(res.getString("FL_TWITTER"));
                        
                        Student.setFL_PATERN_NAME_FATHER(res.getString("FL_PATERN_NAME_FATHER"));
                        Student.setFL_MATERN_NAME_FATHER(res.getString("FL_MATERN_NAME_FATHER"));
                        Student.setFL_NAME_FATHER(res.getString("FL_NAME_FATHER"));
                        Student.setFL_BORN_DATE_FATHER(res.getString("FL_BORN_DATE_FATHER"));
                        Student.setFL_MARITIAL_STATE_FATHER(res.getString("FL_MARITIAL_STATE_FATHER"));
                        Student.setFL_LEVEL_EDUCATION_FATHER(res.getString("FL_LEVEL_EDUCATION_FATHER"));
                        Student.setFL_PATERN_NAME_MOTHER(res.getString("FL_PATERN_NAME_MOTHER"));
                        Student.setFL_MATERN_NAME_MOTHER(res.getString("FL_MATERN_NAME_MOTHER"));
                        Student.setFL_NAME_MOTHER(res.getString("FL_NAME_MOTHER"));
                        Student.setFL_BORN_DATE_MOTHER(res.getString("FL_BORN_DATE_MOTHER"));
                        Student.setFL_MARITIAL_STATE_MOTHER(res.getString("FL_MARITIAL_STATE_MOTHER"));
                        Student.setFL_LEVEL_EDUCATION_MOTHER(res.getString("FL_LEVEL_EDUCATION_MOTHER"));
                        
                        Student.setFL_TUTOR_RELATIONSHIP(res.getString("FL_TUTOR_RELATIONSHIP"));
                        Student.setFL_PATERN_NAME_TUTOR(res.getString("FL_PATERN_NAME_TUTOR"));
                        Student.setFL_MATERN_NAME_TUTOR(res.getString("FL_MATERN_NAME_TUTOR"));
                        Student.setFL_NAME_TUTOR(res.getString("FL_NAME_TUTOR"));
                        Student.setFL_BORN_DATE_TUTOR(res.getString("FL_BORN_DATE_TUTOR"));
                        Student.setFL_GENDER_TUTOR(res.getString("FL_GENDER_TUTOR"));
                        Student.setFL_MARITIAL_STATE_TUTOR(res.getString("FL_MARITIAL_STATE_TUTOR"));
                        Student.setFK_BORN_ENTITY_TUTOR(res.getInt("FK_BORN_ENTITY_TUTOR"));
                        Student.setFK_BORN_MUNICIPALITY_TUTOR(res.getInt("FK_BORN_MUNICIPALITY_TUTOR"));
                        Student.setFK_BORN_LOCALITY_TUTOR(res.getInt("FK_BORN_LOCALITY_TUTOR"));
                        Student.setFL_BETWEEN_STREET1_TUTOR(res.getString("FL_BETWEEN_STREET1_TUTOR"));
                        Student.setFL_OCCUPATION_TUTOR(res.getString("FL_OCCUPATION_TUTOR"));
                        Student.setFL_LEVEL_EDUCATION(res.getString("FL_LEVEL_EDUCATION"));
                        Student.setFL_FILE_ID_OFICIAL_TUTOR(res.getString("FL_FILE_ID_OFICIAL_TUTOR"));
                        Student.setFL_CURP_TUTOR(res.getString("FL_CURP_TUTOR"));
                        Student.setFL_FILE_CURP_TUTOR(res.getString("FL_FILE_CURP_TUTOR"));
                        Student.setFL_STREET_NAME_TUTOR(res.getString("FL_STREET_NAME_TUTOR"));
                        Student.setFL_EXTERNAL_NUMBER_TUTOR(res.getString("FL_EXTERNAL_NUMBER_TUTOR"));
                        Student.setFL_INTERNAL_NUMBER_TUTOR(res.getString("FL_INTERNAL_NUMBER_TUTOR"));
                        Student.setFL_BETWEEN_STREET2_TUTOR(res.getString("FL_BETWEEN_STREET2_TUTOR"));
                        Student.setFL_REFERENCE_TUTOR(res.getString("FL_REFERENCE_TUTOR"));
                        Student.setFK_CURRENT_ENTITY_TUTOR(res.getInt("FK_CURRENT_ENTITY_TUTOR"));
                        Student.setFK_CURRENT_MUNICIPALITY_TUTOR(res.getInt("FK_CURRENT_MUNICIPALITY_TUTOR"));
                        Student.setFK_CURRENT_LOCALITY_TUTOR(res.getInt("FK_CURRENT_LOCALITY_TUTOR"));
                        Student.setFL_COLONY_TUTOR(res.getString("FL_COLONY_TUTOR"));
                        Student.setFL_ZIP_CODE_TUTOR(res.getString("FL_ZIP_CODE_TUTOR"));
                        Student.setFL_PHONE_HOME_TUTOR(res.getString("FL_PHONE_HOME_TUTOR"));
                        Student.setFL_CELL_PHONE_TUTOR(res.getString("FL_CELL_PHONE_TUTOR"));
                        Student.setFL_MAIL_TUTOR(res.getString("FL_MAIL_TUTOR"));
                        Student.setFL_FACEBOOK_TUTOR(res.getString("FL_FACEBOOK_TUTOR"));
                        Student.setFL_TWITTER_TUTOR(res.getString("FL_TWITTER_TUTOR"));
                        Student.setFL_EMERGENCY_PHONE1(res.getString("FL_EMERGENCY_PHONE1"));
                        Student.setFL_EMERGENCY_PHONE2(res.getString("FL_EMERGENCY_PHONE2"));
                        Student.setFL_HOUSE_STATUS(res.getString("FL_HOUSE_STATUS"));
                        Student.setFL_WALL_MATERIAL(res.getString("FL_WALL_MATERIAL"));
                        Student.setFL_ROOF_MATERIAL(res.getString("FL_ROOF_MATERIAL"));
                        Student.setFL_FLOOR_MATERIAL(res.getString("FL_FLOOR_MATERIAL"));
                        Student.setFL_ROOM(res.getString("FL_ROOM"));
                        Student.setFL_DINING_ROOM(res.getString("FL_DINING_ROOM"));
                        Student.setFL_KITCHEN(res.getString("FL_KITCHEN"));
                        Student.setFL_TOILET(res.getString("FL_TOILET"));
                        Student.setFL_TELEVISION(res.getString("FL_TELEVISION"));
                        Student.setFL_STEREO(res.getString("FL_STEREO"));
                        Student.setFL_DVD(res.getString("FL_DVD"));
                        Student.setFL_COMPUTER(res.getString("FL_COMPUTER"));
                        Student.setFL_NUMBER_MEMBERS_FAMLY(res.getString("FL_NUMBER_MEMBERS_FAMLY"));
                        Student.setFL_LAPTOP(res.getString("FL_LAPTOP"));
                        Student.setFL_REFRIGERATOR(res.getString("FL_REFRIGERATOR"));
                        Student.setFL_WASHER(res.getString("FL_WASHER"));
                        Student.setFL_STOVE(res.getString("FL_STOVE"));
                        Student.setFL_FAMILY_MONTHLY_INCOME(res.getInt("FL_FAMILY_MONTHLY_INCOME"));
                        Student.setFL_FAMILY_MONTHLY_DISCHARGE(res.getInt("FL_FAMILY_MONTHLY_DISCHARGE"));
                        Student.setFL_STUDENT_MONTGLY_INCOME(res.getInt("FL_STUDENT_MONTGLY_INCOME"));
                        Student.setFL_STUDENT_MONTGLY_DISCHARGE(res.getInt("FL_STUDENT_MONTGLY_DISCHARGE"));
                        Student.setFL_DIFFUSION_CALL(res.getString("FL_DIFFUSION_CALL"));
                        Student.setFL_DIFFUSION_CARTEL(res.getString("FL_DIFFUSION_CARTEL"));
                        Student.setFL_DIFFUSION_PLANTEL_TALKS(res.getString("FL_DIFFUSION_PLANTEL_TALKS"));
                        Student.setFL_DIFFUSION_PERSONAL_UT(res.getString("FL_DIFFUSION_PERSONAL_UT"));
                        Student.setFL_DIFFUSION_GRADUATES(res.getString("FL_DIFFUSION_GRADUATES"));
                        Student.setFL_DIFFUSION_FAMILY_FRIENDS(res.getString("FL_DIFFUSION_FAMILY_FRIENDS"));
                        Student.setFL_DIFFUSION_DIRECTLT_UT(res.getString("FL_DIFFUSION_DIRECTLT_UT"));
                        Student.setFL_DIFFUSION_BROCHURE(res.getString("FL_DIFFUSION_BROCHURE"));
                        Student.setFL_DIFFUSION_NEWSPAPER(res.getString("FL_DIFFUSION_NEWSPAPER"));
                        Student.setFL_DIFFUSION_STUDENTS_UT(res.getString("FL_DIFFUSION_STUDENTS_UT"));
                        Student.setFL_DIFFUSION_MANTA(res.getString("FL_DIFFUSION_MANTA"));
                        Student.setFL_DIFFUSION_TRIPTYCH(res.getString("FL_DIFFUSION_TRIPTYCH"));
                        Student.setFL_DIFFUSION_GUIDED_VISITS(res.getString("FL_DIFFUSION_GUIDED_VISITS"));
                        Student.setFL_DIFFUSION_EXHIBITIONS(res.getString("FL_DIFFUSION_EXHIBITIONS"));
                        Student.setFL_DIFFUSION_OTHER(res.getString("FL_DIFFUSION_OTHER"));
                        Student.setFL_DIFFUSION_OTHER_NAME(res.getString("FL_DIFFUSION_OTHER_NAME"));
                        Student.setFL_OPTION_UTSEM_STUDY(res.getString("FL_OPTION_UTSEM_STUDY"));
                        Student.setFL_PHYSICAL_DISABILITY(res.getString("FL_PHYSICAL_DISABILITY"));
                        Student.setFL_DISABILITY_NAME(res.getString("FL_DISABILITY_NAME"));
                        Student.setFL_INDIGENOUS_GROUP(res.getString("FL_INDIGENOUS_GROUP"));
                        Student.setFL_INDIGENOUS_GROUP_NAME(res.getString("FL_INDIGENOUS_GROUP_NAME"));
                        Student.setFL_SECUTITY_MEDICAL(res.getString("FL_SECUTITY_MEDICAL"));
                        Student.setFL_SECURITY_NAME(res.getString("FL_SECURITY_NAME"));
                        Student.setFL_NUMBER_SECURITY_MEDICAL(res.getString("FL_NUMBER_SECURITY_MEDICAL"));   
                        
                        Student.setFL_WHOM_DEPEND(res.getString("FL_WHOM_DEPEND"));
                        Student.setFL_DEPEND_ECONOMICALLY_WORK(res.getString("FL_DEPEND_ECONOMICALLY_WORK"));
                        Student.setFL_WHERE_WORK(res.getString("FL_WHERE_WORK"));
                        Student.setFL_WHAT_WORK(res.getString("FL_WHAT_WORK"));
                        
                        Student.setFL_ACEPT_TERM(res.getString("FL_ACEPT_TERM"));
                        list.add(Student);
                    }
                    res.close();
                    ps.close();
                    conn.close();
                }
                return list;
            } catch (SQLException ex) {
                Logger.getLogger(studentModel.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return list;
    }
    public ArrayList<studentModel> SelectEnrollments(){
        ArrayList<studentModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_STUDENTS`('allEnrollment', '')"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    studentModel StudentAll=new studentModel();
                    StudentAll.setFL_ENROLLMENT(res.getString("FL_ENROLLMENT"));
                    list.add(StudentAll);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(studentModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    /*public byte[] SelectFile(String name_field, int pk_student){
        byte[] buffer = null;
        try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("SELECT "+name_field+" FROM tb_students WHERE PK_STUDENT="+pk_student+""); ResultSet res = ps.executeQuery()) {
            while(res!=null&&res.next()){
                Blob bin = res.getBlob(name_field);
                if (bin != null) {
                    InputStream inStream = bin.getBinaryStream();
                    int size = (int) bin.length();
                    buffer = new byte[size];
                    try {
                        inStream.read(buffer, 0, size);
                    } catch (IOException ex) {
                    }
                }
            }
        }catch (SQLException ex) {
           buffer=null;
            //Logger.getLogger(studentModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return buffer;
    }*/
    
    public String InsertStudent(studentModel dataStudent){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_NEW_STUDENT`('insert', '"+dataStudent.getFL_ENROLLMENT()+"', NULL, "+dataStudent.getFK_CAREER()+", '"+dataStudent.getFL_NAME()+"', '"+dataStudent.getFL_MATERN_NAME()+"', '"+dataStudent.getFL_PATERN_NAME()+"', "+dataStudent.getFK_PREPARATORY()+", '"+dataStudent.getFL_BIRTH_CERTIFICATE_NUMBER()+"', '"+dataStudent.getFL_HIGH_SCHOOL_CERTIFICATE()+"')")) {
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
    public String InsertStudentOfPreregister(studentModel dataStudent){
        String request = "";
        String procedure = "CALL `SET_NEW_STUDENT`('insertOfCandidates', '"+dataStudent.getFL_ENROLLMENT()+"', '"+dataStudent.getFL_UTSEM_FOLIO()+"', NULL, NULL, NULL, NULL, NULL, '"+dataStudent.getFL_BIRTH_CERTIFICATE_NUMBER()+"', '"+dataStudent.getFL_HIGH_SCHOOL_CERTIFICATE()+"')";
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    request = (res.getString("FL_STATUS_TRANSACTION"));
                }
                res.close();
                ps.close();
                conn.close();
            }
            return request;
        } catch (SQLException ex) {
            request = ex.getMessage();
        }
        return request;
    }
    public String DeleteStudent(int pkStudent){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("")) {
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
    /*public String UpdateStudentFile(int pk_student, String field_name, FileInputStream file, long sizeFile){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("UPDATE tb_students SET "+field_name+"=? WHERE PK_STUDENT=?")) {
                ps.setBinaryStream(1, file, sizeFile);
                ps.setInt(2, pk_student);
                ps.executeUpdate();
                request="Cargado";
                ps.close();
                conn.close();
            }
        } catch (SQLException e) {
            request=""+e.getMessage();
            e.getMessage();
        }   
        return request;
    }*/
    public String UpdateStudent(int pk_student, String field_name, String field_value){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_STUDENT`('update', '"+pk_student+"', '"+field_name+"', '"+field_value+"')")) {
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
    public String GenerateDownStudent(int pk_student){
        String request;
        String procedure = "CALL `SET_STUDENT_DOWN`('generateDown', "+pk_student+", null, null, null)";
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement(procedure)) {
                ps.executeUpdate();
                request="Baja Generada";
                ps.close();
                conn.close();
            }
        } catch (SQLException e) {
            request=""+e.getMessage();
            e.getMessage();
        }   
        return request;
    }
    public String RemoveDownStudent(int pk_student){
        String request;
        String procedure = "CALL `SET_STUDENT_DOWN`('removeDown', "+pk_student+", null, null, null)";
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement(procedure)) {
                ps.executeUpdate();
                request="Baja Cancelada";
                ps.close();
                conn.close();
            }
        } catch (SQLException e) {
            request=""+e.getMessage();
            e.getMessage();
        }   
        return request;
    }
    public String DetailDownStudent(int pk_student,  int fk_down_detail, String motive, int fk_period){
        String request;
        String procedure = "CALL `SET_STUDENT_DOWN`('generateDown', "+pk_student+", "+fk_down_detail+", "+motive+", "+fk_period+")";
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement(procedure)) {
                ps.executeUpdate();
                request="Detalle Modificado";
                ps.close();
                conn.close();
            }
        } catch (SQLException e) {
            request=""+e.getMessage();
            e.getMessage();
        }   
        return request;
    }
    public String UpdateStudent(studentModel dataStudent){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_NEW_STUDENT`('update', '"+dataStudent.getFL_ENROLLMENT()+"', null, "+dataStudent.getFK_CAREER()+", '"+dataStudent.getFL_NAME()+"', '"+dataStudent.getFL_MATERN_NAME()+"', '"+dataStudent.getFL_PATERN_NAME()+"', "+dataStudent.getFK_PREPARATORY()+", '"+dataStudent.getFL_BIRTH_CERTIFICATE_NUMBER()+"', '"+dataStudent.getFL_HIGH_SCHOOL_CERTIFICATE()+"')")) {
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
    public String GenerateEnrollment(String period){
        String request="";
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("SELECT `GENERATE_ENROLLMENT`('"+period+"') AS new_temp_enrollment"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    request = res.getString("new_temp_enrollment");
                }
                res.close();
                ps.close();
                conn.close();
            }
        } catch (SQLException ex) {
            Logger.getLogger(studentModel.class.getName()).log(Level.SEVERE, null, ex);
        } 
        return request;
    }
    public String StudentActivateAcount(int pk_student, String field_name, String field_value){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_STUDENT`('update', '"+pk_student+"', '"+field_name+"', '"+field_value+"')")) {
                ps.executeUpdate();
                request="Success";
                ps.close();
                conn.close();
            }
        } catch (SQLException e) {
            request=""+e.getMessage();
            e.getMessage();
        }   
        return request;
    }
    public ArrayList<studentModel> SelectUserLogin(studentModel dataUser){
        ArrayList<studentModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_LOGIN`('student','"+dataUser.getFL_ENROLLMENT()+"', '"+dataUser.getFL_PASSWORD()+"')"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    studentModel userLogin=new studentModel();
                    userLogin.setPK_STUDENT(res.getInt("PK_STUDENT"));
                    userLogin.setFL_NAME(res.getString("FL_NAME"));
                    userLogin.setFL_ENROLLMENT(res.getString("FL_ENROLLMENT"));
                    userLogin.setFL_MAIL(res.getString("FL_MAIL"));
                    userLogin.setFL_GENDER(res.getString("FL_GENDER"));
                    userLogin.setFL_NAME_ABBREVIATED(res.getString("FL_DESCRIPTION"));
                    userLogin.setFL_NAME_FATHER(res.getString("FL_NAME_SMALL"));
                    userLogin.setPK_GROUP(res.getInt("PK_GROUP"));
                    userLogin.setFL_NAME_GROUP(res.getString("FL_NAME_GROUP"));
                    userLogin.setFK_LEVEL(res.getInt("FK_LEVEL"));
                    list.add(userLogin);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(studentModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public String SelectUserLoginMail(studentModel dataUser){
        String request="";
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_LOGIN`('studentStatusMailValidate','"+dataUser.getFL_ENROLLMENT()+"', '"+dataUser.getFL_PASSWORD()+"')"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    request=res.getString("FL_MAIL_STATUS_VALIDATE");
                }
                res.close();
                ps.close();
                conn.close();
            }
            return request;
        } catch (SQLException ex) {
            request="fail "+ex;
            Logger.getLogger(studentModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return request;
    }
    public ArrayList<studentModel> SelectRememberPassword(studentModel dataUser){
        ArrayList<studentModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_LOGIN`('rememberPassword', '"+dataUser.getFL_ENROLLMENT()+"', '"+dataUser.getFL_MAIL()+"')"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    studentModel userLogin=new studentModel();
                    userLogin.setFL_NAME(res.getString("FL_NAME"));
                    userLogin.setFL_ENROLLMENT(res.getString("FL_ENROLLMENT"));
                    userLogin.setFL_MAIL(res.getString("FL_MAIL"));
                    userLogin.setFL_PASSWORD(res.getString("FL_PASSWORD"));
                    list.add(userLogin);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(studentModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
}
