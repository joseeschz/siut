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
public class activitiesByStudentsModel extends activitiesToGroupModel{
    String PK_ACTIVITY_BY_STUDENT="";
    String PK_CALIFICATIONS_OF_STUDEN_BY_MATTER="";
    int FK_ACTIVITY=0;
    int FK_STUDENT=0;
    String FL_ENROLLMENT="";
    String FL_NAME_STUDENT="";
    String FL_VALUE_OBTANIED_OLD = "";
    String FL_VALUE_OBTANIED="";
    String FL_VALUE_OBTANIED_EQUIVALENT="";
    String FL_ACUMULATED_NOW ="";
    String FL_APPROVED ="";
    String FL_VALUE_OBTANIED_ACUMULATED_BE="";
    String FL_VALUE_OBTANIED_ACUMULATED_KNOW="";
    String FL_VALUE_OBTANIED_ACUMULATED_DO="";
    String FL_VALUE_OBTANIED_ACUMULATED_TOTAL="";
    String FL_VALUE_OBTANIED_REGULARIZATION_BE="";
    String FL_VALUE_OBTANIED_REGULARIZATION_KNOW="";
    String FL_VALUE_OBTANIED_REGULARIZATION_DO="";
    String FL_VALUE_OBTANIED_REGULARIZATION_TOTAL="";
    String FL_VALUE_OBTANIED_GLOBAL_BE="";
    String FL_VALUE_OBTANIED_GLOBAL_KNOW="";
    String FL_VALUE_OBTANIED_GLOBAL_DO="";
    String FL_VALUE_OBTANIED_GLOBAL_TOTAL="";

    public String getPK_ACTIVITY_BY_STUDENT() {
        return PK_ACTIVITY_BY_STUDENT;
    }

    public void setPK_ACTIVITY_BY_STUDENT(String PK_ACTIVITY_BY_STUDENT) {
        this.PK_ACTIVITY_BY_STUDENT = PK_ACTIVITY_BY_STUDENT;
    }

    public String getPK_CALIFICATIONS_OF_STUDEN_BY_MATTER() {
        return PK_CALIFICATIONS_OF_STUDEN_BY_MATTER;
    }

    public void setPK_CALIFICATIONS_OF_STUDEN_BY_MATTER(String PK_CALIFICATIONS_OF_STUDEN_BY_MATTER) {
        this.PK_CALIFICATIONS_OF_STUDEN_BY_MATTER = PK_CALIFICATIONS_OF_STUDEN_BY_MATTER;
    }

    public int getFK_ACTIVITY() {
        return FK_ACTIVITY;
    }

    public void setFK_ACTIVITY(int FK_ACTIVITY) {
        this.FK_ACTIVITY = FK_ACTIVITY;
    }

    public int getFK_STUDENT() {
        return FK_STUDENT;
    }

    public void setFK_STUDENT(int FK_STUDENT) {
        this.FK_STUDENT = FK_STUDENT;
    }

    public String getFL_ENROLLMENT() {
        return FL_ENROLLMENT;
    }

    public void setFL_ENROLLMENT(String FL_ENROLLMENT) {
        this.FL_ENROLLMENT = FL_ENROLLMENT;
    }

    public String getFL_NAME_STUDENT() {
        return FL_NAME_STUDENT;
    }

    public void setFL_NAME_STUDENT(String FL_NAME_STUDENT) {
        this.FL_NAME_STUDENT = FL_NAME_STUDENT;
    }

    public String getFL_VALUE_OBTANIED_OLD() {
        return FL_VALUE_OBTANIED_OLD;
    }

    public void setFL_VALUE_OBTANIED_OLD(String FL_VALUE_OBTANIED_OLD) {
        this.FL_VALUE_OBTANIED_OLD = FL_VALUE_OBTANIED_OLD;
    }

    public String getFL_VALUE_OBTANIED() {
        return FL_VALUE_OBTANIED;
    }

    public void setFL_VALUE_OBTANIED(String FL_VALUE_OBTANIED) {
        this.FL_VALUE_OBTANIED = FL_VALUE_OBTANIED;
    }

    public String getFL_VALUE_OBTANIED_EQUIVALENT() {
        return FL_VALUE_OBTANIED_EQUIVALENT;
    }

    public void setFL_VALUE_OBTANIED_EQUIVALENT(String FL_VALUE_OBTANIED_EQUIVALENT) {
        this.FL_VALUE_OBTANIED_EQUIVALENT = FL_VALUE_OBTANIED_EQUIVALENT;
    }

    public String getFL_ACUMULATED_NOW() {
        return FL_ACUMULATED_NOW;
    }

    public void setFL_ACUMULATED_NOW(String FL_ACUMULATED_NOW) {
        this.FL_ACUMULATED_NOW = FL_ACUMULATED_NOW;
    }

    public String getFL_APPROVED() {
        return FL_APPROVED;
    }

    public void setFL_APPROVED(String FL_APPROVED) {
        this.FL_APPROVED = FL_APPROVED;
    }

    public String getFL_VALUE_OBTANIED_ACUMULATED_BE() {
        return FL_VALUE_OBTANIED_ACUMULATED_BE;
    }

    public void setFL_VALUE_OBTANIED_ACUMULATED_BE(String FL_VALUE_OBTANIED_ACUMULATED_BE) {
        this.FL_VALUE_OBTANIED_ACUMULATED_BE = FL_VALUE_OBTANIED_ACUMULATED_BE;
    }

