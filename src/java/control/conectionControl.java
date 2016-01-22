/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package control;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Carlos
 */
public class conectionControl {
    public Connection getConexion(){
        try {
            Class.forName("com.mysql.jdbc.Driver");
<<<<<<< HEAD
            return java.sql.DriverManager.getConnection("jdbc:mysql://10.10.40.5:3306/db_siut_pro?zeroDateTimeBehavior=convertToNull", "siut_pro", "utsem_systems");
=======
            return java.sql.DriverManager.getConnection("jdbc:mysql://10.10.40.5:3306/db_siut_dev?zeroDateTimeBehavior=convertToNull", "siut_dev", "utsem_systems");
>>>>>>> develop
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(conectionControl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
