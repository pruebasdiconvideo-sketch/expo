package com.smartpoweron.gestion_materiales.controller;

import com.smartpoweron.gestion_materiales.model.SolicitudProduccion;
import com.smartpoweron.gestion_materiales.service.MaterialService;
import com.smartpoweron.gestion_materiales.service.ProduccionService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class ProduccionController {

    @Autowired
    private ProduccionService produccionService;

    @Autowired
    private MaterialService materialService;

    @GetMapping("/produccion/ver")
    public String consultarProyectos(Model model) {
        model.addAttribute("solicitudes", produccionService.listarSolicitudes());
        model.addAttribute("materiales", materialService.listarMateriales());
        model.addAttribute("nuevaSolicitud", new SolicitudProduccion());
        return "produccion/proyectos";
    }

    @PostMapping("/produccion/guardar")
    public String guardarSolicitud(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        String codigoProyecto = request.getParameter("codigoProyecto");
        String[] idsMaterialesArr = request.getParameterValues("idsMateriales");
        String[] cantidadesArr = request.getParameterValues("cantidades");

        System.out.println("--- INTENTO DE REGISTRO ---");
        System.out.println("Proyecto: " + codigoProyecto);
        if (idsMaterialesArr != null) {
            for (String id : idsMaterialesArr) {
                System.out.println("ID Material recibido: " + id);
            }
        }

        try {
            produccionService.registrarSolicitudConArreglos(codigoProyecto, idsMaterialesArr, cantidadesArr);
            redirectAttributes.addFlashAttribute("successMessage", "¡Solicitud de producción registrada con éxito!");
        } catch (Exception e) {
            System.err.println("ERROR AL GUARDAR SOLICITUD:");
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Error al guardar: " + e.getMessage());
        }

        return "redirect:/produccion/ver";
    }

    @PostMapping("/produccion/aprobar")
    public String aprobarSolicitud(@RequestParam Long idSolicitud, RedirectAttributes redirectAttributes) {
        try {
            produccionService.aprobarSolicitudYDescontarStock(idSolicitud);
            redirectAttributes.addFlashAttribute("successMessage", "¡Solicitud aprobada y stock descontado!");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error al aprobar: " + e.getMessage());
        }
        return "redirect:/produccion/ver";
    }
}