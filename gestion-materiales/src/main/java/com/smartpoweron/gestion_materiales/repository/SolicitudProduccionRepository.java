package com.smartpoweron.gestion_materiales.repository;

import com.smartpoweron.gestion_materiales.model.SolicitudProduccion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SolicitudProduccionRepository extends JpaRepository<SolicitudProduccion, Long> {
    List<SolicitudProduccion> findByCodigoProyecto(String codigoProyecto);
}