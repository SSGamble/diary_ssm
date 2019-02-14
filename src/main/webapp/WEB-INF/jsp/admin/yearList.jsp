<%-- jsp 指令 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%-- 引入 JSTL，使用 c,fmt,fn 标准标签库 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>YearList File</title>

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/roll/onepage-scroll.css" />
    <script src="js/jquery-1.5.2.min.js"></script>

    <style type="text/css">
        body{
            padding: 0px;
            margin: 0px;
        }
        a{
            text-decoration:none;
            color: black;
        }
        a:focus, a:hover {
            color: white;
            text-decoration: none;
        }

        /******************************* 滚屏 ***************************************/
        .page1 {
            background: url("https://daily-1252869435.cos.ap-chengdu.myqcloud.com/2018-12-07-20-39-46.png");/**/
        }
        .page2 {
            background: url("https://daily-1252869435.cos.ap-chengdu.myqcloud.com/2018-12-07-22-05.jpg");
        }
        .page3 {
            background: url("https://daily-1252869435.cos.ap-chengdu.myqcloud.com/2018-12-7-22-04.jpg");
        }
        .page4 {
            background: url("https://daily-1252869435.cos.ap-chengdu.myqcloud.com/1464658095633.png");
        }

        /******************************* div遮罩 ***************************************/
        .tile {
            height: 300px;
            width: 200px;
            /*margin: 20px;*/
            background-color: #99aeff;
            display: inline-block;
            background-size: cover;
            position: relative;
            cursor: pointer;
            transition: all 0.4s ease-out;
            box-shadow: 0px 35px 77px -17px rgba(0, 0, 0, 0.44);
            overflow: hidden;
            color: black;
            font-family: "幼圆";
        }
        .tile img { position: absolute; top: 0; left: 0; z-index: 0; transition: all 0.4s ease-out; }
        .tile .text { z-index: 99;position: absolute; padding: 30px; height: calc(100% - 60px); }
        .tile h2 {
            font-size: 18px;
            font-weight: 900;
            margin-top: 10px;
            /* font-style: italic; */
            transform: translateX(200px);
        }
        .animate-text { opacity: 0; transition: all 0.6s ease-in-out; }
        .tile:hover { box-shadow: 0px 35px 77px -17px rgba(0, 0, 0, 0.64); transform: scale(1.05); }
        .tile:hover img { opacity: 0.2; }
        .tile:hover .animate-text { transform: translateX(0); opacity: 1; }
        .dots span { width: 5px; height: 5px; background-color: currentColor; border-radius: 50%; display: block; opacity: 0; transition: transform 0.4s ease-out, opacity 0.5s ease; transform: translateY(30px); }
        .tile:hover span { opacity: 1; transform: translateY(0px); }
        .dots span:nth-child(1) { transition-delay: 0.05s; }
        .dots span:nth-child(2) { transition-delay: 0.1s; }
        .dots span:nth-child(3) { transition-delay: 0.15s; }

        /******************************* 主页面 ***************************************/
        /* 榜单第一 */
        .top{
            width: 700px;
            height: 400px;
            float: right;
            margin-right: 10%;
            margin-top: 3%;
            /*background: red;*/
            display: inline;
        }
        .top_top{
            height: 100px;
            width: 100%;
            background: rgba(52, 171, 78, 0.36);
        }
        .top_con{
            width: 100%;
            height: 325px;
            background: rgba(144, 191, 148, 0.5);
        }
        .top_title{
            font-size: 30px;
            color: white;
            padding-top: 30px;
            padding-left: 40px;
        }
        .top_img{
            width: 212px;
            height: 312px;
            /*background: white;*/
            float: left;
            padding-left: 12px;
            padding-top: 12px;
        }
        .top_desc{
            padding: 5px;
            position: relative;
            width: 450px;
            height: 325px;
            float: right;
            /* background: white; */
            font-size: 25px;
            padding-right: 20px;
        }
        /* 第一 名字 */
        .top_filename{
            font-size: 55px;
            color: white;
            text-align: center;
            margin-top: 25px;
            font-family: "华文行楷";
        }
        /* 第一 简介 */
        .top_filename_desc{
            /*color: #A99B99;*/
            margin-top: 10px;
            position: absolute;
            bottom: 20px;
        }

        /* 榜单其他 */
        .other{
            display: inline;
            width: 1670px;
            height: 300px;
            /*background: white;*/
            float: left;
            margin-top: 50px;
            padding-left: 250px;
        }
        .music_other{
            width: 60%;
            margin: auto;
            margin-top: 20px;
        }
        .event_other{
            width: 65%;
            margin: auto;
            margin-top: 20px;
        }
        /* 榜单其他子项 */
        .con{
            height: 300px;
            width: 200px;
            float: left;
            overflow: hidden;
            position: relative;
            background-color: #4cd964;
            margin-right: 30px;
            margin-top: 20px;
        }
        .music_con{
            border-radius: 25px;
            padding-top: 30px;
            text-align: center;
            height: 90px;
            width: 480px;
            float: left;
            overflow: hidden;
            position: relative;
            background-color: rgba(249, 162, 103, 0.56);
            margin-right: 30px;
            margin-top: 20px;
            font-size: 36px;
            font-weight: 800;
            color: white;
            font-family: "华文行楷";
        }
        .event_con{
            border-radius: 25px;
            padding: 30px 10px 0px 10px;
            text-align: center;
            /*height: 100px;*/
            width: 100%;
            float: left;
            overflow: hidden;
            position: relative;
            background-color: rgba(109, 112, 173, 0.55);
            margin-right: 30px;
            margin-top: 20px;
            font-size: 36px;
            font-weight: 800;
            color: white;
            font-family: "华文行楷";
        }
        /* 角标 */
        .subscript{
            z-index: 999;
            color: #fff;
            height: 30px;
            width: 100px;
            position: absolute;
            right: -30px;
            text-align: center;
            line-height: 30px;
            font-family: "黑体";
            background-color: #0c60ee;
            -moz-transform:rotate(45deg);
            -webkit-transform:rotate(45deg);
            -o-transform:rotate(45deg);
            -ms-transform:rotate(45deg);
            transform:rotate(45deg);
        }
        /* 角标文字 */
        .subscript_number{
            transform: rotate(-45deg);
        }
        .img{
            width: 100%;
            height: 200px;
            /*background: red;*/
        }
        /* 其他 名字 */
        .name{
            font-family: "华文行楷";
            z-index: 999;
            width: 100%;
            height: 40px;
            background: rgba(220, 220, 220, 0.51);
            position: absolute;
            bottom: 0px;
            text-align: center;
            font-size: x-large;
            padding-top: 10px;
        }

        .music_con{

        }
    </style>

    <script>
        $(function(){
            $('.main').onepage_scroll({
                sectionContainer: '.page'
            });
        });
    </script>

