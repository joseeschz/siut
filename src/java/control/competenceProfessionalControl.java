/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package control;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.competenceProfessionalModel;
import model.studyPlanModel;

/**
 *
 * @author Lab5-E
 */
public class competenceProfessionalControl {
    public static void main(String[] args) {
        ArrayList<competenceProfessionalModel> list = new competenceProfessionalControl().SelectCompetenceProfessionals(6, 1);
        int i=0;
        for (competenceProfessionalModel detailModel : list) {
            System.out.print(detailModel.getFL_CONCEPT());
        }
    }
    private String procedure;
    
    public ArrayList<competenceProfessionalModel> SelectCompetenceProfessionals(int pt_fk_study_plann, int pt_type){
        ArrayList<competenceProfessionalModel> list=new ArrayList<>();
        procedure = "CALL `GET_COMPETEMCE_PROFESSIONAL`(?, ?, ?)";
        try (Connection conn = new connectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure)) { 
            ps.setString(1, "select");         
            ps.setInt(2, pt_fk_study_plann);     
            ps.setInt(3, pt_type);     
            try (ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){   
                    competenceProfessionalModel competenceProfessionalMdl =new competenceProfessionalModel();
                    studyPlanModel studyPlanMdl = new studyPlanModel();
                    competenceProfessionalMdl.setFL_CONCEPT(res.getString("FL_CONCEPT"));
                    competenceProfessionalMdl.setPK_COMPETENCE_PROFESSIONAL(res.getInt("PK_COMPETENCE_PROFESSIONAL"));
                    studyPlanMdl.setPK_STUDY_PLAN(res.getInt("FK_STUDY_PLANN"));
                    competenceProfessionalMdl.setStudyPlanMdl(studyPlanMdl);
                    list.add(competenceProfessionalMdl);
                }
            }
        } catch (SQLException ex) {
            System.err.println(ex);
        }
        return list;
    }
    
    public String InsertCompetenceProfessional(String pt_concept, int pt_fk_type, int pt_pk_study_palnn){
        String request;
        procedure = "CALL `SET_COMPETENCE_PROFESSIONAL`(?, null, ?, ?, ?)";
        PreparedStatement ps;
        Connection conn=new connectionControl().getConexion();
        try {
            ps = conn.prepareStatement(procedure);
            ps.setString(1, "insert");
            ps.setString(2, pt_concept);
            ps.setInt(3, pt_fk_type);
            ps.setInt(4, pt_pk_study_palnn);
            ps.executeUpdate();
            request="Inserted";
            ps.close();
            conn.close();
            
        } catch (SQLException e) {
            request=""+e;
        }   
        return request;
    }
    public String UpdateCompetenceProfessional(String pt_concept, int pt_pk_competence_professional){
        String request;
        procedure = "CALL `SET_COMPETENCE_PROFESSIONAL`(?, ?, ?, null, null)";
        try {
            Connection conn=new connectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement(procedure)) {
                ps.setString(1, "update");
                ps.setInt(2, pt_pk_competence_professional);
                ps.setString(3, pt_concept);
                ps.executeUpdate();
                request="Updated";
                ps.close();
                conn.close();
            }
        } catch (SQLException e) {
            request=""+e.getMessage();
            e.getMessage();
        }   
        return request;
    }
    public String DeleteCompetenceProfessional(int pt_pk_competence_professional){
        String request;
        procedure = "CALL `SET_COMPETENCE_PROFESSIONAL`(?, ?, null, null, null)";
        try {
            Connection conn=new connectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement(procedure)) {
                ps.setString(1, "delete");
                ps.setInt(2, pt_pk_competence_professional);
                ps.executeUpdate();
                request="Deleted";
                ps.close();
                conn.close();
            }
        } catch (SQLException e) {
            request=""+e.getMessage();
            e.getMessage();
        }   
        return request;
    }
}
