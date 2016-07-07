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
    if(request.getParameter("sessionAchievementQuartely")!=null){
        int pt_period = Integer.parseInt(request.getParameter("pt_period"));
        int pt_relationship = Integer.parseInt("0");
        session.setAttribute("pt_period", pt_period);
        session.setAttribute("pt_relationship", pt_relationship);
    }else{
        //Parametros para realizar la conexión// 
        connectionControl connection=new connectionControl();
        //Establecemos la ruta del reporte//
        File reportFile = new File(application.getRealPath("content/data-jr/quartelyAcademicAchievement/report.jasper")); 
        //No enviamos parámetros porque nuestro reporte no los necesita asi que escriba 
        //cualquier cadena de texto ya que solo seguiremos el formato del método runReportToPdf// 
        Map parameters = new HashMap(); 
        parameters.put("pt_relationship", session.getAttribute("pt_relationship")); 
        parameters.put("pt_fk_worker", session.getAttribute("pkUser")); 
        parameters.put("pt_period", session.getAttribute("pt_period")); 
        
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