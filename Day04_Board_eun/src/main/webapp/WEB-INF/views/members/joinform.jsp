<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- 부트스트랩 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr"
	crossorigin="anonymous">
<!-- JQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
	integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
	crossorigin="anonymous" type="text/javascript"></script>
<!-- 다음 우편번호 API -->
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"
	type="text/javascript"></script>

<style type="text/css">
* {
	box-sizing: border-box;
}

.container {
	width: 700px;
	padding: 20px;
	margin: auto;
	margin-top: 10px;
	border-radius: 10px;
	position: relative;
	background: linear-gradient(white, white) padding-box, /* 내부 흰색 */
    linear-gradient(135deg, rgb(155, 93, 248), rgb(255, 85, 215))
		border-box; /* 테두리 그라데이션 */
	border: 2px solid transparent; /* 투명 테두리로 그라데이션 배경 보이게 */
	background-origin: border-box;
	background-clip: padding-box, border-box;
}

.container div {
	padding: 0;
}

.row {
	width: 100%;
}

/* 헤더 */
.header_text {
	text-align: center;
	background: linear-gradient(135deg, rgb(88, 17, 194), rgb(255, 85, 215));
	color: white;
	border-radius: 12px;
	font-size: 20px;
}

/* input */
.input_text {
	text-align: right;
}

.col-2 {
	text-align: right;
}

.input {
	width: 50%;
}

.input_addr {
	width: 80%;
}

/* 푸터 */
.join_footer {
	text-align: center;
}

/* 버튼들 */
.btn {
	width: 100px;
	border: 1px solid rgb(255, 85, 215);
	color: rgb(155, 93, 248);
	border-radius: 5px;
	padding-top: 3px;
	padding-bottom: 3px;
}
</style>

</head>

