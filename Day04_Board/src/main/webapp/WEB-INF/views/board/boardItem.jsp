<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <link rel="stylesheet" href="/boards/boardItem.css">
</head>
<body>
<div class="container">
    <form id="modifyFrm" action="/board/update">
        <input type="hidden" name="id" value="${post.id}">
        <div class="row title">
            <div class="col divTitle">${post.title}</div>
            <input type="hidden" name="title">
        </div>
        <hr>
        <div class="row">
            <div class="col writer">${post.writer}</div>
        </div>
        <div class="row">
            <div class="col writeDate"><fmt:formatDate value="${post.writeDate}" pattern="yyyy-MM-dd hh:mm"/>|
                조회: ${post.viewCount}</div>
        </div>
        <hr>
        <div class="row contents">
            <div class="col divContents">${post.contents}</div>
            <input type="hidden" name="contents">
        </div>
    </form>
    <hr>
    <div class="row fileContainer">
        <div class="col">
            <a href="/download.file">${file.oriName}</a>
        </div>
    </div>
    <div class="row sideMenu m-0 p-0">
        <div class="col m-0 p-0" align="right">
            <c:if test="${post.writer == sessionScope.loginId}">
                <button id="modifyBtn" type="button" class="btn btn-outline-success">수정</button>

                <button id="deleteBtn" type="button" class="btn btn-danger" data-bs-toggle="modal"
                        data-bs-target="#deletePost">삭제
                </button>

                <div class="modal fade" id="deletePost" tabindex="-1" aria-labelledby="deletePost" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5>정말 삭제 하시겠습니까?</h5>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">아니요</button>
                                <button type="button"
                                        onclick="location.href = '/board/delete?id=${post.id}&writer=${post.writer}'"
                                        class="btn btn-primary">예
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <button id="confirmBtn" class="btn btn-success d-none">수정완료</button>
                <button id="cancelBtn" class="btn btn-danger d-none">취소</button>

                <script>
                    $("#modifyBtn").on("click", function () {
                        $("#confirmBtn, #cancelBtn").toggleClass("d-none", false);
                        $("#modifyBtn, #deleteBtn, #backBtn").addClass("d-none").removeClass("d-inline-block");
                        $(".divTitle, .divContents").addClass("form-control").attr("contenteditable", true);
                    });

                    $("#cancelBtn, #confirmBtn").on("click", function () {
                        $("#confirmBtn, #cancelBtn").toggleClass("d-none", true);
                        $("#modifyBtn, #deleteBtn, #backBtn").addClass("d-inline-block").removeClass("d-none");
                        $("[name = divTitle], [name = divContents]").removeClass("form-control").attr("contenteditable", false);
                    });

                    $("#cancelBtn").on("click", function () {
                        location.reload();
                    });

                    $("#confirmBtn").on("click", function () {
                        $("[name = title]").val($(".divTitle").html());
                        $("[name = contents]").val($(".divContents").html());
                        $("<input>").attr({"type": "hidden", "name": "writer"}).val("${post.writer}");
                        $("#modifyFrm").submit();
                    });
                </script>
            </c:if>

            <button id="backBtn" type="button" class="btn btn-secondary"
                    onclick="location.href='/board/list'">목록으로
            </button>
        </div>
    </div>
    <hr>
    <form action="/insert.reply" id="commentFrm" method="post">
        <div class="row leave-comment">
            <div class="col-10 comment-contents">
                <div class="form-control" contenteditable="true" data-placeholder="댓글을 입력하세요."></div>
                <input type="hidden" id="comment-contents" name="comment">
                <input type="hidden" name="parentSeq">
                <input type="hidden" name="writer">
            </div>
            <div class="col-2">
                <button class="btn btn-outline-primary" id="comment-submit" type="button">등록</button>
                <script>
                    $("#comment-submit").on("click", function () {
                        $("#comment-contents").val($(".comment-contents div.form-control").html());

                        let params = new URLSearchParams(window.location.search);
                        $("[name = parentSeq]").val(params.get("seq"));
                        $("#commentFrm").submit();
                    });
                </script>
            </div>
        </div>
    </form>
    <hr class="mb-1">
    <div class="row comments m-0">
        <script>
            let replyList = ${reply};
            let loginId = "<c:out value="${sessionScope.loginId}" />";

            for (let reply of replyList) {
                let row = $("<div>").addClass("row p-0");
                row.css("margin-left", "10px");

                let writer = $("<div>").addClass("row m-0 p-0").html(reply.writer);
                writer.css("font-family", "Maruburi-Bold");

                let contents = $("<div>").addClass("row p-0 replyContents").html(reply.contents);
                contents.css({"font-size": "12px", "margin-left": "5px"});

                let footer = $("<div>").addClass("row m-0 p-0");
                let writeDate = $("<div>").addClass("col-6 p-0").html(milliToDate(reply.writeDate));
                writeDate.css({"font-size": "10px", "margin-bottom": "5px"});

                footer.append(writeDate);

                if (reply.writer === loginId) {
                    let btnGroup = $("<div>").addClass("col-6 modifyBtnGroup");

                    let modifyBtn = $("<button>").addClass("btn btn-outline-secondary modifyBtn");
                    modifyBtn.html("수정");

                    let modifyConfirmBtn = $("<button>").addClass("btn btn-outline-success modifyConfirmBtn");
                    modifyConfirmBtn.attr("type", "button");
                    modifyConfirmBtn.html("완료");

                    let modifyCancelBtn = $("<button>").addClass("btn btn-outline-danger modifyCancelBtn");
                    modifyCancelBtn.attr("type", "button");
                    modifyCancelBtn.html("취소");

                    let deleteBtn = $("<button>").addClass("btn btn-outline-danger deleteBtn");
                    deleteBtn.html("삭제");

                    modifyBtn.on("click", () => {
                        modifyCancelBtn.css("display", "inline-block");
                        modifyConfirmBtn.css("display", "inline-block");
                        modifyBtn.css("display", "none");
                        deleteBtn.css("display", "none");

                        contents.attr("contenteditable", "true");
                        contents.addClass("form-control");
                    });

                    modifyConfirmBtn.on("click", () => {
                        updateReply(reply, contents.html());
                    });

                    modifyCancelBtn.on("click", () => {
                        location.reload();
                    });

                    deleteBtn.on("click", () => {
                        deleteReply(reply);
                    });

                    btnGroup.append(modifyBtn);
                    btnGroup.append(modifyConfirmBtn);
                    btnGroup.append(modifyCancelBtn);
                    btnGroup.append(deleteBtn);

                    footer.append(btnGroup);
                }

                row.append(writer);
                row.append(contents);
                row.append(footer);

                $(".comments").append(row);
                $(".comments").append($("<hr>").addClass("mb-1"));
            }

            function updateReply(reply, modifiedContents) {
                let params = new URLSearchParams(window.location.search);
                let seq = $("<input>").attr({"type": "hidden", "name": "seq"}).val(reply.seq);
                let contents = $("<input>").attr({"type": "hidden", "name": "contents"}).val(modifiedContents);
                let writer = $("<input>").attr({"type": "hidden", "name": "writer"}).val(reply.writer);
                let parentSeq = $("<input>").attr({"type": "hidden", "name": "parentSeq"}).val(params.get("seq"));
                let updateFrm = $("<form>").attr({"action": "/update.reply", "method": "post"});

                updateFrm.append(seq, writer, parentSeq, contents);
                $(document.body).append(updateFrm);
                updateFrm.submit();
            }

            function deleteReply(reply) {
                let params = new URLSearchParams(window.location.search);
                let seq = $("<input>").attr({"type": "hidden", "name": "seq"}).val(reply.seq);
                let writer = $("<input>").attr({"type": "hidden", "name": "writer"}).val(reply.writer);
                let parentSeq = $("<input>").attr({"type": "hidden", "name": "parentSeq"}).val(params.get("seq"));
                let deleteFrm = $("<form>").attr({"action": "/delete.reply", "method": "post"});

                deleteFrm.append(seq, writer, parentSeq);
                $(document.body).append(deleteFrm);
                deleteFrm.submit();
            }

            function milliToDate(millis) {
                let date = new Date(millis);
                let year = date.getFullYear();
                let month = date.getMonth() + 1;
                let day = date.getDate();

                return year + "." + month + "." + day;
            }
        </script>
    </div>
</div>
</body>
</html>
