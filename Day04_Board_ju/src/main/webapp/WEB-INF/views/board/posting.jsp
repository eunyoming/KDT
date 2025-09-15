<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q"
            crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
            integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/boards/posting.css">
</head>
<body>
<div class="container">
    <%--    <form id="postingFrm" action="/board/posting" method="post" enctype="multipart/form-data">--%>
    <form id="postingFrm" action="/board/posting" method="post">
        <div class="row title">
            <div class="col">
                <input type="text" class="form-control" name="title" placeholder="글 제목을 입력하세요.">
            </div>
        </div>
        <div class="row file">
            <div class="col">
                <%--                <input type="file" class="form-control" name="files" placeholder="파일 선택">--%>
            </div>
        </div>
        <div class="row contents">
            <div class="col form-control divContents" contenteditable="true" data-placeholder="내용을 입력하세요."></div>
            <input type="hidden" name="contents">
        </div>
        <div class="row sideMenu m-0 p-0">
            <div class="col m-0 p-0" align="right">
                <div class="btn-group" role="group">
                    <button type="button" class="btn btn-secondary"
                            onclick="location.href='/board/list'">취소
                    </button>
                    <button class="btn btn-primary">등록</button>
                </div>
            </div>
        </div>
    </form>

    <script>
        $("#postingFrm").on("submit", function () {
            $("[name = contents]").val($(".divContents").html());
        });
    </script>
</div>
</body>
</html>
