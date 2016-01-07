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
public class workPlanningModel extends scaleEvaluationModel{
    int PK_WORK_PLANNING=0;
    String FL_DESCRIPTION="";
    String FL_CREATION_DATE="";
    String FL_LAST_DATE_UPDATE="";
    int FK_PERIOD=0;
    int FK_TEACHER=0;
    int FK_SUBJECT_MATTER=0;
    int FK_GROUP=0;
    int FK_SCALE_EVALUATION=0;
    int FL_REALIZED=0;

    public int getPK_WORK_PLANNING() {
        return PK_WORK_PLANNING;
    }

    public void setPK_WORK_PLANNING(int PK_WORK_PLANNING) {
        this.PK_WORK_PLANNING = PK_WORK_PLANNING;
    }

    public String getFL_DESCRIPTION() {
        return FL_DESCRIPTION;
    }

    public void setFL_DESCRIPTION(String FL_DESCRIPTION) {
        this.FL_DESCRIPTION = FL_DESCRIPTION;
    }

    public String getFL_CREATION_DATE() {
        return FL_CREATION_DATE;
    }

    public void setFL_CREATION_DATE(String FL_CREATION_DATE) {
        this.FL_CREATION_DATE = FL_CREATION_DATE;
    }

    public String getFL_LAST_DATE_UPDATE() {
        return FL_LAST_DATE_UPDATE;
    }

    public void setFL_LAST_DATE_UPDATE(String FL_LAST_DATE_UPDATE) {
        this.FL_LAST_DATE_UPDATE = FL_LAST_DATE_UPDATE;
    }

    public int getFK_PERIOD() {
        return FK_PERIOD;
    }

    public void setFK_PERIOD(int FK_PERIOD) {
        this.FK_PERIOD = FK_PERIOD;
    }

    public int getFK_TEACHER() {
        return FK_TEACHER;
    }

    public void setFK_TEACHER(int FK_TEACHER) {
        this.FK_TEACHER = FK_TEACHER;
    }

    public int getFK_SUBJECT_MATTER() {
        return FK_SUBJECT_MATTER;
    }

    public void setFK_SUBJECT_MATTER(int FK_SUBJECT_MATTER) {
        this.FK_SUBJECT_MATTER = FK_SUBJECT_MATTER;
    }

    public int getFK_GROUP() {
        return FK_GROUP;
    }

    public void setFK_GROUP(int FK_GROUP) {
        this.FK_GROUP = FK_GROUP;
    }

    public int getFK_SCALE_EVALUATION() {
        return FK_SCALE_EVALUATION;
    }

    public void setFK_SCALE_EVALUATION(int FK_SCALE_EVALUATION) {
        this.FK_SCALE_EVALUATION = FK_SCALE_EVALUATION;
    }

    public int getFL_REALIZED() {
        return FL_REALIZED;
    }

    public void setFL_REALIZED(int FL_REALIZED) {
        this.FL_REALIZED = FL_REALIZED;
    }
}
