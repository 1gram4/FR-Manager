<%@ page language="java"  pageEncoding="UTF-8"%>
<%--为了避免在jsp页面中出现java代码，这里引入jstl标签库，利用jstl标签库提供的标签来做一些逻辑判断处理 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html>
<head>
    <title>首页</title>
    <script type="text/javascript">
        function doLogout(){
            //访问LogoutServlet注销当前登录的用户
            window.location.href="${pageContext.request.contextPath}/Servlet/LogoutServlet";
        }
    </script>
</head>

<body>
<h1>上海大学住宿管理系统</h1>
<hr/>
<%
    if(session.getAttribute("user")==null){
        String message = String.format(
                "检测到您没登入，1秒后为您自动跳到登入页！！<meta http-equiv='refresh' content='1;url=%s'",
                request.getContextPath()+"/Servlet/LoginUIServlet");
        request.setAttribute("message",message);
        request.getRequestDispatcher("/WEB-INF/pages/message.jsp").forward(request, response);
    }

%>
<c:if test="${user!=null}">
    欢迎您：${user.userName}${user.id}
    <input type="button" value="退出登陆" onclick="doLogout()">
</c:if>
<hr/>
<c:if test="${user.imgPath==null}">
    <a href="${pageContext.request.contextPath }/uploadimg.jsp">检测到您没有采集人脸，将无法开门，请采集人脸</a>
</c:if>

<h2>查寻您的进出记录</h2>

<form name="date" action="${pageContext.request.contextPath }/Servlet/StudentQueryServlet">
    <c:if test="${user.isStudent==0}">
        输入你要查找的学生的名字：<input name="studentName" type="text">
    </c:if>
    <select name="year" onchange="selectYear(this.value)">
        <option value=" ">选择 年</option>
    </select>
    <select name="month" onchange="selectMonth(this.value)">
        <option value="33">选择 月</option>
    </select>
    <select name="day">
        <option value="33">选择 日</option>
    </select>
    <input type="submit" value="搜索"/>
</form>
<hr/>
<script language="JavaScript">
    function dateStart()
    {
        //月份对应天数
        MonHead = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        //给年下拉框赋内容
        var y  = new Date().getFullYear();
        for (var i = (y-20); i < (y+1); i++) //以今年为准，前50年，后50年
            document.date.year.options.add(new Option(" "+ i +" 年", i));
        //给月下拉框赋内容
        for (var i = 1; i < 13; i++)
            document.date.month.options.add(new Option(" " + i + " 月", i));
        document.date.year.value = y;
        document.date.month.value = new Date().getMonth() + 1;
        var n = MonHead[new Date().getMonth()];
        if (  new Date().getMonth() ==1 && IsPinYear()  )
            n++;
        writeDay(n); //赋日期下拉框
        document.date.day.value = new Date().getDate();
    }
    if(document.attachEvent)
        window.attachEvent("onload", dateStart);
    else
        window.addEventListener('load', dateStart, false);
    function selectYear(str) //年发生变化时日期发生变化(主要是判断闰平年)
    {
        if(document.date.month.options.length == 1){
            for (var i = 1; i < 13; i++)
                document.date.month.options.add(new Option(" " + i + " 月", i));
        }
        var yearvalue = document.date.year.options[document.date.year.selectedIndex].value;
        if (yearvalue == "")
        {

            var f = document.date.month;

            optionsClear(f);
            var e = document.date.day;
            optionsClear(e);
            return;

        }
        var monthvalue = document.date.month.options[document.date.month.selectedIndex].value;
        var n = MonHead[monthvalue - 1];
        if (  monthvalue ==2 && IsPinYear(str)  )
            n++;
        writeDay(n);
    }

    function selectMonth(str)   //月发生变化时日期联动
    {
        var yearvalue = document.date.year.options[document.date.year.selectedIndex].value;

        if (yearvalue == "")

        {

            var e = document.date.day;

            optionsClear(e);

            return;

        }

        var n = MonHead[str - 1];

        if (  str ==2 && IsPinYear(yearvalue)  )

            n++;

        writeDay(n);

    }



    function writeDay(n)   //据条件写日期的下拉框

    {

        var e = document.date.day; optionsClear(e);

        for (var i=1; i<(n+1); i++)

            e.options.add(new Option(" "+ i + " 日", i));

    }



    function IsPinYear(year)//判断是否闰平年

    {

        return(  0 == year%4 && ( year%100 !=0 || year%400 == 0 )  );

    }



    function optionsClear(e)

    {

        e.options.length = 1;

    }

</script>
<table border="1">
    <tr>
        <td>编号</td>
        <td>姓名</td>
        <td>学号</td>
        <td>楼号</td>
        <td>开门时间</td>
    </tr>
    <c:if test="${record!=null}">
        <c:forEach var="U" items="${record}">
            <tr>
                <td>${U.id}</td>
                <td>${U.userName}</td>
                <td>${U.userId}</td>
                <td>${U.louHao}</td>
                <td>${U.openTime}</td>
            </tr>
        </c:forEach>
    </c:if>
</table>
</body>
</html>
