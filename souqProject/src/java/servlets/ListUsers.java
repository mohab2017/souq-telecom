/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import classes.admin;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ahmed
 */
public class ListUsers extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {
            admin admin1 = new admin();
            ResultSet res = admin1.selectAllUsers();
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet NewServlet</title>");            
            out.print("		<link rel=\"stylesheet\" href=\"ListUsers.css\">\n");
            out.println("</head>");
            out.println("<body>");
            while (res.next()) {
                //out.print("<div class=\"container\">");
                out.print("<table class='table'>");
                out.print(" <form action='UpdateBalanc?name=" + res.getString(1) + "' method='POST'>");
                out.print("<tr>");                
                out.print("<p>"+"<td>" + res.getString(1)+"</td>");
                out.print("<td>"+"<input type='submit' value='Edit'/>"+"</td>");
                out.print("<td>"+"<input type='submit' formaction='DeleteUser?name=" +res.getString(1)+ "' value='Delete'/>"+"</td>"+"</p>");
                out.println("</form>");
                out.print("</table>");
              //  out.print("</div>");
            }
            out.println("</body>");
            out.println("</html>");            
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ListUsers.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(ListUsers.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
