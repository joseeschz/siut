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
public class localityModel {
    int PK_LOCALITY=0;
    String FL_NAME="";
    String FK_ENTITY="";
    String FK_MUNICIPALITY="";
    String FL_NAME_MUNICIPALITY="";

    public int getPK_LOCALITY() {
        return PK_LOCALITY;
    }

    public void setPK_LOCALITY(int PK_LOCALITY) {
        this.PK_LOCALITY = PK_LOCALITY;
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

    public String getFK_MUNICIPALITY() {
        return FK_MUNICIPALITY;
    }

    public void setFK_MUNICIPALITY(String FK_MUNICIPALITY) {
        this.FK_MUNICIPALITY = FK_MUNICIPALITY;
    }

    public String getFL_NAME_MUNICIPALITY() {
        return FL_NAME_MUNICIPALITY;
    }

    public void setFL_NAME_MUNICIPALITY(String FL_NAME_MUNICIPALITY) {
        this.FL_NAME_MUNICIPALITY = FL_NAME_MUNICIPALITY;
    }
}
