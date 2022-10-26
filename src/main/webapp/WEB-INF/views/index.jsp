<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>

<%@ include file="include/head.jsp"%>
<body class="sb-nav-fixed">

	<%@ include file="include/nav_bar.jsp"%>

	<div id="layoutSidenav">

		<%@ include file="include/layoutSidenav.jsp"%>

		<div id="layoutSidenav_content">
			<main>
				
				<link rel="stylesheet" href="resources/assets/css/main.css" />
				<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.1.2/css/fontawesome.min.css" integrity="sha384-X8QTME3FCg1DLb58++lPvsjbQoCT9bp3MsUU3grbIny/3ZwUJkRNO8NPW6zqzuW9" crossorigin="anonymous">
				
				
				<div class="homepage is-preload">
					<div id="page-wrapper">

						<!-- Main -->
						<section id="main">
							<div class="container">
								<div class="row">
									<div class="col-12">

										<!-- Portfolio -->
										<section>
											<header class="major">
												<h2>인기글</h2>
											</header>
											<div class="row">
												<c:forEach var="board" items="${listHot }" varStatus="status">
												<section class="box" style="height:20px;">
													<li style="margin-right: 20px;"><i class="fa-regular fa-chess-queen" style="color:red;"></i>
													<c:if test="${board.ca_num==1 }">자유</c:if>
													<c:if test="${board.ca_num==2 }">Q&A</c:if>
													<c:if test="${board.ca_num==3 }">꿀팁</c:if>
													<c:if test="${board.ca_num>=100 && board.ca_num<200 }">펫자랑</c:if>
													<c:if test="${board.ca_num>=200 && board.ca_num<300 }">지역별</c:if>
													<c:if test="${board.ca_num>=300 && board.ca_num<=307 }">중고장터</c:if>
													<c:if test="${board.ca_num==308 }">나눔</c:if>
													게시판</li>

													<li style="margin-right: 20px;"><a href="${contextPath}/board/detail?num=${board.bo_num }" style="color:skyblue;">${board.bo_title }</a></li>
													<li style="margin-left: 20px;"><i class="fa-regular fa-user"></i>${ncNameHot[status.index]}</li>																		
													<li style="float: right; margin-right: 20px;"><i class="fa-regular fa-heart"></i>${board.bo_heart }</li>
													<li style="float: right; margin-right: 20px;"><i class="fa-regular fa-comment"></i>${replyCountHot[status.index] }</li>
													<li style="float: right; margin-right: 20px;"><i class="fa-regular fa-eye"></i>${board.bo_views }</li>
													<li style="float: right; margin-right: 20px;"><i class="fa-regular fa-clock"></i>${board.bo_DATE }</li>
												</section>
												</c:forEach>
											</div>
										</section>
										
										<section>
											<header class="major">
													<h2>나눔</h2>
												</header>
												
												<div class="row">
													<c:forEach var="board" items="${listRecent }" varStatus="status">
													<div class="col-4 col-6-medium col-12-small">
													<section class="box">
													<a href="${contextPath}/board/detail?num=${board.bo_num }" class="image featured">
														<img
															src=${board.bo_photo } style="width:336px; height:200px"/></a>
														<header>
															<h3>${board.bo_title }</h3>
														</header>
		
														<li style="margin-right: 10px;"><i class="fa-regular fa-user"></i>${ncName[status.index]}</li>	
														<li style="margin-right: 10px;"><i class="fa-regular fa-eye"></i>${board.bo_views }</li>
														<li style="margin-right: 10px;"><i class="fa-regular fa-comment"></i>${replyCount[status.index] }</li>
														<li style="margin-right: 10px;"><i class="fa-regular fa-heart"></i>${board.bo_heart }</li>
														<br><p><i class="fa-regular fa-clock"></i>${board.bo_DATE }</p>
														<footer>
															<ul class="actions">
																<li style="float:right;"><a href="${contextPath}/board/detail?num=${board.bo_num }"
																	class="button icon solid fa-file-alt" style="width:150px; height:50px; font-size: 10pt;">자세히 보기</a></li>
															</ul>
														</footer>
													</section>
													</div>
													</c:forEach>
												
												</div>
												
										</section>

									</div>
									<div class="col-12">

										<!-- Blog -->
										<section>
											<header class="major">
												<h2>이달의 My Pet</h2>
											</header>
											<div class="row">
											
														<c:forEach var="board" items="${monthpet }"  varStatus="status">	
												<div class="col-6 col-12-small">
													<section class="box">
														<a href="${contextPath}/board/detail?num=${board.bo_num }" class="image featured">
														<img src="${board.bo_photo}"  style="width:627px; height:500px"/></a>
														<header>
															<h3>${board.bo_title}</h3>
														</header>
														<p><i class="fa-regular fa-user"></i>${ncNamePet[status.index] }</p>
														<footer>
															<ul class="actions">
																<li><a href="${contextPath}/board/detail?num=${board.bo_num }"
																	class="button icon solid fa-file-alt" style="width:150px; height:50px; font-size: 10pt; padding: 0; text-align: center;">자세히 보기</a></li>
																<li><a href="${contextPath}/board/detail?num=${board.bo_num }"
																	class="button alt icon solid fa-comment" style="width:150px; height:50px; font-size: 10pt;">${replyCountPet[status.index] }</a></li>
																<li><a href="${contextPath}/board/detail?num=${board.bo_num }"
																	class="button alt icon solid fa-heart" style="width:150px; height:50px; font-size: 10pt;">${board.bo_heart }</a></li>
															</ul>
														</footer>
													</section>
												</div>
													</c:forEach>
												
											</div>
										</section>

									</div>
								</div>
							</div>
						</section>

						<!-- Footer -->
						<section id="footer">
							<div class="container">
								<div class="row">
									<div class="col-8 col-12-medium">
										<section>
											<header>
												<h2>펫 행사 일정</h2>
											</header>
											<ul class="dates">
											<% int i =0; %>
											 	<c:forEach items="${eventList }" var="eventList" varStatus="status">
												<div class = "eventlist" style = "display: none;">
												<span><img class ="image event" src = "${contextPath }/resources/images/event/${eventList.ev_pic }" style="width:100px;height:auto;"></img></span>
													<h3>
														<a>행사기간 : ${eventList.ev_startdate } ~ ${eventList.ev_enddate }</a>
													</h3>
													<p>장소 : ${eventList.ev_loc } 행사이름 : ${eventList.ev_name }</p> <a href="${eventList.ev_url }" style = "float:right;" target='_blank'>자세히보기</a>
													<% i++; %>
												</div>
												</c:forEach>
												<%if(i>5){ %>
										<button class ="load">더보기</button>
											<%} %>
									
											
											
											</ul>
										</section>
									</div>
									
									<div class="col-4 col-12-medium">
										<section>
											<header>
												<h2>실종 동물을 찾습니다.</h2>
											</header>
											<div>
											<c:forEach items="${bannerlist }" var="bannerlist">
											<a href="${bannerlist.bn_url }"  target='_blank' class="image featured"><img class="slide1" src = "${contextPath }/resources/images/banner/${bannerlist.bn_img }"></a>
											</c:forEach>
											</div>
											
										</section>
									</div>
									<div class="col-4 col-6-medium col-12-small">
										<section>
											<header>
												<h2>Tempus consequat</h2>
											</header>
											<ul class="divided">
												<li><a href="#"></a></li>
												<li><a href="#">Sed et blandit consequat sed tlorem
														blandit</a></li>
												<li><a href="#">Adipiscing feugiat phasellus sed
														tempus</a></li>
												<li><a href="#">Hendrerit tortor vitae mattis
														tempor sapien</a></li>
												<li><a href="#">Sem feugiat sapien id suscipit
														magna felis nec</a></li>
												<li><a href="#">Elit class aptent taciti sociosqu
														ad litora</a></li>
											</ul>
										</section>
									</div>
									<div class="col-4 col-6-medium col-12-small">
										<section>
											<header>
												<h2>Ipsum et phasellus</h2>
											</header>
											<ul class="divided">
												<li><a href="#">Lorem ipsum dolor sit amet sit
														veroeros</a></li>
												<li><a href="#">Sed et blandit consequat sed tlorem
														blandit</a></li>
												<li><a href="#">Adipiscing feugiat phasellus sed
														tempus</a></li>
												<li><a href="#">Hendrerit tortor vitae mattis
														tempor sapien</a></li>
												<li><a href="#">Sem feugiat sapien id suscipit
														magna felis nec</a></li>
												<li><a href="#">Elit class aptent taciti sociosqu
														ad litora</a></li>
											</ul>
										</section>
									</div>
									<div class="col-4 col-12-medium">
										<section>
											<header>
												<h2>개발자들</h2>
											</header>
											<ul class="social">
												<li><a class="icon brands fa-facebook-f" href="#"><span
														class="label">Facebook</span></a></li>
												<li><a class="icon brands fa-twitter" href="#"><span
														class="label">Twitter</span></a></li>
												<li><a class="icon brands fa-dribbble" href="#"><span
														class="label">Dribbble</span></a></li>
												<li><a class="icon brands fa-tumblr" href="#"><span
														class="label">Tumblr</span></a></li>
												<li><a class="icon brands fa-linkedin-in" href="#"><span
														class="label">LinkedIn</span></a></li>
											</ul>
											<ul class="contact">
												<li>
													<h3>Address</h3>
													<p>
														우리집 왜.<br /> 우리집 알아서 뭐하게<br />
														싫어, TN 00000-0000
													</p>
												</li>
												<li>
													<h3>Mail</h3>
													<p>
														<a href="#">욕할려고?</a>
													</p>
												</li>
												<li>
													<h3>Phone</h3>
													<p>(800) 000-0000</p>
												</li>
												<li>
													<h3>icon 링크</h3>
													<p><a href="https://www.flaticon.com/kr/free-icons/" title="날씨 아이콘">날씨 아이콘  제작자 <br>
													Freepik - Flaticon</a></p>
													<p><a href="https://www.flaticon.com/kr/free-icons/" title="논평 아이콘">논평 아이콘  제작자 <br>
													 Alfredo Hernandez - Flaticon</a></p>
												</li>
											</ul>
										</section>
									</div>
									<div class="col-12">

										<!-- Copyright -->
										<div id="copyright">
											<ul class="links">
												<li>&copy; Untitled. All rights reserved.</li>
												<li>Design: <a href="http://html5up.net">HTML5 UP</a></li>
											</ul>
										</div>

									</div>
								</div>
							</div>
						</section>

					</div>

					<!-- Scripts -->
					<script src="resources/assets/js/jquery.min.js"></script>
					<script src="resources/assets/js/jquery.dropotron.min.js"></script>
					<script src="resources/assets/js/browser.min.js"></script>
					<script src="resources/assets/js/breakpoints.min.js"></script>
					<script src="resources/assets/js/util.js"></script>
					<script src="resources/assets/js/main.js"></script>
					<script>
				    var index = 0;   //이미지에 접근하는 인덱스
				    window.onload = function(){
				        slideShow();
				    }
				    
				    function slideShow() {
				    var i;
				    var x = document.getElementsByClassName("slide1");  //slide1에 대한 dom 참조
				    for (i = 0; i < x.length; i++) {
				       x[i].style.display = "none";   //처음에 전부 display를 none으로 한다.
				    }
				    index++;
				    if (index > x.length) {
				        index = 1;  //인덱스가 초과되면 1로 변경
				    }   
				    x[index-1].style.display = "block";  //해당 인덱스는 block으로
				    setTimeout(slideShow, 4000);   //함수를 4초마다 호출
				 
				}
				
					</script>
					<script>//행사일정 더보기
					$(function(){
						$('.eventlist').slice(0,5).show();
						$(document).on('click','.load',function(){
							$('.eventlist:hidden').slice(0, 5).show();
							if($('.eventlist:hidden').length == 0){
								 $('.load').replaceWith('<button class ="wjqdj">접기</button>');
							}
						});
						 $(document).on('click','.wjqdj',function(){
							 $('.eventlist').slice(5,$('.eventlist').length).hide();
							 $('.wjqdj').replaceWith('<button class ="load">더보기</button>');
						 });
					});
			
					
					</script>
				</div> 
				<!-- index.jsp End-->
				
					<c:if test ="${!empty user.ui_id}">	
					<%@ include file="/WEB-INF/views/board/minichat.jsp" %>	
					</c:if>	
					
				
	
			</main>
			<%@ include file="include/footer.jsp"%>
		</div>
	</div>
	<%@ include file="include/plugin.jsp"%>
</body>
</html>
