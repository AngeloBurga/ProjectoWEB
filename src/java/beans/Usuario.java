package beans;

public class Usuario {

    private int cod_usuario;
    private String usuario;
    private String clave;

    public Usuario(int cod_usuario, String usuario, String clave) {
        this.cod_usuario = cod_usuario;
        this.usuario = usuario;
        this.clave = clave;
    }

    public Usuario() {
    }

    public int getCod_usuario() {
        return cod_usuario;
    }

    public void setCod_usuario(int cod_usuario) {
        this.cod_usuario = cod_usuario;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getClave() {
        return clave;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }

}
