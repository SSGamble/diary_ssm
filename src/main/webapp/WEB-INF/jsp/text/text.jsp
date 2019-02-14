<%--
  Created by IntelliJ IDEA.
  User: Gamble
  Date: 2018/12/2
  Time: 13:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="icon" href="img/ico/qr_blue.ico" type="image/x-icon">
    <link href="css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
    <script src="js/bootstrap/3.3.6/bootstrap.min.js"></script>
    <script src="js/jquery.min.js"></script>
    <script src="http://www.jq22.com/jquery/jquery-1.10.2.js"></script>
    <link href="css/noteList.css" rel="stylesheet">
    <title>Title</title>
    <script>
//        $(function() {
//            $("button").click(function() {
//                $.ajax({
//                    url:"text",
//                    success:function(data){
//                        // 遍历
//                        $(data).each(function(index){
//                            alert(data[index].title);
//                        });
//                    }
//                });
//            });
//        });

//        $(window).scroll(function() {
//            //$(document).scrollTop()    滚动条位置距页面顶部的距离；
//            //$(document).height()         整个页面的总高度；
//            //$(window).height()             当前窗口的高度；
//            if ($(document).scrollTop() >= $(document).height() - $(window).height()) {   //判断是否已经滚动到页面底部；
//                $("#loading").css("display", "block");                                                            //切换正在加载的数据的图片状态为显示；
//                $.ajax({                                                                                                          //加载ajax；
//                    url: 'text',                                                                                    //请求路径，这里的路径是一个json文件；
//                    success: function(data) {                                                                          //当请求成功时执行的回调函数；
//                        var str = "";
//                        $.each(data, function(i, item) {                                                            //遍历出来json里边的内容；i，表示当前遍历到第几条内容；item，表示当前遍历的对象；
//                            str +="<li>"+'姓名：' + item.title +"</li>"
//                        });
//                        $("#txt").append(str);                                                                          //把遍历到的内容追击到id为txt的div中；
//                        $("#loading").css("display", "none");                                                   //切换正在加载数据图片状态为不显示；
//                    }
//                });
//            }
//        });
    </script>
</head>
<body>
Text Page
<button class="button">click</button>
<%--<div id="test" style="height: 1000px;">test</div>                                        <!-- div高度设置高于当前浏览器窗口高度 -->--%>
<%--<div id="txt" ></div>                                                                                     <!-- 自动加载数据存放于该div中 -->--%>
<%--<img id="loading" style="display: none;" src="img/ico/qr_blue.ico" />             <!-- 正在加载的动画图 -->--%>
</body>
</html>
