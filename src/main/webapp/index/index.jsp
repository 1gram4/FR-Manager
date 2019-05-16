<%--
  Created by IntelliJ IDEA.
  User: pao
  Date: 2019/3/5
  Time: 13:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%String path = request.getContextPath()+"/index";%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>上海大学人脸识别</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="robots" content="all,follow">
    <!-- Bootstrap CSS-->
    <link rel="stylesheet" href="<%=path%>/vendor/bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome CSS-->
    <link rel="stylesheet" href="<%=path%>/vendor/font-awesome/css/font-awesome.min.css">
    <!-- Fontastic Custom icon font-->
    <link rel="stylesheet" href="<%=path%>/css/fontastic.css">
    <!-- Google fonts - Poppins -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins:300,400,700">
    <!-- theme stylesheet-->
    <link rel="stylesheet" href="<%=path%>/css/style.sea.css" id="theme-stylesheet">
    <!-- Custom stylesheet - for your changes-->
    <link rel="stylesheet" href="<%=path%>/css/custom.css">
    <!-- Favicon-->
    <link rel="shortcut icon" href="<%=path%>/img/favicon.ico">
    <!-- Tweaks for older IEs--><!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script><![endif]-->
    <script type="text/javascript">
        function doLogout(){
            //访问LogoutServlet注销当前登录的用户
            window.location.href="${pageContext.request.contextPath}/Servlet/LogoutServlet";
        }
    </script>
</head>
<%
    if(session.getAttribute("user")==null){
        String message = String.format(
                "检测到您没登入，1秒后为您自动跳到登入页！！<meta http-equiv='refresh' content='1;url=%s'",
                request.getContextPath()+"/Servlet/LoginUIServlet");
        request.setAttribute("message",message);
        request.getRequestDispatcher("/WEB-INF/pages/message.jsp").forward(request, response);
    }

