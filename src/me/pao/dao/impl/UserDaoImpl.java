package me.pao.dao.impl;
import me.pao.dao.IUserDao;
import me.pao.domain.Record;
import me.pao.domain.User;
import me.pao.util.DBconn;


import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class UserDaoImpl implements IUserDao {
    public User find(String userId, String userPwd){
        User user = new User();
        boolean flag = false;
        try {
            DBconn.init();
            ResultSet rs = DBconn.selectSql("select * from webdemo4.user where id='"+userId+"' and pwd='"+userPwd+"'");
            while(rs.next()){
                if(rs.getString("id").equals(userId) && rs.getString("pwd").equals(userPwd)){
                    user.setId(rs.getString("id"));
                    user.setUserName(rs.getString("name"));
                    user.setUserPwd(rs.getString("pwd"));
                    user.setIsStudent(rs.getString("isstudent"));
                    user.setImgPath(rs.getString("imgpath"));
                    return user;
                }
            }
            DBconn.closeConn();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    public User find(String userName){
        User user = new User();
        return  user;
    }

    public List<Record> queryRecord(String userId, String y,String m,String d){
        List<Record> list = new ArrayList<Record>();
        try {
            DBconn.init();
            ResultSet rs = DBconn.selectSql("select record.id ,opentime,userid,user.louhao,name from \n" +
                    "webdemo4.record,webdemo4.user\n" +
                    "where record.userid=user.id and \n" +
                    "DATE_FORMAT(opentime,'%Y-%m-%d') = '"+y+"-"+m+"-"+d+"' and \n" +
                    "userid='"+userId+"'"+"order by opentime");
            if(m==null&&d==null){
                rs= DBconn.selectSql("select record.id ,opentime,userid,user.louhao,name from \n" +
                        "webdemo4.record,webdemo4.user\n" +
                        "where record.userid=user.id and \n" +
                        "DATE_FORMAT(opentime,'%Y') = '"+y+"' and \n" +
                        "userid='"+userId+"'"+"order by opentime");
            }
            else if (m!=null&&d==null){
                rs= DBconn.selectSql("select record.id ,opentime,userid,user.louhao,name from \n" +
                        "webdemo4.record,webdemo4.user\n" +
                        "where record.userid=user.id and \n" +
                        "DATE_FORMAT(opentime,'%Y-%m') = '"+y+"-"+m+"' and \n" +
                        "userid='"+userId+"'"+"order by opentime");
            }
            while(rs.next()){
                Record record = new Record();
                record.setId(rs.getString("id"));
                record.setLouHao(rs.getString("louhao"));
                record.setOpenTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(rs.getTimestamp("opentime")));
                record.setUserId(userId);
                record.setUserName(rs.getString("name"));
                list.add(record);
            }
            DBconn.closeConn();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<Record> queryRecordByname(String userName, String y, String m, String d) {
        List<Record> list = new ArrayList<>();
        try {
            DBconn.init();
            ResultSet rs = DBconn.selectSql("select record.id ,opentime,userid,user.louhao,name from \n" +
                    "webdemo4.record,webdemo4.user\n" +
                    "where record.userid=user.id and \n" +
                    "DATE_FORMAT(opentime,'%Y-%m-%d') = '"+y+"-"+m+"-"+d+"' and \n" +
                    "name='"+userName+"'"+"order by opentime");
            if(m==null&&d==null){
                rs= DBconn.selectSql("select record.id ,opentime,userid,user.louhao,name from \n" +
                        "webdemo4.record,webdemo4.user\n" +
                        "where record.userid=user.id and \n" +
                        "DATE_FORMAT(opentime,'%Y') = '"+y+"' and \n" +
                        "name='"+userName+"'"+"order by opentime");
            }
            else if (m!=null&&d==null){
                rs= DBconn.selectSql("select record.id ,opentime,userid,user.louhao,name from \n" +
                        "webdemo4.record,webdemo4.user\n" +
                        "where record.userid=user.id and \n" +
                        "DATE_FORMAT(opentime,'%Y-%m') = '"+y+"-"+m+"' and \n" +
                        "name='"+userName+"'"+"order by opentime");
            }
            while(rs.next()){
                Record record = new Record();
                record.setId(rs.getString("id"));
                record.setLouHao(rs.getString("louhao"));
                record.setOpenTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(rs.getTimestamp("opentime")));
                record.setUserId(rs.getString("userid"));
                record.setUserName(rs.getString("name"));
                list.add(record);
            }
            DBconn.closeConn();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public int addImgPath(String userId, String Path) {
        String sql = "update webdemo4.user\n" +
                "set imgpath = '"+Path+"'\n" +
                "where id = '"+userId+"'";
        DBconn.init();
        int i = DBconn.addUpdDel(sql);
        return i;
    }
}
