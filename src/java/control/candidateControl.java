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
import model.studentModel;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author CARLOS
 */
public class candidateControl {
    public static void main(String[] args) {
        ArrayList<studentModel> list=new candidateControl().SelectCandidate("folioSystem","20160004");
        JSONArray contentRowsCal=new candidateControl().SelectMetadataRows();
        System.err.println(contentRowsCal);
    }
    public ArrayList<propetiesTableModel> SelectReportColums(){
        ArrayList<propetiesTableModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_CANDIDATE`('columsMetadata', '', '', '')"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    propetiesTableModel allData=new propetiesTableModel();
                    allData.setFL_TEXT(res.getString("FL_TEXT"));
                    allData.setFL_TEXT_EXTENDS(res.getString("FL_TEXT_EXTENDS"));
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
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_CANDIDATE`('rowsMetadata', '', '', '')"); ResultSet res = ps.executeQuery()) {
                ResultSetMetaData rsmd = res.getMetaData();
                JSONObject columns;
                while(res!=null&&res.next()){
                    columns = new JSONObject();
                    for(int col=1; col<rsmd.getColumnCount()+1; col++){  
                        columns.put(rsmd.getColumnName(col), res.getString(rsmd.getColumnLabel(col)));
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
    public ArrayList<studentModel> SelectCandidates(){
        ArrayList<studentModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_CANDIDATE`('candidatesPreinscription', '', '', '')"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    studentModel CandidateAll=new studentModel();
                    CandidateAll.setPK_STUDENT(res.getInt("PK_CANDIDATE"));
                    CandidateAll.setFL_UTSEM_FOLIO(res.getString("FL_UTSEM_FOLIO"));
                    CandidateAll.setFL_FOLIO_TEMP_SYSTEM(res.getString("FL_FOLIO_TEMP_SYSTEM"));
                    CandidateAll.setFL_REGISTER_DATE(res.getString("FL_REGISTER_DATE"));
                    CandidateAll.setFL_NAME(res.getString("FL_NAME"));
                    CandidateAll.setFL_NAME_ABBREVIATED(res.getString("FL_NAME_ABBREVIATED"));
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
    public String GenerateFolioUtsem(String period, String type){
        String request="";
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("SELECT `FN_GENERATE_FOLIO_UTSEM`('"+period+"', '"+type+"') AS new_temp_folio_utsem"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    request = res.getString("new_temp_folio_utsem");
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
    public ArrayList<studentModel> SelectFoliosSystem(){
        ArrayList<studentModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_CANDIDATE`('foliosSystem', null, null, null)"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    studentModel CandidateAll=new studentModel();
                    CandidateAll.setFL_FOLIO_TEMP_SYSTEM(res.getString("FL_FOLIO_TEMP_SYSTEM"));
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
    public ArrayList<studentModel> SelectFoliosSystemAll(){
        ArrayList<studentModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_CANDIDATE`('allFoliosSystem', null, null, null)"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    studentModel CandidateAll=new studentModel();
                    CandidateAll.setFL_FOLIO_TEMP_SYSTEM(res.getString("FL_FOLIO_TEMP_SYSTEM"));
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
    public ArrayList<studentModel> SelectFoliosUtsem(){
        ArrayList<studentModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_CANDIDATE`('allFoliosUtsem', null, null, null)"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    studentModel CandidateAll=new studentModel();
                    CandidateAll.setFL_UTSEM_FOLIO(res.getString("FL_UTSEM_FOLIO"));
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
    public ArrayList<studentModel> SelectUserLogin(String userName, String password){
        ArrayList<studentModel> list=new ArrayList<>();
        String procedure = "CALL `GET_CANDIDATE`('login', null, '"+userName+"', '"+password+"')";
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    studentModel userLogin=new studentModel();
                    userLogin.setFL_NAME(res.getString("FL_NAME"));
                    userLogin.setFL_FOLIO_TEMP_SYSTEM(res.getString("FL_FOLIO_TEMP_SYSTEM"));
                    userLogin.setFL_MAIL(res.getString("FL_MAIL"));
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
    public int SelectUserStatusAcount(String userName, String password){
        int status = 0;
        String procedure = "CALL `GET_CANDIDATE`('status', null, '"+userName+"', '"+password+"')";
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    status = (res.getInt("FL_STATUS_ACOUNT"));
                }
                res.close();
                ps.close();
                conn.close();
            }
            return status;
        } catch (SQLException ex) {
            Logger.getLogger(studentModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return status;
    }
    public String ActivateAcount(String userName, String mail, String password){
        String request;
        String procedure = "CALL `SET_CANDITATE_ACTIVATE_ACOUNT`('activateAcount', '"+userName+"', '"+mail+"', '"+password+"')";
       try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement(procedure)) {
                ps.executeUpdate();
                request="Actived";
                ps.close();
                conn.close();
            }
        } catch (SQLException e) {
            request=""+e.getMessage();
            e.getMessage();
        }   
        return request;
    }
    public boolean ValidateUserName(String userName){
        boolean validate = false;
        String procedure = "CALL `GET_CANDIDATE`('validateUserName', null, '"+userName+"', null)";
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                validate = !(res!=null&&res.next());
                res.close();
                ps.close();
                conn.close();
            }
        } catch (SQLException ex) {
            Logger.getLogger(studentModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return validate;
    }
    public boolean ValidateEmail(String email){
        boolean validate = false;
        String procedure = "CALL `GET_CANDIDATE`('validateEmail', null, '"+email+"', null)";
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                validate = !(res!=null&&res.next());
                res.close();
                ps.close();
                conn.close();
            }
        } catch (SQLException ex) {
            Logger.getLogger(studentModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return validate;
    }
    public ArrayList<studentModel> SelectCandidate(String typeFolio, String folio){
        ArrayList<studentModel> list=new ArrayList<>();
        String procedure;
        if(typeFolio.equals("folioSystem")){
           procedure = "CALL `GET_CANDIDATE`('candidateByFolioSystem', '"+folio+"', null, null)";
        }else{
            procedure = "CALL `GET_CANDIDATE`('candidateByFolioUtsem', '"+folio+"', null, null)";
        }
            try {
                try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                    while(res!=null&&res.next()){
                        studentModel Candidate=new studentModel();
                        Candidate.setFL_UTSEM_FOLIO(res.getString("FL_UTSEM_FOLIO"));
                        Candidate.setFK_CAREER(res.getInt("FK_CAREER"));
                        Candidate.setPK_ENTITY(res.getInt("FK_ENTITY"));
                        Candidate.setPK_MUNICIPALITY(res.getInt("FK_MUNICIPALITY"));
                        Candidate.setPK_LOCALITY(res.getInt("FK_LOCALITY"));
                        Candidate.setFK_PREPARATORY(res.getInt("FK_PREPARATORY"));
                        Candidate.setFL_REGISTER_DATE(res.getString("FL_REGISTER_DATE"));
                        Candidate.setFL_NAME(res.getString("FL_NAME"));
                        Candidate.setFL_MATERN_NAME(res.getString("FL_MATERN_NAME"));
                        Candidate.setFL_PATERN_NAME(res.getString("FL_PATERN_NAME"));
                        Candidate.setFL_DATE_BORN(res.getString("FL_DATE_BORN"));
                        Candidate.setFL_GENDER(res.getString("FL_GENDER"));
                        Candidate.setFL_MARITIAL_STATUS(res.getString("FL_MARITIAL_STATUS"));
                        Candidate.setFL_WORKING(res.getString("FL_WORKING"));
                        Candidate.setFL_BACHEROL_TYPE(res.getString("FL_BACHEROL_TYPE"));
                        Candidate.setFL_SCHOOL_TYPE(res.getString("FL_SCHOOL_TYPE"));
                        Candidate.setFL_ABOVE_AVERAGE(res.getDouble("FL_ABOVE_AVERAGE"));
                        Candidate.setFL_PERIOD_BACHEROL(res.getString("FL_PERIOD_BACHEROL"));
                        Candidate.setFL_FILE_ID_OFICIAL(res.getString("FL_FILE_ID_OFICIAL"));
                        Candidate.setFL_FILE_DOCUMENT_BORN(res.getString("FL_FILE_DOCUMENT_BORN"));
                        Candidate.setFL_CURP(res.getString("FL_CURP"));
                        Candidate.setFL_FILE_CURP(res.getString("FL_FILE_CURP"));
                        Candidate.setFK_BORN_ENTITY(res.getInt("FK_BORN_ENTITY"));
                        Candidate.setFK_BORN_MUNICIPALITY(res.getInt("FK_BORN_MUNICIPALITY"));
                        Candidate.setFK_BORN_LOCALITY(res.getInt("FK_BORN_LOCALITY"));
                        Candidate.setFL_NAME_STREET(res.getString("FL_NAME_STREET"));
                        Candidate.setFL_EXTERNAL_NUMBER(res.getString("FL_EXTERNAL_NUMBER"));
                        Candidate.setFL_INTERNAL_NUMBER(res.getString("FL_INTERNAL_NUMBER"));
                        Candidate.setFL_BETWEEN_STREET1(res.getString("FL_BETWEEN_STREET1"));
                        Candidate.setFL_BETWEEN_STREET2(res.getString("FL_BETWEEN_STREET2"));
                        Candidate.setFL_REFERENCE(res.getString("FL_REFERENCE"));
                        Candidate.setFK_CURRENT_ENTITY(res.getString("FK_CURRENT_ENTITY"));
                        Candidate.setFK_CURRENT_MUNICIPALITY(res.getString("FK_CURRENT_MUNICIPALITY"));
                        Candidate.setFK_CURRENT_LOCALITY(res.getString("FK_CURRENT_LOCALITY"));
                        Candidate.setFL_CURRENT_COLONY(res.getString("FL_CURRENT_COLONY"));
                        Candidate.setFL_ZIP_CODE(res.getString("FL_ZIP_CODE"));
                        Candidate.setFL_PHONE_HOME(res. getString("FL_PHONE_HOME"));
                        Candidate.setFL_CELL_PHONE(res.getString("FL_CELL_PHONE"));
                        Candidate.setFL_MAIL(res.getString("FL_MAIL"));
                        Candidate.setFL_FACEBOOK(res.getString("FL_FACEBOOK"));
                        Candidate.setFL_TWITTER(res.getString("FL_TWITTER"));
                        
                        Candidate.setFL_PATERN_NAME_FATHER(res.getString("FL_PATERN_NAME_FATHER"));
                        Candidate.setFL_MATERN_NAME_FATHER(res.getString("FL_MATERN_NAME_FATHER"));
                        Candidate.setFL_NAME_FATHER(res.getString("FL_NAME_FATHER"));
                        Candidate.setFL_BORN_DATE_FATHER(res.getString("FL_BORN_DATE_FATHER"));
                        Candidate.setFL_MARITIAL_STATE_FATHER(res.getString("FL_MARITIAL_STATE_FATHER"));
                        Candidate.setFL_LEVEL_EDUCATION_FATHER(res.getString("FL_LEVEL_EDUCATION_FATHER"));
                        Candidate.setFL_PATERN_NAME_MOTHER(res.getString("FL_PATERN_NAME_MOTHER"));
                        Candidate.setFL_MATERN_NAME_MOTHER(res.getString("FL_MATERN_NAME_MOTHER"));
                        Candidate.setFL_NAME_MOTHER(res.getString("FL_NAME_MOTHER"));
                        Candidate.setFL_BORN_DATE_MOTHER(res.getString("FL_BORN_DATE_MOTHER"));
                        Candidate.setFL_MARITIAL_STATE_MOTHER(res.getString("FL_MARITIAL_STATE_MOTHER"));
                        Candidate.setFL_LEVEL_EDUCATION_MOTHER(res.getString("FL_LEVEL_EDUCATION_MOTHER"));
                        
                        Candidate.setFL_TUTOR_RELATIONSHIP(res.getString("FL_TUTOR_RELATIONSHIP"));
                        Candidate.setFL_PATERN_NAME_TUTOR(res.getString("FL_PATERN_NAME_TUTOR"));
                        Candidate.setFL_MATERN_NAME_TUTOR(res.getString("FL_MATERN_NAME_TUTOR"));
                        Candidate.setFL_NAME_TUTOR(res.getString("FL_NAME_TUTOR"));
                        Candidate.setFL_BORN_DATE_TUTOR(res.getString("FL_BORN_DATE_TUTOR"));
                        Candidate.setFL_GENDER_TUTOR(res.getString("FL_GENDER_TUTOR"));
                        Candidate.setFL_MARITIAL_STATE_TUTOR(res.getString("FL_MARITIAL_STATE_TUTOR"));
                        Candidate.setFK_BORN_ENTITY_TUTOR(res.getInt("FK_BORN_ENTITY_TUTOR"));
                        Candidate.setFK_BORN_MUNICIPALITY_TUTOR(res.getInt("FK_BORN_MUNICIPALITY_TUTOR"));
                        Candidate.setFK_BORN_LOCALITY_TUTOR(res.getInt("FK_BORN_LOCALITY_TUTOR"));
                        Candidate.setFL_BETWEEN_STREET1_TUTOR(res.getString("FL_BETWEEN_STREET1_TUTOR"));
                        Candidate.setFL_OCCUPATION_TUTOR(res.getString("FL_OCCUPATION_TUTOR"));
                        Candidate.setFL_LEVEL_EDUCATION(res.getString("FL_LEVEL_EDUCATION"));
                        Candidate.setFL_FILE_ID_OFICIAL_TUTOR(res.getString("FL_FILE_ID_OFICIAL_TUTOR"));
                        Candidate.setFL_CURP_TUTOR(res.getString("FL_CURP_TUTOR"));
                        Candidate.setFL_FILE_CURP_TUTOR(res.getString("FL_FILE_CURP_TUTOR"));
                        Candidate.setFL_STREET_NAME_TUTOR(res.getString("FL_STREET_NAME_TUTOR"));
                        Candidate.setFL_EXTERNAL_NUMBER_TUTOR(res.getString("FL_EXTERNAL_NUMBER_TUTOR"));
                        Candidate.setFL_INTERNAL_NUMBER_TUTOR(res.getString("FL_INTERNAL_NUMBER_TUTOR"));
                        Candidate.setFL_BETWEEN_STREET2_TUTOR(res.getString("FL_BETWEEN_STREET2_TUTOR"));
                        Candidate.setFL_REFERENCE_TUTOR(res.getString("FL_REFERENCE_TUTOR"));
                        Candidate.setFK_CURRENT_ENTITY_TUTOR(res.getInt("FK_CURRENT_ENTITY_TUTOR"));
                        Candidate.setFK_CURRENT_MUNICIPALITY_TUTOR(res.getInt("FK_CURRENT_MUNICIPALITY_TUTOR"));
                        Candidate.setFK_CURRENT_LOCALITY_TUTOR(res.getInt("FK_CURRENT_LOCALITY_TUTOR"));
                        Candidate.setFL_COLONY_TUTOR(res.getString("FL_COLONY_TUTOR"));
                        Candidate.setFL_ZIP_CODE_TUTOR(res.getString("FL_ZIP_CODE_TUTOR"));
                        Candidate.setFL_PHONE_HOME_TUTOR(res.getString("FL_PHONE_HOME_TUTOR"));
                        Candidate.setFL_CELL_PHONE_TUTOR(res.getString("FL_CELL_PHONE_TUTOR"));
                        Candidate.setFL_MAIL_TUTOR(res.getString("FL_MAIL_TUTOR"));
                        Candidate.setFL_FACEBOOK_TUTOR(res.getString("FL_FACEBOOK_TUTOR"));
                        Candidate.setFL_TWITTER_TUTOR(res.getString("FL_TWITTER_TUTOR"));
                        Candidate.setFL_EMERGENCY_PHONE1(res.getString("FL_EMERGENCY_PHONE1"));
                        Candidate.setFL_EMERGENCY_PHONE2(res.getString("FL_EMERGENCY_PHONE2"));
                        Candidate.setFL_HOUSE_STATUS(res.getString("FL_HOUSE_STATUS"));
                        Candidate.setFL_WALL_MATERIAL(res.getString("FL_WALL_MATERIAL"));
                        Candidate.setFL_ROOF_MATERIAL(res.getString("FL_ROOF_MATERIAL"));
                        Candidate.setFL_FLOOR_MATERIAL(res.getString("FL_FLOOR_MATERIAL"));
                        Candidate.setFL_ROOM(res.getString("FL_ROOM"));
                        Candidate.setFL_DINING_ROOM(res.getString("FL_DINING_ROOM"));
                        Candidate.setFL_KITCHEN(res.getString("FL_KITCHEN"));
                        Candidate.setFL_TOILET(res.getString("FL_TOILET"));
                        Candidate.setFL_TELEVISION(res.getString("FL_TELEVISION"));
                        Candidate.setFL_STEREO(res.getString("FL_STEREO"));
                        Candidate.setFL_DVD(res.getString("FL_DVD"));
                        Candidate.setFL_COMPUTER(res.getString("FL_COMPUTER"));
                        Candidate.setFL_NUMBER_MEMBERS_FAMLY(res.getString("FL_NUMBER_MEMBERS_FAMLY"));
                        Candidate.setFL_LAPTOP(res.getString("FL_LAPTOP"));
                        Candidate.setFL_REFRIGERATOR(res.getString("FL_REFRIGERATOR"));
                        Candidate.setFL_WASHER(res.getString("FL_WASHER"));
                        Candidate.setFL_STOVE(res.getString("FL_STOVE"));
                        Candidate.setFL_FAMILY_MONTHLY_INCOME(res.getInt("FL_FAMILY_MONTHLY_INCOME"));
                        Candidate.setFL_FAMILY_MONTHLY_DISCHARGE(res.getInt("FL_FAMILY_MONTHLY_DISCHARGE"));
                        Candidate.setFL_STUDENT_MONTGLY_INCOME(res.getInt("FL_STUDENT_MONTGLY_INCOME"));
                        Candidate.setFL_STUDENT_MONTGLY_DISCHARGE(res.getInt("FL_STUDENT_MONTGLY_DISCHARGE"));
                        Candidate.setFL_DIFFUSION_CALL(res.getString("FL_DIFFUSION_CALL"));
                        Candidate.setFL_DIFFUSION_CARTEL(res.getString("FL_DIFFUSION_CARTEL"));
                        Candidate.setFL_DIFFUSION_PLANTEL_TALKS(res.getString("FL_DIFFUSION_PLANTEL_TALKS"));
                        Candidate.setFL_DIFFUSION_PERSONAL_UT(res.getString("FL_DIFFUSION_PERSONAL_UT"));
                        Candidate.setFL_DIFFUSION_GRADUATES(res.getString("FL_DIFFUSION_GRADUATES"));
                        Candidate.setFL_DIFFUSION_FAMILY_FRIENDS(res.getString("FL_DIFFUSION_FAMILY_FRIENDS"));
                        Candidate.setFL_DIFFUSION_DIRECTLT_UT(res.getString("FL_DIFFUSION_DIRECTLT_UT"));
                        Candidate.setFL_DIFFUSION_BROCHURE(res.getString("FL_DIFFUSION_BROCHURE"));
                        Candidate.setFL_DIFFUSION_NEWSPAPER(res.getString("FL_DIFFUSION_NEWSPAPER"));
                        Candidate.setFL_DIFFUSION_STUDENTS_UT(res.getString("FL_DIFFUSION_STUDENTS_UT"));
                        Candidate.setFL_DIFFUSION_MANTA(res.getString("FL_DIFFUSION_MANTA"));
                        Candidate.setFL_DIFFUSION_TRIPTYCH(res.getString("FL_DIFFUSION_TRIPTYCH"));
                        Candidate.setFL_DIFFUSION_GUIDED_VISITS(res.getString("FL_DIFFUSION_GUIDED_VISITS"));
                        Candidate.setFL_DIFFUSION_EXHIBITIONS(res.getString("FL_DIFFUSION_EXHIBITIONS"));
                        Candidate.setFL_DIFFUSION_OTHER(res.getString("FL_DIFFUSION_OTHER"));
                        Candidate.setFL_DIFFUSION_OTHER_NAME(res.getString("FL_DIFFUSION_OTHER_NAME"));
                        Candidate.setFL_OPTION_UTSEM_STUDY(res.getString("FL_OPTION_UTSEM_STUDY"));
                        Candidate.setFL_PHYSICAL_DISABILITY(res.getString("FL_PHYSICAL_DISABILITY"));
                        Candidate.setFL_DISABILITY_NAME(res.getString("FL_DISABILITY_NAME"));
                        Candidate.setFL_INDIGENOUS_GROUP(res.getString("FL_INDIGENOUS_GROUP"));
                        Candidate.setFL_INDIGENOUS_GROUP_NAME(res.getString("FL_INDIGENOUS_GROUP_NAME"));
                        Candidate.setFL_SECUTITY_MEDICAL(res.getString("FL_SECUTITY_MEDICAL"));
                        Candidate.setFL_SECURITY_NAME(res.getString("FL_SECURITY_NAME"));
                        Candidate.setFL_NUMBER_SECURITY_MEDICAL(res.getString("FL_NUMBER_SECURITY_MEDICAL"));   
                        
                        Candidate.setFL_WHOM_DEPEND(res.getString("FL_WHOM_DEPEND"));
                        Candidate.setFL_DEPEND_ECONOMICALLY_WORK(res.getString("FL_DEPEND_ECONOMICALLY_WORK"));
                        Candidate.setFL_WHERE_WORK(res.getString("FL_WHERE_WORK"));
                        Candidate.setFL_WHAT_WORK(res.getString("FL_WHAT_WORK"));
                        
                        Candidate.setFL_ACEPT_TERM(res.getString("FL_ACEPT_TERM"));
                        list.add(Candidate);
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
    public String InsertCandidate(String userName, String email, String password){
        String request = null;
        String procedure="CALL `SET_NEW_CANDIDATE`('generateCandidate', '"+userName+"', '"+email+"', '"+password+"')";
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    request=res.getString("FL_FOLIO_TEMP_SYSTEM");
                }
                res.close();
                ps.close();
                conn.close();
            }
        } catch (SQLException e) {
            request="error"+e;
            e.getMessage();
        }   
        return request;
    }
    public String UpdateCandidate(String folioTemp, String field_name, String field_value){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_CANDIDATE`('update', '"+folioTemp+"', '"+field_name+"', '"+field_value+"')")) {
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
    public String Preregister(String folioTemp, String folioUtsem, String period){
        String request;
        String procedure, procedure1, procedure2;
        procedure="CALL `SET_CANDIDATE`('update', '"+folioTemp+"', 'FL_PREREGISTER', '1')";
        procedure1="CALL `SET_CANDIDATE`('update', '"+folioTemp+"', 'FL_UTSEM_FOLIO', '"+folioUtsem+"')";
        procedure2="CALL `SET_CANDIDATE`('update', '"+folioTemp+"', 'FK_PERIOD_INSCRIPTION', '"+period+"')";
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement(procedure1)) {
                ps.executeUpdate();
                ps.close();
            }
            try (PreparedStatement ps = conn.prepareStatement(procedure2)) {
                ps.executeUpdate();
                ps.close();
            }
            try (PreparedStatement ps = conn.prepareStatement(procedure)) {
                ps.executeUpdate();
                ps.close();
            }
            conn.close();
            request="Datos Modificados";
        } catch (SQLException e) {
            request=""+e.getMessage();
            e.getMessage();
        }   
        return request;
    }
}
