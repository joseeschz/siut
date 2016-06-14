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
public class categoryPaymentsModel {
    int PK_CATEGORY_PAYMENT=0;
    String FL_NAME_CATEGORY="";

    public int getPK_CATEGORY_PAYMENT() {
        return PK_CATEGORY_PAYMENT;
    }

    public void setPK_CATEGORY_PAYMENT(int PK_CATEGORY_PAYMENT) {
        this.PK_CATEGORY_PAYMENT = PK_CATEGORY_PAYMENT;
    }

    public String getFL_NAME_CATEGORY() {
        return FL_NAME_CATEGORY;
    }

    public void setFL_NAME_CATEGORY(String FL_NAME_CATEGORY) {
        this.FL_NAME_CATEGORY = FL_NAME_CATEGORY;
    }
    
}
