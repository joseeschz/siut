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
public class groupMatterTeacherModel {
    int PK_GROUP_MATTER_TECHER = 0;
    int FK_CAREER = 0;
    int FK_PERIOD = 0;
    int FK_SEMESTER = 0;
    String FL_NAME_SEMESTER = "";
    int FK_GROUP = 0;
    String FL_NAME_GROUP = "";
    int FK_SUBJECT_MATTER = 0;
    String FL_NAME_SUBJECT_MATTER = "";
    int FK_TEACHER = 0;
    String FL_NAME_TEACHER = "";

    public int getPK_GROUP_MATTER_TECHER() {
        return PK_GROUP_MATTER_TECHER;
    }

    public void setPK_GROUP_MATTER_TECHER(int PK_GROUP_MATTER_TECHER) {
        this.PK_GROUP_MATTER_TECHER = PK_GROUP_MATTER_TECHER;
    }

    public int getFK_CAREER() {
        return FK_CAREER;
    }

    public void setFK_CAREER(int FK_CAREER) {
        this.FK_CAREER = FK_CAREER;
    }

    public int getFK_PERIOD() {
        return FK_PERIOD;
    }

    public void setFK_PERIOD(int FK_PERIOD) {
        this.FK_PERIOD = FK_PERIOD;
    }

    public int getFK_SEMESTER() {
        return FK_SEMESTER;
    }

    public void setFK_SEMESTER(int FK_SEMESTER) {
        this.FK_SEMESTER = FK_SEMESTER;
    }

    public String getFL_NAME_SEMESTER() {
        return FL_NAME_SEMESTER;
    }

    public void setFL_NAME_SEMESTER(String FL_NAME_SEMESTER) {
        this.FL_NAME_SEMESTER = FL_NAME_SEMESTER;
    }

    public int getFK_GROUP() {
        return FK_GROUP;
    }

    public void setFK_GROUP(int FK_GROUP) {
        this.FK_GROUP = FK_GROUP;
    }

    public String getFL_NAME_GROUP() {
        return FL_NAME_GROUP;
    }

    public void setFL_NAME_GROUP(String FL_NAME_GROUP) {
        this.FL_NAME_GROUP = FL_NAME_GROUP;
    }

    public int getFK_SUBJECT_MATTER() {
        return FK_SUBJECT_MATTER;
    }

    public void setFK_SUBJECT_MATTER(int FK_SUBJECT_MATTER) {
        this.FK_SUBJECT_MATTER = FK_SUBJECT_MATTER;
    }

    public String getFL_NAME_SUBJECT_MATTER() {
        return FL_NAME_SUBJECT_MATTER;
    }

    public void setFL_NAME_SUBJECT_MATTER(String FL_NAME_SUBJECT_MATTER) {
        this.FL_NAME_SUBJECT_MATTER = FL_NAME_SUBJECT_MATTER;
    }

    public int getFK_TEACHER() {
        return FK_TEACHER;
    }

    public void setFK_TEACHER(int FK_TEACHER) {
        this.FK_TEACHER = FK_TEACHER;
    }

    public String getFL_NAME_TEACHER() {
        return FL_NAME_TEACHER;
    }

    public void setFL_NAME_TEACHER(String FL_NAME_TEACHER) {
        this.FL_NAME_TEACHER = FL_NAME_TEACHER;
    }
}
