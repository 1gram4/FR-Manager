package me.pao.dao.impl;

import me.pao.domain.Record;
import me.pao.domain.User;
import me.pao.util.DBconn;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class test  {
    public static void main(String[] args) {

        System.out.println("update webdemo4.user\n" +
                "set imgpath = 'F:\\\\userimg\\\\16122070'\n" +
                "where id = '16122070'");//find("12","21");
        DBconn.init();
        ResultSet resultSet = DBconn.selectSql("SELECT imgpath FROM webdemo4.user\n" +
                "where id = '16122070';");
        try {
            while (resultSet!=null){
                System.out.println(resultSet.getString("imgpath"));
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        DBconn.closeConn();
    }
    public static User find(String userId, String userPwd){
        DBconn.init();
        Date date = new Date();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        //从前端或者自己模拟一个日期格式，转为String即可
        String dateStr = format.format(date);
        System.out.println(dateStr);
        DBconn.addUpdDel("insert into webdemo4.record \n" +
                "values ('14','"+dateStr+"','16122070','11')");
        try {
            ResultSet rs = DBconn.selectSql("select record.id ,opentime,userid,user.louhao,name from \n" +
                    "webdemo4.record,webdemo4.user\n" +
                    "where record.userid=user.id and \n" +
                    "userid='"+"16122070"+"'");
            System.out.println(1);
            while(rs.next()){
                    Record record = new Record();
                    record.setId(rs.getString("id"));
                    record.setLouHao(rs.getString("louhao"));
                    record.setOpenTime(rs.getDate("opentime").toString());
                    System.out.println(rs.getDate("opentime").toString());
                    System.out.println(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(rs.getTimestamp("opentime")));
                    record.setUserId(userId);
                    record.setUserName(rs.getString("name"));
            }
            DBconn.closeConn();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}