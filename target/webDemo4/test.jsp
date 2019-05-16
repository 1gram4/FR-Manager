<%--
  Created by IntelliJ IDEA.
  User: pao
  Date: 2019/2/28
  Time: 16:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% System.out.println("872");%>
<html>
<head>
    <title>Title</title>
    <script src="js/jquery-3.3.1.min.js">
    </script>
    <script>
        $(document).ready(function () {
            $("#n123").click(function () {
                alert("点击了提交");
            })
            }
        );
    </script>
    <link href="test.css" rel="stylesheet" type="text/css" >
</head>
<body>
<button class="btn" value="提交" id="n123">提交</button>
</body>
</html>
