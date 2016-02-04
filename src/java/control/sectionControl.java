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
import model.sectionModel;

/**
 *
 * @author CARLOS
 */
public class sectionControl {
    public static void main(String[] args) {
        ArrayList<sectionModel> list=new sectionControl().SelectSection(4, 3);
        for(int i=0;i<list.size();i++){
            System.out.println(list.get(i).getPK_SECTION_MENU_PRINCIPAL());
            System.out.print(list.get(i).getFL_NAME_SECTION()+" ");
            System.out.print(list.get(i).getFL_URL()+" ");
            System.out.print(list.get(i).getPK_PARENT()+" ");
            System.out.print(list.get(i).getFL_ICON()+" ");
            System.out.println();
        }
    }
    public ArrayList<sectionModel> SelectSections(int pt_pk_user, int pt_rol){
        ArrayList<sectionModel> list=new ArrayList<>();
        try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_SECTION_MENU_BY_ROL`('menuPrincipal',"+pt_pk_user+", "+pt_rol+")"); ResultSet res = ps.executeQuery()) {
            while(res!=null&&res.next()){
                sectionModel section=new sectionModel();
                section.setPK_SECTION_MENU_PRINCIPAL(res.getInt("PK_SECTION_MENU_PRINCIPAL"));
                section.setFL_NAME_SECTION(res.getString("FL_NAME_SECTION"));
                section.setFL_URL(res.getString("FL_URL"));
                section.setFL_ICON(res.getString("FL_ICON"));
                section.setFL_ITEM_ID(res.getString("FL_ITEM_ID"));
                section.setPK_PARENT(res.getInt("PK_PARENT"));
                list.add(section);
            }
            res.close();
            ps.close();
            conn.close();
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(sectionModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<sectionModel> SelectSectionsAmissiblenessByRol(int pt_rol){
        ArrayList<sectionModel> list=new ArrayList<>();
        try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_SECTION_MENU_BY_ROL`('amissibleness', null, "+pt_rol+")"); ResultSet res = ps.executeQuery()) {
            while(res!=null&&res.next()){
                sectionModel section=new sectionModel();
                section.setPK_SECTION_MENU_PRINCIPAL(res.getInt("PK_SECTION_MENU_PRINCIPAL"));
                section.setFL_NAME_SECTION(res.getString("FL_NAME_SECTION"));
                section.setFL_URL(res.getString("FL_URL"));
                section.setFL_ICON(res.getString("FL_ICON"));
                section.setFL_ITEM_ID(res.getString("FL_ITEM_ID"));
                section.setPK_PARENT(res.getInt("PK_PARENT"));
                section.setFL_ACCESS(res.getInt("FL_ACCESS"));
                list.add(section);
            }
            res.close();
            ps.close();
            conn.close();
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(sectionModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<sectionModel> SelectSection(int pk_item, int pt_rol){
        ArrayList<sectionModel> list=new ArrayList<>();
        try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_ITEMS_MENU`('byPkPatent',"+pk_item+", "+pt_rol+")"); ResultSet res = ps.executeQuery()) {
            while(res!=null&&res.next()){
                sectionModel section=new sectionModel();
                section.setPK_SECTION_MENU_PRINCIPAL(res.getInt("PK_SECTION_MENU_PRINCIPAL"));
                section.setFL_NAME_SECTION(res.getString("FL_NAME_SECTION"));
                section.setFL_URL(res.getString("FL_URL"));
                section.setFL_ICON(res.getString("FL_ICON"));
                section.setFL_ITEM_ID(res.getString("FL_ITEM_ID"));
                section.setPK_PARENT(res.getInt("PK_PARENT"));
                list.add(section);
            }
            res.close();
            ps.close();
            conn.close();
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(sectionModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<sectionModel> SelectItem(int pk_item){
        ArrayList<sectionModel> list=new ArrayList<>();
        try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_ITEMS_MENU`('item',"+pk_item+", null)"); ResultSet res = ps.executeQuery()) {
            while(res!=null&&res.next()){
                sectionModel section=new sectionModel();
                section.setPK_SECTION_MENU_PRINCIPAL(res.getInt("PK_SECTION_MENU_PRINCIPAL"));
                section.setFL_NAME_SECTION(res.getString("FL_NAME_SECTION"));
                section.setFL_DESCRIPTION(res.getString("FL_DESCRIPTION"));
                section.setFL_URL(res.getString("FL_URL"));
                section.setFL_ICON(res.getString("FL_ICON"));
                section.setFL_ITEM_ID(res.getString("FL_ITEM_ID"));
                section.setPK_PARENT(res.getInt("FK_SECTION_MENU_PRINCIPAL"));
                list.add(section);
            }
            res.close();
            ps.close();
            conn.close();
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(sectionModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
}
