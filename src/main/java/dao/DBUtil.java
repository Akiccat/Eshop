package dao;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DBUtil {
    //连接数据库
    public static Connection getCon(){
        Connection con=null;
        String url = "jdbc:mysql://localhost:3306/eshop?characterEncoding=utf8&serverTimezone=UTC&useSSL=false";
        String user = "root";
        String password = "20010930";//更改为你的数据库密码
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");//mysql-connector-java-8.0及以上
            con = DriverManager.getConnection(url, user, password);
            return con;
        } catch (Exception e) {
            System.out.println(e);
            System.out.println("连接失败");
            return null;
        }
    }
    //关闭数据库
    public static void close(ResultSet rs,PreparedStatement ps,Connection con){
        if (rs != null) {
            try {
                rs.close();
            } catch (Exception e) {
                System.out.println(e);
            }
        }
        if (ps != null) {
            try {
                ps.close();
            } catch (Exception e) {
                System.out.println(e);
            }
        }
        if (con != null) {
            try {
                con.close();
            } catch (Exception e) {
                System.out.println(e);
            }
        }
    }
    public static List<Map<String, String>> getListFromRS(ResultSet rs) throws SQLException {
        List<Map<String, String>> list = null;
        // 获取元数据
        ResultSetMetaData rsmd = rs.getMetaData();
        if (rs.next()) {
            list = new ArrayList<Map<String, String>>();
            do {
                Map<String, String> m = new HashMap<String, String>();
                for (int i = 1; i <= rsmd.getColumnCount(); i++) {
                    // 获取当前行第i列的列名
                    String colName = rsmd.getColumnLabel(i);
                    String s = rs.getString(colName);
                    if (s != null) {
                        m.put(colName, s);
                    }
                }
                list.add(m);
            } while (rs.next());
        }
        return list;
    }

}
