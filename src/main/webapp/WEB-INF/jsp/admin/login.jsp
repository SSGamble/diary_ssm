<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>CaptainQR</title>
    <link rel="stylesheet" type="text/css" href="css/login/normalize.css" />
    <link rel="stylesheet" type="text/css" href="css/login/demo.css" />
    <!--必要样式-->
    <link rel="stylesheet" type="text/css" href="css/login/component.css" />
</head>
<body>
<div class="container demo-1">
    <div class="content">
        <div id="large-header" class="large-header">
            <canvas id="demo-canvas"></canvas>
            <div class="logo_box">
                <h3>CaptainQR</h3>
                <form action="login_check" method="post">
                    <div class="input_outer">
                        <input name="password" class="text" style="color: #FFFFFF !important; position:absolute; z-index:100;" type="password" placeholder="请输入密码">
                    </div>
                    <input class="act-but submit mb2" value="登录" type="submit" style="color: #FFFFFF;width: 100%;">
                </form>
            </div>
        </div>
    </div>
</div><!-- /container -->
<script src="js/login/TweenLite.min.js"></script>
<script src="js/login/EasePack.min.js"></script>
<script src="js/login/rAF.js"></script>
<script src="js/login/demo-1.js"></script>
</body>
</html>