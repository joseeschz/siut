/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author Carlos
 */
public class periodModel {
    int PK_PERIOD = 0;
    String FL_NAME = "";
    String FL_NAME_ABBREVIATED = "";
    int FL_ACTIVE = 0;
    int FL_YEAR_ACTIVE = 0;

    public int getPK_PERIOD() {
        return PK_PERIOD;
    }

    public void setPK_PERIOD(int PK_PERIOD) {
        this.PK_PERIOD = PK_PERIOD;
    }

    public String getFL_NAME() {
        return FL_NAME;
    }

    public void setFL_NAME(String FL_NAME) {
        this.FL_NAME = FL_NAME;
    }

    public String getFL_NAME_ABBREVIATED() {
        return FL_NAME_ABBREVIATED;
    }

    public void setFL_NAME_ABBREVIATED(String FL_NAME_ABBREVIATED) {
        this.FL_NAME_ABBREVIATED = FL_NAME_ABBREVIATED;
    }

    public int getFL_ACTIVE() {
        return FL_ACTIVE;
    }

    public void setFL_ACTIVE(int FL_ACTIVE) {
        this.FL_ACTIVE = FL_ACTIVE;
    }

    public int getFL_YEAR_ACTIVE() {
        return FL_YEAR_ACTIVE;
    }

    public void setFL_YEAR_ACTIVE(int FL_YEAR_ACTIVE) {
        this.FL_YEAR_ACTIVE = FL_YEAR_ACTIVE;
    }
}
