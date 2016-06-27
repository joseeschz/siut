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
public class studentsPenaltyPaymentsModel {
    int PK_STUDENT_PAYMENT_PENALTY=0;
    String FL_DATE_PAYMENT="";
    String FL_UNIQUE="";
    periodModel period = null;
    semesterModel semester = null;
    studentModel student = null;
    careerModel career = null;
    studyLevelModel studyLevel = null;
    typeFormatModel typeFormat = null;
    String FL_TOTAL="";

    public int getPK_STUDENT_PAYMENT_PENALTY() {
        return PK_STUDENT_PAYMENT_PENALTY;
    }

    public void setPK_STUDENT_PAYMENT_PENALTY(int PK_STUDENT_PAYMENT_PENALTY) {
        this.PK_STUDENT_PAYMENT_PENALTY = PK_STUDENT_PAYMENT_PENALTY;
    }

    public String getFL_DATE_PAYMENT() {
        return FL_DATE_PAYMENT;
    }

    public void setFL_DATE_PAYMENT(String FL_DATE_PAYMENT) {
        this.FL_DATE_PAYMENT = FL_DATE_PAYMENT;
    }

    public String getFL_UNIQUE() {
        return FL_UNIQUE;
    }

    public void setFL_UNIQUE(String FL_UNIQUE) {
        this.FL_UNIQUE = FL_UNIQUE;
    }

    public periodModel getPeriod() {
        return period;
    }

    public void setPeriod(periodModel period) {
        this.period = period;
    }

    public semesterModel getSemester() {
        return semester;
    }

    public void setSemester(semesterModel semester) {
        this.semester = semester;
    }

    public studentModel getStudent() {
        return student;
    }

    public void setStudent(studentModel student) {
        this.student = student;
    }

    public careerModel getCareer() {
        return career;
    }

    public void setCareer(careerModel career) {
        this.career = career;
    }

    public studyLevelModel getStudyLevel() {
        return studyLevel;
    }

    public void setStudyLevel(studyLevelModel studyLevel) {
        this.studyLevel = studyLevel;
    }

    public typeFormatModel getTypeFormat() {
        return typeFormat;
    }

    public void setTypeFormat(typeFormatModel typeFormat) {
        this.typeFormat = typeFormat;
    }

    public String getFL_TOTAL() {
        return FL_TOTAL;
    }

    public void setFL_TOTAL(String FL_TOTAL) {
        this.FL_TOTAL = FL_TOTAL;
    }
    
}
