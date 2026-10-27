package com.smartpoweron.gestion_materiales.model;

import jakarta.persistence.*;

@Entity
@Table(name = "detalle_solicitud")
public class DetalleSolicitud {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_detalle")
    private Long idDetalle;

    @ManyToOne
    @JoinColumn(name = "id_solicitud", nullable = false)
    private SolicitudProduccion solicitudProduccion;

    @ManyToOne
    @JoinColumn(name = "id_material", nullable = false)
    private Material material;

    @Column(name = "cantidad_requerida", nullable = false)
    private Integer cantidadRequerida;

    public DetalleSolicitud() {}

    // Getters y Setters
    public Long getIdDetalle() { return idDetalle; }
    public void setIdDetalle(Long idDetalle) { this.idDetalle = idDetalle; }

    public SolicitudProduccion getSolicitudProduccion() { return solicitudProduccion; }
    public void setSolicitudProduccion(SolicitudProduccion solicitudProduccion) { this.solicitudProduccion = solicitudProduccion; }

    public Material getMaterial() { return material; }
    public void setMaterial(Material material) { this.material = material; }

    public Integer getCantidadRequerida() { return cantidadRequerida; }
    public void setCantidadRequerida(Integer cantidadRequerida) { this.cantidadRequerida = cantidadRequerida; }
}