<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<%@ include file="include/head.jsp"%>

<body class="sb-nav-fixed">

	<%@ include file="include/nav_bar.jsp"%>

	<div id="layoutSidenav">
	
		<%@ include file="include/layoutSidenav.jsp"%>

		<div id="layoutSidenav_content">
			<main>
				<!-- contents -->
				<!-- 각자 맡은 페이지 만들시 해당 페이지의 css, 이미지 등 스타일 요소들은 헤더를 <main> 영역 안에 <link> 를 이용해 넣으면 됨.-->
				<!-- index.jsp 참고 -->
				<h1>Home Page</h1>
			</main>
			<%@ include file="include/footer.jsp"%>
		</div>
	</div>
	<%@ include file="include/plugin.jsp"%>
</body>
</html>
