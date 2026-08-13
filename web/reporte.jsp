<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="beans.Producto" %>

<%
    // Recuperar los datos enviados desde el Servlet
    List<Producto> lista = (List<Producto>) request.getAttribute("listaReporte");
    String titulo = (String) request.getAttribute("tituloReporte");
    if (titulo == null) titulo = "Reporte de Productos";
%>

<style>
    .reporte-container {
        width: 100%;
        max-width: 1100px;
        margin: 20px auto;
        background: #ffffff;
        padding: 25px;
        border-radius: 10px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
    }

    .reporte-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
        padding-bottom: 15px;
        border-bottom: 2px solid #e2e8f0;
    }

    .reporte-header h2 {
        margin: 0;
        color: #1e293b;
        font-size: 22px;
    }

    .reporte-actions {
        display: flex;
        gap: 10px;
    }

    .btn-reporte {
        padding: 8px 16px;
        border-radius: 6px;
        font-weight: 600;
        font-size: 13px;
        cursor: pointer;
        border: none;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 6px;
        transition: all 0.2s;
    }

    .btn-print {
        background-color: #0284c7;
        color: white;
    }

    .btn-print:hover {
        background-color: #0369a1;
    }

    .tabla-reporte {
        width: 100%;
        border-collapse: collapse;
        margin-top: 10px;
    }

    .tabla-reporte th {
        background-color: #f8fafc;
        color: #475569;
        font-weight: 700;
        text-align: left;
        padding: 12px 15px;
        border-bottom: 2px solid #cbd5e1;
        font-size: 13px;
        text-transform: uppercase;
    }

    .tabla-reporte td {
        padding: 12px 15px;
        border-bottom: 1px solid #e2e8f0;
        color: #334155;
        font-size: 14px;
    }

    .tabla-reporte tbody tr:hover {
        background-color: #f1f5f9;
    }

    /* Badges de Estado */
    .badge {
        padding: 4px 8px;
        border-radius: 12px;
        font-size: 12px;
        font-weight: 600;
    }

    .badge-activo {
        background-color: #dcfce7;
        color: #15803d;
    }

    .badge-inactivo {
        background-color: #fee2e2;
        color: #b91c1c;
    }

    /* Ocultar elementos innecesarios al imprimir */
    @media print {
        .reporte-actions, .nav-menu, header {
            display: none !important;
        }
        .reporte-container {
            box-shadow: none;
            padding: 0;
        }
    }
</style>

<div class="reporte-container">
    <div class="reporte-header">
        <h2>📊 <%= titulo %></h2>
        <div class="reporte-actions">
            <button onclick="window.print()" class="btn-reporte btn-print">🖨️ Imprimir Reporte</button>
        </div>
    </div>

    <% if (lista == null || lista.isEmpty()) { %>
        <p style="text-align: center; color: #64748b; margin: 40px 0;">
            ⚠️ No se encontraron registros para mostrar en esta consulta.
        </p>
    <% } else { %>

    <table class="tabla-reporte">
        <thead>
            <tr>
                <th>Código</th>
                <th>Nombre del Producto</th>
                <th>Ubicación / Ubigeo</th>
                <th>Foto (Ref)</th>
                <th>Ficha PDF</th>
                <th>Estado</th>
            </tr>
        </thead>
        <tbody>
            <% for (Producto p : lista) { %>
                <tr>
                    <td><strong><%= p.getCod_p() %></strong></td>
                    <td><%= p.getNombre() %></td>
                    <td>
                        <%= (p.getUbigeo() != null && p.getUbigeo().getCod_ubigeo() != null) 
                            ? p.getUbigeo().getCod_ubigeo() : "N/A" %>
                    </td>
                    <td>
                        <%= (p.getFoto() != null && !p.getFoto().isEmpty()) ? p.getFoto() : "Sin foto" %>
                    </td>
                    <td>
                        <%= (p.getPdf() != null && !p.getPdf().isEmpty()) ? p.getPdf() : "Sin PDF" %>
                    </td>
                    <td>
                        <% if ("Activo".equalsIgnoreCase(p.getEstado())) { %>
                            <span class="badge badge-activo">Activo</span>
                        <% } else { %>
                            <span class="badge badge-inactivo">Inactivo</span>
                        <% } %>
                    </td>
                </tr>
            <% } %>
        </tbody>
    </table>

    <p style="margin-top: 15px; font-size: 12px; color: #64748b; text-align: right;">
        Total de registros cargados: <strong><%= lista.size() %></strong>
    </p>

    <% } %>
</div>