<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko" class="light-style" dir="ltr" data-theme="theme-default"
	data-assets-path="resources/assets/"
	data-template="vertical-menu-template-free">
<head>
<meta charset="UTF-8">
<!-- 반응형 웹페이지 -->
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />

<title>chatRoom</title>

<!-- Sneat 템플릿 CSS -->
<%@ include file="../commons/cssConf.jsp"%>

<style type="text/css">
#chatMessages {
    height: 600px;
    padding: 10px;
    overflow-y: auto;
}
</style>
</head>
<body>
	<div class="layout-wrapper layout-content-navbar">
		<div class="layout-container">
			<div class="layout-page">
				<%@include file="./common/nav.jsp"%>
				<div class="container-xxl flex-grow-1 container-p-y">
					<h4 class="fw-bold py-3 mb-4">
						<span class="text-muted fw-light">채팅방 입장 - ROOM ID : chatroomID /</span>
					</h4>
					<div class="card">
						<div class="card-body">
							<div id="chatMessages" class="mb-3">ddd</div>
						
							<div class="input-group mt-3">
								<input type="text" id="chatInput" class="form-control" placeholder="메시지를 입력하세요">
								<button class="btn btn-primary" onclick="sendMessage()">전송</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>



	<%@include file="./common/footer.jsp"%>
	<%@include file="../commons/jsConf.jsp"%>
	
	<script type="text/javascript">
	const roomId = 1; // 채팅방 id
	const ws= new WebSocket("ws://" + location.host + "/platform/chatt/" + roomId);
	
	// 연결,전송,종료
	ws.onopen = function(){
		alert("websocket 연결 성공");
	}
	ws.onmessage = function(event) {
		const data = JSON.parse(event.data);
		showMessage(data.sender, data.message, data.timestamp);
	}
	ws.onclose = function () {
		console.log("websocket 연결 종료"); 
	}
	
	//Enter키로 메시지 전송 
	$('#chatInput').keypress(function(e){
		if(e.which === 13){
			sendMessage();
		}
	});
	
	// 메시지 전송
	window.sendMessage = function() {
		const input = $('#chatInput');
		const msg = input.val().trim();
		
		if(msg === "") return;
		
		ws.send(msg);
		input.val("");		// 전송 후 초기화
		
	}
	
	// 메시지 출력
	function showMessage(sender, message, timestamp){
		const timeText = timestamp || new Date().toLocalTimeString();
		const msgHTML = `
							<div class="chat-msg">
								<strong>보내는 사람 :</strong> 메세지입니다.
								<small class="text-muted">2025.09.10 13:09</small>
							</div>
						`;
						
		const chatBox = $('#chatMessages');
	
		
		chatBox.append(msgHTML);
		chatBox.scrollTop(chatBox[0].scrollHeight);
		//chatBox.scrollTop = chatBox.scrollHeight; // 스크롤 가장 마지막으로 내리기
	}
	
	</script>
</body>
</html>