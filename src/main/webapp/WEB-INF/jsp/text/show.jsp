<%-- jsp 指令 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%-- 引入 JSTL，使用 c,fmt,fn 标准标签库 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<body>
    <c:forEach items="${lst}" var="l">
        内容：${l.title} <br> 名字：${l.content}   <br>
        ------------------------------留言时间：${l.date} <br>
    </c:forEach>
</body>
</html>