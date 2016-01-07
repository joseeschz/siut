/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package control;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

/**
 *
 * @author CARLOS
 */
public class AuthControl extends Authenticator{
    public String userName=null;
    public String password=null;
    public AuthControl(String userName, String password){
        this.userName=userName;
        this.password = password;
    }

    /**
     *
     * @return
     */
    @Override
    protected PasswordAuthentication getPasswordAuthentication(){
        return new PasswordAuthentication(userName, password);
    }
}
