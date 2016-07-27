<%
    String vertion = "jqwidgets-ver4.0.0";
    if(session.getAttribute("logueadoStudent") == null){
        response.sendRedirect("/metadato/login.jsp");
    }else{
        response.sendRedirect("/metadato/module.jsp");
    }
%>  