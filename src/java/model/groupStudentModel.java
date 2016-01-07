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
public class groupStudentModel {
    int PK_GRUPOS_BY_STUDENT = 0;
    String FL_ENROLLMENT = "";
    int FK_CAREER =0;
    int FK_SEMESTER = 0;
    int FK_GROUP = 0;
    int FK_STUDENT = 0;
    String FL_STUDENT_NAME = "";
    int FK_PERIOD = 0;
    int FK_TUTOR_TEACHER = 0;

    public int getPK_GRUPOS_BY_STUDENT() {
        return PK_GRUPOS_BY_STUDENT;
    }

    public void setPK_GRUPOS_BY_STUDENT(int PK_GRUPOS_BY_STUDENT) {
        this.PK_GRUPOS_BY_STUDENT = PK_GRUPOS_BY_STUDENT;
    }

    public String getFL_ENROLLMENT() {
        return FL_ENROLLMENT;
    }

    public void setFL_ENROLLMENT(String FL_ENROLLMENT) {
        this.FL_ENROLLMENT = FL_ENROLLMENT;
    }

    public int getFK_CAREER() {
        return FK_CAREER;
    }

    public void setFK_CAREER(int FK_CAREER) {
        this.FK_CAREER = FK_CAREER;
    }

    public int getFK_SEMESTER() {
        return FK_SEMESTER;
    }

    public void setFK_SEMESTER(int FK_SEMESTER) {
        this.FK_SEMESTER = FK_SEMESTER;
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

    public String getFL_STUDENT_NAME() {
        return FL_STUDENT_NAME;
    }

    public void setFL_STUDENT_NAME(String FL_STUDENT_NAME) {
        this.FL_STUDENT_NAME = FL_STUDENT_NAME;
    }

    public int getFK_PERIOD() {
        return FK_PERIOD;
    }

    public void setFK_PERIOD(int FK_PERIOD) {
        this.FK_PERIOD = FK_PERIOD;
    }

    public int getFK_TUTOR_TEACHER() {
        return FK_TUTOR_TEACHER;
    }

    public void setFK_TUTOR_TEACHER(int FK_TUTOR_TEACHER) {
        this.FK_TUTOR_TEACHER = FK_TUTOR_TEACHER;
    }
}
