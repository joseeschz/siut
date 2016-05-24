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
public class calificationModel extends subjectMattersModel{
    int PK_CALIFICATION=0;
    int FK_PERIOD=0;
    int FK_EVALUATION_TYPE=0;
    int FK_TEACHER=0;
    int FK_CAREER=0;
    int FK_MATTER=0;
    int FK_GROUP=0;
    int FK_STUDENT=0;
    String FL_ENROLLMENT="";
    String FL_NAME="";
    String FL_CALIFICATION_BE="";
    String FL_CALIFICATION_KNOW="";
    String FL_CALIFICATION_DO="";
    String FL_AVG="";
    String FL_TOTAL_EVALUATED="";
    String FL_TOTAL_OBTAINED="";
    String FL_LETTER="";
    String FL_SUBJECT_MATTERS_CALIFICATIONS="";
    String FL_NAME_DESCRIPTION_INTEGRADORAS="";
    String FL_NAME_DESCRIPTION_NOT_INTEGRADORAS="";
    
    String FL_YEAR="";
    String FL_MONTH="";
    String FL_NAME_CAREER="";
    int FL_STUDENTS_FINISHED_SEMESTER=0;
    int FL_STUDENTS_FINISHED_SEMESTER_AS_ACUMULATED=0;
    int FL_STUDENTS_FINISHED_SEMESTER_AS_REGULARIZATION=0;
    int FL_STUDENTS_FINISHED_SEMESTER_AS_GLOBAL=0;
    int FL_STUDENTS_FINISHED_SEMESTER_AS_REPPROVED=0;
    int FL_CAREER_AVERAGE=0;

    public int getPK_CALIFICATION() {
        return PK_CALIFICATION;
    }

    public void setPK_CALIFICATION(int PK_CALIFICATION) {
        this.PK_CALIFICATION = PK_CALIFICATION;
    }

    public int getFK_PERIOD() {
        return FK_PERIOD;
    }

    public void setFK_PERIOD(int FK_PERIOD) {
        this.FK_PERIOD = FK_PERIOD;
    }

    public int getFK_EVALUATION_TYPE() {
        return FK_EVALUATION_TYPE;
    }

    public void setFK_EVALUATION_TYPE(int FK_EVALUATION_TYPE) {
        this.FK_EVALUATION_TYPE = FK_EVALUATION_TYPE;
    }

    public int getFK_TEACHER() {
        return FK_TEACHER;
    }

    public void setFK_TEACHER(int FK_TEACHER) {
        this.FK_TEACHER = FK_TEACHER;
    }

    public int getFK_CAREER() {
        return FK_CAREER;
    }

    public void setFK_CAREER(int FK_CAREER) {
        this.FK_CAREER = FK_CAREER;
    }

    public int getFK_MATTER() {
        return FK_MATTER;
    }

    public void setFK_MATTER(int FK_MATTER) {
        this.FK_MATTER = FK_MATTER;
    }

    public int getFK_GROUP() {
        return FK_GROUP;
    }

    public void setFK_GROUP(int FK_GROUP) {
        this.FK_GROUP = FK_GROUP;
    }

    public int getFK_STUDENT() {
        return FK_STUDENT;
    }

    public void setFK_STUDENT(int FK_STUDENT) {
        this.FK_STUDENT = FK_STUDENT;
    }

    public String getFL_ENROLLMENT() {
        return FL_ENROLLMENT;
    }

    public void setFL_ENROLLMENT(String FL_ENROLLMENT) {
        this.FL_ENROLLMENT = FL_ENROLLMENT;
    }

    public String getFL_NAME() {
        return FL_NAME;
    }

    public void setFL_NAME(String FL_NAME) {
        this.FL_NAME = FL_NAME;
    }

    public String getFL_CALIFICATION_BE() {
        return FL_CALIFICATION_BE;
    }

    public void setFL_CALIFICATION_BE(String FL_CALIFICATION_BE) {
        this.FL_CALIFICATION_BE = FL_CALIFICATION_BE;
    }

    public String getFL_CALIFICATION_KNOW() {
        return FL_CALIFICATION_KNOW;
    }

    public void setFL_CALIFICATION_KNOW(String FL_CALIFICATION_KNOW) {
        this.FL_CALIFICATION_KNOW = FL_CALIFICATION_KNOW;
    }

    public String getFL_CALIFICATION_DO() {
        return FL_CALIFICATION_DO;
    }

    public void setFL_CALIFICATION_DO(String FL_CALIFICATION_DO) {
        this.FL_CALIFICATION_DO = FL_CALIFICATION_DO;
    }

    public String getFL_AVG() {
        return FL_AVG;
    }

    public void setFL_AVG(String FL_AVG) {
        this.FL_AVG = FL_AVG;
    }

    public String getFL_TOTAL_EVALUATED() {
        return FL_TOTAL_EVALUATED;
    }

    public void setFL_TOTAL_EVALUATED(String FL_TOTAL_EVALUATED) {
        this.FL_TOTAL_EVALUATED = FL_TOTAL_EVALUATED;
    }

    public String getFL_TOTAL_OBTAINED() {
        return FL_TOTAL_OBTAINED;
    }

    public void setFL_TOTAL_OBTAINED(String FL_TOTAL_OBTAINED) {
        this.FL_TOTAL_OBTAINED = FL_TOTAL_OBTAINED;
    }

