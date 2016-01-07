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
import model.workerModel;

/**
 *
 * @author CARLOS
 */
public class workerControl {
    public static void main(String[] args) {
        ArrayList<workerModel> list=new workerControl().SelectWorker(null,2);
        for(int i=0;i<list.size();i++){
            System.out.println(list.get(i).getFL_NAME_WORKER());
        }
    }
    public ArrayList<workerModel> SelectWorker(String comand, int fkRol){
        ArrayList<workerModel> list=new ArrayList<>();
        if(comand!=null){
            if(comand.equals("byTeacherTutor")){
                try {
                    try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_WORKERS`('byTeacherTutor', '"+fkRol+"')"); ResultSet res = ps.executeQuery()) {
                        while(res!=null&&res.next()){
                            workerModel listWorker=new workerModel();
                            listWorker.setPK_WORKER(res.getInt("PK_WORKER"));
                            listWorker.setFL_NAME_WORKER(res.getString("FL_NAME_WORKER"));
                            listWorker.setFL_TUTOR(res.getString("FL_TUTOR"));
                            listWorker.setFL_JOB_FUNCTIONAL(res.getString("FL_JOB_FUNCTIONAL"));
                            list.add(listWorker);
                        }
                        res.close();
                        ps.close();
                        conn.close();
                    }
                    return list;
                } catch (SQLException ex) {
                    Logger.getLogger(workerModel.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if(comand.equals("byTeacherWorker")){
                try {
                    try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_WORKERS`('byTeacherWorker', '"+fkRol+"')"); ResultSet res = ps.executeQuery()) {
                        while(res!=null&&res.next()){
                            workerModel listWorker=new workerModel();
                            listWorker.setPK_WORKER(res.getInt("PK_WORKER"));
                            listWorker.setFL_NAME_WORKER(res.getString("FL_NAME_WORKER"));
                            listWorker.setFL_TUTOR(res.getString("FL_TUTOR"));
                            listWorker.setFL_JOB_FUNCTIONAL(res.getString("FL_JOB_FUNCTIONAL"));
                            list.add(listWorker);
                        }
                        res.close();
                        ps.close();
                        conn.close();
                    }
                    return list;
                } catch (SQLException ex) {
                    Logger.getLogger(workerModel.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }else{
            try {
                try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_WORKERS`('byRol', '"+fkRol+"')"); ResultSet res = ps.executeQuery()) {
                    while(res!=null&&res.next()){
                        workerModel listWorker=new workerModel();
                        listWorker.setPK_WORKER(res.getInt("PK_WORKER"));
                        listWorker.setFL_NAME_WORKER(res.getString("FL_NAME_WORKER"));
                        listWorker.setFL_USER_NAME(res.getString("FL_USER_NAME"));
                        listWorker.setFL_MATERN_NAME(res.getString("FL_MATERN_NAME"));
                        listWorker.setFL_PATERN_NAME(res.getString("FL_PATERN_NAME"));
                        listWorker.setFL_KEY_SP(res.getString("FL_KEY_SP"));
                        listWorker.setFL_TELEHONE_NUMBER(res.getString("FL_TELEHONE_NUMBER"));
                        listWorker.setFL_ADDRES(res.getString("FL_ADDRES"));
                        listWorker.setFL_PHOTO(res.getString("FL_PHOTO"));
                        list.add(listWorker);
                    }
                    res.close();
                    ps.close();
                    conn.close();
                }
                return list;
            } catch (SQLException ex) {
                Logger.getLogger(workerModel.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return list;
    }
    
    public String InsertWorker(workerModel dataWorker){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_WORKER`('insert','worker', null, '"+dataWorker.getFL_NAME_WORKER()+"', '"+dataWorker.getFL_MATERN_NAME()+"', '"+dataWorker.getFL_PATERN_NAME()+"', '"+dataWorker.getFL_KEY_SP()+"', '"+dataWorker.getFL_TELEHONE_NUMBER()+"', '"+dataWorker.getFL_ADDRES()+"', '"+dataWorker.getFL_PHOTO()+"', '"+dataWorker.getFK_ROL()+"','','')")) {
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
    public String DeleteWorker(int pkWorker){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_WORKER`('delete', '','"+pkWorker+"', null, null, null, null, null, null, null, null, null, null)")) {
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
    public String UpdateWorker(String comand, workerModel dataWorker){
        String request;
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement("CALL `SET_WORKER`('update','"+comand+"', '"+dataWorker.getPK_WORKER()+"', '"+dataWorker.getFL_NAME_WORKER()+"', '"+dataWorker.getFL_MATERN_NAME()+"', '"+dataWorker.getFL_PATERN_NAME()+"', '"+dataWorker.getFL_KEY_SP()+"', '"+dataWorker.getFL_TELEHONE_NUMBER()+"', '"+dataWorker.getFL_ADDRES()+"', '"+dataWorker.getFL_PHOTO()+"', '"+dataWorker.getFK_ROL()+"','"+dataWorker.getFL_TUTOR()+"','"+dataWorker.getFL_JOB_FUNCTIONAL()+"')")) {
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
