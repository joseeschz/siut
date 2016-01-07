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
public class workerModel {
    int PK_WORKER = 0;
    String FL_NAME_WORKER = "";
    String FL_PATERN_NAME = "";
    String FL_MATERN_NAME = "";
    String FL_KEY_SP = "";
    String FL_TELEHONE_NUMBER = "";
    String FL_USER_NAME = "";
    String FL_ADDRES = "";
    String FL_PHOTO = "";
    int FK_ROL = 0;

    public String getFL_USER_NAME() {
        return FL_USER_NAME;
    }

    public void setFL_USER_NAME(String FL_USER_NAME) {
        this.FL_USER_NAME = FL_USER_NAME;
    }
    //tb_teacher
    String FL_TUTOR = "";
    String FL_JOB_FUNCTIONAL ="";

    public int getPK_WORKER() {
        return PK_WORKER;
    }

    public void setPK_WORKER(int PK_WORKER) {
        this.PK_WORKER = PK_WORKER;
    }

    public String getFL_NAME_WORKER() {
        return FL_NAME_WORKER;
    }

    public void setFL_NAME_WORKER(String FL_NAME_WORKER) {
        this.FL_NAME_WORKER = FL_NAME_WORKER;
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

    public String getFL_KEY_SP() {
        return FL_KEY_SP;
    }

    public void setFL_KEY_SP(String FL_KEY_SP) {
        this.FL_KEY_SP = FL_KEY_SP;
    }

    public String getFL_TELEHONE_NUMBER() {
        return FL_TELEHONE_NUMBER;
    }

    public void setFL_TELEHONE_NUMBER(String FL_TELEHONE_NUMBER) {
        this.FL_TELEHONE_NUMBER = FL_TELEHONE_NUMBER;
    }

    public String getFL_ADDRES() {
        return FL_ADDRES;
    }

    public void setFL_ADDRES(String FL_ADDRES) {
        this.FL_ADDRES = FL_ADDRES;
    }

    public String getFL_PHOTO() {
        return FL_PHOTO;
    }

    public void setFL_PHOTO(String FL_PHOTO) {
        this.FL_PHOTO = FL_PHOTO;
    }

    public int getFK_ROL() {
        return FK_ROL;
    }

    public void setFK_ROL(int FK_ROL) {
        this.FK_ROL = FK_ROL;
    }

    public String getFL_TUTOR() {
        return FL_TUTOR;
    }

    public void setFL_TUTOR(String FL_TUTOR) {
        this.FL_TUTOR = FL_TUTOR;
    }

    public String getFL_JOB_FUNCTIONAL() {
        return FL_JOB_FUNCTIONAL;
    }

    public void setFL_JOB_FUNCTIONAL(String FL_JOB_FUNCTIONAL) {
        this.FL_JOB_FUNCTIONAL = FL_JOB_FUNCTIONAL;
    }
}
