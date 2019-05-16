package me.pao.dao;
import me.pao.domain.Record;
import me.pao.domain.User;

import java.util.Date;
import java.util.List;

public interface IUserDao {
    /**
     * 根据用户名和密码来查找用户
     * @param userId
     * @param userPwd
     * @return 查到到的用户
     */
    User find(String userId, String userPwd);


    /**根据用户名来查找用户
     * @param userName
     * @return 查到到的用户
     */
    User find(String userName);

    List<Record> queryRecord(String userId, String y,String m,String d);
    List<Record> queryRecordByname(String userName, String y,String m,String d);
    int addImgPath(String userId,String Path);
}
