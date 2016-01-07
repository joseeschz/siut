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
public class municipalityModel {
    int PK_MUNICIPALITY=0;
    String FL_NAME="";
    String FK_ENTITY="";
    String FL_NAME_ENTITY="";

    public int getPK_MUNICIPALITY() {
        return PK_MUNICIPALITY;
    }

    public void setPK_MUNICIPALITY(int PK_MUNICIPALITY) {
        this.PK_MUNICIPALITY = PK_MUNICIPALITY;
    }

    public String getFL_NAME() {
        return FL_NAME;
    }

    public void setFL_NAME(String FL_NAME) {
        this.FL_NAME = FL_NAME;
    }

    public String getFK_ENTITY() {
        return FK_ENTITY;
    }

    public void setFK_ENTITY(String FK_ENTITY) {
        this.FK_ENTITY = FK_ENTITY;
    }

    public String getFL_NAME_ENTITY() {
        return FL_NAME_ENTITY;
    }

    public void setFL_NAME_ENTITY(String FL_NAME_ENTITY) {
        this.FL_NAME_ENTITY = FL_NAME_ENTITY;
    }

}
