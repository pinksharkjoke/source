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
				Memo Page<br>
				<style type="text/css">
					li {list-style: none; float: left; padding: 6px;}
				</style>
				<p></p>
			<div class="box-header with-border">
				<input type="button" onclick="location.href='${contextPath}/memo/insert?ui_id=${user.ui_id}'" value="메모 추가"><br>
			</div>
			<table class="table">
			  <tr>
			  	<td>번호</td>
			  	<td>제목</td>
			  	<td>작성일</td>
			  	<td>작성자</td>
			  </tr>
			<c:forEach var="memo" items="${memo }">
			 	<tr>
			 	<td>${memo.mm_mno }</td>
			 	<td><a href="${contextPath}/memo/detail?mm_mno=${memo.mm_mno}"> ${memo.mm_title} </a></td>
			 	<td>${memo.mm_date}</td>
			 	<td>${memo.mm_ncname}</td>
			 	</tr>
			</c:forEach>
			  </table>
				
			<!-- 페이지 부분 -->
			<div>
			  <ul>
			    <c:if test="${page.prev}">
			    	<li><a href="main${page.makeQuery(page.startPage - 1)}&ui_id=${user.ui_id}">이전</a></li>
			    </c:if> 
			
			    <c:forEach begin="${page.startPage}" end="${page.endPage}" var="idx">
			    	<li><a href="main${page.makeQuery(idx)}&ui_id=${user.ui_id}">${idx}</a></li>
			    </c:forEach>
			
			    <c:if test="${page.next && page.endPage > 0}">
			    	<li><a href="main${page.makeQuery(page.endPage + 1)}&ui_id=${user.ui_id}">다음</a></li>
			    </c:if> 
			  </ul>
			<div>
			</main>
			
			<%@ include file="../include/footer.jsp"%>
		</div>
	</div>
	<%@ include file="../include/plugin.jsp"%>
</body>
</html>
