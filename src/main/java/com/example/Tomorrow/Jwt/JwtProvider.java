package com.example.Tomorrow.Jwt;


import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.Map;

@Component
@RequiredArgsConstructor
@Slf4j
public class JwtProvider implements AuthenticationProvider {

    private final MyUserDetailsService userDetailsService;

    public static final long TOKEN_VALIDATION_SECOND = 1000L * 60 * 60 * 48;
    public static final long REFRESH_TOKEN_VALIDATION_TIME = 1000L * 60 * 60 * 48;


    @Value("${spring:jwt:secret}")
    private String SECRET_KEY;

    @Value("${group:name}")
    private String ISSUER;

    private Algorithm getSigningKey(String secretKey) {
        return Algorithm.HMAC256(secretKey);
    }

    private Map<String, Claim> getAllClaims(DecodedJWT token) {
        return token.getClaims();
    }

    public String getMemberIdFromToken(String token) {
        DecodedJWT verifiedToken = validateToken(token);
        return verifiedToken.getClaim("memberId").asString();

    }

    private JWTVerifier getTokenValidator() {
        return JWT.require(getSigningKey(SECRET_KEY))
                .withIssuer(ISSUER)
                .build();
    }

    public String generateToken(Map<String, String> payload) {

        return doGenerateToken(TOKEN_VALIDATION_SECOND, payload);
    }

    public String generateRefreshToken(Map<String, String> payload) {
        return doGenerateToken(REFRESH_TOKEN_VALIDATION_TIME, payload);
    }

    private String doGenerateToken(long expireTime, Map<String, String> payload) {

        return JWT.create()
                .withIssuedAt(new Date(System.currentTimeMillis()))
                .withExpiresAt(new Date(System.currentTimeMillis() + expireTime))
                .withPayload(payload)
                .withIssuer(ISSUER)
                .sign(getSigningKey(SECRET_KEY));
    }

    private DecodedJWT validateToken(String token) throws JWTVerificationException {
        JWTVerifier validator = getTokenValidator();
        return validator.verify(token);
    }

    public boolean isTokenExpired(String token) {
        try {
            DecodedJWT decodedJWT = validateToken(token);
            return false;
        } catch (JWTVerificationException e) {
            return true;
        }
    }



    //UsernamePassword찾는 곳
    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        MyDetails userDetails = (MyDetails) userDetailsService.loadUserByUsername
                ((String) authentication.getPrincipal());


        return new UsernamePasswordAuthenticationToken(
                userDetails.getMemberId(),
                userDetails.getPassword(),
                userDetails.getAuthorities()); //권한
    }

    @Override
    public boolean supports(Class<?> authentication) {
        return false;
    }


}