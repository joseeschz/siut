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
public class lowOfStudentModel {
    int PK_LOW_STUDENT=0;
    String FL_REGISTER_DATE="";
    String FL_FOLIO_LOW="";
    String FL_AUTORIZATION_DATE="";
    boolean FL_HAS_SCHOOLARSHIP=false;
    schoolarshipStudentsModel schoolarshipStudentsMdl;
    boolean FL_HAS_DEBT=false;
    debtModel debtMdl;
    studentModel studentMdl;
    boolean FL_ULTIMATE_LOW=false;
    boolean FL_TEMPORALY_LOW=false;
    boolean FL_REQUEST_FOR_STUDENT=false;
    boolean FL_REPPROBED=false;
    boolean FL_BACKGROUND_ACADEMICS_STUDENT=false;
    boolean FL_UTSEM_NOT_FIRST_OPTION=false;
    boolean FL_MISTAKES_REGULATION_SCHOOL=false;
    boolean FL_DIFFICULTY_MATTERS_SCHOOL=false;
    String FL_THAT_MATTERS="";
    boolean FL_ABSENCE=false;
    boolean FL_DISSATISFACTION_OF_EXPECTATIONS=false;
    boolean FL_DEFICIENT_ORIENTATION_VOCATIONAL=false;
    boolean FL_CAREER_NOT_FIRST_OPTION=false;
    boolean FL_OTHERS_FACTORS_ACADEMICS=false;
    String FL_THAT_OTHERS_FACTORS_ACADEMICS="";
    boolean FL_SITUATION_ECONOMIC_UNFAVORABLE=false;
    boolean FL_STUDENT_WORK=false;
    boolean FL_MARRIAGE_AFFECTS_SITUATION_ECONOMIC=false;
    boolean FL_PROBLEMS_BAD_NUTRITION=false;
    boolean FL_LOSS_EMPLOYMENT_WHO_DEPENDS_STUDENT=false;
    boolean FL_INCOMPATIBILITY_OF_SCHEDULES_WORK_STUDIES=false;
    boolean FL_CHANGE_RESIDENCE=false;
    boolean FL_FEATURES_SOCIOCULTURALES_STUDENT=false;
    boolean FL_LACK_MOTIVATION=false;
    boolean FL_DISTANCE_OF_UTSEM=false;
    boolean FL_PROBLEMS_HEALTH=false;
    boolean FL_NOT_PRESENT_CLASSES=false;
    boolean FL_PROBLEMS_WITH_COLLAGUES_OF_CLASS=false;
    boolean FL_PROBLEMS_EMOTIONALS=false;
    boolean FL_ADDICTIONS=false;
    boolean FL_PROBLEMS_WITH_TEACHERS=false;
    boolean FL_OTHERS_FACTORS_PERSONALS=false;
    String FL_THAT_OTHERS_FACTORS_PERSONALS="";
    workerModel workerDirectorMdl;
    workerModel workerTutorMdl;
    workerModel workerESMdl;
    workerModel workerCPMdl;    
    periodModel periodMdl;
    boolean FL_AUTHORIZATION_DIRECTOR=false;
    boolean FL_AUTHORIZATION_ES=false;
    careerModel careerMdl;
    semesterModel semesterMdl;
    groupModel groupMdl;
    String FL_STATUS_DIR;
    String FL_STATUS_ES;

    public int getPK_LOW_STUDENT() {
        return PK_LOW_STUDENT;
    }

    public void setPK_LOW_STUDENT(int PK_LOW_STUDENT) {
        this.PK_LOW_STUDENT = PK_LOW_STUDENT;
    }

    public String getFL_REGISTER_DATE() {
        return FL_REGISTER_DATE;
    }

    public void setFL_REGISTER_DATE(String FL_REGISTER_DATE) {
        this.FL_REGISTER_DATE = FL_REGISTER_DATE;
    }

    public String getFL_FOLIO_LOW() {
        return FL_FOLIO_LOW;
    }

    public void setFL_FOLIO_LOW(String FL_FOLIO_LOW) {
        this.FL_FOLIO_LOW = FL_FOLIO_LOW;
    }

    public String getFL_AUTORIZATION_DATE() {
        return FL_AUTORIZATION_DATE;
    }

    public void setFL_AUTORIZATION_DATE(String FL_AUTORIZATION_DATE) {
        this.FL_AUTORIZATION_DATE = FL_AUTORIZATION_DATE;
    }

