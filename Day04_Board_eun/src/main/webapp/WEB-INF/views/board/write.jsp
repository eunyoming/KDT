<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- JQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
            integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q"
            crossorigin="anonymous"></script>
            
<!-- Summernote cdn -->
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.css"
	rel="stylesheet">
<!-- CSS -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.css" rel="stylesheet">

<!-- JS -->
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.js"></script>

<!-- css -->
<link rel="stylesheet" href="/resources/css/board/write.css">

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
			<form id="add-Frm" action="/board/insert" method="post">
				<div class="container">
					<!-- header -->
					<div class="row header g-0">
						<div class="col">
							<b>자유게시판 글 작성하기</b>
						</div>
					</div>
					<div class="row title g-0">
						<div class="col">
							<input type="text" name="title" placeholder="글 제목을 입력하세요.">
						</div>
					</div>
					<input type="file" name="files" id="files" multiple>
					<div class="row contents g-0">
						<div class="col contentsDiv" id="summernote"></div>
						<input type="hidden" name="contents" id="contents">
					</div>
					<div class="row footer g-0">
						<div class="col">
							<a href="/board/list?cpage=1">
								<button type="button" class="btns btn btn-dark">목록으로</button>
							</a>
							<button class="btns btn btn-dark" id="okBtn">작성완료</button>
						</div>
					</div>
				</div>
			</form>

			<script>
				// 썸머노트 API 실행
				$(document).ready(function() {
									// 1. contents 영역 높이 가져오기
									let contentsHeight = $(".contents")
											.height();

									// 2. Summernote 임시 초기화
									$("#summernote").summernote({
										height : 100, // 임시값
										disableResizeEditor : true
									});

									// 3. 툴바 높이 측정
									let toolbarHeight = $(".note-toolbar")
											.outerHeight(true);

									// 4. 에디터 전체 높이 설정
									let editorHeight = contentsHeight;

									// 에디터 본문 영역 높이 설정
									let editableHeight = contentsHeight - toolbarHeight;

									// 5. Summernote 다시 초기화
									$("#summernote").summernote("destroy");
									$("#summernote")
											.summernote(
													{
														placeholder : "내용을 작성하세요.",
														tabsize : 2,
														// height : 에디터 전체 높이
														height : editorHeight,
														disableResizeEditor : true,
														toolbar: [
															
														      ["style", ["style"]],
														      ["font", ["bold", "underline", 'strikethrough', 'superscript', 'subscript', "clear"]],
														      ['fontsize', ['fontsize']],
														      ["color", ["color"]],
														      ['height', ['height']],
														      ["para", ["ul", "ol", "paragraph"]],
														      ["table", ["table"]],
														      ["insert", ["link", "picture", "video"]],
														      ["view", ["fullscreen", "codeview", "help"]]
														    ],
														    
														    callbacks: {
													            onImageUpload: function(files) {
													                for (let i = 0; i < files.length; i++) {
													                    uploadImage(files[i], this);
													                }
													            }
													        }
														  });
									// note-editable 영역 (에디터 본문) 높이 조정
									$(".note-editable").css("height", editableHeight + "px");
									
									// 초기화 후 강제로 숨기기
									$(".note-resize").css("display", "none");
								});

				// 작성완료 버튼 눌렀을 때
				$("#okBtn").on("click", function(e) {
					e.preventDefault(); // 기본 submit 막기
					console.log($("#contents").val());
					let htmlContent = $("#summernote").summernote("code");
					$("#contents").val(htmlContent);
					$("#add-Frm").submit();
				});

				function uploadImage(file, editor) {
				    let data = new FormData();
				    data.append("file", file);

				    $.ajax({
				        url: "/file/upload",   // 서버 업로드 엔드포인트
				        type: "POST",
				        data: data,
				        cache: false,
				        contentType: false,
				        processData: false,
				        success: function(url) {
				            // 성공하면 Summernote에 <img src="..."> 추가
				            $(editor).summernote('insertImage', url);
				        },
				        error: function(err) {
				            console.log("Upload failed:", err);
				        }
				    });
				}
				
			</script>
		</c:otherwise>
	</c:choose>
</body>
</html>