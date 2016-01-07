/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author CARLOS
 */
public class sectionModel {
    int PK_SECTION_MENU_PRINCIPAL = 0;
    String FL_NAME_SECTION = "";
    String FL_DESCRIPTION ="";
    String FL_URL = "";
    String FL_ITEM_ID ="";
    String FL_ICON="";
    int PK_PARENT = 0;
    int FL_ACCESS=0;

    public int getPK_SECTION_MENU_PRINCIPAL() {
        return PK_SECTION_MENU_PRINCIPAL;
    }

    public void setPK_SECTION_MENU_PRINCIPAL(int PK_SECTION_MENU_PRINCIPAL) {
        this.PK_SECTION_MENU_PRINCIPAL = PK_SECTION_MENU_PRINCIPAL;
    }

    public String getFL_NAME_SECTION() {
        return FL_NAME_SECTION;
    }

    public void setFL_NAME_SECTION(String FL_NAME_SECTION) {
        this.FL_NAME_SECTION = FL_NAME_SECTION;
    }

    public String getFL_DESCRIPTION() {
        return FL_DESCRIPTION;
    }

    public void setFL_DESCRIPTION(String FL_DESCRIPTION) {
        this.FL_DESCRIPTION = FL_DESCRIPTION;
    }

    public String getFL_URL() {
        return FL_URL;
    }

    public void setFL_URL(String FL_URL) {
        this.FL_URL = FL_URL;
    }

    public String getFL_ITEM_ID() {
        return FL_ITEM_ID;
    }

    public void setFL_ITEM_ID(String FL_ITEM_ID) {
        this.FL_ITEM_ID = FL_ITEM_ID;
    }

    public String getFL_ICON() {
        return FL_ICON;
    }

    public void setFL_ICON(String FL_ICON) {
        this.FL_ICON = FL_ICON;
    }

    public int getPK_PARENT() {
        return PK_PARENT;
    }

    public void setPK_PARENT(int PK_PARENT) {
        this.PK_PARENT = PK_PARENT;
    }

    public int getFL_ACCESS() {
        return FL_ACCESS;
    }

    public void setFL_ACCESS(int FL_ACCESS) {
        this.FL_ACCESS = FL_ACCESS;
    }
}
