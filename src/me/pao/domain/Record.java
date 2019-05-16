package me.pao.domain;

import java.io.Serializable;
import java.util.Date;
public class Record implements Serializable{
    private static final long serialVersionUID = -4313782718477229465L;

    // 记录id
    private String id;
    // 用户名
    private String userName;
    //楼号
    private String louHao;

    private String openTime;

    private String userId;

    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getUserId() {
        return userId;
    }
    public void setUserId(String userId) {
        this.userId = userId;
    }
    public String getUserName() {
        return userName;
    }
    public void setUserName(String userName) {
        this.userName = userName;
    }
    public void setLouHao(String louHao){
        this.louHao = louHao;
    }
    public String getLouHao(){
        return louHao;
    }
    public String getOpenTime() {
        return openTime;
    }
    public void setOpenTime(String openTime) {
        this.openTime = openTime;
    }
}
