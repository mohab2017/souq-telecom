/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package classes;

import static java.lang.System.out;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;

/**
 *
 * @author Mohab
 */
public class admin {
Connection connect;
String uname="";
String password="";
Statement stmt;
PreparedStatement prep;
ResultSet rs;
String checkstate;
//String item_name,item_photo,description;
//Integer priceint,quantityint;
public admin() throws ClassNotFoundException, SQLException
        {
        Class.forName("org.postgresql.Driver");
         connect=DriverManager.getConnection("jdbc:postgresql://192.168.1.3:5432/souqdb", "postgres", "postgres");
        }
public void addProduct(String item_name,int quantityint,String item_photo,int priceint,String description) throws SQLException
{
PreparedStatement stmt = connect.prepareStatement("insert into items (item_name,quantity,item_photo,price,description) values (?,?,?,?,?);");
stmt.setString(1, item_name);
stmt.setInt(2, quantityint);
stmt.setString(3, item_photo);
stmt.setInt(4, priceint);
stmt.setString(5, description);
stmt.executeUpdate();
out.println("PRODUCT ADDEDDDDD ");
}
public int deleteUser(String name){
    int o =0;
try {
            PreparedStatement stmt = connect.prepareStatement("delete from users where uname=?;");
            stmt.setString(1, name);
            o = stmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(admin.class.getName()).log(Level.SEVERE, null, ex);
    }
return o;
}
public ResultSet selectAllUsers(){
        try {
            PreparedStatement stmt = connect.prepareStatement("Select uname from users;");
            rs = stmt.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(admin.class.getName()).log(Level.SEVERE, null, ex);
    }
    return rs;

}
public ResultSet History(String user){
        try {
            PreparedStatement stmt = connect.prepareStatement("select username,itemid,quantity from history where username='"+user+"");
            rs = stmt.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(admin.class.getName()).log(Level.SEVERE, null, ex);
    }
    return rs;

}

public int updateBalance(String name,double bal){
    int result=0;
         try {
             
            PreparedStatement stmt = connect.prepareStatement("Update users set credit=? where uname=?;");
         stmt.setString(2, name); 
         
         stmt.setDouble(1, bal);
          result = stmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(admin.class.getName()).log(Level.SEVERE, null, ex);
    }
    return result;
}

 public void deleteProduct(String deleteditem_name) {
        try {
            String query=("UPDATE items set quantity =0 where item_name=?");
            prep = connect.prepareStatement(query);
            prep.setString(1,deleteditem_name);
        } catch (SQLException ex) {
            Logger.getLogger(admin.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

//    public static void main(String[] args) {
//        admin a = new admin();
//        try {
//            a.updateProduct("apple", 7);
//        } catch (SQLException ex) {
//            Logger.getLogger(admin.class.getName()).log(Level.SEVERE, null, ex);
//        }
//    }

    public void updateProduct(String upitem_name, int upquantityint) throws SQLException {
        String sql = "UPDATE items set quantity = ? where item_name=?";
        prep = connect.prepareStatement(sql);
        prep.setInt(1,upquantityint);
        prep.setString(2, upitem_name);
        prep.execute();
//         connect.commit();


    }
//public void checkAdmin(String uname,String password) throws SQLException
//{
//stmt=connect.createStatement();
//String queryString = new String("Select * from users;");
//rs = stmt.executeQuery(queryString);
//Boolean flag=true;
//while (rs.next()) 
//       {
//                if (rs.getString(1).equals(uname) && rs.getString(2).equals(password))
//                {
//                 checkstate="true";
//                }
//       }
//       if(flag) 
//       {     }
//              else  {
//                checkstate="false";
//                }
//}
}
