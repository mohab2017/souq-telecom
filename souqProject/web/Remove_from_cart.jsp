<%-- 
    Document   : Remove_from_cart
    Created on : Mar 2, 2018, 7:22:38 AM
    Author     : Arwa
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="mobileCat.css">
        <title>Edit Cart</title>

    </head>
    <body>
        <%
            Connection con = null;
            try {
                Class.forName("org.postgresql.Driver");
                String url = "jdbc:postgresql://localhost:5432/souqdb";
                con = DriverManager.getConnection(url, "postgres", "postgres");
                Statement st = con.createStatement(
                  ResultSet.TYPE_SCROLL_INSENSITIVE,
                 ResultSet.CONCUR_READ_ONLY
                   );
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
        %>
        <div class="navbar" style="background-color: #000000;text-align: center" > 
            <a>MiniSouq</a>
            <div class="dropdown" style="background-color: #000000">
                <button class="dropbtn" onclick="myFunction()">Category
                    <i class="fa fa-caret-down"></i>
                </button>
                <div class="dropdown-content" id="myDropdown">
                    <a href="MobileCategory.jsp">Mobiles</a>
                    <a href="#">Laptops</a>
                </div>
            </div> 
            <a href="Remove_from_cart.jsp">Edit Cart</a>
            <a href="#">Edit Profile</a>
            <a href="buy.jsp">Buy</a>   
            <a href="logout">Logout</a> 
        </div>
        <%
            String userName = "";
            String id=request.getParameter("id");
            String quantity= request.getParameter("quantity"); 
            String cart_id=request.getParameter("cart");
            Cookie cookArr[] = request.getCookies();
            if (cookArr != null) {
                for (Cookie cookie : cookArr) {
                    if (cookie.getName().equals("uname")) {
                        userName = cookie.getValue();
                    }
                }
            }       
            if((id!=null)&& (quantity!=null))
                  {    
                      String stm1="update cart set quantity=? where username=? and itemid=? ";
//                      update cart set quantity=0 where username='arwa' and itemid=1 and cart_id=(select max(cart_id) FROM cart where username='arwa' and itemid=1)
//                      String stm2="select sum(quantity) from cart where username='" + userName + "' and itemid="+id+" group by itemid";
                      String stm2="select quantity from cart where username='" + userName + "' and itemid="+id+" and cart_id="+cart_id+"";
                      ResultSet rs= con.createStatement().executeQuery(stm2);
                      rs.next();
                      int newQuantity=rs.getInt(1)-Integer.parseInt(quantity);
                      if(newQuantity==0)
                      {   
                          System.out.println("zero quantity");
                          String stm3="delete from cart where username=? and itemid=? and cart_id="+cart_id+"";
                          PreparedStatement ps1= con.prepareStatement(stm3);
                          ps1.setInt(2,Integer.parseInt(id));
                          ps1.setString(1, userName);
                          ps1.executeUpdate();
                          
                      }else
                      {
                      PreparedStatement ps= con.prepareStatement(stm1);
                      ps.setInt(1,newQuantity);
                      ps.setString(2, userName);
                      ps.setInt(3, Integer.parseInt(id));
                      ps.executeUpdate();
                      }
                   

                  }
                     
                    Statement s =  con.createStatement(
                  ResultSet.TYPE_SCROLL_INSENSITIVE,
                 ResultSet.CONCUR_READ_ONLY
                   );
                    ResultSet rs1= s.executeQuery("select * from cart where username='" + userName + "'");
                    while (rs1.next()) {
//                        int item_id = rs1.getInt(3);
                        Statement stm =  con.createStatement(
                            ResultSet.TYPE_SCROLL_INSENSITIVE,
                           ResultSet.CONCUR_READ_ONLY
                             );
                        System.out.println("first item id "+rs1.getInt(3));
                        String sql="select item_name,item_photo,price from items where item_id=" + rs1.getInt(3) + "";
                        ResultSet rs2=stm.executeQuery(sql);
                        rs2.next();
                        %>
                        <table align="center" class="paddingBetweenCols">
                         <p style="text-align: center"></p>
                        <%
                        out.println("<tr>");
                        out.println("<td>");
                        out.println("<image src=" + rs2.getString(2) + " width=\"200\" height=\"250\"/>");
                        out.println("</td>");
                        if (rs1.next()) {
                            
                             rs2=stm.executeQuery("select item_name,item_photo,price from items where item_id=" + rs1.getInt(3) + "");
                             rs2.next();
                             System.out.println("second item id "+rs1.getInt(3) +"rs2.getString(2)"+rs2.getString(2));
                            out.println("<td>");
                            out.println("<image src=" + rs2.getString(2) + " width=\"200\" height=\"250\"/>");
                            out.println("</td>");
                            out.println("</tr>");
                        }
                        if (rs1.previous()) {
                            rs2=stm.executeQuery("select item_name,item_photo,price from items where item_id=" + rs1.getInt(3) + "");
                            rs2.next();
                            out.println("<tr>");
                            out.println("<td>");
                            out.println("<p style=\"text-align: center\">Description:" + rs2.getString(1) + "</p>");
                            out.println("<p style=\"text-align: center\">Price : " + rs2.getString(3) + " LE</p>");
                            out.println("<form style=\"text-align: center\" action=\"Remove_from_cart.jsp\" method=\"POST\">");
                            out.println("<input type=\"hidden\" name=\"id\" value=" + rs1.getInt(3) + " >");
                            out.println("<input type=\"hidden\" name=\"cart\" value=" + rs1.getInt(1) + " >");
                            out.println("<input type=\"submit\" value=\"Remove from Cart\"/>");
                            out.println("<select name=\"quantity\"/>");

                            for (int i = 1; i <= rs1.getInt(4); i++) {
                                out.println("<option value=" + i + ">" + i + "</option>");
                            }
                            out.println("</select>");
                            out.println("</form>");
                            out.println("</td>");
                        }
                        if (rs1.next()) {
                            rs2=stm.executeQuery("select item_name,item_photo,price from items where item_id=" + rs1.getInt(3) + "");
                            rs2.next();
                            out.println("<td>");
                            out.println("<p style=\"text-align: center\">Description:" + rs2.getString(1) + "</p>");
                            out.println("<p style=\"text-align: center\">Price : " + rs2.getString(3) + " LE</p>");
                            out.println("<form style=\"text-align: center\" action=\"Remove_from_cart.jsp\" method=\"POST\">");
                            out.println("<input type=\"hidden\" name=\"id\" value=" + rs1.getInt(3) + " >");
                            out.println("<input type=\"hidden\" name=\"cart\" value=" + rs1.getInt(1) + " >");
                            out.println("<input type=\"submit\" value=\"Remove from Cart\"/>");
                            out.println("<select name=\"quantity\"/>");
                            for (int i = 1; i <= rs1.getInt(4); i++) {
                                out.println("<option value=" + i + ">" + i + "</option>");
                            }
                            out.println("</select>");
                            out.println("</form>");
                            out.println("</td>");
                        }
                        out.println("</tr>");

                    }
        %>

                        </table>
        <script>
            /* When the user clicks on the button, 
             toggle between hiding and showing the dropdown content */
            function myFunction() {
                document.getElementById("myDropdown").classList.toggle("show");
            }

// Close the dropdown if the user clicks outside of it
            window.onclick = function (e) {
                if (!e.target.matches('.dropbtn')) {
                    var myDropdown = document.getElementById("myDropdown");
                    if (myDropdown.classList.contains('show')) {
                        myDropdown.classList.remove('show');
                    }
                }
            }
        </script>
        <footer>Copyright &copy; MiniSouq.com</footer>
    </body>
</html>
