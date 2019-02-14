<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<body>
<form action="${pageContext.request.contextPath}/show" method="POST">
    内容：<input type="text" name="title"/><br>
    名字：<input type="text" name="content"/><br>
    <input type="submit" value="提交"/>
</form>
</body>
</html>