</head>
<body>
<div class="main">
    <div class="page page1">
        <div id="main">
            <!-- 第一 -->
            <div class="top">
                <div class="top_top">
                    <div class="top_title">
                        ${year} 影视榜单
                    </div>
                </div>
                <div class="top_con">
                    <div class="top_img">
                        <img src="${moveTop.img}" width="200px" height="300px">
                    </div>
                    <div class="top_desc">
                        <div class="top_filename">
                            <c:if test="${moveTop.nid == '0'}">
                                <a href="#">${moveTop.name}</a>
                            </c:if>
                            <c:if test="${moveTop.nid != '0'}">
                                <a href="article?id=${moveTop.nid}" target="_blank">
                                    ${moveTop.name}
                                </a>
                            </c:if>
                        </div>
                        <div class="top_filename_desc">
                            ${moveTop.desc}
                        </div>
                    </div>
                </div>
            </div>

            <!-- 其他 -->
            <div class="other">
                <c:forEach items="${moveOtherList}" var="list">
                <c:if test="${list.nid == '0'}">
                    <a href="#">
                </c:if>
                <c:if test="${list.nid != '0'}">
                    <a href="article?id=${list.nid}"  target="_blank">
                </c:if>
                        <div class="con">
                            <div class="subscript">
                                <div class="subscript_number">${list.rank}</div>
                            </div>
                            <div class="img">
                                <div class="wrap">
                                    <div class="tile">
                                        <div class="text">
                                            <img src="${list.img}" width="200px" height="300px">
                                            <h2 class="animate-text">${list.desc}</h2>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="name">
                                ${list.name}
                            </div>
                        </div>
                    </a>
                    </c:forEach>
            </div>
        </div>
    </div>

    <div class="page page2">
        <div id="main2">
            <!-- 第一 -->
            <div class="top">
                <div class="top_top">
                    <div class="top_title">
                        ${year} 阅读榜单
                    </div>
                </div>
                <div class="top_con">
                    <div class="top_img">
                        <img src="${bookTop.img}" width="200px" height="300px">
                    </div>
                    <div class="top_desc">
                        <div class="top_filename">
                            <c:if test="${bookTop.nid} == 0">
                            <a href="#">
                            </c:if>
                            <c:if test="${bookTop.nid} != 0">
                                <a href="article?id=${bookTop.nid}" target="_blank">
                                    ${bookTop.name}
                                </a>
                            </c:if>
                        </div>
                        <div class="top_filename_desc">
                            ${bookTop.desc}
                        </div>
                    </div>
                </div>
            </div>

            <!-- 其他 -->
            <div class="other">
                <c:forEach items="${bookOtherList}" var="list">
                    <c:if test="${list.nid == '0'}">
                    <a href="#">
                    </c:if>
                    <c:if test="${list.nid != '0'}">
                        <a href="article?id=${list.nid}"  target="_blank">
                    </c:if>
                        <div class="con">
                            <div class="subscript">
                                <div class="subscript_number">${list.rank}</div>
                            </div>
                            <div class="img">
                                <div class="wrap">
                                    <div class="tile">
                                        <div class="text">
                                            <img src="${list.img}" width="200px" height="300px">
                                            <h2 class="animate-text">${list.desc}</h2>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="name">
                                ${list.name}
                            </div>
                        </div>
                    </a>
                    </c:forEach>
            </div>
        </div>
    </div>

    <div class="page page3">
        <div class="music_other">
            <c:forEach items="${musicList}" var="list">
            <div class="music_con">
                <p>${list.name} - ${list.desc}</p>
            </div>
            </c:forEach>
        </div>
    </div>

    <div class="page page4">
        <div class="event_other">
            <c:forEach items="${eventList}" var="list">
            <div class="event_con">
                <p>${list.name}</p>
            </div>
            </c:forEach>
        </div>
    </div>
</div>


<script src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/jquery-1.5.2.min.js"></script>
<script src="js/roll/jquery.onepage-scroll.min.js"></script>
</body>
</html>