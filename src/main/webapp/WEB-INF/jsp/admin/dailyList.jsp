<!DOCTYPE html>
<%-- jsp 指令 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%-- 引入 JSTL，使用 c,fmt,fn 标准标签库 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<html style="height:100%;width:100%;overflow: hidden;">

<head>
    <link rel="icon" href="img/ico/qr_blue.ico" type="image/x-icon">
    <link href="css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
    <script src="js/bootstrap/3.3.6/bootstrap.min.js"></script>
    <script src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery-1.5.2.min.js"></script>
    <link href="css/noteList.css" rel="stylesheet">

    <style type="text/css">
        .highlight {background-color: #ffe045; }
    </style>

    <script language="JavaScript">
        // 回车事件
        $(function () {
            $("#searchKey").keydown(function (e) {
                if (e.keyCode == 13) {
                    searchAjax();
                }
            });
        });

        // 删除确认
        $(function(){
            $("a").click(function(){
                var deleteLink = $(this).attr("deleteLink");
                console.log(deleteLink);
                if("true" == deleteLink){
                    var confirmDelete = confirm("确认要删除");
                    if(confirmDelete)
                        return true;
                    return false;
                }
            });
        });

        // 搜索
        function searchDaily() {
            var hightLightStr = $("#searchKey").val();
            $.ajax({
                type: "POST",
                url:"search_daily",
                data: {
                    "searchKey" : hightLightStr
                },
                success:function(data) {
                    var str = "";
                    // 遍历
                    $(data).each(function (index) {
                        str += " <tr class='ajax_tr'>" +
                            "<td><a onclick='previewDaily(" + data[index].id + ")'>" + data[index].id + "</a></td>" +
                            "<td class='title_tr'>" +
                            "<a href='show_daily?id=" + data[index].id + "' target='_blank'>" +
                            data[index].title +
                            "</a>" +
                            "</td>" +
                            "<td>" + data[index].location + "</td>" +
                            "<td>" + data[index].date + "</td>" +
                            "<td>" +
                            "<a href='edit_note_page?id=" + data[index].id + "'>" +
                            "<button type='button'' class='btn btn-success'>编辑</button>" +
                            "</a>" +
                            "<a href='delete_note?id=" + data[index].id + "' deleteLink='true'>" +
                            "<button type='button' class='btn btn-danger'>删除</button>" +
                            "</a>" +
                            "</td>"
                            + "</tr>";
                    });
                    jQuery('.ajax_tr').html(str);
                    // 高亮
                    $(".title_tr").highlight(hightLightStr);
                }
            });
        }

         // 预览笔记
        function previewDaily(id){
            $.ajax({
                type: "POST",
                url: "preview_daily",
                data: {
                    "id": id
                },
                success: function (data) {
                    $(".preview").html(data.content);
                    $(".preview").highlight($("#searchKey").val());
                }
            })
        }
        
    </script>
</head>
<body style="height:100%;width:100%;padding:0;margin: 0;">

<title>DailyList</title>

<div class="i_header">
    <div class="button_group">
        <a href="insert_daily_page" target="_blank">
            <button type="button" class="btn btn-default">
                <span class="glyphicon glyphicon-plus"></span>Daily
            </button>
        </a>
        <a href="insert_year_list_page" target="_blank">
            <button type="button" class="btn btn-default">
                <span class="glyphicon glyphicon-plus"></span>总结
            </button>
        </a>

        <div style="width: auto;float:right;">
            <input style="width: auto;display:inline;" id="searchKey" name="searchKey" type="text" class="form-control input-search-title" placeholder="key">
            <button style="width: auto" type="submit" class="btn btn-default" onclick="searchDaily()">
                <span class="glyphicon glyphicon-search">搜索</span></button>
        </div>
    </div>
</div>

<div class="i_content" style="height: 94%">

    <%-- 日志：年份列表 --%>
    <div class="group1">
        <ul class="topnav" style="width: 100%;margin: 0px;">
            <li><a href="note_list">笔记</a></li>
            <li><a>日志</a>
                <ul style="overflow: hidden; display: block;"> <!--标签默认打开-->
                    <c:forEach items="${yearList}" var="y">
                        <li><a href="daily_list?year=${y}">${y}</a></li>
                    </c:forEach>
                </ul>
            </li>
        </ul>
    </div>

    <%-- 年度总结 --%>
    <div class="group2">
        <ul class="topnav" style="width: 100%;margin: 0px;">
            <li><a>年度总结</a>
                <ul style="overflow: hidden; display: block;"> <!--标签默认打开-->
                    <c:forEach items="${dailyYearList}" var="y">
                        <li><a href="year_list?year=${y}">${y}</a></li>
                    </c:forEach>
                </ul>
            </li>
        </ul>

    </div>

    <%-- 日志列表 --%>
    <div class="note_list" id="note_list_hight_light" style="overflow-y: scroll;width: 50%">
        <div class="table_list">
            <table class="table table-striped">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>标题</th>
                    <th>地点</th>
                    <th>日期</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody class="ajax_tr">
                <c:forEach items="${dailyList}" var="daily">
                    <tr>
                        <td>
                            <a onclick="previewDaily(${daily.id})" >
                                ${daily.id}
                            </a>
                        </td>
                        <td id="title_tr">
                            <a href="show_daily?id=${daily.id}" target="_blank">
                                <%-- 如果标题超过 20 个字，则超过部分显示为... --%>
                                <c:if test="${fn:length(daily.title)>'22'}">
                                    ${fn:substring(daily.title,0,22)}...
                                </c:if>
                                <c:if test="${fn:length(daily.title)<='22'}">
                                    ${daily.title}
                                </c:if>
                            </a>
                        </td>
                        <td>${daily.location}</td>
                        <td>${daily.date}</td>
                        <td>
                            <a href="edit_note_page?id=${daily.id}">
                                <button type="button" class="btn btn-success">编辑</button>
                            </a>
                            <a href="delete_note?id=${daily.id}" deleteLink="true">
                                <button type="button" class="btn btn-danger">删除</button>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

    </div>

    <%-- 预览列表 --%>
    <div class="preview" style="overflow: scroll">
    </div>

</div>


<script type="text/javascript" src="js/scriptbreaker-multiple-accordion-1.js"></script>
<script type="text/javascript" src="js/jquery.highlight.js"></script>

<script language="JavaScript">

    $(document).ready(function() {
        $(".topnav").accordion({
            accordion:false,
            speed: 500,
            closedSign: '[+]',
            openedSign: '[-]'
        });
    });

</script>
