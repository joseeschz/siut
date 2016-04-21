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
import model.calificationModel;
import model.propetiesTableModel;
import model.subjectMattersModel;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author CARLOS
 */
public class calificationControl {
    public static void main(String[] args){
        ArrayList<subjectMattersModel> listColumns=new calificationControl().SubjectsMattersRepprovedByStudent(2976, 2, 11, 13);
        JSONArray contentRows = new JSONArray();
        JSONArray bulding = new JSONArray();
        JSONObject rows = new JSONObject();
        for(int i=0;i<listColumns.size();i++){
            JSONObject dataRows = new JSONObject();
            dataRows.put("index", i);
            dataRows.put("Pk_matter", listColumns.get(i).getPK_SUBJECT_MATTER());
            contentRows.add(dataRows); 
        }
        System.out.println(contentRows);
    }
    
    public String UpdateCalificationByStudent(int updateTypeEval, int pt_pk_calification_student, int pt_scale_evaluation, double pt_value){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_CALIFICATION`('update', "+pt_pk_calification_student+", null, null, "+updateTypeEval+", "+pt_scale_evaluation+", "+pt_value+")")) {
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
    
    public ArrayList<calificationModel> SelectCalificationNow(int  pkGroup, int pkMatter, int pkPeriod){
        ArrayList<calificationModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_CALIFICATIONS_BY_TEACHER`('byMatter', null, "+pkGroup+", "+pkMatter+", "+pkPeriod+", null)"); ResultSet res = ps.executeQuery()) {
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
    public ArrayList<calificationModel> SelectCalificationRecordsAverage(int  pkGroup, int pkMatter, int pkPeriod, int pkTypeEvaluation){
        ArrayList<calificationModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_CALIFICATIONS_BY_TEACHER`('byMatterRecordsCalifications', null, "+pkGroup+", "+pkMatter+", "+pkPeriod+", "+pkTypeEvaluation+")"); ResultSet res = ps.executeQuery()) {
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
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_CALIFICATIONS_BY_TEACHER`('byMatterRecordsCalificationsRegularization', null, "+pkGroup+", "+pkMatter+", "+pkPeriod+", null)"); ResultSet res = ps.executeQuery()) {
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
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_CALIFICATIONS_BY_TEACHER`('byMatterRecordsCalificationsGlobal', null, "+pkGroup+", "+pkMatter+", "+pkPeriod+", null)"); ResultSet res = ps.executeQuery()) {
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
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_CALIFICATIONS_BY_TEACHER`('byMatterRecordsCalificationsDescription', null, null, null, null, null)"); ResultSet res = ps.executeQuery()) {
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
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_CALIFICATIONS_BY_TEACHER`('byTutor', "+pkCareer+", "+pkGroup+",null, "+pkPeriod+", null)"); ResultSet res = ps.executeQuery()) {
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
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_CALIFICATIONS_BY_TEACHER`('rowsCal', "+pkCareer+", "+pkGroup+",null, "+pkPeriod+", null)"); ResultSet res = ps.executeQuery()) {
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
    public JSONArray SelectCalificationsByActivitiesRows(int pkCareer, int fkMatter, int pkGroup, int pkPeriod){
        JSONArray contentColums = new JSONArray();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_ACTIVITIES_CAL_BY_STUDENTS`('rowsCal', "+pkCareer+", "+fkMatter+", "+pkGroup+", "+fkMatter+", null, "+pkPeriod+")"); ResultSet res = ps.executeQuery()) {
                ResultSetMetaData rsmd = res.getMetaData();                
                JSONObject columns;
                while(res!=null&&res.next()){
                    columns = new JSONObject();
                    for(int col=0; col<rsmd.getColumnCount(); col++){    
                        columns.put(rsmd.getColumnName(col+1), res.getString(rsmd.getColumnName(col+1)));
                    }
                    contentColums.add(columns);
                }
                res.close();
                ps.close();
                conn.close();
            }
        } catch (SQLException ex) {
            Logger.getLogger(calificationModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return contentColums;
    }
    public ArrayList<propetiesTableModel> SelectCalificationNowTutoringColumns(int pkCareer, int  pkGroup, int period){
        ArrayList<propetiesTableModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_CALIFICATIONS_BY_TEACHER`('colums', "+pkCareer+", "+pkGroup+", null, "+period+", null)"); ResultSet res = ps.executeQuery()) {
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
    public ArrayList<propetiesTableModel> SelectCalificationByActivitiesColums(int pkCareer, int  pkGroup, int pkMatter, int period){
        ArrayList<propetiesTableModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_ACTIVITIES_CAL_BY_STUDENTS`('columsActivities', "+pkCareer+", "+pkMatter+", "+pkGroup+", "+pkMatter+", null, "+period+")"); ResultSet res = ps.executeQuery()) {
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
    public String CanPrint(int fkType, int pkMatter, int  pkGroup, int period){
        String status = null;
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `SET_WORK_PLANNING_BY_GROUP_MATTER`('canPrint',"+fkType+", "+pkMatter+", "+pkGroup+", "+period+", null)"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    status= res.getString("FL_RESULT");
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
    public ArrayList<subjectMattersModel> SubjectsMattersMissingCloseAndRepprovedByStudent(int pkStudent, int fkType, int  pkGroup, int pkPeriod){
        ArrayList<subjectMattersModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_SUBJECTS_MATTERS_BY_STUDENT_FAIL`('teacherMissingCloseAndRepprovedByStudent', "+pkStudent+", "+fkType+", "+pkPeriod+")"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    calificationModel allData=new calificationModel();
                    allData.setPK_WORKER(res.getInt("PK_WORKER"));
                    allData.setFL_NAME_WORKER(res.getString("FL_NAME_WORKER"));
                    allData.setPK_SUBJECT_MATTER(res.getInt("PK_SUBJECT_MATTER"));
                    allData.setFL_NAME_SUBJECT_MATTER(res.getString("FL_NAME_SUBJECT_MATTER"));
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
    public ArrayList<subjectMattersModel> SubjectsMattersRepprovedByStudent(int pkStudent, int fkType, int  pkGroup, int pkPeriod){
        ArrayList<subjectMattersModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_SUBJECTS_MATTERS_BY_STUDENT_FAIL`('subjectsRepprovedByStudent', "+pkStudent+", "+fkType+", "+pkPeriod+")"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    calificationModel allData=new calificationModel();
                    allData.setPK_WORKER(res.getInt("PK_WORKER"));
                    allData.setFL_NAME_WORKER(res.getString("FL_NAME_WORKER"));
                    allData.setPK_SUBJECT_MATTER(res.getInt("PK_SUBJECT_MATTER"));
                    allData.setFL_NAME_SUBJECT_MATTER(res.getString("FL_NAME_SUBJECT_MATTER"));
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
    public ArrayList<subjectMattersModel> TeacherMissingCloseByStudent(int fkType, int pkMatter, int  pkGroup, int period){
        ArrayList<subjectMattersModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `SET_WORK_PLANNING_BY_GROUP_MATTER`('teacherMissingCloseByStudent',"+fkType+", "+pkMatter+", "+pkGroup+", "+period+", null)"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    calificationModel allData=new calificationModel();
                    allData.setPK_WORKER(res.getInt("FK_TEACHER"));
                    allData.setFL_NAME_WORKER(res.getString("FL_NAME_WORKER"));
                    allData.setPK_SUBJECT_MATTER(res.getInt("PK_SUBJECT_MATTER"));
                    allData.setFL_NAME_SUBJECT_MATTER(res.getString("FL_NAME_SUBJECT_MATTER"));
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
    public ArrayList<subjectMattersModel> TeacherMissingClose(int fkType, int pkMatter, int  pkGroup, int period){
        ArrayList<subjectMattersModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `SET_WORK_PLANNING_BY_GROUP_MATTER`('teacherMissingClose',"+fkType+", "+pkMatter+", "+pkGroup+", "+period+", null)"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    calificationModel allData=new calificationModel();
                    allData.setPK_WORKER(res.getInt("FK_TEACHER"));
                    allData.setFL_NAME_WORKER(res.getString("FL_NAME_WORKER"));
                    allData.setPK_SUBJECT_MATTER(res.getInt("PK_SUBJECT_MATTER"));
                    allData.setFL_NAME_SUBJECT_MATTER(res.getString("FL_NAME_SUBJECT_MATTER"));
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
    
    public String OpenWorkPlanningByGroupMatter(int fkType, int pkMatter, int  pkGroup, int period){
        String status;
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `SET_WORK_PLANNING_BY_GROUP_MATTER`('openWorkPlanningByGroupMatter',"+fkType+", "+pkMatter+", "+pkGroup+", "+period+", null)"); ResultSet res = ps.executeQuery()) {
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
        String status = null;
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `SET_WORK_PLANNING_BY_GROUP_MATTER`('isCloseWorkPlanningByGroupMatter',"+fkType+", "+pkMatter+", "+pkGroup+", "+period+", null)"); ResultSet res = ps.executeQuery()) {
                if(res!=null && res.next()){
                    status=res.getString("FL_CLOSED");
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
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_CALIFICATIONS_BY_TEACHER`('columsDescription', "+pkCareer+", "+pkGroup+", null, "+pkPeriod+", null)"); ResultSet res = ps.executeQuery()) {
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
                    allData.setFL_NAME_WORKER(res.getString("FL_NAME_WORKER"));
                    allData.setFL_TOTAL_OBTAINED(res.getString("FL_AVG"));
                    allData.setFL_TOTAL_EVALUATED(res.getString("FL_TOTAL_EVALUATED"));
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
    public ArrayList<calificationModel> SelectCalificationMattersStudent(int pkStudent){
        ArrayList<calificationModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_CALIFICATIONS_BY_STUDENTS`('sumjectMatersPercentEvalautedAndCurrentValue', "+pkStudent+", null, null, null)"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    calificationModel allData=new calificationModel();
                    allData.setPK_SUBJECT_MATTER(res.getInt("PK_SUBJECT_MATTER"));
                    allData.setFL_NAME_SUBJECT_MATTER(res.getString("FL_NAME_SUBJECT_MATTER"));
                    allData.setFL_NAME_WORKER(res.getString("FL_NAME_WORKER"));
                    allData.setFL_TOTAL_EVALUATED(res.getString("FL_TOTAL_EVALUATED"));
                    allData.setFL_TOTAL_OBTAINED(res.getString("FL_TOTAL_OBTAINED"));
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
