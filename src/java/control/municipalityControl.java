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
import model.municipalityModel;

/**
 *
 * @author CARLOS
 */
public class municipalityControl {
    public static void main(String[] args) {
        model.municipalityModel obj=new municipalityModel();
        obj.setPK_MUNICIPALITY(1);
        obj.setFL_NAME("dd");
        obj.setFK_ENTITY("1");
        System.out.print(new municipalityControl().UpdateMunicipality(obj));
        /*ArrayList<municipalityModel> list=new municipalityControl().SelectMunicipality();
        for(int i=0;i<list.size();i++){
            System.out.println(list.get(i).getFL_NAME());
        }*/
    }
    public ArrayList<municipalityModel> SelectMunicipality(String action, String fk_enity){
        String procedure;
        if(action.equals("byPkInegi")){
            procedure="CALL `GET_MUNICIPALITY`('byPkInegi', '"+fk_enity+"')"; 
        }else{
            procedure="CALL `GET_MUNICIPALITY`('byPk', '"+fk_enity+"')"; 
        }
        ArrayList<municipalityModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    municipalityModel allMunicipality=new municipalityModel();
                    allMunicipality.setPK_MUNICIPALITY(res.getInt("PK_MUNICIPALITY"));
                    allMunicipality.setFL_NAME(res.getString("FL_NAME"));
                    allMunicipality.setFK_ENTITY(res.getString("FK_ENTITY"));
                    allMunicipality.setFL_NAME_ENTITY(res.getString("FL_NAME_ENTITY"));
                    list.add(allMunicipality);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(municipalityModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<municipalityModel> SelectMunicipality(){
        ArrayList<municipalityModel> list=new ArrayList<>();
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_MUNICIPALITY`('all', null)"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    municipalityModel allMunicipality=new municipalityModel();
                    allMunicipality.setPK_MUNICIPALITY(res.getInt("PK_MUNICIPALITY"));
                    allMunicipality.setFL_NAME(res.getString("FL_NAME"));
                    allMunicipality.setFK_ENTITY(res.getString("FK_ENTITY"));
                    allMunicipality.setFL_NAME_ENTITY(res.getString("FL_NAME_ENTITY"));
                    list.add(allMunicipality);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(municipalityModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public String InsertMunicipality(municipalityModel dataMunicipality){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_MUNICIPALITY`('insert', null, '"+dataMunicipality.getFL_NAME()+"', '"+dataMunicipality.getFK_ENTITY()+"')")) {
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
    public String DeleteMunicipality(int pkMunicipality){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_MUNICIPALITY`('delete', '"+pkMunicipality+"', null, null)")) {
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
    public String UpdateMunicipality(municipalityModel dataMunicipality){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_MUNICIPALITY`('update', '"+dataMunicipality.getPK_MUNICIPALITY()+"', '"+dataMunicipality.getFL_NAME()+"', '"+dataMunicipality.getFK_ENTITY()+"')")) {
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
