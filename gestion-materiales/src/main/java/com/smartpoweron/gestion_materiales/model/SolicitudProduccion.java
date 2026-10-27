package com.smartpoweron.gestion_materiales.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "solicitud_produccion")
public class SolicitudProduccion {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_solicitud")
    private Long idSolicitud;

    @Column(name = "codigo_proyecto", nullable = false, length = 50)
    private String codigoProyecto;

    @Column(length = 50)
    private String estado;

    @Column(name = "fecha_registro")
    private LocalDateTime fechaRegistro = LocalDateTime.now();

    @OneToMany(mappedBy = "solicitudProduccion", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<DetalleSolicitud> detalles;

    public SolicitudProduccion() {
        this.estado = "PENDIENTE";
    }

    // Getters y Setters
    public Long getIdSolicitud() { return idSolicitud; }
    public void setIdSolicitud(Long idSolicitud) { this.idSolicitud = idSolicitud; }
    public String getCodigoProyecto() { return codigoProyecto; }
    public void setCodigoProyecto(String codigoProyecto) { this.codigoProyecto = codigoProyecto; }
    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
    public LocalDateTime getFechaRegistro() { return fechaRegistro; }
    public void setFechaRegistro(LocalDateTime fechaRegistro) { this.fechaRegistro = fechaRegistro; }
    public List<DetalleSolicitud> getDetalles() { return detalles; }
    public void setDetalles(List<DetalleSolicitud> detalles) { this.detalles = detalles; }
}