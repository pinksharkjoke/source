<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">


<%@ include file="../include/head.jsp"%>
<link rel="stylesheet" href="${contextPath}/resources/test/css/main.css" />

<body class="sb-nav-fixed">
	<script>
		$(document).ready(function() {
			$("#keywordInput").keyup(function(event) {
				if (event.keyCode === 13) {
					$("#searchBtn").click();
				}
			});
		});
	</script>
	<%@ include file="../include/nav_bar.jsp"%>

	<div id="layoutSidenav">

		<%@ include file="../include/layoutSidenav.jsp"%>


		<div id="layoutSidenav_content">

			<!-- contents -->
			<!-- 각자 맡은 페이지 만들시 해당 페이지의 css, 이미지 등 스타일 요소들은 헤더를 <main> 영역 안에 <link> 를 이용해 넣으면 됨.-->

			<!-- 게시판 종류 적기 -->



			<main id="main">
				<!-- ======= Breadcrumbs ======= -->
				<div class="breadcrumbs d-flex align-items-center"
					style="background-image: url('${contextPath}/resources/test/img/pets3.jpg'); background-size:auto;">
					<div
						class="container position-relative d-flex flex-column align-items-center">
						<c:set var="num" value="${type }" />
						<%
						String category = "";
						int num = (int) pageContext.getAttribute("num");

						if (num == 1) {
							category = "자유";
						} else if (num == 2) {
							category = "Q&A";
						} else if (num == 3) {
							category = "꿀팁";
						} else if (num == 201) {
							category = "서울";
						} else if (num == 202) {
							category = "경기북부";
						} else if (num == 203) {
							category = "경기남부";
						} else if (num == 204) {
							category = "강원";
						} else if (num == 205) {
							category = "충청";
						} else if (num == 206) {
							category = "전라";
						} else if (num == 207) {
							category = "경상";
						} else if (num == 208) {
							category = "제주도";
						} else if (num == 901) {
							category = "건의 및 신고";
						} else if (num == 902) {
							category = "등업 신청";
						}
						%>
						<h2><%=category%>
							게시판
						</h2>
						<ol>
							<li><a href="${contextPath}/board/insert?ca=${type}">게시판
									글쓰기</a></li>
							<li>Boards</li>

						</ol>

					</div>
				</div>
				<!-- End Breadcrumbs -->
				<div style="background-color: #C3E7FA;">
					<br>
					<div
						style="font-size: 1.5em; color: #0A82FF; font-weight: bold; margin-left: 210px">
						<i class="bi bi-megaphone-fill" style="margin-left: 600px"></i>&nbsp;&nbsp;공지<br>
					</div>
					<div style="color: #00AFFF;">
						<table style="margin-left: 718px;">
							<c:forEach var="board" items="${listnotice }" varStatus="status">
								<tr>
									<td><a href="detail?num=${board.bo_num }"
										style="color: #00BFFF; font-weight: bold;">
											${board.bo_title} &nbsp; </a></td>
									<td>${board.bo_modifydate}&nbsp;</td>
									<td>${board.bo_name}</td>
								</tr>
							</c:forEach>
						</table>
						<br>
					</div>
				</div>
					<div style="margin-top: 40px">
							<button type="button"
								onclick="location.href='/pap/board/list?ca=${scri.ca_num}&searchType=${scri.searchType}&keyword=${scri.keyword}&sort=viewCount'"
								class="btn btn-outline-dark float-right ">조회순</button>
							<button type="button"
								onclick="location.href='/pap/board/list?ca=${scri.ca_num}&searchType=${scri.searchType}&keyword=${scri.keyword}&sort=likeCount'"
								class="btn btn-outline-dark float-right" data-bs-toggle="button">좋아요순</button>
							<button type="button"
								onclick="location.href='/pap/board/list?ca=${scri.ca_num}&searchType=${scri.searchType}&keyword=${scri.keyword}&sort=bno'"
								class="btn btn-outline-dark float-right ">최신순</button>

						</div>

			
		
						
						
						
							<table class="table">

								<tr>
									<td>글번호</td>
									<td>제목</td>
									<td>작성일</td>
									<td>작성자</td>
									<td>회원등급</td>
									<td>조회수</td>
									<td>댓글수</td>
									<td>좋아요</td>
								</tr>



								<!-- 게시물 번호 부여 -->
								<c:set var="num"
									value="${pageMaker.totalCount - ((pageMaker.cri.page-1)*10)}" />
								<c:forEach var="board" items="${list }" varStatus="status">

									<tr>

										<td>${num}</td>
										<td><a
											href="detail?num=${board.bo_num }
				 	&page=${scri.page}&perPageNum=${scri.perPageNum}&searchType=${scri.searchType}&keyword=${scri.keyword}&sort=${scri.sort }
				 	">
												${board.bo_title} </a></td>
										<td>${board.bo_modifydate}</td>
										<td>${ncName[status.index]}</td>
										<td>${grade[status.index]}</td>
										<td>${board.bo_views}</td>
										<td>${replyCount[status.index] }</td>
										<td>${board.bo_heart}</td>
									</tr>

									<!-- 게시물 번호 역순처리 -->
									<c:set var="num" value="${num-1 }" />

								</c:forEach>







								<tr>
									<td colspan="5" align="center"><a href="${contextPath }/"><input
											class="btn btn-success" type="button" value="메인으로" id="main" /></a>
									</td>
								</tr>
							</table>
							<div>
								<ul>
									<c:if test="${pageMaker.prev}">
										<li><a
											href="list${pageMaker.makeSearch(pageMaker.startPage - 1)}">이전</a></li>
									</c:if>

									<c:forEach begin="${pageMaker.startPage}"
										end="${pageMaker.endPage}" var="idx">
										<li><a href="list${pageMaker.makeSearch(idx)}">${idx}</a></li>
									</c:forEach>

									<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
										<li><a
											href="list${pageMaker.makeSearch(pageMaker.endPage + 1)}">다음</a></li>
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
															self.location = "list"
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
						</div>
					</section>
					<!-- /.content -->

				</div>
				<!-- /.content-wrapper -->


				<c:if test="${!empty user.ui_id}">
					<%@ include file="/WEB-INF/views/board/minichat.jsp"%>
				</c:if>



			</main>

			<%@ include file="../include/footer.jsp"%>
		</div>
	</div>
	<%@ include file="../include/plugin.jsp"%>

</body>
</html>

