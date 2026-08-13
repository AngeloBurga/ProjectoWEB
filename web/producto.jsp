<%@page import="beans.Producto"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Recuperamos la lista filtrada o total desde el Servlet
    List<Producto> listaProductos = (List<Producto>) request.getAttribute("listaProductos");

    // Recuperamos el término de búsqueda actual para mantener el estado en el input
    String txtBuscar = (String) request.getAttribute("txtBuscar");
    if (txtBuscar == null) {
        txtBuscar = "";
    }

    // Formateador de fecha simple
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
%>

<style>
    /* Estilos específicos para la sección de productos */
    .cabecera-seccion {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 25px;
        border-bottom: 2px solid #3b82f6;
        padding: 15px;
        flex-wrap: wrap;
        gap: 15px;
    }

    .cabecera-seccion h2 {
        margin: 0;
        color: #1e293b;
        font-size: 22px;
        font-weight: 600;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .contenedor-cabecera-derecha {
        display: flex;
        align-items: center;
        gap: 12px;
        flex-wrap: wrap;
    }

    /* Estilos del Formulario de Búsqueda */
    .form-busqueda {
        display: flex;
        gap: 8px;
        align-items: center;
        margin: 0;
    }

    .input-buscar {
        padding: 10px 16px;
        border: 1.5px solid #cbd5e1;
        border-radius: 6px;
        font-size: 14px;
        color: #334155;
        outline: none;
        width: 260px;
        background-color: #f8fafc;
        transition: all 0.3s ease;
        box-sizing: border-box;
    }

    .input-buscar:focus {
        border-color: #3b82f6;
        background-color: #ffffff;
        box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.15);
    }

    .btn-buscar {
        background-color: #3b82f6;
        color: white;
        border: none;
        padding: 10px 18px;
        border-radius: 6px;
        font-weight: 600;
        font-size: 14px;
        cursor: pointer;
        transition: all 0.2s ease;
    }

    .btn-buscar:hover {
        background-color: #1d4ed8;
        transform: translateY(-1px);
    }

    .btn-limpiar {
        background-color: #94a3b8;
        color: white;
        text-decoration: none;
        padding: 10px 18px;
        border-radius: 6px;
        font-weight: 600;
        font-size: 14px;
        transition: all 0.2s ease;
        display: inline-block;
    }

    .btn-limpiar:hover {
        background-color: #64748b;
    }

    .btn-nuevo {
        background-color: #2ecc71;
        color: white;
        text-decoration: none;
        padding: 10px 18px;
        border-radius: 6px;
        font-weight: 600;
        font-size: 14px;
        transition: all 0.2s ease;
        box-shadow: 0 4px 6px -1px rgba(46, 204, 113, 0.2);
    }

    .btn-nuevo:hover {
        background-color: #27ae60;
        transform: translateY(-1px);
        box-shadow: 0 6px 12px -1px rgba(46, 204, 113, 0.3);
    }

    /* Estilos de la Tabla */
    .tabla-productos {
        width: 100%;
        border-collapse: collapse;
        background-color: #ffffff;
        box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05);
        border-radius: 8px;
        overflow: hidden;
        border: 1px solid #e2e8f0;
        margin-top: 10px;
        text-align: center;
    }

    .tabla-productos th {
        background-color: #2c3e50;
        color: white;
        text-align: left;
        padding: 14px 18px;
        font-size: 13px;
        font-weight: 600;
        letter-spacing: 0.5px;
        text-align: center;
    }

    .tabla-productos td {
        padding: 14px 18px;
        border-bottom: 1px solid #e2e8f0;
        color: #475569;
        font-size: 14px;
        vertical-align: middle;
    }

    .tabla-productos tr:last-child td {
        border-bottom: none;
    }

    .tabla-productos tr:hover {
        background-color: #f8fafc;
    }

    /* Miniatura de Foto */
    .foto-producto {
        width: 48px;
        height: 48px;
        object-fit: cover;
        border-radius: 6px;
        border: 1px solid #cbd5e1;
        background-color: #f1f5f9;
    }

    /* Badges de Estado */
    .badge {
        padding: 4px 10px;
        border-radius: 9999px;
        font-size: 11px;
        font-weight: 600;
        text-transform: uppercase;
        display: inline-block;
    }

    .badge-activo {
        background-color: #d1fae5;
        color: #065f46;
    }

    .badge-inactivo {
        background-color: #fee2e2;
        color: #991b1b;
    }

    /* Botones de acción (Modificar / Eliminar Lógicamente / PDF) */
    .btn-accion {
        border: none;
        text-decoration: none;
        padding: 6px 12px;
        border-radius: 4px;
        font-size: 12px;
        color: white;
        font-weight: 600;
        margin-right: 5px;
        transition: all 0.2s ease;
        display: inline-flex;
        align-items: center;
        gap: 4px;
    }

    .btn-modificar {
        background-color: #f59e0b;
    }

    .btn-modificar:hover {
        background-color: #d97706;
        transform: translateY(-1px);
    }

    .btn-eliminar-logico {
        background-color: #ef4444;
    }

    .btn-eliminar-logico:hover {
        background-color: #dc2626;
        transform: translateY(-1px);
    }

    .btn-pdf-ver {
        background-color: #10b981;
        color: white;
        text-decoration: none;
        padding: 6px 12px;
        border-radius: 4px;
        font-size: 12px;
        font-weight: 600;
        transition: all 0.2s ease;
        display: inline-flex;
        align-items: center;
        gap: 4px;
    }

    .btn-pdf-ver:hover {
        background-color: #059669;
        transform: translateY(-1px);
    }

    .mensaje-vacio {
        margin: 15px;
        text-align: center;
        padding: 50px 30px;
        background: #ffffff;
        border: 2px dashed #cbd5e1;
        color: #64748b;
        border-radius: 8px;
    }

    .mensaje-vacio h3 {
        margin: 0 0 8px 0;
        color: #1e293b;
    }

    .mensaje-vacio p {
        margin: 0;
        font-size: 14px;
    }
