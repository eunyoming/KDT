<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/input.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/home.css">
</head>
<body>

<c:choose>
    <c:when test="${sessionScope.loginId == null}">
        <div class="container">
            <form action="/member/login" method="post">
                <div class="row title">
                    <div class="col col-12">
                        Login Box
                    </div>
                </div>
                <div class="row idInput input">
                    <div class="col col-3 form-label">
                        아이디
                    </div>
                    <div class="col col-8">
                        <input type="text" class="form-control" name="id" placeholder="ID" required>
                    </div>
                </div>
                <div class="row pwInput input">
                    <div class="col col-3 form-label">
                        비밀번호
                    </div>
                    <div class="col col-8">
                        <input type="password" class="form-control" name="pw" placeholder="PW" required>
                    </div>
                </div>
                <div class="row btns">
                    <div class="col col-6 loginBtn">
                        <input type="submit" class="btn btn-primary" value="로그인">
                    </div>
                    <div class="col col-6 regBtn">
                        <a href="/member/toregistry">
                            <input type="button" class="btn btn-outline-primary" value="회원가입">
                        </a>
                    </div>

                </div>
                <div class="row checkbox">
                    <div class="col col-12 form-check">
                        <input type="checkbox" class="form-check-input" name="rememberId">
                        <div class="form-label">ID기억하기</div>
                    </div>
                </div>
            </form>
        </div>
    </c:when>
    <c:otherwise>
        <table border="1" align="center">
            <tr>
                <th>${sessionScope.loginId}님 안녕하세요.</th>
            </tr>
            <tr>
                <td>
                    <a href="/board/list">
                        <button>회원게시판</button>
                    </a>
                </td>
                <td>
                    <a href="/member/mypage">
                        <button>마이페이지</button>
                    </a>
                </td>
                <td>
                    <a href="/member/logout">
                        <button>로그아웃</button>
                    </a>
                </td>
                <td>
                    <button id="withdraw" type="button">회원탈퇴</button>
                </td>
            </tr>
        </table>

        <script>
            $("#withdraw").on("click", function () {
                if (confirm("정말 탈퇴하시겠습니까?")) {
                    location.href = "/member/withdraw";
                }
            });
        </script>
    </c:otherwise>
</c:choose>

</body>
</html>
