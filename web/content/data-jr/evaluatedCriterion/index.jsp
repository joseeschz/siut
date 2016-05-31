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
        int fk_teacher = 0;
        int pt_matter = Integer.parseInt(request.getParameter("pt_matter"));
        int pt_study_level = Integer.parseInt(request.getParameter("pt_study_level"));
        int pt_career = Integer.parseInt(request.getParameter("pt_career"));
        int pt_period = Integer.parseInt(request.getParameter("pt_period"));
        if(session.getAttribute("pkUser")!=null){
            fk_teacher = Integer.parseInt(session.getAttribute("pkUser").toString());
        }
        if(request.getParameter("fk_teacher")!=null){
            fk_teacher = Integer.parseInt(request.getParameter("fk_teacher"));
        }
        session.setAttribute("pt_career", pt_career);
        session.setAttribute("pt_study_level", pt_study_level);
        session.setAttribute("pt_matter", pt_matter);
        session.setAttribute("pt_teacher", fk_teacher);
        session.setAttribute("pt_period", pt_period);
    }else{
        //Parametros para realizar la conexión// 
        conectionControl connection=new conectionControl();
        //Establecemos la ruta del reporte//
        File reportFile = new File(application.getRealPath("content/data-jr/evaluatedCriterion/master.jasper")); 
        //No enviamos parámetros porque nuestro reporte no los necesita asi que escriba 
        //cualquier cadena de texto ya que solo seguiremos el formato del método runReportToPdf// 
        Map parameters = new HashMap(); 
        parameters.put("pt_career", session.getAttribute("pt_career")); 
        parameters.put("pt_study_level", session.getAttribute("pt_study_level")); 
        parameters.put("pt_matter", session.getAttribute("pt_matter")); 
        parameters.put("pt_teacher", session.getAttribute("pt_teacher")); 
        parameters.put("pt_period", session.getAttribute("pt_period")); 
        //Enviamos la ruta del reporte, los parámetros y la conexión(objeto Connection)//
        
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