</style>

<div class="cabecera-seccion">
    <h2>📦 Gestión de Productos</h2>

    <div class="contenedor-cabecera-derecha">
        <!-- Formulario GET que apunta directamente al Servlet controlador -->
        <form action="ProductoServlet" method="GET" class="form-busqueda">
            <input type="hidden" name="action" value="list">
            <input type="text" 
                   name="txtBuscar" 
                   class="input-buscar" 
                   placeholder="Buscar por nombre..." 
                   value="">
            <button type="submit" class="btn-buscar">Buscar</button>

            <a href="ProductoServlet?action=list" class="btn-limpiar">Limpiar</a>

        </form>
        <a href="menu.jsp?sec=nuevo" class="btn-nuevo">+ Registrar Producto</a>
    </div>
</div>

<table class="tabla-productos">
    <thead>
        <tr>
            <th>Código</th>
            <th>Foto</th>
            <th>Nombre</th>
            <th>Almacén</th>
            <th>Ubicación </th>
            <th>F.Registro</th>
            <th>Ficha PDF</th>
            <th>Estado</th>
            <th>Acciones</th>
        </tr>
    </thead>
    <tbody id="tabla">

    </tbody>
</table>
<form id="formEliminar" action="ProductoServlet" method="POST">
    <input type="hidden" name="action" value="logicalDelete">
    <input type="hidden" name="id" id="idProductoEliminar">
</form>
<script>
    document.addEventListener("DOMContentLoaded", () => {
        cargarProductos();
    });
    function cargarProductos() {
        fetch("ProductoServlet")
                .then(response => response.json())
                .then(productos => {
                    const tabla = document.getElementById("tabla");
                    tabla.innerHTML = '';
                    productos.forEach(prod => {
                        const row = document.createElement("tr");
                        row.innerHTML = `
                            <td>` + prod.cod_p + `</td>
                            <td>` + prod.foto + `</td>
                            <td>` + prod.nombre + `</td>
                            <td>` + (prod.almacen ? prod.almacen.almacen : '') + `</td>
                            <td>` + (prod.ubigeo ? prod.ubigeo.departamento : '') + `</td>
                    <td>` + prod.fecha + `</td>
                    <td>` + prod.pdf + `</td>
                    <td>` + prod.estado + `</td>
                    <td> 
                        <!-- CAMBIO AQUÍ: Llamar a ProductoServlet con action=edit -->
                        <a href="ProductoServlet?action=edit&id=` + prod.cod_p + `" class="btn-accion btn-modificar">📝 Editar</a> 
                        <button type="button" class="btn-accion btn-eliminar-logico" onclick="confirmarEliminacion('` + prod.cod_p + `')">⛵ Borrar</button> 
                    </td>
                `;

                        tabla.appendChild(row);
                    });
                });
    }
    function confirmarEliminacion(codigoProducto) {
        if (confirm("¿Estás seguro de que deseas desactivar este producto?")) {
            document.getElementById('idProductoEliminar').value = codigoProducto;
            document.getElementById('formEliminar').submit();
        }
    }
    ;

</script>
