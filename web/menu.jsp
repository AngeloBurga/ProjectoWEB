<%@page import="beans.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // 1. FILTRO DE SEGURIDAD: Validar que el usuario tenga una sesión activa
    HttpSession sesion = request.getSession(false);
    Usuario user = (sesion != null) ? (Usuario) sesion.getAttribute("usuarioLogueado") : null;

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menú Principal - Sistema de Almacén</title>
    <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f6f9;
            }
            .contenedor-principal {
                max-width: 1200px;
                margin: 20px auto;
                background: #ffffff;
                box-shadow: 0px 4px 10px rgba(0,0,0,0.1);
                border-radius: 8px;
                overflow: hidden;
            }
            #logo {
                background-color: #2c3e50;
                color: white;
                padding: 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                border-bottom: 4px solid #3498db;
            }
            #logo h1 {
                margin: 0;
                font-size: 24px;
            }
            .info-usuario {
                font-size: 14px;
            }
            .info-usuario strong {
                color: #3498db;
            }
            #botones {
                background-color: #ecf0f1;
                padding: 10px 20px;
                display: flex;
                gap: 15px;
                border-bottom: 1px solid #bdc3c7;
            }
            #botones a {
                text-decoration: none;
                color: #2c3e50;
                font-weight: bold;
                padding: 10px 15px;
                border-radius: 4px;
                transition: background 0.3s, color 0.3s;
            }
            #botones a:hover, #botones a.activo {
                background-color: #3498db;
                color: white;
            }
            #botones a.btn-logout {
                background-color: #e74c3c;
                color: white;
                margin-left: auto;
            }
            #botones a.btn-logout:hover {
                background-color: #c0392b;
            }
            #contenido {
                padding: 30px 20px;
                min-height: 400px;
                color: #333;
            }
            .bienvenida-card {
                background-color: #ebf5fb;
                border-left: 5px solid #3498db;
                padding: 20px;
                border-radius: 4px;
            }/* Contenedor del Dropdown */
            .dropdown {
                position: relative;
                display: inline-block;
            }

            /* Botón principal del Dropdown */
            .dropdown-btn {
                background-color: transparent;
                color: #333;
                padding: 10px 15px;
                font-size: 15px;
                font-weight: 600;
                border: none;
                cursor: pointer;
                border-radius: 6px;
                display: flex;
                align-items: center;
                gap: 6px;
                transition: background 0.3s ease;
            }

            .dropdown-btn:hover {
                background-color: #3498db;
                color: #ffffff;
            }

            /* Menú desplegable oculto por defecto */
            .dropdown-content {
                display: none;
                position: absolute;
                top: 100%;
                left: 0;
                background-color: #ffffff;
                min-width: 220px;
                box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.15);
                border-radius: 8px;
                z-index: 1000;
                overflow: hidden;
                border: 1px solid #e2e8f0;
            }

            /* Enlaces dentro del desplegable */
            .dropdown-content a {
                color: #334155;
                padding: 12px 16px;
                text-decoration: none;
                display: block;
                font-size: 14px;
                font-weight: 500;
                transition: background 0.2s ease;
            }

            .dropdown-content a:hover {
                background-color: #f1f5f9;
                color: #3498db;
            }

            /* Mostrar el menú al pasar el cursor (Hover) */
            .dropdown:hover .dropdown-content {
                display: block;
            }
        </style>
    </head>
    <body>
        <div class="contenedor-principal">

            <div id="logo">
                <h1>Almacén Central</h1>
                <div class="info-usuario">
                    Usuario: <strong><%= user.getUsuario()%></strong> (ID: <%= user.getCod_usuario()%>)
                </div>
            </div>

            <%
                // Capturamos el parámetro "sec" para saber qué sección mostrar
                String seccion = request.getParameter("sec");
                if (seccion == null) {
                    seccion = "inicio"; // Por defecto muestra el inicio
                }
                if (request.getAttribute("producto") != null) {
                    seccion = "editar";
                }

                String paginaDestino = "inicio.jsp";

                if (seccion.equals("productos")) {
                    paginaDestino = "producto.jsp";
                } else if (seccion.equals("nuevo")) {
                    paginaDestino = "nuevo_producto.jsp";
                } else if (seccion.equals("editar")) {
                    paginaDestino = "editar_producto.jsp";
                } else if (seccion.equals("reporte1")) {
                    paginaDestino = "reporte.jsp";
                } else if (seccion.equals("filtro")) {
                    paginaDestino = "filtro_productos.jsp";
                } else if (seccion.equals("reportePdf")) {
                    paginaDestino = "reporte_pdf.jsp";
                }
            %>


            <div id="botones">
                <a href="menu.jsp?sec=inicio" class="<%= seccion.equals("inicio") ? "activo" : ""%>">Inicio</a>
                <a href="menu.jsp?sec=productos" class="<%= seccion.equals("productos") ? "activo" : ""%>">📦 Productos</a>
                <div class="dropdown">
                    <button class="dropdown-btn">📊 Consultas ▾</button>
                    <div class="dropdown-content">
                        <a href="ProductoServlet?sec=reporte1&action=reporteUbigeo">📍 Productos por Ubicación</a>
                        
                        <a href="ProductoServlet?sec=filtro&action=filtrar">🔍 Búsqueda y Filtro Personalizado</a>
                        <a href="ProductoServlet?sec=reportePdf&action=reportePdf">📄 Consulta de Documentación PDF</a>
                    </div>
                </div>
                <a href="LoginServlet?action=logout" class="btn-logout">Cerrar Sesión</a>
            </div>
            <div id='contenido'><jsp:include page="<%= paginaDestino%>" />
            </div>
        </div>
    </body>
</html>