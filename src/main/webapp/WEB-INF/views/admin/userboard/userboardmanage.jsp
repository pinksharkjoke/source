<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<%@ include file="../../include/head.jsp"%>
<style>
.dropbtn {
    color: balck;
    padding: 16px;
    font-size: 16px;
    border: none;
    cursor: pointer;
}

/* Dropdown button on hover & focus */
.dropbtn:hover, .dropbtn:focus {
    background-color: #3e8e41;
}

/* The container <div> - needed to position the dropdown content */
.dropdown {
    position: static;
    display: inline-block;
}

/* Dropdown Content (Hidden by Default) */
.dropdown-content {
    display: none;
    position: absolute;
    background-color: white;
    min-width: 160px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
}

/* Links inside the dropdown */
.dropdown-content a {
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display:inline-block;
}

/* Change color of dropdown links on hover */
.dropdown-content a:hover {background-color: #f1f1f1}

/* Show the dropdown menu (use JS to add this class to the .dropdown-content container when the user clicks on the dropdown button) */
.show {display:inline-block;}
.hide {display:none;}
</style>
<script>

$(document).ready(function(){
	$("#ui_id").keyup(function(event) {
	    if (event.keyCode === 13) {
	        $("#searchuserbutton").click();
	    }
	});

	
	$(document).on('click','#searchuserstart',function(){
		var htmls = '';
		
		htmls += '<div id ="searchuser">';
		htmls +='<div style = "text-align: center;">유저ID:<input type = "text" id="ui_id" name="ui_id"></input></div>';
		htmls +='</div>';
		htmls += '<div style = "text-align: center;"><button id = "searchuserbutton">검색</button><button id="fold">접기</button></div>';
		
		$("#searchuser").replaceWith(htmls);
		$("#searchuserstart").remove();
	
		
	});
	$(document).on('click',"#searchuserbutton",function(){
	
			
		
		var user = $("#ui_id").val();		
		var url = "${contextPath}/admin/userboardmanage/searchuser";
		var htmls = "";
		$.ajax({
			url: url,
			data:{"ui_id":user},
			dataType:'json',
			type: 'POST',
			success:function(result){
				var prohibit = "";
				if(result.ui_prohibit == 0){
					prohibit = "정상";
				}else if(result.ui_prohibit == 1&&result.ui_enprohibit == "2999-12-31"){
					prohibit = "영구정지";
				}else if(result.ui_prohibit == 1){
					prohibit = "기간정지";
				}else if(result.ui_prohibit == 2){
					prohibit = "글쓰기 제한";
				}
				
				
				htmls+= '<table id="searcheduser" class="board-table" >';
	            htmls+= '<thead>';
	            htmls+= '<tr>';
	            htmls+= '<th scope="col" class="th-date">ID</th>';
	            htmls+= '<th scope="col" class="th-date">닉네임</th>';
	            htmls+= '<th scope="col" class="th-date">현재 제재상태</th>';
	            htmls+= '<th scope="col" class="th-date">제재기간</th>';
	            htmls+= '<th scope="col" class="th-date">가입일</th>';
	            htmls+= '</tr>';
	            htmls+= '</thead><tbody><tr>';
	            htmls+= '<td><div class="dropdown">';
				htmls+= '<button onclick="userdropdown3()" class="dropbtn" style ="background-color: white;">'+result.ui_id+'</button>';
				htmls+=	'<div id="myDropdown3" class="dropdown-content">';
				htmls+= '<a href="${contextPath }/admin/userboardmanage/userban?ui_id='+result.ui_id+'&period=3">3일 정지</a>';
				htmls+=	'<br>';
				htmls+=	'<a href="${contextPath }/admin/userboardmanage/userban?ui_id='+result.ui_id+'&period=7">1주 정지</a>';
				htmls+=	'<br>';
				htmls+= '<a href="${contextPath }/admin/userboardmanage/userban?ui_id='+result.ui_id+'&period=30">1달 정지</a>';
				htmls+=	'<br>';
				htmls+= '<a href="${contextPath }/admin/userboardmanage/userban?ui_id='+result.ui_id+'&period=100">영구 정지</a>';
				htmls+= '<br>';
				htmls+= '<a href="${contextPath }/admin/userboardmanage/writeban?ui_id='+result.ui_id+'">1주 글쓰기 제한</a>';
				htmls+= '<br>';
				htmls+= '<a href="${contextPath}/admin/userboardmanage/userban?ui_id='+result.ui_id+'&period=0">정지해제</a>';
				htmls+= '</div>';
				htmls+= '</div></td>';
	            htmls+= '<td>'+result.ui_ncName+'</td>';
	            htmls+= '<td>'+prohibit+'</td>';
	            htmls+= '<td>'+result.ui_stprohibit+'~'+result.ui_enprohibit+'</td>';
	            htmls+= '<td>'+result.ui_registerdate+'</td>';
	            htmls+= '</tr>';
	            htmls+= '</tbody>';
	            htmls+= '</table>';
	            
	            $("#searcheduser").remove();
	            $("#searchuser").append(htmls);
				
			},
			error:function(result){
				alert("찾는유저 없음.");
			}
			
			
		});
		
		
		
	});
	$(document).on('keyup',"#ui_id",function(event){
		if(event.keyCode ===13){
			
		
		var user = $("#ui_id").val();		
		var url = "${contextPath}/admin/userboardmanage/searchuser";
		var htmls = "";
		$.ajax({
			url: url,
			data:{"ui_id":user},
			dataType:'json',
			type: 'POST',
			success:function(result){
				var prohibit = "";
				if(result.ui_prohibit == 0){
					prohibit = "정상";
				}else if(result.ui_prohibit == 1&&result.ui_enprohibit == "2999-12-31"){
					prohibit = "영구정지";
				}else if(result.ui_prohibit == 1){
					prohibit = "기간정지";
				}else if(result.ui_prohibit == 2){
					prohibit = "글쓰기 제한";
				}
				
				
				htmls+= '<table id="searcheduser" class="board-table" >';
	            htmls+= '<thead>';
	            htmls+= '<tr>';
	            htmls+= '<th scope="col" class="th-date">ID</th>';
	            htmls+= '<th scope="col" class="th-date">닉네임</th>';
	            htmls+= '<th scope="col" class="th-date">현재 제재상태</th>';
	            htmls+= '<th scope="col" class="th-date">제재기간</th>';
	            htmls+= '<th scope="col" class="th-date">가입일</th>';
	            htmls+= '</tr>';
	            htmls+= '</thead><tbody><tr>';
	            htmls+= '<td><div class="dropdown">';
				htmls+= '<button onclick="userdropdown3()" class="dropbtn" style ="background-color: white;">'+result.ui_id+'</button>';
				htmls+=	'<div id="myDropdown3" class="dropdown-content">';
				htmls+= '<a href="${contextPath }/admin/userboardmanage/userban?ui_id='+result.ui_id+'&period=3">3일 정지</a>';
				htmls+=	'<br>';
				htmls+=	'<a href="${contextPath }/admin/userboardmanage/userban?ui_id='+result.ui_id+'&period=7">1주 정지</a>';
				htmls+=	'<br>';
				htmls+= '<a href="${contextPath }/admin/userboardmanage/userban?ui_id='+result.ui_id+'&period=30">1달 정지</a>';
				htmls+=	'<br>';
				htmls+= '<a href="${contextPath }/admin/userboardmanage/userban?ui_id='+result.ui_id+'&period=100">영구 정지</a>';
				htmls+= '<br>';
				htmls+= '<a href="${contextPath }/admin/userboardmanage/writeban?ui_id='+result.ui_id+'">1주 글쓰기 제한</a>';
				htmls+= '<br>';
				htmls+= '<a href="${contextPath}/admin/userboardmanage/userban?ui_id='+result.ui_id+'&period=0">정지해제</a>';
				htmls+= '</div>';
				htmls+= '</div></td>';
	            htmls+= '<td>'+result.ui_ncName+'</td>';
	            htmls+= '<td>'+prohibit+'</td>';
	            htmls+= '<td>'+result.ui_stprohibit+'~'+result.ui_enprohibit+'</td>';
	            htmls+= '<td>'+result.ui_registerdate+'</td>';
	            htmls+= '</tr>';
	            htmls+= '</tbody>';
	            htmls+= '</table>';
	            
	            $("#searcheduser").remove();
	            $("#searchuser").append(htmls);
				
			},
			error:function(result){
				alert("찾는유저 없음.");
			}
			
			
		});
		}
		
		
	});
	$(document).on('click','#fold',function(){
		var buttonchange = '<div style = "text-align: center;"><button id="searchuserstart">유저검색</button></div>';
		var htmls = '<div id ="searchuser"></div>';
		$("#fold").remove();
		$("#searchuserbutton").remove();
		$("#searchuser").replaceWith(htmls);
		$("#searchuser").append(buttonchange);
		
	});
	
	
});



function userdropdown(bo_num) {//드롭다운메뉴
   	for(var i =0;i<10;i++){
   		
	document.getElementById("myDropdown1_"+i).classList.remove("show");
   	}
	document.getElementById("myDropdown1_"+bo_num).classList.add("show");
	
}
function userdropdown2(bo_num,end) {//드롭다운메뉴
 	for(var i =0;i<end;i++){
   		
 		document.getElementById("myDropdown2_"+i).classList.remove("show");
 	   	}
 	   	console.log(end);
 		document.getElementById("myDropdown2_"+bo_num).classList.add("show");
}
function userdropdown3() {//드롭다운메뉴
    document.getElementById("myDropdown3").classList.toggle("show");
}

// Close the dropdown menu if the user clicks outside of it
window.onclick = function(event) {
  if (!event.target.matches('.dropbtn')) {

    var dropdowns = document.getElementsByClassName("dropdown-content");
    var i;
    for (i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i];
      if (openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show');
      }
    }
  }
}


