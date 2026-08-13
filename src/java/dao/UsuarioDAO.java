package dao;

import beans.Usuario;
import conexion.ConexionDB;
import java.sql.*;

public class UsuarioDAO {

    public Usuario validarAcceso(String user, String pass) {
        Usuario u = null;
        String sql = "{call sp_validar_acceso(?,?)}";
        try {

            Connection cn = ConexionDB.getConexion();

            if (cn == null) {
                return null;
            }

            CallableStatement cs = cn.prepareCall(sql);
            cs.setString(1, user);
            cs.setString(2, pass);

            ResultSet rs = cs.executeQuery();

            if (rs.next()) {

                u = new Usuario();
                u.setCod_usuario(rs.getInt("cod_usuario"));
                u.setUsuario(rs.getString("usuario"));
            }

            rs.close();
            cs.close();
            cn.close();

        } catch (SQLException ex) {

            ex.getMessage();
        }
        return u;
    }
}
