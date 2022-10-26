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
    display: block;
}

/* Change color of dropdown links on hover */
.dropdown-content a:hover {background-color: #f1f1f1}

/* Show the dropdown menu (use JS to add this class to the .dropdown-content container when the user clicks on the dropdown button) */
.show {display:block;}

</style>
<body class="sb-nav-fixed">

	<%@ include file="../../include/nav_bar.jsp"%>

<script>




$(document).ready(function(){
	$("#ui_id").keyup(function(event) {
	    if (event.keyCode === 13) {
	        $("#searchuserbutton").click();
	    }
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
	            htmls+= '<th scope="col" class="th-date">회원등급</th>';
	            htmls+= '<th scope="col" class="th-date">제재상태</th>';
	            htmls+= '<th scope="col" class="th-date">가입일</th>';
	            htmls+= '</tr>';
	            htmls+= '</thead><tbody><tr>';
	            htmls+= '<td><div class="dropdown">';
				htmls+= '<button onclick="userdropdown()" class="dropbtn" style ="background-color: white;">'+result.ui_id+'</button>';
				htmls+=	'<div id="myDropdown" class="dropdown-content">';
				<% LoginVO admincheck = (LoginVO)session.getAttribute("user");
					if(admincheck.getUi_grade().equals("관리자")){				%>
				htmls+= '<a href="${contextPath }/admin/usergrademanage/usergrade?ui_id='+result.ui_id+'&grade=매니저">매니저</a>';
				htmls+=	'<br>';
				<%}%>
				htmls+=	'<a href="${contextPath }/admin/usergrademanage/usergrade?ui_id='+result.ui_id+'&grade=전문가">전문가</a>';
				htmls+=	'<br>';
				htmls+= '<a href="${contextPath }/admin/usergrademanage/usergrade?ui_id='+result.ui_id+'&grade=평회원">평회원</a>';
				htmls+= '</div>';
				htmls+= '</div></td>';
	            htmls+= '<td>'+result.ui_ncName+'</td>';
	            htmls+= '<td>'+result.ui_grade+'</td>';
	            htmls+= '<td>'+prohibit+'</td>';
	            htmls+= '<td>'+result.ui_registerdate+'</td>';
	            htmls+= '</tr>';
	            htmls+= '</tbody>';
	            htmls+= '</table>';
	            
	            $("#searcheduser").remove();
	            $("#searchuser").append(htmls);
				
			},
			error:function(result){
				alert("해당유저 없음.");
			}
			
			
		});
		
		
		
	
	});

	
});
function userdropdown(){
	document.getElementById("myDropdown").classList.toggle("show");
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
	<div id="layoutSidenav">
	
		<%@ include file="../../include/layoutSidenav.jsp"%>

		<div id="layoutSidenav_content">
			<main>
			<link rel="stylesheet" href="${contextPath }/resources/assets/css/eventboard.css" />
			<br><br>
				<div class="page-title">
        <div class="container">
            <h3>등급변경</h3>
        </div>
			<div id ="searchuser">
		<div style = "text-align: center;">유저ID:<input type = "text" id="ui_id" name="ui_id"></input></div>
		</div>
	<div style = "text-align: center;"><button id = "searchuserbutton">검색</button></div>
	<section class="notice">
  <div class="page-title">
        <div class="container">
            <h3>등업 신청 목록</h3>
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
                    <th scope="col" class="th-date">작성자ID</th>
                    <th scope="col" class="th-date">거절</th>
                    <th scope="col" class="th-date">승인</th>
 
                    
                </tr>
                </thead>
                <tbody>
              <c:forEach var="boardvo" items="${boardvo }" varStatus="index">
                <tr>
                	
                    <td>${boardvo.bo_num }</td>
                    <th style="text-align: center"><a href="${contextPath}/board/detail?num=${boardvo.bo_num }" target='_blank'>${boardvo.bo_title }</a></th>
                    <td>${boardvo.ui_id}</td>
                    <td><a href="${contextPath }/admin/usergrademanage/gradeupreject?bo_num=${boardvo.bo_num}">거절</a></td>
                    <td><div class="dropdown">
						  <button onclick="userdropdown1(${index.index},${listsize })" class="dropbtn" style ="background-color: white;">등급선택</button>
						  <div id="myDropdown1_${index.index }" class="dropdown-content">
						    <a href="${contextPath }/admin/usergrademanage/usergrade?ui_id=${boardvo.ui_id}&grade=매니저&bo_num=${boardvo.bo_num}">매니저</a>
						    <br>
						    <a href="${contextPath }/admin/usergrademanage/usergrade?ui_id=${boardvo.ui_id}&grade=전문가&bo_num=${boardvo.bo_num}">전문가</a>
						    <br>
						    <a href="${contextPath }/admin/usergrademanage/usergrade?ui_id=${boardvo.ui_id}&grade=평회원&bo_num=${boardvo.bo_num}">평회원</a>
						  </div>
						</div></td>
                	
                </tr>
               </c:forEach>
               
                </tbody>
            </table>
            <script>
function userdropdown1(bo_num,listsize) {//드롭다운메뉴
   	for(var i =0;i<listsize;i++){
   		
	document.getElementById("myDropdown1_"+i).classList.remove("show");
   	}
	document.getElementById("myDropdown1_"+bo_num).classList.add("show");
	
}
</script>
        </div>
    </div>
<script>

</script>
</section>
	
			</main>
			<%@ include file="../../include/footer.jsp"%>
		</div>
	</div>
	<%@ include file="../../include/plugin.jsp"%>
</body>
</html>
