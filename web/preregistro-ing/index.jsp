<%
    String vertion = "jqwidgets-ver4.0.0";
    if(session.getAttribute("logueadoStudent") == null){
        response.sendRedirect("/preregistro-ing/login.jsp");
    }else{
        response.sendRedirect("/preregistro-ing/module.jsp");
    }
%>  