<%--
  Created by IntelliJ IDEA.
  User: pao
  Date: 2019/2/24
  Time: 15:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--为了避免在jsp页面中出现java代码，这里引入jstl标签库，利用jstl标签库提供的标签来做一些逻辑判断处理 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>上传图片</title>
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
<div style="display: flex;flex-direction: row ;width: 100%;">
    <div style="width:20%;height:200px;background-color:#ffffff">

    </div>

    <div style="margin-top:0;width:60%;height:850px;background-color: #fffde3" >
        <div style="margin-top:0;margin-right:40px;margin-left:40px;">
            <p style="margin-left: 33% ;margin-top:30px ;margin-bottom:0;font-family: '华文楷体';;font-size: 45px;">人脸采集</p>
        </div>

        <hr style="margin-left: 40px;margin-right: 40px"/>
        <video style="margin-top:30px;margin-left: 25%;width: 400px ; height: 300px" id="myVideo"  autoplay="autoplay" hidden></video>
        <img id="img" src="${pageContext.request.contextPath }/renlianshibie.png" onclick="imgClick()" style="margin-top:30px;margin-left: 23%;width: 400px ; height: 300px"/>
        <canvas width="400" height="300"  id="canvas" style="display: none"></canvas>
        <button   style="margin-top:30px;width:100px;height:30px;margin-left: 40%" onclick="gatherimg()">开始采集</button>
        <div style="display: flex;flex-direction: column;align-items: center;">
            <h3 id="bartext">，请稍等...</h3>
            <span style="display: inline-block;width: 50%;height: 20px;padding-right: 10px;border: 1px solid #999;border-radius: 5px;">
                <span id="progressBar" style="width:10%;height: 100%;display: inline-block; background: #90bf46;color: white;font-weight: bold;padding: 0 5px;text-align: right;border-radius: 5px;border-right: 1px solid #999;"></span>
            </span>
        </div>
    </div>

    <div style="width: 20%;height:300px;background-color: #ffffff">

    </div>
</div>
    <script src="js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript">
        navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || window.navigator.mozGetUserMedia;
        window.URL = window.URL || window.webkitURL;
        var video = document.getElementById('myVideo');
        var dataurl = null
        //video.addEventListener("click",snapshot,false);
        var canvas = document.getElementById("canvas");
        var  ctx = canvas.getContext('2d');
        var localMediaStream = null;
        var i=0;

        //进度条控制
        $(document).ready(function () {
            var interval = setInterval(function () {
                if (i<200) {
                    var widthTemp = (i / 2).toFixed(1) + '%';
                    $('#progressBar').css("width",widthTemp);
                    $('#bartext').text(widthTemp);
                } else {
                    clearInterval(interval);
                    $('h3').text('加载完成！正在为您跳转...');
                    setTimeout(function () {
                        location = 'index/index.jsp';
                    }, 1500);
                }
            }, 10);
        });
        function imgClick(){
            //显示video 隐藏图片
            $(document).ready(function () {
                $("#myVideo").show();
                $("#img").hide();
            });
            navigator.getUserMedia({video:true,audio:false},
                function (stream) {
                    video.src = window.URL.createObjectURL(stream);
                    localMediaStream = stream;
                },
                function (err) {
                    console.log(err);
                });
        }

        function gatherimg() {
            var myVar = setInterval(snapshot, 50);
            function snapshot() {
                i++;
                if (localMediaStream) {
                    ctx.drawImage(video, 0, 0, 400, 300);
                    dataurl = canvas.toDataURL('img/png');
                    document.getElementById('img').src = dataurl;
                    const blob = dataURItoBlob(dataurl);
                    uploadFile(dataurl)
                }
                if(i==200){
                    clearInterval(myVar);
                    //alert("采集完毕");
                }
            }
        }

        function uploadFile(dataurl) {
            var blob = dataURItoBlob(dataurl);
            var fd=new FormData();
            fd.append('i',i)
            fd.append('file',blob);
            $.ajax({
                url: 'http://localhost:8081/webDemo4_war_exploded/Servlet/GetPart',
                type:'POST',
                data: fd,
                processData: false,
                contentType: false,
                success: function (responseStr) {
                    if(responseStr.status===0){
                        console.log("成功"+responseStr);
                    }else{
                        console.log("失败");
                    }
                },
                error : function(responseStr) {
                    console.log("error"+responseStr);
                }
            });
        }

        function  dataURItoBlob(dataURI) {
            // convert base64/URLEncoded data component to raw binary data held in a string
            let byteString;
            if (dataURI.split(',')[0].indexOf('base64') >= 0) {
                byteString = atob(dataURI.split(',')[1]);
            } else byteString = unescape(dataURI.split(',')[1]);

            // separate out the mime component
            const mimeString = dataURI
                .split(',')[0]
                .split(':')[1]
                .split(';')[0];

            // write the bytes of the string to a typed array
            const ia = new Uint8Array(byteString.length);
            for (let i = 0; i < byteString.length; i++) {
                ia[i] = byteString.charCodeAt(i);
            }
            return new Blob([ia], { type: mimeString });
        }



    </script>
</body>
</html>
