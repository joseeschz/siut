/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servletServices;

import control.AuthControl;
import control.candidateControl;
import java.io.IOException;
import java.io.PrintWriter;
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
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Lab5-E
 */
@WebServlet(name = "serviceMail", urlPatterns = {"/serviceMail"})
public class serviceMail extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession sessionWeb = request.getSession();
        try (PrintWriter out = response.getWriter()) {
            if(request.getParameter("rememberPassword")!=null){
                
            }
            
            
            if(request.getParameter("email")!=null && request.getParameter("userName")!=null && request.getParameter("password")!=null){
                if(request.getParameter("welcome")!=null){
                    String email = request.getParameter("email");
                    String name = request.getParameter("userName");
                    String password = request.getParameter("password");
                    String message;
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
                    String contentMail="";
                    Message msg=new MimeMessage(session);
                    try {
                        InternetAddress[] emails = new InternetAddress[1];
                        emails[0] = new InternetAddress(email);
                        msg.setRecipients(Message.RecipientType.TO, emails);
                        InternetAddress from=new InternetAddress(auth.userName);
                        msg.setFrom(from);
                        msg.setSubject("Universidad Tecnológica del Sur del Estado de México teda la bienvenida");
                        MimeBodyPart cuerpo=new MimeBodyPart();
                        contentMail=contentMail+"<span style='font-style: italic; font-size: 40px;'><span style='color:green'>UT</span><span>sem</span></span><br>";
                        contentMail=contentMail+"<b>Nombre de la Dependencia: </b><span style='font-style: italic;'>Universidad Tecnológica del Sur del Estado de México</span><br>";
                        contentMail=contentMail+"<b>Hola: "+name+"</b><br>";
                        contentMail=contentMail+"<b><span style='font-style: italic;'>La Universidad Tecnológica del Sur del Estado de México te da la bienvenida al proceso de preinscripción y desea que tu formes parte de sus alumnos por que recuerda su compromiso es la excelencia educativa.</span></b><br><br>";
                        
                        contentMail=contentMail+"<b>Usuario</b>: <b>"+name+"<br>";
                        contentMail=contentMail+"<b>Contraseña</b>: <b>"+password+"<br><br>";
                        contentMail=contentMail+"<b>Para iniciar sesión en el <a href='http://148.223.215.19/preregistro'>Sistema de preregristro click aquí.</a></b><br><br>";
                        contentMail=contentMail+"<span><b>El mensaje se envió a </b><span>"+email+"</span></span><br><br><br>";
                        contentMail=contentMail+"<b>Nota: </b><b><span style='font-style: italic; color:red;'>En caso de no ser el responsable de este correo favor de eliminarlo y pasar por alto el contenido...!</span><br><br><br><br>";
                        contentMail=contentMail+"<b>Carretera Tejupilco - Amatepec Km. 12.5 Ex - Hacienda de San Miguel, Ixtapan, Tejupilco, Méx. Teléfonos: (724) 2694020, ext 220, 225 </b>";
                        cuerpo.setContent(contentMail, "text/html");
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
                    out.print(message);
                }else{
                    String mail = request.getParameter("mail");
                    String name = request.getParameter("name");
                    String message;
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
                    String contentMail="";
                    Message msg=new MimeMessage(session);
                    try {
                        InternetAddress[] emails = new InternetAddress[1];
                        emails[0] = new InternetAddress(mail);
                        msg.setRecipients(Message.RecipientType.TO, emails);
                        InternetAddress from=new InternetAddress(auth.userName);
                        msg.setFrom(from);
                        msg.setSubject("Universidad Tecnológica del Sur del Estado de México");
                        MimeBodyPart cuerpo=new MimeBodyPart();
                        contentMail=contentMail+"<span style='font-style: italic; font-size: 40px;'><span style='color:green'>UT</span><span>sem</span></span><br>";
                        contentMail=contentMail+"<b>Nombre de la Dependencia: </b><span style='font-style: italic;'>Universidad Tecnológica del Sur del Estado de México</span><br>";
                        contentMail=contentMail+"<b>Área:</b><span style='font-style: italic;'> Departamento de Servicios Escolares</span><br><br>";
                        contentMail=contentMail+"<b>Hola: "+name+"</b><br>";
                        contentMail=contentMail+"<b>Folio UTsem</b>: <b>"+sessionWeb.getAttribute("folio")+"<br><br><br><br>";
                        contentMail=contentMail+"<span><b>El mensaje se envió a </b><span>"+mail+"</span></span><br><br><br><br><br>";
                        contentMail=contentMail+"<b>Carretera Tejupilco - Amatepec Km. 12.5 Ex - Hacienda de San Miguel, Ixtapan, Tejupilco, Méx. Teléfonos: (724) 2694020, ext 220, 225 </b>";
                        cuerpo.setContent(contentMail, "text/html");
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
                    out.print(message);
                }
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
