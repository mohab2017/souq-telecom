<%-- 
    Document   : view
    Created on : Feb 25, 2018, 9:43:36 PM
    Author     : Arwa
--%>

<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
        }
     %>

<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="mobileCat.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        
    </head>
    <body>
    <div class="navbar" style="text-align: center"> 
  <a>MiniSouq</a>
  <a href="buy.jsp">Buy</a>
 
  <div class="dropdown">
    <button class="dropbtn" onclick="myFunction()">Category
      <i class="fa fa-caret-down"></i>
    </button>
    <div class="dropdown-content" id="myDropdown">
      <a href="MobileCategory.jsp">Mobiles</a>
      <a href="#">Laptops</a>
    </div>
  </div> 
       <a href="#news">Logout</a> 

    <div class="search-container">
    <form action="/action_page.php">
      <input type="text" placeholder="Search.." name="search">
      <button type="submit"><i class="fa fa-search"></i></button>
    </form>
  </div>
</div>
  
        <table align="center" class="paddingBetweenCols">
              <p style="text-align: center"></p>
        <% 
          String url="jdbc:postgresql://10.145.4.186:5432/souqdb";
          try {
                  Connection con=DriverManager.getConnection(url,"postgres","postgres");
                  Statement st = con.createStatement(
                  ResultSet.TYPE_SCROLL_INSENSITIVE,
                 ResultSet.CONCUR_READ_ONLY
                   );
                  ResultSet rs= st.executeQuery("select * from items");
                while (rs.next()) {
                       
                     out.println("<tr>");
                     out.println("<td>");
                     out.println("<image src="+rs.getString(4)+" width=\"200\" height=\"250\"/>");
                     out.println("</td>");
                     if(rs.next())
                     {
                     out.println("<td>");
                     out.println("<image src="+rs.getString(4)+" width=\"200\" height=\"250\"/>");
                     out.println("</td>");
                     out.println("</tr>");
                    }
                   if(rs.previous())
                   {
                     out.println("<tr>");
                     out.println("<td>");
                     out.println("<p style=\"text-align: center\">Description:"+rs.getString(2)+"</p>");
                     out.println("<p style=\"text-align: center\">Price : "+rs.getString(5)+" LE</p>");
                     out.println("<form style=\"text-align: center\" method=\"POST\">");
                       out.println("<input type=\"hidden\" name=\"id\" value="+rs.getInt(1)+" >");
                       out.println("<input type=\"submit\" value=\"Add To Cart\"/>");
                     out.println("<select name=\"quantity\"/>");
                     
                     for(int i=1;i<=rs.getInt(3);i++)
                     {
                         out.println("<option value="+i+">"+i+"</option>");
                     }
                     out.println("<select/>");
                     out.println("</form>");
                     out.println("</td>");
                   }
                   if(rs.next())
                   {
                     out.println("<td>");
                     out.println("<p style=\"text-align: center\">Description:"+rs.getString(2)+"</p>");
                     out.println("<p style=\"text-align: center\">Price : "+rs.getString(5)+" LE</p>");
                     out.println("<form style=\"text-align: center\" method=\"POST\" >");
                     out.println("<input type=\"hidden\" name=\"id\" value="+rs.getInt(1)+" >");
                     out.println("<input type=\"submit\" value=\"Add To Cart\"/>");
                     out.println("<select name=\"quantity\"/>");
                     for(int i=1;i<=rs.getInt(3);i++)
                     {
                         out.println("<option value="+i+">"+i+"</option>");
                     }
                     out.println("<select/>");
                     out.println("</form>");
                     out.println("</td>"); 
                   }
              out.println("</tr>"); 
              } 
          }
                catch (SQLException e) {
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
window.onclick = function(e) {
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
