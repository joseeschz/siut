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
public class debtDetailModel {
    int PK_DEBT_DETAIL=0;
    studentModel studentMdl;
    String FL_ROW_DATE="";
    String FL_MOUNT="";
    debtModel debtMdl;
    String FL_MOTIVE="";
    periodModel periodMdl;    
    String FL_STATUS_NOW_DEBT="";

    public int getPK_DEBT_DETAIL() {
        return PK_DEBT_DETAIL;
    }

    public void setPK_DEBT_DETAIL(int PK_DEBT_DETAIL) {
        this.PK_DEBT_DETAIL = PK_DEBT_DETAIL;
    }

    public studentModel getStudentMdl() {
        return studentMdl;
    }

    public void setStudentMdl(studentModel studentMdl) {
        this.studentMdl = studentMdl;
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

    public debtModel getDebtMdl() {
        return debtMdl;
    }

    public void setDebtMdl(debtModel debtMdl) {
        this.debtMdl = debtMdl;
    }

    public String getFL_MOTIVE() {
        return FL_MOTIVE;
    }

    public void setFL_MOTIVE(String FL_MOTIVE) {
        this.FL_MOTIVE = FL_MOTIVE;
    }

    public periodModel getPeriodMdl() {
        return periodMdl;
    }

    public void setPeriodMdl(periodModel periodMdl) {
        this.periodMdl = periodMdl;
    }

    public String getFL_STATUS_NOW_DEBT() {
        return FL_STATUS_NOW_DEBT;
    }

    public void setFL_STATUS_NOW_DEBT(String FL_STATUS_NOW_DEBT) {
        this.FL_STATUS_NOW_DEBT = FL_STATUS_NOW_DEBT;
    }
    
}
