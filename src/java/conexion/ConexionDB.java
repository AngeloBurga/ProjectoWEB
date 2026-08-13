package conexion;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionDB {

    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String URL = "jdbc:mysql://localhost:3306/bd_almacen";
    private static final String USER = "root";
    private static final String PASSWORD = "Angelo123$.";

    public static Connection getConexion() {
        Connection cn = null;
        try {

            Class.forName(DRIVER);
            cn = DriverManager.getConnection(URL, USER, PASSWORD);

        } catch (ClassNotFoundException e) {
            System.out.println("Error: No se encontró el Driver de MySQL -> " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("Error: Falló la conexión a la base de datos -> " + e.getMessage());
        }
        return cn;
    }
}
