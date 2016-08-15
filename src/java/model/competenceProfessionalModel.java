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
public class competenceProfessionalModel {
    int PK_COMPETENCE_PROFESSIONAL=0;
    String FL_CONCEPT="";
    studyPlanModel studyPlanMdl;
    int FK_TYPE=0;

    public int getPK_COMPETENCE_PROFESSIONAL() {
        return PK_COMPETENCE_PROFESSIONAL;
    }

    public void setPK_COMPETENCE_PROFESSIONAL(int PK_COMPETENCE_PROFESSIONAL) {
        this.PK_COMPETENCE_PROFESSIONAL = PK_COMPETENCE_PROFESSIONAL;
    }

    public String getFL_CONCEPT() {
        return FL_CONCEPT;
    }

    public void setFL_CONCEPT(String FL_CONCEPT) {
        this.FL_CONCEPT = FL_CONCEPT;
    }

    public studyPlanModel getStudyPlanMdl() {
        return studyPlanMdl;
    }

    public void setStudyPlanMdl(studyPlanModel studyPlanMdl) {
        this.studyPlanMdl = studyPlanMdl;
    }

    public int getFK_TYPE() {
        return FK_TYPE;
    }

    public void setFK_TYPE(int FK_TYPE) {
        this.FK_TYPE = FK_TYPE;
    }
    
}
