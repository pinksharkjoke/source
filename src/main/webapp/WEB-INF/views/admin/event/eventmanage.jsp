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
				<link rel="stylesheet" href="${contextPath }/resources/assets/css/eventboard.css" />
<section class="notice">
  <div class="page-title">
        <div class="container">
            <h3>행사 일정 목록</h3>
        </div>
    </div>

   
  <!-- board list area -->
    <div id="board-list">
        <div class="container">
            <table class="board-table">
                <thead>
                <tr>
                    <th scope="col" class="th-num">번호</th>
                    <th scope="col" class="th-title">행사이름</th>
                    <th scope="col" class="th-date">행사기간</th>
                    <th scope="col" class="th-date">행사위치</th>
                </tr>
                </thead>
                <tbody>
              <c:forEach var="event" items="${eventvo }" >
                <tr>
                    <td>${event.ev_id }</td>
                    <th style="text-align: center"><a href="${contextPath}/admin/event/eventdetail?ev_id=${event.ev_id }">${event.ev_name }</a></th>
                    <td>${event.ev_startdate } ~ ${event.ev_enddate }</td>
                    <td>${event.ev_loc }</td>
                </tr>
                	</c:forEach>
                </tbody>
            </table>
            <button class="btn btn-dark" onclick="location.href='${contextPath}/admin/event/eventadd'">등록</button>
        </div>
    </div>

</section>
				
			</main>
			<%@ include file="../../include/footer.jsp"%>
		</div>
	</div>
	<%@ include file="../../include/plugin.jsp"%>
</body>
</html>
