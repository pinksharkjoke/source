<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<%@ page session="true" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=045cf8e3fa0eeb2315c22add32c6aae9&libraries=services,clusterer,drawing"></script>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script>
	var ncName = "";
	var grade = "";
	//ajax를 통한 댓글 기능 작성하기
	$(document).ready(function(){
		console.log('ajax text ready');
		//댓글 목록 함수 불러오기
		replylist();
			
		
		$(document).on('click','#btnReplySave',function(){
			var co_content = $("#co_content").val();
			var ui_id = '${user.ui_id}'; 
			var url = '${contextPath}/board/insert3';
			var paramData = { 
				"ui_id": ui_id,
				"co_content" : co_content,
				"bo_num" : "${board.bo_num}"
			}//추가데이터 작성

				
			$.ajax({
				url: url,
				data: paramData,
				dataType: 'json',
				type: 'POST',
				success: function(result){
					replylist();
					$("#co_content").val('');
					$("#ui_id").val(${user.ui_ncname}); 
				},
				error: function(result){
					alert('에러가 발생했습니다.');				
				}
			});	//ajax end
		}); //end of $(document).on
	})
	
	//댓글 목록 불러오기 : ajax -> board/replylist, bo_num
	//자바스크립트 변수선언 : var, let, const
	function replylist(){
		
		var url = '${contextPath}/board/list3';
		var paramData = {
			"bo_num" : "${board.bo_num}" 
		} 
		
		
		$.ajax({
			url: url,		//전송주소 -> controller 매핑주소
			data: paramData,		//요청데이터
			dataType: 'json',	//데이터타입
			type: 'POST',		//전송방식(POST, GET)
			success: function(result){
				var htmls = '';	//문서꾸미기
				if(result.comments < 1){
					htmls += '<h3>댓글이 없습니다.</h3>';
				}else{
					$(result.comments).each(function(){
						ncName = getName(this.ui_id);
						console.log("닉네임조회함수 :"+ncName);
						grade = getGrade(this.ui_id);
						console.log("등급 조회함수 :"+grade);
						
					   htmls = htmls + '<div class="" id="co_num' +this.co_num + '">';
                       //<div id="co_num12"> <div id="co_num13">
				       htmls += '<span class="d-block">';
				       htmls += this.co_num + ' - ';
				       htmls += '<strong class="text-gray-dark">' + ncName + '</strong>';
				       htmls += '- ⚝' + grade;
				       htmls += ' - ' + this.co_modifydate;
				       htmls += '<span style="padding-left: 7px; font-size: 9pt">'; 
				       if("${user.ui_id}" == this.ui_id){
				       	htmls += '<a href="javascript:void(0)" onclick="fn_editReply(' + this.co_num + ', \'' + this.ui_id + '\', \'' + this.co_content + '\' )" style="padding-right:5px">수정</a>';
						htmls += '<a href="javascript:void(0)" onclick="fn_deleteReply(' + this.co_num + ' )" style="padding-right:5px">삭제</a>';
					       }
				       if("${user.ui_id}" !== null){
					       htmls += '<c:if test="${!empty user.ui_id}"><a href="javascript:void(0)" onclick="fn_reportReply(' + this.co_num + ')" >신고</a></c:if>';

				       }  
				    
				       htmls += '<c:if test="${!empty user.ui_id}"><a id="heart' +this.co_num+ '" onclick="fn_likeReply(' + this.co_num + ')"" style="padding-right:8px" >♡좋아요</a></c:if>';
						likeReply(this.co_num)
				       
				       htmls += '</span>'; 	
				       htmls += '</span><br>'; 
				       htmls += this.co_content; 
				       htmls += '</p>';  
				       htmls += '</div>';    
						
					}); //end of result.comments.each
				} 
				$("#replylist").html(htmls);
			}, 
			error: function(result){
				alert('실패');
			}
		});
	 }
	
	// 댓글 테이블 id로 유저 테이블 닉네임 가져오는 함수
	function getName(ui_id){
		var url = '${contextPath}/board/getName3';
		var paramData = {
			"re_id" : ui_id
		};
		
		//	alert(ui_id);
		
		$.ajax({
			url:url,
			async:false,
			data:paramData,
			dataType:'json',
			contentType: 'application/json; charset=utf-8',
			type:'GET',
			success:function(result){
				if(result){
					//alert("닉네임 조회 완료");
					console.log(result.name);
					ncName=result.name;					
				}else{
					alert("전송받은 값 없음");
				}
			
			},
			error:function(result, request, error){
				alert('닉네임 조회 에러'+request.status +"에러 message"+request.responseText+"error"+error);
			}
		});
		return ncName;
	} // end of getName
	
	// 댓글 테이블 id로 유저 테이블 등급 가져오는 함수
	function getGrade(ui_id){
		var url = '${contextPath}/board/getGrade3';
		var paramData = {
			"re_id" : ui_id
		};
		
		//	alert(ui_id);
		
		$.ajax({
			url:url,
			async:false,
			data:paramData,
			dataType:'json',
			contentType: 'application/json; charset=utf-8',
			type:'GET',
			success:function(result){
				if(result){
					//alert("닉네임 조회 완료");
					console.log(result.grade);
					grade=result.grade;					
				}else{
					alert("전송받은 값 없음");
				}
			
			},
			error:function(result, request, error){
				alert('닉네임 조회 에러'+request.status +"에러 message"+request.responseText+"error"+error);
			}
		});
		return grade;
	} // end of getGrade
	
	//수정 창 바꿔주는 함수 
	function fn_editReply(co_num,ui_id,co_content){
		getName(ui_id);
		 var htmls = "";
	      htmls = htmls + '<div class="" id="co_num' +co_num + '">';
	       htmls += '<span class="d-block">';
	       htmls += co_num + ' - ';
	       htmls += '<strong class="text-gray-dark">' + ncName + '</strong>';
	       htmls += '<span style="padding-left: 7px; font-size: 9pt">';
	       htmls += '<a href="javascript:void(0)" onclick="fn_updateReply(' + co_num + ', \'' + ui_id + '\' )" style="padding-right:5px">저장</a>';
	       htmls += '<a href="javascript:void(0)" onclick="replylist()" >취소</a>';
	       htmls += '</span>';
	       htmls += '</span><br>';
	       htmls += '<textarea id="editmemo" name="editmemo" rows="3">';
	       htmls += co_content; 
	       htmls += '</textarea>' 
	       htmls += '</p>';
	       htmls += '</div>';
	       // 선택한 요소를 다른것으로 바꿉니다.(변경)
	       $('#co_num'+co_num).replaceWith(htmls);
	       $('#co_num'+co_num +'#editmemo').focus();
		
	}	
	
	//댓글 수정 
	function fn_updateReply(co_num,ui_id){
		var co_content=$("#editmemo").val();
		var url = '${contextPath}/board/update3';
		var paramData = {
				"ui_id":ui_id,  
				"co_num":co_num,
				"co_content": co_content
		};
		
		$.ajax({
			url:url,
			data:paramData,
			dataType:'json',
			type:'POST',
			success:function(result){
				alert('수정 완료되었습니다.')
				replylist();
			},
			error:function(result){
				alert('수정 하는 중 문제가 발생하였습니다.');
			}
			
			
		})	
		
	} 
	
	//댓글 삭제 
	function fn_deleteReply(co_num){
		var url = '${contextPath}/board/delete3';
		var paramData = {
				"co_num":co_num,
		};
		
		$.ajax({
			url:url,
			data:paramData,
			dataType:'json',
			type:'POST',
			success:function(result){
				alert('삭제 완료되었습니다.')
				replylist();
			},
			error:function(result){
				alert('삭제 하는 중 문제가 발생하였습니다.');
			}
			
		})	
		
		
		
		
	}
	

	//댓글 신고
	
		function fn_reportReply(co_num){
		var url = '${contextPath}/board/report3';
		var paramData = {
				"co_num":co_num,
		};
		
		$.ajax({
			url:url,
			data:paramData,
			dataType:'json',
			type:'POST',
			success:function(result){
				alert('신고 완료되었습니다.')
				replylist();
			},
			error:function(result){
				alert('신고 하는 중 문제가 발생하였습니다.');
			}
			
		})	
		
		
	}
	
	
	// 댓글 좋아요 & 취소
		function fn_likeReply(co_num){
		var url = '${contextPath}/board/like3';
		var paramData = {
				"co_num":co_num,
				"ui_id": "${user.ui_id}"
		};
		
		$.ajax({
			url:url,
			data:JSON.stringify(paramData),
			dataType:'json',
			contentType: 'application/json; charset=utf-8',
			type:'POST',
			success:function(likeCheck){
				if(likeCheck==0){
					alert('댓글 좋아요 처리되었습니다.')
					
					replylist();
				
				}else {
					alert('댓글 좋아요 취소처리되었습니다.')
					
					replylist();
		
				}
			},
			error:function(likeCheck){
				alert('좋아요 처리 오류');
			}
			
		});	
		
	}
	
	// 댓글 좋아요 조회
		function likeReply(co_num){
			var url = '${contextPath}/board/likeReply';
			var paramData = {
					"co_num":co_num,
					"ui_id": "${user.ui_id}"
			};
			$.ajax({
				url:url,
				data:JSON.stringify(paramData),
				dataType:'json',
				contentType: 'application/json; charset=utf-8',
				type:'POST',
				success:function(likeCheck){
					if(likeCheck==0){
						html = '<c:if test="${!empty user.ui_id}"><a id="heart' +co_num+ '" onclick="fn_likeReply(' + co_num + ')"" style="padding-right:8px" >♡좋아요</a></c:if>'
						$('#heart'+co_num).replaceWith(html);
					}else {
						html = '<c:if test="${!empty user.ui_id}"><a id="heart' +co_num+ '" onclick="fn_likeReply(' + co_num + ')"" style="padding-right:8px" >❤︎취소</a></c:if>'
						$('#heart'+co_num).replaceWith(html);
					}
				},
				error:function(likeCheck){
					alert('좋아요 조회 오류');
				}
				
			});		
		
		
		
	}
	
	
	
	// 게시글 좋아요 & 취소
		$(document).ready(function(){
			console.log('ajax heart ready');
			var likecheck = ${like};
			
			
			var bo_heart = ${board.bo_heart};
			if(likecheck > 0){
				$('#LikeBtn').html(bo_heart+'❤︎취소');
			}else{
				$('#LikeBtn').html(bo_heart+'♡좋아요');
			}
		
			$(document).on('click','#LikeBtn',function(){
				
				
				if(likecheck > 0){ 
					console.log(likecheck + "좋아요 누름상태");
					var url = '${contextPath}/board/dislike';
					
					var paramData = { 
						"bo_num" : "${board.bo_num}",
						"he_num" : "${like}"
						
					};//추가데이터 작성
						
					$.ajax({
						url: url,
						data: JSON.stringify(paramData),
						dataType: 'json',
						contentType: 'application/json; charset=utf-8',
						type: 'POST',
						success: function(result){

							alert('취소 처리되었습니다.'+ ${like});
							
							location.reload();

							$('#LikeBtn').html(bo_heart+'♡좋아요');
						},
						error: function(result){
							alert('취소 실패');				
						}
					});	//ajax end
				}else{
					console.log(likecheck+'좋아요 안누름상태'+${board.bo_num});
					
					var url = '${contextPath}/board/like';
					var paramData = { 
						"ui_id": "${user.ui_id}",
						"bo_num" : "${board.bo_num}"
					};//추가데이터 작성
					
					$.ajax({
						url: url,
						data: JSON.stringify(paramData),
						dataType: 'json',
						contentType: 'application/json',
						type: 'POST',
						success: function(result){

							alert('좋아요 처리되었습니다.');
							location.reload();

							$('#LikeBtn').html(bo_heart+'❤︎취소');
						},
						error: function(result){
							alert('좋아요 에러 발생');
						}
						
					}); // ajax end
					
				}
				
			}); //end of $(document).on
		})
		 
		
	
		
			
				
				
		
	
	
	
	
