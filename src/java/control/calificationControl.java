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
import model.calificationModel;
import model.propetiesTableModel;

/**
 *
 * @author CARLOS
 */
public class calificationControl {
    public static void main(String[] args) {
        /*ArrayList<propetiesTableModel> listStudents=new calificationControl().SelectCalificationNowTutoringColumns(11, 82, 5);
        for(int i=0;i<listStudents.size();i++){
            System.out.println(listStudents.get(i).getFL_TEXT());
            
        }*/
        ArrayList<calificationModel> listStudents2=new calificationControl().SelectCalificationNow(61, 366, 9);
        for(int i=0;i<listStudents2.size();i++){
            System.out.println(listStudents2.get(i).getFL_NAME());
        }
        //System.out.println(new calificationControl().IsCloseWorkPlanningByGroupMatter(1, 366, 61, 9));
    }
    public ArrayList<calificationModel> SelectCalificationNow(int  pkGroup, int pkMatter, int pkPeriod){
        ArrayList<calificationModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_CALIFICATIONS_BY_TEACHER`('byMatter', null, "+pkGroup+", "+pkMatter+", "+pkPeriod+")"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    calificationModel allData=new calificationModel();
                    allData.setFK_STUDENT(res.getInt("PK_STUDENT"));
                    allData.setFL_ENROLLMENT(res.getString("FL_ENROLLMENT"));
                    allData.setFL_NAME(res.getString("FL_NAME"));
                    allData.setFL_CALIFICATION_BE(res.getString("FL_CALIFICATION_BE"));
                    allData.setFL_CALIFICATION_KNOW(res.getString("FL_CALIFICATION_KNOW"));
                    allData.setFL_CALIFICATION_DO(res.getString("FL_CALIFICATION_DO"));
                    allData.setFL_AVG(res.getString("FL_CALIFICATION_TOTAL"));
                    list.add(allData);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(calificationModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<calificationModel> SelectCalificationRecordsAverage(int  pkGroup, int pkMatter, int pkPeriod){
        ArrayList<calificationModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_CALIFICATIONS_BY_TEACHER`('byMatterRecordsCalifications', null, "+pkGroup+", "+pkMatter+", "+pkPeriod+")"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    calificationModel allData=new calificationModel();
                    allData.setFK_STUDENT(res.getInt("PK_STUDENT"));
                    allData.setFL_ENROLLMENT(res.getString("FL_ENROLLMENT"));
                    allData.setFL_NAME(res.getString("FL_NAME"));
                    allData.setFL_CALIFICATION_BE(res.getString("FL_CALIFICATION_BE"));
                    allData.setFL_CALIFICATION_KNOW(res.getString("FL_CALIFICATION_KNOW"));
                    allData.setFL_CALIFICATION_DO(res.getString("FL_CALIFICATION_DO"));
                    allData.setFL_LETTER(res.getString("FL_LETTER"));
                    allData.setFL_AVG(res.getString("FL_CALIFICATION_TOTAL"));
                    list.add(allData);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(calificationModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<calificationModel> SelectCalificationRecordsRegularization(int  pkGroup, int pkMatter, int pkPeriod){
        ArrayList<calificationModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_CALIFICATIONS_BY_TEACHER`('byMatterRecordsCalificationsRegularization', null, "+pkGroup+", "+pkMatter+", "+pkPeriod+")"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    calificationModel allData=new calificationModel();
                    allData.setFK_STUDENT(res.getInt("PK_STUDENT"));
                    allData.setFL_ENROLLMENT(res.getString("FL_ENROLLMENT"));
                    allData.setFL_NAME(res.getString("FL_NAME"));
                    allData.setFL_CALIFICATION_BE(res.getString("FL_CALIFICATION_BE"));
                    allData.setFL_CALIFICATION_KNOW(res.getString("FL_CALIFICATION_KNOW"));
                    allData.setFL_CALIFICATION_DO(res.getString("FL_CALIFICATION_DO"));
                    allData.setFL_LETTER(res.getString("FL_LETTER"));
                    allData.setFL_AVG(res.getString("FL_CALIFICATION_TOTAL"));
                    list.add(allData);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(calificationModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<calificationModel> SelectCalificationRecordsGlobal(int  pkGroup, int pkMatter, int pkPeriod){
        ArrayList<calificationModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_CALIFICATIONS_BY_TEACHER`('byMatterRecordsCalificationsGlobal', null, "+pkGroup+", "+pkMatter+", "+pkPeriod+")"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    calificationModel allData=new calificationModel();
                    allData.setFK_STUDENT(res.getInt("PK_STUDENT"));
                    allData.setFL_ENROLLMENT(res.getString("FL_ENROLLMENT"));
                    allData.setFL_NAME(res.getString("FL_NAME"));
                    allData.setFL_CALIFICATION_BE(res.getString("FL_CALIFICATION_BE"));
                    allData.setFL_CALIFICATION_KNOW(res.getString("FL_CALIFICATION_KNOW"));
                    allData.setFL_CALIFICATION_DO(res.getString("FL_CALIFICATION_DO"));
                    allData.setFL_LETTER(res.getString("FL_LETTER"));
                    allData.setFL_AVG(res.getString("FL_CALIFICATION_TOTAL"));
                    list.add(allData);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(calificationModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<calificationModel> SelectCalificationRecordsDescription(){
        ArrayList<calificationModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_CALIFICATIONS_BY_TEACHER`('byMatterRecordsCalificationsDescription', null, null, null, null)"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    calificationModel allData=new calificationModel();  
                    allData.setFL_NAME_DESCRIPTION_INTEGRADORAS(res.getString("FL_NAME_DESCRIPTION_INTEGRADORAS"));
                    allData.setFL_NAME_DESCRIPTION_NOT_INTEGRADORAS(res.getString("FL_NAME_DESCRIPTION_NOT_INTEGRADORAS"));
                    list.add(allData);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(calificationModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<calificationModel> SelectCalificationNowTutoring(int pkCareer, int  pkGroup, int pkPeriod){
        ArrayList<calificationModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_CALIFICATIONS_BY_TEACHER`('byTutor', "+pkCareer+", "+pkGroup+",null, "+pkPeriod+")"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    calificationModel allData=new calificationModel();
                    allData.setFK_STUDENT(res.getInt("PK_STUDENT"));
                    allData.setFL_ENROLLMENT(res.getString("FL_ENROLLMENT"));
                    allData.setFL_NAME(res.getString("FL_NAME"));
                    list.add(allData);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(calificationModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<calificationModel> SelectCalificationRows(int pkCareer, int  pkGroup, int pkPeriod){
        ArrayList<calificationModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_CALIFICATIONS_BY_TEACHER`('rowsCal', "+pkCareer+", "+pkGroup+",null, "+pkPeriod+")"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    calificationModel allData=new calificationModel();
                    allData.setFK_STUDENT(res.getInt("PK_STUDENT"));
                    allData.setFL_NAME_ALIAS_SUBJECT_MATTER(res.getString("FL_TEXT"));
                    allData.setFL_AVG(res.getString("FL_CALIFICATION_TOTAL"));
                    list.add(allData);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(calificationModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<propetiesTableModel> SelectCalificationNowTutoringColumns(int pkCareer, int  pkGroup, int period){
        ArrayList<propetiesTableModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_CALIFICATIONS_BY_TEACHER`('colums', "+pkCareer+", "+pkGroup+", null, "+period+")"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    propetiesTableModel allData=new propetiesTableModel();
                    allData.setFL_TEXT(res.getString("FL_TEXT"));
                    allData.setFL_DATA_FIELD(res.getString("FL_DATA_FIELD"));
                    allData.setFL_ALIGN(res.getString("FL_ALIGN"));
                    allData.setFL_CELLSALING(res.getString("FL_CELLSALING"));
                    allData.setFL_CELLSRENDERER(res.getString("FL_CELLSRENDERER"));
                    allData.setFL_WIDHT(res.getString("FL_WIDHT"));
                    list.add(allData);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(calificationModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public String SetObservations(int fkType, int pkMatter, int  pkGroup, int period, String observation){
        String status;
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `SET_WORK_PLANNING_BY_GROUP_MATTER`('updateObservations', "+fkType+", "+pkMatter+", "+pkGroup+", "+period+", '"+observation+"')"); ResultSet res = ps.executeQuery()) {
                status= "Success";
                res.close();
                ps.close();
                conn.close();
            }
            return status;
        } catch (SQLException ex) {
            status="error";
            Logger.getLogger(calificationModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return status;
    }
    public String GetObservations(int fkType, int pkMatter, int  pkGroup, int period){
        String status;
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `SET_WORK_PLANNING_BY_GROUP_MATTER`('getObservations', "+fkType+", "+pkMatter+", "+pkGroup+", "+period+", null)"); ResultSet res = ps.executeQuery()) {
                if(res!=null && res.next()){
                    status=""+res.getString("FL_OBSERVATIONS");   
                }else{
                    status="null"; 
                }
                res.close();
                ps.close();
                conn.close();
            }
            return status;
        } catch (SQLException ex) {
            status="error";
            Logger.getLogger(calificationModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return status;
    }
    public String CloseWorkPlanningByGroupMatter(int fkType, int pkMatter, int  pkGroup, int period){
        String status;
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `SET_WORK_PLANNING_BY_GROUP_MATTER`('closeWorkPlanningByGroupMatter',"+fkType+", "+pkMatter+", "+pkGroup+", "+period+", null)"); ResultSet res = ps.executeQuery()) {
                status= "Success";
                res.close();
                ps.close();
                conn.close();
            }
            return status;
        } catch (SQLException ex) {
            status="error";
            Logger.getLogger(calificationModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return status;
    }
    public String IsCloseWorkPlanningByGroupMatter(int fkType, int pkMatter, int  pkGroup, int period){
        String status;
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `SET_WORK_PLANNING_BY_GROUP_MATTER`('isCloseWorkPlanningByGroupMatter',"+fkType+", "+pkMatter+", "+pkGroup+", "+period+", null)"); ResultSet res = ps.executeQuery()) {
                if(res!=null && res.next()){
                    status=res.getString("FL_CLOSED");
                }else{
                    status="3";
                }
                res.close();
                ps.close();
                conn.close();
            }
            return status;
        } catch (SQLException ex) {
            status="error";
            Logger.getLogger(calificationModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return status;
    }
    
    public ArrayList<propetiesTableModel> SelectCalificationNowTutoringColumnsDescription(int pkCareer, int  pkGroup, int pkPeriod){
        ArrayList<propetiesTableModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_CALIFICATIONS_BY_TEACHER`('columsDescription', "+pkCareer+", "+pkGroup+", null, "+pkPeriod+")"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    propetiesTableModel allData=new propetiesTableModel();
                    allData.setFL_TEXT(res.getString("FL_TEXT"));
                    allData.setFL_TEXT_EXTENDS(res.getString("FL_TEXT_EXTENDS"));
                    list.add(allData);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(calificationModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<calificationModel> SelectCalificationNowStudent(int pkStudent){
        ArrayList<calificationModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_CALIFICATIONS_BY_STUDENTS`('columsDescription', "+pkStudent+", null, null, null)"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    calificationModel allData=new calificationModel();
                    allData.setFL_NAME_SUBJECT_MATTER(res.getString("FL_NAME_SUBJECT_MATTER"));
                    allData.setFL_AVG(res.getString("FL_AVG"));
                    list.add(allData);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(calificationModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<calificationModel> SelectCalificationHistoryStudent(int pkStudent, int pkPerdiod){
        ArrayList<calificationModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_CALIFICATIONS_BY_STUDENTS`('columsDescriptionHistory', "+pkStudent+", null, null, "+pkPerdiod+")"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    calificationModel allData=new calificationModel();
                    if(res.getString("FL_NAME_SUBJECT_MATTER")!=null && res.getString("FL_AVG")!=null){
                        allData.setFL_NAME_SUBJECT_MATTER(res.getString("FL_NAME_SUBJECT_MATTER"));
                        allData.setFL_AVG(res.getString("FL_AVG"));
                        list.add(allData);
                    }                    
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(calificationModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
}
