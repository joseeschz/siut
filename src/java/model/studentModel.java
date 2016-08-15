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
public class studentModel extends careerModel{
    int PK_STUDENT=0;
    int PK_CERTIFIED_OF_STUDY=0;
    String FL_FOLIO_TEMP_SYSTEM="";
    String FL_ENROLLMENT="";
    int FK_CAREER=0;
    int PK_LEVEL_STUDY=0;
    int PK_ENTITY=0;
    int PK_MUNICIPALITY=0;
    int PK_LOCALITY=0;
    int FK_PREPARATORY=0;
    String FL_PASSWORD="";
    String FL_REGISTER_DATE="";
    String FL_UTSEM_FOLIO="";
    String FL_CENEVAL_FOLIO="";
    String FL_NAME="";
    String FL_PATERN_NAME="";
    String FL_MATERN_NAME="";
    String FL_DATE_BORN="";
    String FL_GENDER="";
    String FL_PHOTOGRAPHY="";
    String FL_MARITIAL_STATUS="";
    String FL_WORKING="";
    String FL_WHERE_WORK_PLACE_ADDRESS="";
    String FL_COMPANY_TYPE="";
    String FL_TELEPHONE_PLACE_WORK="";
    String FL_BACHEROL_TYPE="";
    String FL_SCHOOL_TYPE="";
    double FL_ABOVE_AVERAGE=0;
    String FL_PERIOD_BACHEROL="";
    String FL_NAME_UNIVERSITY_STUDIED="";
    String FL_PERIOD_TSU="";
    String FL_FILE_ID_OFICIAL="";
    String FL_FILE_DOCUMENT_BORN="";
    String FL_CURP="";
    String FL_FILE_CURP="";
    int FK_BORN_ENTITY=0;
    int FK_BORN_LOCALITY=0;
    int FK_BORN_MUNICIPALITY=0;
    String FL_NAME_STREET="";
    String FL_EXTERNAL_NUMBER="";
    String FL_INTERNAL_NUMBER="";
    String FL_BETWEEN_STREET1="";
    String FL_BETWEEN_STREET2="";
    String FL_REFERENCE="";
    String FK_CURRENT_ENTITY="";
    String FK_CURRENT_MUNICIPALITY="";
    String FK_CURRENT_LOCALITY="";
    String FL_CURRENT_COLONY="";
    String FL_ZIP_CODE="";
    String FL_PHONE_HOME="";
    String FL_CELL_PHONE="";
    String FL_MAIL="";
    String FL_FACEBOOK="";
    String FL_TWITTER="";
    String FL_PATERN_NAME_FATHER = "";
    String FL_MATERN_NAME_FATHER = "";
    String FL_NAME_FATHER="";
    String FL_BORN_DATE_FATHER="";
    String FL_MARITIAL_STATE_FATHER="";
    String FL_LEVEL_EDUCATION_FATHER="";
    String FL_PATERN_NAME_MOTHER="";
    String FL_MATERN_NAME_MOTHER="";
    String FL_NAME_MOTHER="";
    String FL_BORN_DATE_MOTHER="";
    String FL_MARITIAL_STATE_MOTHER="";
    String FL_LEVEL_EDUCATION_MOTHER="";
    String FL_TUTOR_RELATIONSHIP="";
    String FL_PATERN_NAME_TUTOR="";
    String FL_MATERN_NAME_TUTOR="";
    String FL_NAME_TUTOR="";
    String FL_BORN_DATE_TUTOR="";
    int FL_AGE_TUTOR=0;
    String FL_GENDER_TUTOR="";
    String FL_MARITIAL_STATE_TUTOR="";
    int FK_BORN_ENTITY_TUTOR=0;
    int FK_BORN_LOCALITY_TUTOR=0;
    int FK_BORN_MUNICIPALITY_TUTOR=0;
    String FL_BETWEEN_STREET1_TUTOR="";
    String FL_OCCUPATION_TUTOR="";
    String FL_LEVEL_EDUCATION="";
    String FL_FILE_ID_OFICIAL_TUTOR="";
    String FL_CURP_TUTOR="";
    String FL_FILE_CURP_TUTOR="";
    String FL_STREET_NAME_TUTOR="";
    String FL_EXTERNAL_NUMBER_TUTOR="";
    String FL_INTERNAL_NUMBER_TUTOR="";
    String FL_BETWEEN_STREET2_TUTOR="";
    String FL_REFERENCE_TUTOR="";
    int FK_CURRENT_ENTITY_TUTOR=0;
    int FK_CURRENT_MUNICIPALITY_TUTOR=0;
    int FK_CURRENT_LOCALITY_TUTOR=0;
    String FL_COLONY_TUTOR="";
    String FL_ZIP_CODE_TUTOR="";
    String FL_PHONE_HOME_TUTOR="";
    String FL_CELL_PHONE_TUTOR="";
    String FL_MAIL_TUTOR="";
    String FL_FACEBOOK_TUTOR="";
    String FL_TWITTER_TUTOR="";
    String FL_EMERGENCY_PHONE1="";
    String FL_EMERGENCY_PHONE2="";
    String FL_HOUSE_STATUS="";
    String FL_WALL_MATERIAL="";
    String FL_ROOF_MATERIAL="";
    String FL_FLOOR_MATERIAL="";
    String FL_ROOM="";
    String FL_DINING_ROOM="";
    String FL_KITCHEN="";
    String FL_TOILET="";
    String FL_TELEVISION="";
    String FL_STEREO="";
    String FL_VIDEO="";
    String FL_DVD="";
    String FL_COMPUTER="";
    String FL_NUMBER_MEMBERS_FAMLY="";
    String FL_LAPTOP="";
    String FL_REFRIGERATOR="";
    String FL_WASHER="";
    String FL_STOVE="";
    double FL_FAMILY_MONTHLY_INCOME=0;
    double FL_FAMILY_MONTHLY_DISCHARGE=0;
    double FL_STUDENT_MONTGLY_INCOME=0;
    double FL_STUDENT_MONTGLY_DISCHARGE=0;
    String FL_ACEPT_TERM="";
    String FL_DIFFUSION_CALL="";
    String FL_DIFFUSION_CARTEL="";
    String FL_DIFFUSION_PLANTEL_TALKS="";
    String FL_DIFFUSION_PERSONAL_UT="";
    String FL_DIFFUSION_GRADUATES="";
    String FL_DIFFUSION_FAMILY_FRIENDS="";
    String FL_DIFFUSION_DIRECTLT_UT="";
    String FL_DIFFUSION_BROCHURE="";
    String FL_DIFFUSION_NEWSPAPER="";
    String FL_DIFFUSION_STUDENTS_UT="";
    String FL_DIFFUSION_MANTA="";
    String FL_DIFFUSION_TRIPTYCH="";
    String FL_DIFFUSION_GUIDED_VISITS="";
    String FL_DIFFUSION_EXHIBITIONS="";
    String FL_DIFFUSION_OTHER="";
    String FL_DIFFUSION_OTHER_NAME="";
    String FL_OPTION_UTSEM_STUDY="";
    String FL_PHYSICAL_DISABILITY="";
    String FL_DISABILITY_NAME="";
    String FL_INDIGENOUS_GROUP="";
    String FL_INDIGENOUS_GROUP_NAME="";
    String FL_SECUTITY_MEDICAL="";
    String FL_SECURITY_NAME="";
    String FL_NUMBER_SECURITY_MEDICAL="";
    String FL_WHOM_DEPEND="";
    String FL_DEPEND_ECONOMICALLY_WORK="";
    String FL_WHERE_WORK="";
    String FL_WHAT_WORK="";
    String FL_BIRTH_CERTIFICATE_NUMBER="";
    String FL_HIGH_SCHOOL_CERTIFICATE="";
    int FL_DOWN=0;
    int FL_MODIFY=0;
    int FL_AUTHORIZED_ACCESS_PREREGISTER_ING=0;
    int FL_METADATA_PREREGISTER_ING=0;
    int FL_PREINSCRIPTION_ING = 0;
    int FL_INSCRIPTION_ING=0;
    semesterModel semesterMl;

