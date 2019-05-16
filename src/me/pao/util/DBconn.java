package me.pao.util;

import com.mysql.jdbc.Driver;
import java.sql.*;

public class DBconn {
    static String driverName = "com.mysql.cj.jdbc.Driver";
    static String URL = "jdbc:mysql://127.0.0.1:3306/webdemo4?useUnicode=true&characterEncoding=utf8&serverTimezone=Asia/Shanghai";
    static String username = "root";
    static String password = "Zz199701";
    static Connection conn = null;
    static ResultSet rs = null; // 初始化一个结果集 rs
    static PreparedStatement ps =null; // 初始化一个PreparedStatement对象 ps
    public static void init(){
        try {
            //加载驱动
            Driver.class.forName(driverName);
            //建立连接
            conn = DriverManager.getConnection(URL, username, password);
        } catch (Exception e) {
            System.out.println("init [SQL驱动程序初始化失败！]");
            e.printStackTrace();
        }
    }
    public static int addUpdDel(String sql){
        int i = 0;
        try {
            PreparedStatement ps =  conn.prepareStatement(sql);
            i =  ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("sql数据库增删改异常");
            e.printStackTrace();
        }
        return i;
    }

    public static ResultSet selectSql(String sql){
        try {
            ps =  conn.prepareStatement(sql);
            rs =  ps.executeQuery(sql);
        } catch (SQLException e) {
            System.out.println("sql数据库查询异常");
            e.printStackTrace();
        }
        return rs;
    }

    public static void closeConn(){
        try {
            conn.close();
        } catch (SQLException e) {
            System.out.println("sql数据库关闭异常");
            e.printStackTrace();
        }
    }
}
