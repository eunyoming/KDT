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

<!-- font-awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css">
 
<!-- css -->
<link rel="stylesheet" href="/resources/css/members/chat.css">

</head>

<body>
    <!-- contenteditable이 가진 기본 속성 : Enter 입력하면 새로운 div 아래에 만듬. -->

    <!-- 컨테이너 -->
    <div class="container">
    	<!-- 채팅방 -->
	    <div id="chatroom"></div>
	
	    <!-- 이모지 박스 (채팅 입력창 위로 이동) -->
	    <div class="emojibox">
	        <img src="/resources/img/rabbit_1.gif">
	        <img src="/resources/img/rabbit_2.gif">
	        <img src="/resources/img/rabbit_3.gif">
	        <img src="/resources/img/rabbit_4.gif">
	        <img src="/resources/img/bear_1.png">
	        <img src="/resources/img/bear_2.gif">
	        <img src="/resources/img/loopy_1.gif">
	        <img src="/resources/img/loopy_2.jpg">
	        <img src="/resources/img/ompang_1.gif">
	        <img src="/resources/img/ompang_2.gif">
	        <img src="/resources/img/ompang_3.gif">
	        <img src="/resources/img/lion1.gif">
	    </div>
	
	    <!-- 채팅입력창 + 버튼 -->
	    <div class="chatcraft">
	        <div class="emojiIcon">
	            <i class="fa-regular fa-face-smile" id="emojiIcon"></i>
	        </div>
	        <div class="inputchat" id="inputchat" contenteditable="true"></div>
	        <div class="btnBox">
	            <button type="button" class="iconBtn">
	                <i class="fa-solid fa-paper-plane" id="sendIcon"></i>
	            </button>
	        </div>
	    </div>
	</div>
	
	<div>
		<a href="/">
			<button class="login_btn">뒤로가기</button>
		</a>
	</div>


    <script>
    // 1. 웹소켓 인스턴스 생성
    let ws = new WebSocket("ws://10.5.5.8/chat"); // localhost라고 하면 클라이언트의 localhost로 접속되므로 ip 사용
 	
    // 3. 서버로부터 메세지 받기
    ws.onmessage = (e)=> {	
     	// 다시 역직렬화 
    	let data = JSON.parse(e.data);
     	console.log(data);
     	// 실시간 채팅
     	// history
    	if(data.type == "history"){
    		// 합치기
    		for(let i of data.list){
    			// 합치기
				displayChat(i);
    		}
    	}else { 
    		displayChat(data);
    	}
        // 스크롤 제일 아래로 이동
        $("#chatroom").scrollTop($("#chatroom")[0].scrollHeight);
    }
    // 메세지 전송 - 엔터 감지
    $("#inputchat").on("keydown", function (e) {
        if (e.key === "Enter") {
            e.preventDefault(); // 줄바꿈 막기
            sendMessage();
        }
    });

    // 메세지 전송 - 보내기 버튼 클릭 시
    $(".iconBtn").on("click", function () {
        sendMessage();
    });

        // 이모지 아이콘 클릭시 이모지 박스 나타났다 사라졌다 하기
        $("#emojiIcon").on("click", function () {
            $(".emojibox").fadeToggle(500);
            $(".emojibox").css("display", "inline-block");
        })

        // 이모지 하나 눌렀을 때 채팅 입력창에 '하나만' 넣고 즉시 전송
		$(document).on("click", ".emojibox img", function () {
		    let emoji = $(this).clone();    // 선택한 이모지 복사
		    $("#inputchat").html(emoji);    // 입력창에 교체 (append → html)
		    sendMessage();                  // 바로 전송
		    $(".emojibox").hide();          // 이모지 박스 닫기
		});
        
    // 메세지 div 출력하는 함수
    function displayChat(data){
    	// 채팅방으로 보낼 메세지 박스 div
        let msgbox = $("<div>").addClass("msgbox");
		
        // 데이터 나누기
		let userId = data.sender;
		let message = data.content;
		
        // 현재 시간 가져오기
        let time = data.time;
        console.log(time);
        let timeStr = formatTime(time);
        console.log(timeStr);
        // 시간 div
        let timebox = $("<div>").addClass("timebox").text(timeStr);

		// userId == loginId
		let loginId = "${loginId}";
		if (loginId === userId) {
		    msgbox = $("<div>").addClass("msgbox"); // 내가 보낸 거
		    userIdDiv = $("<div>").addClass("userIdDiv myId").text(userId);
		} else {
		    msgbox = $("<div>"). toggleClass("other_msgbox"); // 상대방 거
		    userIdDiv = $("<div>").addClass("userIdDiv otherId").text(userId);
		}
		
		// 메세지 div
        let msgdiv = $("<div>").addClass("msgdiv").html(message);

        // 합치기 (아이디는 msgbox 위에 추가)
    	$("#chatroom").append(userIdDiv).append(msgbox.append(msgdiv).append(timebox));
    }

    // 공통 함수: 입력값 읽어서 채팅 전송
    function sendMessage() {
        let msg = $("#inputchat").html().trim();
        if (msg === "") return; // 빈값이면 무시

        // 2. 서버로 메세지 내용 보내기
        ws.send(msg);

        // 입력창 비우기
        $("#inputchat").html("");
        
     	// 내가 보낸 메시지 바로 스크롤 내리기
        $("#chatroom").scrollTop($("#chatroom")[0].scrollHeight);
    }

    function formatTime(serverTimeStr) {
        let date = new Date(serverTimeStr);  // "Sep 18, 2025, 3:01:30 PM" → Date 객체 변환

        let hours = date.getHours();
        let minutes = date.getMinutes().toString().padStart(2, "0");
        let ampm = hours >= 12 ? "오후" : "오전";
        hours = hours % 12;
        hours = hours ? hours : 12; // 0시는 12로 표시
        return ampm + " " + hours + ":" + minutes;
    }
    </script>
</body>
</html>