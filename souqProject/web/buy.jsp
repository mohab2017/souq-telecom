<%-- 
    Document   : buy
    Created on : Feb 27, 2018, 8:02:36 PM
    Author     : Arwa
9/3/2018
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .modal {
                display: block; 
                position: fixed; /* Stay in place */
                z-index: 1; /* Sit on top */
                left: 0;
                top: 0;
                width: 100%; /* Full width */
                height: 100%; /* Full height */
                overflow: auto; /* Enable scroll if needed */
                background-color: rgb(0,0,0); /* Fallback color */
                background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
                border-color: #ff9a9d;
            }

            /* Modal Content/Box */
            .modal-content {
                background-color: #2b2727d1;
                margin: 15% auto; /* 15% from the top and centered */
                padding: 20px;
                border: 1px solid #888;
                width: 80%; /* Could be more or less, depending on screen size */
                text-align: center;
                font-size: 22px;
                color: #fd8080e8;
            }

            /* The Close Button */
            .close {
                color: #aaa;
                float: right;
                font-size: 28px;
                font-weight: bold;
            }

            .close:hover,
            .close:focus {
                color: black;
                text-decoration: none;
                cursor: pointer;
            }
        </style>
    </head>
    <body>
        <%

            String url = "jdbc:postgresql://localhost:5432/souqdb";

            try {
                Class.forName("org.postgresql.Driver");
                Connection con = DriverManager.getConnection(url, "postgres", "postgres");
                Cookie cookArr[] = request.getCookies();
                boolean buy = false;
                double cartBill = 0;
                double userNewCredit = 0.0;
                double userCredit = 0;
                boolean empty_cart=true;
                if (cookArr != null) {

                    for (Cookie cookie : cookArr) {
                        if (cookie.getName().equals("uname")) {
                            String userName = cookie.getValue();
                            String sql = "select sum(quantity),itemid from cart where username='" + userName + "' group by itemid";
                            ResultSet rs = con.createStatement().executeQuery(sql);
                            
                            while (rs.next()) {
                                empty_cart=false;
                                String sql2 = "SELECT quantity,price from items where item_id=" + rs.getInt(2) + " ";
                                ResultSet rs2 = con.createStatement().executeQuery(sql2);
                                String sql3 = "select credit from users where uname='" + userName + "'";
                                ResultSet rs3 = con.createStatement().executeQuery(sql3);
                                if (rs2.next() && rs3.next()) {
                                    double itemBill = rs.getInt(1) * rs2.getDouble(2);
                                    userCredit = rs3.getFloat(1);
                                    cartBill += itemBill;
                                    if (rs2.getInt(1) >= rs.getInt(1)) {
                                        if (userCredit >= cartBill) {

//                                            out.println("horray");
                                            buy = true;
                                        } else {
                                            RequestDispatcher rd1 = request.getRequestDispatcher("Remove_from_cart.jsp");
                                            rd1.include(request, response);
        %>
        <div id="myModal" class="modal">

            <!-- Modal content -->
            <div class="modal-content">
                <span class="close">&times;</span>
                <p>Sorry,You Exceed Your Budget</p>
                <p>May be You Wanna Edit Your Cart</p>
            </div>

        </div>
        <%
//                                            out.println("you are out of money");
                buy = false;
                break;
            }

        } else {
            RequestDispatcher rd2 = request.getRequestDispatcher("Remove_from_cart.jsp");
            rd2.include(request, response);
        %>
        <div id="myModal" class="modal">


            <div class="modal-content">
                <span class="close">&times;</span>
                <p>Sorry,Item is out of stock</p>
            </div>

        </div>
        <%
//                        out.println("out of stock");
                        buy = false;
                        break;
                    }
                }
            }
            if(empty_cart){
               RequestDispatcher rd3 = request.getRequestDispatcher("MobileCategory.jsp");
                rd3.include(request, response);
%>
  <div id="myModal" class="modal">


            <div class="modal-content">
                <span class="close">&times;</span>
                <p>Your Cart is Empty</p>
                <p>You May Wanna Add Some Items </p>
            </div>

        </div>

  <%            
}
              

            if (buy) {

                userNewCredit = userCredit - cartBill;
                String sql4 = "UPDATE users SET credit=" + userNewCredit + " WHERE uname='" + userName + "'";

                con.prepareStatement(sql4).executeUpdate();
                String sql5 = "select sum(quantity),itemid from cart where username='" + userName + "' group by itemid";
                ResultSet rs5 = con.createStatement().executeQuery(sql5);
                while (rs5.next()) {

                    int itemQuantity = rs5.getInt(1);
                    int itemId = rs5.getInt(2);
                    int storeQuantity = 0;
                    String sql6 = "SELECT quantity from items where item_id=" + rs5.getInt(2) + " ";
                    ResultSet rs6 = con.createStatement().executeQuery(sql6);
                    while (rs6.next()) {
                        storeQuantity = rs6.getInt(1);

                    }

                    int newStoreQuantity = storeQuantity - itemQuantity;
                    String sql7 = "UPDATE items set quantity=? WHERE item_id=?";
                    PreparedStatement p7 = con.prepareStatement(sql7);
                    p7.setInt(1, newStoreQuantity);
                    p7.setInt(2, itemId);
                    p7.executeUpdate();

                    String sql8 = "delete from cart where username='" + userName + "' ";
                    con.prepareStatement(sql8).executeUpdate();
                    String sql9 = "insert into history (username,itemid,quantity) values(?,?,?)";
                    PreparedStatement ps9 = con.prepareStatement(sql9);
                    ps9.setString(1, userName);
                    ps9.setInt(2, itemId);
                    ps9.setInt(3, itemQuantity);
                    ps9.executeUpdate();
                }
                RequestDispatcher rd = request.getRequestDispatcher("MobileCategory.jsp");
                rd.include(request, response);
        %>
        <div id="myModal" class="modal">

            <!-- Modal content -->
            <div class="modal-content">
                <span class="close">&times;</span>
                <p>Congratulations</p>
            </div>

        </div>


        <%
                            }

                        }
                    }
                }

            } catch (SQLException e) {

            }
        %>
        <script>
            var modal = document.getElementById('myModal');
// Get the <span> element that closes the modal
            var span = document.getElementsByClassName("close")[0];
// When the user clicks on <span> (x), close the modal
            span.onclick = function () {
                modal.style.display = "none";
            };

// When the user clicks anywhere outside of the modal, close it
            window.onclick = function (event) {
                if (event.target == modal) {
                    modal.style.display = "none";
                }
            };
        </script>
    </body>
</html>
