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
public class careerModel {
    int PK_CAREER = 0;
    String FL_NAME_CAREER = "";
    String FL_NAME_ABBREVIATED = "";
    String FL_STATUS = "";
    int FK_LEVEL = 0;

    public int getPK_CAREER() {
        return PK_CAREER;
    }

    public void setPK_CAREER(int PK_CAREER) {
        this.PK_CAREER = PK_CAREER;
    }

    public String getFL_NAME_CAREER() {
        return FL_NAME_CAREER;
    }

    public void setFL_NAME_CAREER(String FL_NAME_CAREER) {
        this.FL_NAME_CAREER = FL_NAME_CAREER;
    }

    public String getFL_NAME_ABBREVIATED() {
        return FL_NAME_ABBREVIATED;
    }

    public void setFL_NAME_ABBREVIATED(String FL_NAME_ABBREVIATED) {
        this.FL_NAME_ABBREVIATED = FL_NAME_ABBREVIATED;
    }

    public String getFL_STATUS() {
        return FL_STATUS;
    }

    public void setFL_STATUS(String FL_STATUS) {
        this.FL_STATUS = FL_STATUS;
    }

    public int getFK_LEVEL() {
        return FK_LEVEL;
    }

    public void setFK_LEVEL(int FK_LEVEL) {
        this.FK_LEVEL = FK_LEVEL;
    }
}
