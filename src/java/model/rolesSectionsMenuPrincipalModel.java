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
public class rolesSectionsMenuPrincipalModel extends sectionModel{
    int PK_ROLES_SECTION_MENU_PRINCIPAL=0;
    int FK_ROL=0;

    public int getPK_ROLES_SECTION_MENU_PRINCIPAL() {
        return PK_ROLES_SECTION_MENU_PRINCIPAL;
    }

    public void setPK_ROLES_SECTION_MENU_PRINCIPAL(int PK_ROLES_SECTION_MENU_PRINCIPAL) {
        this.PK_ROLES_SECTION_MENU_PRINCIPAL = PK_ROLES_SECTION_MENU_PRINCIPAL;
    }

    public int getFK_ROL() {
        return FK_ROL;
    }

    public void setFK_ROL(int FK_ROL) {
        this.FK_ROL = FK_ROL;
    }
}
