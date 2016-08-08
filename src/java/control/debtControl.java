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
import java.util.Iterator;
import model.studentModel;
import model.debtModel;

/**
 *
 * @author Lab5-E
 */
public class debtControl {
    public static void main(String[] args) {
        ArrayList<debtModel> list = null;
        for (debtModel debtMdl : list) {
            System.out.print(debtMdl.getFL_ROW_DATE());
        }
    }
    private String procedure;
    public ArrayList<debtModel> SelectDebts(){
        ArrayList<debtModel> list=new ArrayList<>();
        procedure = "";
        try (Connection conn = new connectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure)) { 
            ps.setString(1, "all");         
            try (ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    debtModel allDebt=new debtModel();
                    studentModel student = new studentModel();
                    
                    list.add(allDebt);
                }
            }
        } catch (SQLException ex) {
            System.err.println(ex);
        }
        return list;
    }
    
    public String[] InsertDebt(debtModel dataDebt){
        String[] request = new String[2];
        String key = null;
        procedure = "";
        PreparedStatement ps;
        Connection conn=new connectionControl().getConexion();
        try {
            ps = conn.prepareStatement(procedure);
            ps.setString(1, "insert");
            ps.setInt(2, 0);
            ps.executeUpdate();
            ResultSet rs = ps.getResultSet(); 
            while (rs.next()) {  
                key = ""+rs.getString("LAST_INSERT_ID");
            }   
            request[0]="Inserted";
            request[1]=""+key;
            ps.close();
            conn.close();
            
        } catch (SQLException e) {
            request[0]=""+e;
            request[1]=null;
        }   
        return request;
    }
    public String CommitFalseDebt(int pkDebt){
        String request;
        procedure = "";
        try {
            Connection conn=new connectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement(procedure)) {
                ps.setString(1, "commitBack");
                ps.setInt(2, pkDebt);
                ps.executeUpdate();
                request="Commited";
                ps.close();
                conn.close();
            }
        } catch (SQLException e) {
            request=""+e.getMessage();
            e.getMessage();
        }   
        return request;
    }
    public String UpdateDebt(debtModel dataDebt){
        String request;
        procedure = "";
        try {
            Connection conn=new connectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement(procedure)) {
                ps.setString(1, "update");
                ps.executeUpdate();
                request="Updated";
                ps.close();
                conn.close();
            }
        } catch (SQLException e) {
            request=""+e.getMessage();
            e.getMessage();
        }   
        return request;
    }
    public String DeleteDebt(int pkDebt){
        String request;
        procedure = "";
        try {
            Connection conn=new connectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement(procedure)) {
                ps.setString(1, "delete");
                ps.setInt(2, pkDebt);
                ps.executeUpdate();
                request="Deleted";
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
