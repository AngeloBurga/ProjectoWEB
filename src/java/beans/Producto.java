package beans;

import java.sql.Date;

public class Producto {

    private String cod_p;
    private String nombre;
    private Ubigeo ubigeo;
    private Almacen almacen;
    private String foto;
    private String estado;
    private Date fecha;
    private String pdf;

    public String getPdf() {
        return pdf;
    }

    public void setPdf(String pdf) {
        this.pdf = pdf;
    }
    
    public String getCod_p() {
        return cod_p;
    }

    public void setCod_p(String cod_p) {
        this.cod_p = cod_p;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Ubigeo getUbigeo() {
        return ubigeo;
    }

    public void setUbigeo(Ubigeo ubigeo) {
        this.ubigeo = ubigeo;
    }

    public Almacen getAlmacen() {
        return almacen;
    }

    public void setAlmacen(Almacen almacen) {
        this.almacen = almacen;
    }


    public String getFoto() {
        return foto;
    }

    public void setFoto(String foto) {
        this.foto = foto;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    @Override
    public String toString() {
        return "Producto{" + "cod_p=" + cod_p + ", nombre=" + nombre + ", ubigeo=" + ubigeo + ", almacen=" + almacen + ", foto=" + foto + ", estado=" + estado + ", fecha=" + fecha + ", pdf=" + pdf + '}';
    }
    
}
