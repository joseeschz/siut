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
public class reportBoxCutModel {
    int PK_BOX_CUT =0;
    String FL_NUMBER="";
    String FL_DATE_BEGIN="";
    String FL_DATE_END="";
    String FL_DATE_ROW="";
    int FK_PERIOD=0;

    public int getPK_BOX_CUT() {
        return PK_BOX_CUT;
    }

    public void setPK_BOX_CUT(int PK_BOX_CUT) {
        this.PK_BOX_CUT = PK_BOX_CUT;
    }

    public String getFL_NUMBER() {
        return FL_NUMBER;
    }

    public void setFL_NUMBER(String FL_NUMBER) {
        this.FL_NUMBER = FL_NUMBER;
    }

    public String getFL_DATE_BEGIN() {
        return FL_DATE_BEGIN;
    }

    public void setFL_DATE_BEGIN(String FL_DATE_BEGIN) {
        this.FL_DATE_BEGIN = FL_DATE_BEGIN;
    }

    public String getFL_DATE_END() {
        return FL_DATE_END;
    }

    public void setFL_DATE_END(String FL_DATE_END) {
        this.FL_DATE_END = FL_DATE_END;
    }

    public String getFL_DATE_ROW() {
        return FL_DATE_ROW;
    }

    public void setFL_DATE_ROW(String FL_DATE_ROW) {
        this.FL_DATE_ROW = FL_DATE_ROW;
    }

    public int getFK_PERIOD() {
        return FK_PERIOD;
    }

    public void setFK_PERIOD(int FK_PERIOD) {
        this.FK_PERIOD = FK_PERIOD;
    }
}
