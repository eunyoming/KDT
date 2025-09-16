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
            integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q"
            crossorigin="anonymous"></script>
<style>
* {
	box-sizing: border-box;
}

.container {
	margin-top: 15px;
	max-width:800px;
}

.header {
	height: 5%;
	text-align: center;
	margin-bottom: 10px;
}

.header div {
	font-size: 24px;
}

.title {
	height: 5%;
	text-align: center;
	background-color: black;
	color: white;
}

.contents {
	height: 480px;
	overflow: auto;
}
.titles{
	color:black;
}

/* .contents div {
   display: flex;
   justify-content: center;
   text-align: center;
} */
.board-item {
	padding: 0;
	margin: 0;
	border-bottom: 1px solid lightgray;
	height: 10%;
}

.board-item:hover{
	background-color:lightgray;
}

.board-item div {
	padding: 0;
	margin: 0;
	height: auto;
	display: flex;
	justify-content: center;
	align-items: center;
}

.naviPage {
	height: 5%;
	text-align: center;
	margin-top : 10px;
	margin-bottom : 10px;
}

.footer {
	height: 5%;
	text-align: right;
}

</style>
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
			<div class="container g-0">
				<!-- header -->
				<div class="row header g-0">
					<div class="col">
						<b>자유게시판</b>
					</div>
				</div>
				<!-- title -->
				<div class="row title g-0">
					<div class="col-1"></div>
					<div class="col-4">제목</div>
					<div class="col-2">작성자</div>
					<div class="col-4">날짜</div>
					<div class="col-1">조회</div>
				</div>
				<!-- contents -->
				<div class="contents g-0">
					<c:choose>
						<c:when test="${list == null }">
							<div>표시할 내용이 없습니다.</div>
						</c:when>

						<c:otherwise>
							<c:forEach var="dto" items="${list}">
								<div class="row board-item">
									<div class="col-1">${dto.seq}</div>
									<div class="col-4 titles">
										<a href="/board/detail?seq=${dto.seq}" style="text-decoration: none; color: inherit;">${dto.title}</a>
									</div>
									<div class="col-2">${dto.writer}</div>
									<div class="col-4">
										<fmt:formatDate value="${dto.create_at}"
											pattern="yyyy-MM-dd HH:mm:ss" />
									</div>
									<div class="col-1">${dto.view_count}</div>
								</div>
							</c:forEach>
						</c:otherwise>
					</c:choose>

				</div>
				<!-- page -->
				<div class="row naviPage g-0">
					<div class="col page">${navi }</div>
				</div>
				<!-- footer -->
				<div class="row footer g-0">
					<div class="col">
						<a href="/" style="text-decoration: none;">
							<button class="btn btn-dark">돌아가기</button>
						</a>
						<a href="/board/write">
							<button class="btn btn-dark">글 작성하기</button>
						</a>
					</div>
				</div>
			</div>
			
			<script>
				// 전체 레코드
				let recordTotalCount = ${recordTotalCount};
				// 한 페이지당 몇개의 게시글
				let recordCountPerPage = ${recordCountPerPage};
				// 한 번에 보여즐 네비게이터 수
				let naviCountPerPage = ${naviCountPerPage};
				// 현재 내가 클릭한 페이지
				let currentPage = ${currentPage};
								
				// 전체 페이지
				let pageTotalCount = 0;
				
				if(recordTotalCount % recordCountPerPage > 0){
					pageTotalCount = recordTotalCount / recordCountPerPage + 1;
				}else{
					pageTotalCount = recordTotalCount / recordCountPerPage;
				}
				
				let startNavi = parseInt((currentPage-1)/recordCountPerPage)*recordCountPerPage+ 1;
				let endNavi = startNavi + (naviCountPerPage - 1);
				if(endNavi > pageTotalCount){
					endNavi = pageTotalCount;
				}
				
				// 현재 페이지 안전장치
				if(currentPage < 1){
					currentPage = 1;
				}else if(currentPage > pageTotalCount ){
					endNavi = pageTotalCount;
				}
				
				let needPrev = true;
				let needNext = true;
				
				if(startNavi == 1){
					needPrev = false;
				}
				
				if(endNavi == pageTotalCount ){
					needNext = false;
				}
				
				// 앵커 태그 달기
				if(needPrev) {
					$(".page").append("<a href='/board/list?cpage=" + (startNavi-1) + "'>< </a>");
				}

				for(let i = startNavi; i<= endNavi; i++) {
					$(".page").append("<a href='/board/list?cpage=" + i + "'>" + i + "</a> ");
				}
				if(needNext) {
					$(".page").append(" <a href='/board/list?cpage=" + (endNavi+1) + "'> > </a>");
				}
				
			</script>
			
		</c:otherwise>
	</c:choose>
</body>
</html>