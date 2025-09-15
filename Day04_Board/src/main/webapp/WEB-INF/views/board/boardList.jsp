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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css"
          integrity="sha512-DxV+EoADOkOygM4IR9yXP8Sb2qwgidEmeqAEmDKIOfPRQZOWbXCzLC6vjbZyy0vPisbH2SyW27+ddLVCN+OMzQ=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <link rel="stylesheet" href="/boards/boardList.css">
</head>
<body>
<div class="container">

    <nav class="navbar navbar-expand-lg">
        <div class="container-fluid">
            <a class="navbar-brand" aria-current="page" href="/" style="color: #0d6dfb;">Home</a>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link" href="/member/mypage">회원 정보</a>
                    </li>
                </ul>
                <form class="d-flex" action="/board/list" method="get">
                    <div class="input-group">
                        <select class="form-select" name="searchOpt">
                            <option value="title" selected>제목</option>
                            <option value="writer">작성자</option>
                        </select>
                        <input class="form-control me-2" name="search" placeholder="검색어 입력" aria-label="Search"/>
                    </div>
                    <button class="btn btn-outline-success"><i class="fa-solid fa-magnifying-glass"></i></button>
                </form>
            </div>
        </div>
    </nav>

    <table class="table">
        <thead>
        <tr align="center">
            <th></th>
            <th>제목</th>
            <th>작성자</th>
            <th>날짜</th>
            <th>조회</th>
        </tr>
        </thead>
        <tbody class="table-group-divider item-list-view">
        <script>
            let postList = ${list};
            let itemPerPage = ${itemPerPage};

            if (postList.length === 0) {
                let emptyAlert = $("<td>").attr({
                    "colspan": "5",
                    "align": "center"
                }).html("표시할 내용이 없습니다.");

                $(".item-list-view").append($("<tr>").append(emptyAlert));
                for (let i = 0; i < itemPerPage - 1; i++) {
                    let emptyItem = $("<p>").css("color", "transparent");
                    let emptyItemTd = $("<td>").attr("colspan", "5");
                    $(".item-list-view").append($("<tr>").append(emptyItemTd.append(emptyItem)));
                }
            } else {
                for (let post of postList) {
                    let tr = $("<tr>").attr("align", "center");
                    let seq = $("<td>").attr("width", "5%").html(post.id);
                    let title = $("<td>").attr("width", "30%").addClass("title")
                        .append($("<a>").attr({
                            "title": post.title,
                            "href": "/board/item?id=" + post.id
                        }).html(post.title));
                    let writer = $("<td>").attr("width", "15%").html(post.writer);
                    let writeDate = $("<td>").attr("width", "30%").html(milliToDate(post.writeDate));
                    let viewCount = $("<td>").attr("width", "20%").html(post.viewCount);

                    $(".item-list-view").append(tr
                        .append(seq)
                        .append(title)
                        .append(writer)
                        .append(writeDate)
                        .append(viewCount));
                }
                if(postList.length % itemPerPage !== 0) {
                    for (let i = 0; i < itemPerPage - postList.length % itemPerPage; i++) {
                        let emptyItem = $("<p>").css("color", "transparent");
                        let emptyItemTd = $("<td>").attr("colspan", "5");
                        $(".item-list-view").append($("<tr>").append(emptyItemTd.append(emptyItem)));
                    }
                }
            }

            function milliToDate(millis) {
                let date = new Date(millis);
                let year = date.getFullYear();
                let month = date.getMonth() + 1;
                let day = date.getDate();

                return year + "." + month + "." + day;
            }
        </script>
        <tr>
            <td colspan="3" id="navPos">
                <script>
                    let params = new URLSearchParams(window.location.search);

                    let maxPage = ${maxPage};
                    let curPage = ${curPage};
                    let naviPerPage = ${naviPerPage};

                    let searchOpt = params.get("searchOpt");
                    let search = params.get("search");

                    if (maxPage > 1) {
                        let nav = $("<nav>");
                        let ul = $("<ul>").addClass("pagination");

                        let prevArrow = $("<li>").addClass("page-item");
                        let prevArrowLink = $("<a>").addClass("page-link");

                        let nextArrow = $("<li>").addClass("page-item");
                        let nextArrowLink = $("<a>").addClass("page-link");

                        if (curPage <= naviPerPage) {
                            prevArrow.addClass("disabled");
                        }

                        if (curPage > maxPage - naviPerPage) {
                            nextArrow.addClass("disabled");
                        }

                        let searchParams = "";
                        if (search != null) {
                            params += "&searchOpt=" + searchOpt;
                            params += "&search=" + search;
                        }

                        let prevPageLast = Math.floor((curPage - 1) / naviPerPage) * naviPerPage;
                        let nextPageFirst = prevPageLast + naviPerPage + 1;

                        prevArrowLink.attr("href", "?page=" + prevPageLast + searchParams).html("&laquo;");
                        nextArrowLink.attr("href", "?page=" + nextPageFirst + searchParams).html("&raquo;");

                        prevArrow.append(prevArrowLink);
                        nextArrow.append(nextArrowLink);

                        ul.append(prevArrow);

                        let navFirstPage = Math.floor((curPage - 1) / naviPerPage) * naviPerPage + 1;
                        for (let i = navFirstPage; i < navFirstPage + naviPerPage; i++) {
                            if (i <= maxPage) {
                                let navItem = $("<li>").addClass("page-item");
                                let navLink = $("<a>").addClass("page-link");

                                navLink.attr("href", "?page=" + i + searchParams).html(i);
                                if (i === curPage) {
                                    navLink.addClass("active");
                                }
                                navItem.append(navLink);

                                ul.append(navItem);
                            }
                        }

                        ul.append(nextArrow);

                        nav.append(ul);

                        $("#navPos").append(nav);
                    }
                </script>
            </td>
            <td colspan="2" align="right">
                <div class="btn-group" role="group">
                    <button onclick="location.href='/'" class="btn btn-secondary">뒤로가기</button>
                    <button onclick="location.href='/board/postingform'" class="btn btn-primary">작성하기</button>
                </div>
            </td>
        </tr>
        </tbody>
    </table>
</div>
</body>
</html>