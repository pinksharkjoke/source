+<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<link rel="stylesheet" href="${contextPath}/resources/test/css/main.css" />
<body class="sb-nav-fixed">
<%@ include file="../include/head.jsp"%>

	<%@ include file="../include/nav_bar.jsp"%>

	<div id="layoutSidenav">
		<%@ include file="../include/layoutSidenav.jsp"%>


		<div id="layoutSidenav_content">
			<main>
				<!-- ======= Breadcrumbs ======= -->
				<div class="breadcrumbs d-flex align-items-center"
					style="background-image: url('${contextPath}/resources/test/img/cat.jpg'); background-size:auto;">
					<div
						class="container position-relative d-flex flex-column align-items-center">

						<h2>관련 글</h2>

					</div>
				</div>
				<!-- 글목록 테이블 -->
				<section class="content container-fluid">
					<div class="table-responsive">
						<table class="table">

							<tr>
								<td>제목</td>
								<td>작성일</td>
								<td>작성자</td>
								<td>조회수</td>
								<td>좋아요</td>
							</tr>


							<!-- 일반상태 게시글 목록 0 -->
							<!-- 게시물 번호 부여 -->
							<c:forEach var="board" items="${list }" varStatus="status">

								<tr>

									<td><a href="../board/detail?num=${board.bo_num }">${board.bo_title}</a></td>
									<td>${board.bo_modifydate}</td>
									<td>${board.bo_name}</td>
									<td>${board.bo_views}</td>
									<td>${board.bo_heart}</td>
								</tr>


							</c:forEach>
						</table>
					</div>
				</section>
			</main>

		</div>
	</div>


	<%@ include file="../include/footer.jsp"%>
	<%@ include file="../include/plugin.jsp"%>

</body>
</html>
