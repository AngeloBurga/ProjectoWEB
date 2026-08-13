<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login - Almacén</title>
        <link href="estilos/estilos.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <div id="div01">
            <div id="div02">
                <div id="div03">
                    <img src="imagenes/almacen.jpg" width="200" height="200">
                </div>
                <div id="div04">
                    
                    <%
                        System.out.println("Bienvenido");
                        if (request.getAttribute("mensajeError") != null) {
                    %>
                        <p style="color: red; font-weight: bold; text-align: center;">
                            <%= request.getAttribute("mensajeError") %>
                        </p>
                    <%
                        }
                    %>
                    
                    <form action="usuarioServlet" method="POST">
                        <table>
                            <tr>
                                <td>Usuario</td>
                                <td><input type="text" id="text_01" name="txtUsuario"> </td>
                                <td><input type="text" id="txtOperacion" name="txtOperacion" hidden="" value="1"></td>
                            </tr>
                            <tr>                               
                                <td>Password</td>
                                <td><input type="password" id="pass_01" name="txtClave"></td>
                            </tr>
                            <tr>
                                <td><input type="submit" value="Enviar"></td>
                                <td><input type="reset" value="Limpiar"></td>
                            </tr>
                        </table>
                    </form>
                </div>
            </div> 
        </div>
    </body>
</html>