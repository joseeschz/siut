/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package control;

import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import model.studentModel;

/**
 *
 * @author CARLOS
 */
public class mailControl {
    public static void main(String[] args) {
        studentModel data = new studentModel();
        data.setFL_PASSWORD("Hola");
        data.setFL_MAIL("karlos.antoni-1994@hotmail.com");
        mailControl obj = new mailControl();
        System.out.print(obj.MailSender(data));
    }
    public  String MailSender(studentModel dataStudent) {
        String message="";
        AuthControl auth =new AuthControl("sistema.integral.utsem@gmail.com", "siut_admin");
        //Inicializamos las propiedades del envio del mail
        Properties prop=new Properties();
        prop.put("mail.transport.protocol", "smtp");
        prop.put("mail.smtp.host", "smtp.gmail.com");
        prop.put("mail.smtp.port", "465"); 
        prop.put("mail.smtp.user", auth.userName);
        prop.put("mail.smtp.password", auth.password);
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.ssl.enable", "true");
        prop.put("mail.smtp.starttls.enable", "true"); 
        //Inicializamos la clase de autentificacion
        //Creamos sesion
        Session session = Session.getInstance(prop, auth);
        
        Message msg=new MimeMessage(session);
        try {
            System.out.println("Enviando correo...");
            InternetAddress[] emails = new InternetAddress[1];
            emails[0] = new InternetAddress(dataStudent.getFL_MAIL());
            msg.setRecipients(Message.RecipientType.TO, emails);
            InternetAddress from=new InternetAddress(auth.userName);
            msg.setFrom(from);
            msg.setSubject("Recordatorio de contraseña");
            MimeBodyPart cuerpo=new MimeBodyPart();
            cuerpo.setContent("Su contraseña es: "+dataStudent.getFL_PASSWORD()+"", "text/html");
            //Mandar archivo
            //MimeBodyPart anexo=new MimeBodyPart();
            //File archivo=new File("Rutaa");
            //FileDataSource fds=new FileDataSource(archivo);
            //anexo.setFileName(archivo.getName());
            //mp.addBodyPart(anexo);
            Multipart mp=new MimeMultipart();
            mp.addBodyPart(cuerpo);
            msg.setContent(mp);
            //Instrucciones para enviar email
            Transport t = session.getTransport();
            t.connect("smtp.gmail.com",auth.userName, auth.password);
            msg.saveChanges();
            t.sendMessage(msg, msg.getAllRecipients());
            t.close();
            message="Success";
        } catch (AddressException e) {
            //e.printStackTrace();
            message = "InvalidMail";
        } catch( MessagingException e){
            //e.printStackTrace();
            message = "FailConnectionNetwork";
        }
        return message;
    }
    
}