<body>
	<form action="/members/insert" method="post">
		<div class="container">

			<div class="row join_header g-0">
				<div class="col-12 header_text pt-2 pb-2">회원 가입 정보 입력</div>
			</div>

			<div class="row g-0 mb-2">
				<div class="col-2 input_text pe-3 mb-2 mt-2">ID</div>
				<div class="col">
					<input type="text" class="mb-2 mt-2" placeholder="아이디를 입력하세요"
						id="id" name="id">
					<button type="button" class="btn" id="duplCheck">중복확인</button>
				</div>
			</div>

			<div class="row g-0 mb-2">
				<div class="col-2 mb-3 input_text pe-3">PW</div>
				<div class="col">
					<input type="password" placeholder="비밀번호를 입력하세요" class="input"
						id="pw" name="pw">
				</div>

			</div>

			<div class="row g-0 mb-2">
				<div class="col-2 mb-3 input_text pe-3">PW 확인</div>
				<div class="col">
					<input type="password" placeholder="비밀번호를 다시 입력하세요" class="input"
						id="pwCheck" name="pwCheck">
				</div>
			</div>

			<div class="row g-0 mb-2">
				<div class="col-2 mb-3 input_text pe-3">이름</div>
				<div class="col">
					<input type="text" placeholder="이름을 입력하세요." class="input" id="name"
						name="name">
				</div>
			</div>

			<div class="row g-0 mb-2">
				<div class="col-2 mb-3 input_text pe-3">전화번호</div>
				<div class="col">
					<input type="text" placeholder="전화번호를 입력하세요 (예: 010-1234-1234)"
						class="input" id="phone" name="phone">
				</div>
			</div>

			<div class="row g-0 mb-2">
				<div class="col-2 mb-3 input_text pe-3">이메일</div>
				<div class="col">
					<input type="text" placeholder="이메일을 입력하세요" class="input"
						id="email" name="email">
				</div>
			</div>

			<div class="row g-0 mb-2">
				<div class="col-2 mb-3 input_text pe-3">우편번호</div>
				<div class="col">
					<input type="text" placeholder="우편번호" class="input" id="postcode"
						name="zipcode"> <input type="button"
						onclick="sample4_execDaumPostcode()" value="찾기" class="btn">
				</div>
			</div>

			<div class="row g-0 mb-2">
				<div class="col-2 mb-3 input_text pe-3">주소</div>
				<div class="col">
					<input type="text" placeholder="주소를 입력하세요" class="input input_addr"
						id="roadAddress" name="address1">
				</div>
			</div>

			<div class="row g-0 mb-2">
				<div class="col-2 mb-3 input_text pe-3">상세주소</div>
				<div class="col">
					<input type="text" placeholder="상세주소를 입력하세요"
						class="input input_addr" id="detailAddress" name="address2">
				</div>
			</div>

			<div class="row g-0 mb-2">
				<div class="col join_footer">
					<button type="submit" class="btn" id="joinBtn">회원가입</button>
					<button type="reset" class="btn">다시입력</button>
				</div>
			</div>
		</div>
	</form>

	<script type="text/javascript">
		// 아이디 중복체크 여부 확인하는 변수
		let isIdChecked = false;

		// true로 만들어주는 함수 하나 생성
		function isIdCheckedToTrue() {
			return true;
		}

		// 다음 우편번호 API
		function sample4_execDaumPostcode() {
			new daum.Postcode({
				oncomplete : function(data) {
					// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
					// 우편번호와 주소 정보를 해당 필드에 넣는다.
					$("#postcode").val(data.zonecode);
					$("#roadAddress").val(data.roadAddress);
				}
			}).open();
		}

		// ID 중복체크 팝업창
		$("#duplCheck").on(
				"click",
				function() {

					// 팝업창 url 로 id 값 보내기
					window.open(
							"/idcheck.members?id=" + $("#id").val(),
							"", "width=300,height=200");
				})

		// (유효성 검사) 회원가입 버튼 클릭시
		$("form")
				.on(
						"submit",
						function() {
							// 정규식
							let regexId = /^[a-z0-9_]{4,12}$/;
							let regexPw = /^([a-zA-Z0-9]|[^a-zA-Z0-9\s]){8,16}$/;
							let regexName = /^[a-zA-Z가-힣]{2,6}$/;
							let regexPhone = /^010[0-9]{8}$|^010-[0-9]{4}-[0-9]{4}$/;
							let regexEmail = /^[\da-z_]{4,12}@[\w]+(\.com|\.co\.kr)$/;
							
							
							
							// ID
							let id = $("#id").val();

							if (id == '') {
								alert("아이디를 입력해주세요.");
								$("#id").focus();
								return false;
							}

							if (!regexId.test(id)) {
								alert("아이디 형식이 올바르지 않습니다.\n영어 소문자, 숫자, _만 가능 (4 ~ 12자)");
								$("#id").focus();
								return false;
							}

							// PW
							let pw = $("#pw").val();
							if (pw == "") {
								alert("패스워드를 입력해주세요.");
								$("#pw").focus();
								return false;
							}

							if (!regexPw.test(pw)) {
								alert("패스워드 형식이 올바르지 않습니다.\n영문, 숫자, 특수문자 각 한글자 이상 포함 ( 8 ~ 16자 )");
								$("#pw").focus();
								return false;
							}

							if (!(/[a-zA-Z]/.test(pw) && /[\d]/.test(pw) && /[^\w\s]/
									.test(pw))) {
								alert("영문, 숫자, 특수문자 각 한글자 이상 포함해야 됩니다. ( 8 ~ 16자 )");
								$("#pw").focus();
								return false;
							}

							// pw Check
							let pwCheck = $("#pwCheck").val();
							if (pwCheck == "") {
								alert("패스워드를 다시 확인해주세요.");
								$("#pwCheck").focus();
								return false;
							}

							if (pwCheck != pw) {
								alert("입력한 패스워드와 일치하지 않습니다.");
								$("#pwCheck").focus();
								return false;
							}

							// 이름
							let name = $("#name").val();
							if (name == "") {
								alert("이름을 입력해주세요.");
								$("#name").focus();
								return false;
							}

							if (!regexName.test(name)) {
								alert("이름 형식이 올바르지 않습니다.( 2 ~ 10자 )");
								$("#name").focus();
								return false;
							}

							// phone
							let phone = $("#phone").val();
							if (phone == "") {
								alert("전화번호를 입력해주세요.\n(예:01012341234 또는 010-1234-1234)");
								$("#phone").focus();
								return false;
							}

							if (!regexPhone.test(phone)) {
								alert("전화번호 형식이 맞지 않습니다.\n(예:01012341234 또는 010-1234-1234)");
								$("#phone").focus();
								return false;
							}

							// 이메일
							let email = $("#email").val();

							if (email != "") {
								if (!regexEmail.test(email)) {
									alert("이메일 형식이 올바르지 않습니다.\n예시 : 영문 및 숫자@naver.com\n예시2 : 영문 및 숫자@naver.co.kr");
									$("#email").focus();
									return false;
								}
							}
						})
	</script>
</body>
</html>