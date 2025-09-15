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
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <link rel="stylesheet" href="/common/css/input.css">
    <link rel="stylesheet" href="/members/mypage.css">
</head>
<body>
<div class="container">
    <form id="updateFrm" action="/member/update" method="post">
        <div class="row title">
            <div class="col">
                회원 정보
            </div>
        </div>
        <div class="row input">
            <div class="col col-2 form-label">ID</div>
            <div class="col col-10">
                <span>${myInfo.id}</span>
            </div>
        </div>
        <div class="row input">
            <div class="col col-2 form-label">이름</div>
            <div class="col col-10">
                <span>${myInfo.name}</span>
            </div>
        </div>
        <div class="row input">
            <div class="col col-2 form-label">전화번호</div>
            <div class="col col-10">
                <input type="text" class="form-control readonly-disabled" name="phone" placeholder="전화번호를 입력하세요."
                       value="${myInfo.phone}" readonly required>
            </div>
        </div>
        <div class="row input">
            <div class="col col-2 form-label">이메일</div>
            <div class="col col-10">
                <input type="email" class="form-control readonly-disabled" name="email" placeholder="이메일을 입력하세요."
                       value="${myInfo.email}" readonly>
            </div>
        </div>
        <div class="row input">
            <div class="col col-2 form-label">우편번호</div>
            <div class="col col-10 zipcodeInput">
                <input type="text" class="form-control readonly-disabled" name="zipcode" placeholder="우편번호"
                       value="${myInfo.zipcode}" readonly>
            </div>
            <div class="col col-2 searchPostcode" style="display: none">
                <input type="button" class="btn btn-primary" onclick="searchPostcode()" value="찾기">
            </div>
        </div>
        <div class="row input">
            <div class="col col-2 form-label">주소</div>
            <div class="col col-10">
                <input type="text" class="form-control readonly-disabled" name="address1" placeholder="주소"
                       value="${myInfo.address1}" readonly>
            </div>
        </div>
        <div class="row input">
            <div class="col col-2 form-label">상세주소</div>
            <div class="col col-10">
                <input type="text" class="form-control readonly-disabled" name="address2" placeholder="상세주소를 입력하세요."
                       value="${myInfo.address2}" readonly>
            </div>
        </div>
        <div class="row input">
            <div class="col col-2 form-label">가입날짜</div>
            <div class="col col-10">
                <span>${myInfo.joinDate}</span>
            </div>
        </div>
        <div class="row modiHomeBtn">
            <div class="col modifyBtn">
                <input id="modifyBtn" type="button" class="btn btn-primary" value="수정하기">
            </div>
            <div class="col homeBtn">
                <input type="button" onclick="history.back();" class="btn btn-outline-primary" value="뒤로가기">
            </div>
            <div class="col confirmBtn" style="display: none">
                <input id="confirmBtn" type="submit" class="btn btn-primary" value="수정완료">
            </div>
            <div class="col cancelBtn" style="display: none">
                <input id="cancelBtn" type="button" onclick="location.reload()" class="btn btn-outline-primary" value="취소">
            </div>
        </div>
    </form>

    <script>
        $("#modifyBtn").on("click", function () {
            $(".modifyBtn, .homeBtn").css("display", "none");
            $(".confirmBtn, .cancelBtn").css("display", "flex");
            $(".searchPostcode").css("display", "flex");

            modifyAllow();
        });

        function modifyAllow() {
            $("[name = phone]").attr("readonly", false);
            $("[name = phone]").removeClass("readonly-disabled");

            $("[name = email]").attr("readonly", false);
            $("[name = email]").removeClass("readonly-disabled");

            $(".zipcodeInput").addClass("col-8");
            $(".zipcodeInput").removeClass("col-10");

            $("[name = address2]").attr("readonly", false);
            $("[name = address2]").removeClass("readonly-disabled");
        }

        function searchPostcode() {
            new daum.Postcode({
                oncomplete: function (data) {
                    $("[name = zipCode]").val(data.zonecode);
                    $("[name = address1]").val(data.address);
                }
            }).open()
        }

        let phoneRegex = /^010(-?\d{4}){2}$/;
        let emailRegex = /^.+@.+(\.com|\.co\.kr)$/;

        $("#updateFrm").on("submit", function checkValidation() {
            if (emailRegex.test($("[name = email]").val()) &&
                phoneRegex.test($("[name = phone]").val())) {
                return true;
            } else {
                alert("입력 정보를 다시 확인해주세요.");
                return false;
            }
        });
    </script>
</div>
</body>
</html>
