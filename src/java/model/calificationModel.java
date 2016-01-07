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
public class calificationModel extends subjectMattersModel{
    int PK_CALIFICATION=0;
    int FK_PERIOD=0;
    int FK_EVALUATION_TYPE=0;
    int FK_TEACHER=0;
    int FK_CAREER=0;
    int FK_MATTER=0;
    int FK_GROUP=0;
    int FK_STUDENT=0;
    String FL_ENROLLMENT="";
    String FL_NAME="";
    String FL_CALIFICATION_BE="";
    String FL_CALIFICATION_KNOW="";
    String FL_CALIFICATION_DO="";
    String FL_AVG="";
    String FL_LETTER="";
    String FL_SUBJECT_MATTERS_CALIFICATIONS="";
    String FL_NAME_DESCRIPTION_INTEGRADORAS="";
    String FL_NAME_DESCRIPTION_NOT_INTEGRADORAS="";

    public int getPK_CALIFICATION() {
        return PK_CALIFICATION;
    }

    public void setPK_CALIFICATION(int PK_CALIFICATION) {
        this.PK_CALIFICATION = PK_CALIFICATION;
    }

    public int getFK_PERIOD() {
        return FK_PERIOD;
    }

    public void setFK_PERIOD(int FK_PERIOD) {
        this.FK_PERIOD = FK_PERIOD;
    }

    public int getFK_EVALUATION_TYPE() {
        return FK_EVALUATION_TYPE;
    }

    public void setFK_EVALUATION_TYPE(int FK_EVALUATION_TYPE) {
        this.FK_EVALUATION_TYPE = FK_EVALUATION_TYPE;
    }

    public int getFK_TEACHER() {
        return FK_TEACHER;
    }

    public void setFK_TEACHER(int FK_TEACHER) {
        this.FK_TEACHER = FK_TEACHER;
    }

    public int getFK_CAREER() {
        return FK_CAREER;
    }

    public void setFK_CAREER(int FK_CAREER) {
        this.FK_CAREER = FK_CAREER;
    }

    public int getFK_MATTER() {
        return FK_MATTER;
    }

    public void setFK_MATTER(int FK_MATTER) {
        this.FK_MATTER = FK_MATTER;
    }

    public int getFK_GROUP() {
        return FK_GROUP;
    }

    public void setFK_GROUP(int FK_GROUP) {
        this.FK_GROUP = FK_GROUP;
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

    public String getFL_NAME() {
        return FL_NAME;
    }

    public void setFL_NAME(String FL_NAME) {
        this.FL_NAME = FL_NAME;
    }

    public String getFL_CALIFICATION_BE() {
        return FL_CALIFICATION_BE;
    }

    public void setFL_CALIFICATION_BE(String FL_CALIFICATION_BE) {
        this.FL_CALIFICATION_BE = FL_CALIFICATION_BE;
    }

    public String getFL_CALIFICATION_KNOW() {
        return FL_CALIFICATION_KNOW;
    }

    public void setFL_CALIFICATION_KNOW(String FL_CALIFICATION_KNOW) {
        this.FL_CALIFICATION_KNOW = FL_CALIFICATION_KNOW;
    }

    public String getFL_CALIFICATION_DO() {
        return FL_CALIFICATION_DO;
    }

    public void setFL_CALIFICATION_DO(String FL_CALIFICATION_DO) {
        this.FL_CALIFICATION_DO = FL_CALIFICATION_DO;
    }

    public String getFL_AVG() {
        return FL_AVG;
    }

    public void setFL_AVG(String FL_AVG) {
        this.FL_AVG = FL_AVG;
    }

    public String getFL_LETTER() {
        return FL_LETTER;
    }

    public void setFL_LETTER(String FL_LETTER) {
        this.FL_LETTER = FL_LETTER;
    }

    public String getFL_SUBJECT_MATTERS_CALIFICATIONS() {
        return FL_SUBJECT_MATTERS_CALIFICATIONS;
    }

    public void setFL_SUBJECT_MATTERS_CALIFICATIONS(String FL_SUBJECT_MATTERS_CALIFICATIONS) {
        this.FL_SUBJECT_MATTERS_CALIFICATIONS = FL_SUBJECT_MATTERS_CALIFICATIONS;
    }

    public String getFL_NAME_DESCRIPTION_INTEGRADORAS() {
        return FL_NAME_DESCRIPTION_INTEGRADORAS;
    }

    public void setFL_NAME_DESCRIPTION_INTEGRADORAS(String FL_NAME_DESCRIPTION_INTEGRADORAS) {
        this.FL_NAME_DESCRIPTION_INTEGRADORAS = FL_NAME_DESCRIPTION_INTEGRADORAS;
    }

    public String getFL_NAME_DESCRIPTION_NOT_INTEGRADORAS() {
        return FL_NAME_DESCRIPTION_NOT_INTEGRADORAS;
    }

    public void setFL_NAME_DESCRIPTION_NOT_INTEGRADORAS(String FL_NAME_DESCRIPTION_NOT_INTEGRADORAS) {
        this.FL_NAME_DESCRIPTION_NOT_INTEGRADORAS = FL_NAME_DESCRIPTION_NOT_INTEGRADORAS;
    }
}