    public int getPK_STUDENT() {
        return PK_STUDENT;
    }

    public void setPK_STUDENT(int PK_STUDENT) {
        this.PK_STUDENT = PK_STUDENT;
    }

    public int getPK_CERTIFIED_OF_STUDY() {
        return PK_CERTIFIED_OF_STUDY;
    }

    public void setPK_CERTIFIED_OF_STUDY(int PK_CERTIFIED_OF_STUDY) {
        this.PK_CERTIFIED_OF_STUDY = PK_CERTIFIED_OF_STUDY;
    }

    public String getFL_FOLIO_TEMP_SYSTEM() {
        return FL_FOLIO_TEMP_SYSTEM;
    }

    public void setFL_FOLIO_TEMP_SYSTEM(String FL_FOLIO_TEMP_SYSTEM) {
        this.FL_FOLIO_TEMP_SYSTEM = FL_FOLIO_TEMP_SYSTEM;
    }

    public String getFL_ENROLLMENT() {
        return FL_ENROLLMENT;
    }

    public void setFL_ENROLLMENT(String FL_ENROLLMENT) {
        this.FL_ENROLLMENT = FL_ENROLLMENT;
    }

    public int getFK_CAREER() {
        return FK_CAREER;
    }

    public void setFK_CAREER(int FK_CAREER) {
        this.FK_CAREER = FK_CAREER;
    }

    public int getPK_LEVEL_STUDY() {
        return PK_LEVEL_STUDY;
    }

    public void setPK_LEVEL_STUDY(int PK_LEVEL_STUDY) {
        this.PK_LEVEL_STUDY = PK_LEVEL_STUDY;
    }

    public int getPK_ENTITY() {
        return PK_ENTITY;
    }

    public void setPK_ENTITY(int PK_ENTITY) {
        this.PK_ENTITY = PK_ENTITY;
    }

    public int getPK_MUNICIPALITY() {
        return PK_MUNICIPALITY;
    }

    public void setPK_MUNICIPALITY(int PK_MUNICIPALITY) {
        this.PK_MUNICIPALITY = PK_MUNICIPALITY;
    }

    public int getPK_LOCALITY() {
        return PK_LOCALITY;
    }

    public void setPK_LOCALITY(int PK_LOCALITY) {
        this.PK_LOCALITY = PK_LOCALITY;
    }

    public int getFK_PREPARATORY() {
        return FK_PREPARATORY;
    }

    public void setFK_PREPARATORY(int FK_PREPARATORY) {
        this.FK_PREPARATORY = FK_PREPARATORY;
    }

    public String getFL_PASSWORD() {
        return FL_PASSWORD;
    }

    public void setFL_PASSWORD(String FL_PASSWORD) {
        this.FL_PASSWORD = FL_PASSWORD;
    }

    public String getFL_REGISTER_DATE() {
        return FL_REGISTER_DATE;
    }

    public void setFL_REGISTER_DATE(String FL_REGISTER_DATE) {
        this.FL_REGISTER_DATE = FL_REGISTER_DATE;
    }

    public String getFL_UTSEM_FOLIO() {
        return FL_UTSEM_FOLIO;
    }

    public void setFL_UTSEM_FOLIO(String FL_UTSEM_FOLIO) {
        this.FL_UTSEM_FOLIO = FL_UTSEM_FOLIO;
    }

    public String getFL_CENEVAL_FOLIO() {
        return FL_CENEVAL_FOLIO;
    }

    public void setFL_CENEVAL_FOLIO(String FL_CENEVAL_FOLIO) {
        this.FL_CENEVAL_FOLIO = FL_CENEVAL_FOLIO;
    }

    public String getFL_NAME() {
        return FL_NAME;
    }