</script>


<body class="sb-nav-fixed">

	<%@ include file="../../include/nav_bar.jsp"%>

	<div id="layoutSidenav">

		<%@ include file="../../include/layoutSidenav.jsp"%>
	
		<div id="layoutSidenav_content">
			<main>
				<link rel="stylesheet" href="${contextPath }/resources/assets/css/eventboard.css" />
				<br><br>
				<div class="page-title">
        <div class="container">
            <h3>유저제재</h3>
        </div>
				<div id ="searchuser"></div>
				<div style = "text-align: center;">
				<button id="searchuserstart">유저검색</button>
				</div>
    	
    </div>
<section class="notice">
  <div class="page-title">
        <div class="container">
            <h3>신고글 목록</h3>
        </div>
    </div>

   
  <!-- board list area -->
    <div id="board-list">
        <div class="container" style ="width: 100%;">
            <table class="board-table" >
                <thead>
                <tr>
                	
                    <th scope="col" class="th-num">번호</th>
                    <th scope="col" class="th-title">게시글제목</th>
                    <th scope="col" class="th-date">게시일</th>
                    <th scope="col" class="th-date">작성자ID</th>
                    <th scope="col" class="th-date">게시판 분류</th>
                    <th scope="col" class="th-date">삭제</th>
                    <th scope="col" class="th-date">신고대상아님</th>
 
                    
                </tr>
                </thead>
                <tbody>
              <c:forEach var="board" items="${boardvo }"  varStatus="index" >
                <tr>
                	
                    <td>${board.bo_num }</td>
                    <th style="text-align: center"><a href="${contextPath}/board/detail?num=${board.bo_num }" target='_blank'>${board.bo_title }</a></th>
                    <td>${board.bo_DATE}</td>
                    <td><div class="dropdown">
						  <input type="button" onclick="userdropdown(${index.index })" class="dropbtn" style ="background-color: white;" value="${board.ui_id }">
						  
						  <div id="myDropdown1_${index.index }"  class="dropdown-content">
						    <a href="${contextPath }/admin/userboardmanage/userban?ui_id=${board.ui_id}&period=3">3일 정지</a>
						    <br>
						    <a href="${contextPath }/admin/userboardmanage/userban?ui_id=${board.ui_id}&period=7">1주 정지</a>
						    <br>
						    <a href="${contextPath }/admin/userboardmanage/userban?ui_id=${board.ui_id}&period=30">1달 정지</a>
						    <br>
						    <a href="${contextPath }/admin/userboardmanage/userban?ui_id=${board.ui_id}&period=100">영구 정지</a>
						    <br>
						    <a href="${contextPath }/admin/userboardmanage/writeban?ui_id=${board.ui_id}">1주 글쓰기 제한</a>
						  </div>
						  </div>
					</td>
                    <c:if test="${board.ca_num == 101 || board.ca_num == 102 || board.ca_num == 103}">
                    <td>펫자랑</td>
                    </c:if>
                    <c:if test="${board.ca_num == 201 || board.ca_num == 202 || board.ca_num == 203 || board.ca_num == 204 || board.ca_num == 205 || board.ca_num == 206 || board.ca_num == 207 || board.ca_num == 208}">
                    <td>지역별</td>
                    </c:if>
                    <c:if test ="${board.ca_num == 1 }">
                    <td>자유게시판</td>
                    </c:if>
                    <c:if test ="${board.ca_num == 2 }">
                    <td>질문 Q&A</td>
                    </c:if>
                    <c:if test ="${board.ca_num == 3 }">
                    <td>꿀팁 게시판</td>
                    </c:if>
                    <c:if test = "${board.ca_num == 301 || board.ca_num == 302 || board.ca_num == 303 || board.ca_num == 304 || board.ca_num == 305 || board.ca_num == 306 || board.ca_num == 307}">
                	<td>중고장터</td>
                	</c:if>
                	<c:if test="${board.ca_num == 308 }">
                	<td>나눔</td>
                	</c:if>
                	<td><a href="${contextPath }/admin/userboardmanage/boarddelete?bo_num=${board.bo_num}">삭제</a></td>
                	<td><a href="${contextPath }/admin/userboardmanage/boardback?bo_num=${board.bo_num}">신고대상아님</a></td>
                </tr>
               </c:forEach>
                </tbody>
            </table>
        <div>
  <ul>
    <c:if test="${boardpageMaker.prev}">
    	<li><a href="userboardmanage${boardpageMaker.makeQuery(boardpageMaker.startPage - 1)}">이전</a></li>
    </c:if> 

    <c:forEach begin="${boardpageMaker.startPage}" end="${boardpageMaker.endPage}" var="idx">
    	<li><a href="userboardmanage${boardpageMaker.makeQuery(idx)}">${idx}</a></li>
    </c:forEach>

    <c:if test="${boardpageMaker.next && boardpageMaker.endPage > 0}">
    	<li><a href="userboardmanage${boardpageMaker.makeQuery(boardpageMaker.endPage + 1)}">다음</a></li>
    </c:if> 
  </ul>
