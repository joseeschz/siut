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
public class activitiesToGroupModel extends workPlanningModel{
    String PK_ACTIVITY="";
    String FL_NUM="";
    String FL_NAME_ACTIVITY="";
    double FL_VALUE_ACTIVITY=0; 
    String FL_VALUE_ACTIVITY_PERCENT=""; 

    public String getPK_ACTIVITY() {
        return PK_ACTIVITY;
    }

    public void setPK_ACTIVITY(String PK_ACTIVITY) {
        this.PK_ACTIVITY = PK_ACTIVITY;
    }

    public String getFL_NUM() {
        return FL_NUM;
    }

    public void setFL_NUM(String FL_NUM) {
        this.FL_NUM = FL_NUM;
    }

    public String getFL_NAME_ACTIVITY() {
        return FL_NAME_ACTIVITY;
    }

    public void setFL_NAME_ACTIVITY(String FL_NAME_ACTIVITY) {
        this.FL_NAME_ACTIVITY = FL_NAME_ACTIVITY;
    }

    public double getFL_VALUE_ACTIVITY() {
        return FL_VALUE_ACTIVITY;
    }

    public void setFL_VALUE_ACTIVITY(double FL_VALUE_ACTIVITY) {
        this.FL_VALUE_ACTIVITY = FL_VALUE_ACTIVITY;
    }

    public String getFL_VALUE_ACTIVITY_PERCENT() {
        return FL_VALUE_ACTIVITY_PERCENT;
    }

    public void setFL_VALUE_ACTIVITY_PERCENT(String FL_VALUE_ACTIVITY_PERCENT) {
        this.FL_VALUE_ACTIVITY_PERCENT = FL_VALUE_ACTIVITY_PERCENT;
    }
}