    public void setFL_NAME(String FL_NAME) {
        this.FL_NAME = FL_NAME;
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

    public String getFL_DATE_BORN() {
        return FL_DATE_BORN;
    }

    public void setFL_DATE_BORN(String FL_DATE_BORN) {
        this.FL_DATE_BORN = FL_DATE_BORN;
    }

    public String getFL_GENDER() {
        return FL_GENDER;
    }

    public void setFL_GENDER(String FL_GENDER) {
        this.FL_GENDER = FL_GENDER;
    }

    public String getFL_PHOTOGRAPHY() {
        return FL_PHOTOGRAPHY;
    }

    public void setFL_PHOTOGRAPHY(String FL_PHOTOGRAPHY) {
        this.FL_PHOTOGRAPHY = FL_PHOTOGRAPHY;
    }

    public String getFL_MARITIAL_STATUS() {
        return FL_MARITIAL_STATUS;
    }

    public void setFL_MARITIAL_STATUS(String FL_MARITIAL_STATUS) {
        this.FL_MARITIAL_STATUS = FL_MARITIAL_STATUS;
    }

    public String getFL_WORKING() {
        return FL_WORKING;
    }

    public void setFL_WORKING(String FL_WORKING) {
        this.FL_WORKING = FL_WORKING;
    }

    public String getFL_WHERE_WORK_PLACE_ADDRESS() {
        return FL_WHERE_WORK_PLACE_ADDRESS;
    }

    public void setFL_WHERE_WORK_PLACE_ADDRESS(String FL_WHERE_WORK_PLACE_ADDRESS) {
        this.FL_WHERE_WORK_PLACE_ADDRESS = FL_WHERE_WORK_PLACE_ADDRESS;
    }

    public String getFL_COMPANY_TYPE() {
        return FL_COMPANY_TYPE;
    }

    public void setFL_COMPANY_TYPE(String FL_COMPANY_TYPE) {
        this.FL_COMPANY_TYPE = FL_COMPANY_TYPE;
    }

    public String getFL_TELEPHONE_PLACE_WORK() {
        return FL_TELEPHONE_PLACE_WORK;
    }

    public void setFL_TELEPHONE_PLACE_WORK(String FL_TELEPHONE_PLACE_WORK) {
        this.FL_TELEPHONE_PLACE_WORK = FL_TELEPHONE_PLACE_WORK;
    }

    public String getFL_BACHEROL_TYPE() {
        return FL_BACHEROL_TYPE;
    }

    public void setFL_BACHEROL_TYPE(String FL_BACHEROL_TYPE) {
        this.FL_BACHEROL_TYPE = FL_BACHEROL_TYPE;
    }

    public String getFL_SCHOOL_TYPE() {
        return FL_SCHOOL_TYPE;
    }

    public void setFL_SCHOOL_TYPE(String FL_SCHOOL_TYPE) {
        this.FL_SCHOOL_TYPE = FL_SCHOOL_TYPE;
    }

    public double getFL_ABOVE_AVERAGE() {
        return FL_ABOVE_AVERAGE;
    }

    public void setFL_ABOVE_AVERAGE(double FL_ABOVE_AVERAGE) {
        this.FL_ABOVE_AVERAGE = FL_ABOVE_AVERAGE;
    }

    public String getFL_PERIOD_BACHEROL() {
        return FL_PERIOD_BACHEROL;
    }

    public void setFL_PERIOD_BACHEROL(String FL_PERIOD_BACHEROL) {
        this.FL_PERIOD_BACHEROL = FL_PERIOD_BACHEROL;
    }

    public String getFL_NAME_UNIVERSITY_STUDIED() {
        return FL_NAME_UNIVERSITY_STUDIED;
    }

    public void setFL_NAME_UNIVERSITY_STUDIED(String FL_NAME_UNIVERSITY_STUDIED) {
        this.FL_NAME_UNIVERSITY_STUDIED = FL_NAME_UNIVERSITY_STUDIED;
    }

    public String getFL_PERIOD_TSU() {
        return FL_PERIOD_TSU;
    }

    public void setFL_PERIOD_TSU(String FL_PERIOD_TSU) {
        this.FL_PERIOD_TSU = FL_PERIOD_TSU;
    }

    public String getFL_FILE_ID_OFICIAL() {
        return FL_FILE_ID_OFICIAL;
    }

    public void setFL_FILE_ID_OFICIAL(String FL_FILE_ID_OFICIAL) {
        this.FL_FILE_ID_OFICIAL = FL_FILE_ID_OFICIAL;
    }

    public String getFL_FILE_DOCUMENT_BORN() {
        return FL_FILE_DOCUMENT_BORN;
    }

    public void setFL_FILE_DOCUMENT_BORN(String FL_FILE_DOCUMENT_BORN) {
        this.FL_FILE_DOCUMENT_BORN = FL_FILE_DOCUMENT_BORN;
    }

    public String getFL_CURP() {
        return FL_CURP;
    }

    public void setFL_CURP(String FL_CURP) {
        this.FL_CURP = FL_CURP;
    }

    public String getFL_FILE_CURP() {
        return FL_FILE_CURP;
    }

    public void setFL_FILE_CURP(String FL_FILE_CURP) {
        this.FL_FILE_CURP = FL_FILE_CURP;
    }

    public int getFK_BORN_ENTITY() {
        return FK_BORN_ENTITY;
    }

    public void setFK_BORN_ENTITY(int FK_BORN_ENTITY) {
        this.FK_BORN_ENTITY = FK_BORN_ENTITY;
    }

    public int getFK_BORN_LOCALITY() {
        return FK_BORN_LOCALITY;
    }

    public void setFK_BORN_LOCALITY(int FK_BORN_LOCALITY) {
        this.FK_BORN_LOCALITY = FK_BORN_LOCALITY;
    }

    public int getFK_BORN_MUNICIPALITY() {
        return FK_BORN_MUNICIPALITY;
    }

    public void setFK_BORN_MUNICIPALITY(int FK_BORN_MUNICIPALITY) {
        this.FK_BORN_MUNICIPALITY = FK_BORN_MUNICIPALITY;
    }

    public String getFL_NAME_STREET() {
        return FL_NAME_STREET;
    }

    public void setFL_NAME_STREET(String FL_NAME_STREET) {
        this.FL_NAME_STREET = FL_NAME_STREET;
    }

    public String getFL_EXTERNAL_NUMBER() {
        return FL_EXTERNAL_NUMBER;
    }

    public void setFL_EXTERNAL_NUMBER(String FL_EXTERNAL_NUMBER) {
        this.FL_EXTERNAL_NUMBER = FL_EXTERNAL_NUMBER;
    }

    public String getFL_INTERNAL_NUMBER() {
        return FL_INTERNAL_NUMBER;
    }

    public void setFL_INTERNAL_NUMBER(String FL_INTERNAL_NUMBER) {
        this.FL_INTERNAL_NUMBER = FL_INTERNAL_NUMBER;
    }

    public String getFL_BETWEEN_STREET1() {
        return FL_BETWEEN_STREET1;
    }

    public void setFL_BETWEEN_STREET1(String FL_BETWEEN_STREET1) {
        this.FL_BETWEEN_STREET1 = FL_BETWEEN_STREET1;
    }

    public String getFL_BETWEEN_STREET2() {
        return FL_BETWEEN_STREET2;
    }

    public void setFL_BETWEEN_STREET2(String FL_BETWEEN_STREET2) {
        this.FL_BETWEEN_STREET2 = FL_BETWEEN_STREET2;
    }

    public String getFL_REFERENCE() {
        return FL_REFERENCE;
    }

    public void setFL_REFERENCE(String FL_REFERENCE) {
        this.FL_REFERENCE = FL_REFERENCE;
    }

    public String getFK_CURRENT_ENTITY() {
        return FK_CURRENT_ENTITY;
    }

    public void setFK_CURRENT_ENTITY(String FK_CURRENT_ENTITY) {
        this.FK_CURRENT_ENTITY = FK_CURRENT_ENTITY;
    }

    public String getFK_CURRENT_MUNICIPALITY() {
        return FK_CURRENT_MUNICIPALITY;
    }

    public void setFK_CURRENT_MUNICIPALITY(String FK_CURRENT_MUNICIPALITY) {
        this.FK_CURRENT_MUNICIPALITY = FK_CURRENT_MUNICIPALITY;
    }

    public String getFK_CURRENT_LOCALITY() {
        return FK_CURRENT_LOCALITY;
    }

    public void setFK_CURRENT_LOCALITY(String FK_CURRENT_LOCALITY) {
        this.FK_CURRENT_LOCALITY = FK_CURRENT_LOCALITY;
    }

    public String getFL_CURRENT_COLONY() {
        return FL_CURRENT_COLONY;
    }

    public void setFL_CURRENT_COLONY(String FL_CURRENT_COLONY) {
        this.FL_CURRENT_COLONY = FL_CURRENT_COLONY;
    }

    public String getFL_ZIP_CODE() {
        return FL_ZIP_CODE;
    }

    public void setFL_ZIP_CODE(String FL_ZIP_CODE) {
        this.FL_ZIP_CODE = FL_ZIP_CODE;
    }

    public String getFL_PHONE_HOME() {
        return FL_PHONE_HOME;
    }

    public void setFL_PHONE_HOME(String FL_PHONE_HOME) {
        this.FL_PHONE_HOME = FL_PHONE_HOME;
    }

    public String getFL_CELL_PHONE() {
        return FL_CELL_PHONE;
    }

    public void setFL_CELL_PHONE(String FL_CELL_PHONE) {
        this.FL_CELL_PHONE = FL_CELL_PHONE;
    }

    public String getFL_MAIL() {
        return FL_MAIL;
    }

    public void setFL_MAIL(String FL_MAIL) {
        this.FL_MAIL = FL_MAIL;
    }

    public String getFL_FACEBOOK() {
        return FL_FACEBOOK;
    }

    public void setFL_FACEBOOK(String FL_FACEBOOK) {
        this.FL_FACEBOOK = FL_FACEBOOK;
    }

    public String getFL_TWITTER() {
        return FL_TWITTER;
    }

    public void setFL_TWITTER(String FL_TWITTER) {
        this.FL_TWITTER = FL_TWITTER;
    }

    public String getFL_PATERN_NAME_FATHER() {
        return FL_PATERN_NAME_FATHER;
    }

    public void setFL_PATERN_NAME_FATHER(String FL_PATERN_NAME_FATHER) {
        this.FL_PATERN_NAME_FATHER = FL_PATERN_NAME_FATHER;
    }

    public String getFL_MATERN_NAME_FATHER() {
        return FL_MATERN_NAME_FATHER;
    }

    public void setFL_MATERN_NAME_FATHER(String FL_MATERN_NAME_FATHER) {
        this.FL_MATERN_NAME_FATHER = FL_MATERN_NAME_FATHER;
    }

    public String getFL_NAME_FATHER() {
        return FL_NAME_FATHER;
    }

    public void setFL_NAME_FATHER(String FL_NAME_FATHER) {
        this.FL_NAME_FATHER = FL_NAME_FATHER;
    }

    public String getFL_BORN_DATE_FATHER() {
        return FL_BORN_DATE_FATHER;
    }

    public void setFL_BORN_DATE_FATHER(String FL_BORN_DATE_FATHER) {
        this.FL_BORN_DATE_FATHER = FL_BORN_DATE_FATHER;
    }

    public String getFL_MARITIAL_STATE_FATHER() {
        return FL_MARITIAL_STATE_FATHER;
    }

    public void setFL_MARITIAL_STATE_FATHER(String FL_MARITIAL_STATE_FATHER) {
        this.FL_MARITIAL_STATE_FATHER = FL_MARITIAL_STATE_FATHER;
    }

    public String getFL_LEVEL_EDUCATION_FATHER() {
        return FL_LEVEL_EDUCATION_FATHER;
    }

    public void setFL_LEVEL_EDUCATION_FATHER(String FL_LEVEL_EDUCATION_FATHER) {
        this.FL_LEVEL_EDUCATION_FATHER = FL_LEVEL_EDUCATION_FATHER;
    }

    public String getFL_PATERN_NAME_MOTHER() {
        return FL_PATERN_NAME_MOTHER;
    }

    public void setFL_PATERN_NAME_MOTHER(String FL_PATERN_NAME_MOTHER) {
        this.FL_PATERN_NAME_MOTHER = FL_PATERN_NAME_MOTHER;
    }

    public String getFL_MATERN_NAME_MOTHER() {
        return FL_MATERN_NAME_MOTHER;
    }

    public void setFL_MATERN_NAME_MOTHER(String FL_MATERN_NAME_MOTHER) {
        this.FL_MATERN_NAME_MOTHER = FL_MATERN_NAME_MOTHER;
    }

    public String getFL_NAME_MOTHER() {
        return FL_NAME_MOTHER;
    }

    public void setFL_NAME_MOTHER(String FL_NAME_MOTHER) {
        this.FL_NAME_MOTHER = FL_NAME_MOTHER;
    }

    public String getFL_BORN_DATE_MOTHER() {
        return FL_BORN_DATE_MOTHER;
    }

    public void setFL_BORN_DATE_MOTHER(String FL_BORN_DATE_MOTHER) {
        this.FL_BORN_DATE_MOTHER = FL_BORN_DATE_MOTHER;
    }

    public String getFL_MARITIAL_STATE_MOTHER() {
        return FL_MARITIAL_STATE_MOTHER;
    }

    public void setFL_MARITIAL_STATE_MOTHER(String FL_MARITIAL_STATE_MOTHER) {
        this.FL_MARITIAL_STATE_MOTHER = FL_MARITIAL_STATE_MOTHER;
    }

    public String getFL_LEVEL_EDUCATION_MOTHER() {
        return FL_LEVEL_EDUCATION_MOTHER;
    }

    public void setFL_LEVEL_EDUCATION_MOTHER(String FL_LEVEL_EDUCATION_MOTHER) {
        this.FL_LEVEL_EDUCATION_MOTHER = FL_LEVEL_EDUCATION_MOTHER;
    }

    public String getFL_TUTOR_RELATIONSHIP() {
        return FL_TUTOR_RELATIONSHIP;
    }

    public void setFL_TUTOR_RELATIONSHIP(String FL_TUTOR_RELATIONSHIP) {
        this.FL_TUTOR_RELATIONSHIP = FL_TUTOR_RELATIONSHIP;
    }

    public String getFL_PATERN_NAME_TUTOR() {
        return FL_PATERN_NAME_TUTOR;
    }

    public void setFL_PATERN_NAME_TUTOR(String FL_PATERN_NAME_TUTOR) {
        this.FL_PATERN_NAME_TUTOR = FL_PATERN_NAME_TUTOR;
    }

    public String getFL_MATERN_NAME_TUTOR() {
        return FL_MATERN_NAME_TUTOR;
    }

    public void setFL_MATERN_NAME_TUTOR(String FL_MATERN_NAME_TUTOR) {
        this.FL_MATERN_NAME_TUTOR = FL_MATERN_NAME_TUTOR;
    }

    public String getFL_NAME_TUTOR() {
        return FL_NAME_TUTOR;
    }

    public void setFL_NAME_TUTOR(String FL_NAME_TUTOR) {
        this.FL_NAME_TUTOR = FL_NAME_TUTOR;
    }

    public String getFL_BORN_DATE_TUTOR() {
        return FL_BORN_DATE_TUTOR;
    }

    public void setFL_BORN_DATE_TUTOR(String FL_BORN_DATE_TUTOR) {
        this.FL_BORN_DATE_TUTOR = FL_BORN_DATE_TUTOR;
    }

    public int getFL_AGE_TUTOR() {
        return FL_AGE_TUTOR;
    }

    public void setFL_AGE_TUTOR(int FL_AGE_TUTOR) {
        this.FL_AGE_TUTOR = FL_AGE_TUTOR;
    }

    public String getFL_GENDER_TUTOR() {
        return FL_GENDER_TUTOR;
    }

    public void setFL_GENDER_TUTOR(String FL_GENDER_TUTOR) {
        this.FL_GENDER_TUTOR = FL_GENDER_TUTOR;
    }

    public String getFL_MARITIAL_STATE_TUTOR() {
        return FL_MARITIAL_STATE_TUTOR;
    }

    public void setFL_MARITIAL_STATE_TUTOR(String FL_MARITIAL_STATE_TUTOR) {
        this.FL_MARITIAL_STATE_TUTOR = FL_MARITIAL_STATE_TUTOR;
    }

    public int getFK_BORN_ENTITY_TUTOR() {
        return FK_BORN_ENTITY_TUTOR;
    }

    public void setFK_BORN_ENTITY_TUTOR(int FK_BORN_ENTITY_TUTOR) {
        this.FK_BORN_ENTITY_TUTOR = FK_BORN_ENTITY_TUTOR;
    }

    public int getFK_BORN_LOCALITY_TUTOR() {
        return FK_BORN_LOCALITY_TUTOR;
    }

    public void setFK_BORN_LOCALITY_TUTOR(int FK_BORN_LOCALITY_TUTOR) {
        this.FK_BORN_LOCALITY_TUTOR = FK_BORN_LOCALITY_TUTOR;
    }

    public int getFK_BORN_MUNICIPALITY_TUTOR() {
        return FK_BORN_MUNICIPALITY_TUTOR;
    }

    public void setFK_BORN_MUNICIPALITY_TUTOR(int FK_BORN_MUNICIPALITY_TUTOR) {
        this.FK_BORN_MUNICIPALITY_TUTOR = FK_BORN_MUNICIPALITY_TUTOR;
    }

    public String getFL_BETWEEN_STREET1_TUTOR() {
        return FL_BETWEEN_STREET1_TUTOR;
    }

    public void setFL_BETWEEN_STREET1_TUTOR(String FL_BETWEEN_STREET1_TUTOR) {
        this.FL_BETWEEN_STREET1_TUTOR = FL_BETWEEN_STREET1_TUTOR;
    }

    public String getFL_OCCUPATION_TUTOR() {
        return FL_OCCUPATION_TUTOR;
    }

    public void setFL_OCCUPATION_TUTOR(String FL_OCCUPATION_TUTOR) {
        this.FL_OCCUPATION_TUTOR = FL_OCCUPATION_TUTOR;
    }

    public String getFL_LEVEL_EDUCATION() {
        return FL_LEVEL_EDUCATION;
    }

    public void setFL_LEVEL_EDUCATION(String FL_LEVEL_EDUCATION) {
        this.FL_LEVEL_EDUCATION = FL_LEVEL_EDUCATION;
    }

    public String getFL_FILE_ID_OFICIAL_TUTOR() {
        return FL_FILE_ID_OFICIAL_TUTOR;
    }

    public void setFL_FILE_ID_OFICIAL_TUTOR(String FL_FILE_ID_OFICIAL_TUTOR) {
        this.FL_FILE_ID_OFICIAL_TUTOR = FL_FILE_ID_OFICIAL_TUTOR;
    }

    public String getFL_CURP_TUTOR() {
        return FL_CURP_TUTOR;
    }

    public void setFL_CURP_TUTOR(String FL_CURP_TUTOR) {
        this.FL_CURP_TUTOR = FL_CURP_TUTOR;
    }

    public String getFL_FILE_CURP_TUTOR() {
        return FL_FILE_CURP_TUTOR;
    }

    public void setFL_FILE_CURP_TUTOR(String FL_FILE_CURP_TUTOR) {
        this.FL_FILE_CURP_TUTOR = FL_FILE_CURP_TUTOR;
    }

    public String getFL_STREET_NAME_TUTOR() {
        return FL_STREET_NAME_TUTOR;
    }

    public void setFL_STREET_NAME_TUTOR(String FL_STREET_NAME_TUTOR) {
        this.FL_STREET_NAME_TUTOR = FL_STREET_NAME_TUTOR;
    }

    public String getFL_EXTERNAL_NUMBER_TUTOR() {
        return FL_EXTERNAL_NUMBER_TUTOR;
    }

    public void setFL_EXTERNAL_NUMBER_TUTOR(String FL_EXTERNAL_NUMBER_TUTOR) {
        this.FL_EXTERNAL_NUMBER_TUTOR = FL_EXTERNAL_NUMBER_TUTOR;
    }

    public String getFL_INTERNAL_NUMBER_TUTOR() {
        return FL_INTERNAL_NUMBER_TUTOR;
    }

    public void setFL_INTERNAL_NUMBER_TUTOR(String FL_INTERNAL_NUMBER_TUTOR) {
        this.FL_INTERNAL_NUMBER_TUTOR = FL_INTERNAL_NUMBER_TUTOR;
    }

    public String getFL_BETWEEN_STREET2_TUTOR() {
        return FL_BETWEEN_STREET2_TUTOR;
    }

    public void setFL_BETWEEN_STREET2_TUTOR(String FL_BETWEEN_STREET2_TUTOR) {
        this.FL_BETWEEN_STREET2_TUTOR = FL_BETWEEN_STREET2_TUTOR;
    }

    public String getFL_REFERENCE_TUTOR() {
        return FL_REFERENCE_TUTOR;
    }

    public void setFL_REFERENCE_TUTOR(String FL_REFERENCE_TUTOR) {
        this.FL_REFERENCE_TUTOR = FL_REFERENCE_TUTOR;
    }

    public int getFK_CURRENT_ENTITY_TUTOR() {
        return FK_CURRENT_ENTITY_TUTOR;
    }

    public void setFK_CURRENT_ENTITY_TUTOR(int FK_CURRENT_ENTITY_TUTOR) {
        this.FK_CURRENT_ENTITY_TUTOR = FK_CURRENT_ENTITY_TUTOR;
    }

    public int getFK_CURRENT_MUNICIPALITY_TUTOR() {
        return FK_CURRENT_MUNICIPALITY_TUTOR;
    }

    public void setFK_CURRENT_MUNICIPALITY_TUTOR(int FK_CURRENT_MUNICIPALITY_TUTOR) {
        this.FK_CURRENT_MUNICIPALITY_TUTOR = FK_CURRENT_MUNICIPALITY_TUTOR;
    }

    public int getFK_CURRENT_LOCALITY_TUTOR() {
        return FK_CURRENT_LOCALITY_TUTOR;
    }

    public void setFK_CURRENT_LOCALITY_TUTOR(int FK_CURRENT_LOCALITY_TUTOR) {
        this.FK_CURRENT_LOCALITY_TUTOR = FK_CURRENT_LOCALITY_TUTOR;
    }

    public String getFL_COLONY_TUTOR() {
        return FL_COLONY_TUTOR;
    }

    public void setFL_COLONY_TUTOR(String FL_COLONY_TUTOR) {
        this.FL_COLONY_TUTOR = FL_COLONY_TUTOR;
    }

    public String getFL_ZIP_CODE_TUTOR() {
        return FL_ZIP_CODE_TUTOR;
    }

    public void setFL_ZIP_CODE_TUTOR(String FL_ZIP_CODE_TUTOR) {
        this.FL_ZIP_CODE_TUTOR = FL_ZIP_CODE_TUTOR;
    }

    public String getFL_PHONE_HOME_TUTOR() {
        return FL_PHONE_HOME_TUTOR;
    }

    public void setFL_PHONE_HOME_TUTOR(String FL_PHONE_HOME_TUTOR) {
        this.FL_PHONE_HOME_TUTOR = FL_PHONE_HOME_TUTOR;
    }

    public String getFL_CELL_PHONE_TUTOR() {
        return FL_CELL_PHONE_TUTOR;
    }

    public void setFL_CELL_PHONE_TUTOR(String FL_CELL_PHONE_TUTOR) {
        this.FL_CELL_PHONE_TUTOR = FL_CELL_PHONE_TUTOR;
    }

    public String getFL_MAIL_TUTOR() {
        return FL_MAIL_TUTOR;
    }

    public void setFL_MAIL_TUTOR(String FL_MAIL_TUTOR) {
        this.FL_MAIL_TUTOR = FL_MAIL_TUTOR;
    }

    public String getFL_FACEBOOK_TUTOR() {
        return FL_FACEBOOK_TUTOR;
    }

    public void setFL_FACEBOOK_TUTOR(String FL_FACEBOOK_TUTOR) {
        this.FL_FACEBOOK_TUTOR = FL_FACEBOOK_TUTOR;
    }

    public String getFL_TWITTER_TUTOR() {
        return FL_TWITTER_TUTOR;
    }

    public void setFL_TWITTER_TUTOR(String FL_TWITTER_TUTOR) {
        this.FL_TWITTER_TUTOR = FL_TWITTER_TUTOR;
    }

    public String getFL_EMERGENCY_PHONE1() {
        return FL_EMERGENCY_PHONE1;
    }

    public void setFL_EMERGENCY_PHONE1(String FL_EMERGENCY_PHONE1) {
        this.FL_EMERGENCY_PHONE1 = FL_EMERGENCY_PHONE1;
    }

    public String getFL_EMERGENCY_PHONE2() {
        return FL_EMERGENCY_PHONE2;
    }

    public void setFL_EMERGENCY_PHONE2(String FL_EMERGENCY_PHONE2) {
        this.FL_EMERGENCY_PHONE2 = FL_EMERGENCY_PHONE2;
    }

    public String getFL_HOUSE_STATUS() {
        return FL_HOUSE_STATUS;
    }

    public void setFL_HOUSE_STATUS(String FL_HOUSE_STATUS) {
        this.FL_HOUSE_STATUS = FL_HOUSE_STATUS;
    }

    public String getFL_WALL_MATERIAL() {
        return FL_WALL_MATERIAL;
    }

    public void setFL_WALL_MATERIAL(String FL_WALL_MATERIAL) {
        this.FL_WALL_MATERIAL = FL_WALL_MATERIAL;
    }

    public String getFL_ROOF_MATERIAL() {
        return FL_ROOF_MATERIAL;
    }

    public void setFL_ROOF_MATERIAL(String FL_ROOF_MATERIAL) {
        this.FL_ROOF_MATERIAL = FL_ROOF_MATERIAL;
    }

    public String getFL_FLOOR_MATERIAL() {
        return FL_FLOOR_MATERIAL;
    }

    public void setFL_FLOOR_MATERIAL(String FL_FLOOR_MATERIAL) {
        this.FL_FLOOR_MATERIAL = FL_FLOOR_MATERIAL;
    }

    public String getFL_ROOM() {
        return FL_ROOM;
    }

    public void setFL_ROOM(String FL_ROOM) {
        this.FL_ROOM = FL_ROOM;
    }

    public String getFL_DINING_ROOM() {
        return FL_DINING_ROOM;
    }

    public void setFL_DINING_ROOM(String FL_DINING_ROOM) {
        this.FL_DINING_ROOM = FL_DINING_ROOM;
    }

    public String getFL_KITCHEN() {
        return FL_KITCHEN;
    }

    public void setFL_KITCHEN(String FL_KITCHEN) {
        this.FL_KITCHEN = FL_KITCHEN;
    }

    public String getFL_TOILET() {
        return FL_TOILET;
    }

    public void setFL_TOILET(String FL_TOILET) {
        this.FL_TOILET = FL_TOILET;
    }

    public String getFL_TELEVISION() {
        return FL_TELEVISION;
    }

    public void setFL_TELEVISION(String FL_TELEVISION) {
        this.FL_TELEVISION = FL_TELEVISION;
    }

    public String getFL_STEREO() {
        return FL_STEREO;
    }

    public void setFL_STEREO(String FL_STEREO) {
        this.FL_STEREO = FL_STEREO;
    }

    public String getFL_VIDEO() {
        return FL_VIDEO;
    }

    public void setFL_VIDEO(String FL_VIDEO) {
        this.FL_VIDEO = FL_VIDEO;
    }

    public String getFL_DVD() {
        return FL_DVD;
    }

    public void setFL_DVD(String FL_DVD) {
        this.FL_DVD = FL_DVD;
    }

    public String getFL_COMPUTER() {
        return FL_COMPUTER;
    }

    public void setFL_COMPUTER(String FL_COMPUTER) {
        this.FL_COMPUTER = FL_COMPUTER;
    }

    public String getFL_NUMBER_MEMBERS_FAMLY() {
        return FL_NUMBER_MEMBERS_FAMLY;
    }

    public void setFL_NUMBER_MEMBERS_FAMLY(String FL_NUMBER_MEMBERS_FAMLY) {
        this.FL_NUMBER_MEMBERS_FAMLY = FL_NUMBER_MEMBERS_FAMLY;
    }

    public String getFL_LAPTOP() {
        return FL_LAPTOP;
    }

    public void setFL_LAPTOP(String FL_LAPTOP) {
        this.FL_LAPTOP = FL_LAPTOP;
    }

    public String getFL_REFRIGERATOR() {
        return FL_REFRIGERATOR;
    }

    public void setFL_REFRIGERATOR(String FL_REFRIGERATOR) {
        this.FL_REFRIGERATOR = FL_REFRIGERATOR;
    }

    public String getFL_WASHER() {
        return FL_WASHER;
    }

    public void setFL_WASHER(String FL_WASHER) {
        this.FL_WASHER = FL_WASHER;
    }

    public String getFL_STOVE() {
        return FL_STOVE;
    }

    public void setFL_STOVE(String FL_STOVE) {
        this.FL_STOVE = FL_STOVE;
    }

    public double getFL_FAMILY_MONTHLY_INCOME() {
        return FL_FAMILY_MONTHLY_INCOME;
    }

    public void setFL_FAMILY_MONTHLY_INCOME(double FL_FAMILY_MONTHLY_INCOME) {
        this.FL_FAMILY_MONTHLY_INCOME = FL_FAMILY_MONTHLY_INCOME;
    }

    public double getFL_FAMILY_MONTHLY_DISCHARGE() {
        return FL_FAMILY_MONTHLY_DISCHARGE;
    }

    public void setFL_FAMILY_MONTHLY_DISCHARGE(double FL_FAMILY_MONTHLY_DISCHARGE) {
        this.FL_FAMILY_MONTHLY_DISCHARGE = FL_FAMILY_MONTHLY_DISCHARGE;
    }

    public double getFL_STUDENT_MONTGLY_INCOME() {
        return FL_STUDENT_MONTGLY_INCOME;
    }

    public void setFL_STUDENT_MONTGLY_INCOME(double FL_STUDENT_MONTGLY_INCOME) {
        this.FL_STUDENT_MONTGLY_INCOME = FL_STUDENT_MONTGLY_INCOME;
    }

    public double getFL_STUDENT_MONTGLY_DISCHARGE() {
        return FL_STUDENT_MONTGLY_DISCHARGE;
    }

    public void setFL_STUDENT_MONTGLY_DISCHARGE(double FL_STUDENT_MONTGLY_DISCHARGE) {
        this.FL_STUDENT_MONTGLY_DISCHARGE = FL_STUDENT_MONTGLY_DISCHARGE;
    }

    public String getFL_ACEPT_TERM() {
        return FL_ACEPT_TERM;
    }

    public void setFL_ACEPT_TERM(String FL_ACEPT_TERM) {
        this.FL_ACEPT_TERM = FL_ACEPT_TERM;
    }

    public String getFL_DIFFUSION_CALL() {
        return FL_DIFFUSION_CALL;
    }

    public void setFL_DIFFUSION_CALL(String FL_DIFFUSION_CALL) {
        this.FL_DIFFUSION_CALL = FL_DIFFUSION_CALL;
    }

    public String getFL_DIFFUSION_CARTEL() {
        return FL_DIFFUSION_CARTEL;
    }

    public void setFL_DIFFUSION_CARTEL(String FL_DIFFUSION_CARTEL) {
        this.FL_DIFFUSION_CARTEL = FL_DIFFUSION_CARTEL;
    }

    public String getFL_DIFFUSION_PLANTEL_TALKS() {
        return FL_DIFFUSION_PLANTEL_TALKS;
    }

    public void setFL_DIFFUSION_PLANTEL_TALKS(String FL_DIFFUSION_PLANTEL_TALKS) {
        this.FL_DIFFUSION_PLANTEL_TALKS = FL_DIFFUSION_PLANTEL_TALKS;
    }

    public String getFL_DIFFUSION_PERSONAL_UT() {
        return FL_DIFFUSION_PERSONAL_UT;
    }

    public void setFL_DIFFUSION_PERSONAL_UT(String FL_DIFFUSION_PERSONAL_UT) {
        this.FL_DIFFUSION_PERSONAL_UT = FL_DIFFUSION_PERSONAL_UT;
    }

    public String getFL_DIFFUSION_GRADUATES() {
        return FL_DIFFUSION_GRADUATES;
    }

    public void setFL_DIFFUSION_GRADUATES(String FL_DIFFUSION_GRADUATES) {
        this.FL_DIFFUSION_GRADUATES = FL_DIFFUSION_GRADUATES;
    }

    public String getFL_DIFFUSION_FAMILY_FRIENDS() {
        return FL_DIFFUSION_FAMILY_FRIENDS;
    }

    public void setFL_DIFFUSION_FAMILY_FRIENDS(String FL_DIFFUSION_FAMILY_FRIENDS) {
        this.FL_DIFFUSION_FAMILY_FRIENDS = FL_DIFFUSION_FAMILY_FRIENDS;
    }

    public String getFL_DIFFUSION_DIRECTLT_UT() {
        return FL_DIFFUSION_DIRECTLT_UT;
    }

    public void setFL_DIFFUSION_DIRECTLT_UT(String FL_DIFFUSION_DIRECTLT_UT) {
        this.FL_DIFFUSION_DIRECTLT_UT = FL_DIFFUSION_DIRECTLT_UT;
    }

    public String getFL_DIFFUSION_BROCHURE() {
        return FL_DIFFUSION_BROCHURE;
    }

    public void setFL_DIFFUSION_BROCHURE(String FL_DIFFUSION_BROCHURE) {
        this.FL_DIFFUSION_BROCHURE = FL_DIFFUSION_BROCHURE;
    }

    public String getFL_DIFFUSION_NEWSPAPER() {
        return FL_DIFFUSION_NEWSPAPER;
    }

    public void setFL_DIFFUSION_NEWSPAPER(String FL_DIFFUSION_NEWSPAPER) {
        this.FL_DIFFUSION_NEWSPAPER = FL_DIFFUSION_NEWSPAPER;
    }

    public String getFL_DIFFUSION_STUDENTS_UT() {
        return FL_DIFFUSION_STUDENTS_UT;
    }

    public void setFL_DIFFUSION_STUDENTS_UT(String FL_DIFFUSION_STUDENTS_UT) {
        this.FL_DIFFUSION_STUDENTS_UT = FL_DIFFUSION_STUDENTS_UT;
    }

    public String getFL_DIFFUSION_MANTA() {
        return FL_DIFFUSION_MANTA;
    }

    public void setFL_DIFFUSION_MANTA(String FL_DIFFUSION_MANTA) {
        this.FL_DIFFUSION_MANTA = FL_DIFFUSION_MANTA;
    }

    public String getFL_DIFFUSION_TRIPTYCH() {
        return FL_DIFFUSION_TRIPTYCH;
    }

    public void setFL_DIFFUSION_TRIPTYCH(String FL_DIFFUSION_TRIPTYCH) {
        this.FL_DIFFUSION_TRIPTYCH = FL_DIFFUSION_TRIPTYCH;
    }

    public String getFL_DIFFUSION_GUIDED_VISITS() {
        return FL_DIFFUSION_GUIDED_VISITS;
    }

    public void setFL_DIFFUSION_GUIDED_VISITS(String FL_DIFFUSION_GUIDED_VISITS) {
        this.FL_DIFFUSION_GUIDED_VISITS = FL_DIFFUSION_GUIDED_VISITS;
    }

    public String getFL_DIFFUSION_EXHIBITIONS() {
        return FL_DIFFUSION_EXHIBITIONS;
    }

    public void setFL_DIFFUSION_EXHIBITIONS(String FL_DIFFUSION_EXHIBITIONS) {
        this.FL_DIFFUSION_EXHIBITIONS = FL_DIFFUSION_EXHIBITIONS;
    }

    public String getFL_DIFFUSION_OTHER() {
        return FL_DIFFUSION_OTHER;
    }

    public void setFL_DIFFUSION_OTHER(String FL_DIFFUSION_OTHER) {
        this.FL_DIFFUSION_OTHER = FL_DIFFUSION_OTHER;
    }

    public String getFL_DIFFUSION_OTHER_NAME() {
        return FL_DIFFUSION_OTHER_NAME;
    }

    public void setFL_DIFFUSION_OTHER_NAME(String FL_DIFFUSION_OTHER_NAME) {
        this.FL_DIFFUSION_OTHER_NAME = FL_DIFFUSION_OTHER_NAME;
    }

    public String getFL_OPTION_UTSEM_STUDY() {
        return FL_OPTION_UTSEM_STUDY;
    }

    public void setFL_OPTION_UTSEM_STUDY(String FL_OPTION_UTSEM_STUDY) {
        this.FL_OPTION_UTSEM_STUDY = FL_OPTION_UTSEM_STUDY;
    }

    public String getFL_PHYSICAL_DISABILITY() {
        return FL_PHYSICAL_DISABILITY;
    }

    public void setFL_PHYSICAL_DISABILITY(String FL_PHYSICAL_DISABILITY) {
        this.FL_PHYSICAL_DISABILITY = FL_PHYSICAL_DISABILITY;
    }

    public String getFL_DISABILITY_NAME() {
        return FL_DISABILITY_NAME;
    }

    public void setFL_DISABILITY_NAME(String FL_DISABILITY_NAME) {
        this.FL_DISABILITY_NAME = FL_DISABILITY_NAME;
    }

    public String getFL_INDIGENOUS_GROUP() {
        return FL_INDIGENOUS_GROUP;
    }

    public void setFL_INDIGENOUS_GROUP(String FL_INDIGENOUS_GROUP) {
        this.FL_INDIGENOUS_GROUP = FL_INDIGENOUS_GROUP;
    }

    public String getFL_INDIGENOUS_GROUP_NAME() {
        return FL_INDIGENOUS_GROUP_NAME;
    }

    public void setFL_INDIGENOUS_GROUP_NAME(String FL_INDIGENOUS_GROUP_NAME) {
        this.FL_INDIGENOUS_GROUP_NAME = FL_INDIGENOUS_GROUP_NAME;
    }

    public String getFL_SECUTITY_MEDICAL() {
        return FL_SECUTITY_MEDICAL;
    }

    public void setFL_SECUTITY_MEDICAL(String FL_SECUTITY_MEDICAL) {
        this.FL_SECUTITY_MEDICAL = FL_SECUTITY_MEDICAL;
    }

    public String getFL_SECURITY_NAME() {
        return FL_SECURITY_NAME;
    }

    public void setFL_SECURITY_NAME(String FL_SECURITY_NAME) {
        this.FL_SECURITY_NAME = FL_SECURITY_NAME;
    }

    public String getFL_NUMBER_SECURITY_MEDICAL() {
        return FL_NUMBER_SECURITY_MEDICAL;
    }

    public void setFL_NUMBER_SECURITY_MEDICAL(String FL_NUMBER_SECURITY_MEDICAL) {
        this.FL_NUMBER_SECURITY_MEDICAL = FL_NUMBER_SECURITY_MEDICAL;
    }

    public String getFL_WHOM_DEPEND() {
        return FL_WHOM_DEPEND;
    }

    public void setFL_WHOM_DEPEND(String FL_WHOM_DEPEND) {
        this.FL_WHOM_DEPEND = FL_WHOM_DEPEND;
    }

    public String getFL_DEPEND_ECONOMICALLY_WORK() {
        return FL_DEPEND_ECONOMICALLY_WORK;
    }

    public void setFL_DEPEND_ECONOMICALLY_WORK(String FL_DEPEND_ECONOMICALLY_WORK) {
        this.FL_DEPEND_ECONOMICALLY_WORK = FL_DEPEND_ECONOMICALLY_WORK;
    }

    public String getFL_WHERE_WORK() {
        return FL_WHERE_WORK;
    }

    public void setFL_WHERE_WORK(String FL_WHERE_WORK) {
        this.FL_WHERE_WORK = FL_WHERE_WORK;
    }

    public String getFL_WHAT_WORK() {
        return FL_WHAT_WORK;
    }

    public void setFL_WHAT_WORK(String FL_WHAT_WORK) {
        this.FL_WHAT_WORK = FL_WHAT_WORK;
    }

    public String getFL_BIRTH_CERTIFICATE_NUMBER() {
        return FL_BIRTH_CERTIFICATE_NUMBER;
    }

    public void setFL_BIRTH_CERTIFICATE_NUMBER(String FL_BIRTH_CERTIFICATE_NUMBER) {
        this.FL_BIRTH_CERTIFICATE_NUMBER = FL_BIRTH_CERTIFICATE_NUMBER;
    }

    public String getFL_HIGH_SCHOOL_CERTIFICATE() {
        return FL_HIGH_SCHOOL_CERTIFICATE;
    }

    public void setFL_HIGH_SCHOOL_CERTIFICATE(String FL_HIGH_SCHOOL_CERTIFICATE) {
        this.FL_HIGH_SCHOOL_CERTIFICATE = FL_HIGH_SCHOOL_CERTIFICATE;
    }

    public int getFL_DOWN() {
        return FL_DOWN;
    }

    public void setFL_DOWN(int FL_DOWN) {
        this.FL_DOWN = FL_DOWN;
    }

    public int getFL_MODIFY() {
        return FL_MODIFY;
    }

    public void setFL_MODIFY(int FL_MODIFY) {
        this.FL_MODIFY = FL_MODIFY;
    }

    public int getFL_AUTHORIZED_ACCESS_PREREGISTER_ING() {
        return FL_AUTHORIZED_ACCESS_PREREGISTER_ING;
    }

    public void setFL_AUTHORIZED_ACCESS_PREREGISTER_ING(int FL_AUTHORIZED_ACCESS_PREREGISTER_ING) {
        this.FL_AUTHORIZED_ACCESS_PREREGISTER_ING = FL_AUTHORIZED_ACCESS_PREREGISTER_ING;
    }

    public int getFL_METADATA_PREREGISTER_ING() {
        return FL_METADATA_PREREGISTER_ING;
    }

    public void setFL_METADATA_PREREGISTER_ING(int FL_METADATA_PREREGISTER_ING) {
        this.FL_METADATA_PREREGISTER_ING = FL_METADATA_PREREGISTER_ING;
    }

    public int getFL_PREINSCRIPTION_ING() {
        return FL_PREINSCRIPTION_ING;
    }

    public void setFL_PREINSCRIPTION_ING(int FL_PREINSCRIPTION_ING) {
        this.FL_PREINSCRIPTION_ING = FL_PREINSCRIPTION_ING;
    }

    public int getFL_INSCRIPTION_ING() {
        return FL_INSCRIPTION_ING;
    }

    public void setFL_INSCRIPTION_ING(int FL_INSCRIPTION_ING) {
        this.FL_INSCRIPTION_ING = FL_INSCRIPTION_ING;
    }

    public semesterModel getSemesterMl() {
        return semesterMl;
    }

    public void setSemesterMl(semesterModel semesterMl) {
        this.semesterMl = semesterMl;
    }
    
}
