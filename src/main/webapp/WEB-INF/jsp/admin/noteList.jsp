<!DOCTYPE html>
<%-- jsp 指令 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false"%>
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
        .stick_td{
            background-color: #dff0d8;
        }
    </style>

    <script>
        var currentPage = 0 ;   //当前页
        var pages = ${pageTotal}; //总页数
        $("#searchKey").focus();

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

        // 获取笔记总数
        $(function() {
            $(".btn_get_note_total").click(function() {
                $.ajax({
                    url:"get_note_total",
                    success:function(data){
                        $(".span_note_total").html(data);
                    }
                });
            });
        });

        // Ajax 加载下一页笔记
        function nextPage(){
            // 是否在搜索页面，如果在搜索页面，数据是一次加载的，不需要再 ajax 下一页
            if($("#searchKey").val() != ""){
                return;
            }

            //如果总页数为0,直接return
            if (pages == 0)	{
                return;
            }

            currentPage++;  //当前页数 +1

            //当前页大于总页数,显示没有更多的提示语
            if(currentPage > pages){
//                $(".no_more").show();
                return;
            }
            //如果当前页大于1,显示正在加载的提示语
            if(currentPage >= 1){
                $(".div_loading").show();
            }

            //进行异步请求数据
            $.ajax({
                type: "POST",
                url:"get_note_list_ajax",
                data: {
                    "currentPage" : currentPage,
                    "currentGroup" :　"${currentGroup}"
                },
                success:function(data){
                    var str = ajaxNoteStr(data,"");
                    jQuery('.ajax_tr').append(str);
                    jQuery('.div_loading').hide();
                }
            });
        }

        function ajaxNoteStr(data,trClass) {
            var str = "";
            // 遍历
            $(data).each(function (index) {
                var title = data[index].title;
                var subTitle;
                if(title.length > 22){
                    subTitle = title.substring(0,22) + "...";
                }else {
                    subTitle = title;
                }
                str += " <tr " + trClass +">" +
                    "<td><a onclick='previewNote(" + data[index].id + ")'>" + data[index].id + "</a></td>" +
                    "<td>"+
                    "<a href='show_note?id="+data[index].id+"' title = '"+title+"' target='_blank'>"+
                    subTitle +
                    "</a>"+
                    "</td>"+
                    "<td>" + data[index].groups + "</td>" +
                    "<td>" + data[index].date + "</td>" +
                    "<td>" + data[index].gmt_modified + "</td>" +
                    "<td>" +
                    "<a target='_blank' href='edit_note?id=" + data[index].id + "'>" +
                    "<button type='button'' class='btn btn-success'>编辑</button>" +
                    "</a>" +
                    "<a href='delete_note?id=" + data[index].id + "' deleteLink='true'>" +
                    "<button type='button' class='btn btn-danger' style='margin-left: 0.3em'>删除</button>" +
                    "</a>" +
                    "</td>"
                    + "</tr>";
            });
            return str;
        }
        
        // 判定笔记列表是否滚动到底部
        $(document).ready(function (){
//            $(".no_more").hide();
            $(".div_loading").hide();

            var nScrollHight = 0; //滚动距离总长(注意不是滚动条的长度)
            var nScrollTop = 0; //滚动到的当前位置
            var nDivHight = $(".note_list").height();
            $(".note_list").scroll(function(){
                nScrollHight = $(this)[0].scrollHeight;
                nScrollTop = $(this)[0].scrollTop;
                if(nScrollTop + nDivHight >= nScrollHight)
                    nextPage();
            });
        });

        // 搜索
        function searchAjax() {
            var hightLightStr = $("#searchKey").val();
            $.ajax({
                type: "POST",
                url:"search_note_list_ajax",
                data: {
                    "searchKey" : hightLightStr
                },
                success:function(data) {
                    var str = ajaxNoteStr(data,"class='ajax_tr'");
                    jQuery('.ajax_tr').html(str);
                    // 高亮
                    $(".title_tr").highlight(hightLightStr);
                }
            });
        }

        // 预览笔记
        function previewNote(id) {
            $.ajax({
                type: "POST",
                url: "preview_note",
                data: {
                    "noteID": id
                },
                success: function (data) {
                    $(".preview").html(data.content);
                    $(".preview").highlight($("#searchKey").val());
                }
            })
        }

        // 日志
        function showDailyPwd() {
            var str =
                "<div class='password-ajax'>" +
                    "<form action='daily_list' method='post'>" +
                        "<input type='password' class='form-control' name='password' id='dailyPassword' placeholder='确认密码'/>" +
                        "<button type='submit' class='btn btn-success'>解锁</button>" +
                    "</form>" +
                "</div>";
                $(".preview").html(str);
                //获取焦点
                $("#dailyPassword").focus();
                // 回车事件，跳转日志页面
                $(function () {
                    $("#dailyPassword").keydown(function (e) {
                        if (e.keyCode == 13) {
                            showDailyPage();
                    }
                });
            });
        }
    </script>
