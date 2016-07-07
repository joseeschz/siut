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
public class periodModel extends semesterModel{
    int PK_PERIOD = 0;
    String FL_UNIQUE="";
    String FL_DAY_BEGIN="";
    String FL_DAY_END="";
    String FL_NAME = "";
    String FL_NAME_ABBREVIATED = "";
    String FL_ACTIVE = "";
    String FL_YEAR_ACTIVE = "";
    String FL_YEAR="";
    int FL_PERIOD_TYPE=0;
    int FK_SCHOOL_YEAR=0;
    int FL_DELETED=0;

    public int getPK_PERIOD() {
        return PK_PERIOD;
    }

    public void setPK_PERIOD(int PK_PERIOD) {
        this.PK_PERIOD = PK_PERIOD;
    }

    public String getFL_UNIQUE() {
        return FL_UNIQUE;
    }

    public void setFL_UNIQUE(String FL_UNIQUE) {
        this.FL_UNIQUE = FL_UNIQUE;
    }

    public String getFL_DAY_BEGIN() {
        return FL_DAY_BEGIN;
    }

    public void setFL_DAY_BEGIN(String FL_DAY_BEGIN) {
        this.FL_DAY_BEGIN = FL_DAY_BEGIN;
    }

    public String getFL_DAY_END() {
        return FL_DAY_END;
    }

    public void setFL_DAY_END(String FL_DAY_END) {
        this.FL_DAY_END = FL_DAY_END;
    }

    public String getFL_NAME() {
        return FL_NAME;
    }

    public void setFL_NAME(String FL_NAME) {
        this.FL_NAME = FL_NAME;
    }

    public String getFL_NAME_ABBREVIATED() {
        return FL_NAME_ABBREVIATED;
    }

    public void setFL_NAME_ABBREVIATED(String FL_NAME_ABBREVIATED) {
        this.FL_NAME_ABBREVIATED = FL_NAME_ABBREVIATED;
    }

    public String getFL_ACTIVE() {
        return FL_ACTIVE;
    }

    public void setFL_ACTIVE(String FL_ACTIVE) {
        this.FL_ACTIVE = FL_ACTIVE;
    }

    public String getFL_YEAR_ACTIVE() {
        return FL_YEAR_ACTIVE;
    }

    public void setFL_YEAR_ACTIVE(String FL_YEAR_ACTIVE) {
        this.FL_YEAR_ACTIVE = FL_YEAR_ACTIVE;
    }

    public String getFL_YEAR() {
        return FL_YEAR;
    }

    public void setFL_YEAR(String FL_YEAR) {
        this.FL_YEAR = FL_YEAR;
    }

    public int getFL_PERIOD_TYPE() {
        return FL_PERIOD_TYPE;
    }

    public void setFL_PERIOD_TYPE(int FL_PERIOD_TYPE) {
        this.FL_PERIOD_TYPE = FL_PERIOD_TYPE;
    }

    public int getFK_SCHOOL_YEAR() {
        return FK_SCHOOL_YEAR;
    }

    public void setFK_SCHOOL_YEAR(int FK_SCHOOL_YEAR) {
        this.FK_SCHOOL_YEAR = FK_SCHOOL_YEAR;
    }

    public int getFL_DELETED() {
        return FL_DELETED;
    }

    public void setFL_DELETED(int FL_DELETED) {
        this.FL_DELETED = FL_DELETED;
    }
    
}
