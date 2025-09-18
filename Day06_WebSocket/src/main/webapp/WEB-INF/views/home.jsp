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
 

<style>
        * {
            box-sizing: border-box;
        }

        /* 컨테이너 */
       .container {
		    position: relative; /* 기준점 */
		    border: 1px solid rgb(0, 0, 0);
		    border-radius: 5px;
		    width: 400px;
		    height: 400px;
		    margin: auto;
		    display: flex;
		    flex-direction: column;
		}

        /* 채팅방 */
		#chatroom {
		    flex: 1;
		    overflow: auto;
		    background-color: #fff;
		    border-bottom: 1px solid black;
		    display: flex;
		    flex-direction: column;
		    align-items: flex-end;
		    position: relative; /* 이모지 박스 기준점 */
		}

        /* 숨겨져 있는 이모지 박스 */
		.emojibox {
		    position: absolute;
		    bottom: 20%;
		    left: 0;
		    width: 100%;
		    max-height: 150px;
		    display: none;
		    overflow: auto;
		    border-top: 1px solid #ccc;
		    background: rgba(255, 255, 255, 0.8); /* 흰색 + 80% 불투명 */
		    z-index: 10;
		}

        /* 스크롤바 숨기기 */
        .emojibox::-webkit-scrollbar {
            width: 2px;
            /* 가로 스크롤바를 숨기기 */
            height: 1px;
            /* 세로 스크롤바를 숨기기 */
        }

        /* 숨겨져 있는 이모지box 이미지들 */
        .emojibox img {
		    width: 24%;
		    height: auto;
		    cursor: pointer;
		}

        /* 호버 효과 */
        .emojibox img:hover,
        .iconBtn:hover,
        .emojiIcon:hover {
            cursor: pointer;
        }

        /* 채팅입력창 + 버튼 */
        /* 채팅 입력창 */
		.chatcraft {
		    height: 20%;
		    display: flex;
		}

        /* 이모지 div */
        .emojiIcon {
            width: 10%;
            height: 100%;
            float: left;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            color: rgb(218, 128, 245);
        }

        /* 채팅입력 div */
        .inputchat {
            width: 70%;
            height: 100%;
            float: left;
            overflow: auto;
            background-color: rgb(255, 255, 255);
            padding: 5px;
        }

        .inputchat img{
            max-width: 70px;
            height: 70px;
        }

        /* 채팅방으로 보내지는 메세지 박스 + 시간 */
        .msgbox {
		    max-width: 75%;
		    background: linear-gradient(135deg, #6f45f8, #dc65f6);
		    color: white;
		    padding: 5px;
		    margin: 5px;
		    border-radius: 10px;
		
		    display: flex;
		    flex-direction: column;   /* 세로 정렬 */
		    align-items: flex-end;    /* 시간은 오른쪽 */
		    gap: 3px;
		}

        /* 시간 박스 */
        .timebox {
            width: 20%;
            min-width: 50px;
            height: 100%;
            font-size: 10px;
            margin-left: 5px;

            display: flex;
            justify-content: center;
            align-items: end;
        }
            
        /* 채팅방으로 보내지는 div */
        .msgdiv {
		    width: 100%;
		    word-wrap: break-word;
		    overflow-wrap: break-word;
		}

        .msgdiv img {
		    max-width: 70px;
		    max-height: 70px;
		    margin: 2px;
		}


        /* 버튼 박스 */
        .btnBox {
            border-left: 0px;
            width: 20%;
            height: 100%;
            float: left;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* 아이콘 버튼 */
        .iconBtn {
            width: 70%;
            height: 70%;
            text-align: center;
            border: 0px;
            border-radius: 50%;
            background-color: rgb(218, 128, 245);

        }

        .fa-paper-plane {
            color: white;
        }
    </style>


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
		<a href="/login"><button>로그인</button></a>
	</div>


    <script>
    // 1. 웹소켓 인스턴스 생성
    let ws = new WebSocket("ws://10.5.5.8/chat"); // localhost라고 하면 클라이언트의 localhost로 접속되므로 ip 사용
 	
    // 3. 서버로부터 메세지 받기
    ws.onmessage = (e)=> { // 받는 타입이 2가지 (history, chat)
    	console.log(e);
	
     	// 다시 역직렬화 
    	let data = JSON.parse(e.data);
    	console.log(data.type);
    	if(data.type == "chat"){
    		// 합치기
    		displayChat(data.data);
    	}else if(data.type == "history"){
    		for(let i of data.data){
    			// 합치기
				displayChat(i);
    		}
    	}
        // 스크롤 제일 아래로 이동
        $("#chatroom").scrollTop($("#chatroom")[0].scrollHeight);
    }
    
    // 메세지 div들 합치는 함수
    function displayChat(chat){
    	// 채팅방으로 보낼 메세지 박스 div
	    let msgbox = $("<div>").addClass("msgbox");

	 	// 현재 시간 가져오기
	    let now = new Date();
	    let timeStr = now.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
	 	// 시간 div
	    let timebox = $("<div>").addClass("timebox").text(timeStr);
		
        // 메세지 내용 담을 div
        let msgdiv = $("<div>").addClass("msgdiv").html(chat);
        
        // 합치기
	    msgbox.append(msgdiv).append(timebox);
	    $("#chatroom").append(msgbox);
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

    // 엔터 감지
    $("#inputchat").on("keydown", function (e) {
        if (e.key === "Enter") {
            e.preventDefault(); // 줄바꿈 막기
            sendMessage();
        }
    });

    // 보내기 버튼 클릭 시
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



    </script>
</body>
</html>