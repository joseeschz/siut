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
import java.util.Arrays;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.activitiesToGroupModel;

/**
 *
 * @author Carlos
 */
public class activitiesToGroupControl {
    public static void main(String[] args) {
        ArrayList<activitiesToGroupModel> list=new activitiesToGroupControl().SelectActivitiesToGroup(0, 12, 64, 1, 325, 6, 1);
        String[] result = new activitiesToGroupControl().SelectWorkPlanning(28, 1, 329, 1, 13);
        System.out.println(result[6]);
        for(int i=0;i<list.size();i++){
            //System.out.println(list.get(i).getFL_NAME_ACTIVITY());
        }
        //System.out.println(Arrays.toString(new activitiesToGroupControl().SelectWorkPlanning(33, 3, 109, 4, 5)));
    }
    public ArrayList<activitiesToGroupModel> SelectActivitiesByScale(int fk_period, int fk_study_level, int fk_subject_matter, int fk_scale_evaluation){
        ArrayList<activitiesToGroupModel> list=new ArrayList<>();
        try {
            String procedure="CALL `GET_ACTIVITIES`('byScale', null, "+fk_period+", null, "+fk_study_level+", "+fk_subject_matter+", null, "+fk_scale_evaluation+")";
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    activitiesToGroupModel listActivitiesToGroup=new activitiesToGroupModel();
                    listActivitiesToGroup.setPK_ACTIVITY(res.getString("PK_ACTIVITY"));
                    listActivitiesToGroup.setFL_NAME_ACTIVITY(res.getString("FL_NAME_ACTIVITY"));
                    listActivitiesToGroup.setFL_VALUE_ACTIVITY(res.getDouble("FL_VALUE_ACTIVITY"));
                    listActivitiesToGroup.setFL_TYPE_SCALE(res.getInt("FL_TYPE_SCALE"));
                    list.add(listActivitiesToGroup);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        }catch (SQLException ex) {
            Logger.getLogger(activitiesToGroupModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<activitiesToGroupModel> SelectActivitiesToGroup(int fk_work_planning, int fk_period, int fk_teacher, int fk_study_level, int fk_subject_matter, int fk_group, int fk_scale_evaluation){
        ArrayList<activitiesToGroupModel> list=new ArrayList<>();
        try {
            String procedure="CALL `GET_ACTIVITIES`('byScale', "+fk_work_planning+", "+fk_period+", "+fk_teacher+", "+fk_study_level+", "+fk_subject_matter+", "+fk_group+", "+fk_scale_evaluation+")";
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    activitiesToGroupModel listActivitiesToGroup=new activitiesToGroupModel();
                    listActivitiesToGroup.setPK_ACTIVITY(res.getString("PK_ACTIVITY"));
                    listActivitiesToGroup.setFL_NUM(res.getString("FL_NUM"));
                    listActivitiesToGroup.setFL_NAME_ACTIVITY(res.getString("FL_NAME_ACTIVITY"));
                    listActivitiesToGroup.setFL_EVALUATED(res.getString("FL_EVALUATED"));
                    listActivitiesToGroup.setFL_DESCRIPTION(res.getString("FL_DESCRIPTION"));
                    listActivitiesToGroup.setFL_VALUE_ACTIVITY(res.getDouble("FL_VALUE_ACTIVITY"));
                    listActivitiesToGroup.setFL_VALUE_ACTIVITY_PERCENT(res.getString("FL_VALUE_ACTIVITY_PERCENT"));
                    listActivitiesToGroup.setFL_CREATION_DATE(res.getString("FL_CREATION_DATE"));
                    listActivitiesToGroup.setFL_LAST_DATE_UPDATE(res.getString("FL_LAST_UPDATE_DATE"));
                    listActivitiesToGroup.setPK_SCALE_EVALUATION(res.getInt("PK_SCALE_EVALUATION"));
                    listActivitiesToGroup.setFL_NAME_SCALE(res.getString("FL_NAME_SCALE"));
                    listActivitiesToGroup.setFL_MAX_VALUE(res.getInt("FL_MAX_VALUE"));
                    listActivitiesToGroup.setPK_WORK_PLANNING(res.getInt("PK_WORK_PLANNING"));
                    list.add(listActivitiesToGroup);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        }catch (SQLException ex) {
            Logger.getLogger(activitiesToGroupModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<activitiesToGroupModel> SelectActivityToGroup(int pkActivity){
        ArrayList<activitiesToGroupModel> list=new ArrayList<>();
        try {
            String procedure="CALL `GET_ACTIVITIES_CAL_BY_STUDENTS`('byPk', null, null, null, null, "+pkActivity+", null)";
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    activitiesToGroupModel listActivitiesToGroup=new activitiesToGroupModel();
                    listActivitiesToGroup.setPK_ACTIVITY(res.getString("PK_ACTIVITY"));
                    listActivitiesToGroup.setFL_NAME_ACTIVITY(res.getString("FL_NAME_ACTIVITY"));
                    listActivitiesToGroup.setFL_DESCRIPTION(res.getString("FL_DESCRIPTION"));
                    listActivitiesToGroup.setFL_VALUE_ACTIVITY(res.getDouble("FL_VALUE_ACTIVITY"));
                    listActivitiesToGroup.setFL_CREATION_DATE(res.getString("FL_CREATION_DATE"));
                    listActivitiesToGroup.setFL_LAST_DATE_UPDATE(res.getString("FL_LAST_UPDATE_DATE"));
                    list.add(listActivitiesToGroup);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        }catch (SQLException ex) {
            Logger.getLogger(activitiesToGroupModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public String[] SelectWorkPlanning(int fk_teacher, int fk_study_level, int fk_subject_matter, int fk_scale_evaluation, int fk_period){
        String[] result = new String[7];
        try {
            String procedure="CALL `GET_WORK_PLANNING`('exist?', "+fk_teacher+", "+fk_study_level+", "+fk_subject_matter+", "+fk_scale_evaluation+", "+fk_period+")";
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    result[0]=res.getString("result");
                    result[1]=res.getString("PK_WORK_PLANNING");
                    result[2]=res.getString("FL_INDICATIONS");
                    result[3]=res.getString("FL_REALIZED");
                    result[4]=res.getString("FL_REALIZED_BLOCK");
                    result[5]=res.getString("FL_OBSERVATIONS");
                    result[6]=res.getString("FL_DATE_PRINT");
                }
                res.close();
                ps.close();
                conn.close();
            }
            return result;
        }catch (SQLException ex) {
            Logger.getLogger(activitiesToGroupModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }
        
    public String[] InsertWorkPlanning(int fk_teacher, int fk_study_level, int fk_subject_matter, int fk_scale_evaluation, int fk_period){
        String[] result = new String[2];
        try {
            String procedure="CALL `SET_WORK_PLANNING`('insert', null, "+fk_teacher+", "+fk_study_level+", "+fk_subject_matter+", "+fk_scale_evaluation+", "+fk_period+", null)";
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    result[0]=res.getString("result");
                    result[1]=res.getString("pkWorkPlanning");
                }
                res.close();
                ps.close();
                conn.close();
            }
            return result;
        }catch (SQLException ex) {
            result[0]="Fail";
            result[1]=null;
            Logger.getLogger(activitiesToGroupModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }
    public String SetObservations(int fk_teacher, int fk_study_level, int fk_subject_matter, int fk_period, String fl_observations){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            String procedure="CALL `SET_WORK_PLANNING`('setObservations', null, "+fk_teacher+", "+fk_study_level+", "+fk_subject_matter+", null, "+fk_period+", '"+fl_observations+"')";
            try (PreparedStatement ps = conn.prepareStatement(procedure)) {
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
    public String SetPrintDate(int fk_teacher, int fk_study_level, int fk_subject_matter, int fk_period, String fl_date_print){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            String procedure="CALL `SET_WORK_PLANNING`('setPrintDate', null, "+fk_teacher+", "+fk_study_level+", "+fk_subject_matter+", null, "+fk_period+", '"+fl_date_print+"')";
            try (PreparedStatement ps = conn.prepareStatement(procedure)) {
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
    public String[] SelectDisponibilityValueByWorkPlanning(int fk_work_planning, int fk_scale_evaluation){
        String[] result = new String[2];
        try {
            String procedure="CALL `SET_ACTIVITIES`('valueByActivity', null, null, null, null, "+fk_work_planning+", "+fk_scale_evaluation+")";
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    result[0]=res.getString("result");
                    result[1]=null;
                }
                res.close();
                ps.close();
                conn.close();
            }
            return result;
        }catch (SQLException ex) {
            result[0]="Fail";
            result[1]=null;
            Logger.getLogger(activitiesToGroupModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }
    
    public String[] BlockWorkPlanning(int fk_work_planning){
        String[] result = new String[2];
        try {
            String procedure="CALL `SET_WORK_PLANNING`('blockWorkPlanning', "+fk_work_planning+", null, null, null, null, null, null)";
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    result[0]=res.getString("result");
                    result[1]=res.getString("resultStatus");
                }
                res.close();
                ps.close();
                conn.close();
            }
            return result;
        }catch (SQLException ex) {
            result[0]="Fail";
            result[1]=null;
            Logger.getLogger(activitiesToGroupModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }
    
    public String[] UnblockWorkPlanning(int fk_work_planning){
        String[] result = new String[2];
        try {
            String procedure="CALL `SET_WORK_PLANNING`('unblockWorkPlanning', "+fk_work_planning+", null, null, null, null, null, null)";
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    result[0]=res.getString("result");
                    result[1]=res.getString("resultStatus");
                }
                res.close();
                ps.close();
                conn.close();
            }
            return result;
        }catch (SQLException ex) {
            result[0]="Fail";
            result[1]=null;
            Logger.getLogger(activitiesToGroupModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }
    
    public String[] ValidateValue(double value_activity, int fk_work_planning, int fk_scale_evaluation){
        String[] result = new String[2];
        try {
            String procedure="CALL `SET_ACTIVITIES`('valueByActivity', null, null, null, '"+value_activity+"', "+fk_work_planning+", "+fk_scale_evaluation+")";
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    result[0]=res.getString("result");
                    result[1]=null;
                }
                res.close();
                ps.close();
                conn.close();
            }
            return result;
        }catch (SQLException ex) {
            result[0]="Fail";
            result[1]=null;
            Logger.getLogger(activitiesToGroupModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }
    
    public String InsertActivitiesToGroup(activitiesToGroupModel dataActivitiesToGroup){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_ACTIVITIES`('insert', null, '"+dataActivitiesToGroup.getFL_NAME_ACTIVITY()+"', '"+dataActivitiesToGroup.getFL_DESCRIPTION()+"','"+dataActivitiesToGroup.getFL_VALUE_ACTIVITY()+"', "+dataActivitiesToGroup.getPK_WORK_PLANNING()+", "+dataActivitiesToGroup.getFK_SCALE_EVALUATION()+")")) {
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
    
    public String InsertActivitiesToGroupImported(activitiesToGroupModel dataActivitiesToGroup){
        String request="";
        String procedure="CALL `SET_ACTIVITIES`('insertImported', "+dataActivitiesToGroup.getPK_ACTIVITY()+", null, null, null, "+dataActivitiesToGroup.getPK_WORK_PLANNING()+", null)";
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    request=res.getString("result");
                }
                res.close();
                ps.close();
                conn.close();
            }
            return request;
        }catch (SQLException ex) {
            request="fail";
        } 
        return request;
    }
    
    public String InsertActivitiesToGroupImportedAll(int pkWorkPlanningNew, int pkWorkPlanningOld){
        String request="";
        String procedure="CALL `SET_ACTIVITIES`('insertImportedAll', "+pkWorkPlanningOld+", null, null, null, "+pkWorkPlanningNew+", null)";
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    request=res.getString("result");
                }
                res.close();
                ps.close();
                conn.close();
            }
            return request;
        }catch (SQLException ex) {
            request="fail";
        }   
        return request;
    }
    
    public String DeleteActivitiesToGroup(int pkActivitiesToGroup){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_ACTIVITIES`('delete', "+pkActivitiesToGroup+", null, null, null, null, null)")) {
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
    public String UpdateActivitiesToGroup(activitiesToGroupModel dataActivitiesToGroup){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_ACTIVITIES`('update', "+dataActivitiesToGroup.getPK_ACTIVITY()+", '"+dataActivitiesToGroup.getFL_NAME_ACTIVITY()+"', '"+dataActivitiesToGroup.getFL_DESCRIPTION()+"', '"+dataActivitiesToGroup.getFL_VALUE_ACTIVITY()+"', "+dataActivitiesToGroup.getPK_WORK_PLANNING()+", null)")) {
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
}
