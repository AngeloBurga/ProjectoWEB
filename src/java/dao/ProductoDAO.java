package dao;

import beans.Almacen;
import beans.Producto;
import beans.Ubigeo;
import conexion.ConexionDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ProductoDAO {

    public boolean insertarProducto(Producto p) {
        String query = "INSERT INTO producto (cod_p, nombre, cod_almacen, cod_ubigeo, foto, estado, fecha, pdf) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        boolean flag = false;
        try {
            Connection conn = ConexionDB.getConexion();
            PreparedStatement ps = conn.prepareCall(query);

            ps.setString(1, p.getCod_p());
            ps.setString(2, p.getNombre());
            ps.setString(3, p.getAlmacen().getAlmacen());
            ps.setString(4, p.getUbigeo().getCod_ubigeo());
            ps.setString(5, p.getFoto());
            ps.setString(6, p.getEstado());

            java.util.Date date = new java.util.Date(); // Fecha actual
            java.sql.Date sqlDate = new java.sql.Date(date.getTime());

            ps.setDate(7, sqlDate);
            ps.setString(8, p.getPdf());

            flag = true;
            ps.executeUpdate();
            System.out.println("correcto");
            return flag;
        } catch (SQLException ex) {
            System.out.println(ex);
            System.out.println("incorrecto");
        }
        return flag;
    }

    public List<Producto> listarTodos() {
        String query = "SELECT\n"
                + "    p.cod_p,\n"
                + "    p.foto,\n"
                + "    p.nombre, \n"
                + "    c.almacen as almacen, \n"
                + "    u.departamento as ubicacion, \n"
                + "    p.fecha, \n"
                + "    p.pdf, \n"
                + "    p.estado \n"
                + "FROM producto p\n"
                + "INNER JOIN almacen c ON p.cod_almacen = c.cod_almacen\n"
                + "INNER JOIN ubigeo u ON p.cod_ubigeo = u.cod_ubigeo   ";
        List<Producto> lista = new ArrayList<>();
        try {

            Connection conn = ConexionDB.getConexion();
            PreparedStatement ps = conn.prepareCall(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Producto producto = new Producto();
                producto.setCod_p(rs.getString("cod_p"));
                producto.setFoto(rs.getString("foto"));
                producto.setNombre(rs.getString("nombre"));
                //////////////////////////////////////////////////
                Almacen alm = new Almacen();
                alm.setAlmacen("alm");
                producto.setAlmacen(alm);
                //////////////////////////////////////////////////
                Ubigeo ubi = new Ubigeo();
                ubi.setDepartamento("departamento");
                producto.setUbigeo(ubi);
                //////////////////////////////////////////////////
                producto.setFecha(rs.getDate("fecha"));
                producto.setPdf(rs.getString("pdf"));
                producto.setEstado(rs.getString("estado"));

                lista.add(producto);
            }

        } catch (SQLException ex) {
            Logger.getLogger(ProductoDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return lista;
    }

    public boolean actualizar(Producto p) {
        boolean actualizado = false;
        // IMPORTANTE: Debe ser UPDATE, no INSERT
        String sql = "UPDATE producto SET nombre = ?, cod_almacen = ?, cod_ubigeo = ?, foto = ?, pdf = ?, estado = ? WHERE cod_p = ?";

        try (Connection cn = ConexionDB.getConexion(); PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, p.getNombre());
            ps.setString(2, (p.getAlmacen() != null) ? p.getAlmacen().getAlmacen() : null);
            ps.setString(3, (p.getUbigeo() != null) ? p.getUbigeo().getCod_ubigeo() : null);
            ps.setString(4, p.getFoto());
            ps.setString(5, p.getPdf());
            ps.setString(6, p.getEstado());

            // El ID va en la cláusula WHERE al final (posición 7)
            ps.setString(7, p.getCod_p());

            int filasAfectadas = ps.executeUpdate();
            if (filasAfectadas > 0) {
                actualizado = true;
            }

        } catch (SQLException e) {
            System.out.println(">>> ERROR SQL EN actualizar: " + e.getMessage());
            e.printStackTrace();
        }

        return actualizado;
    }

    public boolean eliminarLogico(String id) {
        Connection cn = null;
        PreparedStatement ps = null;
        boolean exito = false;

        String sqlLogicalDelete = "UPDATE producto SET estado = 'Inactivo' WHERE cod_p = ?";

        try {
            cn = ConexionDB.getConexion();
            if (cn != null) {
                ps = cn.prepareStatement(sqlLogicalDelete);
                ps.setString(1, id);
                int rowsAffected = ps.executeUpdate();
                if (rowsAffected > 0) {
                    exito = true;
                }
            }
        } catch (SQLException e) {
            System.out.println("Error al aplicar la eliminación lógica en el DAO: " + e.getMessage());
        }
        return exito;
    }

    public Producto obtenerPorId(String id) {
        Producto p = null;

        String sql = "SELECT * FROM producto WHERE cod_p = ?";

        try (Connection cn = ConexionDB.getConexion(); PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    p = new Producto();
                    p.setCod_p(rs.getString("cod_p"));
                    p.setNombre(rs.getString("nombre"));

                    // IMPORTANTE: Debes instanciar e ingresar los datos del Almacén
                    Almacen a = new Almacen();
                    a.setAlmacen(rs.getString("almacen")); // Revisa el nombre exacto de la columna en tu BD
                    p.setAlmacen(a);

                    // IMPORTANTE: Debes instanciar e ingresar los datos del Ubigeo
                    Ubigeo u = new Ubigeo();
                    u.setCod_ubigeo(rs.getString("ubigeo")); // Revisa el nombre exacto de la columna en tu BD
                    p.setUbigeo(u);

                    p.setFoto(rs.getString("foto"));
                    p.setPdf(rs.getString("pdf"));
                    p.setEstado(rs.getString("estado"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return p;
    }

    public List<Producto> obtenerPorUbigeo() {
        List<Producto> lista = new ArrayList<>();
        // Cambia 'cod_ubigeo' por el nombre REAL de la columna de ubigeo en tu BD
        String sql = "SELECT * FROM producto ORDER BY cod_ubigeo ASC";

        try (Connection cn = ConexionDB.getConexion(); PreparedStatement ps = cn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Producto p = new Producto();
                p.setCod_p(rs.getString("cod_p"));
                p.setNombre(rs.getString("nombre"));
                p.setFoto(rs.getString("foto"));
                p.setPdf(rs.getString("pdf"));
                p.setEstado(rs.getString("estado"));

                // Ajusta el nombre de la columna aquí también
                Ubigeo u = new Ubigeo();
                u.setCod_ubigeo(rs.getString("cod_ubigeo"));
                p.setUbigeo(u);

                lista.add(p);
            }
        } catch (SQLException e) {
            System.out.println(">>> ERROR EN obtenerPorUbigeo: " + e.getMessage());
            e.printStackTrace();
        }
        return lista;
    }
// 2. Método para Reporte de Inactivos

    public List<Producto> obtenerInactivos() {
        List<Producto> lista = new ArrayList<>();
        String sql = "SELECT * FROM producto WHERE estado = 'Inactivo'";

        try (Connection cn = ConexionDB.getConexion(); PreparedStatement ps = cn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Producto p = new Producto();
                p.setCod_p(rs.getString("cod_p"));
                p.setNombre(rs.getString("nombre"));
                p.setFoto(rs.getString("foto"));
                p.setPdf(rs.getString("pdf"));
                p.setEstado(rs.getString("estado"));

                Ubigeo u = new Ubigeo();
                u.setCod_ubigeo(rs.getString("ubigeo"));
                p.setUbigeo(u);

                Almacen a = new Almacen();
                a.setAlmacen(rs.getString("almacen"));
                p.setAlmacen(a);

                lista.add(p);
            }
            System.out.println(">>> Reporte Inactivos - Registros encontrados: " + lista.size());

        } catch (SQLException e) {
            System.out.println(">>> ERROR EN obtenerInactivos: " + e.getMessage());
            e.printStackTrace();
        }
        return lista;
    }

    public List<Producto> buscarConFiltro(String nombre, String ubigeo, String estado) {
        // 1. Obtenemos todos los productos (aprovechando tu método que ya funciona)
        List<Producto> listaCompleta = listarTodos();
        List<Producto> listaFiltrada = new ArrayList<>();

        for (Producto p : listaCompleta) {
            boolean cumpleNombre = true;
            boolean cumpleEstado = true;

            // Validar filtro de Nombre (coincidencia parcial sin importar mayúsculas/minúsculas)
            if (nombre != null && !nombre.trim().isEmpty()) {
                cumpleNombre = p.getNombre() != null
                        && p.getNombre().toLowerCase().contains(nombre.trim().toLowerCase());
            }

            // Validar filtro de Estado
            if (estado != null && !estado.trim().isEmpty() && !"TODOS".equalsIgnoreCase(estado)) {
                cumpleEstado = p.getEstado() != null
                        && p.getEstado().equalsIgnoreCase(estado.trim());
            }

            // Si cumple con los criterios, lo agregamos a la lista final
            if (cumpleNombre && cumpleEstado) {
                listaFiltrada.add(p);
            }
        }

        return listaFiltrada;
    }
}
