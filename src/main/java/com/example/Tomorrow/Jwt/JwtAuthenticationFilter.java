package com.example.Tomorrow.Jwt;

import com.example.Tomorrow.Service.CookieUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import org.h2.util.json.JSONObject;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import org.springframework.web.filter.GenericFilterBean;
import org.springframework.web.filter.OncePerRequestFilter;


import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;

@RequiredArgsConstructor
@Slf4j

//처츰으로 지나가는 Filter
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final JwtProvider jwtProvider;
    private final CookieUtil cookieUtil;

    //1번 필터
    @Override
    protected void doFilterInternal(HttpServletRequest req, HttpServletResponse res, FilterChain filterChain) throws ServletException, IOException {

        String token = null;
        Authentication authenticate;
        //사용자의 principal과 credential 정보를 Authentication에 담는다

        Cookie accessTokenCookie = cookieUtil.getCookie(req,"access_token");

        //Cookies이름 추출

        if (accessTokenCookie != null) {
            token = accessTokenCookie.getValue();
        }
        else if(token != null && jwtProvider.isTokenExpired(token)){
            Cookie refreshTokenCookie = cookieUtil.getCookie(req,"refresh_token");
            try {
                token = refreshTokenCookie.getValue();

                String memberIdToken = jwtProvider.getMemberIdFromToken(token);
                authenticate = jwtProvider
                        .authenticate(new UsernamePasswordAuthenticationToken(memberIdToken, ""));
                HashMap<String, String> m = new HashMap<>();
                m.put("memberId", memberIdToken);
                final String token2 = jwtProvider.generateToken(m); //Access토큰 생성
                final String refreshJwt = jwtProvider.generateRefreshToken(m); //Refresh Token 생성
                Cookie accessToken = cookieUtil.createCookie("access_token", token2);//쿠키 생성
                Cookie refreshToken = cookieUtil.createCookie("refresh_token", refreshJwt);
                token = accessToken.getValue();
            }catch(Exception e){

                res.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                res.setContentType("application/json");
                res.setCharacterEncoding("UTF-8");

                JSONObject resJson = new JSONObject();
                try {
                    resJson.put("code", 401);
                } catch (JSONException ex) {
                    throw new RuntimeException(ex);
                }
                try {
                    resJson.put("message", e.getMessage());
                } catch (JSONException ex) {
                    throw new RuntimeException(ex);
                }

                res.getWriter().write(resJson.toString());
            }
        }
        if(token != null && !jwtProvider.isTokenExpired(token)) {
            try {
                String memberIdToken = jwtProvider.getMemberIdFromToken(token);

                authenticate = jwtProvider
                        .authenticate(new UsernamePasswordAuthenticationToken(memberIdToken, ""));

                SecurityContextHolder.getContext().setAuthentication(authenticate);
                System.out.println(authenticate);
                res.setStatus(HttpServletResponse.SC_OK);
                res.setContentType("application/json");
                res.setCharacterEncoding("UTF-8");

                JSONObject resJson = new JSONObject();
                resJson.put("code", 200);
                resJson.put("message", 1);


            } catch(Exception e) {
                res.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                res.setContentType("application/json");
                res.setCharacterEncoding("UTF-8");

                JSONObject resJson = new JSONObject();
                try {
                    resJson.put("code", 401);
                } catch (JSONException ex) {
                    throw new RuntimeException(ex);
                }
                try {
                    resJson.put("message", e.getMessage());
                } catch (JSONException ex) {
                    throw new RuntimeException(ex);
                }

                res.getWriter().write(resJson.toString());
            }
        }


        chain.doFilter(request, response);
    }


}