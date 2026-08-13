package dao;

import beans.Almacen;
import conexion.ConexionDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AlmacenDAO {

    public List<Almacen> cargarAlmacen() {
        String query = "SELECT*FROM almacen";
        List<Almacen> almacenes = new ArrayList<>();
        try {

            Connection conn = ConexionDB.getConexion();
            PreparedStatement ps = conn.prepareCall(query);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()){
                Almacen alm = new Almacen();
                alm.setCod_almacen(rs.getString("cod_almacen"));
                alm.setAlmacen(rs.getString("almacen"));
                almacenes.add(alm);
            }
            
            
        } catch (SQLException ex) {
            Logger.getLogger(AlmacenDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return almacenes;
    }
}
