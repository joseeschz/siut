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
import model.periodModel;

/**
 *
 * @author CARLOS
 */
public class periodControl {
    public static void main(String[] args) {
        ArrayList<periodModel> list=new periodControl().SelectPeriodByTeacher(33, 242, 0 ,0 ,0);
        for(int i=0;i<list.size();i++){
        //    System.out.println(list.get(i).getFL_NAME());
        }
        System.out.print(new periodControl().SelectPeriodActive("activeInscription"));
    }
    public ArrayList<periodModel> SelectPeriod(String condition){
        ArrayList<periodModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_PERIOD`('"+condition+"')"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    periodModel listPeriod=new periodModel();
                    listPeriod.setPK_PERIOD(res.getInt("PK_PERIOD"));
                    listPeriod.setFL_ACTIVE(res.getInt("FL_ACTIVE"));
                    listPeriod.setFL_NAME(res.getString("FL_NAME"));
                    listPeriod.setFL_NAME_ABBREVIATED(res.getString("FL_NAME_ABBREVIATED"));
                    listPeriod.setFL_YEAR_ACTIVE(res.getInt("FL_YEAR_ACTIVE"));
                    list.add(listPeriod);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(periodModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<periodModel> SelectPeriodByStudentsAdjustmentCalifications(int pkStudent, int fkSemester){
        ArrayList<periodModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_PERIOD_BY_STUDENT_CALIFICATIONS`("+pkStudent+", "+fkSemester+")"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    periodModel listPeriod=new periodModel();
                    listPeriod.setPK_PERIOD(res.getInt("PK_PERIOD"));
                    listPeriod.setFL_ACTIVE(res.getInt("FL_ACTIVE"));
                    listPeriod.setFL_NAME(res.getString("FL_NAME"));
                    listPeriod.setFL_NAME_ABBREVIATED(res.getString("FL_NAME_ABBREVIATED"));
                    listPeriod.setFL_YEAR_ACTIVE(res.getInt("FL_YEAR_ACTIVE"));
                    list.add(listPeriod);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(periodModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<periodModel> SelectPeriodByTeacher(int pkTeacher, int pkCareer, int pkSemester, int pkMatter, int pkTypeEval){
        ArrayList<periodModel> list=new ArrayList<>();
        String procedure = "CALL `GET_PERIOD_BY_TEACHER`('periodByTeacherByMatterHistory', "+pkTeacher+", "+pkCareer+", "+pkSemester+", "+pkMatter+", "+pkTypeEval+")";
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    periodModel listPeriod=new periodModel();
                    listPeriod.setPK_PERIOD(res.getInt("PK_PERIOD"));
                    listPeriod.setFL_ACTIVE(res.getInt("FL_ACTIVE"));
                    listPeriod.setFL_NAME(res.getString("FL_NAME"));
                    listPeriod.setFL_NAME_ABBREVIATED(res.getString("FL_NAME_ABBREVIATED"));
                    listPeriod.setFL_YEAR_ACTIVE(res.getInt("FL_YEAR_ACTIVE"));
                    list.add(listPeriod);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(periodModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public int SelectPeriodActive(String command){
        int period_active = 0;
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_PERIOD`('"+command+"')"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    period_active = (res.getInt("PK_PERIOD"));
                }
                res.close();
                ps.close();
                conn.close();
            }
            return period_active;
        } catch (SQLException ex) {
            Logger.getLogger(periodModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return period_active;
    }
}
