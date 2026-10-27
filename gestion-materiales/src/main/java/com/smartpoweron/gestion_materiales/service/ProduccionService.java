package com.smartpoweron.gestion_materiales.service;

import com.smartpoweron.gestion_materiales.model.DetalleSolicitud;
import com.smartpoweron.gestion_materiales.model.Material;
import com.smartpoweron.gestion_materiales.model.SolicitudProduccion;
import com.smartpoweron.gestion_materiales.repository.MaterialRepository;
import com.smartpoweron.gestion_materiales.repository.SolicitudProduccionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
public class ProduccionService {

    @Autowired
    private SolicitudProduccionRepository solicitudRepository;

    @Autowired
    private MaterialRepository materialRepository;

    public List<SolicitudProduccion> listarSolicitudes() {
        return solicitudRepository.findAll();
    }

    @Transactional
    public void registrarSolicitudConArreglos(String codigoProyecto, String[] idsMaterialesArr, String[] cantidadesArr) {
        if (codigoProyecto == null || codigoProyecto.trim().isEmpty() || codigoProyecto.startsWith("Ej:")) {
            throw new IllegalArgumentException("El código del proyecto es obligatorio.");
        }

        System.out.println("==================================================");
        System.out.println("PROCESANDO PROYECTO: " + codigoProyecto);

        SolicitudProduccion solicitud = new SolicitudProduccion();
        solicitud.setCodigoProyecto(codigoProyecto.trim());
        solicitud.setEstado("PENDIENTE");
        solicitud.setFechaRegistro(LocalDateTime.now());

        List<DetalleSolicitud> detalles = new ArrayList<>();

        if (idsMaterialesArr != null) {
            for (int i = 0; i < idsMaterialesArr.length; i++) {
                String idStr = idsMaterialesArr[i];
                if (idStr != null && !idStr.trim().isEmpty() && !idStr.equals("null")) {
                    Long idMaterial = Long.valueOf(idStr.trim());

                    // Leer y asegurar la cantidad con valor por defecto de 1
                    int cantidadFinal = 1;
                    if (cantidadesArr != null && i < cantidadesArr.length && cantidadesArr[i] != null && !cantidadesArr[i].trim().isEmpty()) {
                        try {
                            cantidadFinal = Integer.parseInt(cantidadesArr[i].trim());
                        } catch (NumberFormatException e) {
                            cantidadFinal = 1;
                        }
                    }

                    System.out.println(" > Material ID: " + idMaterial + " | Cantidad leída: " + cantidadFinal);

                    Material material = materialRepository.findById(idMaterial).orElse(null);
                    if (material != null) {
                        DetalleSolicitud detalle = new DetalleSolicitud();
                        detalle.setMaterial(material);
                        detalle.setCantidadRequerida(cantidadFinal); // Asignación explícita garantizada
                        detalle.setSolicitudProduccion(solicitud);
                        detalles.add(detalle);
                    }
                }
            }
        }

        if (detalles.isEmpty()) {
            throw new RuntimeException("Debe seleccionar al menos un material válido.");
        }

        solicitud.setDetalles(detalles);
        solicitudRepository.save(solicitud);
        System.out.println("¡SOLICITUD GUARDADA CORRECTAMENTE EN LA BD!");
        System.out.println("==================================================");
    }

    @Transactional
    public void aprobarSolicitudYDescontarStock(Long idSolicitud) {
        SolicitudProduccion solicitud = solicitudRepository.findById(idSolicitud)
                .orElseThrow(() -> new RuntimeException("Solicitud no encontrada"));

        if (!"PENDIENTE".equals(solicitud.getEstado())) {
            throw new RuntimeException("La solicitud ya fue procesada.");
        }

        for (DetalleSolicitud detalle : solicitud.getDetalles()) {
            Material material = detalle.getMaterial();
            int cantidadPedida = detalle.getCantidadRequerida();

            if (material.getStockActual() < cantidadPedida) {
                throw new RuntimeException("Stock insuficiente para: " + material.getNombre());
            }

            material.setStockActual(material.getStockActual() - cantidadPedida);
            materialRepository.save(material);
        }

        solicitud.setEstado("APROBADO");
        solicitudRepository.save(solicitud);
    }
}