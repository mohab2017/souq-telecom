///*
// * To change this license header, choose License Headers in Project Properties.
// * To change this template file, choose Tools | Templates
// * and open the template in the editor.
// */
//package servlets;
//
//import classes.admin;
//import java.io.IOException;
//import java.io.PrintWriter;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.util.logging.Level;
//import java.util.logging.Logger;
//import javax.servlet.ServletException;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
///**
// *
// * @author ahmed
// */
//public class UpdateBalanc extends HttpServlet {
//
//  
//    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//         PrintWriter out = response.getWriter();
//         String name=request.getParameter("name");
//        
//       //Double.parseDouble(request.getParameter("bal"));
//        out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet NewServlet</title>");            
//            out.println("</head>");
//            out.println("<body>");
//             out.print(" <form action='UpdateBalanc?name="+name+"' method='POST'>");
//            out.print("<input name='set' type='text'/>");
//            out.print("<input type='submit' name='edit' value='Set Balance'/>");
//            
//            out.println("</form>");
//            out.println("</body>");
//            out.println("</html>"); 
//         
//         String  name1 = request.getParameter("edit");
//         if(!name1.equals(null)){
////              try {
////            admin admin1 = new admin();
//            double balance=Double.parseDouble(request.getParameter("set"));
//            out.println(balance);
////          int result =admin1.updateBalance(name,balance);
////            System.out.println(result);
////          if(result!=0){;
//                
//              out.println("update success the new balance = "+balance);
//          
//          }
//            
////        } catch (ClassNotFoundException ex) {
////            Logger.getLogger(ListUsers.class.getName()).log(Level.SEVERE, null, ex);
////        } catch (SQLException ex) {
////            Logger.getLogger(ListUsers.class.getName()).log(Level.SEVERE, null, ex);
//        }
//         
//         }
//         
//   
//       
////    }
//
//
//    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
//    /**
//     * Handles the HTTP <code>GET</code> method.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        processRequest(request, response);
//    }
//
//    /**
//     * Handles the HTTP <code>POST</code> method.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        processRequest(request, response);
//    }
//
//    /**
//     * Returns a short description of the servlet.
//     *
//     * @return a String containing servlet description
//     */
//    @Override
//    public String getServletInfo() {
//        return "Short description";
//    }// </editor-fold>
//
//}
