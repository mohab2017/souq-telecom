/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ahmed
 */
public class SignUp extends HttpServlet {

    Connection connect;
    String uname = "";
    String password = "";
    String birthday = "";
    String name = "";
    String jop = "";
    String email = "";
    String address = "";
    String interests = "";

    Statement stmt;
    PreparedStatement prep;
    ResultSet rs;
    Boolean islogin = true;

    public void init() {

        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(login.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {
            connect = DriverManager.getConnection("jdbc:postgresql://localhost/souqdb", "postgres", "postgres");
        } catch (SQLException ex) {
            Logger.getLogger(login.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
  }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        uname = request.getParameter("uname");
        password = request.getParameter("password");
        name = request.getParameter("name");
        birthday = request.getParameter("birthday");
        email = request.getParameter("email");
        jop = request.getParameter("jop");
        address = request.getParameter("address");
        interests = request.getParameter("interests");
        try {

            stmt = connect.createStatement();
            String queryString = new String("Select * from users;");
            rs = stmt.executeQuery(queryString);
            boolean flag = true;
            while (rs.next()) {

                if (rs.getString(1).equals(uname)) {
                    flag = false;
                    out.println("This User Name is exist, please enter another one");

                }
            }
            if (flag) {
                 queryString = new String("Insert into users values(?,?,?,?,?,?,?,?,?);");
                 
                 prep=connect.prepareStatement(queryString);
                 prep.setString(1,uname);
                 prep.setString(2,password);
                 prep.setFloat(3,10000);
                 prep.setString(4,name);
                 prep.setString(5, birthday);
                 prep.setString(6,email);
                 prep.setString(7,jop);
                 prep.setString(8,address);
                  prep.setString(9,interests);
                 boolean insert= prep.execute();
                // out.print("insert");
               
                 Cookie pwdcookie = new Cookie("uname",uname);
                 response.addCookie(pwdcookie);
                  Cookie c = new Cookie("islogin","true");
                 response.addCookie(c);
                 response.sendRedirect("MobileCategory.jsp");
                 
                 
                 
                 

            }
        } catch (SQLException ex) {
            Logger.getLogger(SignUp.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
