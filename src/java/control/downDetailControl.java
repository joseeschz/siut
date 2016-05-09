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
import model.downDetailModel;

/**
 *
 * @author Lab5-E
 */
public class downDetailControl {
    public static void main(String[] args) {
        
    }
    public ArrayList<downDetailModel> SelectDownDetails(){
        ArrayList<downDetailModel> list=new ArrayList<>();
        String procedure = "CALL `GET_STUDENTS_DOWN`('downDetails', null, null, null, null)";
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    downDetailModel Detail=new downDetailModel();
                    Detail.setPK_DOWN_DETAIL(res.getInt("PK_DOWN_DETAIL"));
                    Detail.setFL_DESCRIPTION(res.getString("FL_DESCRIPTION"));
                    list.add(Detail);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(downDetailModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
}
