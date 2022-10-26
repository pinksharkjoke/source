<%@ page isELIgnored="false"%>
<%@ page session="true" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<%@ include file="../include/head.jsp"%>
<style>
	.main_bg{
		width: 100%;
  		height: 100%;
		position: relative;
	}
	.main_bg::before{
		content: "";
		width: 100%;
		height: 100%;
		background-image: url('${contextPath}/resources/images/dogdog.jpg'); 
		opacity: 0.4;
		position: absolute;
		top: 0;
		left: 0;
		right: 0;
		bottom: 0;
	}

	.content{
		position: relative;
	}
</style>
<script>
	$('document').ready(function(){

		var category0 = ["-게시판-","자유 게시판", "QnA 게시판", "꿀Tip 게시판", "펫자랑 게시판", "지역별 게시판", "중고장터 게시판", "나눔 게시판", "고객센터"];
		var category1 = ["세부 게시판 선택", "자유 게시판"];
		var category2 = ["세부 게시판 선택", "QnA 게시판"];
		var category3 = ["세부 게시판 선택", "꿀Tip 게시판"];
		var category4 = ["세부 게시판 선택", "강아지 게시판", "고양이 게시판", "기타(Etc) 게시판"];
		var category5 = ["세부 게시판 선택", "서울 게시판", "경기북부 게시판", "경기남부 게시판", "강원 게시판", "충청 게시판", "전라 게시판", "경상 게시판", "제주 게시판"];
		var category6 = ["세부 게시판 선택", "사료/간식", "위생/미용용품", "하우스/실내용품", "리드줄/야외용품", "장난감/훈련용품", "의류/액세서리", "급수/급식기"];
		var category7 = ["세부 게시판 선택", "나눔 게시판"];
		var category8 = ["세부 게시판 선택", "건의 및 신고", "등업신청 게시판"];

		$("#sel_B_ca").each(function(){
			$sel_B_ca = $(this);
			$.each(eval(category0), function(){
				$sel_B_ca.append("<option value='"+this+"'>"+this+"</option>");
			});
			$sel_B_ca.next().append("<option value=''>세부 게시판 선택</option>");
		});

		$("#sel_B_ca").change(function(){
			var category = "category" + $("option", $(this)).index($("option:selected", $(this)));
			var $sel_ca = $(this).next();
			$("option", $sel_ca).remove();

			if(category == "category0"){
				$sel_ca.append("<option value=''>세부 게시판 선택</option>");
			}else{
				$.each(eval(category), function(){
					$sel_ca.append("<option value='"+this+"'>" + this + "</option>");
				});
			}
		});

	}); // end of document ready

	function selChange(){
						var sel_cnt = $("#sel_cnt").val();
						var sel_ca = $("#sel_ca").val();

						if(sel_ca == "자유 게시판"){
							sel_ca = 1;
						}else if(sel_ca == "QnA 게시판"){
							sel_ca = 2;
						}else if(sel_ca == "꿀Tip 게시판"){
							sel_ca = 3;
						}else if(sel_ca == "강아지 게시판"){
							sel_ca = 101;
						}else if(sel_ca == "고양이 게시판"){
							sel_ca = 102;
						}else if(sel_ca == "기타(Etc) 게시판"){
							sel_ca = 103;
						}else if(sel_ca == "서울 게시판"){
							sel_ca = 201;
						}else if(sel_ca == "경기북부 게시판"){
							sel_ca = 202;
						}else if(sel_ca == "경기남부 게시판"){
							sel_ca = 203;
						}else if(sel_ca == "강원 게시판"){
							sel_ca = 204;
						}else if(sel_ca == "충청 게시판"){
							sel_ca = 205;
						}else if(sel_ca == "전라 게시판"){
							sel_ca = 206;
						}else if(sel_ca == "경상 게시판"){
							sel_ca = 207;
						}else if(sel_ca == "제주 게시판"){
							sel_ca = 208;
						}else if(sel_ca == "사료/간식"){
							sel_ca = 301;
						}else if(sel_ca == "위생/미용용품"){
							sel_ca = 302;
						}else if(sel_ca == "하우스/실내용품"){
							sel_ca = 303;
						}else if(sel_ca == "리드줄/야외용품"){
							sel_ca = 304;
						}else if(sel_ca == "장난감/훈련용품"){
							sel_ca = 305;
						}else if(sel_ca == "의류/액세서리"){
							sel_ca = 306;
						}else if(sel_ca == "급수/급식기"){
							sel_ca = 307;
						}else if(sel_ca == "나눔 게시판"){
							sel_ca = 308;
						}else if(sel_ca == "건의 및 신고"){
							sel_ca = 901;
						}else if(sel_ca == "등업신청 게시판"){
							sel_ca = 902;
						}

						if(sel_ca == null){
							sel_ca = 1;
						}
						location.href='${contextPath}/myBoardList?nowPage=' + ${paging.nowPage} + '&cntPerPage=' + sel_cnt + '&ca=' + sel_ca;
					}
