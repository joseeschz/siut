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
public class groupStudentModel extends  groupMatterTeacherModel{
    int PK_GRUPOS_BY_STUDENT = 0;
    String FL_ENROLLMENT = "";
    int FK_STUDENT = 0;
    String FL_STUDENT_NAME = "";
    int FK_TUTOR_TEACHER = 0;
    String FL_DELIVERY_STATUS=null;
    String FL_DELIVERY_DESCRIPTION="";

    public int getPK_GRUPOS_BY_STUDENT() {
        return PK_GRUPOS_BY_STUDENT;
    }

    public void setPK_GRUPOS_BY_STUDENT(int PK_GRUPOS_BY_STUDENT) {
        this.PK_GRUPOS_BY_STUDENT = PK_GRUPOS_BY_STUDENT;
    }

    public String getFL_ENROLLMENT() {
        return FL_ENROLLMENT;
    }

    public void setFL_ENROLLMENT(String FL_ENROLLMENT) {
        this.FL_ENROLLMENT = FL_ENROLLMENT;
    }

    public int getFK_STUDENT() {
        return FK_STUDENT;
    }

    public void setFK_STUDENT(int FK_STUDENT) {
        this.FK_STUDENT = FK_STUDENT;
    }

    public String getFL_STUDENT_NAME() {
        return FL_STUDENT_NAME;
    }

    public void setFL_STUDENT_NAME(String FL_STUDENT_NAME) {
        this.FL_STUDENT_NAME = FL_STUDENT_NAME;
    }

    public int getFK_TUTOR_TEACHER() {
        return FK_TUTOR_TEACHER;
    }

    public void setFK_TUTOR_TEACHER(int FK_TUTOR_TEACHER) {
        this.FK_TUTOR_TEACHER = FK_TUTOR_TEACHER;
    }

    public String getFL_DELIVERY_STATUS() {
        return FL_DELIVERY_STATUS;
    }

    public void setFL_DELIVERY_STATUS(String FL_DELIVERY_STATUS) {
        this.FL_DELIVERY_STATUS = FL_DELIVERY_STATUS;
    }

    public String getFL_DELIVERY_DESCRIPTION() {
        return FL_DELIVERY_DESCRIPTION;
    }

    public void setFL_DELIVERY_DESCRIPTION(String FL_DELIVERY_DESCRIPTION) {
        this.FL_DELIVERY_DESCRIPTION = FL_DELIVERY_DESCRIPTION;
    }
    
}
