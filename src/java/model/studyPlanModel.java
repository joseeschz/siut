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
public class studyPlanModel {
    int PK_STUDY_PLAN = 0;
    String FL_NAME_PLAN = "";
    int FK_CAREER = 0;

    public int getPK_STUDY_PLAN() {
        return PK_STUDY_PLAN;
    }

    public void setPK_STUDY_PLAN(int PK_STUDY_PLAN) {
        this.PK_STUDY_PLAN = PK_STUDY_PLAN;
    }

    public String getFL_NAME_PLAN() {
        return FL_NAME_PLAN;
    }

    public void setFL_NAME_PLAN(String FL_NAME_PLAN) {
        this.FL_NAME_PLAN = FL_NAME_PLAN;
    }

    public int getFK_CAREER() {
        return FK_CAREER;
    }

    public void setFK_CAREER(int FK_CAREER) {
        this.FK_CAREER = FK_CAREER;
    }
}
