<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>	
<!DOCTYPE html>
<html lang="en">
<style>

/* 블로그메뉴 */


div, ul, li { margin:0; padding:0; }

#blogMenu {
	float:right;
	margin:0px 5px 3px 5px;
	padding:0 0 3px 0;
	box-shadow: 0px 0px 15px rgba(0,0,0,.3);
	-moz-box-shadow: 0px 0px 15px rgba(0,0,0,.3);
	-webkit-box-shadow: 0px 0px 15px rgba(0,0,0,.3);
	-o-box-shadow: 0px 0px 15px rgba(0,0,0,.3);
	-moz-border-radius: 3px;
	-khtml-border-radius: 3px;
	-webkit-border-radius: 3px;
	border-radius: 3px;
	background-color:#5c5c5c;
}

#blogMenu ul li {
	float:left;
	list-style-type:none;
}

#blogMenu a {
	height:16px;
	color:#f1f1f1;
	font-family:arial;
	font-size:12px;
	padding:0 10px 0 10px;
	text-decoration:none;
}

#blogMenu a:hover {
	color:#D4F4FA;
	border-bottom:3px solid #FAED7D;
}

#blogMenu ul ul {

display:none;
}

#blogMenu ul li:hover ul {
 display: block;
}

</style>
<script type="text/javascript">
	console.log("script ok");
	var usernameFrom = "${username}";	
	var usernameTo = "${userTo}";

	var webSocket = new WebSocket("ws://localhost:8080/pap/chatServerEndpoint/" + usernameFrom);	
	
	// server -> client json parse 부터 안되고있음 -> escape sequence such as \b, \r, \n, -> toString 수정필요
	webSocket.onmessage = function processMessage(message) {
		console.log (message.data +"-> get message.data ok");
		
		
		let jsonData = JSON.parse(message.data);
		let tmpUsernameFrom = jsonData["usernameFrom"];
		let tmpUsernameTo = jsonData["usernameTo"];
		let contentChat = jsonData["content"];
		console.log(contentChat+"->json parse ok");
		console.log("websocket onmessage done");
		
		if((tmpUsernameFrom == usernameTo && tmpUsernameTo == usernameFrom) || (tmpUsernameTo == usernameTo && tmpUsernameFrom == usernameFrom)){
			document.getElementById("textarea").append(contentChat + "\n");
			alert(contentChat +" : textarea에 추가될 내용");
		}
	}
	
	// client -> server O
	function sendMessage() {
		let inputText = document.getElementById("input-text").value;

		let contentSend = "{ \"message\" : \"" + inputText + "\", " + 
		 					 "\"usernameFrom\" : \"" + usernameFrom + "\", " + 
		 					 "\"usernameTo\" : \"" + usernameTo + "\"}";	

		webSocket.send(contentSend);
		console.log("webcoket.send done");
		document.getElementById("input-text").value = "";
	}

</script>


<%@ include file="../include/head.jsp"%>

<body class="sb-nav-fixed">

	<%@ include file="../include/nav_bar.jsp"%>

	<div id="layoutSidenav">

		<%@ include file="../include/layoutSidenav.jsp"%>


		<div id="layoutSidenav_content">
			<main>
				<!-- contents -->
				<!-- 각자 맡은 페이지 만들시 해당 페이지의 css, 이미지 등 스타일 요소들은 헤더를 <main> 영역 안에 <link> 를 이용해 넣으면 됨.-->
				<link rel="stylesheet" href="${contextPath}/resources/test/css/main.css" />
	
				
				<!-- ======= Breadcrumbs ======= -->
		    <div class="breadcrumbs d-flex align-items-center" style="background-image: url('${contextPath}/resources/test/img/blog-header.jpg');">
		      <div class="container position-relative d-flex flex-column align-items-center">
		
		        <h2>채팅</h2>
		        <ol>
		          <li><a href="${contextPath }">메인으로 </a></li>
		          <li>${username}님의 대화</li>
		        </ol>
		
		      </div>
		    </div><!-- End Breadcrumbs -->
			<!-- loop over and print user-->
				
				
						
			<!-- Content Wrapper. Contains page content -->		
			<div class="content-wrapper">		
			<!-- 대화상대목록 -->
			<div id="blogMenu" class="list-users">
			<ul>
			<li><a href="#">대화상대목록</a>
				<ul>
					<c:forEach var="loop" items="${listUsers}">
						<c:if test = "${username != loop.ui_ncName}">
						<li><a href="chatting?usernameTo=${loop.ui_ncName}"><c:out value = "${loop.ui_ncName}"/></a></li>
						</c:if>
					</c:forEach>
			
				</ul>
				</li>
			</ul>						
			</div>
			<!-- 대화상대목록 끝 -->
			
						<!-- Main content -->
							<!-- this area contain chat box-->
			<div class="container" align="center">
				대화 상대 : <c:out value = "${userTo}"/><br />
				<textarea class="textarea" id="textarea" rows="30" cols="100"><c:out value = "${chat_content }"/></textarea>
			</div>
		
			<div class="container" align="center">
				<input type="text" id="input-text" placeholder="enter here..." style="width: 740px; height: 20px;" />
				<input type="button" id="send-text" value="send" style="width: 70px; height: 25px" onclick="sendMessage();" />
			</div>
			
			
			
			</div>
		 	<!-- /.content-wrapper -->	
				
				
				
				
				
			</main>

			<%@ include file="../include/footer.jsp"%>
		</div>
	</div>
	<%@ include file="../include/plugin.jsp"%>

</body>
</html>

