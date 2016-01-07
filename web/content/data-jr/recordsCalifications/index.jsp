<%-- 
    Document   : Reporte
    Created on : 26/12/2012, 09:05:24 AM
    Author     : Unknown
--%>

<%@page import="control.conectionControl"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="net.sf.jasperreports.engine.*" %> 
<%@ page import="java.util.*" %> 
<%@ page import="java.io.*" %> 
<%@ page import="java.sql.*" %> 
<% 
 if(session.getAttribute("logueado") != null){
    if(request.getParameter("session")!=null){
        int pt_group = Integer.parseInt(request.getParameter("pt_group"));
        int pt_matter = Integer.parseInt(request.getParameter("pt_matter"));
        int pt_period = Integer.parseInt(request.getParameter("pt_period"));
        String pt_type_report = request.getParameter("pt_type_report");
        session.setAttribute("pt_group", pt_group);
        session.setAttribute("pt_matter", pt_matter);
        session.setAttribute("pt_period", pt_period);
        session.setAttribute("pt_type_report", pt_type_report);
    }else{
        //Parametros para realizar la conexión// 
        conectionControl connection=new conectionControl();
        //Establecemos la ruta del reporte//
        File reportFile = new File(application.getRealPath("content/data-jr/recordsCalifications/acta_calificaciones.jasper")); 
        //No enviamos parámetros porque nuestro reporte no los necesita asi que escriba 
        //cualquier cadena de texto ya que solo seguiremos el formato del método runReportToPdf// 
        Map parameters = new HashMap(); 
        parameters.put("pt_group", session.getAttribute("pt_group")); 
        parameters.put("pt_matter", session.getAttribute("pt_matter")); 
        parameters.put("pt_period", session.getAttribute("pt_period"));
        parameters.put("pt_type_report", session.getAttribute("pt_type_report"));
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
}
else{
    response.sendRedirect("../../../admin");
}%>  