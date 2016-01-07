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
public class userModel {
    int PK_USER = 0;
    String FL_NAME_USER = "";
    String FL_PATERN_NAME = "";
    String FL_MATERN_NAME = "";
    String FL_MAIL = "";
    String FL_USER_NAME = "";
    String FL_PASSWORD = "";
    int FL_DELETED = 0;
    int FK_ROL = 0;
    String FL_NAME_ROL = "";

    public int getPK_USER() {
        return PK_USER;
    }

    public void setPK_USER(int PK_USER) {
        this.PK_USER = PK_USER;
    }

    public String getFL_NAME_USER() {
        return FL_NAME_USER;
    }

    public void setFL_NAME_USER(String FL_NAME_USER) {
        this.FL_NAME_USER = FL_NAME_USER;
    }

    public String getFL_PATERN_NAME() {
        return FL_PATERN_NAME;
    }

    public void setFL_PATERN_NAME(String FL_PATERN_NAME) {
        this.FL_PATERN_NAME = FL_PATERN_NAME;
    }

    public String getFL_MATERN_NAME() {
        return FL_MATERN_NAME;
    }

    public void setFL_MATERN_NAME(String FL_MATERN_NAME) {
        this.FL_MATERN_NAME = FL_MATERN_NAME;
    }

    public String getFL_MAIL() {
        return FL_MAIL;
    }

    public void setFL_MAIL(String FL_MAIL) {
        this.FL_MAIL = FL_MAIL;
    }

    public String getFL_USER_NAME() {
        return FL_USER_NAME;
    }

    public void setFL_USER_NAME(String FL_USER_NAME) {
        this.FL_USER_NAME = FL_USER_NAME;
    }

    public String getFL_PASSWORD() {
        return FL_PASSWORD;
    }

    public void setFL_PASSWORD(String FL_PASSWORD) {
        this.FL_PASSWORD = FL_PASSWORD;
    }

    public int getFL_DELETED() {
        return FL_DELETED;
    }

    public void setFL_DELETED(int FL_DELETED) {
        this.FL_DELETED = FL_DELETED;
    }

    public int getFK_ROL() {
        return FK_ROL;
    }

    public void setFK_ROL(int FK_ROL) {
        this.FK_ROL = FK_ROL;
    }

    public String getFL_NAME_ROL() {
        return FL_NAME_ROL;
    }

    public void setFL_NAME_ROL(String FL_NAME_ROL) {
        this.FL_NAME_ROL = FL_NAME_ROL;
    }
    
}
