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
public class groupModel {
    int PK_GROUP = 0;
    String FL_NAME_GROUP = "";
    String FL_STATUS = "";
    int FK_SEMESTER = 0;
    int FK_CAREER = 0;
    int FK_GROUP = 0;

    public int getPK_GROUP() {
        return PK_GROUP;
    }

    public void setPK_GROUP(int PK_GROUP) {
        this.PK_GROUP = PK_GROUP;
    }

    public String getFL_NAME_GROUP() {
        return FL_NAME_GROUP;
    }

    public void setFL_NAME_GROUP(String FL_NAME_GROUP) {
        this.FL_NAME_GROUP = FL_NAME_GROUP;
    }

    public String getFL_STATUS() {
        return FL_STATUS;
    }

    public void setFL_STATUS(String FL_STATUS) {
        this.FL_STATUS = FL_STATUS;
    }

    public int getFK_SEMESTER() {
        return FK_SEMESTER;
    }

    public void setFK_SEMESTER(int FK_SEMESTER) {
        this.FK_SEMESTER = FK_SEMESTER;
    }

    public int getFK_CAREER() {
        return FK_CAREER;
    }

    public void setFK_CAREER(int FK_CAREER) {
        this.FK_CAREER = FK_CAREER;
    }

    public int getFK_GROUP() {
        return FK_GROUP;
    }

    public void setFK_GROUP(int FK_GROUP) {
        this.FK_GROUP = FK_GROUP;
    }
}
