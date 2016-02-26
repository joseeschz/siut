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
    int FK_ACTIVITY=0;
    int FK_STUDENT=0;
    String FL_ENROLLMENT="";
    String FL_NAME_STUDENT="";
    String FL_VALUE_OBTANIED_OLD = "";
    String FL_VALUE_OBTANIED="";
    String FL_VALUE_OBTANIED_EQUIVALENT="";
    String FL_ACUMULATED_NOW ="";
    String FL_APPROVED ="";

    public String getPK_ACTIVITY_BY_STUDENT() {
        return PK_ACTIVITY_BY_STUDENT;
    }

    public void setPK_ACTIVITY_BY_STUDENT(String PK_ACTIVITY_BY_STUDENT) {
        this.PK_ACTIVITY_BY_STUDENT = PK_ACTIVITY_BY_STUDENT;
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
}
