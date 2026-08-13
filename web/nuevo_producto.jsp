<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="beans.Almacen"%>
<%@page import="beans.Ubigeo"%>

<style>
    /* Contenedor del Formulario */
    .registro-container {
        width: auto;
        margin: 0 auto;
        background: #ffffff;
        overflow: hidden;
        border: none;
        animation: fadeInForm 0.4s ease-out;
    }

    @keyframes fadeInForm {
        from {
            opacity: 0;
            transform: translateY(15px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    /* Cabecera de la Sección */
    .registro-header {
        padding: 15px 0px 5px 20px;
        color: black;
    }

    .registro-header h2 {
        margin: 0;
        font-size: 22px;
        font-weight: 600;
        letter-spacing: 0.5px;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    /* Cuerpo del Formulario */
    .registro-body {
        margin: 0px;
        padding: 20px;
    }

    /* Estructura en Rejilla (Grid) */
    .form-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 25px;
        margin-bottom: 25px;
    }

    @media (max-width: 768px) {
        .form-grid {
            grid-template-columns: 1fr;
            gap: 15px;
        }
    }

    /* Campos del Formulario */
    .form-group {
        display: flex;
        flex-direction: column;
        gap: 8px;
    }

    .form-group.full-width {
        grid-column: span 2;
    }

    @media (max-width: 768px) {
        .form-group.full-width {
            grid-column: span 1;
        }
    }

    .form-group label {
        font-size: 13px;
        font-weight: 600;
        color: #34495e;
        letter-spacing: 0.3px;
    }

    .form-group label span {
        color: #e74c3c;
    }

    .form-control {
        width: 100%;
        padding: 12px 16px;
        border: 1.5px solid #cbd5e1;
        border-radius: 8px;
        font-size: 14px;
        color: #334155;
        background-color: #f8fafc;
        transition: all 0.3s ease;
        box-sizing: border-box;
    }

    .form-control:focus {
        outline: none;
        border-color: #3498db;
        background-color: #ffffff;
        box-shadow: 0 0 0 4px rgba(52, 152, 219, 0.15);
    }

    .form-control::placeholder {
        color: #94a3b8;
    }

    /* Personalización de inputs de tipo FILE */
    .file-upload-wrapper {
        position: relative;
        border: 2px dashed #cbd5e1;
        border-radius: 8px;
        padding: 20px;
        text-align: center;
        background-color: #f8fafc;
        cursor: pointer;
        transition: all 0.3s ease;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        gap: 10px;
        min-height: 110px;
    }

    .file-upload-wrapper:hover {
        border-color: #3498db;
        background-color: #f0f9ff;
    }

    .file-upload-wrapper input[type="file"] {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        opacity: 0;
        cursor: pointer;
    }

    .file-upload-icon {
        font-size: 24px;
        color: #64748b;
    }

    .file-upload-wrapper:hover .file-upload-icon {
        color: #3498db;
    }

    .file-upload-text {
        font-size: 13px;
        color: #64748b;
        font-weight: 500;
    }

    .file-name-preview {
        font-size: 12px;
        color: #2ecc71;
        font-weight: 600;
        word-break: break-all;
        margin-top: 5px;
    }

    /* Contenedor de Botones de Acción */
    .form-actions {
        display: flex;
        justify-content: flex-end;
        align-items: center;
        gap: 15px;
        padding-top: 25px;
        border-top: 1px solid #e2e8f0;
        margin-top: 15px;
    }

    .btn {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        padding: 12px 24px;
        border-radius: 8px;
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.2s ease;
        border: none;
        text-decoration: none;
    }

    .btn-cancel {
        background-color: #e2e8f0;
        color: #475569;
    }

    .btn-cancel:hover {
        background-color: #cbd5e1;
        color: #1e293b;
    }

    .btn-submit {
        background-color: #2ecc71;
        color: #ffffff;
        box-shadow: 0 4px 6px -1px rgba(46, 204, 113, 0.2);
    }

    .btn-submit:hover {
        background-color: #27ae60;
        transform: translateY(-1px);
        box-shadow: 0 6px 12px -1px rgba(46, 204, 113, 0.3);
    }

    .btn-submit:active {
        transform: translateY(0);
    }

    /* Mensajes de Validación Frontend */
    .validation-error {
        font-size: 12px;
        color: #e74c3c;
        font-weight: 500;
        margin-top: 4px;
        display: none;
    }
</style>

<div class="registro-container">
    <div class="registro-header">
        <h2>📦 Registro de Productos</h2>
    </div>

    <div class="registro-body">
        <form action="ProductoServlet" method="POST">
            <input type="hidden" name="action" value="insert">

            <div class="form-grid">

                <!-- Código del Producto -->
                <div class="form-group">
                    <label for="txtCodigo">Código de Producto <span>*</span></label>
                    <input type="text" 
                           id="txtCodigo" 
                           name="txtCodigo" 
                           class="form-control" 
                           placeholder="Ej: PRD-1024" 
                           maxlength="10"
                           >
                    <div id="error-codigo" class="validation-error">El código es requerido (máx. 10 caracteres).</div>
                </div>

                <!-- Nombre del Producto -->
                <div class="form-group">
                    <label for="txtNombre">Nombre del Producto <span>*</span></label>
                    <input type="text" 
                           id="txtNombre" 
                           name="txtNombre" 
                           class="form-control" 
                           placeholder="Ej: Microcontrolador ATmega328P" 
                           >
                    <div id="error-nombre" class="validation-error">El nombre comercial es obligatorio.</div>
                </div>

                <!-- Selector de Almacén (cod_ubigeo en el Bean de la base de datos) -->
                <div class="form-group">
                    <label for="cmbAlmacen">Almacén Destino <span>*</span></label>
                    <select id="cmbAlmacen" name="cmbAlmacen" class="form-control" required>
                    </select>
                </div>

                <!-- Selector de Ubigeo (cod_almacen en el Bean de la base de datos) -->
                <div class="form-group">
                    <label>Departamento <span>*</span></label>
                    <select id="cmbDepartamento" name="cmbDepartamento" class="form-control"  onchange="cargarProvincias()">
                        <option value="">-- Seleccionar Ubicación --</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Provincia <span>*</span></label>
                    <select id="cmbProvincia" name="cmbProvincia" class="form-control" onchange="cargarDistritos()">
                        <option value="">Seleccione...</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Distrito <span>*</span></label>
                    <select id="cmbDistrito" name="cmbDistrito" class="form-control" >
                        <option value="">Seleccione...</option>
                    </select>
                </div>
                <!-- Carga de Foto de Producto -->
                <div class="form-group">
                    <label>Fotografía Ilustrativa</label>
                    <div class="file-upload-wrapper">
                        <span class="file-upload-icon">📷</span>
                        <span class="file-upload-text">Arrastra o haz clic para subir imagen</span>
                        <input type="file" id="fileFoto" name="fileFoto" accept="image/*" >
                        <div id="preview-foto" class="file-name-preview"></div>
                    </div>
                </div>

                <!-- Carga de Ficha Técnica PDF -->
                <div class="form-group">
                    <label>Ficha Técnica Certificada (PDF)</label>
                    <div class="file-upload-wrapper">
                        <span class="file-upload-icon">📄</span>
                        <span class="file-upload-text">Arrastra o haz clic para subir el PDF</span>
                        <input type="file" id="filePdf" name="filePdf" accept=".pdf" >
                        <div id="preview-pdf" class="file-name-preview"></div>
                    </div>
                </div>

                <!-- Estado del Producto -->
                <div class="form-group" style="grid-column: span 2;">
                    <label>Estado Inicial de Disponibilidad</label>
                    <select id="cmbEstado" name="cmbEstado" class="form-control">
                        <option value="Activo">Activo (Habilitado para Despacho)</option>
                        <option value="Inactivo">Inactivo (En Espera / Bloqueado)</option>
                    </select>
                </div>

            </div>

            <!-- Botones de Acción -->
            <div class="form-actions">
                <a href="menu.jsp?sec=productos" class="btn btn-cancel">Cancelar</a>
                <button type="submit" class="btn btn-submit">Guardar Cambios</button>
            </div>

        </form>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", () => {
        cargarDepartamentos(), cargarAlmacen();
    });

    function cargarAlmacen() {
        const selectAlmacen = document.getElementById("cmbAlmacen");
        fetch("AlmacenServlet")
                .then(response => {
                    return response.json();
                })
                .then(almacenes => {
                    almacenes.forEach(alm => {
                        const option = document.createElement("option");
                        option.value = alm.cod_almacen;
                        option.textContent = alm.almacen;
                        selectAlmacen.appendChild(option);
                    });
                });
    }

    function cargarDepartamentos() {
        fetch('ubigeo?accion=departamentos')
                .then(res => res.json())
                .then(data => {
                    const depSelect = document.getElementById("cmbDepartamento");
                    data.forEach(item => {
                        depSelect.innerHTML += `<option value="` + item.cod_ubigeo + `">` + item.departamento + `</option>`;
                    });
                });
    }

    function cargarProvincias() {
        const codDep = document.getElementById("cmbDepartamento").value;
        const provSelect = document.getElementById("cmbProvincia");
        const distSelect = document.getElementById("cmbDistrito");

        provSelect.innerHTML = '<option value="">Seleccione...</option>';
        distSelect.innerHTML = '<option value="">Seleccione...</option>';
        distSelect.disabled = true;

        if (!codDep) {
            provSelect.disabled = true;
            return;
        }

        fetch(`ubigeo?accion=provincias&codDep=` + codDep)
                .then(res => res.json())
                .then(data => {
                    data.forEach(item => {
                        provSelect.innerHTML += `<option value="` + item.cod_ubigeo + `">` + item.provincia + `</option>`;
                    });
                    provSelect.disabled = false;
                });
    }

    function cargarDistritos() {
        const codProv = document.getElementById("cmbProvincia").value;
        const distSelect = document.getElementById("cmbDistrito");

        distSelect.innerHTML = '<option value="">Seleccione...</option>';

        if (!codProv) {
            distSelect.disabled = true;
            return;
        }

        fetch(`ubigeo?accion=distritos&codProv=` + codProv)
                .then(res => res.json())
                .then(data => {
                    data.forEach(item => {
                        distSelect.innerHTML += `<option value="` + item.cod_ubigeo + `">` + item.distrito + `</option>`;

                    });
                    distSelect.disabled = false;
                });
    }
</script>