package com.smartpoweron.gestion_materiales.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .csrf(csrf -> csrf.disable()) // Deshabilita CSRF para evitar bloqueos en formularios locales
            .authorizeHttpRequests(auth -> auth
                .requestMatchers("/css/**", "/js/**", "/images/**").permitAll()
                
                // Permitir que cualquier usuario autenticado pueda ver (GET) las vistas
                .requestMatchers(HttpMethod.GET, "/home", "/almacen/ver", "/produccion/ver").authenticated()
                
                // Permitir acciones (POST) de guardado y aprobación
                .requestMatchers(HttpMethod.POST, "/almacen/guardar").hasAnyRole("ALMACENERO", "ADMINISTRADOR")
                .requestMatchers(HttpMethod.POST, "/produccion/guardar", "/produccion/aprobar").hasAnyRole("PRODUCCION", "ALMACENERO", "ADMINISTRADOR")
                
                .anyRequest().authenticated()
            )
            .formLogin(form -> form
                .defaultSuccessUrl("/home", true)
                .permitAll()
            )
            .logout(logout -> logout.permitAll());

        return http.build();
    }

    @Bean
    public UserDetailsService userDetailsService() {
        UserDetails almacenero = User.withDefaultPasswordEncoder()
            .username("almacen")
            .password("1234")
            .roles("ALMACENERO")
            .build();

        UserDetails produccion = User.withDefaultPasswordEncoder()
            .username("produccion")
            .password("1234")
            .roles("PRODUCCION")
            .build();

        UserDetails calidad = User.withDefaultPasswordEncoder()
            .username("calidad")
            .password("1234")
            .roles("CALIDAD")
            .build();

        UserDetails tecnico = User.withDefaultPasswordEncoder()
            .username("tecnico")
            .password("1234")
            .roles("TECNICO")
            .build();

        return new InMemoryUserDetailsManager(almacenero, produccion, calidad, tecnico);
    }
}