    public String getFL_VALUE_OBTANIED_ACUMULATED_KNOW() {
        return FL_VALUE_OBTANIED_ACUMULATED_KNOW;
    }

    public void setFL_VALUE_OBTANIED_ACUMULATED_KNOW(String FL_VALUE_OBTANIED_ACUMULATED_KNOW) {
        this.FL_VALUE_OBTANIED_ACUMULATED_KNOW = FL_VALUE_OBTANIED_ACUMULATED_KNOW;
    }

    public String getFL_VALUE_OBTANIED_ACUMULATED_DO() {
        return FL_VALUE_OBTANIED_ACUMULATED_DO;
    }

    public void setFL_VALUE_OBTANIED_ACUMULATED_DO(String FL_VALUE_OBTANIED_ACUMULATED_DO) {
        this.FL_VALUE_OBTANIED_ACUMULATED_DO = FL_VALUE_OBTANIED_ACUMULATED_DO;
    }

    public String getFL_VALUE_OBTANIED_ACUMULATED_TOTAL() {
        return FL_VALUE_OBTANIED_ACUMULATED_TOTAL;
    }

    public void setFL_VALUE_OBTANIED_ACUMULATED_TOTAL(String FL_VALUE_OBTANIED_ACUMULATED_TOTAL) {
        this.FL_VALUE_OBTANIED_ACUMULATED_TOTAL = FL_VALUE_OBTANIED_ACUMULATED_TOTAL;
    }

    public String getFL_VALUE_OBTANIED_REGULARIZATION_BE() {
        return FL_VALUE_OBTANIED_REGULARIZATION_BE;
    }

    public void setFL_VALUE_OBTANIED_REGULARIZATION_BE(String FL_VALUE_OBTANIED_REGULARIZATION_BE) {
        this.FL_VALUE_OBTANIED_REGULARIZATION_BE = FL_VALUE_OBTANIED_REGULARIZATION_BE;
    }

    public String getFL_VALUE_OBTANIED_REGULARIZATION_KNOW() {
        return FL_VALUE_OBTANIED_REGULARIZATION_KNOW;
    }

    public void setFL_VALUE_OBTANIED_REGULARIZATION_KNOW(String FL_VALUE_OBTANIED_REGULARIZATION_KNOW) {
        this.FL_VALUE_OBTANIED_REGULARIZATION_KNOW = FL_VALUE_OBTANIED_REGULARIZATION_KNOW;
    }

    public String getFL_VALUE_OBTANIED_REGULARIZATION_DO() {
        return FL_VALUE_OBTANIED_REGULARIZATION_DO;
    }

    public void setFL_VALUE_OBTANIED_REGULARIZATION_DO(String FL_VALUE_OBTANIED_REGULARIZATION_DO) {
        this.FL_VALUE_OBTANIED_REGULARIZATION_DO = FL_VALUE_OBTANIED_REGULARIZATION_DO;
    }

    public String getFL_VALUE_OBTANIED_REGULARIZATION_TOTAL() {
        return FL_VALUE_OBTANIED_REGULARIZATION_TOTAL;
    }

    public void setFL_VALUE_OBTANIED_REGULARIZATION_TOTAL(String FL_VALUE_OBTANIED_REGULARIZATION_TOTAL) {
        this.FL_VALUE_OBTANIED_REGULARIZATION_TOTAL = FL_VALUE_OBTANIED_REGULARIZATION_TOTAL;
    }

    public String getFL_VALUE_OBTANIED_GLOBAL_BE() {
        return FL_VALUE_OBTANIED_GLOBAL_BE;
    }

    public void setFL_VALUE_OBTANIED_GLOBAL_BE(String FL_VALUE_OBTANIED_GLOBAL_BE) {
        this.FL_VALUE_OBTANIED_GLOBAL_BE = FL_VALUE_OBTANIED_GLOBAL_BE;
    }

    public String getFL_VALUE_OBTANIED_GLOBAL_KNOW() {
        return FL_VALUE_OBTANIED_GLOBAL_KNOW;
    }

    public void setFL_VALUE_OBTANIED_GLOBAL_KNOW(String FL_VALUE_OBTANIED_GLOBAL_KNOW) {
        this.FL_VALUE_OBTANIED_GLOBAL_KNOW = FL_VALUE_OBTANIED_GLOBAL_KNOW;
    }

    public String getFL_VALUE_OBTANIED_GLOBAL_DO() {
        return FL_VALUE_OBTANIED_GLOBAL_DO;
    }

    public void setFL_VALUE_OBTANIED_GLOBAL_DO(String FL_VALUE_OBTANIED_GLOBAL_DO) {
        this.FL_VALUE_OBTANIED_GLOBAL_DO = FL_VALUE_OBTANIED_GLOBAL_DO;
    }

    public String getFL_VALUE_OBTANIED_GLOBAL_TOTAL() {
        return FL_VALUE_OBTANIED_GLOBAL_TOTAL;
    }

    public void setFL_VALUE_OBTANIED_GLOBAL_TOTAL(String FL_VALUE_OBTANIED_GLOBAL_TOTAL) {
        this.FL_VALUE_OBTANIED_GLOBAL_TOTAL = FL_VALUE_OBTANIED_GLOBAL_TOTAL;
    }
}
