/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Filters;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author pc
 */
public class Filter1 implements Filter {
    
    public void doFilter(ServletRequest request,ServletResponse response,FilterChain chain) throws IOException, ServletException {
        
        Cookie[] cookies=((HttpServletRequest)request).getCookies();
        if(cookies!=null){
            for(Cookie cookie:cookies)
            {
                if(cookie.getName().equals("IsLogged"))
                {
                   String s= cookie.getValue();
                    if(s.equals("true")) {
                        ((HttpServletResponse)response).sendRedirect("MobileCategory");
                    }
                }
            }
        
 
        }else
        {
            chain.doFilter(request, response);
        }
       
        
    
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
//        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void destroy() {
//        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
   
    
}
