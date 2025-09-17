<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- JSTL 날짜 포맷 라이브러리 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- JQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
	integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
	crossorigin="anonymous"></script>

<!-- 부트스트랩 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q"
	crossorigin="anonymous"></script>

<!-- css -->
<link rel="stylesheet" href="/resources/css/board/detail.css">

</head>

<body>
	<c:choose>
		<c:when test="${loginId == null}">
			<script>
				alert("로그인 후 이용해주세요.");
				location.href = "/";
			</script>
		</c:when>

		<c:otherwise>
			<!-- 로그인 했을 때 -->
			<div class="container">
				<!-- 컨텐츠 박스 ( 글 작성자 내용 ) -->
				<div class="contentsBox">
					<!-- 제목 -->
					<div class="row title">
						<div class="col" contenteditable="false" id="dto-title"
							name="title">${dto.title }</div>
					</div>
					<!-- 작성자 -->
					<div class="row writer">
						<div class="col" id="dto_writer">
							<b>${dto.writer }</b>
						</div>
					</div>
					<!-- 날짜, 조회수 -->
					<div class="row date-view">
						<div class="col">
							<fmt:formatDate value="${dto.create_at}"
								pattern="yyyy-MM-dd HH:mm:ss" />
							| ${dto.view_count }
						</div>
					</div>
					<!-- 구분선 -->
					<hr>
					<!-- 글 내용 -->
					<div class="row contents">
						<div class="col" id="dto-contents" contenteditable="false"
							name="contents">${dto.contents}</div>
					</div>
					<!-- 버튼들 -->
					<div class="row btns">
						<!-- 작성자 = 로그인한 사람 -->
						<c:if test="${loginId == dto.writer }">

							<div class="col btns text-end">
								<form id="delete-Frm" action="/board/delete" method="post">
									<button type="button" class="btn btn-dark d-none" id="noBtn">취소</button>
									<button type="button" class="btn btn-dark d-none" id="okBtn">수정완료</button>

									<button class="btn btn-dark" id="deleteBtn">삭제하기</button>
									<input type="hidden" value="${dto.seq}" name="seq"
										id="dto_seq2">

									<button type="button" class="btn btn-dark" id="updateBtn">수정하기</button>
									<button type="button" class="btn btn-dark" id="listBtn">목록으로</button>
								</form>
							</div>
						</c:if>
						<!-- 작성자 != 로그인한 사람 -->
						<c:if test="${loginId != dto.writer }">
							<div class="col btns text-end">
								<button type="button" class="btn btn-dark" id="listBtn">목록으로</button>
							</div>
						</c:if>
					</div>
					<!-- 글 내용 update form -->
					<form id="detail-Frm" action="/board/update" method="post">
						<input type="hidden" value="${dto.seq}" name="seq" id="dto_seq">
						<input type="hidden" value="${dto.title}" name="title"
							id="dto_title"> <input type="hidden"
							value="<c:out value='${dto.contents}'/>" name="contents"
							id="dto_contents">
					</form>
				</div>


				<!-- 댓글 박스 -->
				<div class="row replies g-0">
					<!-- 댓글 div -->
					<div class="col replyDiv" contenteditable="true"></div>
					<!-- 댓글 등록 버튼 -->
					<div class="col-2 replyBtn">
						<button class="btn btn-outline-dark" id="replyBtn">등록</button>
					</div>
					<!-- 댓글 있을시 출력 -->
					<c:forEach var="replyDto" items="${list}">
						<div class="replyBlock">
							<div class="col-12 replyWriter">
								<b>${replyDto.writer}</b>
							</div>
							<div class="col-12 replyContentsDiv" contenteditable="false">${replyDto.contents}</div>
							<div class="col-12 replyWrite_date">
								<fmt:formatDate value="${replyDto.write_date}"
									pattern="yyyy-MM-dd HH:mm:ss" />
							</div>

							<c:if test="${loginId == replyDto.writer}">
								<div class="col-12 replyBtns">
									<button type="button"
										class="btn btn-outline-dark replyOkBtn d-none"
										data-reply-seq="${replyDto.seq}" data-parent-seq="${dto.seq}">수정완료</button>
									<button type="button"
										class="btn btn-outline-dark replyNoBtn d-none">취소</button>

									<button type="button"
										class="btn btn-outline-dark replyUpdateBtn">수정</button>
									<button class="btn btn-outline-dark replyDeleteBtn"
										data-reply-seq="${replyDto.seq}" data-parent-seq="${dto.seq}">삭제</button>

									<input type="hidden" class="reply_contents"
										value="${replyDto.contents}" name="contents"> <input
										type="hidden" class="reply_seq" name="seq"
										value="${replyDto.seq}"> <input type="hidden"
										class="parent_seq" name="parent_seq" value="${dto.seq}">
								</div>
							</c:if>

							<hr id="replyHr">
						</div>
					</c:forEach>
				</div>
			</div>

			<script>
  // 삭제버튼 클릭시
  $("#deleteBtn").on("submit", function () {
    let form = $("#delete-Frm");

    // 제목/내용은 필요 없으니 제거
    $("#dto_title").html("");
    $("#dto_writer").html("");

    form.submit();
  });

  // update 버튼 클릭시
  $("#updateBtn").on("click", function () {
    // 제목 영역을 수정 가능하게 변경
    $("#dto-title").attr("contenteditable", true);
    $("#dto-contents").attr("contenteditable", true);
    $("#dto-contents").focus();

    // 버튼들 생기게 하고, 숨기기
    $("#okBtn").removeClass("d-none");
    $("#noBtn").removeClass("d-none");
    $("#updateBtn").css("display", "none");
    $("#deleteBtn").css("display", "none");
  });

  // 목록으로 버튼 클릭시
  $("#listBtn").on("click", function () {
    window.location.href = "/board/list";
  });

  // 수정완료 버튼 클릭시
  $("#okBtn").on("click", function () {
    let form = $("#detail-Frm");
    form.attr("action", "/board/update");

    // 제목, 내용이 화면에 있는 경우 가져와서 넣기
    let title = $("#dto-title").html();
    let contents = $("#dto-contents").html();

    // hidden input에 값 넣기
    $("#dto_title").val(title);
    $("#dto_contents").val(contents);

    form.submit();
  });

  // 취소버튼 클릭시
  $("#noBtn").on("click", function () {
    // 제목 영역을 수정 불가능하게 변경
    $("#dto-title").attr("contenteditable", false);
    $("#dto-contents").attr("contenteditable", false);

    // 다시 원래 페이지로 돌아가게 하기
    window.location.href = "/board/detail?seq=" + $("#dto_seq").val();
  });

  $(function () {
    // 댓글 등록시
    $("#replyBtn").on("click", function () {
      let contents = $(".replyDiv").html();
      // JSP라면 아래처럼 null/빈값 방지 (JSTL 사용)
      let parent_seq = <c:out value="${dto.seq}" default="0" />;

      $.ajax({
        url: "/reply/insert",
        method: "post",
        data: {
          contents: contents,
          parent_seq: parent_seq
        }
      }).done(function (resp) {
        // 댓글 버튼
        let btnsHtml =
            '<div class="col-12 replyBtns">' +
            '<button type="button" class="btn btn-outline-dark replyOkBtn d-none" ' +
            'data-reply-seq="' + resp.seq + '" data-parent-seq="' + resp.parent_seq + '">수정완료</button>' +
            '<button type="button" class="btn btn-outline-dark replyNoBtn d-none">취소</button>' +
            '<button type="button" class="btn btn-outline-dark replyUpdateBtn">수정</button>' +
            '<button type="button" class="btn btn-outline-dark replyDeleteBtn" ' +
            'data-reply-seq="' + resp.seq + '" data-parent-seq="' + resp.parent_seq + '">삭제</button>' +
            '<input type="hidden" class="reply_contents" value="' + resp.contents + '" name="contents">' +
            '<input type="hidden" class="reply_seq" value="' + resp.seq + '" name="seq">' +
            '<input type="hidden" class="parent_seq" value="' + resp.parent_seq + '" name="parent_seq">' +
            '</div>';
            
     	// 댓글 HTML
        let newReplyHtml =
          '<div class="replyBlock">' +
          '<div class="col-12 replyWriter"><b>' + resp.writer + '</b></div>' +
          '<div class="col-12 replyContentsDiv" contenteditable="false">' + resp.contents + '</div>' +
          '<div class="col-12 replyWrite_date">' + resp.write_date + '</div>' +
          btnsHtml +
          '<hr id="replyHr">' +
          '</div>';

        // 댓글 목록에 추가
        $(".replyBtn").after(newReplyHtml);
        // 댓글 입력창 비우기
        $(".replyDiv").html("");
        
      });
    });

    // 댓글 삭제버튼 클릭시
    $(document).on("click", ".replyDeleteBtn", function () {
      let replySeq = $(this).data("reply-seq");   // 댓글 고유 번호
      let parentSeq = $(this).data("parent-seq"); // 게시글 번호
      let btn = this; // 버튼 참조 저장

      $.ajax({
        url: "/reply/delete",
        method: "POST",
        data: {
          seq: replySeq,
          parent_seq: parentSeq
        }
      }).done((resp) => {
    	  if (resp === "success") {
    		  	const replyBlock = $(btn).closest(".replyBlock");
    		    replyBlock.remove();
    		  }
      });
    });

    // 댓글 수정버튼 클릭시
    $(document).on("click", ".replyUpdateBtn", function () {
      const replyBlock = $(this).closest(".replyBlock");
      // 버튼 생기게 하고 없애기
      replyBlock.find(".replyOkBtn").removeClass("d-none");
      replyBlock.find(".replyNoBtn").removeClass("d-none");
      replyBlock.find(".replyUpdateBtn").addClass("d-none");
      replyBlock.find(".replyDeleteBtn").addClass("d-none");

      replyBlock.find(".replyContentsDiv").attr("contenteditable", true).focus();
    });

    // 댓글 취소버튼 클릭시
    $(document).on("click", ".replyNoBtn", function () {
      const replyBlock = $(this).closest(".replyBlock");
      // contents 내용 다시 옮겨 담기
      let replyContentsDiv = replyBlock.find(".replyContentsDiv");
      replyContentsDiv.html(replyBlock.find(".reply_contents").val());

      // 버튼 생기게 하고 없애기
      replyBlock.find(".replyOkBtn").addClass("d-none");
      replyBlock.find(".replyNoBtn").addClass("d-none");
      replyBlock.find(".replyUpdateBtn").removeClass("d-none");
      replyBlock.find(".replyDeleteBtn").removeClass("d-none");

      // Div 수정 못하게 막기
      replyContentsDiv.attr("contenteditable", false);
    });

    // 댓글 수정완료 버튼 클릭시
    $(document).on("click", ".replyOkBtn", function () {
      const replyBlock = $(this).closest(".replyBlock");
      // 버튼에 저장된 데이터 꺼내기
      let reply_seq = $(this).data("reply-seq");
      let parent_seq = $(this).data("parent-seq");

      // 버튼 생기게 하고 없애기
      replyBlock.find(".replyOkBtn").addClass("d-none");
      replyBlock.find(".replyNoBtn").addClass("d-none");
      replyBlock.find(".replyUpdateBtn").removeClass("d-none");
      replyBlock.find(".replyDeleteBtn").removeClass("d-none");

      // 수정 막기
      replyBlock.find(".replyContentsDiv").attr("contenteditable", false);

      // 내용 담기
      let replyContentsDiv = replyBlock.find(".replyContentsDiv");
      let contents = replyContentsDiv.html().trim();

      $.ajax({
        url: "/reply/update",
        method: "post",
        data: {
          "contents": contents,
          "seq": reply_seq
        }
      }).done(function () {
    	  replyContentsDiv.html(contents);
      });
    });
  });
</script>

		</c:otherwise>
	</c:choose>
</body>

</html>