    public boolean isFL_HAS_SCHOOLARSHIP() {
        return FL_HAS_SCHOOLARSHIP;
    }

    public void setFL_HAS_SCHOOLARSHIP(boolean FL_HAS_SCHOOLARSHIP) {
        this.FL_HAS_SCHOOLARSHIP = FL_HAS_SCHOOLARSHIP;
    }

    public schoolarshipStudentsModel getSchoolarshipStudentsMdl() {
        return schoolarshipStudentsMdl;
    }

    public void setSchoolarshipStudentsMdl(schoolarshipStudentsModel schoolarshipStudentsMdl) {
        this.schoolarshipStudentsMdl = schoolarshipStudentsMdl;
    }

    public boolean isFL_HAS_DEBT() {
        return FL_HAS_DEBT;
    }

    public void setFL_HAS_DEBT(boolean FL_HAS_DEBT) {
        this.FL_HAS_DEBT = FL_HAS_DEBT;
    }

    public debtModel getDebtMdl() {
        return debtMdl;
    }

    public void setDebtMdl(debtModel debtMdl) {
        this.debtMdl = debtMdl;
    }

    public studentModel getStudentMdl() {
        return studentMdl;
    }

    public void setStudentMdl(studentModel studentMdl) {
        this.studentMdl = studentMdl;
    }

    public boolean isFL_ULTIMATE_LOW() {
        return FL_ULTIMATE_LOW;
    }

    public void setFL_ULTIMATE_LOW(boolean FL_ULTIMATE_LOW) {
        this.FL_ULTIMATE_LOW = FL_ULTIMATE_LOW;
    }

    public boolean isFL_TEMPORALY_LOW() {
        return FL_TEMPORALY_LOW;
    }

    public void setFL_TEMPORALY_LOW(boolean FL_TEMPORALY_LOW) {
        this.FL_TEMPORALY_LOW = FL_TEMPORALY_LOW;
    }

    public boolean isFL_REQUEST_FOR_STUDENT() {
        return FL_REQUEST_FOR_STUDENT;
    }

    public void setFL_REQUEST_FOR_STUDENT(boolean FL_REQUEST_FOR_STUDENT) {
        this.FL_REQUEST_FOR_STUDENT = FL_REQUEST_FOR_STUDENT;
    }

    public boolean isFL_REPPROBED() {
        return FL_REPPROBED;
    }

    public void setFL_REPPROBED(boolean FL_REPPROBED) {
        this.FL_REPPROBED = FL_REPPROBED;
    }

    public boolean isFL_BACKGROUND_ACADEMICS_STUDENT() {
        return FL_BACKGROUND_ACADEMICS_STUDENT;
    }

    public void setFL_BACKGROUND_ACADEMICS_STUDENT(boolean FL_BACKGROUND_ACADEMICS_STUDENT) {
        this.FL_BACKGROUND_ACADEMICS_STUDENT = FL_BACKGROUND_ACADEMICS_STUDENT;
    }

    public boolean isFL_UTSEM_NOT_FIRST_OPTION() {
        return FL_UTSEM_NOT_FIRST_OPTION;
    }

    public void setFL_UTSEM_NOT_FIRST_OPTION(boolean FL_UTSEM_NOT_FIRST_OPTION) {
        this.FL_UTSEM_NOT_FIRST_OPTION = FL_UTSEM_NOT_FIRST_OPTION;
    }

    public boolean isFL_MISTAKES_REGULATION_SCHOOL() {
        return FL_MISTAKES_REGULATION_SCHOOL;
    }

    public void setFL_MISTAKES_REGULATION_SCHOOL(boolean FL_MISTAKES_REGULATION_SCHOOL) {
        this.FL_MISTAKES_REGULATION_SCHOOL = FL_MISTAKES_REGULATION_SCHOOL;
    }

    public boolean isFL_DIFFICULTY_MATTERS_SCHOOL() {
        return FL_DIFFICULTY_MATTERS_SCHOOL;
    }

    public void setFL_DIFFICULTY_MATTERS_SCHOOL(boolean FL_DIFFICULTY_MATTERS_SCHOOL) {
        this.FL_DIFFICULTY_MATTERS_SCHOOL = FL_DIFFICULTY_MATTERS_SCHOOL;
    }

