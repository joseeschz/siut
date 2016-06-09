/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author CARLOS
 */
public class subjectMattersModel extends workerModel{
    int PK_SUBJECT_MATTER = 0;
    String FL_NAME_SUBJECT_MATTER = "";
    String FL_INTEGRADORA = "";
    int FK_STUDY_PLAN = 0;
    String FL_NAME_PLAN = "";
    int FK_SEMESTER = 0;
    String FL_NAME_ALIAS_SUBJECT_MATTER = "";
    String FL_NAME_SEMESTER = "";
    int FL_CANT_HOURS = 0;
    String FL_BLOCKS = "";
    String FL_QUALIFICATION_TOTAL_SUBJECT_MATTER="";

    public int getPK_SUBJECT_MATTER() {
        return PK_SUBJECT_MATTER;
    }

    public void setPK_SUBJECT_MATTER(int PK_SUBJECT_MATTER) {
        this.PK_SUBJECT_MATTER = PK_SUBJECT_MATTER;
    }

    public String getFL_NAME_SUBJECT_MATTER() {
        return FL_NAME_SUBJECT_MATTER;
    }

    public void setFL_NAME_SUBJECT_MATTER(String FL_NAME_SUBJECT_MATTER) {
        this.FL_NAME_SUBJECT_MATTER = FL_NAME_SUBJECT_MATTER;
    }

    public String getFL_INTEGRADORA() {
        return FL_INTEGRADORA;
    }

    public void setFL_INTEGRADORA(String FL_INTEGRADORA) {
        this.FL_INTEGRADORA = FL_INTEGRADORA;
    }

    public int getFK_STUDY_PLAN() {
        return FK_STUDY_PLAN;
    }

    public void setFK_STUDY_PLAN(int FK_STUDY_PLAN) {
        this.FK_STUDY_PLAN = FK_STUDY_PLAN;
    }

    public String getFL_NAME_PLAN() {
        return FL_NAME_PLAN;
    }

    public void setFL_NAME_PLAN(String FL_NAME_PLAN) {
        this.FL_NAME_PLAN = FL_NAME_PLAN;
    }

    public int getFK_SEMESTER() {
        return FK_SEMESTER;
    }

    public void setFK_SEMESTER(int FK_SEMESTER) {
        this.FK_SEMESTER = FK_SEMESTER;
    }

    public String getFL_NAME_ALIAS_SUBJECT_MATTER() {
        return FL_NAME_ALIAS_SUBJECT_MATTER;
    }

    public void setFL_NAME_ALIAS_SUBJECT_MATTER(String FL_NAME_ALIAS_SUBJECT_MATTER) {
        this.FL_NAME_ALIAS_SUBJECT_MATTER = FL_NAME_ALIAS_SUBJECT_MATTER;
    }

    public String getFL_NAME_SEMESTER() {
        return FL_NAME_SEMESTER;
    }

    public void setFL_NAME_SEMESTER(String FL_NAME_SEMESTER) {
        this.FL_NAME_SEMESTER = FL_NAME_SEMESTER;
    }

    public int getFL_CANT_HOURS() {
        return FL_CANT_HOURS;
    }

    public void setFL_CANT_HOURS(int FL_CANT_HOURS) {
        this.FL_CANT_HOURS = FL_CANT_HOURS;
    }

    public String getFL_BLOCKS() {
        return FL_BLOCKS;
    }

    public void setFL_BLOCKS(String FL_BLOCKS) {
        this.FL_BLOCKS = FL_BLOCKS;
    }

    public String getFL_QUALIFICATION_TOTAL_SUBJECT_MATTER() {
        return FL_QUALIFICATION_TOTAL_SUBJECT_MATTER;
    }

    public void setFL_QUALIFICATION_TOTAL_SUBJECT_MATTER(String FL_QUALIFICATION_TOTAL_SUBJECT_MATTER) {
        this.FL_QUALIFICATION_TOTAL_SUBJECT_MATTER = FL_QUALIFICATION_TOTAL_SUBJECT_MATTER;
    }
    
}
