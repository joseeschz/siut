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
public class reportBoxCutDetailModel {
    int PK_REPORT_BOX_CUT_DETAIL=0;
    int FK_DENOMINATION=0;
    String FL_CONCEPT = "";
    int FL_CANT=0;
    String FL_TOTAL="";
    int FK_REPORT_BOX_CUT=0;

    public int getPK_REPORT_BOX_CUT_DETAIL() {
        return PK_REPORT_BOX_CUT_DETAIL;
    }

    public void setPK_REPORT_BOX_CUT_DETAIL(int PK_REPORT_BOX_CUT_DETAIL) {
        this.PK_REPORT_BOX_CUT_DETAIL = PK_REPORT_BOX_CUT_DETAIL;
    }

    public int getFK_DENOMINATION() {
        return FK_DENOMINATION;
    }

    public void setFK_DENOMINATION(int FK_DENOMINATION) {
        this.FK_DENOMINATION = FK_DENOMINATION;
    }

    public String getFL_CONCEPT() {
        return FL_CONCEPT;
    }

    public void setFL_CONCEPT(String FL_CONCEPT) {
        this.FL_CONCEPT = FL_CONCEPT;
    }

    public int getFL_CANT() {
        return FL_CANT;
    }

    public void setFL_CANT(int FL_CANT) {
        this.FL_CANT = FL_CANT;
    }

    public String getFL_TOTAL() {
        return FL_TOTAL;
    }

    public void setFL_TOTAL(String FL_TOTAL) {
        this.FL_TOTAL = FL_TOTAL;
    }

    public int getFK_REPORT_BOX_CUT() {
        return FK_REPORT_BOX_CUT;
    }

    public void setFK_REPORT_BOX_CUT(int FK_REPORT_BOX_CUT) {
        this.FK_REPORT_BOX_CUT = FK_REPORT_BOX_CUT;
    }
    
}
