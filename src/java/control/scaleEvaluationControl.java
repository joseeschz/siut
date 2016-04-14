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
import model.scaleEvaluationModel;

/**
 *
 * @author Carlos
 */
public class scaleEvaluationControl {
    public static void main(String[] args) {
        ArrayList<scaleEvaluationModel> list=new scaleEvaluationControl().SelectValueScaleEvaluationByLevelBloqued(1);
        for(int i=0;i<list.size();i++){
            System.out.println(list.get(i).getFL_MAX_VALUE());
        }
    }    
    public ArrayList<scaleEvaluationModel> SelectScaleEvaluationByLevel(int pkLevel){
        ArrayList<scaleEvaluationModel> list=new ArrayList<>();
        try {
            String procedure="CALL `GET_SCALE_EVALUATION`('allByLevel', "+pkLevel+", null, null)";
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    scaleEvaluationModel listStudyLevel=new scaleEvaluationModel();
                    listStudyLevel.setPK_SCALE_EVALUATION(res.getInt("PK_SCALE_EVALUATION"));
                    listStudyLevel.setFL_NAME_SCALE(res.getString("FL_NAME_SCALE"));
                    listStudyLevel.setFL_MAX_VALUE(res.getDouble("FL_MAX_VALUE"));
                    listStudyLevel.setFL_TYPE_SCALE(res.getInt("FL_TYPE_SCALE"));
                    list.add(listStudyLevel);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        }catch (SQLException ex) {
            Logger.getLogger(scaleEvaluationModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<scaleEvaluationModel> SelectScaleEvaluationByLevelBloqued(int pkPeriod, int pkTeacher, int pkSubjectMatter){
        ArrayList<scaleEvaluationModel> list=new ArrayList<>();
        try {
            String procedure="CALL `GET_SCALE_EVALUATION`('allByLevelBloqued', "+pkPeriod+", "+pkTeacher+", "+pkSubjectMatter+")";
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    scaleEvaluationModel listStudyLevel=new scaleEvaluationModel();
                    listStudyLevel.setPK_SCALE_EVALUATION(res.getInt("PK_SCALE_EVALUATION"));
                    listStudyLevel.setFL_NAME_SCALE(res.getString("FL_NAME_SCALE"));
                    listStudyLevel.setFL_MAX_VALUE(res.getDouble("FL_MAX_VALUE"));
                    listStudyLevel.setFL_TYPE_SCALE(res.getInt("FL_TYPE_SCALE"));
                    list.add(listStudyLevel);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        }catch (SQLException ex) {
            Logger.getLogger(scaleEvaluationModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<scaleEvaluationModel> SelectValueScaleEvaluationByLevelBloqued(int pkScale){
        ArrayList<scaleEvaluationModel> list=new ArrayList<>();
        try {
            String procedure="CALL `GET_ACTIVITIES`('valueByScale', null, null, null, null, null, null, '"+pkScale+"')";
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    scaleEvaluationModel listStudyLevel=new scaleEvaluationModel();
                    listStudyLevel.setPK_SCALE_EVALUATION(res.getInt("PK_SCALE_EVALUATION"));
                    listStudyLevel.setFL_NAME_SCALE(res.getString("FL_NAME_SCALE"));
                    listStudyLevel.setFL_MAX_VALUE(res.getDouble("FL_MAX_VALUE"));
                    listStudyLevel.setFL_TYPE_SCALE(res.getInt("FL_TYPE_SCALE"));
                    list.add(listStudyLevel);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        }catch (SQLException ex) {
            Logger.getLogger(scaleEvaluationModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<scaleEvaluationModel> SelectScaleEvaluationByLevelBloquedStudent(int pkMatter){
        ArrayList<scaleEvaluationModel> list=new ArrayList<>();
        try {
            String procedure="CALL `GET_SCALE_EVALUATION`('allByLevelBloquedStudent',null, null, "+pkMatter+")";
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    scaleEvaluationModel listStudyLevel=new scaleEvaluationModel();
                    listStudyLevel.setPK_SCALE_EVALUATION(res.getInt("PK_SCALE_EVALUATION"));
                    listStudyLevel.setFL_NAME_SCALE(res.getString("FL_NAME_SCALE"));
                    listStudyLevel.setFL_MAX_VALUE(res.getDouble("FL_MAX_VALUE"));
                    listStudyLevel.setFL_TYPE_SCALE(res.getInt("FL_TYPE_SCALE"));
                    list.add(listStudyLevel);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        }catch (SQLException ex) {
            Logger.getLogger(scaleEvaluationModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
}
