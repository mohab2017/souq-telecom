/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Mohab
 */
public class login extends HttpServlet 
{
Connection connect;
String uname="";
String password="";
ServletContext servletcontext;
Statement stmt;
PreparedStatement prep;
ResultSet rs;
Boolean islogin=true;
String adminname="admin";
String adminpassword="admin";
  public void init()
  {
        servletcontext=this.getServletContext();
    try {
        Class.forName("org.postgresql.Driver");
    } catch (ClassNotFoundException ex) {
        Logger.getLogger(login.class.getName()).log(Level.SEVERE, null, ex);
    }
    try {
        connect=DriverManager.getConnection("jdbc:postgresql://localhost/souqdb", "postgres", "postgres");
    } catch (SQLException ex) {
        Logger.getLogger(login.class.getName()).log(Level.SEVERE, null, ex);
    }

  }
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException 
    {
       PrintWriter out = response.getWriter();
       response.setContentType("text/html;charset=UTF-8");
      
       uname = request.getParameter("uname");
       password = request.getParameter("password");
        System.out.println(uname+"  "+password);
       stmt=connect.createStatement();
       String queryString = new String("Select * from users");
       rs = stmt.executeQuery(queryString);
      boolean flag = false;
       while (rs.next()) 
       {
        
                
                if (rs.getString(1).equals(uname) && rs.getString(2).equals(password))
                {
                    System.out.println("trueeeeeee");
                flag=true;
                 Cookie userlog= new Cookie("islogin","true");
//                 userlog.setMaxAge(60*60*24*7);  
                 response.addCookie(userlog); 
                 Cookie username=new Cookie("uname",uname);
                response.addCookie(username);
                if (rs.getString(1).equals(adminname) && rs.getString(2).equals(adminpassword))
                {
                response.sendRedirect("adminpage.html");
                return;
                }else
                {
                    response.sendRedirect("MobileCategory.jsp");
                }
                }
       }
       if(!flag) 
       {
           response.sendRedirect("loginpage.html");
       }
//              else  {
//                response.sendRedirect("faild.html");
//                }
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
    try {
        processRequest(request, response);
    
    } catch (ClassNotFoundException ex) {
       ex.printStackTrace();
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
    }
//     @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
//    {
//    try {
//        processRequest(request, response);
//    } catch (ClassNotFoundException ex) {
//        Logger.getLogger(login.class.getName()).log(Level.SEVERE, null, ex);
//    } catch (SQLException ex) {
//        Logger.getLogger(login.class.getName()).log(Level.SEVERE, null, ex);
//    }
//    }
}