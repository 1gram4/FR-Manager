package me.pao.service;

import me.pao.domain.Record;
import me.pao.domain.User;
import me.pao.exception.UserExistException;

import java.util.Date;
import java.util.List;

public interface IUserService {

    /**
     * 提供登录服务
     * @param userId
     * @param userPwd
     * @return
     */
    User loginUser(String userId, String userPwd);
    List<Record> findRecord(String userId, String y,String m,String d);
    List<Record> findRecordByName(String userName, String y,String m,String d);
    int addImgPath(String userId,String path);
}
