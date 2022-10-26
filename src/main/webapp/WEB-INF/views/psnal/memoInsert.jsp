<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<%@ include file="../include/head.jsp"%>
<script>
	$(document).ready(function(){
		
		$("#subButton").click(function(){
			
			if($("#title").val() == ""){
				alert("제목을 입력하세요");
				$("#title").focus();
				return false;
			}
			if($("#title").val().length > 50){
				alert("제목을 50자 이하로 입력하세요");
				$("#title").focus();
				return false;
			}
			if($("#contents").val().length > 300){
				alert("내용을 300자 이하로 입력하세요");
				$("#contents").focus();
				return false;
			}
				$("#regform").submit();
			
		}) // end of subButton click
		
	}) // end of document ready
</script>
<body class="sb-nav-fixed">

	<%@ include file="../include/nav_bar.jsp"%>

	<div id="layoutSidenav">

		<%@ include file="../include/layoutSidenav.jsp"%>

		<div id="layoutSidenav_content">
			<main>
				<h1>메모 추가</h1>
				
				<form role="form" id="regform" method="post">
			<div class="box-body">
				<div class="form-group">
					<label>제목</label> <input type="text"
						id='title' name='mm_title' class="form-control" placeholder="제목을 입력하세요">
				</div>
				<div class="form-group">
					<label>내용</label>
					<textarea class="form-control" name="mm_contents" rows="3"
						maximumcount=300 id='contents' placeholder="300자 이내로 작성하세요"></textarea>
				</div>
				<div class="form-group">
					<label>첨부파일</label>
					<input type="file" name="mm_filename">
				</div>
				<div class="form-group">
					<label>작성자</label> <input type="text" name="mm_ncname" class="form-control"  
						value="${user.ui_ncname }" readonly>
				</div>
			</div>
	
			<div class="box-footer">
				<button id="subButton" class="btn btn-primary">작성완료</button>
			</div>
		</form>
			</main>
			<%@ include file="../include/footer.jsp"%>
		</div>
	</div>
	<%@ include file="../include/plugin.jsp"%>
</body>
</html>
