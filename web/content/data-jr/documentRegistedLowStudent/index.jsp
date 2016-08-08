<%-- 
    Document   : Reporte
    Created on : 26/12/2012, 09:05:24 AM
    Author     : Unknown
--%>

<%@page import="control.connectionControl"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="net.sf.jasperreports.engine.*" %> 
<%@ page import="java.util.*" %> 
<%@ page import="java.io.*" %> 
<%@ page import="java.sql.*" %> 
<% 
 if(session.getAttribute("logueado") != null){
    if(request.getParameter("sessionLowReport")!=null){
        String pt_pk_student = request.getParameter("pt_pk_student");
        session.setAttribute("pt_pk_student", pt_pk_student);
        String pt_pk_period = request.getParameter("pt_pk_period");
        session.setAttribute("pt_pk_period", pt_pk_period);
    }else{
        //Parametros para realizar la conexión// 
        connectionControl connection=new connectionControl();
        //Establecemos la ruta del reporte//
        File reportFile = new File(application.getRealPath("content/data-jr/documentRegistedLowStudent/report.jasper")); 
        //No enviamos parámetros porque nuestro reporte no los necesita asi que escriba 
        //cualquier cadena de texto ya que solo seguiremos el formato del método runReportToPdf// 
        Map parameters = new HashMap(); 
        parameters.put("pt_pk_student", session.getAttribute("pt_pk_student")); 
        parameters.put("pt_pk_period", session.getAttribute("pt_pk_period")); 
        //Enviamos la ruta del reporte, los parámetros y la conexión(objeto Connection)//
//        
        byte[] bytes = JasperRunManager.runReportToPdf(reportFile.getPath(), parameters, connection.getConexion()); 
        //Indicamos que la respuesta va a ser en formato PDF//
        response.setContentType("application/pdf");
        response.setContentLength(bytes.length); 
        ServletOutputStream ouputStream = response.getOutputStream(); 
        ouputStream.write(bytes, 0, bytes.length); 
        //Limpiamos y cerramos flujos de salida// 
        ouputStream.flush(); 
        ouputStream.close(); 
    }
}else{
    response.sendRedirect("../../../admin");
}%>  