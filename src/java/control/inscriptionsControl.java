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
import model.inscriptionsModel;

/**
 *
 * @author Lab5-E
 */
public class inscriptionsControl {
    public static void main(String[] args) {
        ArrayList<inscriptionsModel> listCareersInscriptionsTop=new inscriptionsControl().SelectCareersInscriptionsTop("12");
        for(int i=0;i<listCareersInscriptionsTop.size();i++){
            System.out.print(listCareersInscriptionsTop.get(i).getFL_NAME_ABBREVIATED());
        }
    }
    public ArrayList<inscriptionsModel> SelectCareersInscriptionsTop(String pk_period){
        ArrayList<inscriptionsModel> list=new ArrayList<>();
        try {
            try (Connection conn = new connectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(" CALL `GET_TOP_INSCRIPTIONS`('top', "+pk_period+")"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    inscriptionsModel allCareersInscriptions=new inscriptionsModel();
                    allCareersInscriptions.setPK_TOP_INSCRIPTION(res.getInt("PK_TOP_INSCRIPTION"));
                    allCareersInscriptions.setFL_NAME_ABBREVIATED(res.getString("FL_NAME_ABBREVIATED"));
                     allCareersInscriptions.setFL_TOP(res.getString("FL_TOP"));
                    list.add(allCareersInscriptions);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(inscriptionsModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
}
