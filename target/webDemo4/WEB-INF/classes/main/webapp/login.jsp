<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
    <title>上海大学人脸识别门禁管理系统</title>
    <link  rel="stylesheet" type="text/css" href="login.css">
</head>


<body onload="daoying()">
<%
    if(session.getAttribute("user")!=null){
        String message = String.format(
                "检测到您已经登入，1秒后为您自动跳到首页！！<meta http-equiv='refresh' content='1;url=%s'",
                request.getContextPath()+"/index/index.jsp");
        request.setAttribute("message",message);
        request.getRequestDispatcher("/WEB-INF/pages/message.jsp").forward(request, response);
    }

%>
<div style="background-color: white;width: 985px;padding-top: 80px;padding-right: 15px;padding-left: 15px;margin-right: auto;margin-left: auto;">
    <div style="margin: 0px auto;display: flex;">
        <img style="height: 90%;width: 280px" src="${pageContext.request.contextPath }/logo2.jpg">
        <h1 style="margin-top: 30px;font-family:'华文楷体';font-size: 45px">人脸识别门禁管理平台</h1>
    </div>
    <div style="width: 985px;height: 400px;">
        <div style="float: left;width: 665px;height: 390px;margin: 5px 10px 5px 0px;">
            <img style="float: left;width: 665px;height: 390px;margin: 5px 10px 5px 0px;" src="${pageContext.request.contextPath }/login2.jpg">
        </div>


        <form id="login" action="${pageContext.request.contextPath }/Servlet/LoginServlet" method="post">

            <div style="padding: 30px 0 0 30px;float: left;width: 273px;height: 360px;margin: 5px 0px 7px 5px;border: solid 1px #d3dbdf;background-color: #f9fcfd;position: relative;">
                <div id="userloign" style="font-size: 18px;font-family: '微软雅黑';color: #0080b0;padding-bottom: 20px;">用户登录</div>
                <div style="position: relative;color: #686c70;font-size: 14px;font-family: '微软雅黑';padding-top: 20px;">
                    学号\工号<input style="margin-left: 15px;height: 30px;border-radius: 3px;width: 175px;" name="userid" id="user" type="text">
                </div>
                <div style="position: relative;color: #686c70;font-size: 14px;font-family: '微软雅黑';padding-top: 20px;">
                    密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码<input style="margin-left: 10px;height: 30px;border-radius: 3px;width: 175px;" type="password" name="password" id="password">
                </div>

                <input type="submit" style="background-color: #0080b0;border-radius: 10px;color: white;font-size: 14px;text-align: center;width: 100px;height: 30px;line-height: 30px;border: none;position: relative;display: block;top: 20px;left: -20px;margin-left: 130px;" value="登录"><br /> <span style="display: inline-block;width: 252px;height: 1px;background: #d6d6d6;"></span>
                <br /> <a href="test.jsp" style="text-decoration:none;position: relative; /*top: 20px;*/color: #71a8ca;font-size: 12px;font-family: '微软雅黑';">忘记密码了？</a>

            </div>
        </form>
    </div>
    <span style="display: inline-block;width: 985px;height: 1px;background: #d6d6d6;"></span>
    <div style="font-family:'微软雅黑';font-size: 12px;color: #6a6a6b;">
        <div style="float: left;">
            <p>地址：上海市宝山区上大路99号 邮编：200444</p>
            <p>信息服务电话：12345678</p>
        </div>
        <div style="text-align: right;">
            <p style="text-align: right;">技术支持 高年级研讨小组</p>
            <p style="text-align: right;">Copyright © 2012-2017 Shanghai University, All Rights
                Reserved</p>
        </div>
    </div>
</div>
<script type="text/javascript">
    function daoying() {
        tat = document.getElementById("userloign").innerHTML
        aaa = ""
        ja = ""
        for (i = 19, a = 20; i < 58; i++, a--) {
            ja += "<div style='overflow:hidden;width:328px;height:1px;position:absolute;top:" + (i + 35) + "px;left:30px;filter:alpha(opacity=" + a + ");opacity:" + (a / 100) + "'><p class='daoying' style='margin:-" + (18 - (i - 18)) + "px 0px 0px 0px'>" + tat + "</p></div>"
        }
        userloign.innerHTML += ja
    }
</script>
</body>
</html>
