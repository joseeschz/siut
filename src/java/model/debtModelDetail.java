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
public class debtModelDetail {
    int PK_DEBT_DETAIL=0;
    int FK_STUDENT=0;
    String FL_ROW_DATE="";
    String FL_MOUNT="";
    int FK_DEBT=0;
    String FL_MOTIVE="";
    periodModel periMdl;    
    String FL_STATUS_NOW_DEBT="";

    public int getPK_DEBT_DETAIL() {
        return PK_DEBT_DETAIL;
    }

    public void setPK_DEBT_DETAIL(int PK_DEBT_DETAIL) {
        this.PK_DEBT_DETAIL = PK_DEBT_DETAIL;
    }

    public int getFK_STUDENT() {
        return FK_STUDENT;
    }

    public void setFK_STUDENT(int FK_STUDENT) {
        this.FK_STUDENT = FK_STUDENT;
    }

    public String getFL_ROW_DATE() {
        return FL_ROW_DATE;
    }

    public void setFL_ROW_DATE(String FL_ROW_DATE) {
        this.FL_ROW_DATE = FL_ROW_DATE;
    }

    public String getFL_MOUNT() {
        return FL_MOUNT;
    }

    public void setFL_MOUNT(String FL_MOUNT) {
        this.FL_MOUNT = FL_MOUNT;
    }

    public int getFK_DEBT() {
        return FK_DEBT;
    }

    public void setFK_DEBT(int FK_DEBT) {
        this.FK_DEBT = FK_DEBT;
    }

    public String getFL_MOTIVE() {
        return FL_MOTIVE;
    }

    public void setFL_MOTIVE(String FL_MOTIVE) {
        this.FL_MOTIVE = FL_MOTIVE;
    }

    public periodModel getPeriMdl() {
        return periMdl;
    }

    public void setPeriMdl(periodModel periMdl) {
        this.periMdl = periMdl;
    }

    public String getFL_STATUS_NOW_DEBT() {
        return FL_STATUS_NOW_DEBT;
    }

    public void setFL_STATUS_NOW_DEBT(String FL_STATUS_NOW_DEBT) {
        this.FL_STATUS_NOW_DEBT = FL_STATUS_NOW_DEBT;
    }
}
