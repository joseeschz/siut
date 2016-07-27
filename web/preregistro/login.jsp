<%
    String vertion = "jqwidgets-ver4.0.0";
    if(session.getAttribute("logueadoCandidate") == null){%>
        <!DOCTYPE html>
        <html xmlns="http://www.w3.org/1999/xhtml" manifest="file.manifest">
            <head>
            <title>Login SIUT</title>
                <meta name="viewport" content="width=device-width"/>
                <meta charset="UTF-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1">
                <link title="SIUT" rel="icon" type="image/png" href="../../content/pictures-system/favicon.png" />
                <link type="text/css" rel="Stylesheet" href="../content/files-jq/<%out.print(vertion);%>/jqwidgets/styles/jqx.base.css" />
                <link type="text/css" rel="Stylesheet" href="../content/files-jq/<%out.print(vertion);%>/jqwidgets/styles/jqx.greenUtsem.css" />
                <link rel="stylesheet" href="../content/files-css/main-login.css" type="text/css"/>     
                <script type="text/javascript" src="../content/files-jq/jquery-2.0.2.min.js"></script>
                <script>
                     $.ajax({
                        type: "GET",
                        url: "../serviceCandidate?statusAcount&&statusLogin=logged",
                        dataType: 'json',
                        async: false,
                        beforeSend: function (xhr) {
                            console.log("Checking session of out cache...");
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) {
                            if(data.status){
                                window.location = "/preregistro/module.jsp";
                            }
                        }
                    });
                </script>
                <script>
                    // Check if a new cache is available on page load.
                    window.addEventListener('load', function(e) {
                        window.applicationCache.addEventListener('updateready', function(e) {

                            if (window.applicationCache.status == window.applicationCache.UPDATEREADY) {
                                // Browser downloaded a new app cache.
                                // Swap it in and reload the page to get the new hotness.
                                window.applicationCache.swapCache();
                                window.location.reload();
                            } else {
                                // Manifest didn't changed. Nothing new to server.
                            }
                        }, false);

                    }, false);
                </script>
            </head>
            <body>
                <div style="width: 100%;" id="mainDemoContainer">
                    <div id='jqxwindow'>
                        <div>Mensaje</div>
                        <div style="padding: 20px">
                            <span id="message"></span>
                            <br>
                            <div style="text-align: center">
                                <input type="button" id="ok" value="Aceptar" style="margin-right: 10px" />
                            </div>
                        </div>
                    </div>
                </div>
                <center class="login">  
                    <div id="stage" style="display: block">
                        <div style="display: none" id="windowBlock">
                            <div id="WindowLoad"></div>
                            <div id="loadingPicture"></div>
                        </div>
                        <span id="loginText" style="font-size: 35px; line-height: normal;">LOGIN PRE-REGISTRO</span><br>
                        <span id="MessageError" style="display: none; position:absolute; color: red; font-size: 18px; right: 20px; top: 100px">Error datos incorrectos</span>
                        <div id="intro" style="display: block;">
                            <section style="margin-top: 32px;">
                                <form id="formLogin" method="post" >
                                    <input type="hidden" name="statusLogin" value="in"/>
                                    <div id="tmm-form-wizard" class="form-login substrate">
                                        <div style="position: relative; height: 60px;">
                                            <div class="label-row">
                                                <label for="userName">Usuario</label>
                                            </div>
                                            <div class="input-row" style="padding-right: 125px;">
                                                <input title="Ingresa tu usuario para poder ingresar" style="width: 164px" name="userName" type="text" id="userName" autofocus="" placeholder="usuario, email">
                                            </div>
                                        </div>
                                        <br>
                                        <div style="position: relative; height: 60px;">
                                            <div class="label-row">
                                                <label for="password">Contraseña</label>
                                            </div>
                                            <div class="input-row" style="padding-right: 110px;">
                                                <input title="Ingresa tu contraseña para poder ingresar" name="password" type="password" class="password" id="password" placeholder="Contraseña">
                                            </div>
                                        </div>
                                        <br>
                                        <div class="description" id="nonFolio" style="cursor: pointer; text-decoration: underline">No tengo un folio utsem!</div>
                                        <div class="button-row">
                                            <input type="submit" id="buttonGetStarted" class="button" value="Ingresar" />
                                        </div>
                                    </div><br>
                                </form><!--/ form-->                                    
                            </section><!--/ seccion-->
                            <a title="Información requerida" style="color: rgb(66, 79, 89); text-decoration: none; position: absolute; right: 20px; bottom: 2px;" href="../content/files-pdf/metadata-preregister.pdf" download="Documento piloto de metadato"><img src="../content/pictures-system/pdf.png"></a>
                        </div>
                    </div>                        
                </center>
                <center class="register" style="display: none">
                    <div id="stage">
                        <div style="display: none" id="windowBlockRegister">
                            <div id="WindowLoad"></div>
                            <div id="loadingPicture"></div>
                        </div>
                        <span id="loginText" style="font-size: 35px; line-height: normal;">NUEVA CUENTA</span><br>
                        <span id="MessageErrorRegister" style="display: none; position:absolute; color: red; font-size: 18px; right: 20px; top: 62px">Error datos incorrectos</span>
                        <div id="intro" style="display: block;">
                            <section style="margin-top: 16px;">
                                <form id="formRegister" method="post" >
                                    <div id="tmm-form-wizard" class="form-login substrate">
                                        <div style="position: relative; height: 70px; padding-right: 85px;">
                                            <div class="label-row">
                                                <label for="userNameRegister">Nombre de usuario</label>
                                            </div>
                                            <div class="input-row">
                                                <input title="Ingresa tu nombre de usuario para poder ingresar" name="userNameRegister" style="width: 250px;" maxlength="20" type="text" id="userNameRegister" autofocus="" placeholder="Nombre de usuario">
                                            </div>
                                        </div>
                                        <div style="position: relative; height: 70px;">
                                            <div class="label-row">
                                                <label for="password">Correo electronico</label>
                                            </div>
                                            <div class="input-row" style="padding-right: 30px;">
                                                <input title="Ingresa tu correo para poder ingresar" name="email"  type="text" id="email" placeholder="Correo">
                                            </div>
                                        </div>
                                        <div style="position: relative; height: 70px;">
                                            <div class="label-row">
                                                <label for="password">Contraseña</label>
                                            </div>
                                            <div class="input-row" style="padding-right: 118px;">
                                                <input title="Ingresa tu contraseña para poder ingresar" name="password1" style="width: 160px;" type="password" class="password" id="password1" placeholder="Contraseña">
                                            </div>
                                        </div>
                                        <div style="position: relative; height: 70px;">
                                            <div class="label-row" style="padding-right: 80px;">
                                                <label for="password">Repita la contraseña</label>
                                            </div>
                                            <div class="input-row" style="padding-right: 118px;">
                                                <input title="Repita la la contraseña para poder ingresar" name="password2" style="width: 160px;" type="password" class="password" id="password2" placeholder="Contraseña">
                                            </div>
                                        </div>    
                                        <div class="description" id="back" style="cursor: pointer; text-decoration: underline">Regresar<<</div>
                                        <div class="button-row">
                                            <input type="submit" id="buttonGetStartedRegister" class="button" value="Registrar" />
                                        </div>
                                    </div><br>
                                </form><!--/ form-->
                            </section><!--/ seccion-->
                        </div>
                    </div>
                </center>  
            </body>
            <script type="text/javascript" src="../content/files-jq/<%out.print(vertion);%>/jqwidgets/localization.js"></script>
            <script type="text/javascript" src="../content/files-jq/<%out.print(vertion);%>/jqwidgets/jqxcore.js"></script>
            <script type="text/javascript" src="../content/files-jq/<%out.print(vertion);%>/jqwidgets/jqxpasswordinput.js"></script>
            <script type="text/javascript" src="../content/files-jq/<%out.print(vertion);%>/jqwidgets/jqxtooltip.js"></script>
            <script type="text/javascript" src="../content/files-jq/<%out.print(vertion);%>/jqwidgets/jqxinput.js"></script>
            <script type="text/javascript" src="../content/files-jq/<%out.print(vertion);%>/jqwidgets/jqxvalidator.js"></script>
            <script type="text/javascript" src="../content/files-jq/<%out.print(vertion);%>/jqwidgets/jqxwindow.js"></script>
            <script type="text/javascript" src="../content/files-jq/<%out.print(vertion);%>/jqwidgets/jqxbuttons.js"></script>
            <script type="text/javascript">
                $(document).ready(function (){
                    window.location.hash="";
                    window.location.hash=""; //chrome
                    window.onhashchange=function(){window.location.hash="";};
                    //window.location.href.replace( /#.*/, "");
                    $(".password").jqxPasswordInput({width: '170px', showStrength: false, showStrengthPosition: "right" });
                    $(".password, #nameUser").focusin(function (){
                        $("#MessageError").fadeOut("slow");
                    });
                    $("#formLogin").jqxValidator({
                        hintType: 'label',
                        animationDuration: 0,
                        rules: [
                                    {
                                        input: "#userName", 
                                        message: "El campo requerido!", 
                                        action: 'keyup, blur', 
                                        rule: "required"
                                    },
                                    {   
                                        input: "#password", 
                                        message: "La contraseña es necesaria!", 
                                        action: 'keyup, blur', 
                                        rule: 'required' 
                                    }
                                ]
                    });
                    $("#buttonGetStarted").click(function (){
                        $('#formLogin').jqxValidator('validate');
                        return false;
                    });
                    $('#formLogin').submit(function (){
                        $('#formLogin').jqxValidator('validate');
                    });
                    $('#formLogin').on('validationSuccess', function (event) {
                        //en el evento submit del fomulario
                        var datos = $("#formLogin").serialize(); // los datos del 
                        $.ajax({
                            type: "POST",
                            async: false,
                            url: "../serviceCandidate?statusAcount",
                            data:datos,
                            beforeSend: function (xhr) {
                                $("#windowBlock").fadeIn("slow");
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                alert("Error interno del servidor");
                                $("#windowBlock").fadeOut("slow");
                            },
                            success: function (data, textStatus, jqXHR) {
                                if(data==="1logeado"){
                                    setTimeout(function(){
                                        $("#windowBlock").fadeOut("slow");
                                        window.location = "/preregistro/";
                                    }, 2000);
                                }else if(data==="0noLogeado"){
                                    $("#windowBlock").fadeOut("slow");
                                    $("#message").text("Para iniciar sesión es necesario activar tu cuenta para ello revisa el correo que te hemos mandado.");
                                    $("#jqxwindow").jqxWindow("open");
                                    $("#MessageError").text("Es necesario activar la cuenta");
                                    $("#MessageError").fadeIn("slow");
                                }else if(data==="0notExit"){
                                    $("#windowBlock").fadeOut("slow");
                                    $("#MessageError").text("Error datos incorrectos");
                                    $("#MessageError").fadeIn("slow");
                                }
                            }
                        });
                    });

                    $("#formRegister").jqxValidator({
                        hintType: 'label',
                        animationDuration: 0,
                        rules: [
                                    {
                                        input: "#userNameRegister", 
                                        message: "El nombre de usuario es requerido :/", 
                                        action: 'keyup, blur', 
                                        rule: "required"
                                    },
                                    {
                                        input: "#userNameRegister", 
                                        message: "No se permiten espacios :/", 
                                        action: 'keyup, blur', 
                                        rule: function (input, commit) {
                                            // call commit with false, when you are doing server validation and you want to display a validation error on this field. 
                                            if (!(/\s/.test(input.val()))) {
                                                return true;
                                            }
                                            return false;
                                        } 
                                    },
                                    {
                                        input: "#userNameRegister", 
                                        message: "La longitud máxima es de 15 caracteres!", 
                                        action: 'keyup, blur', 
                                        rule: function (input, commit) {
                                            // call commit with false, when you are doing server validation and you want to display a validation error on this field. 
                                            if (!(input.val().length>=16)) {
                                                return true;
                                            }
                                            return false;
                                        } 
                                    },
                                    {
                                        input: "#userNameRegister", 
                                        message: "La longitud minima es de 5 caracteres!", 
                                        action: 'keyup, blur', 
                                        rule: function (input, commit) {
                                            // call commit with false, when you are doing server validation and you want to display a validation error on this field. 
                                            if (!(input.val().length<5)) {
                                                return true;
                                            }
                                            return false;
                                        } 
                                    },
                                    {
                                        input: "#userNameRegister", 
                                        message: "El nombre de usuario no esta disponible:/", 
                                        action: 'blur', 
                                        rule: function (input, commit) {
                                            var validate = false;
                                            // call commit with false, when you are doing server validation and you want to display a validation error on this field. 
                                            $.ajax({
                                                type: "POST",
                                                async: false,
                                                url: "../serviceCandidate?validateUserName",
                                                data: {"dataUserName": input.val()},
                                                beforeSend: function (xhr) {
                                                },
                                                error: function (jqXHR, textStatus, errorThrown) {
                                                    alert("Error interno del servidor");
                                                },
                                                success: function (data, textStatus, jqXHR) {
                                                    if(data==="true"){
                                                        validate=true;
                                                    }
                                                }
                                            });
                                            return validate;
                                        } 
                                    },
                                    {
                                        input: "#email", 
                                        message: "El correo es requerido :/", 
                                        action: 'keyup, blur', 
                                        rule: "required"
                                    },
                                    {
                                        input: "#email", 
                                        message: "Contiene espacios >_<", 
                                        action: 'keyup, blur', 
                                        rule: function (input, commit) {
                                            // call commit with false, when you are doing server validation and you want to display a validation error on this field. 
                                            if (!(/\s/.test(input.val()))) {
                                                return true;
                                            }
                                            return false;
                                        } 
                                    },
                                    { 
                                        input: '#email', 
                                        message: 'Correo en uso', 
                                        action: 'keyup', 
                                        rule: function (input, commit) {
                                           var validate = false;
                                            // call commit with false, when you are doing server validation and you want to display a validation error on this field. 
                                            $.ajax({
                                                type: "POST",
                                                async: false,
                                                url: "../serviceCandidate?validateEmail",
                                                data: {"dataEmail": input.val()},
                                                beforeSend: function (xhr) {
                                                },
                                                error: function (jqXHR, textStatus, errorThrown) {
                                                    alert("Error interno del servidor");
                                                },
                                                success: function (data, textStatus, jqXHR) {
                                                    if(data==="true"){
                                                        validate=true;
                                                    }
                                                }
                                            });
                                            return validate;
                                        }  
                                    },
                                    { 
                                        input: '#email', 
                                        message: 'Seleccione un correo correcto :(', 
                                        action: 'keyup', 
                                        rule: 'email' 
                                    },
                                    {   
                                        input: "#password1", 
                                        message: "La contraseña es necesaria :/", 
                                        action: 'keyup, blur', 
                                        rule: 'required' 
                                    },
                                    {   
                                        input: "#password2", 
                                        message: "La contraseña es necesaria :/", 
                                        action: 'keyup, blur', 
                                        rule: 'required' 
                                    },
                                    {   
                                        input: "#password2", 
                                        message: "Las contraseñas no concuerdan >_<", 
                                        action: 'keyup, focus', 
                                        rule: function (input, commit) {
                                            // call commit with false, when you are doing server validation and you want to display a validation error on this field. 
                                            if (input.val() === $('#password1').val()) {
                                                return true;
                                            }
                                            return false;
                                        } 
                                    }
                                ]
                    });
                    $("#buttonGetStartedRegister").click(function (){
                        $('#formRegister').jqxValidator('validate');
                        return false;
                    });
                    $('#formRegister').submit(function (){
                        $('#formRegister').jqxValidator('validate');
                    });
                    $('#formRegister').on('validationSuccess', function (event) {
                        //en el evento submit del fomulario
                        var datos = $("#formRegister").serialize(); // los datos del 
                        $.ajax({
                            type: "POST",
                            async: false,
                            url: "../serviceCandidate?insert",
                            data:datos,
                            beforeSend: function (xhr) {
                                $("#windowBlockRegister").fadeIn("slow");
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                alert("Error interno del servidor");
                                $("#windowBlock").fadeOut("slow");
                            },
                            success: function (data, textStatus, jqXHR) {
                                if(!(data==="error")){
                                    $.ajax({
                                        type: "POST",
                                        async: true,
                                        url: "../serviceMail?welcome",
                                        data: {
                                            "email":  $("#email").val(),
                                            "userName": $("#userNameRegister").val(),
                                            "password": $("#password1").val() 
                                        },
                                        beforeSend: function (xhr) {
                                            $("#windowBlockRegister").fadeIn("slow");
                                        },
                                        error: function (jqXHR, textStatus, errorThrown) {
                                            alert("Error interno del servidor");
                                            $("#windowBlockRegister").fadeOut("slow");
                                        },
                                        success: function (data, textStatus, jqXHR) {
                                            if(data==="Success"){                                                    
                                                $("#message").text("Revisa tu correo te hemos mandado un link para activar tu cuenta.");
                                                $("#jqxwindow").jqxWindow("open");
                                                $(".login").slideDown(2000);
                                                $(".register").slideUp("slow");
                                            }else if("FailConnectionNetwork"){
                                                $("#message").text("Registro creado correctamente pero no fue posible mandar los datos a tu correo!");
                                                $("#jqxwindow").jqxWindow("open");
                                                $("#windowBlockRegister").fadeOut("slow");
                                            }
                                        }
                                    });
                                }else{
                                    $("#windowBlockRegister").fadeOut("slow");
                                    $("#MessageErrorRegister").fadeIn("slow");
                                }
                            }
                        });
                    });
                    $("#nonFolio").click(function (){
                       $(".login").slideUp("slow");
                       $(".register").slideDown(2000);
                    });
                    $("#back").click(function (){
                       $(".login").slideDown(2000);
                       $(".register").slideUp("slow");
                    });
                    $("#jqxwindow").jqxWindow({
                        height: 130,
                        width: 350,
                        theme: 'greenUtsem',
                        autoOpen: false,
                        isModal: true,
                        showCloseButton: true,
                        resizable: false,
                        position: "center",
                        okButton: $('#ok'),
                        initContent: function () {
                            $('#ok').jqxButton({
                                width: '65px',
                                theme: 'greenUtsem'
                            });
                            $('#ok').focus();
                        }
                    });
                });
            </script>
        </html>
    <%}else{
        response.sendRedirect("/preregistro/module.jsp");
    }
%>