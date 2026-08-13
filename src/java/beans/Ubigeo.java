package beans;

public class Ubigeo {

    private String cod_ubigeo;
    private String departamento;
    private String provincia;
    private String distrito;

    public Ubigeo(String cod_ubigeo, String departamento, String provincia, String distrito) {
        this.cod_ubigeo = cod_ubigeo;
        this.departamento = departamento;
        this.provincia = provincia;
        this.distrito = distrito;
    }

    public Ubigeo() {
    }

    public String getCod_ubigeo() {
        return cod_ubigeo;
    }

    public void setCod_ubigeo(String cod_ubigeo) {
        this.cod_ubigeo = cod_ubigeo;
    }

    public String getDepartamento() {
        return departamento;
    }

    public void setDepartamento(String departamento) {
        this.departamento = departamento;
    }

    public String getProvincia() {
        return provincia;
    }

    public void setProvincia(String provincia) {
        this.provincia = provincia;
    }

    public String getDistrito() {
        return distrito;
    }

    public void setDistrito(String distrito) {
        this.distrito = distrito;
    }

}