</script>



<%@ include file="../include/head.jsp"%>

<body class="page-blog">

	<%@ include file="../include/nav_bar.jsp"%>

	<div id="layoutSidenav">

		<%@ include file="../include/layoutSidenav.jsp"%>

		<div id="layoutSidenav_content">
			<main id="main">
				<!-- contents -->
				<!-- 각자 맡은 페이지 만들시 해당 페이지의 css, 이미지 등 스타일 요소들은 헤더를 <main> 영역 안에 <link> 를 이용해 넣으면 됨.-->
				<!-- Template Main CSS File -->
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




<!-- ======= Breadcrumbs ======= -->
<div class="breadcrumbs d-flex align-items-center"
	style="background-image: url('${contextPath}/resources/test/img/blog-header.jpg');">
	<div
		class="container position-relative d-flex flex-column align-items-center">

		<h2 class="title">제목 : ${board.bo_title }</h2>
		<ol>


			<c:if test="${board.ca_num <100}">
				<li><a
					href="list?ca=${board.ca_num }&page=${scri.page}&perPageNum=${scri.perPageNum}&searchType=${scri.searchType}&keyword=${scri.keyword}">목록으로</a></li>
			</c:if>
			<c:if test="${board.ca_num <200 && board.ca_num>100}">
				<li><a
					href="listpicpet?ca=${board.ca_num }&page=${scri.page}&perPageNum=${scri.perPageNum}&searchType=${scri.searchType}&keyword=${scri.keyword}">목록으로</a></li>
			</c:if>
			<c:if test="${board.ca_num <300 && board.ca_num >200}">
				<li><a
					href="list?ca=${board.ca_num }&page=${scri.page}&perPageNum=${scri.perPageNum}&searchType=${scri.searchType}&keyword=${scri.keyword}">목록으로</a></li>
			</c:if>
			<c:if test="${board.ca_num >300}">
				<li><a
					href="listpicmarket?ca=${board.ca_num }&page=${scri.page}&perPageNum=${scri.perPageNum}&searchType=${scri.searchType}&keyword=${scri.keyword}">목록으로</a></li>
			</c:if>


			<c:if
				test="${user.ui_grade=='관리자' or user.ui_grade=='매니저' or user.ui_id== board.ui_id }">
				<li><a href="update?num=${board.bo_num }">글수정</a></li>
				<li><a href="delete?num=${board.bo_num }">글삭제</a></li>
			</c:if>
			<li><a href="report?num=${board.bo_num }">신고하기</a></li>
		</ol>

	</div>