    public String getFL_LETTER() {
        return FL_LETTER;
    }

    public void setFL_LETTER(String FL_LETTER) {
        this.FL_LETTER = FL_LETTER;
    }

    public String getFL_SUBJECT_MATTERS_CALIFICATIONS() {
        return FL_SUBJECT_MATTERS_CALIFICATIONS;
    }

    public void setFL_SUBJECT_MATTERS_CALIFICATIONS(String FL_SUBJECT_MATTERS_CALIFICATIONS) {
        this.FL_SUBJECT_MATTERS_CALIFICATIONS = FL_SUBJECT_MATTERS_CALIFICATIONS;
    }

    public String getFL_NAME_DESCRIPTION_INTEGRADORAS() {
        return FL_NAME_DESCRIPTION_INTEGRADORAS;
    }

    public void setFL_NAME_DESCRIPTION_INTEGRADORAS(String FL_NAME_DESCRIPTION_INTEGRADORAS) {
        this.FL_NAME_DESCRIPTION_INTEGRADORAS = FL_NAME_DESCRIPTION_INTEGRADORAS;
    }

    public String getFL_NAME_DESCRIPTION_NOT_INTEGRADORAS() {
        return FL_NAME_DESCRIPTION_NOT_INTEGRADORAS;
    }

    public void setFL_NAME_DESCRIPTION_NOT_INTEGRADORAS(String FL_NAME_DESCRIPTION_NOT_INTEGRADORAS) {
        this.FL_NAME_DESCRIPTION_NOT_INTEGRADORAS = FL_NAME_DESCRIPTION_NOT_INTEGRADORAS;
    }

    public String getFL_YEAR() {
        return FL_YEAR;
    }

    public void setFL_YEAR(String FL_YEAR) {
        this.FL_YEAR = FL_YEAR;
    }

    public String getFL_MONTH() {
        return FL_MONTH;
    }

    public void setFL_MONTH(String FL_MONTH) {
        this.FL_MONTH = FL_MONTH;
    }

    public String getFL_NAME_CAREER() {
        return FL_NAME_CAREER;
    }

    public void setFL_NAME_CAREER(String FL_NAME_CAREER) {
        this.FL_NAME_CAREER = FL_NAME_CAREER;
    }

    public int getFL_STUDENTS_FINISHED_SEMESTER() {
        return FL_STUDENTS_FINISHED_SEMESTER;
    }

    public void setFL_STUDENTS_FINISHED_SEMESTER(int FL_STUDENTS_FINISHED_SEMESTER) {
        this.FL_STUDENTS_FINISHED_SEMESTER = FL_STUDENTS_FINISHED_SEMESTER;
    }

    public int getFL_STUDENTS_FINISHED_SEMESTER_AS_ACUMULATED() {
        return FL_STUDENTS_FINISHED_SEMESTER_AS_ACUMULATED;
    }

    public void setFL_STUDENTS_FINISHED_SEMESTER_AS_ACUMULATED(int FL_STUDENTS_FINISHED_SEMESTER_AS_ACUMULATED) {
        this.FL_STUDENTS_FINISHED_SEMESTER_AS_ACUMULATED = FL_STUDENTS_FINISHED_SEMESTER_AS_ACUMULATED;
    }

    public int getFL_STUDENTS_FINISHED_SEMESTER_AS_REGULARIZATION() {
        return FL_STUDENTS_FINISHED_SEMESTER_AS_REGULARIZATION;
    }

    public void setFL_STUDENTS_FINISHED_SEMESTER_AS_REGULARIZATION(int FL_STUDENTS_FINISHED_SEMESTER_AS_REGULARIZATION) {
        this.FL_STUDENTS_FINISHED_SEMESTER_AS_REGULARIZATION = FL_STUDENTS_FINISHED_SEMESTER_AS_REGULARIZATION;
    }

    public int getFL_STUDENTS_FINISHED_SEMESTER_AS_GLOBAL() {
        return FL_STUDENTS_FINISHED_SEMESTER_AS_GLOBAL;
    }

    public void setFL_STUDENTS_FINISHED_SEMESTER_AS_GLOBAL(int FL_STUDENTS_FINISHED_SEMESTER_AS_GLOBAL) {
        this.FL_STUDENTS_FINISHED_SEMESTER_AS_GLOBAL = FL_STUDENTS_FINISHED_SEMESTER_AS_GLOBAL;
    }

    public int getFL_STUDENTS_FINISHED_SEMESTER_AS_REPPROVED() {
        return FL_STUDENTS_FINISHED_SEMESTER_AS_REPPROVED;
    }

    public void setFL_STUDENTS_FINISHED_SEMESTER_AS_REPPROVED(int FL_STUDENTS_FINISHED_SEMESTER_AS_REPPROVED) {
        this.FL_STUDENTS_FINISHED_SEMESTER_AS_REPPROVED = FL_STUDENTS_FINISHED_SEMESTER_AS_REPPROVED;
    }

    public int getFL_CAREER_AVERAGE() {
        return FL_CAREER_AVERAGE;
    }

    public void setFL_CAREER_AVERAGE(int FL_CAREER_AVERAGE) {
        this.FL_CAREER_AVERAGE = FL_CAREER_AVERAGE;
    }
}
