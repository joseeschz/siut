/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author Lab5-E
 */
public class evaluationTypeModel {
    int PK_EVALUATION_TYPE = 0;
    String FL_NAME_TYPE="";
    String FL_STATUS="";

    public int getPK_EVALUATION_TYPE() {
        return PK_EVALUATION_TYPE;
    }

    public void setPK_EVALUATION_TYPE(int PK_EVALUATION_TYPE) {
        this.PK_EVALUATION_TYPE = PK_EVALUATION_TYPE;
    }

    public String getFL_NAME_TYPE() {
        return FL_NAME_TYPE;
    }

    public void setFL_NAME_TYPE(String FL_NAME_TYPE) {
        this.FL_NAME_TYPE = FL_NAME_TYPE;
    }

    public String getFL_STATUS() {
        return FL_STATUS;
    }

    public void setFL_STATUS(String FL_STATUS) {
        this.FL_STATUS = FL_STATUS;
    }
    
}