</div>
        
        </div>
    </div>

</section>
<!-- 댓글신고목록 -->
<section class="notice">
  <div class="page-title">
        <div class="container">
            <h3>신고댓글 목록</h3>
        </div>
    </div>

   
  <!-- board list area -->
    <div id="board-list">
        <div class="container" style ="width: 100%;">
            <table class="board-table" >
                <thead>
                <tr>
                	
                    <th scope="col" class="th-num">번호</th>
                    <th scope="col" class="th-title">게시글바로가기</th>
                    <th scope="col" class="th-date">댓글내용</th>
                    <th scope="col" class="th-date">작성자ID</th>
                    <th scope="col" class="th-date">삭제</th>
                    <th scope="col" class="th-date">신고대상아님</th>
 
                    
                </tr>
                </thead>
                <tbody>
              <c:forEach var="reply" items="${replyvo }" varStatus="index">
                <tr>
                	
                    <td>${reply.co_num }</td>
                    <th style="text-align: center"><a href="${contextPath}/board/detail?num=${reply.bo_num }" target='_blank'>게시글바로가기</a></th>
                    <td>${reply.co_content}</td>
                    <td><div class="dropdown">
						  <button onclick="userdropdown2(${index.index},${listsize})" class="dropbtn" style ="background-color: white;">${reply.ui_id }</button>
						  <div id="myDropdown2_${index.index }" class="dropdown-content">
						    <a href="${contextPath }/admin/userboardmanage/userban?ui_id=${reply.ui_id}&period=3">3일 정지</a>
						    <br>
						    <a href="${contextPath }/admin/userboardmanage/userban?ui_id=${reply.ui_id}&period=7">1주 정지</a>
						    <br>
						    <a href="${contextPath }/admin/userboardmanage/userban?ui_id=${reply.ui_id}&period=30">1달 정지</a>
						    <br>
						    <a href="${contextPath }/admin/userboardmanage/userban?ui_id=${reply.ui_id}&period=100">영구 정지</a>
						    <br>
						    <a href="${contextPath }/admin/userboardmanage/writeban?ui_id=${reply.ui_id}">1주 글쓰기 제한</a>
						  </div>
						</div></td>
                	<td><a href="${contextPath }/admin/userboardmanage/replydelete?co_num=${reply.co_num}">삭제</a></td>
                	<td><a href="${contextPath }/admin/userboardmanage/replyback?co_num=${reply.co_num}">신고대상아님</a></td>
                </tr>
               </c:forEach>
                </tbody>
            </table>
            
        </div>
    </div>

</section>

			</main>
			<%@ include file="../../include/footer.jsp"%>
		</div>
	</div>
	<%@ include file="../../include/plugin.jsp"%>
</body>
</html>
