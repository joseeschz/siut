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
import model.activitiesByStudentsModel;

/**
 *
 * @author Carlos
 */
public class activitiesByStudentsControl {
    public static void main(String[] args) throws InterruptedException {
        ArrayList<activitiesByStudentsModel> list=new activitiesByStudentsControl().SelectListActivitiesByStudent(3064, 333, 3, 13);
        for(int i=0;i<list.size();i++){
            System.out.println(Double.parseDouble(list.get(i).getFL_NAME_ACTIVITY()));
            
        }
//        System.out.print(new activitiesByStudentsControl().UpdateActivitiesByStudents(1, 0));
        
        
        //new activitiesByStudentsControl().SelectWorkPlanning();
    }
    static double getDecimal(int numeroDecimales,double decimal){
        decimal = decimal*(java.lang.Math.pow(10, numeroDecimales));
        decimal = java.lang.Math.round(decimal);
        decimal = decimal/java.lang.Math.pow(10, numeroDecimales);
        return decimal;  
    }
    public ArrayList<activitiesByStudentsModel> SelectActivitiesByStudents(int pkCareer, int pkSemester, int pkGroup, int pkMatter, int pkActivity, int pkPeriod){
        ArrayList<activitiesByStudentsModel> list=new ArrayList<>();
        try {
            try (Connection conn = new connectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_ACTIVITIES_CAL_BY_STUDENTS`('allFilter', "+pkCareer+", "+pkSemester+", "+pkGroup+", "+pkMatter+", "+pkActivity+" ,"+pkPeriod+")"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){                    
                    activitiesByStudentsModel listActivitiesByStudents=new activitiesByStudentsModel();
                    
                    listActivitiesByStudents.setPK_ACTIVITY_BY_STUDENT(res.getString("PK_ACTIVITY_BY_STUDENT"));
                    listActivitiesByStudents.setFL_REALIZED(res.getInt("FL_REALIZED"));
                    listActivitiesByStudents.setFK_STUDENT(res.getInt("PK_STUDENT"));
                    listActivitiesByStudents.setFL_ENROLLMENT(res.getString("FL_ENROLLMENT"));
                    listActivitiesByStudents.setFL_NAME_STUDENT(res.getString("FL_NAME_STUDENT"));
                    listActivitiesByStudents.setFL_VALUE_OBTANIED(res.getString("FL_VALUE_OBTANIED"));
                    listActivitiesByStudents.setFL_VALUE_OBTANIED_EQUIVALENT(res.getString("FL_VALUE_OBTANIED_EQUIVALENT"));
                    listActivitiesByStudents.setFL_ACUMULATED_NOW(res.getString("FL_ACUMULATED_NOW"));
                    list.add(listActivitiesByStudents);
                    
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(activitiesByStudentsModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<activitiesByStudentsModel> SelectAnyActivityEvaluated(int pkCareer, int pkSemester, int pkGroup, int pkMatter, int pkActivity, int pkPeriod){
        ArrayList<activitiesByStudentsModel> list=new ArrayList<>();
        try {
            try (Connection conn = new connectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_ACTIVITIES_CAL_BY_STUDENTS`('statusAnyEvaluated', "+pkCareer+", "+pkSemester+", "+pkGroup+", "+pkMatter+", "+pkActivity+" ,"+pkPeriod+")"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    activitiesByStudentsModel listActivitiesByStudents=new activitiesByStudentsModel();
                    listActivitiesByStudents.setFL_REALIZED(res.getInt("FL_REALIZED"));
                    list.add(listActivitiesByStudents);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(activitiesByStudentsModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<activitiesByStudentsModel> SelectActivitiesByStudentsRegularization(int pkCareer, int pkSemester, int pkGroup, int pkMatter, int pkPeriod){
        ArrayList<activitiesByStudentsModel> list=new ArrayList<>();
        try {
            try (Connection conn = new connectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_ACTIVITIES_CAL_BY_STUDENTS`('allFilterRegularization', "+pkCareer+", "+pkSemester+", "+pkGroup+", "+pkMatter+", null, "+pkPeriod+")"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    activitiesByStudentsModel listActivitiesByStudents=new activitiesByStudentsModel();
                    listActivitiesByStudents.setPK_CALIFICATIONS_OF_STUDEN_BY_MATTER(res.getString("PK_CALIFICATIONS_OF_STUDEN_BY_MATTER"));
                    listActivitiesByStudents.setFK_STUDENT(res.getInt("PK_STUDENT"));
                    listActivitiesByStudents.setFL_ENROLLMENT(res.getString("FL_ENROLLMENT"));
                    listActivitiesByStudents.setFL_NAME_STUDENT(res.getString("FL_NAME_STUDENT"));
                    listActivitiesByStudents.setFL_VALUE_OBTANIED_ACUMULATED_BE(res.getString("FL_VALUE_OBTANIED_ACUMULATED_BE"));
                    listActivitiesByStudents.setFL_VALUE_OBTANIED_ACUMULATED_KNOW(res.getString("FL_VALUE_OBTANIED_ACUMULATED_KNOW"));
                    listActivitiesByStudents.setFL_VALUE_OBTANIED_ACUMULATED_DO(res.getString("FL_VALUE_OBTANIED_ACUMULATED_DO"));
                    listActivitiesByStudents.setFL_VALUE_OBTANIED_ACUMULATED_TOTAL(res.getString("FL_VALUE_OBTANIED_ACUMULATED_TOTAL"));
                    listActivitiesByStudents.setFL_VALUE_OBTANIED_REGULARIZATION_BE(res.getString("FL_VALUE_OBTANIED_REGULARIZATION_BE"));
                    listActivitiesByStudents.setFL_VALUE_OBTANIED_REGULARIZATION_KNOW(res.getString("FL_VALUE_OBTANIED_REGULARIZATION_KNOW"));
                    listActivitiesByStudents.setFL_VALUE_OBTANIED_REGULARIZATION_DO(res.getString("FL_VALUE_OBTANIED_REGULARIZATION_DO"));
                    listActivitiesByStudents.setFL_VALUE_OBTANIED_REGULARIZATION_TOTAL(res.getString("FL_VALUE_OBTANIED_REGULARIZATION_TOTAL"));
                    list.add(listActivitiesByStudents);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(activitiesByStudentsModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<activitiesByStudentsModel> SelectActivitiesByStudentsGlobal(int pkCareer, int pkSemester, int pkGroup, int pkMatter, int pkPeriod){
        ArrayList<activitiesByStudentsModel> list=new ArrayList<>();
        try {
            try (Connection conn = new connectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_ACTIVITIES_CAL_BY_STUDENTS`('allFilterGlobal', "+pkCareer+", "+pkSemester+", "+pkGroup+", "+pkMatter+", null, "+pkPeriod+")"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    activitiesByStudentsModel listActivitiesByStudents=new activitiesByStudentsModel();
                    listActivitiesByStudents.setPK_CALIFICATIONS_OF_STUDEN_BY_MATTER(res.getString("PK_CALIFICATIONS_OF_STUDEN_BY_MATTER"));
                    listActivitiesByStudents.setFK_STUDENT(res.getInt("PK_STUDENT"));
                    listActivitiesByStudents.setFL_ENROLLMENT(res.getString("FL_ENROLLMENT"));
                    listActivitiesByStudents.setFL_NAME_STUDENT(res.getString("FL_NAME_STUDENT"));
                    listActivitiesByStudents.setFL_VALUE_OBTANIED_ACUMULATED_BE(res.getString("FL_VALUE_OBTANIED_ACUMULATED_BE"));
                    listActivitiesByStudents.setFL_VALUE_OBTANIED_ACUMULATED_KNOW(res.getString("FL_VALUE_OBTANIED_ACUMULATED_KNOW"));
                    listActivitiesByStudents.setFL_VALUE_OBTANIED_ACUMULATED_DO(res.getString("FL_VALUE_OBTANIED_ACUMULATED_DO"));
                    listActivitiesByStudents.setFL_VALUE_OBTANIED_ACUMULATED_TOTAL(res.getString("FL_VALUE_OBTANIED_ACUMULATED_TOTAL"));
                    
                    listActivitiesByStudents.setFL_VALUE_OBTANIED_REGULARIZATION_BE(res.getString("FL_VALUE_OBTANIED_REGULARIZATION_BE"));
                    listActivitiesByStudents.setFL_VALUE_OBTANIED_REGULARIZATION_KNOW(res.getString("FL_VALUE_OBTANIED_REGULARIZATION_KNOW"));
                    listActivitiesByStudents.setFL_VALUE_OBTANIED_REGULARIZATION_DO(res.getString("FL_VALUE_OBTANIED_REGULARIZATION_DO"));
                    listActivitiesByStudents.setFL_VALUE_OBTANIED_REGULARIZATION_TOTAL(res.getString("FL_VALUE_OBTANIED_REGULARIZATION_TOTAL"));
                    
                    listActivitiesByStudents.setFL_VALUE_OBTANIED_GLOBAL_BE(res.getString("FL_VALUE_OBTANIED_GLOBAL_BE"));
                    listActivitiesByStudents.setFL_VALUE_OBTANIED_GLOBAL_KNOW(res.getString("FL_VALUE_OBTANIED_GLOBAL_KNOW"));
                    listActivitiesByStudents.setFL_VALUE_OBTANIED_GLOBAL_DO(res.getString("FL_VALUE_OBTANIED_GLOBAL_DO"));
                    listActivitiesByStudents.setFL_VALUE_OBTANIED_GLOBAL_TOTAL(res.getString("FL_VALUE_OBTANIED_GLOBAL_TOTAL"));
                    
                    listActivitiesByStudents.setFL_PERMIT_GLOBAL(res.getString("FL_PERMIT_GLOBAL"));
                    
                    
                    list.add(listActivitiesByStudents);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(activitiesByStudentsModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<activitiesByStudentsModel> SelectListActivitiesByStudents(int pkStudent,int pkMatter, int pkScale, int pkPeriod){
        ArrayList<activitiesByStudentsModel> list=new ArrayList<>();
        try {
            try (Connection conn = new connectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_CALIFICATIONS_BY_STUDENTS`('byMatter', "+pkStudent+","+pkMatter+" ,"+pkScale+", null)"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    activitiesByStudentsModel listActivitiesByStudents=new activitiesByStudentsModel();
                    listActivitiesByStudents.setFK_SCALE_EVALUATION(res.getInt("PK_SCALE_EVALUATION"));
                    listActivitiesByStudents.setFL_NAME_SCALE(res.getString("FL_NAME_SCALE"));
                    listActivitiesByStudents.setPK_ACTIVITY(res.getString("PK_ACTIVITY"));
                    listActivitiesByStudents.setFL_NAME_ACTIVITY(res.getString("FL_NAME_ACTIVITY"));
                    listActivitiesByStudents.setPK_ACTIVITY_BY_STUDENT(res.getString("PK_ACTIVITY_BY_STUDENT"));
                    listActivitiesByStudents.setFL_VALUE_OBTANIED(res.getString("FL_VALUE_OBTANIED"));
                    listActivitiesByStudents.setFL_VALUE_ACTIVITY(res.getString("FL_VALUE_ACTIVITY"));
                    list.add(listActivitiesByStudents);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(activitiesByStudentsModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<activitiesByStudentsModel> SelectListActivitiesByStudent(int pkStudent,int pkMatter, int pkScale, int pkPeriod){
        ArrayList<activitiesByStudentsModel> list=new ArrayList<>();
        try {
            try (Connection conn = new connectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_CALIFICATIONS_BY_STUDENTS`('byMatterByStudent', "+pkStudent+","+pkMatter+" ,"+pkScale+", null)"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    if(res.getString("FL_VALUE_OBTANIED")!=null){                        
                        activitiesByStudentsModel listActivitiesByStudents=new activitiesByStudentsModel();
                        listActivitiesByStudents.setFK_SCALE_EVALUATION(res.getInt("PK_SCALE_EVALUATION"));
                        listActivitiesByStudents.setFL_NAME_SCALE(res.getString("FL_NAME_SCALE"));
                        listActivitiesByStudents.setPK_ACTIVITY(res.getString("PK_ACTIVITY"));
                        listActivitiesByStudents.setFL_NAME_ACTIVITY(res.getString("FL_NAME_ACTIVITY"));
                        listActivitiesByStudents.setPK_ACTIVITY_BY_STUDENT(res.getString("PK_ACTIVITY_BY_STUDENT"));
                        listActivitiesByStudents.setFL_VALUE_OBTANIED(res.getString("FL_VALUE_OBTANIED"));
                        listActivitiesByStudents.setFL_VALUE_OBTANIED_EQUIVALENT(res.getString("FL_VALUE_OBTANIED_EQUIVALENT"));
                        listActivitiesByStudents.setFL_VALUE_ACTIVITY(res.getString("FL_VALUE_ACTIVITY"));
                        listActivitiesByStudents.setFL_MAX_VALUE(res.getDouble("FL_MAX_VALUE"));  
                        list.add(listActivitiesByStudents);
                    }
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(activitiesByStudentsModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public String InsertActivitiesByStudent(int pkStudent, int pkCareer, int pkSemester, int pkGroup, int pkMatter, int pkActivity, double valueOptanied, double valueOptaniedEquivalent, int pkPeriod){
        String request;
        try {
            Connection conn=new connectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_ACTIVITIES_CAL_BY_STUDENTS`('insertByStudent', "+pkStudent+", "+pkCareer+", "+pkSemester+", "+pkGroup+", "+pkMatter+", "+pkPeriod+", "+pkActivity+", "+valueOptanied+", '"+valueOptaniedEquivalent+"')")) {
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
    public String InsertActivitiesByStudents(int pt_value, int pkCareer, int pkSemester, int pkGroup, int pkMatter, int pkActivity, int pkPeriod){
        String request;
        try {
            Connection conn=new connectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_ACTIVITIES_CAL_BY_STUDENTS`('insert', null, "+pkCareer+", "+pkSemester+", "+pkGroup+", "+pkMatter+", "+pkPeriod+", "+pkActivity+", "+pt_value+", null)")) {
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
    public String UpdateActivitiesByStudents(int updateType, int pkActivityByStudent, double valueOptanied , double valueOptaniedEquivalent){
        String request;
        try {
            Connection conn=new connectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_ACTIVITIES_CAL_BY_STUDENTS`('update"+updateType+"', "+pkActivityByStudent+", null, null, null, null, null, null, '"+valueOptanied+"', '"+valueOptaniedEquivalent+"')")) {
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
    public String DeleteActivitiesByStudents(int pkGroup, int pkActivity, int pkPeriod){
        String request;
        try {
            Connection conn=new connectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_ACTIVITIES_CAL_BY_STUDENTS`('delete', null, null, null, "+pkGroup+", null, "+pkPeriod+", "+pkActivity+", null, null)")) {
                ps.executeUpdate();
                request="Datos Borrados";
                ps.close();
                conn.close();
            }
        } catch (SQLException e) {
            request=""+e.getMessage();
            e.getMessage();
        }   
        return request;
    }
    public ArrayList<activitiesByStudentsModel> SelectWorkPlanning() throws InterruptedException{
        ArrayList<activitiesByStudentsModel> list=new ArrayList<>();
        try {
            try (Connection conn = new connectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("SELECT PK_WORK_PLANNING FROM tb_work_planning WHERE FL_DELETED=0"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    System.out.println(res.getInt("PK_WORK_PLANNING"));
                    Thread.sleep(1000);
                    new activitiesByStudentsControl().WorkPlanning(res.getInt("PK_WORK_PLANNING"));
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(activitiesByStudentsModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public String WorkPlanning(int pkWorkPlanning) throws InterruptedException{
        String request = null;
        try {
            try (Connection conn = new connectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("SELECT FN_NUM_ACTIVITIES("+pkWorkPlanning+") AS FL_RESULT"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    Thread.sleep(1000);
                    System.out.println(res.getInt("FL_RESULT"));
                }
                res.close();
                ps.close();
                conn.close();
            }
        } catch (SQLException ex) {
            Logger.getLogger(activitiesByStudentsModel.class.getName()).log(Level.SEVERE, null, ex);
        }  
        return request;
    }
}
