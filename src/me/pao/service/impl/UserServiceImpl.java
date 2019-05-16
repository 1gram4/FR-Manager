package me.pao.service.impl;

import me.pao.dao.IUserDao;
import me.pao.dao.impl.UserDaoImpl;
import me.pao.domain.Record;
import me.pao.domain.User;
import me.pao.exception.UserExistException;
import me.pao.service.IUserService;

import java.util.Date;
import java.util.List;

public class UserServiceImpl implements IUserService {

    private IUserDao userDao = new UserDaoImpl();

    @Override
    public User loginUser(String userId, String userPwd) {
        return userDao.find(userId, userPwd);
    }
    @Override
    public List<Record> findRecord(String userId, String y,String m,String d){
        return userDao.queryRecord(userId,y,m,d);
    }

    @Override
    public List<Record> findRecordByName(String userName, String y, String m, String d) {
        return userDao.queryRecordByname(userName,y,m,d);
    }

    @Override
    public int addImgPath(String userId,String path){
        return userDao.addImgPath(userId,path);
    }
}