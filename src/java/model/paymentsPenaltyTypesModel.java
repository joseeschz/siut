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
public class paymentsPenaltyTypesModel {
    int PK_PAYMENT_PENALTY_TYPE=0;
    String FL_NAME_PENALTY="";
    String FL_TARIFF="";
    studyLevelModel studyLevel = null;
    semesterModel semester = null;
    categoryPaymentsModel category = null;
    periodModel period = null;
    int FL_STATUS_PREPAI=0;

    public int getPK_PAYMENT_PENALTY_TYPE() {
        return PK_PAYMENT_PENALTY_TYPE;
    }

    public void setPK_PAYMENT_PENALTY_TYPE(int PK_PAYMENT_PENALTY_TYPE) {
        this.PK_PAYMENT_PENALTY_TYPE = PK_PAYMENT_PENALTY_TYPE;
    }

    public String getFL_NAME_PENALTY() {
        return FL_NAME_PENALTY;
    }

    public void setFL_NAME_PENALTY(String FL_NAME_PENALTY) {
        this.FL_NAME_PENALTY = FL_NAME_PENALTY;
    }

    public String getFL_TARIFF() {
        return FL_TARIFF;
    }

    public void setFL_TARIFF(String FL_TARIFF) {
        this.FL_TARIFF = FL_TARIFF;
    }

    public studyLevelModel getStudyLevel() {
        return studyLevel;
    }

    public void setStudyLevel(studyLevelModel studyLevel) {
        this.studyLevel = studyLevel;
    }

    public semesterModel getSemester() {
        return semester;
    }

    public void setSemester(semesterModel semester) {
        this.semester = semester;
    }

    public categoryPaymentsModel getCategory() {
        return category;
    }

    public void setCategory(categoryPaymentsModel category) {
        this.category = category;
    }

    public periodModel getPeriod() {
        return period;
    }

    public void setPeriod(periodModel period) {
        this.period = period;
    }

    public int getFL_STATUS_PREPAI() {
        return FL_STATUS_PREPAI;
    }

    public void setFL_STATUS_PREPAI(int FL_STATUS_PREPAI) {
        this.FL_STATUS_PREPAI = FL_STATUS_PREPAI;
    }
    
}
