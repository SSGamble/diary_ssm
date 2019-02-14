<%-- jsp 指令 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%-- 引入 JSTL，使用 c 和 fmt 两种标准标签库 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt' %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="utf-8" />
    <title>Markdown</title>

    <link href="css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
    <script src="js/bootstrap/3.3.6/bootstrap.min.js"></script>
    <script src="js/jquery.min.js"></script>
    <link rel="stylesheet" href="markdown/examplescss/style.css" />
    <link rel="stylesheet" href="markdown/css/editormd.css" />
    <link rel="shortcut icon" href="https://pandao.github.io/editor.md/favicon.ico" type="image/x-icon" />
    <!-- 下拉搜索 -->
    <link rel="stylesheet" href="css/select/bootstrap-3.3.4.css">
    <link rel="stylesheet" href="css/select/bootstrap-select.css">
    <script src="js/select/jquery.min.js"></script>
    <script src="js/select/bootstrap-3.3.4.js"></script>
    <script src="js/select/bootstrap-select.js"></script>

    <link rel="stylesheet" href="css/editNote.css">

    <style>
        body{
            background-color: #2A383E;
        }
        h1 {
            color: #3e8ea9;
            text-align: center;
        }
        .sub{
            width: auto;
        }
        .sel_div{
            width: auto;
            float: right;
            margin-right: 95px;
        }
    </style>

    <script type="text/javascript">
        // 保存笔记草稿
        function saveNoteDraft(){
            if($("#context").text() == "")
                return;

            $.ajax({
                type:"POST",
                url: "save_note_draft",
                data:{
                    content: $("#context").text()
                },
                success:function (data) {
                    document.getElementById("txtHint").innerHTML = data;
                },
                error:function () {
                    document.getElementById("txtHint").innerHTML="出错啦";
                }
            });
        }

        // 按键监听: alt + q
        function keyUp(e) {
            var currKey=0,e=e||event;
            currKey=e.keyCode||e.which||e.charCode;
            if(currKey == 81 && (e.altKey||e.metaKey)){
                saveNoteDraft();
                return false;
            }
        }
        document.onkeyup = keyUp;

        // 自动保存时间间隔
        var AutoSaveTime = 30000;//30 秒
        // 计时器对象
        var AutoSaveTimer;
        // 首先设置一次自动保存状态
        SetAutoSave();

        //自动保存函数
        function SetAutoSave() {
            AutoSaveTimer = setInterval("saveNoteDraft()",AutoSaveTime);
        }

    </script>
</head>
<body>
<div id="layout">
    <%--<header>--%>
        <%--<h1>知行合一</h1>--%>
    <%--</header>--%>
    <form id="daily" method="post" action="insert_note">
        <div class="sub">
            <div class="sel_div">
                <%-- 选择分类 --%>
                <select id="lunch" class="selectpicker" name="groups" data-live-search="true" title="选择分类">
                    <c:forEach items="${groupList}" var="g">
                        <option value="${g.groups}">${g.groups}</option>
                    </c:forEach>
                </select>

                <!-- 是否显示在首页 -->
                <select name="is_show">
                    <%--<c:choose>  --%>
                        <%--<c:when test ="${note.is_show = 1}"> --%>
                            <%--显示--%>
                        <%--</c:when>  --%>
                        <%--<c:otherwise>--%>
                            <%--不显示--%>
                        <%--</c:otherwise>--%>
                    <%--</c:choose>--%>
                    <option value="0">不显示</option>
                    <option value="1">显示</option>
                </select>

                <!-- 是否发布 -->
                <select name="publish">
                    <option value="0">不发布</option>
                    <option value="1">发布</option>
                </select>

                <button type="submit" class="btn btn-default"> 提交 </button>
            </div>

            <%-- 摘要 --%>
            <div class="summary">
                <input type="text" style="margin-left: 5%;width: 90%;" name="summary"/>
            </div>

        </div>

        <div id="test-editormd" style="width: 100%;">
            <textarea style="display:none;" name="content" id="context"></textarea>
        </div>
    </form>
</div>

<!-- 自动保存信息 -->
<div id="txtHint" style="color: red;position: fixed;top: 0px;"></div>

<script src="markdown/examples/js/jquery.min.js"></script>
<script src="markdown/editormd.min.js"></script>
<script type="text/javascript">
    var testEditor;
    $(function() {
        testEditor = editormd("test-editormd", {
            width   : "90%",
            height  : "780px",
            syncScrolling : "single",
            path    : "markdown/lib/",
            imageUpload : true,
            imageFormats : ["jpg", "jpeg", "gif", "png", "bmp", "webp"],
            imageUploadURL : "/uploadfile",
            saveHTMLToTextarea : true,
            tex  : true,
        });
    });
</script>
</body>
</html>
