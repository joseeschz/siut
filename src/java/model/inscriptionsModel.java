/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author Lab5-E
 */
public class inscriptionsModel extends careerModel{
    int PK_TOP_INSCRIPTION=0;
    int FK_PERIOD=0;
    String FL_TOP="";

    public int getPK_TOP_INSCRIPTION() {
        return PK_TOP_INSCRIPTION;
    }

    public void setPK_TOP_INSCRIPTION(int PK_TOP_INSCRIPTION) {
        this.PK_TOP_INSCRIPTION = PK_TOP_INSCRIPTION;
    }

    public int getFK_PERIOD() {
        return FK_PERIOD;
    }

    public void setFK_PERIOD(int FK_PERIOD) {
        this.FK_PERIOD = FK_PERIOD;
    }

    public String getFL_TOP() {
        return FL_TOP;
    }

    public void setFL_TOP(String FL_TOP) {
        this.FL_TOP = FL_TOP;
    }
}
