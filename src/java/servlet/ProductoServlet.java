    package servlet;

import beans.Almacen;
import beans.Producto;
import beans.Ubigeo;
import com.google.gson.Gson;
import dao.ProductoDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.util.List;

@WebServlet(name = "ProductoServlet", urlPatterns = {"/ProductoServlet"})
public class ProductoServlet extends HttpServlet {

    ProductoDAO pdao = new ProductoDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("edit".equals(action)) {
            String idParam = request.getParameter("id");

            if (idParam != null && !idParam.isEmpty()) {
                Producto p = pdao.obtenerPorId(idParam);
                request.setAttribute("producto", p);
                request.getRequestDispatcher("menu.jsp").forward(request, response);
                return;
            }
        }

        if ("reporteUbigeo".equals(action)) {
            List<Producto> lista = pdao.listarTodos();
            request.setAttribute("listaReporte", lista);
            request.setAttribute("tituloReporte", "Reporte General de Productos por Ubicación");
            request.getRequestDispatcher("menu.jsp?sec=reporte1").forward(request, response);
            return;
        }

        if ("reporteInactivos".equals(action)) {
            List<Producto> lista = pdao.obtenerInactivos();
            request.setAttribute("listaReporte", lista);
            request.setAttribute("tituloReporte", "Reporte de Productos Inactivos / Bloqueados");

            request.getRequestDispatcher("menu.jsp?sec=reporte1").forward(request, response);
            return;
        }
        
        if ("filtrar".equals(action)) {
            String fNombre = request.getParameter("txtNombre");
            String fEstado = request.getParameter("cboEstado");
            System.out.println(fEstado + fEstado);

            if (fEstado == null) {
                fEstado = "TODOS";
            }
            List<Producto> listaFiltrada = pdao.buscarConFiltro(fNombre, null, fEstado);

            request.setAttribute("txtNombre", fNombre != null ? fNombre : "");
            request.setAttribute("cboEstado", fEstado);
            request.setAttribute("listaResultado", listaFiltrada);

            request.getRequestDispatcher("menu.jsp?sec=filtro").forward(request, response);
            return;
        }
        List<Producto> lista = pdao.listarTodos();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        Gson gson = new Gson();
        response.getWriter().write(gson.toJson(lista));
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null || action.isEmpty()) {
            action = "insert";
        }

        switch (action) {
            case "insert": {
                String cod_p = request.getParameter("txtCodigo");
                String nombre = request.getParameter("txtNombre");
                String almacen = request.getParameter("cmbAlmacen");
                String ubigeo = request.getParameter("cmbDistrito");
                String foto = request.getParameter("fileFoto");
                String pdf = request.getParameter("filePdf");
                String estado = request.getParameter("cmbEstado");

                Producto p = new Producto();
                p.setCod_p(cod_p);
                p.setNombre(nombre);

                Almacen a = new Almacen();
                a.setAlmacen(almacen);
                p.setAlmacen(a);

                Ubigeo u = new Ubigeo();
                u.setCod_ubigeo(ubigeo);
                p.setUbigeo(u);

                p.setFoto(foto);
                p.setPdf(pdf);
                p.setEstado(estado);

                pdao.insertarProducto(p);
                response.sendRedirect("menu.jsp?sec=nuevo");
                break;
            }

            case "update": {
                String cod_p = request.getParameter("txtCodigo");
                String nombre = request.getParameter("txtNombre");
                String almacen = request.getParameter("cmbAlmacen");
                String ubigeo = request.getParameter("cmbDistrito");
                String foto = request.getParameter("fileFoto");
                String pdf = request.getParameter("filePdf");
                String estado = request.getParameter("cmbEstado");

                Producto p = new Producto();
                p.setCod_p(cod_p);
                p.setNombre(nombre);

                Almacen a = new Almacen();
                a.setAlmacen(almacen);
                p.setAlmacen(a);

                Ubigeo u = new Ubigeo();
                u.setCod_ubigeo(ubigeo);
                p.setUbigeo(u);

                p.setFoto(foto);
                p.setPdf(pdf);
                p.setEstado(estado);

                pdao.actualizar(p);

                response.sendRedirect("menu.jsp?sec=productos");

                break;
            }

            case "logicalDelete": {
                String idParam = request.getParameter("id");
                if (idParam != null && !idParam.isEmpty()) {
                    pdao.eliminarLogico(idParam);
                }
                response.sendRedirect("menu.jsp?sec=productos");
                break;
            }

            default:
                response.sendRedirect("ProductoServlet?action=list");
                break;
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