    public String getFL_THAT_MATTERS() {
        return FL_THAT_MATTERS;
    }

    public void setFL_THAT_MATTERS(String FL_THAT_MATTERS) {
        this.FL_THAT_MATTERS = FL_THAT_MATTERS;
    }

    public boolean isFL_ABSENCE() {
        return FL_ABSENCE;
    }

    public void setFL_ABSENCE(boolean FL_ABSENCE) {
        this.FL_ABSENCE = FL_ABSENCE;
    }

    public boolean isFL_DISSATISFACTION_OF_EXPECTATIONS() {
        return FL_DISSATISFACTION_OF_EXPECTATIONS;
    }

    public void setFL_DISSATISFACTION_OF_EXPECTATIONS(boolean FL_DISSATISFACTION_OF_EXPECTATIONS) {
        this.FL_DISSATISFACTION_OF_EXPECTATIONS = FL_DISSATISFACTION_OF_EXPECTATIONS;
    }

    public boolean isFL_DEFICIENT_ORIENTATION_VOCATIONAL() {
        return FL_DEFICIENT_ORIENTATION_VOCATIONAL;
    }

    public void setFL_DEFICIENT_ORIENTATION_VOCATIONAL(boolean FL_DEFICIENT_ORIENTATION_VOCATIONAL) {
        this.FL_DEFICIENT_ORIENTATION_VOCATIONAL = FL_DEFICIENT_ORIENTATION_VOCATIONAL;
    }

    public boolean isFL_CAREER_NOT_FIRST_OPTION() {
        return FL_CAREER_NOT_FIRST_OPTION;
    }

    public void setFL_CAREER_NOT_FIRST_OPTION(boolean FL_CAREER_NOT_FIRST_OPTION) {
        this.FL_CAREER_NOT_FIRST_OPTION = FL_CAREER_NOT_FIRST_OPTION;
    }

    public boolean isFL_OTHERS_FACTORS_ACADEMICS() {
        return FL_OTHERS_FACTORS_ACADEMICS;
    }

    public void setFL_OTHERS_FACTORS_ACADEMICS(boolean FL_OTHERS_FACTORS_ACADEMICS) {
        this.FL_OTHERS_FACTORS_ACADEMICS = FL_OTHERS_FACTORS_ACADEMICS;
    }

    public String getFL_THAT_OTHERS_FACTORS_ACADEMICS() {
        return FL_THAT_OTHERS_FACTORS_ACADEMICS;
    }

    public void setFL_THAT_OTHERS_FACTORS_ACADEMICS(String FL_THAT_OTHERS_FACTORS_ACADEMICS) {
        this.FL_THAT_OTHERS_FACTORS_ACADEMICS = FL_THAT_OTHERS_FACTORS_ACADEMICS;
    }

    public boolean isFL_SITUATION_ECONOMIC_UNFAVORABLE() {
        return FL_SITUATION_ECONOMIC_UNFAVORABLE;
    }

    public void setFL_SITUATION_ECONOMIC_UNFAVORABLE(boolean FL_SITUATION_ECONOMIC_UNFAVORABLE) {
        this.FL_SITUATION_ECONOMIC_UNFAVORABLE = FL_SITUATION_ECONOMIC_UNFAVORABLE;
    }

    public boolean isFL_STUDENT_WORK() {
        return FL_STUDENT_WORK;
    }

    public void setFL_STUDENT_WORK(boolean FL_STUDENT_WORK) {
        this.FL_STUDENT_WORK = FL_STUDENT_WORK;
    }

    public boolean isFL_MARRIAGE_AFFECTS_SITUATION_ECONOMIC() {
        return FL_MARRIAGE_AFFECTS_SITUATION_ECONOMIC;
    }

    public void setFL_MARRIAGE_AFFECTS_SITUATION_ECONOMIC(boolean FL_MARRIAGE_AFFECTS_SITUATION_ECONOMIC) {
        this.FL_MARRIAGE_AFFECTS_SITUATION_ECONOMIC = FL_MARRIAGE_AFFECTS_SITUATION_ECONOMIC;
    }

    public boolean isFL_PROBLEMS_BAD_NUTRITION() {
        return FL_PROBLEMS_BAD_NUTRITION;
    }

    public void setFL_PROBLEMS_BAD_NUTRITION(boolean FL_PROBLEMS_BAD_NUTRITION) {
        this.FL_PROBLEMS_BAD_NUTRITION = FL_PROBLEMS_BAD_NUTRITION;
    }

