
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>

<%@ include file="../include/head.jsp"%>
<script>
	$(document)
			.ready(
					function() {
						$('#searchBtn').click(
								function() {
									self.location = "listpicmarket"
											+ '${pageMaker.makeQuery(1)}'
											+ "&searchType="
											+ $("select option:selected").val()
											+ "&keyword="
											+ encodeURIComponent($(
													'#keywordInput').val());
								});

					})
</script>


<body class="sb-nav-fixed">

	<%@ include file="../include/nav_bar.jsp"%>

	<div id="layoutSidenav">

		<%@ include file="../include/layoutSidenav.jsp"%>

		<div id="layoutSidenav_content">
			<main>
				<!-- contents -->
				<!-- 각자 맡은 페이지 만들시 해당 페이지의 css, 이미지 등 스타일 요소들은 헤더를 <main> 영역 안에 <link> 를 이용해 넣으면 됨.-->
				<!-- index.jsp 참고 -->
				<link rel="stylesheet"
					href="${contextPath}/resources/test/css/main.css" />



				<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>Nova Bootstrap Template - Blog</title>
<meta content="" name="description">
<meta content="" name="keywords">

<!-- Favicons -->
<link href="${contextPath}/resources/test/img/favicon.png" rel="icon">
<link href="${contextPath}/resources/test/img/apple-touch-icon.png"
	rel="apple-touch-icon">

<!-- Google Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,600;1,700&family=Montserrat:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&family=Raleway:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
	rel="stylesheet">

<!-- Vendor CSS Files -->
<link
	href="${contextPath}/resources/test/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="${contextPath}/resources/test/vendor/bootstrap-icons/bootstrap-icons.css"
	rel="stylesheet">
<link href="${contextPath}/resources/test/vendor/aos/aos.css"
	rel="stylesheet">
<link
	href="${contextPath}/resources/test/vendor/glightbox/css/glightbox.min.css"
	rel="stylesheet">
<link
	href="${contextPath}/resources/test/vendor/swiper/swiper-bundle.min.css"
	rel="stylesheet">
<link
	href="${contextPath}/resources/test/vendor/remixicon/remixicon.css"
	rel="stylesheet">

<!-- Template Main CSS File -->
<link href="${contextPath}/resources/test/css/main.css" rel="stylesheet">

