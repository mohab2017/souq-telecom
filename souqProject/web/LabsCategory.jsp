<%-- 
    Document   : LabsCategory
    Created on : Mar 6, 2018, 11:12:56 AM
    Author     : Arwa
9/3/2018
--%>

<%@page import="java.sql.PreparedStatement"%>
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
        <link rel="stylesheet" href="mobileCat.css">
        <style>

            body {font-family: Arial, Helvetica, sans-serif;}
            * {box-sizing: border-box}
            /* Full-width input fields */
            input[type=text], input[type=password] {
                width: 100%;
                padding: 15px;
                margin: 5px 0 22px 0;
                display: inline-block;
                border: none;
                background: #f1f1f1;
            }

            /* Add a background color when the inputs get focus */
            input[type=text]:focus, input[type=password]:focus {
                background-color: #ddd;
                outline: none;
            }


            button:hover {
                opacity:1;
            }

            /* Extra styles for the cancel button */
            .cancelbtn {
                padding: 14px 20px;
                background-color: #ff9a9d;
            }

            /* Float cancel and signup buttons and add an equal width */
            .cancelbtn, .signupbtn {
                float: left;
                width: 50%;
            }

            /* Add padding to container elements */
            .container {
                padding: 16px;
            }

            /* The Modal (background) */
            .modal {
                display: none; /* Hidden by default */
                position: fixed; /* Stay in place */
                z-index: 1; /* Sit on top */
                left: 0;
                top: 0;
                width: 100%; /* Full width */
                height: 100%; /* Full height */
                overflow: auto; /* Enable scroll if needed */
                background-color: #474e5d;
                padding-top: 50px;
            }

            /* Modal Content/Box */
            .modal-content {
                background-color: #fefefe;
                margin: 5% auto 15% auto; /* 5% from the top, 15% from the bottom and centered */
                border: 1px solid #888;
                width: 80%; /* Could be more or less, depending on screen size */
            }

            /* Style the horizontal ruler */
            hr {
                border: 1px solid #f1f1f1;
                margin-bottom: 25px;
            }

            /* The Close Button (x) */
            .close {
                position: absolute;
                right: 35px;
                top: 15px;
                font-size: 40px;
                font-weight: bold;
                color: #f1f1f1;
            }

            .close:hover,
            .close:focus {
                color: #f44336;
                cursor: pointer;
            }

            /* Clear floats */
            .clearfix::after {
                content: "";
                clear: both;
                display: table;
            }
        </style>
        <title>JSP Page</title>

    </head>

    <body>
        <div class="navbar" style="background-color: #000000;text-align: center" > 
            <a>MiniSouq</a>
            <div class="dropdown" style="background-color: #000000">
                <button class="dropbtn" onclick="myFunction()">Category
                    <i class="fa fa-caret-down"></i>
                </button>
                <div class="dropdown-content" id="myDropdown" style="background-color: #000000" >
                    <a href="MobileCategory.jsp" >Mobiles</a>
                    <a href="LabsCategory.jsp">Laptops</a>
                </div>
            </div> 
            <%  Cookie cook_Arr[] = request.getCookies();
                boolean flag = false;
                String uname = "";
                if (cook_Arr != null) {
                    for (Cookie cookie : cook_Arr) {
                        if (cookie.getName().equals("uname")) {
                            uname = cookie.getValue();
                        }
                        if (cookie.getName().equals("islogin")) {
                            flag = true;
                            if (cookie.getValue().equals("true")) {
            %>
            <a href="Remove_from_cart.jsp">Cart</a>
            <a onclick="document.getElementById('id01').style.display = 'block'">Edit Profile</a>
            <a href="buy.jsp">Buy</a>   
            <a href="logout">Logout</a> 
            <%
            } else {
            %>
            <a href="loginpage.html">Login</a> 
            <a href="SignUp.jsp">SignUp</a> 
            <%
                        }
                    }

                }
                if (!flag) {
            %>
            <a href="loginpage.html">Login</a> 
            <a href="SignUp.jsp">SignUp</a>
            <%
                }

            } else {
            %>
            <a href="loginpage.html">Login</a> 
            <a href="SignUp.jsp">SignUp</a> 
            <%
                }
            %>
            <div class="search-container">
                <form action="LabsCategory.jsp">
                    <input type="text" placeholder="Search.." name="search">
                    <button id="search" type="submit"><i class="fa fa-search"></i></button>
                </form>
            </div>
        </div>

        <table align="center" class="paddingBetweenCols">
            <p style="text-align: center"></p>
            <%
                String url = "jdbc:postgresql://localhost:5432/souqdb";
                try {
                    Connection con = DriverManager.getConnection(url, "postgres", "postgres");
                    Statement st = con.createStatement(
                            ResultSet.TYPE_SCROLL_INSENSITIVE,
                            ResultSet.CONCUR_READ_ONLY
                    );
                    ResultSet rs = st.executeQuery("select * from items where categ_id=" + 2 + "");
                    String id = request.getParameter("id");
                    String quantity = request.getParameter("quantity");
                    String keyWord = request.getParameter("search");
                    if (keyWord != null) {
                        if (keyWord.equals("mobiles")) {
                            response.sendRedirect("MobileCategory.jsp");
                        }
                    }
                    String username = request.getParameter("username");
                    String password = request.getParameter("password");
                    String email = request.getParameter("email");
                    String job = request.getParameter("job");
                    String address = request.getParameter("address");
                    String birth = request.getParameter("birth");
                    String interests = request.getParameter("interests");
                    if (username != null) {
                         Statement stmt10 = con.createStatement();
                        String queryString = new String("Select * from users");
                         ResultSet rs10 = stmt10.executeQuery(queryString);
                        boolean flag10 = true;
                        while (rs10.next()) {
                            if (rs10.getString(1).equals(username)) {
                                System.out.println("flag10"+flag10);
                                flag = false;
                            }
                            if(flag10)
                            {   
                                System.out.println("flag10"+flag10);
                                con.prepareStatement("update users set uname='" + username + "' where uname='" + uname + "'").executeUpdate();
                                if (cook_Arr != null) {
                                    System.out.println("inside cookoe");
                                    for (Cookie cookie : cook_Arr) {
                                        if (cookie.getName().equals("uname")) {
                                            cookie.setValue(username);
                                            response.addCookie(cookie);
                                        }
                                    }
                                }
                            }else
                            {
                                
                            }
                        }
                    }
                            if (password != null) {
                                con.prepareStatement("update users set password='" + password + "' where username='" + uname + "'").executeUpdate();
                            }
                            if (email != null) {
                                con.prepareStatement("update users set email='" + email + "' where username='" + uname + "'").executeUpdate();
                            }
                            if (job != null) {
                                con.prepareStatement("update users set job='" + job + "' where username='" + uname + "'").executeUpdate();
                            }
                            if (address != null) {
                                con.prepareStatement("update users set address='" + address + "' where username='" + uname + "'").executeUpdate();
                            }
                            if (birth != null) {
                                con.prepareStatement("update users set birthday='" + birth + "' where username='" + uname + "'").executeUpdate();
                            }
                            if (interests != null) {
                                con.prepareStatement("update users set interests='" + interests + "' where username='" + uname + "'").executeUpdate();
                            }
                            
                                    
                            if ((id != null) && (quantity != null)) {
                                System.out.println(request.getParameter("id"));
                                System.out.println(request.getParameter("quantity"));
                                Cookie cookArr[] = request.getCookies();
                                if (cookArr != null) {
                                    for (Cookie cookie : cookArr) {
                                        if (cookie.getName().equals("uname")) {
                                            //                                      if(request.getParameter("name").equals("arwa")){
                                            String userName = cookie.getValue();
                                            //                                      String userName = "arwa";
                                            System.out.println(request.getParameter("id"));
                                            String sql = "insert into cart (username,itemid,quantity) values(?,?,?)";

                                            PreparedStatement ps = con.prepareStatement(sql);

                                            ps.setString(1, userName);
                                            ps.setInt(2, Integer.parseInt(id));
                                            ps.setInt(3, Integer.parseInt(quantity));
                                            ps.executeUpdate();

                                        }

                                    }
                                }
                            }

                            while (rs.next()) {
                                 System.out.println("lab cat");
                                out.println("<tr>");
                                out.println("<td>");
                                out.println("<image src=" + rs.getString(4) + " width=\"200\" height=\"250\"/>");
                                out.println("</td>");
                                if (rs.next()) {
                                    out.println("<td>");
                                    out.println("<image src=" + rs.getString(4) + " width=\"200\" height=\"250\"/>");
                                    out.println("</td>");
                                    out.println("</tr>");
                                }
                                if (rs.previous()) {
                                    out.println("<tr>");
                                    out.println("<td>");
                                    out.println("<p style=\"text-align: center\">" + rs.getString(2) + "</p>");
                                    out.println("<p style=\"text-align: center\">Price : " + rs.getString(5) + " LE</p>");
                                    if (rs.getInt(3) == 0) {
                                        out.println("<p style=\"text-align: center;text-decoration: line-through #f44336\">Out Of Stock</p>");
                                        out.println("</td>");
                                    } else {
                                        out.println("<form style=\"text-align: center\" action=\"LabsCategory.jsp\" method=\"POST\">");
                                        out.println("<input type=\"hidden\" name=\"id\" value=" + rs.getInt(1) + " >");
                                        out.println("<input type=\"submit\" value=\"Add To Cart\"/>");
                                        out.println("<select name=\"quantity\"/>");

                                        for (int i = 1; i <= rs.getInt(3); i++) {
                                            out.println("<option value=" + i + ">" + i + "</option>");
                                        }
                                        out.println("</select>");
                                        out.println("</form>");
                                        out.println("</td>");
                                    }
                                }
                                if (rs.next()) {
                                    out.println("<td>");
                                    out.println("<p style=\"text-align: center\">" + rs.getString(2) + "</p>");
                                    out.println("<p style=\"text-align: center\">Price : " + rs.getString(5) + " LE</p>");
                                    if (rs.getInt(3) == 0) {
                                        out.println("<p style=\"text-align: center;text-decoration: line-through #f44336\">Out Of Stock</p>");
                                        out.println("</td>");
                                        //    out.println("</tr>");
                                    } else {
                                        out.println("<form style=\"text-align: center\" action=\"LabsCategory.jsp\" method=\"POST\">");
                                        out.println("<input type=\"hidden\" name=\"id\" value=" + rs.getInt(1) + " >");
                                        out.println("<input type=\"submit\" value=\"Add To Cart\"/>");
                                        out.println("<select name=\"quantity\">");
                                        for (int i = 1; i <= rs.getInt(3); i++) {
                                            out.println("<option value=" + i + ">" + i + "</option>");
                                        }
                                        out.println("</select>");

                                        out.println("</form>");
                                        out.println("</td>");
                                    }
                                }
                                out.println("</tr>");
                            }
                        }catch (SQLException e) {
                            e.printStackTrace();
                }

            %>
        </table>
        <div id="id01" class="modal">
            <span onclick="document.getElementById('id01').style.display = 'none'" class="close" title="Close Modal">&times;</span>
            <form class="modal-content" action="LabsCategory.jsp">
                <div class="container">
                    <h1>Profile</h1>
                    <hr>
                    <label for="UserName"><b>UserName</b></label>
                    <input type="text" placeholder="username" name="username" >

                    <label for="psw"><b>Password</b></label>
                    <input type="password" placeholder="Enter Password" name="psw" >

                    <label for="email"><b>Email</b></label>
                    <input type="text" placeholder="Enter Email" name="email" >

                    <label for="jop"><b>Job</b></label>
                    <input type="text" placeholder="Enter Job" name="job" >

                    <label for="address"><b> Address</b></label>
                    <input type="text" placeholder="Enter Address" name="address" >

                    <label for="interests"><b>Interests</b></label>
                    <input type="text" placeholder="Enter Interests" name="interests" >
                    <label for="interests"><b>Birth Date</b></label>
                    <input type="text" placeholder="Enter Birth Date" name="birth" >

                    <div class="clearfix">
                        <input type="submit" onclick="document.getElementById('id01').style.display = 'none'" class="cancelbtn">
                        <!--<button type="submit" class="signupbtn ">Save</button>-->
                    </div>
                </div>
            </form>
        </div>


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
            var modal = document.getElementById('id01');

// When the user clicks anywhere outside of the modal, close it
            window.onclick = function (event) {
                if (event.target == modal) {
                    modal.style.display = "none";
                }
            }
        </script>
        <footer>Copyright &copy; MiniSouq.com</footer>
    </body>
</html>

