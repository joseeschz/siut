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
    int PK_ACTIVITY=0;
    String FL_NAME_ACTIVITY="";
    double FL_VALUE_ACTIVITY=0; 

    public int getPK_ACTIVITY() {
        return PK_ACTIVITY;
    }

    public void setPK_ACTIVITY(int PK_ACTIVITY) {
        this.PK_ACTIVITY = PK_ACTIVITY;
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
}
