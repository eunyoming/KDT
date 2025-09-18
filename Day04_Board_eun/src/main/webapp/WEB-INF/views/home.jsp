<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
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

<!-- css -->
<link rel="stylesheet" href="/resources/css/home.css">

</head>

<body>
	<c:choose>
		<c:when test="${loginId == null}">
			<form action="/members/login" method="post">
				<div class="container mt-4">
					<div class="login_header mb-3">Login Box</div>

					<div class="col-12">
						<div class="col-4 input_div">아이디</div>
						<div class="col-8">
							<input type="text" placeholder="ID" class="login_input"
								id="loginId" name="loginId">
						</div>
					</div>

					<div class="col-12">
						<div class="col-4 input_div">비밀번호</div>
						<div class="col-8">
							<input type="password" placeholder="PW" class="login_input"
								id="loginPw" name="loginPw">
						</div>
					</div>

					<div class="col-12 login_btns">

						<button type="submit" class="login_btn" id="login_btn">로그인</button>
						<a href="/members/join">
							<button type="button" class="join_btn">회원가입</button>
						</a>
					</div>

					<div class="col-12">
						<input type="checkbox">ID 기억하기
					</div>
				</div>
			</form>
			<div style="margin-top:10px;">
				<img src="/resources/img/me.png">
			</div>

			<script>
				// 로그인 버튼 클릭시
				$("form").on("submit", function() {
					let id = $("#loginId").val();
					let pw = $("#loginPw").val();

					if (id === "") {
						alert("아이디를 입력해주세요.");
						$("#loginId").focus();
						return false;
					}

					if (pw === "") {
						alert("비밀번호를 입력해주세요.");
						$("#loginPw").focus();
						return false;
					}
				})
			</script>

		</c:when>
		<c:otherwise>
				<div class="container mt-4">
					<div><h5><b>${loginId }님 안녕하세요.</b></h5></div>
					<div class="btns">
						<a href="/chat/join">
							<button type="button" class="login_btn">채팅 참여</button>
						</a>
						<a href="/board/list">
							<button type="button" class="login_btn">회원게시판</button>
						</a>
						<a href="/members/mypage">
							<button type="button" class="login_btn">마이페이지</button>
						</a>
						<a href="/members/logout">
							<button class="join_btn">로그아웃</button>
						</a>
						<form id="deleteFrm" action="/members/delete" method="post">
							<button id="deleteBtn" type="submit" class="join_btn">회원탈퇴</button>
						</form>
					</div>
				</div>

			<script>
				// 회원탈퇴 버튼 눌렀을시
				$("#deleteFrm").on("submit", function() {

					let result = confirm("정말 탈퇴하시겠습니까?");

					if (!result) {
						return false;
					}
				})						
			</script>

		</c:otherwise>
	</c:choose>
</body>
</html>