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
public class studyLevelModel {
    int PK_LEVEL_STUDY = 0;
    String FL_NAME_LEVEL = "";
    String FL_STATUS = "";

    public int getPK_LEVEL_STUDY() {
        return PK_LEVEL_STUDY;
    }

    public void setPK_LEVEL_STUDY(int PK_LEVEL_STUDY) {
        this.PK_LEVEL_STUDY = PK_LEVEL_STUDY;
    }

    public String getFL_NAME_LEVEL() {
        return FL_NAME_LEVEL;
    }

    public void setFL_NAME_LEVEL(String FL_NAME_LEVEL) {
        this.FL_NAME_LEVEL = FL_NAME_LEVEL;
    }

    public String getFL_STATUS() {
        return FL_STATUS;
    }

    public void setFL_STATUS(String FL_STATUS) {
        this.FL_STATUS = FL_STATUS;
    }
}
