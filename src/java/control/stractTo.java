/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package control;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Lab5-E
 */
public class stractTo {
    public static void main(String[] args) throws SQLException, IOException {
        stractTo obj = new stractTo();
        obj.bajar_archivo();
    }
    public void bajar_archivo() throws SQLException, IOException {
        try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement("CALL `GET_FILES`()"); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    try {
                        File directory = new File("c:/temp/"+res.getString("FL_ENROLLMENT")+"");
                        if(!directory.exists()){
                            directory.mkdirs();
                            String pathname =directory+"/FILE_CURP_TUTOR.pdf";
                            System.out.println(pathname);
                            File file = new File(pathname);
                            FileOutputStream output = new FileOutputStream(file);
                            Blob archivo = res.getBlob("FL_FILE_CURP_TUTOR");
                            InputStream inStream = archivo.getBinaryStream();
                            int length = -1;
                            int size = (int) archivo.length();
                            byte[] buffer = new byte[size];
                            while ((length = inStream.read(buffer)) != -1) {
                                output.write(buffer, 0, length);
                                output.flush();
                            }
                            inStream.close();
                            output.close();
                        }else{
                            String pathname =directory+"/FILE_CURP_TUTOR.pdf";
                            System.out.println(pathname);
                            File file = new File(pathname);
                            FileOutputStream output = new FileOutputStream(file);
                            Blob archivo = res.getBlob("FL_FILE_CURP_TUTOR");
                            InputStream inStream = archivo.getBinaryStream();
                            int length = -1;
                            int size = (int) archivo.length();
                            byte[] buffer = new byte[size];
                            while ((length = inStream.read(buffer)) != -1) {
                                output.write(buffer, 0, length);
                                output.flush();
                            }
                            inStream.close();
                            output.close();
                        }                       
                    } catch (Exception ioe) {
                        throw new IOException(ioe.getMessage());
                    }  
                }
                res.close();
                ps.close();
                conn.close();
            }
        
    }
}
