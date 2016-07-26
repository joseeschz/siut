<%
String vertion = "jqwidgets-ver4.0.0";
if(session.getAttribute("logueado") == null){
    response.sendRedirect("/admin/login.jsp");
}else{  
    response.sendRedirect("/admin/system.jsp");
}%>