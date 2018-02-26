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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .paddingBetweenCols td
{
    padding:0 60px 0 60px;
}
.navbar {
    overflow: hidden;
    padding: 6px;
    /*background-color: #bdbdbd;*/
    font-family: Arial, Helvetica, sans-serif;
    
}

.navbar a {
    float: left;
    font-size: 22px;
    color: #ff9a9d;
    text-align: center;
    padding: 14px 16px;
    text-decoration: none;
    display: blockl;
}

.dropdown {
    float: left;
    overflow: hidden;
}

.dropdown .dropbtn {
    cursor: pointer;
    font-size: 22px;    
    border: none;
    outline: none;
    color: #ff9a9d;
    padding: 14px 16px;
    background-color: inherit;
    font-family: inherit;
    margin: 0;
}
.navbar .search-container {
  float: left;
}

.navbar input[type=text] {
  padding: 6px;
  margin-top: 8px;
  font-size: 17px;
  border: solid 1px #ff9a9d;
  width: 450px;
}

.navbar .search-container button {
  float: right;
  padding: 6px 10px;
  margin-top: 8px;
  margin-right: 16px;
  background: #ff9a9d;
  font-size: 17px;
  border: none;
  cursor: pointer;
}

.navbar .search-container button:hover {
  background: #ff9a9d;
}


.navbar a:hover, .dropdown:hover .dropbtn, .dropbtn:focus {
    background-color: #cbb8d7;
}

.dropdown-content {
    display: none;
    position: absolute;
    background-color: #f9f9f9;
    min-width: 160px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
}

.dropdown-content a {
    float: none;
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
    text-align: left;
}

.dropdown-content a:hover {
    background-color: #ddd;
}

.show {
    display: block;
}
table
{
    border-collapse:separate; 
border-spacing:1.5em;
}
header, footer {
    padding: 1em;
    color: black;
    /*background-color: #bdbdbd;*/
    clear: left;
    text-align: center;
    font-size: 22px;
}
        </style>
    </head>
    <body>
    <div class="navbar" style="text-align: center"> 
  <a>MiniSouq</a>
  <a href="#home">Buy</a>
 
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
          String url="jdbc:postgresql://localhost:5432/souqdb";
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
                     out.println("<form style=\"text-align: center\">");
                       out.println("<input type=\"hidden\" name=\"id\" value="+rs.getInt(1)+" >");
                       out.println("<input type=\"submit\" value=\"Add To Cart\"/>");
                     out.println("<select name=\"quantity\"/>");
                     
                     for(int i=1;i<=rs.getInt(3);i++)
                     {
                         out.println("<option value="+i+">"+i+"</option>");
                     }
                     
                     out.println("</form>");
                     out.println("</td>");
                   }
                   if(rs.next())
                   {
                     out.println("<td>");
                     out.println("<p style=\"text-align: center\">Description:"+rs.getString(2)+"</p>");
                     out.println("<p style=\"text-align: center\">Price : "+rs.getString(5)+" LE</p>");
                     out.println("<form style=\"text-align: center\">");
                     out.println("<input type=\"hidden\" name=\"id\" value="+rs.getInt(1)+" >");
                     out.println("<input type=\"submit\" value=\"Add To Cart\"/>");
                     out.println("<select name=\"quantity\"/>");
                     for(int i=1;i<=rs.getInt(3);i++)
                     {
                         out.println("<option value="+i+">"+i+"</option>");
                     }
                     
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
