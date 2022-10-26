<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<%@ include file="../include/head.jsp"%>

<body class="sb-nav-fixed" style="padding-top: 5rem;">

	<%@ include file="../include/nav_bar.jsp"%>

	<div id="layoutSidenav">

		<%@ include file="../include/layoutSidenav.jsp"%>

		<div id="layoutSidenav_content">
			<main>
				<!-- include libraries(jQuery, bootstrap) -->
				<link
					href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"
					rel="stylesheet">
				<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
				<script
					src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>




				<!-- 글수정 폼 -->
				<table>

					<form name="form" method="POST" >
						<input type="hidden" id="pl_num" name="pl_num"
							value="${map.pl_num	}"> <input type="hidden" id="pl_lat"
							name="pl_lat" value="${map.pl_lat}" /> <input type="hidden"
							id="pl_lon" name="pl_lon" value="${map.pl_lon	}" />

						<div class="form-group" style="margin: 5px">
							<label style="margin-left: 40px">-${map.pl_name} 정보수정- </label>
						</div>
						<div class="form-group" style="margin: 5px">
							<label>카테고리</label> <select name="pl_category" id="pl_category">
								<option value="병원">병원</option>
								<option value="카페">카페</option>
								<option value="마트">마트</option>
								<option value="식당">식당</option>
								<option value="놀이터">놀이터</option>
								<option value="기타">기타</option>
							</select>
						</div>
						<div class="form-group" style="margin: 5px">
							<label>url</label> <input type="text" name='pl_url'
								class="form-control" value="${map.pl_url }"
								style="text-align: center; width: 200px;">
						</div>

						<div class="form-group" style="margin: 5px">
							<label>전화번호</label> <input type="text" name='pl_phnum'
								class="form-control" value="${map.pl_phnum }" style="text-align: center; width: 200px;">
						</div>
						<div class="form-group" style="margin: 5px">
							<label>작성자</label> <input type="text" name="ui_id"
								class="form-control" value="${map.ui_id}" readonly style="text-align: center; width: 200px;">
						</div><Br>
						<div class="box-footer">
							<button type="submit" class="btn btn-primary" style="text-align: center; width: 200px; margin: 5px;">작성완료</button>
						</div>
				</table>
				</form>



			</main>
			<%@ include file="../include/footer.jsp"%>
		</div>
	</div>
	<%@ include file="../include/plugin.jsp"%>
</body>
</html>
