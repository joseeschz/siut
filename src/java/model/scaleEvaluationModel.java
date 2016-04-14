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
public class scaleEvaluationModel {
    int PK_SCALE_EVALUATION=0;
    String FL_NAME_SCALE="";
    double FL_MAX_VALUE=0;
    int FL_TYPE_SCALE=0;

    public int getPK_SCALE_EVALUATION() {
        return PK_SCALE_EVALUATION;
    }

    public void setPK_SCALE_EVALUATION(int PK_SCALE_EVALUATION) {
        this.PK_SCALE_EVALUATION = PK_SCALE_EVALUATION;
    }

    public String getFL_NAME_SCALE() {
        return FL_NAME_SCALE;
    }

    public void setFL_NAME_SCALE(String FL_NAME_SCALE) {
        this.FL_NAME_SCALE = FL_NAME_SCALE;
    }

    public double getFL_MAX_VALUE() {
        return FL_MAX_VALUE;
    }

    public void setFL_MAX_VALUE(double FL_MAX_VALUE) {
        this.FL_MAX_VALUE = FL_MAX_VALUE;
    }

    public int getFL_TYPE_SCALE() {
        return FL_TYPE_SCALE;
    }

    public void setFL_TYPE_SCALE(int FL_TYPE_SCALE) {
        this.FL_TYPE_SCALE = FL_TYPE_SCALE;
    }
}
