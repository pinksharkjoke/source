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
			
			<link rel="stylesheet" href="${contextPath }/resources/persAssets/css/main.css" />
			<noscript><link rel="stylesheet" href="${contextPath }/resources/persAssets/css/noscript.css" /></noscript>
			
		<body class="is-preload">
		<div id="wrapper">
			<div id="bg"></div>
				<div id="overlay"></div>
					<div id="main">

				<!-- Header -->
					<header id="header">
						<h1>Personal Page</h1>
						<nav>
							<ul>
								<li>메모<a href="${contextPath }/memo/main?ui_id=${ui_id}" class="icon fa-sticky-note"></a></li>
								<li>캘린더<a href="${contextPath }/cal/main" class="icon fa-calendar-check"></a></li>
								<li>내 게시글<a href="${contextPath }/myboard" class="icon solid fa-user-tag"></a></li>
								<li>날씨<a href="${contextPath }/weather" class="icon solid fa-cloud-sun"></a></li>
							</ul>
						</nav>
					</header>
				</div>
			</div>
		<script>
			window.onload = function() { document.body.classList.remove('is-preload'); }
			window.ontouchmove = function() { return false; }
			window.onorientationchange = function() { document.body.scrollTop = 0; }
		</script>
		</body>
			</main>
			<%@ include file="include/footer.jsp"%>
		</div>
	</div>
	<%@ include file="include/plugin.jsp"%>
</body>
</html>
