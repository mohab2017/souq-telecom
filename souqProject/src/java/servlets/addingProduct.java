/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import classes.admin;
import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
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
public class addingProduct extends HttpServlet {

 @Override
public void init()
{System.out.println("I am inside the init method");} 
@Override
public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException 
{
     try {
         response.setContentType("text/html;charset=UTF-8");
         PrintWriter out = response.getWriter();
         String item_name=request.getParameter("item_name");
         String quantity=request.getParameter("quantity");
         int quantityint=Integer.parseInt(quantity);
         String item_photo=request.getParameter("item_photo");
         String price=request.getParameter("price");
         int priceint=Integer.parseInt(price);
         String description=request.getParameter("description");
         String categ_id=request.getParameter("categ_id");
         int categ_idint=Integer.parseInt(categ_id);
         admin ad=new admin();
           out.println("<html>\n" +
"    <head>\n" +
"        <title>TODO supply a title</title>\n" +
"        <meta charset=\"UTF-8\">\n" +
"        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n" +
"    </head>\n" +
"    <body>\n" +
"        <div align=\"center\">\n" +
"            PRODUCT ADDED\n" +
"            <br><br>\n" +
"           <a href=\"adminpage.html\"><button>Back To Adminstrator Page</button></a>\n" +
"        </div>\n" +
"        \n" +
"    </body>\n" +
"</html>\n" +
"");
         ad.addProduct(item_name,quantityint,item_photo,priceint,description,categ_idint);
       
     } catch (ClassNotFoundException | SQLException ex) {
         Logger.getLogger(addingProduct.class.getName()).log(Level.SEVERE, null, ex);
     }
}
}
