<%@page import="control.candidateControl"%>
<%@page import="control.aes"%>
<%
    String vertion = "jqwidgets-ver4.0.0";
    if(session.getAttribute("logueadoCandidate") == null){
        if(request.getParameter("ac") != null){
            aes sec = new aes();
            sec.addKey("2015");
            String ligaDescript = sec.desencriptar(request.getParameter("ac").replace(" ", "+"));
            String userName = null;
            String mail = null;
            String password = null;
            if(!ligaDescript.equals("")){
                String[] numerosComoArray = ligaDescript.split("&");
                for (int i = 0; i < numerosComoArray.length; i++) {
                    String data = numerosComoArray[i].toString();
                    String[] numberAsArray = data.split("=");
                    for(int x = 0; x < numberAsArray.length; x++){
                        if(numberAsArray[x].equals("userName")){
                            userName = numberAsArray[x+1];
                        }
                        if(numberAsArray[x].equals("mail")){
                            mail = numberAsArray[x+1];
                        }
                        if(numberAsArray[x].equals("password")){
                            password = numberAsArray[x+1];
                        }
                    }
                }
                if(new candidateControl().SelectUserStatusAcount(userName, password)==0){
                    if(new candidateControl().ActivateAcount(userName, mail, password).equals("Actived")){
                        %>
                            <html xmlns="http://www.w3.org/1999/xhtml">
                                <head>
                                <title>Activación de cuenta</title>
                                    <meta name="viewport" content="width=device-width"/>
                                    <meta charset="UTF-8"/>
                                    <meta name="viewport" content="width=device-width, initial-scale=1">
                                    <link title="SIUT" rel="icon" type="image/png" href="../../content/pictures-system/favicon.png" />
                                    <link type="text/css" rel="Stylesheet" href="../content/files-jq/<%out.print(vertion);%>/jqwidgets/styles/jqx.base.css" />
                                    <link type="text/css" rel="Stylesheet" href="../content/files-jq/<%out.print(vertion);%>/jqwidgets/styles/jqx.greenUtsem.css" />
                                    <script type="text/javascript" src="../content/files-jq/jquery-2.0.2.min.js"></script>
                                    <script type="text/javascript" src="../content/files-jq/<%out.print(vertion);%>/jqwidgets/jqxcore.js"></script>
                                    <script type="text/javascript" src="../content/files-jq/<%out.print(vertion);%>/jqwidgets/jqxwindow.js"></script> 
                                    <script type="text/javascript">
                                        $(document).ready(function (){
                                            $("#mainDemoContainer").height($(document).height()-130);
                                            $("#jqxwindow").jqxWindow({
                                                height: 130,
                                                width: 350,
                                                theme: 'greenUtsem',
                                                autoOpen: true,
                                                isModal: true,
                                                showCloseButton: false,
                                                resizable: false,
                                                position: "center"
                                            });

                                        });
                                    </script>
                                </head>
                                <body class='default'>
                                    <div style="width: 100%;" id="mainDemoContainer">
                                        <div id='jqxwindow'>
                                            <div>Activación de la cuenta</div>
                                            <div style="padding: 20px">
                                                La cuenta fue activada con éxito, ahora puedes iniciar sesión para ello da click a <a href="http://148.223.215.19/preregistro/">aquí</a>.
                                            </div>
                                        </div>
                                    </div>
                                </body>
                            </html>
                        <%
                    }else{
                        %>
                            <html xmlns="http://www.w3.org/1999/xhtml">
                                <head>
                                <title>Activación de cuenta</title>
                                    <meta name="viewport" content="width=device-width"/>
                                    <meta charset="UTF-8"/>
                                    <meta name="viewport" content="width=device-width, initial-scale=1">
                                    <link title="SIUT" rel="icon" type="image/png" href="../../content/pictures-system/favicon.png" />
                                    <link type="text/css" rel="Stylesheet" href="../content/files-jq/<%out.print(vertion);%>/jqwidgets/styles/jqx.base.css" />
                                    <link type="text/css" rel="Stylesheet" href="../content/files-jq/<%out.print(vertion);%>/jqwidgets/styles/jqx.greenUtsem.css" />
                                    <script type="text/javascript" src="../content/files-jq/jquery-2.0.2.min.js"></script>
                                    <script type="text/javascript" src="../content/files-jq/<%out.print(vertion);%>/jqwidgets/jqxcore.js"></script>
                                    <script type="text/javascript" src="../content/files-jq/<%out.print(vertion);%>/jqwidgets/jqxwindow.js"></script> 
                                    <script type="text/javascript">
                                        $(document).ready(function (){
                                            $("#mainDemoContainer").height($(document).height()-130);
                                            $("#jqxwindow").jqxWindow({
                                                height: 130,
                                                width: 350,
                                                theme: 'greenUtsem',
                                                autoOpen: true,
                                                isModal: true,
                                                showCloseButton: true,
                                                resizable: false,
                                                position: "center"
                                            });

                                        });
                                    </script>
                                </head>
                                <body class='default'>
                                    <div style="width: 100%;" id="mainDemoContainer">
                                        <div id='jqxwindow'>
                                            <div>Activación de la cuenta</div>
                                            <div style="padding: 20px">
                                                Ocurrio un problema intente de nuevo mas tarde... :/
                                            </div>
                                        </div>
                                    </div>
                                </body>
                            </html>
                        <%
                    }
                }else{
                    %>
                        <html xmlns="http://www.w3.org/1999/xhtml">
                            <head>
                            <title>Activación de cuenta</title>
                                <meta name="viewport" content="width=device-width"/>
                                <meta charset="UTF-8"/>
                                <meta name="viewport" content="width=device-width, initial-scale=1">
                                <link title="SIUT" rel="icon" type="image/png" href="../../content/pictures-system/favicon.png" />
                                <link type="text/css" rel="Stylesheet" href="../content/files-jq/<%out.print(vertion);%>/jqwidgets/styles/jqx.base.css" />
                                <link type="text/css" rel="Stylesheet" href="../content/files-jq/<%out.print(vertion);%>/jqwidgets/styles/jqx.greenUtsem.css" />
                                <script type="text/javascript" src="../content/files-jq/jquery-2.0.2.min.js"></script>
                                <script type="text/javascript" src="../content/files-jq/<%out.print(vertion);%>/jqwidgets/jqxcore.js"></script>
                                <script type="text/javascript" src="../content/files-jq/<%out.print(vertion);%>/jqwidgets/jqxwindow.js"></script> 
                                <script type="text/javascript">
                                    $(document).ready(function (){
                                        $("#mainDemoContainer").height($(document).height()-130);
                                        $("#jqxwindow").jqxWindow({
                                            height: 130,
                                            width: 350,
                                            theme: 'greenUtsem',
                                            autoOpen: true,
                                            isModal: true,
                                            showCloseButton: false,
                                            resizable: false,
                                            position: "center"
                                        });

                                    });
                                </script>
                            </head>
                            <body class='default'>
                                <div style="width: 100%;" id="mainDemoContainer">
                                    <div id='jqxwindow'>
                                        <div>Cuenta activada</div>
                                        <div style="padding: 20px">
                                            Esta cuenta ya fue activada anterior mente por a hora inicia sesión desde <a href="http://148.223.215.19/preregistro/">aquí...</a>.
                                        </div>
                                    </div>
                                </div>
                            </body>
                        </html>
                    <%
                }                
            }else{
                response.sendRedirect("/preregistro/index.jsp");
            }
        }else{
            response.sendRedirect("/preregistro/login.jsp");
        }
    }else{
        response.sendRedirect("/preregistro/module.jsp");
    }
%>