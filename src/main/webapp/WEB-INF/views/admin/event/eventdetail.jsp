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
			<div class="box">
			<div class="box-header">
				<h3 class="box-title">상세보기</h3>
			</div>
			<div class="box-body">
				<div class="form-group" style = "width:40%; float:left; margin-right:15px;">
					<label>행사이름</label> <input type="text" name="ev_name"
						class="form-control" value="${detail.ev_name}" readonly="readonly" />
				</div>
				<div class="form-group" style = "width:40%;float:left;">
					<label>행사장소</label> <input type="text" name="ev_loc"
						class="form-control" value="${detail.ev_loc}" readonly="readonly" />
				</div>
				<br>
				<br>
				<br>
				<div class="form-group">
					<label>행사정보url</label>
					<textarea name="ev_url" readonly="readonly"
						class="form-control" style="width: 80.8%;">${detail.ev_url}</textarea>
				</div>

				<div class="form-group">
					<label >행사기간</label><br> <input type="text" name="ev_startdate"
						class="form-control" value="${detail.ev_startdate}" readonly="readonly" style ="width:40%; float:left;"><p  style ="float:left;">~</p><input type="text" name="ev_enddate"
						class="form-control" value="${detail.ev_enddate}" readonly="readonly" style ="width:40%; float:left;">
				</div>
				<br><br>
				<div class="form-group">
					<label>행사이미지</label> <input type="image" name="ev_pic"
						class="form-control" style="width:50%;" src="${contextPath }/resources/images/event/${detail.ev_pic}" readonly="readonly" />
				</div>
		
			</div>

		</div>
			<button onclick="location.href='${contextPath}/admin/event/eventdelete?ev_id=${detail.ev_id }'">삭제</button>
			<button onclick="location.href='${contextPath}/admin/event/eventupdate?ev_id=${detail.ev_id }'">수정</button>
			<button onclick="location.href='${contextPath}/admin/event'">목록</button>
			</main>
			<%@ include file="../../include/footer.jsp"%>
		</div>
	</div>
	<%@ include file="../../include/plugin.jsp"%>
</body>
</html>