</div>
<!-- End Breadcrumbs -->

<!-- ======= Blog Details Section ======= -->
<section id="blog" class="blog">
	<div class="container" data-aos="fade-up">

		<div class="row g-5">

			<div class="col-lg-8" data-aos="fade-up" data-aos-delay="200">

				<article class="blog-details">



					<div class="meta-top">
						<ul>
							<li class="d-flex align-items-center"><i
								class="bi bi-person"></i>${ncName}</li>
							<li class="d-flex align-items-center"><i class="bi bi-clock"></i>${board.bo_modifydate}</li>
							<li class="d-flex align-items-center"><i class="bi bi-eye"></i>${board.bo_views}</li>
							<li class="d-flex align-items-center"><i
								class="bi bi-chat-dots"></i>${replyCount }</li>
							<c:if test="${!empty user.ui_id}">
								<li class="d-flex align-items-center"><td><button
											type="button" id="LikeBtn" border-color="white">${board.bo_heart }❤︎</button></td>
								</li>
							</c:if>
							<c:if test="${empty user.ui_id}">
								<li class="d-flex align-items-center"><i
									class="bi bi-heart"></i>${board.bo_heart }</li>
							</c:if>
						</ul>
					</div>
					<!-- End meta top -->

					<div class="content">

						${board.bo_content } <br>

						<!--  
               	  <img src="${board.bo_photo}"
                   alt="" class="img-fluid">
				-->
						<c:if test="${board.pl_lat!=0&& board.pl_lon!=0}">
							<div id="map" style="width: 100%; height: 350px;"></div>
						</c:if>
					</div>
					<!-- End post content -->


				</article>
				<!-- End blog post -->

				<!-- 댓글 시작  -->




				<hr>
				<p></p>
				<div id="list3">


					<div>
						<div class="box-body">
							<table>
								<c:if test="${!empty user.ui_id}">
									<tr>
										<td rowspan="2" width="70%"><textarea
												class="form-control" name="co_content" id="co_content"
												placeholder="댓글을 입력하세요"></textarea></td>
										<td><input type="text" name="ui_id" id="ui_id"
											placeholder="댓글작성자" value="${user.ui_ncname }"
											readonly="readonly"></td>
									</tr>
									<tr>
										<td><button type="button" id="btnReplySave">저장</button></td>
									</tr>
								</c:if>
								<c:if test="${empty user.ui_id}">
									<tr>
										<td rowspan="2" width="70%"><textarea
												class="form-control" name="co_content" id="co_content"
												placeholder="로그인 하세요" readonly="readonly"></textarea></td>
										<td><input type="text" name="ui_id" id="ui_id"
											placeholder="로그인 하세요" readonly="readonly"></td>
									</tr>
									<tr>
										<td><button type="button" id="btnReplySave"
												disabled="disabled">저장</button></td>
									</tr>
								</c:if>



							</table>

						</div>
					</div>
					<hr>
					<p></p>
					<div id="replylist"></div>

				</div>
				<!-- End blog comments -->



				<hr>
				<p></p>
				<div id="list3"></div>


			</div>

			<div class="col-lg-4" data-aos="fade-up" data-aos-delay="400">


			</div>
		</div>

	</div>