%>
<body>
<div class="page">
    <!-- Main Navbar-->
    <header class="header">
        <nav class="navbar">
            <!-- Search Box-->

            <div class="container-fluid">
                <div class="navbar-holder d-flex align-items-center justify-content-between">
                    <!-- Navbar Header-->
                    <div class="navbar-header">
                        <!-- Navbar Brand --><a href="index.html" class="navbar-brand d-none d-sm-inline-block">
                        <div class="brand-text d-none d-lg-inline-block"><span style="font-size: 35px;font-family: '微软雅黑 Light'">SHU </span>人脸识别门禁管理平台</div>
                        <div class="brand-text d-none d-sm-inline-block d-lg-none"><strong>BD</strong></div></a>
                        <!-- Toggle Button--><a id="toggle-btn" href="#" class="menu-btn active"><span></span><span></span><span></span></a>
                    </div>
                    <!-- Navbar Menu -->
                    <ul class="nav-menu list-unstyled d-flex flex-md-row align-items-md-center">

                        <!-- Logout    -->
                        <li class="nav-item"> <span onclick="doLogout()">注销</span><i class="fa fa-sign-out"></i></li>
                    </ul>
                </div>
            </div>
        </nav>
    </header>
    <div class="page-content d-flex align-items-stretch">
        <!-- Side Navbar -->
        <nav class="side-navbar">
            <!-- Sidebar Header-->
            <div class="sidebar-header d-flex align-items-center">
                <div class="avatar"><img src="<%=path%>/img/touxiang.jpg" alt="..." class="img-fluid rounded-circle"></div>
                <div class="title">
                    <h1 class="h4">${user.userName}</h1>
                    <p style="color: black">${user.id}</p>
                    <p style="color: black">遇见你真好！</p>
                </div>
            </div>
            <!-- Sidebar Navidation Menus-->
            <ul class="list-unstyled">
                <li id="li1" onclick="click1()" ><a><img src="<%=path%>/icon/index.png" style="height: 30px;width: 30px"/><div style="color: black">主页</div></a> </li>
                <li id="li2" onclick="click2()"><a><img src="<%=path%>/icon/chaxun.png" style="height: 30px;width: 30px"/><div style="color: black">查询</div ></a></li>
                <li id="li3" onclick="click3()"> <a><img src="<%=path%>/icon/baojing.png" style="height: 30px;width: 30px"/><div style="color: black">报警</div> </a></li>
                <li id="li4" onclick="click4()"> <a> <img src="<%=path%>/icon/kaimen.png " style="height: 30px;width: 30px"><div style="color: black">开门</div></a></li>
            </ul>
        </nav>
        <div class="content-inner">
            <!-- Page Header-->
            <header class="page-header">
                <div class="container-fluid">
                    <c:if test="${user.imgPath==null}">
                        <a href="${pageContext.request.contextPath }/uploadimg.jsp">检测到您没有采集人脸，将无法开门，请采集人脸</a>
                    </c:if>
                    <c:if test="${user.imgPath!=null}">
                        <h2 >您已采集人脸</h2>
                    </c:if>

                </div>
            </header>
            <!-- Dashboard Counts Section-->
            <section id='se1' class="dashboard-counts no-padding-bottom">
                <div class="container-fluid">
                    <div class="row bg-white has-shadow" style="height: 300px;margin-bottom: 30px">
                        <p style="margin-left: 140px;margin-top: 50px;font-size: 40px">这里什么都没有……<br></p>
                    </div>
                </div>
            </section>

            <section id='se2' class="dashboard-counts no-padding-bottom" >
                <div class="container-fluid">
                    <div class="row bg-white has-shadow" style="display: flex;flex-direction: column; height: 300px;margin-bottom: 30px">
                        <div style="margin-left:150px;">
                            <form name="date" action="${pageContext.request.contextPath }/Servlet/StudentQueryServlet">
                                <c:if test="${user.isStudent==0}">
                                    输入你要查找的学生的名字：<input style="width: 110px;border-style:double;border-radius: 10px;outline: none" name="studentName" type="text">
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
                        </div>
                        <div style="margin-left:150px;">
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
                        </div>

                    </div>
                </div>
            </section>

            <section id='se3' class="dashboard-counts no-padding-bottom" >
                <div class="container-fluid">
                    <div class="row bg-white has-shadow" style="height: 300px;margin-bottom: 30px">
                        <p style="margin-left: 140px;margin-top: 50px;font-size: 40px">3这里什么都没有……<br>祝您考试周顺利!</p>
                    </div>
                </div>
            </section>

            <section id='se4' class="dashboard-counts no-padding-bottom" >
                <div class="container-fluid">
                    <div class="row bg-white has-shadow" style="height: 300px;margin-bottom: 30px">
                        <p style="margin-left: 140px;margin-top: 50px;font-size: 40px">4这里什么都没有……<br>祝您考试周顺利!</p>
                    </div>
                </div>
            </section>
            <!-- Page Footer-->
            <footer class="main-footer">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-sm-6">
                            <p>高年级研讨小组 &copy; 2017-2019</p>
                        </div>
                        <div class="col-sm-6 text-right">
                            <p>Design by zwk </p>
                            <!-- Please do not remove the backlink to us unless you support further theme's development at https://bootstrapious.com/donate. It is part of the license conditions. Thank you for understanding :)-->
                        </div>
                    </div>
                </div>
            </footer>
        </div>
    </div>
</div>
<script src="../js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
    click2();
    function allhiden() {
        $("#se1").hide();
        $("#se2").hide();
        $("#se3").hide();
        $("#se4").hide();
    }
    function hidenActive() {
        $("#li1").removeClass("active");
        $("#li2").removeClass("active");
        $("#li3").removeClass("active");
        $("#li4").removeClass("active");
    }
    function click1() {
        hidenActive()
        allhiden();
        $("#se1").show();
        $("#li1").addClass("active")
    }
    function click2() {
        hidenActive()
        allhiden();
        $("#li2").addClass("active")
        $("#se2").show();
    }
    function click3() {
        hidenActive()
        allhiden();
        $("#se3").show();
        $("#li3").addClass("active")
    }
    function click4() {
        hidenActive()
        allhiden();
        $("#se4").show();
        $("#li4").addClass("active")
    }
</script>
<!-- JavaScript files-->
<script src="<%=path%>/vendor/jquery/jquery.min.js"></script>
<script src="<%=path%>/vendor/popper.js/umd/popper.min.js"> </script>
<script src="<%=path%>/vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="<%=path%>/vendor/jquery.cookie/jquery.cookie.js"> </script>
<script src="<%=path%>/vendor/chart.js/Chart.min.js"></script>
<script src="<%=path%>/vendor/jquery-validation/jquery.validate.min.js"></script>
<script src="<%=path%>/js/charts-home.js"></script>
<!-- Main File-->
<script src="<%=path%>/js/front.js"></script>
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
</body>
</html>
