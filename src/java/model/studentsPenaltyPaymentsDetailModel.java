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
public class studentsPenaltyPaymentsDetailModel {
    int PK_STUDENT_PENALTY_PAYMENT_DETAIL=0;
    String FL_UNIQUE="";
    studentModel student= null;
    semesterModel semester = null;
    periodModel period = null;
    studentsPenaltyPaymentsModel studentPenalityPayment = null;
    paymentsPenaltyTypesModel paymentTypes = null;
    categoryPaymentsModel categoryPayments = null;
    String FL_AMOUNT_PENALITY = "";
    String FL_REFERENCE_NUMBER="";
    int FL_STATUS_JUSTIFY=0;
    String FL_STATUS_PAY="";
    String FL_MOTIVE_JUSTIFY="";
    String FK_TYPE_CONCEPT="";
    String FK_TYPE_FORMAT="";

    public int getPK_STUDENT_PENALTY_PAYMENT_DETAIL() {
        return PK_STUDENT_PENALTY_PAYMENT_DETAIL;
    }

    public void setPK_STUDENT_PENALTY_PAYMENT_DETAIL(int PK_STUDENT_PENALTY_PAYMENT_DETAIL) {
        this.PK_STUDENT_PENALTY_PAYMENT_DETAIL = PK_STUDENT_PENALTY_PAYMENT_DETAIL;
    }

    public String getFL_UNIQUE() {
        return FL_UNIQUE;
    }

    public void setFL_UNIQUE(String FL_UNIQUE) {
        this.FL_UNIQUE = FL_UNIQUE;
    }

    public studentModel getStudent() {
        return student;
    }

    public void setStudent(studentModel student) {
        this.student = student;
    }

    public semesterModel getSemester() {
        return semester;
    }

    public void setSemester(semesterModel semester) {
        this.semester = semester;
    }

    public periodModel getPeriod() {
        return period;
    }

    public void setPeriod(periodModel period) {
        this.period = period;
    }

    public studentsPenaltyPaymentsModel getStudentPenalityPayment() {
        return studentPenalityPayment;
    }

    public void setStudentPenalityPayment(studentsPenaltyPaymentsModel studentPenalityPayment) {
        this.studentPenalityPayment = studentPenalityPayment;
    }

    public paymentsPenaltyTypesModel getPaymentTypes() {
        return paymentTypes;
    }

    public void setPaymentTypes(paymentsPenaltyTypesModel paymentTypes) {
        this.paymentTypes = paymentTypes;
    }

    public categoryPaymentsModel getCategoryPayments() {
        return categoryPayments;
    }

    public void setCategoryPayments(categoryPaymentsModel categoryPayments) {
        this.categoryPayments = categoryPayments;
    }

    public String getFL_AMOUNT_PENALITY() {
        return FL_AMOUNT_PENALITY;
    }

    public void setFL_AMOUNT_PENALITY(String FL_AMOUNT_PENALITY) {
        this.FL_AMOUNT_PENALITY = FL_AMOUNT_PENALITY;
    }

    public String getFL_REFERENCE_NUMBER() {
        return FL_REFERENCE_NUMBER;
    }

    public void setFL_REFERENCE_NUMBER(String FL_REFERENCE_NUMBER) {
        this.FL_REFERENCE_NUMBER = FL_REFERENCE_NUMBER;
    }

    public int getFL_STATUS_JUSTIFY() {
        return FL_STATUS_JUSTIFY;
    }

    public void setFL_STATUS_JUSTIFY(int FL_STATUS_JUSTIFY) {
        this.FL_STATUS_JUSTIFY = FL_STATUS_JUSTIFY;
    }

    public String getFL_STATUS_PAY() {
        return FL_STATUS_PAY;
    }

    public void setFL_STATUS_PAY(String FL_STATUS_PAY) {
        this.FL_STATUS_PAY = FL_STATUS_PAY;
    }

    public String getFL_MOTIVE_JUSTIFY() {
        return FL_MOTIVE_JUSTIFY;
    }

    public void setFL_MOTIVE_JUSTIFY(String FL_MOTIVE_JUSTIFY) {
        this.FL_MOTIVE_JUSTIFY = FL_MOTIVE_JUSTIFY;
    }

    public String getFK_TYPE_CONCEPT() {
        return FK_TYPE_CONCEPT;
    }

    public void setFK_TYPE_CONCEPT(String FK_TYPE_CONCEPT) {
        this.FK_TYPE_CONCEPT = FK_TYPE_CONCEPT;
    }

    public String getFK_TYPE_FORMAT() {
        return FK_TYPE_FORMAT;
    }

    public void setFK_TYPE_FORMAT(String FK_TYPE_FORMAT) {
        this.FK_TYPE_FORMAT = FK_TYPE_FORMAT;
    }
    
}
