<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<%@ include file="../../include/head.jsp"%>

<body class="sb-nav-fixed">

	<%@ include file="../../include/nav_bar.jsp"%>

	<div id="layoutSidenav">

		<%@ include file="../../include/layoutSidenav.jsp"%>
		<div id="layoutSidenav_content">
			<main>
	<form method="POST" enctype="multipart/form-data">
			<div class="box">
			<div class="box-header">
				<h3 class="box-title">행사일정 수정</h3>
			</div>
			<div class="box-body">
				<div class="form-group" style = "width:40%; float:left; margin-right:15px;">
					<label>행사이름</label> <input type="text" name="ev_name"
						class="form-control" value="${vo.ev_name }" />
				</div>
				<div class="form-group" style = "width:40%;float:left;">
					<label>행사장소</label> <input type="text" name="ev_loc"
						class="form-control" value = "${vo.ev_loc }" />
				</div>
				<br>
				<br>
				<br>
				<div class="form-group">
					<label>행사정보url</label>
					<textarea name="ev_url"
						class="form-control" placeholder = "${vo.ev_url }"></textarea>
				</div>

				<div class="form-group">
					<label >행사기간</label><br> <input type="date" name="ev_startdate"
						class="form-control" style ="width:40%; float:left;" value = "${vo.ev_startdate }"><p  style ="float:left;">~</p><input type="date" name="ev_enddate"
						class="form-control" style ="width:40%; float:left;" value = "${vo.ev_enddate }">
				</div>
				<br><br>
				<div class="form-group">
					<label>행사이미지</label> <input type="file" name="evpic"
						class="form-control" style="width:50%;">
						<br>
						현재 이미지
						<img style = "height: 200px;" src = "${contextPath }/resources/images/event/${vo.ev_pic}">
						<input type ="hidden" name="orgpic" value = "${vo.ev_pic}">
						
				</div>
		
			</div>

		</div>
		<br>
			<input type = "submit" value = "등록" style="float:left;">
			</form>
			<button style ="float: right; margin-right: 1590px;"onclick="location.href='${contextPath}/admin/event'">목록</button>
			</main>
			<%@ include file="../../include/footer.jsp"%>
		</div>
	</div>
	<%@ include file="../../include/plugin.jsp"%>
</body>
</html>