package com.example.Tomorrow.Config;

import com.example.Tomorrow.Jwt.JwtAuthenticationFilter;
import com.example.Tomorrow.Jwt.JwtProvider;
import com.example.Tomorrow.Service.CookieUtil;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
public class SecurityConfigure {

    @Bean
    PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    JwtAuthenticationFilter jwtAuthenticationFilter(JwtProvider jwtProvider, CookieUtil cookieUtil) {
        return new JwtAuthenticationFilter(jwtProvider, cookieUtil);
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http,
                                           JwtProvider jwtProvider,
                                           CookieUtil cookieUtil) throws Exception {
        return http
                .httpBasic().disable()
                .csrf().disable()
                .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                .and()
                .authorizeRequests()
                .antMatchers("/api/member/**").permitAll()
                .antMatchers("/test").permitAll()
                .antMatchers("/api/member/login").hasAuthority("[ROLE_USER]")

                .and()
                .addFilterBefore(jwtAuthenticationFilter(jwtProvider, cookieUtil),
                        UsernamePasswordAuthenticationFilter.class)
                .build();
    }
}