    public boolean isFL_LOSS_EMPLOYMENT_WHO_DEPENDS_STUDENT() {
        return FL_LOSS_EMPLOYMENT_WHO_DEPENDS_STUDENT;
    }

    public void setFL_LOSS_EMPLOYMENT_WHO_DEPENDS_STUDENT(boolean FL_LOSS_EMPLOYMENT_WHO_DEPENDS_STUDENT) {
        this.FL_LOSS_EMPLOYMENT_WHO_DEPENDS_STUDENT = FL_LOSS_EMPLOYMENT_WHO_DEPENDS_STUDENT;
    }

    public boolean isFL_INCOMPATIBILITY_OF_SCHEDULES_WORK_STUDIES() {
        return FL_INCOMPATIBILITY_OF_SCHEDULES_WORK_STUDIES;
    }

    public void setFL_INCOMPATIBILITY_OF_SCHEDULES_WORK_STUDIES(boolean FL_INCOMPATIBILITY_OF_SCHEDULES_WORK_STUDIES) {
        this.FL_INCOMPATIBILITY_OF_SCHEDULES_WORK_STUDIES = FL_INCOMPATIBILITY_OF_SCHEDULES_WORK_STUDIES;
    }

    public boolean isFL_CHANGE_RESIDENCE() {
        return FL_CHANGE_RESIDENCE;
    }

    public void setFL_CHANGE_RESIDENCE(boolean FL_CHANGE_RESIDENCE) {
        this.FL_CHANGE_RESIDENCE = FL_CHANGE_RESIDENCE;
    }

    public boolean isFL_FEATURES_SOCIOCULTURALES_STUDENT() {
        return FL_FEATURES_SOCIOCULTURALES_STUDENT;
    }

    public void setFL_FEATURES_SOCIOCULTURALES_STUDENT(boolean FL_FEATURES_SOCIOCULTURALES_STUDENT) {
        this.FL_FEATURES_SOCIOCULTURALES_STUDENT = FL_FEATURES_SOCIOCULTURALES_STUDENT;
    }

    public boolean isFL_LACK_MOTIVATION() {
        return FL_LACK_MOTIVATION;
    }

    public void setFL_LACK_MOTIVATION(boolean FL_LACK_MOTIVATION) {
        this.FL_LACK_MOTIVATION = FL_LACK_MOTIVATION;
    }

    public boolean isFL_DISTANCE_OF_UTSEM() {
        return FL_DISTANCE_OF_UTSEM;
    }

    public void setFL_DISTANCE_OF_UTSEM(boolean FL_DISTANCE_OF_UTSEM) {
        this.FL_DISTANCE_OF_UTSEM = FL_DISTANCE_OF_UTSEM;
    }

    public boolean isFL_PROBLEMS_HEALTH() {
        return FL_PROBLEMS_HEALTH;
    }

    public void setFL_PROBLEMS_HEALTH(boolean FL_PROBLEMS_HEALTH) {
        this.FL_PROBLEMS_HEALTH = FL_PROBLEMS_HEALTH;
    }

    public boolean isFL_NOT_PRESENT_CLASSES() {
        return FL_NOT_PRESENT_CLASSES;
    }

    public void setFL_NOT_PRESENT_CLASSES(boolean FL_NOT_PRESENT_CLASSES) {
        this.FL_NOT_PRESENT_CLASSES = FL_NOT_PRESENT_CLASSES;
    }

    public boolean isFL_PROBLEMS_WITH_COLLAGUES_OF_CLASS() {
        return FL_PROBLEMS_WITH_COLLAGUES_OF_CLASS;
    }

    public void setFL_PROBLEMS_WITH_COLLAGUES_OF_CLASS(boolean FL_PROBLEMS_WITH_COLLAGUES_OF_CLASS) {
        this.FL_PROBLEMS_WITH_COLLAGUES_OF_CLASS = FL_PROBLEMS_WITH_COLLAGUES_OF_CLASS;
    }

    public boolean isFL_PROBLEMS_EMOTIONALS() {
        return FL_PROBLEMS_EMOTIONALS;
    }

    public void setFL_PROBLEMS_EMOTIONALS(boolean FL_PROBLEMS_EMOTIONALS) {
        this.FL_PROBLEMS_EMOTIONALS = FL_PROBLEMS_EMOTIONALS;
    }

