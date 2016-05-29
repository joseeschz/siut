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
public class generationsModel extends periodModel{
    int PK_GENERATION=0;
    String FL_UNIQUE="";
    String FL_GENERATION_NAME="";
    String FL_STATUS_ACTIVE="";
    String FL_YEAR_BEGIN="";
    String FL_YEAR_END="";

    public int getPK_GENERATION() {
        return PK_GENERATION;
    }

    public void setPK_GENERATION(int PK_GENERATION) {
        this.PK_GENERATION = PK_GENERATION;
    }

    public String getFL_UNIQUE() {
        return FL_UNIQUE;
    }

    public void setFL_UNIQUE(String FL_UNIQUE) {
        this.FL_UNIQUE = FL_UNIQUE;
    }

    public String getFL_GENERATION_NAME() {
        return FL_GENERATION_NAME;
    }

    public void setFL_GENERATION_NAME(String FL_GENERATION_NAME) {
        this.FL_GENERATION_NAME = FL_GENERATION_NAME;
    }

    public String getFL_STATUS_ACTIVE() {
        return FL_STATUS_ACTIVE;
    }

    public void setFL_STATUS_ACTIVE(String FL_STATUS_ACTIVE) {
        this.FL_STATUS_ACTIVE = FL_STATUS_ACTIVE;
    }

    public String getFL_YEAR_BEGIN() {
        return FL_YEAR_BEGIN;
    }

    public void setFL_YEAR_BEGIN(String FL_YEAR_BEGIN) {
        this.FL_YEAR_BEGIN = FL_YEAR_BEGIN;
    }

    public String getFL_YEAR_END() {
        return FL_YEAR_END;
    }

    public void setFL_YEAR_END(String FL_YEAR_END) {
        this.FL_YEAR_END = FL_YEAR_END;
    }
    
}
