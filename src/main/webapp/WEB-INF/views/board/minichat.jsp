<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    

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

#send-text{
	width: 70px;
	height: 25px;

}

 #chat {

    position:fixed; _position:absolute; _z-index:-1;

    width:220px;

    display:inline-block;/* overflow:hidden;  같은 의미? */

    right:0px; /* //화면 오른쪽에 위치한다. left로 변경가능 */

    top:85%; /* //화면 위쪽과의 간격 */

    background-color: transparent;

    margin:0;

}
#chat:hover { background-color: pink;  } /* 마우스오버 시 배경/글씨 색깔 */

#_chat {

    position:fixed; _position:absolute; _z-index:-1;

    width:220px;

    display:inline-block;/* overflow:hidden;  같은 의미? */

    right:0px; /* //화면 오른쪽에 위치한다. left로 변경가능 */

    top:20%; /* //화면 위쪽과의 간격 */

    background-color: transparent;

    margin:0;

}

</style>


<script type="text/javascript">
	console.log("script ok");
	var usernameFrom ="${user.ui_id}";
	var usernameTo ="";
	var webSocket="";
	var name="";
	$(document).ready(function(){
		$("#input-text").keyup(function(event) {
		    if (event.keyCode === 13) {
		        $("#send-text").click();
		    }
		});
	});
	//websocket 
	webSocket = new WebSocket("ws://localhost:8080/pap/chatServerEndpoint/" + usernameFrom);
	
	// chatController ajax
	function miniChat(ui_id){
		var url = '${contextPath}/miniChat';
		var paramData = "";
		if(ui_id==null){
			$('#chatarea').empty();
		}else{
			$('#chatarea').empty();
			paramData={
					"usernameTO":ui_id
					
			}
		}
		
		console.log(ui_id+"재귀호출 넘어온 아이디");
		$.ajax({
			url:url,
			async:false,
			data:paramData,
			dataType:'json',
			type:'GET',
			success:function(chat){
				alert("From:"+chat.username+"To: "+chat.userTo);
				
			//get basic form	
				//document.getElementById("chatarea").append(chat.chat_content + "\n");
				$('#chatarea').append(chat.chat_content);
				name = getName(chat.userTo);
				$('#to').html(name);
				console.log("함수에서 넘어온:" + name);
				
				usernameTo = chat.userTo;
				usernameFrom = chat.username;
				console.log("usernameFrom"+usernameFrom +"/usernameTo:"+usernameTo);
			
				//웹소켓
				
				
				// server -> client / json parse 부터 안되고있음 -> escape sequence such as \b, \r, \n, -> toString 수정완료
				webSocket.onmessage = function processMessage(message) {
					console.log(message.data +"-> message.data ok");
					
					
					let jsonData = JSON.parse(message.data);
					let tmpUsernameFrom = jsonData["usernameFrom"];
					let tmpUsernameTo = jsonData["usernameTo"];
					let contentChat = jsonData["content"];
					console.log(contentChat);
					console.log("websocket onmessage ok"+usernameTo);
					
					if((tmpUsernameFrom == usernameTo && tmpUsernameTo == usernameFrom) || (tmpUsernameTo == usernameTo && tmpUsernameFrom == usernameFrom)){
						
						$('#chatarea').append(contentChat + "\n"); 
						console.log(contentChat+"메세지 전송 완료");
						alert(" 메세지 전송 완료");
					}
				} // end of webSocket.onmessage
				
				
				var htmls = '';	
				//대화상대목록
				$(chat.listUsers).each(function(){
					if(usernameFrom != this.ui_id){
						console.log("listUsers : "+this.ui_id);
						
						 htmls = htmls + '<li><a onclick="miniChat(\'' +this.ui_id+ '\')"> ' +this.ui_ncName + '</a></li>';
							
					}
				});
				$("#listUsers").html(htmls);

			
			},// end of success:function(chat)
			error:function(chat){
				alert('miniChat ajax 에러');
			}
			
			
		});	
	} // end of miniChat()

		
	// client -> server O
	function sendMessage() {
		let inputText = document.getElementById("input-text").value;

		let contentSend = "{ \"message\" : \"" + inputText + "\", " + 
		 					 "\"usernameFrom\" : \"" + usernameFrom + "\", " + 
		 					 "\"usernameTo\" : \"" + usernameTo + "\"}";	

		webSocket.send(contentSend);
		console.log("webcoket.send done"+usernameFrom+"&"+usernameTo);
		document.getElementById("input-text").value = "";
	}
	
	
	// 채팅 테이블 id로 유저 테이블 닉네임 가져오는 함수
	function getName(ui_id){
		var url = '${contextPath}/getName';
		var paramData = {
			"re_id" : ui_id
		};
		
		//	alert(ui_id);
		
		$.ajax({
			url:url,
			async:false,
			data:paramData,
			dataType:'json',
			contentType: 'application/json; charset=utf-8',
			type:'GET',
			success:function(result){
				if(result){
				//	alert("닉네임 조회 완료");
					console.log("결과 이름 : "+result.name);
					name=result.name;
				}else{
					alert("전송받은 값 없음");
				}
			
			},
			error:function(result, request, error){
				alert('닉네임 조회 에러'+request.status +"에러 message"+request.responseText+"error"+error);
			}
		});
		return name;
	} // end of getName
	
	
	
	
	
	