    public boolean isFL_ADDICTIONS() {
        return FL_ADDICTIONS;
    }

    public void setFL_ADDICTIONS(boolean FL_ADDICTIONS) {
        this.FL_ADDICTIONS = FL_ADDICTIONS;
    }

    public boolean isFL_PROBLEMS_WITH_TEACHERS() {
        return FL_PROBLEMS_WITH_TEACHERS;
    }

    public void setFL_PROBLEMS_WITH_TEACHERS(boolean FL_PROBLEMS_WITH_TEACHERS) {
        this.FL_PROBLEMS_WITH_TEACHERS = FL_PROBLEMS_WITH_TEACHERS;
    }

    public boolean isFL_OTHERS_FACTORS_PERSONALS() {
        return FL_OTHERS_FACTORS_PERSONALS;
    }

    public void setFL_OTHERS_FACTORS_PERSONALS(boolean FL_OTHERS_FACTORS_PERSONALS) {
        this.FL_OTHERS_FACTORS_PERSONALS = FL_OTHERS_FACTORS_PERSONALS;
    }

    public String getFL_THAT_OTHERS_FACTORS_PERSONALS() {
        return FL_THAT_OTHERS_FACTORS_PERSONALS;
    }

    public void setFL_THAT_OTHERS_FACTORS_PERSONALS(String FL_THAT_OTHERS_FACTORS_PERSONALS) {
        this.FL_THAT_OTHERS_FACTORS_PERSONALS = FL_THAT_OTHERS_FACTORS_PERSONALS;
    }

    public workerModel getWorkerDirectorMdl() {
        return workerDirectorMdl;
    }

    public void setWorkerDirectorMdl(workerModel workerDirectorMdl) {
        this.workerDirectorMdl = workerDirectorMdl;
    }

    public workerModel getWorkerTutorMdl() {
        return workerTutorMdl;
    }

    public void setWorkerTutorMdl(workerModel workerTutorMdl) {
        this.workerTutorMdl = workerTutorMdl;
    }

    public workerModel getWorkerESMdl() {
        return workerESMdl;
    }

    public void setWorkerESMdl(workerModel workerESMdl) {
        this.workerESMdl = workerESMdl;
    }

    public workerModel getWorkerCPMdl() {
        return workerCPMdl;
    }

    public void setWorkerCPMdl(workerModel workerCPMdl) {
        this.workerCPMdl = workerCPMdl;
    }

    public periodModel getPeriodMdl() {
        return periodMdl;
    }

    public void setPeriodMdl(periodModel periodMdl) {
        this.periodMdl = periodMdl;
    }

    public boolean isFL_AUTHORIZATION_DIRECTOR() {
        return FL_AUTHORIZATION_DIRECTOR;
    }

    public void setFL_AUTHORIZATION_DIRECTOR(boolean FL_AUTHORIZATION_DIRECTOR) {
        this.FL_AUTHORIZATION_DIRECTOR = FL_AUTHORIZATION_DIRECTOR;
    }

    public boolean isFL_AUTHORIZATION_ES() {
        return FL_AUTHORIZATION_ES;
    }

    public void setFL_AUTHORIZATION_ES(boolean FL_AUTHORIZATION_ES) {
        this.FL_AUTHORIZATION_ES = FL_AUTHORIZATION_ES;
    }

    public careerModel getCareerMdl() {
        return careerMdl;
    }

    public void setCareerMdl(careerModel careerMdl) {
        this.careerMdl = careerMdl;
    }

    public semesterModel getSemesterMdl() {
        return semesterMdl;
    }

    public void setSemesterMdl(semesterModel semesterMdl) {
        this.semesterMdl = semesterMdl;
    }

    public groupModel getGroupMdl() {
        return groupMdl;
    }

    public void setGroupMdl(groupModel groupMdl) {
        this.groupMdl = groupMdl;
    }

    public String getFL_STATUS_DIR() {
        return FL_STATUS_DIR;
    }

    public void setFL_STATUS_DIR(String FL_STATUS_DIR) {
        this.FL_STATUS_DIR = FL_STATUS_DIR;
    }

    public String getFL_STATUS_ES() {
        return FL_STATUS_ES;
    }

    public void setFL_STATUS_ES(String FL_STATUS_ES) {
        this.FL_STATUS_ES = FL_STATUS_ES;
    }
    
}
