<%-- 
    Document   : buy
    Created on : Feb 27, 2018, 8:02:36 PM
    Author     : Arwa
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
    </head>
    <body>
        <% 
          String url="jdbc:postgresql://localhost:5432/souqdb";
          
          try {
                  Connection con=DriverManager.getConnection(url,"postgres","postgres");
                  Cookie cookArr[] = request.getCookies();
                  boolean buy=false;
                  double cartBill=0;
                  double userNewCredit=0.0;
                  double userCredit=0;
                  if (cookArr != null)
                  {
                  for (Cookie cookie : cookArr) {
                                  if (cookie.getName().equals("uname")) {
                                      String userName=cookie.getValue();
                                      String sql="select sum(quantity),itemid from cart where username="+userName+" group by itemid";
                                      ResultSet rs=con.createStatement().executeQuery(sql);
                                      while (rs.next()) {
                                          String sql2="SELECT quantity,price from items where item_id="+rs.getInt(2)+" ";
                                          ResultSet rs2=con.createStatement().executeQuery(sql2);
                                          String sql3="select credit from users where uname="+userName+"";
                                           ResultSet rs3=con.createStatement().executeQuery(sql3);
                                          if(rs2.next()&& rs3.next())
                                          {   
                                              double itemBill=rs.getInt(1)*rs2.getDouble(2);
                                              userCredit=rs3.getDouble(1);
                                              cartBill+=itemBill;
                                              if(rs2.getInt(1)>rs.getInt(1))
                                              {
                                                  if(userCredit>=cartBill)
                                              {
                                                  out.println("horray");
                                                  buy=true;
                                              }else
                                                  {
                                                      out.println("you are out of money");
                                                      buy=false;
                                                      break;
                                                  }
                                              }else
                                              {
                                                  out.println("out of stock");
                                                  buy=false;
                                                  break;
                                              }
                                          }
                                          }
                                      if(buy)
                                      {
                                          userNewCredit=userCredit-cartBill;
                                          String sql4="UPDATE users SET credit="+userNewCredit+" WHERE uname="+userName+"";
                                          con.prepareStatement(sql4).executeUpdate();
                                          String sql5="select sum(quantity),itemid from cart where username="+userName+" group by itemid";
                                           ResultSet rs5=con.createStatement().executeQuery(sql5);
                                           String sql6="SELECT quantity from items where item_id="+rs5.getInt(2)+" ";
                                           ResultSet rs6=con.createStatement().executeQuery(sql6);
                                            while (rs5.next()&&rs6.next()) {
                                                int itemQuantity=rs5.getInt(1);
                                                int itemId=rs5.getInt(2);
                                                int storeQuantity=rs6.getInt(1);
                                                int newStoreQuantity=storeQuantity-itemQuantity;
                                                String sql7="UPDATE items set quantity="+newStoreQuantity+" WHERE item_id="+itemId+"";
                                                con.prepareStatement(sql7).executeUpdate();
                                                String sql8="delete from cart where username="+userName+"";
                                            }
                                          
                                          
                                      }
                                  }
                              }
                          }

          }         
          catch(SQLException e)
          {
              
          }
                %>
    </body>
</html>
