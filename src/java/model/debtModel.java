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
public class debtModel {
    int PK_DEBT=0;
    int FK_STUDENT=0;
    String FL_ROW_DATE="";
    String FL_STATUS_NOW_DEBT="";
    studentModel studentMdl;
    careerModel careerMdl;
    studyLevelModel studyLevelMdl;

    public int getPK_DEBT() {
        return PK_DEBT;
    }

    public void setPK_DEBT(int PK_DEBT) {
        this.PK_DEBT = PK_DEBT;
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

    public String getFL_STATUS_NOW_DEBT() {
        return FL_STATUS_NOW_DEBT;
    }

    public void setFL_STATUS_NOW_DEBT(String FL_STATUS_NOW_DEBT) {
        this.FL_STATUS_NOW_DEBT = FL_STATUS_NOW_DEBT;
    }

    public studentModel getStudentMdl() {
        return studentMdl;
    }

    public void setStudentMdl(studentModel studentMdl) {
        this.studentMdl = studentMdl;
    }

    public careerModel getCareerMdl() {
        return careerMdl;
    }

    public void setCareerMdl(careerModel careerMdl) {
        this.careerMdl = careerMdl;
    }

    public studyLevelModel getStudyLevelMdl() {
        return studyLevelMdl;
    }

    public void setStudyLevelMdl(studyLevelModel studyLevelMdl) {
        this.studyLevelMdl = studyLevelMdl;
    }
    
}