<!-- =======================================================
  * Template Name: Nova - v1.1.0
  * Template URL: https://bootstrapmade.com/nova-bootstrap-business-template/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
				</head>

				<div class="page-blog">

					<!-- ======= Header ======= -->

					<!-- End Header -->

					<main id="main">

						<!-- ======= Breadcrumbs ======= -->
						<div class="breadcrumbs d-flex align-items-center"
							style="background-image: url('${contextPath}/resources/test/img/pets3.jpg'); background-size:auto;">
							<div
								class="container position-relative d-flex flex-column align-items-center">

								<h2>Market</h2>
								<ol>
									<li><a href="${contextPath}/board/insert?ca=${type}">게시판
											글쓰기</a></li>
									<li>Market</li>
								</ol>

							</div>
						</div>
						<!-- End Breadcrumbs -->

						<!-- ======= Blog Section ======= -->

						<div style="margin-top: 40px">
							<a href="${contextPath}/board/listpicmarket?ca=${type}"><button
									class="btn btn-success" value="전체보기" id="default"
									style="margin: 3px">전체보기</button> </a>
							<button id="ing" name="ing" class="btn btn-success">판매중</button>
							<button type="button"
								onclick="location.href='/pap/board/list?ca=${scri.ca_num}&searchType=${scri.searchType}&keyword=${scri.keyword}&sort=viewCount'"
								class="btn btn-outline-dark float-right " style="margin-left: 5px"]>조회순</button>
							<button type="button"
								onclick="location.href='/pap/board/list?ca=${scri.ca_num}&searchType=${scri.searchType}&keyword=${scri.keyword}&sort=likeCount'"
								class="btn btn-outline-dark float-right" data-bs-toggle="button">좋아요순</button>
							<button type="button"
								onclick="location.href='/pap/board/list?ca=${scri.ca_num}&searchType=${scri.searchType}&keyword=${scri.keyword}&sort=bno'"
								class="btn btn-outline-dark float-right ">최신순</button>

						</div>


						<section id="blog" class="blog">
							<div class="container" data-aos="fade-up">

								<div class="row g-5">

									<div class="col-lg-8" data-aos="fade-up" data-aos-delay="200">

										<div class="row gy-5 posts-list">


											<!-- 게시물 번호 부여 -->
											<c:set var="num"
												value="${pageMaker.totalCount - ((pageMaker.cri.page-1)*10)}" />
											<c:forEach var="board" items="${list }" varStatus="status">
												<div class="col-lg-6">
													<article class="d-flex flex-column">


														<h2 class="title">
															<a href="detail?num=${board.bo_num }">${board.bo_title }
															</a>
														</h2>
														<div class="post-img">
															<div class="post-img">
																<a href="detail?num=${board.bo_num }"> <img
																	src="${board.bo_photo}" alt="" class="img-fluid"
																	style="width: 500px">

																</a>
															</div>
														</div>

														<div class="meta-top">
															<ul>
																<li class="d-flex align-items-center"><i
																	class="bi bi-hash"></i> <a
																	href="detail?num=${board.bo_num }"> ${num}</a></li>
																<li class="d-flex align-items-center"><i
																	class="bi bi-person"></i> <a
																	href="detail?num=${board.bo_num }">
																		${ncName[status.index]}</a></li>
																<li class="d-flex align-items-center"><i
																	class="bi bi-clock"></i> <a
																	href="detail?num=${board.bo_num }"><time
																			datetime="2022-01-01">${board.bo_modifydate }</time></a></li>
																<li class="d-flex align-items-center"><i
																	class="bi bi-eye"></i>${board.bo_views } <a
																	href="detail?num=${board.bo_num }"> </a></li>
																<li class="d-flex align-items-center"><i
																	class="bi bi-chat-dots"></i>${replyCount[status.index]}
																	<a href="detail?num=${board.bo_num }"> </a></li>
																<li class="d-flex align-items-center"><i
																	class="bi bi-heart"></i>${board.bo_heart } <a
																	href="detail?num=${board.bo_num }"> </a></li>
																<li class="d-flex align-items-center"><i
																	class="bi bi-caret-right"></i>${board.bo_pstatus } <a
																	href="detail?num=${board.bo_num }"> </a></li>
															</ul>
														</div>





														<div class="read-more mt-auto align-self-end">
															<a href="detail?num=${board.bo_num }">Read More <i
																class="bi bi-arrow-right"></i></a>
														</div>

													</article>
												</div>
												<!-- 게시물 번호 역순처리 -->
												<c:set var="num" value="${num-1 }" />

											</c:forEach>
											<!-- End post list item -->
										</div>
										<!-- End blog posts list -->
										<div>
											<ul>
												<c:if test="${pageMaker.prev}">
													<li><a
														href="listing${pageMaker.makeSearch(pageMaker.startPage - 1)}">이전</a></li>
												</c:if>

												<c:forEach begin="${pageMaker.startPage}"
													end="${pageMaker.endPage}" var="idx">
													<li><a href="listing${pageMaker.makeSearch(idx)}">${idx}</a></li>
												</c:forEach>

												<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
													<li><a
														href="listing${pageMaker.makeSearch(pageMaker.endPage + 1)}">다음</a></li>
												</c:if>

											</ul>
										</div>
										<div class="search">
											<select name="searchType">
											
												<option value="t"
													<c:out value="${scri.searchType eq 't' ? 'selected' : ''}"/>>제목</option>
												<option value="c"
													<c:out value="${scri.searchType eq 'c' ? 'selected' : ''}"/>>내용</option>
												<option value="w"
													<c:out value="${scri.searchType eq 'w' ? 'selected' : ''}"/>>작성자</option>
												<option value="tc"
													<c:out value="${scri.searchType eq 'tc' ? 'selected' : ''}"/>>제목+내용</option>
											</select> <input type="text" name="keyword" id="keywordInput"
												value="${scri.keyword}" />

											<button id="searchBtn" type="button">검색</button>
											<script>
												$(function() {
													$('#searchBtn')
															.click(
																	function() {
																		self.location = "listing"
																				+ '${pageMaker.makeQuery(1)}'
																				+ "&searchType="
																				+ $(
																						"select option:selected")
																						.val()
																				+ "&keyword="
																				+ encodeURIComponent($(
																						'#keywordInput')
																						.val());
																	});
												});
											</script>
										</div>
										<!-- End blog pagination -->

									</div>

									<div class="col-lg-4" data-aos="fade-up" data-aos-delay="400">

										<div class="sidebar ps-lg-4">

											<div class="sidebar-item search-form">
												<h3 class="sidebar-title">Search</h3>
												<form action="" class="mt-3">
													<input type="text">
													<button type="submit">
														<i class="bi bi-search"></i>
													</button>
												</form>
											</div>
											<!-- End sidebar search formn-->

											<div class="sidebar-item categories">
												<h3 class="sidebar-title">Categories</h3>
												<ul class="mt-3">
													<li><a
														href="${contextPath}/board/listpicmarket?ca=301">사료/간식
															<span>(25)</span>
													</a></li>
													<li><a
														href="${contextPath}/board/listpicmarket?ca=302">위생/미용용품
															<span>(12)</span>
													</a></li>
													<li><a
														href="${contextPath}/board/listpicmarket?ca=303">하우스/실내용품<span>(5)</span></a></li>
													<li><a
														href="${contextPath}/board/listpicmarket?ca=304">리드줄/야외용품
															<span>(22)</span>
													</a></li>
													<li><a
														href="${contextPath}/board/listpicmarket?ca=305">장난감/훈련용품<span>(8)</span></a></li>
													<li><a
														href="${contextPath}/board/listpicmarket?ca=306">의류/악세서리<span>(14)</span></a></li>
													<li><a
														href="${contextPath}/board/listpicmarket?ca=307">급수/급식기<span>(14)</span></a></li>

												</ul>
											</div>
											<!-- End sidebar categories-->
											<br>
											<Br>
											<br>
											<br>
											<Br>
											<br>
											<br>
											<Br>
											<br>
											<br>
											<Br>
											<div class="sidebar-item recent-posts">
												<h3 class="sidebar-title">Recent Posts</h3>

												<c:forEach var="board" items="${listRecent }">
													<c:set var="val0" value="${board.bo_status }"></c:set>
													<div class="mt-3">

														<div class="post-item mt-3">

															<a href="detail?num=${board.bo_num }"><img
																src=${board.bo_photo } alt="" class="flex-shrink-0"
																style="float: right;" /></a>
															<div>
																<h4>
																	<a href="detail?num=${board.bo_num }">${board.bo_title }</a>
																</h4>
																<time datetime="2020-01-01">${board.bo_DATE }</time>
															</div>
														</div>
														<!-- End recent post item-->


														<!-- End recent post item-->

													</div>
												</c:forEach>
											</div>


											<!-- End sidebar recent posts-->




										</div>
										<!-- End Blog Sidebar -->

									</div>

								</div>

							</div>
						</section>
						<!-- End Blog Section -->

						<c:if test="${!empty user.ui_id}">
							<%@ include file="/WEB-INF/views/board/minichat.jsp"%>
						</c:if>


					</main>
					<!-- End #main -->


					<!-- End Footer -->

					<a href="#"
						class="scroll-top d-flex align-items-center justify-content-center"><i
						class="bi bi-arrow-up-short"></i></a>

					<div id="preloader"></div>

					<!-- Vendor JS Files -->
					<script
						src="${contextPath}/resources/test/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
					<script src="${contextPath}/resources/test/vendor/aos/aos.js"></script>
					<script
						src="${contextPath}/resources/test/vendor/glightbox/js/glightbox.min.js"></script>
					<script
						src="${contextPath}/resources/test/vendor/swiper/swiper-bundle.min.js"></script>
					<script
						src="${contextPath}/resources/test/vendor/isotope-layout/isotope.pkgd.min.js"></script>
					<script
						src="${contextPath}/resources/test/vendor/php-email-form/validate.js"></script>

					<!-- Template Main JS File -->
					<script src="${contextPath}/resources/test/js/main.js"></script>

				</div>

			</main>
			<%@ include file="../include/footer.jsp"%>
		</div>
	</div>
	<%@ include file="../include/plugin.jsp"%>
</body>
</html>
