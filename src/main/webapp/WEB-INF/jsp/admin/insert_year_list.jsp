<%-- jsp 指令 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%-- 引入 JSTL，使用 c 和 fmt 两种标准标签库 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt' %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="utf-8" />
    <title>insert_year_list_page</title>

</head>
<body>
<div id="layout">
    <header>
        <h1>insert_year_list_page</h1>
    </header>

    <form id="insert_year_list_page" method="post" action="insert_year_list">
        nid<input name="nid"></br>
        rank<input name="rank"></br>
        name<input name="name"></br>
        img<input name="img"></br>
        desc<input name="desc"></br>
        group<input name="group"></br>
        year<input name="year"></br></br>
        <input type="submit">
    </form>
</div>

</body>
</html>
