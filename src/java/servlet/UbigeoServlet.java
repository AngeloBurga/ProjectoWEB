package servlet;

import com.google.gson.Gson;
import dao.UbigeoDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ubigeo", urlPatterns = {"/ubigeo"})
public class UbigeoServlet extends HttpServlet {

    private UbigeoDAO dao = new UbigeoDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UbigeoServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UbigeoServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        String accion = request.getParameter("accion");
        Gson gson = new Gson();
        String json = "[]";

        if ("departamentos".equals(accion)) {
            json = gson.toJson(dao.listarDepartamentos());

        } else if ("provincias".equals(accion)) {
            String codDep = request.getParameter("codDep");
            json = gson.toJson(dao.listarProvincias(codDep));

        } else if ("distritos".equals(accion)) {
            String codProv = request.getParameter("codProv");
            json = gson.toJson(dao.listarDistritos(codProv));
        }

        response.getWriter().write(json);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
