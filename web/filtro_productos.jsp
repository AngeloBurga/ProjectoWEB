<%@page import="beans.Producto"%>
<%@page import="beans.Producto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>

<style>
    .form-filtro {
        background-color: #f8f9fa;
        padding: 20px;
        border-radius: 8px;
        margin-bottom: 25px;
        display: flex;
        gap: 15px;
        align-items: flex-end;
        flex-wrap: wrap;
        border: 1px solid #e9ecef;
    }
    .grupo-filtro {
        display: flex;
        flex-direction: column;
        gap: 5px;
    }
    .grupo-filtro label {
        font-weight: bold;
        font-size: 0.9em;
        color: #495057;
    }
    .grupo-filtro input, .grupo-filtro select {
        padding: 8px 12px;
        border: 1px solid #ced4da;
        border-radius: 4px;
        font-size: 0.95em;
    }
    .btn-buscar {
        background-color: #0d6efd;
        color: white;
        border: none;
        padding: 9px 20px;
        border-radius: 4px;
        cursor: pointer;
        font-weight: bold;
    }
    .btn-buscar:hover {
        background-color: #0b5ed7;
    }

    .tabla-resultados {
        width: 100%;
        border-collapse: collapse;
        margin-top: 10px;
    }
    .tabla-resultados th, .tabla-resultados td {
        padding: 12px;
        border: 1px solid #dee2e6;
        text-align: left;
    }
    .tabla-resultados th {
        background-color: #f1f3f5;
        color: #343a40;
    }
    .badge-activo {
        background-color: #d1e7dd;
        color: #0f5132;
        padding: 4px 8px;
        border-radius: 4px;
        font-weight: bold;
    }
    .badge-inactivo {
        background-color: #f8d7da;
        color: #842029;
        padding: 4px 8px;
        border-radius: 4px;
        font-weight: bold;
    }
</style>
</head>
<body>

    <h2>🔍 Consultas y Filtros de Productos</h2>

    <!-- FORMULARIO DE FILTRADO -->
    <form action="ProductoServlet" method="GET" class="form-filtro">
        <input type="hidden" name="action" value="filtrar">

        <div class="grupo-filtro">
            <label for="txtNombre">Nombre del Producto:</label>
            <input type="text" id="txtNombre" name="txtNombre" 
                   value="${txtNombre}" placeholder="Ej: Sabanas, Papas...">
        </div>

        <div class="grupo-filtro">
            <label for="cboEstado">Estado:</label>
            <select id="cboEstado" name="cboEstado">
                <option value="TODOS" ${cboEstado == 'TODOS' ? 'selected' : ''}>-- Todos --</option>
                <option value="Activo" ${cboEstado == 'Activo' ? 'selected' : ''}>Activo</option>
                <option value="Inactivo" ${cboEstado == 'Inactivo' ? 'selected' : ''}>Inactivo</option>
            </select>
        </div>

        <button type="submit" class="btn-buscar">Buscar / Filtrar</button>
    </form>

    <!-- TABLA DE RESULTADOS (Muestra Nombre, Ubicación y Estado) -->
    <table class="tabla-resultados">
        <thead>
            <tr>
                <th>Código</th>
                <th>Nombre del Producto</th>
                <th>Ubicación / Ubigeo</th>
                <th>Estado</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<Producto> lista = (List<Producto>) request.getAttribute("listaResultado");
                if (lista != null && !lista.isEmpty()) {
                    for (Producto p : lista) {
                        String ubi = (p.getUbigeo() != null && p.getUbigeo().getCod_ubigeo() != null)
                                ? p.getUbigeo().getCod_ubigeo() : "N/A";
            %>
            <tr>
                <td><strong><%= p.getCod_p()%></strong></td>
                <td><%= p.getNombre()%></td>
                <td><%= ubi%></td>
                <td>
                    <% if ("Activo".equalsIgnoreCase(p.getEstado())) { %>
                    <span class="badge-activo">Activo</span>
                    <% } else { %>
                    <span class="badge-inactivo">Inactivo</span>
                    <% } %>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="4" style="text-align: center; color: #6c757d;">
                    ⚠️ No se encontraron resultados con los criterios seleccionados.
                </td>
            </tr>
            <% }%>
        </tbody>
    </table>

</body>