</section>
<!-- End Blog Details Section -->

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

<c:if test="${!empty user.ui_id}">
	<%@ include file="/WEB-INF/views/board/minichat.jsp"%>
</c:if>
			</main>
			<%@ include file="../include/footer.jsp"%>
		</div>
	</div>
	<%@ include file="../include/plugin.jsp"%>
</body>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng('${board.pl_lon}','${board.pl_lat}'), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
var pl_lat = '${board.pl_lat}';
var pl_lon = '${board.pl_lon}';
var title = '${board.pl_name}'


// 마커가 표시될 위치입니다 
var markerPosition  = new kakao.maps.LatLng(pl_lon, pl_lat); 
console.log(markerPosition)																																
//인포 위치
var iwContent = '<div style="padding:5px;">'+title+' <br><a href="https://map.kakao.com/link/map/'+title+','+pl_lon+','+pl_lat+'" style="color:blue" target="_blank">큰지도보기</a> <a href="https://map.kakao.com/link/to/'+title+','+pl_lon+','+pl_lat+'" style="color:blue" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
    iwPosition = new kakao.maps.LatLng(pl_lon, pl_lat); //인포윈도우 표시 위치입니다
 
 // 인포윈도우를 생성합니다
    var infowindow = new kakao.maps.InfoWindow({
        position : iwPosition, 
        content : iwContent 
    });   
// 마커를 생성합니다
var marker = new kakao.maps.Marker({
    position: markerPosition
});

// 마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);
//마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
infowindow.open(map, marker); 
// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
// marker.setMap(null);    
</script>
</html>