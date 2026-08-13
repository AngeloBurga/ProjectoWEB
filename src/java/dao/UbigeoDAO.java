package dao;

import beans.Ubigeo;
import conexion.ConexionDB;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UbigeoDAO {

    // 1. Departamentos únicos (primeros 2 dígitos)
    public List<Ubigeo> listarDepartamentos() {
        List<Ubigeo> lista = new ArrayList<>();
        String sql = "SELECT DISTINCT SUBSTR(cod_ubigeo, 1, 2) AS cod, departamento " +
                     "FROM ubigeo ORDER BY departamento";

        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Ubigeo u = new Ubigeo();
                u.setCod_ubigeo(rs.getString("cod"));
                u.setDepartamento(rs.getString("departamento"));
                lista.add(u);
            }
        } catch (SQLException e) {
        }
        return lista;
    }

    // 2. Provincias según el prefijo de 2 dígitos del Departamento
    public List<Ubigeo> listarProvincias(String codDep) {
        List<Ubigeo> lista = new ArrayList<>();
        String sql = "SELECT DISTINCT SUBSTR(cod_ubigeo, 1, 4) AS cod, provincia " +
                     "FROM ubigeo WHERE cod_ubigeo LIKE ? ORDER BY provincia";

        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, codDep + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Ubigeo u = new Ubigeo();
                    u.setCod_ubigeo(rs.getString("cod"));
                    u.setProvincia(rs.getString("provincia"));
                    lista.add(u);
                }
            }
        } catch (SQLException e) {
        }
        return lista;
    }

    // 3. Distritos (incluye el cod_ubigeo completo de 6 dígitos)
    public List<Ubigeo> listarDistritos(String codProv) {
        List<Ubigeo> lista = new ArrayList<>();
        String sql = "SELECT cod_ubigeo, distrito FROM ubigeo " +
                     "WHERE cod_ubigeo LIKE ? ORDER BY distrito";

        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, codProv + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Ubigeo u = new Ubigeo();
                    u.setCod_ubigeo(rs.getString("cod_ubigeo"));
                    u.setDistrito(rs.getString("distrito"));
                    lista.add(u);
                }
            }
        } catch (SQLException e) {
         }
        return lista;
    }
}