</script>

 			   <!--     채팅창 -->
 			   
				    <div id="_chatbox" style="display: none">
				    	<div id="_chat">
				        <fieldset  style="BORDER-RIGHT: skyblue 3px solid; BORDER-TOP: skyblue 3px solid; BORDER-LEFT: skyblue 3px solid; WIDTH: 400px; BORDER-BOTTOM: skyblue 3px solid;  background:skyblue; border-radius:20px; float:right">
				            <div id="messageWindow"></div>
				            	<!-- 대화상대목록 -->
								<div id="blogMenu" class="list-users">
								<ul>
								<li><a href="#">대화상대목록</a>
									<ul id="listUsers">
										
								
									</ul>
									</li>
								</ul>						
								</div>
								<!-- 대화상대목록 끝 -->
							<div align="center">
							
				            대화 상대 : <span id="to">상대목록에서 선택해주세요. </span><br>
					    	<textarea class="textarea" id="chatarea" rows="20" cols="50" ></textarea>
				            </div>
				            
				            <div class="container" align="right">
							<input type="text" id="input-text" placeholder="enter here..." style="width: 370px; height: 25px;" />
							<input type="button" id="send-text" value="send" style="width: 70px; height: 25px" onclick="sendMessage();" />
							</div>
				        </fieldset>
				       </div>
				    </div>
				   
				   
				  	<img class="chat" id="chat" onclick="miniChat()" style="float:right; width:60px; height:60px;" src="${contextPath}/resources/test/img/chat-closed.png" />
				    <!--저작권표시 <a href="https://www.flaticon.com/kr/free-icons/" title="논평 아이콘">논평 아이콘  제작자: Alfredo Hernandez - Flaticon</a> -->
				  
				</body>
				<!-- 말풍선아이콘 클릭시 채팅창 열고 닫기 -->
				<script>
				    $(".chat").on({
				        "click" : function() {
				            if ($(this).attr("src") == "${contextPath}/resources/test/img/chat-closed.png") {
				                $(".chat").attr("src", "${contextPath}/resources/test/img/chat-opened.png");
				                $("#_chatbox").css("display", "block");
				            } else if ($(this).attr("src") == "${contextPath}/resources/test/img/chat-opened.png") {
				                $(".chat").attr("src", "${contextPath}/resources/test/img/chat-closed.png");
				                $("#_chatbox").css("display", "none");
				                
				            }
				        }
				    });
				</script>

