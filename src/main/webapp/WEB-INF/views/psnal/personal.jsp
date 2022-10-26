<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<%@ include file="../include/head.jsp"%>

		
		
<body class="sb-nav-fixed">

	<%@ include file="../include/nav_bar.jsp"%>

	<div id="layoutSidenav">

		<%@ include file="../include/layoutSidenav.jsp"%>

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
								<li><span class="label">메모</span><a href="${contextPath }/memo/main?ui_id=${user.ui_id}" class="icon fa-sticky-note"></a></li>
								<li><span class="label">캘린더</span><a href="${contextPath }/cal/main?ui_id=${user.ui_id}" class="icon fa-calendar-check"></a></li>
								<li><span class="label">내 게시글</span><a href="${contextPath }/myBoardList" class="icon solid fa-user-tag"></a></li>
								<li><span class="label">날씨</span><a href="${contextPath }/weather/home" class="icon solid fa-cloud-sun"></a></li>
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
			<%@ include file="../include/footer.jsp"%>
		</div>
	</div>
	<%@ include file="../include/plugin.jsp"%>
</body>
</html>
