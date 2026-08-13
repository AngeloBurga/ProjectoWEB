package servlet;

import beans.Usuario;
import dao.UsuarioDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "usuarioServlet", urlPatterns = {"/usuarioServlet"})
public class usuarioServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoginServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
            String txtOperacion = request.getParameter("txtOperacion");

            if (txtOperacion.equals("1")) {
                String txtUser = request.getParameter("txtUsuario");
                String txtPass = request.getParameter("txtClave");

                UsuarioDAO dao = new UsuarioDAO();
                Usuario usuarioValido = dao.validarAcceso(txtUser, txtPass);

                if (usuarioValido != null) {

                    HttpSession session = request.getSession(true);
                    session.setAttribute("usuarioLogueado", usuarioValido);
                    response.sendRedirect("menu.jsp");
                } else {

                    request.setAttribute("mensajeError", "Usuario o contraseña incorrectos.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            } 
        

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
