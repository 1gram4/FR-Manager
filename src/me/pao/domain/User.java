package me.pao.domain;
import java.io.Serializable;
import java.util.Date;

public class User implements Serializable{
    private static final long serialVersionUID = -4313782718477229465L;

    // 用户ID
    private String id;
    // 用户名
    private String userName;
    // 用户密码
    private String userPwd;

    private String isStudent;

    private String imgPath;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserPwd() {
        return userPwd;
    }

    public void setUserPwd(String userPwd) {
        this.userPwd = userPwd;
    }

    public String getIsStudent() {
        return isStudent;
    }

    public void setIsStudent(String isStudent) {
        this.isStudent = isStudent;
    }

    public String getImgPath() {
        return imgPath;
    }

    public void setImgPath(String imgPath) {
        this.imgPath = imgPath;
    }
}