</head>
<body style="height:100%;width:100%;padding:0;margin: 0;">

<title>NoteList</title>

<div class="i_header">
    <div class="button_group">
        <a href="insert_note_page" target="_blank">
            <button type="button" class="btn btn-default">
                <span class="glyphicon glyphicon-plus"></span>
                新增
            </button>
        </a>
        <a>
            <button type="button" class="btn btn-default btn_get_note_total">
                <span class="glyphicon glyphicon-refresh"></span>
                <span class="span_note_total">${noteTotal}</span>
            </button>
        </a>

        <div style="width: auto;float:right;">
            <input style="width: auto;display:inline;" id="searchKey" name="searchKey" type="text" class="form-control input-search-title" placeholder="key">
            <button style="width: auto" type="submit" class="btn btn-default" onclick="searchAjax()">
                <span class="glyphicon glyphicon-search">搜索</span></button>
        </div>
    </div>
</div>

<div class="i_content" style="height: 94%">

    <%-- 一级菜单 --%>
    <div class="group1">
        <ul class="topnav" style="width: 100%;margin: 0px;">
            <li><a onclick="showDailyPwd()">日志</a></li>
            <li><a href="#">笔记</a>
                <ul style="overflow: hidden; display: block;"> <!--标签默认打开-->
                    <c:forEach items="${rootGroupList}" var="g">
                        <li><a href="note_list?groups=${g.groups}">${g.groups}（${g.g_count}）</a></li>
                    </c:forEach>
                </ul>
            </li>
        </ul>
    </div>

    <%-- CS 列表 --%>
    <div class="group2">
        <ul class="topnav" style="width: 100%;margin: 0px;">
            <li><a href="#">CS</a>
                <ul style="overflow: hidden; display: block;"> <!--标签默认打开-->
                    <c:forEach items="${computerGroupList}" var="g">
                        <li><a href="note_list?groups=${g.groups}">${g.groups}(${g.g_count})</a></li>
                    </c:forEach>
                </ul>
            </li>
        </ul>

    </div>

    <%-- 笔记列表 --%>
    <div class="note_list" id="note_list_hight_light" style="overflow-y: scroll;width: 50%">
        <div class="table_list">
            <table class="table table-striped">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>标题</th>
                    <th>类别</th>
                    <th>创建日期</th>
                    <th>修改日期</th>
                    <th>操作</th>
                </tr>
                </thead>
                <%-- 默认笔记 --%>
                <tbody>
                <c:forEach items="${noteDefaultList}" var="n">
                    <tr>
                        <td class="default_td">${n.id}</td>
                        <td class="default_td"><a href="show_note?id=${n.id}" target="_blank">${n.title}</a></td>
                        <td class="default_td">${n.groups}</td>
                        <td class="default_td">${n.date}</td>
                        <td class="default_td">${n.gmt_modified}</td>
                        <td class="default_td">
                            <a href="edit_note?id=${n.id}" target="_blank">
                                <button type="button" class="btn btn-default">
                                    编辑
                                </button>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
                <%-- 置顶笔记 --%>
                <tbody>
                <c:forEach items="${noteStickList}" var="n">
                    <tr>
                        <td class="stick_td"><a onclick="previewNote(${n.id})">${n.id}</a></td>
                        <td class="stick_td">
                            <a href="show_note?id=${n.id}" title="${n.title}" target="_blank">
                                    <%-- 如果标题超过 22 个字，则超过部分显示为... --%>
                                <c:if test="${fn:length(n.title)>'22'}">
                                    ${fn:substring(n.title,0,22)}...
                                </c:if>
                                <c:if test="${fn:length(n.title)<='22'}">
                                    ${n.title}
                                </c:if>
                            </a>
                        </td>
                        <td class="stick_td">${n.groups}</td>
                        <td class="stick_td">${n.date}</td>
                        <td class="stick_td">${n.gmt_modified}</td>
                        <td class="stick_td">
                            <a href="edit_note?id=${n.id}" target="_blank">
                                <button type="button" class="btn btn-success">编辑</button>
                            </a>
                            <a href="delete_note?id=${n.id}" deleteLink="true">
                                <button type="button" class="btn btn-danger">删除</button>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                <%--<tr style="background-color: #638ecd"><td></td></tr>--%>
                </tbody>
                <%-- 最新笔记 --%>
                <tbody class="ajax_tr">
                <c:forEach items="${noteList}" var="n">
                    <tr>
                        <td><a onclick="previewNote(${n.id})">${n.id}</a></td>
                        <td id="title_tr">
                            <a href="show_note?id=${n.id}" title="${n.title}" target="_blank">
                                <%-- 如果标题超过 22 个字，则超过部分显示为... --%>
                                <c:if test="${fn:length(n.title)>'22'}">
                                    ${fn:substring(n.title,0,22)}...
                                </c:if>
                                <c:if test="${fn:length(n.title)<='22'}">
                                    ${n.title}
                                </c:if>
                            </a>
                        </td>
                        <td>${n.groups}</td>
                        <td>${n.date}</td>
                        <td>${n.gmt_modified}</td>
                        <td>
                            <a href="edit_note?id=${n.id}" target="_blank">
                                <button type="button" class="btn btn-success">编辑</button>
                            </a>
                            <a href="delete_note?id=${n.id}" deleteLink="true">
                                <button type="button" class="btn btn-danger">删除</button>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <%-- 正在加载 --%>
            <div class="div_loading" style="background-color: #614574;width: 100%;text-align: center;">
                <img src="img/loading.gif"  style="width:auto;margin: auto;height: 5em;">
                <img src="img/loading.gif"  style="width:auto;margin: auto;height: 5em;">
                <img src="img/loading.gif"  style="width:auto;margin: auto;height: 5em;">
                <img src="img/loading.gif"  style="width:auto;margin: auto;height: 5em;">
                <img src="img/loading.gif"  style="width:auto;margin: auto;height: 5em;">
            </div>
            <%-- 已没有更多数据 --%>
            <%--<div class="no_more" style="background-color: #145c74;width: 100%;text-align: center;height: 3em;font-size: x-large;">--%>
                <%--<span>到底了！！！</span>--%>
            <%--</div>--%>
        </div>

        <%-- 分页 --%>
        <%--<div class="nav_page">--%>
            <%--<%@ include file="../include/admin/adminPage.jsp" %>--%>
        <%--</div>--%>
    </div>

    <%-- 预览列表 --%>
    <div class="preview" style="overflow: scroll">
        <%--<div class='password-ajax'>--%>
            <%--<form action='daily_list' method='post'>--%>
                <%--<input type='password' class='form-control' name="password" id='dailyPassword' placeholder='确认密码'/>--%>
                <%--<button type='submit' class='btn btn-success'>解锁</button>--%>
            <%--</form>--%>
        <%--</div>--%>
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
