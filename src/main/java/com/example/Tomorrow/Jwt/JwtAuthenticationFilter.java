package com.example.Tomorrow.Jwt;

import com.example.Tomorrow.BasicResponse;
import com.example.Tomorrow.Service.CookieUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


import org.json.JSONException;
import org.json.simple.JSONObject;
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

        String accessToken = null;
        String refreshToken = null;
        Authentication authenticate;
        //사용자의 principal과 credential 정보를 Authentication에 담는다

        accessToken =  req.getHeader("accessToken");

        if(accessToken==null || jwtProvider.isTokenExpired(accessToken)) {  //유효기간 만료 또는 토큰 없을시

            Cookie RefreshTokenCookie = cookieUtil.getCookie(req, "RefreshToken");
            refreshToken = RefreshTokenCookie.getValue(); //RefreshToken 쿠키에서 가져오기

            if(refreshToken!=null || !jwtProvider.isTokenExpired(refreshToken)) {

                String memberId = jwtProvider.getMemberIdFromToken(refreshToken);
                // RefreshToken에 저장된 Token을 Decode해서 Id값을 가져온다
                try {
                    authenticate = jwtProvider
                            .authenticate(new UsernamePasswordAuthenticationToken(memberId, ""));
                    //UsernamePasswordAuthenticationToken은 추후 인증이 끝나고
                    //SecurityContextHolder.getContext()에 등록될 Authentication객체
                    //MyUserDetailsService의  loadUserByUsername()로 이동
                    // Details이동후 Authenticate객체 생성! (id, pw, 권한)

                    SecurityContextHolder.getContext().setAuthentication(authenticate);
                    //ID, PW가 존재하는 계정이면 Holder에 객체 저장

                    HashMap<String, String> m = new HashMap<>();
                    m.put("memberId", memberId);    //RefreshToken에 저장된 Id를 가져온다

                    accessToken = jwtProvider.generateToken(m);   //accessToken 재발급
                    res.addHeader("accessToken", accessToken);
                } catch (Exception e) {
                    throw new RuntimeException(e.getMessage());
                }

            }
            else if(refreshToken==null || jwtProvider.isTokenExpired(refreshToken)) {   //토큰 유효기간 끝

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
                    resJson.put("message", "쿠키만료");
                } catch (JSONException ex) {
                    throw new RuntimeException(ex);
                }

                res.getWriter().write(resJson.toString());
            }
        }
        else if(accessToken!=null && !jwtProvider.isTokenExpired(accessToken)){
            String memberId = jwtProvider.getMemberIdFromToken(accessToken);
            try {
                authenticate = jwtProvider
                        .authenticate(new UsernamePasswordAuthenticationToken(memberId, ""));
                //UsernamePasswordAuthenticationToken은 추후 인증이 끝나고
                //SecurityContextHolder.getContext()에 등록될 Authentication객체
                //MyUserDetailsService의  loadUserByUsername()로 이동
                // Details이동후 Authenticate객체 생성! (id, pw, 권한)

                SecurityContextHolder.getContext().setAuthentication(authenticate);
                //ID, PW가 존재하는 계정이면 Holder에 객체 저장

            } catch (Exception e) {
                throw new RuntimeException(e.getMessage());
            }
        }

        filterChain.doFilter(req, res);

    }
}