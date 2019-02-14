<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>CaptainQR-index</title>
    <link rel="stylesheet" type="text/css" href="css/login/normalize.css" />
    <link rel="stylesheet" type="text/css" href="css/login/demo.css" />
    <!--必要样式-->
    <link rel="stylesheet" type="text/css" href="css/login/component.css" />
</head>
<body>
<%
    session.removeAttribute("userSession");
    session.removeAttribute("isDaily");
%>
</body>
</html>