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
import model.evaluationTypeModel;

/**
 *
 * @author CARLOS
 */
public class evaluationTypeControl {
    public static void main(String[] args) {
    }
    public ArrayList<evaluationTypeModel> SelectEvaluationType(String action, int fkGroup, int fkMatter, int fkPeriod){
        ArrayList<evaluationTypeModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_TYPE_EVALUATION`('"+action+"', "+fkMatter+", "+fkGroup+","+fkPeriod+")"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    evaluationTypeModel Items=new evaluationTypeModel();
                    Items.setPK_EVALUATION_TYPE(res.getInt("PK_EVALUATION_TYPE"));
                    Items.setFL_NAME_TYPE(res.getString("FL_NAME_TYPE"));
                    Items.setFL_STATUS(res.getString("FL_STATUS"));
                    list.add(Items);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(evaluationTypeModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
}
