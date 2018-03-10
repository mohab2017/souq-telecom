/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import classes.admin;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Mohab
 */
public class deleteProduct extends HttpServlet {

 @Override
public void init()
{System.out.println("I am inside the init method");} 
@Override
public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException 
{
     try {
         response.setContentType("text/html;charset=UTF-8");
         PrintWriter out = response.getWriter();
         String deleteditem_name=request.getParameter("deleteditem_name");
         admin ad=new admin();
         out.println("<html>\n" +
"    <head>\n" +
"        <title>TODO supply a title</title>\n" +
"        <meta charset=\"UTF-8\">\n" +
"        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n" +
"    </head>\n" +
"    <body>\n" +
"        <div align=\"center\">\n" +
"            PRODUCT deleted\n" +
"            <br><br>\n" +
"           <a href=\"adminpage.html\"><button>Back To Adminstrator Page</button></a>\n" +
"        </div>\n" +
"        \n" +
"    </body>\n" +
"</html>\n" +
" ");
         ad.deleteProduct(deleteditem_name);
     } catch (ClassNotFoundException ex) {
         Logger.getLogger(deleteProduct.class.getName()).log(Level.SEVERE, null, ex);
     } catch (SQLException ex) {
         Logger.getLogger(deleteProduct.class.getName()).log(Level.SEVERE, null, ex);
     }
}

}
