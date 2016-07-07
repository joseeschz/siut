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
import model.localityModel;

/**
 *
 * @author CARLOS
 */
public class localityControl {

    public static void main(String[] args) {
        ArrayList<localityModel> list = new localityControl().SelectLocality("byPkInegi","660");
        for (int i = 0; i < list.size(); i++) {
            System.out.println(list.get(i).getFL_NAME());
        }
    }

    public ArrayList<localityModel> SelectLocality(String action, String fkMunicipality) {
        String procedure="";
        switch (action) {
            case "byPk":
                procedure = "CALL `GET_LOCALITY`('byPk', '" + fkMunicipality + "')";
                break;
            case "all":
                procedure = "CALL `GET_LOCALITY`('all', '" + fkMunicipality + "')";
                break;
            case "byPkInegi":
                procedure = "CALL `GET_LOCALITY`('byPkInegi', '" + fkMunicipality + "')";
                break;
            case "allInegi":
                procedure = "CALL `GET_LOCALITY`('allInegi', '" + fkMunicipality + "')";
                break;
        }
        ArrayList<localityModel> list = new ArrayList<>();
        try {
            try (Connection conn = new connectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while (res != null && res.next()) {
                    localityModel allLocality = new localityModel();
                    allLocality.setPK_LOCALITY(res.getInt("PK_LOCALITY"));
                    allLocality.setFL_NAME(res.getString("FL_NAME"));
                    allLocality.setFK_ENTITY(res.getString("FK_ENTITY"));
                    allLocality.setFK_MUNICIPALITY(res.getString("FK_MUNICIPALITY"));
                    allLocality.setFL_NAME_MUNICIPALITY(res.getString("FL_NAME_MUNICIPALITY"));
                    list.add(allLocality);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(localityModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public String InsertLocality(localityModel dataLocality) {
        String request;
        try {
            Connection conn = new connectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_LOCALITY`('insert', null, '" + dataLocality.getFL_NAME() + "', '" + dataLocality.getFK_MUNICIPALITY() + "')")) {
                ps.executeUpdate();
                request = "Datos Guardados";
                ps.close();
                conn.close();
            }
        } catch (SQLException e) {
            request = "" + e.getMessage();
            e.getMessage();
        }
        return request;
    }

    public String DeleteLocality(int pkLocality) {
        String request;
        try {
            Connection conn = new connectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_LOCALITY`('delete', " + pkLocality + ", null, null)")) {
                ps.executeUpdate();
                request = "Dato Eliminado";
                ps.close();
                conn.close();
            }
        } catch (SQLException e) {
            request = "" + e.getMessage();
            e.getMessage();
        }
        return request;
    }

    public String UpdateLocality(localityModel dataLocality) {
        String request;
        try {
            Connection conn = new connectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_LOCALITY`('update', " + dataLocality.getPK_LOCALITY() + ", '" + dataLocality.getFL_NAME() + "', '" + dataLocality.getFK_MUNICIPALITY() + "')")) {
                ps.executeUpdate();
                request = "Datos Modificados";
                ps.close();
                conn.close();
            }
        } catch (SQLException e) {
            request = "" + e.getMessage();
            e.getMessage();
        }
        return request;
    }
}