</script>
<body class="sb-nav-fixed">

	<%@ include file="../include/nav_bar.jsp"%>

	<div id="layoutSidenav">

		<%@ include file="../include/layoutSidenav.jsp"%>

		<div id="layoutSidenav_content">
			<main class="main_bg">
				<div class="content">
					<div class="container-fluid">
						<div class="row">
							<div style="text-align: center;">
								<p></p>
								<h2><strong>${user.ui_ncname}</strong>님의 게시글(My Board)</h2>
								<hr>
							</div>
							<div class="col-md-4" style="padding-top: 50;">
								<select id="sel_cnt" name="sel_cnt" onchange="selChange()">
									<option value="5"
									<c:if test="${paging.cntPerPage == 5 }">selected</c:if> >5개씩 표시</option>
									<option value="10"
									<c:if test="${paging.cntPerPage == 10 }">selected</c:if> >10개씩 표시</option>
									<option value="15"
									<c:if test="${paging.cntPerPage == 15 }">selected</c:if> >15개씩 표시</option>
									<option value="20"
									<c:if test="${paging.cntPerPage == 20 }">selected</c:if> >20개씩 표시</option>
								</select>
								<select id="sel_B_ca" name="sel_B_ca"></select>
								<select id="sel_ca" name="sel_ca" onchange="selChange()"></select>
							</div>
						</div>
						<div style="height: 100%;">
							<table class="table table-striped">
								<thead>
									<tr>
										<td>글번호</td>
										<td>제목</td>
										<td>작성일</td>
										<td>작성자</td>
										<td>회원등급</td>
										<td>조회수</td>
										<td>좋아요</td>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="item" items="${list}">
										<tr>
											<td>${item.bo_num}</td>
											<td><a href="board/detail?num=${item.bo_num}&page=${paging.nowPage}&perPageNum=${paging.cntPerPage}
												&searchType=${scri.searchType}&keyword=${scri.keyword}&sort=${scri.sort }">${item.bo_title}</a></td>
											<td>${item.bo_modifydate}</td>
											<td> ${user.ui_ncname} </td>
											<td> ${user.ui_grade} </td>
											<td>${item.bo_views}</td>
											<td>${item.bo_heart}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<div style="display: block; text-align: center;">
								<c:if test="${paging.startPage != 1 }">
									<a href="myBoardList?nowPage=${paging.startPage -1 }&cntPerPage=${paging.cntPerPage}&ca=${paging.ca}">&lt;</a>
								</c:if>
								<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
									<c:choose>
										<c:when test="${p == paging.nowPage }">
											<b>${p }</b>
										</c:when>
										<c:when test="${p != paging.nowPage }">
											<a href="myBoardList?nowPage=${p }&cntPerPage=${paging.cntPerPage}&ca=${paging.ca}">${p }</a>
										</c:when>
									</c:choose>
								</c:forEach>
								<c:if test="${paging.endPage != paging.lastPage }">
									<a href="myBoardList?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}&ca=${paging.ca}">&gt;</a>
								</c:if>
							</div>
						</div>
					</div>
				</div>
			</main>
			<%@ include file="../include/footer.jsp"%>
		</div>
	</div>
	<%@ include file="../include/plugin.jsp"%>
</body>
</html>