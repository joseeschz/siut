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
import model.preparatoryModel;


/**
 *
 * @author CARLOS
 */
public class prepararoryControl {
    public static void main(String[] args) {
        ArrayList<preparatoryModel> list=new prepararoryControl().SelectPreparatory("all", "0");
        for(int i=0;i<list.size();i++){
            System.out.println(list.get(i).getFL_NAME_PREPARATORY());
        }
    }
    public ArrayList<preparatoryModel> SelectPreparatory(String action, String fk_locality){
        String procedure;
        if(action.equals("all")){
            procedure ="CALL `GET_PREPARATORY`('all', null)";
        }else{
            procedure="CALL `GET_PREPARATORY`('byLocality', "+fk_locality+")";
        }
        ArrayList<preparatoryModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    preparatoryModel allPreparatory=new preparatoryModel();
                    allPreparatory.setPK_PREPARATORY(res.getInt("PK_PREPARATORY"));
                    allPreparatory.setFK_ENTITY(res.getInt("FK_ENTITY"));
                    allPreparatory.setFK_MUNICIPALITY(res.getInt("FK_MUNICIPALITY"));
                    allPreparatory.setFK_LOCALITY(res.getInt("FK_LOCALITY"));                    
                    allPreparatory.setFL_ALTITUDE_msnm(res.getString("FL_ALTITUDE_msnm"));
                    allPreparatory.setFL_AND_STREET(res.getString("FL_AND_STREET"));
                    allPreparatory.setFL_BETWEEN_STREET(res.getString("FL_BETWEEN_STREET"));
                    allPreparatory.setFL_CCT(res.getString("FL_CCT"));
                    allPreparatory.setFL_CONTROL(res.getString("FL_CONTROL"));
                    allPreparatory.setFL_DOMICILE(res.getString("FL_DOMICILE"));
                    allPreparatory.setFL_LATITUDE(res.getString("FL_LATITUDE"));
                    allPreparatory.setFL_LATITUDE_gms(res.getString("FL_LATITUDE_gms"));
                    allPreparatory.setFL_LONGITUDE(res.getString("FL_LONGITUDE"));
                    allPreparatory.setFL_LONGITUDE_gms(res.getString("FL_LONGITUDE_gms"));
                    allPreparatory.setFL_NAME_ENTITY(res.getString("FL_NAME_ENTITY"));
                    allPreparatory.setFL_NAME_LOCALITY(res.getString("FL_NAME_LOCALITY"));
                    allPreparatory.setFL_NAME_MUNICIPALITY(res.getString("FL_NAME_MUNICIPALITY"));
                    allPreparatory.setFL_NAME_PREPARATORY(res.getString("FL_NAME_PREPARATORY"));
                    list.add(allPreparatory);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(preparatoryModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public String InsertPreparatory(preparatoryModel dataPreparatory){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_PREPARATORY`('insert', null, '"+dataPreparatory.getFL_CCT()+"',"
                    + "'"+dataPreparatory.getFL_NAME_PREPARATORY()+"', '"+dataPreparatory.getFL_CONTROL()+"', '"+dataPreparatory.getFL_DOMICILE()+"', "
                    + "'"+dataPreparatory.getFL_BETWEEN_STREET()+"', '"+dataPreparatory.getFL_AND_STREET()+"', 'altitude', '"+dataPreparatory.getFL_LONGITUDE()+"', "
                    + "'"+dataPreparatory.getFL_LATITUDE()+"', '"+dataPreparatory.getFL_LATITUDE_gms()+"', '"+dataPreparatory.getFL_LONGITUDE_gms()+"', '"+dataPreparatory.getFK_LOCALITY()+"')")) {
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
    public String DeletePreparatory(int pkPreparatory){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_PREPARATORY`('delete', "+pkPreparatory+", '', '', '', '', '', '', '', '', '', '', '', null)")) {
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
    public String UpdatePreparatory(preparatoryModel dataPreparatory){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_PREPARATORY`('update', '"+dataPreparatory.getPK_PREPARATORY()+"', '"+dataPreparatory.getFL_CCT()+"',"
                    + "'"+dataPreparatory.getFL_NAME_PREPARATORY()+"', '"+dataPreparatory.getFL_CONTROL()+"', '"+dataPreparatory.getFL_DOMICILE()+"', "
                    + "'"+dataPreparatory.getFL_BETWEEN_STREET()+"', '"+dataPreparatory.getFL_AND_STREET()+"', 'altitude', '"+dataPreparatory.getFL_LONGITUDE()+"', "
                    + "'"+dataPreparatory.getFL_LATITUDE()+"', '"+dataPreparatory.getFL_LATITUDE_gms()+"', '"+dataPreparatory.getFL_LONGITUDE_gms()+"', '"+dataPreparatory.getFK_LOCALITY()+"')")) {
                ps.executeUpdate();
                request="Datos Modificados"+dataPreparatory.getPK_PREPARATORY();
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
