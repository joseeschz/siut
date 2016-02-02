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
public class requirementsModel {
    int PK_REQUIREMENT=0;
    String FL_ORDER="";
    String FL_NAME="";
    int FK_SECTION_REQUIREMENT=0;
    String FL_FULFILLMENT="";
    String FL_PARENT="";

    public int getPK_REQUIREMENT() {
        return PK_REQUIREMENT;
    }

    public void setPK_REQUIREMENT(int PK_REQUIREMENT) {
        this.PK_REQUIREMENT = PK_REQUIREMENT;
    }

    public String getFL_ORDER() {
        return FL_ORDER;
    }

    public void setFL_ORDER(String FL_ORDER) {
        this.FL_ORDER = FL_ORDER;
    }

    public String getFL_NAME() {
        return FL_NAME;
    }

    public void setFL_NAME(String FL_NAME) {
        this.FL_NAME = FL_NAME;
    }

    public int getFK_SECTION_REQUIREMENT() {
        return FK_SECTION_REQUIREMENT;
    }

    public void setFK_SECTION_REQUIREMENT(int FK_SECTION_REQUIREMENT) {
        this.FK_SECTION_REQUIREMENT = FK_SECTION_REQUIREMENT;
    }

    public String getFL_FULFILLMENT() {
        return FL_FULFILLMENT;
    }

    public void setFL_FULFILLMENT(String FL_FULFILLMENT) {
        this.FL_FULFILLMENT = FL_FULFILLMENT;
    }

    public String getFL_PARENT() {
        return FL_PARENT;
    }

    public void setFL_PARENT(String FL_PARENT) {
        this.FL_PARENT = FL_PARENT;
    }
    
}
