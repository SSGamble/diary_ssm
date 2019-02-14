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
    <title>Markdown</title>
    <link rel="stylesheet" href="markdown/examplescss/style.css" />
    <link rel="stylesheet" href="markdown/css/editormd.css" />
    <link rel="shortcut icon" href="https://pandao.github.io/editor.md/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="markdown/showdaily.css" />

    <style>
        .editormd-preview-active {
            align-content: center;
            width: 60%;
            padding: 40px;
            margin: auto;
        }

        /* 图片 */
        .markdown-body img {
            max-width: 60%;
            margin:0 auto;
            display:block;
        }

        /* 图片对应的文字 */
        .markdown-body em{
            text-decoration: underline;
            text-align: center;
            width: 100%;
            min-height: 22px;
            display: inline-block;
            margin: 0 auto;
            font-size: 14px;
            color: #969696;
            line-height: 1.7;
        }

        h1{
            color: #3e8ea9;
            text-align:center;
        }
        .markdown-body h1 {
            color: #3e8ea9;
            text-align:center;
        }

        .markdown-body strong{
            color: red;
        }

        .editormd-preview-container blockquote, .editormd-html-preview blockquote {
            color: #ff7c09;
            font-weight: bold;
            font-size: 14px;
            font-style: normal;
            padding-left: 10px;
        }

        .editormd .CodeMirror pre {
            font-size: 19px;
        }

        /* 主界面 */
        .editormd-preview-theme-dark .editormd-preview-container{
            height: 100%;
            width: 100%;
            background: #212B30;
            color: #A1A4A5;
        }

        /* 内部样式 */
        .markdown-body p,.markdown-body blockquote ,.markdown-body ul, .markdown-body ol, .markdown-body dl, .markdown-body table, .markdown-body pre {
            width: 60%;
            margin-left: 20%;
        }

        /* 文字 */
        .markdown-body p{
            font-size: 18px;
        }

        /* 加粗 */
        .markdown-body strong {
            color: #d10116;
        }

        /* li 下的 p */
        .markdown-body li > p {
            margin-left: 2px;
            width: 100%;
        }

        /* 引用样式 */
        .editormd-preview-theme-dark .editormd-preview-container blockquote {
            color: #294155;
            background: rgba(238, 238, 238, 0.04);
            border-color: #E48B7B;
        }

        /* 引用内的 p */
        .editormd-preview-theme-dark .editormd-preview-container blockquote p{
            width: 100%;
            margin-left: 12px;
            font-size: 16px;
            color: #DB653D;
        }

    </style>
</head>
<body style="background-color: #2A383E;">
<div id="layout">
    <div id="test-editormd">
        <textarea style="display:none;" name="content">${daily.content}</textarea>
    </div>
</div>

<script src="markdown/examples/js/jquery.min.js"></script>
<script src="markdown/editormd.min.js"></script>
<script type="text/javascript">
    var testEditor;
    $(function() {
        testEditor = editormd("test-editormd", {
            width   : "100%",
            height  : "100%",
            editorTheme: "pastel-on-dark",
            theme: "gray",
            previewTheme: "dark",
            syncScrolling : "single",
            path    : "markdown/lib/",
            imageUpload : true,
            imageFormats : ["jpg", "jpeg", "gif", "png", "bmp", "webp"],
            imageUploadURL : "/uploadfile",
            onload : function() {
                this.fullscreen();
                this.previewing();
            }
        });
    });
</script>
</body>
</html>

