<%-- jsp 指令 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false"%>
<%-- 引入 JSTL，使用 c 和 fmt 两种标准标签库 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt' %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="utf-8" />
    <title>Edit Note</title>

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
        <%--<h1>${note.title}</h1>--%>
    <%--</header>--%>
    <form id="daily" method="post" action="edit_note_fun">
        <div class="sub">
            <div class="sel_div">
                <%-- 选择分类 --%>
                <select id="lunch" class="selectpicker" name="groups" data-live-search="true" title="选择分类">
                    <option value="${note.groups}" selected = "selected">${note.groups}</option>
                    <c:forEach items="${groupList}" var="g">
                        <option value="${g.groups}">${g.groups}</option>
                    </c:forEach>
                </select>

                <!-- 是否显示在首页 -->
                <select name="is_show">
                    <c:if test="${note.is_show == 0}">
                        <option value="0" selected = "selected">不显示</option>
                        <option value="1">显示</option>
                    </c:if>
                    <c:if test="${note.is_show == 1}">
                        <option value="1" selected = "selected">显示</option>
                        <option value="0">不显示</option>
                    </c:if>
                </select>

                <!-- 是否发布 -->
                <select name="publish">
                    <c:if test="${note.publish == 0}">
                        <option value="0" selected = "selected">不发布</option>
                        <option value="1">发布</option>
                    </c:if>
                    <c:if test="${note.publish == 1}">
                        <option value="1" selected = "selected">发布</option>
                        <option value="0">不发布</option>
                    </c:if>
                </select>

                <button type="submit" class="btn btn-default"> 提交 </button>
            </div>

            <%-- 摘要 --%>
            <div class="summary">
                <input type="text" style="margin-left: 5%;width: 90%;" name="summary" value="${note.summary}"/>
            </div>

        </div>

        <div id="test-editormd">
            <textarea style="display:none;" name="content" id="context">${note.content}</textarea>
        </div>
        <textarea style="display:none;" name="id">${note.id}</textarea>
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
