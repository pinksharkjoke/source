<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=045cf8e3fa0eeb2315c22add32c6aae9&libraries=services,clusterer,drawing"></script>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<%@ include file="../include/head.jsp"%>
<link rel="stylesheet" href="${contextPath}/resources/map/map.css" />

<body class="sb-nav-fixed" style="padding-top: 5rem;">

	<%@ include file="../include/nav_bar.jsp"%>

	<div id="layoutSidenav">

		<%@ include file="../include/layoutSidenav.jsp"%>

		<div id="layoutSidenav_content">
			<main>
				<!-- include libraries(jQuery, bootstrap) -->
				<link
					href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"
					rel="stylesheet">
				<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
				<script
					src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

				<!-- include summernote css/js -->
				<link
					href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css"
					rel="stylesheet">
				<script
					src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>

				<!-- summer노트 사진업로드 -->

				<script>
					$(document)
							.ready(
									function() {

										var toolbar = [
												// 글꼴 설정
												[ 'fontname', [ 'fontname' ] ],
												// 글자 크기 설정
												[ 'fontsize', [ 'fontsize' ] ],
												// 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
												[
														'style',
														[
																'bold',
																'italic',
																'underline',
																'strikethrough',
																'clear' ] ],
												// 글자색
												[
														'color',
														[ 'forecolor', 'color' ] ],
												// 표만들기
												[ 'table', [ 'table' ] ],
												// 글머리 기호, 번호매기기, 문단정렬
												[
														'para',
														[ 'ul', 'ol',
																'paragraph' ] ],
												// 줄간격
												[ 'height', [ 'height' ] ],
												// 그림첨부, 링크만들기, 동영상첨부
												[
														'insert',
														[ 'picture', 'link',
																'video' ] ],
												// 코드보기, 확대해서보기, 도움말
												[
														'view',
														[ 'codeview',
																'fullscreen',
																'help' ] ] ];

										var setting = {
											height : 400,
											minHeight : null,
											maxHeight : null,
											focus : true,
											lang : 'ko-KR',
											toolbar : toolbar,
											//콜백 함수
											callbacks : {
												onImageUpload : function(files,
														editor, welEditable) {
													// 파일 업로드(다중업로드를 위해 반복문 사용)
													for (var i = files.length - 1; i >= 0; i--) {
														uploadSummernoteImageFile(
																files[i], this);
													}
												}
											}
										};
										$('#summernote').summernote(setting);

										function uploadSummernoteImageFile(
												file, el) {

											data = new FormData();
											data.append("file", file);

											$.ajax({
														data : data,
														type : "POST",
														url : "uploadSummernoteImageFile",
														contentType : false,
														enctype : 'multipart/form-data',
														processData : false,
														success : function(data) {
															console.log(data);
										
															$(el).summernote('editor.insertImage', data.photo);
														
															
															
															var bo_photo=data.photo;
															
															
															if(bo_photo!=null){
																bo_photo+=","+data.photo;
																$('input[name=bo_photo]').attr('value',bo_photo);
																
															}
															
															
														}
													});
											
											
											
											
											
										}

									});
				</script>

				<!--  summernote 끝 -->




				<!-- 글작성 폼 -->
				<table style="margin: 5px">
					<form name="form" method="POST">
						<input type="hidden" id="ca_num" name="ca_num" value="${type}" />

						<input type="hidden" id="ui_id" name="ui_id" value="${user.ui_id}" />
						<input type="hidden" id="bo_photo" name="bo_photo" />

						<div class="form-group">
							<label>제목</label> <input type="text" name='bo_title'
								class="form-control" placeholder="제목을 입력하세요">
						</div>

						<div class="form-group">
							<label>내용</label>
							<textarea class="form-control" id="summernote" name="bo_content"
								rows="3" placeholder="내용을 입력하세요"></textarea>
						</div>


						<div class="form-group">
							<label>작성자</label> <input type="text" name="bo_name"
								class="form-control" value="${user.ui_ncname }" readonly>
						</div>


						<c:if test="${type > 300 and user.ui_id!='admin'}">
							<div class="form-group">
								<label>제품상태</label> <select name="bo_pstatus" id="bo_pstatus"
									value="${board.bo_pstatus }">
									<option value="판매중">판매중</option>
									<option value="예약중">예약중</option>
									<option value="판매완료">판매완료</option>
								</select>
							</div>
						</c:if>


						<c:if test="${user.ui_grade=='관리자' or user.ui_grade=='매니저' }">
							<div class="form-group">
								<label>공지여부</label> <select name="bo_notice" id="bo_notice"
									value="${board.bo_notice }">
									<option value="0">공지X</option>
									<option value="1">공지O</option>

								</select>
							</div>
						</c:if>
						<input type="hidden" id="pl_name" name="pl_name"> <input
							type="hidden" id="pl_lat" name="pl_lat" value=0.0> <input
							type="hidden" id="pl_lon" name="pl_lon" value=0.0>

						<div id="result"></div>
						<!-- 지도 추가  -->
						<div class="map_wrap">
							<div id="map"
								style="width: 700px; height: 500px; position: relative; overflow: hidden;"></div>

							<div id="menu_wrap" class="bg_white">
								<div class="option">
									<div>

										키워드 : <input type="text" id="keyword" size="0.5"> <input
											type="button" id="searchBtn" onclick="searchPlaces()"
											value="검색">

									</div>
								</div>
								<hr>
								<ul id="placesList"></ul>
								<div id="pagination"></div>
							</div>
						</div>


						<script>
							// 마커를 담을 배열입니다
							var markers = [];

							var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
							mapOption = {
								center : new kakao.maps.LatLng(
										37.26605926890435, 126.99984498409006), // 지도의 중심좌표
								level : 3
							// 지도의 확대 레벨
							};

							// 지도를 생성합니다    
							var map = new kakao.maps.Map(mapContainer,
									mapOption);

							// 장소 검색 객체를 생성합니다
							var ps = new kakao.maps.services.Places();

							// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
							var infowindow = new kakao.maps.InfoWindow({
								zIndex : 1
							});

							// 키워드로 장소를 검색합니다
							searchPlaces();

							// 키워드 검색을 요청하는 함수입니다
							function searchPlaces() {

								var keyword = document
										.getElementById('keyword').value;

								if (!keyword.replace(/^\s+|\s+$/g, '')) {
									return false;
								}

								// 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
								ps.keywordSearch(keyword, placesSearchCB);
							}

							// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
							function placesSearchCB(data, status, pagination) {
								if (status === kakao.maps.services.Status.OK) {

									// 정상적으로 검색이 완료됐으면
									// 검색 목록과 마커를 표출합니다
									displayPlaces(data);

									// 페이지 번호를 표출합니다
									displayPagination(pagination);

								} else if (status === kakao.maps.services.Status.ZERO_RESULT) {

									alert('검색 결과가 존재하지 않습니다.');
									return;

								} else if (status === kakao.maps.services.Status.ERROR) {

									alert('검색 결과 중 오류가 발생했습니다.');
									return;

								}
							}

							// 검색 결과 목록과 마커를 표출하는 함수입니다
							function displayPlaces(places) {

								var listEl = document
										.getElementById('placesList'), menuEl = document
										.getElementById('menu_wrap'), fragment = document
										.createDocumentFragment(), bounds = new kakao.maps.LatLngBounds(), listStr = '';

								// 검색 결과 목록에 추가된 항목들을 제거합니다
								removeAllChildNods(listEl);

								// 지도에 표시되고 있는 마커를 제거합니다
								removeMarker();

								for (var i = 0; i < places.length; i++) {

									// 마커를 생성하고 지도에 표시합니다
									var placePosition = new kakao.maps.LatLng(
											places[i].y, places[i].x), marker = addMarker(
											placePosition, i), itemEl = getListItem(
											i, places[i]); // 검색 결과 항목 Element를 생성합니다

									// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
									// LatLngBounds 객체에 좌표를 추가합니다
									bounds.extend(placePosition);

									// 마커와 검색결과 항목에 mouseover 했을때
									// 해당 장소에 인포윈도우에 장소명을 표시합니다
									// mouseout 했을 때는 인포윈도우를 닫습니다
									(function(marker, title) {
										kakao.maps.event.addListener(marker,
												'mouseover', function() {
													displayInfowindow(marker,
															title);
												});

										kakao.maps.event.addListener(marker,
												'mouseout', function() {
													infowindow.close();
												});

										itemEl.onmouseover = function() {
											displayInfowindow(marker, title);
										};

										itemEl.onmouseout = function() {
											infowindow.close();
										};

										kakao.maps.event
												.addListener(
														marker,
														'click',
														(function(placePosition) {
															displayInfowindow(
																	marker,
																	title);
															return function() {
																// 좌표정보를 파싱하기 위해 hidden input에 값 지정
																$("#pl_lat")
																		.val(
																				placePosition.La);
																$("#pl_lon")
																		.val(
																				placePosition.Ma);
																$("#pl_name")
																		.val(
																				title);
																// #result 영역에 좌표정보 출력
																var resultDiv = document
																		.getElementById('result');
																resultDiv.innerHTML = '선택하신 위치는 '
																		+ '"'
																		+ title
																		+ '"'
																		+ placePosition
																		+ ' 입니다';
																
															
																$('input[name=pl_name]').attr('value', title);
																$('input[name=pl_lat]').attr('value', placePosition.La);
																$('input[name=pl_lon]').attr('value', placePosition.Ma);

																
															}
														})(placePosition));

									})(marker, places[i].place_name);

									fragment.appendChild(itemEl);

								}

								// 검색결과 항목들을 검색결과 목록 Element에 추가합니다
								listEl.appendChild(fragment);
								menuEl.scrollTop = 0;

								// 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
								map.setBounds(bounds);
							}

							// 검색결과 항목을 Element로 반환하는 함수입니다
							function getListItem(index, places) {

								var el = document.createElement('li'), itemStr = '<span class="markerbg marker_'
										+ (index + 1)
										+ '"></span>'
										+ '<div class="info">'
										+ '   <h5>'
										+ places.place_name + '</h5>';

								if (places.road_address_name) {
									itemStr += '    <span>'
											+ places.road_address_name
											+ '</span>'
											+ '   <span class="jibun gray">'
											+ places.address_name + '</span>';
								} else {
									itemStr += '    <span>'
											+ places.address_name + '</span>';
								}

								itemStr += '  <span class="tel">'
										+ places.phone + '</span>' + '</div>';

								el.innerHTML = itemStr;
								el.className = 'item';

								return el;
							}

							// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
							function addMarker(position, idx, title) {
								var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
								imageSize = new kakao.maps.Size(36, 37), // 마커 이미지의 크기
								imgOptions = {
									spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
									spriteOrigin : new kakao.maps.Point(0,
											(idx * 46) + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
									offset : new kakao.maps.Point(13, 37)
								// 마커 좌표에 일치시킬 이미지 내에서의 좌표
								}, markerImage = new kakao.maps.MarkerImage(
										imageSrc, imageSize, imgOptions), marker = new kakao.maps.Marker(
										{
											position : position, // 마커의 위치
											image : markerImage
										});

								marker.setMap(map); // 지도 위에 마커를 표출합니다
								markers.push(marker); // 배열에 생성된 마커를 추가합니다

								return marker;
							}

							// 지도 위에 표시되고 있는 마커를 모두 제거합니다
							function removeMarker() {
								for (var i = 0; i < markers.length; i++) {
									markers[i].setMap(null);
								}
								markers = [];
							}

							// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
							function displayPagination(pagination) {
								var paginationEl = document
										.getElementById('pagination'), fragment = document
										.createDocumentFragment(), i;

								// 기존에 추가된 페이지번호를 삭제합니다
								while (paginationEl.hasChildNodes()) {
									paginationEl
											.removeChild(paginationEl.lastChild);
								}

								for (i = 1; i <= pagination.last; i++) {
									var el = document.createElement('a');
									el.href = "#";
									el.innerHTML = i;

									if (i === pagination.current) {
										el.className = 'on';
									} else {
										el.onclick = (function(i) {
											return function() {
												pagination.gotoPage(i);
											}
										})(i);
									}

									fragment.appendChild(el);
								}
								paginationEl.appendChild(fragment);
							}

							// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
							// 인포윈도우에 장소명을 표시합니다
							function displayInfowindow(marker, title) {
								var content = '<div style="padding:5px;z-index:1;">'
										+ title + '</div>';

								infowindow.setContent(content);
								infowindow.open(map, marker);
							}

							// 검색결과 목록의 자식 Element를 제거하는 함수입니다
							function removeAllChildNods(el) {
								while (el.hasChildNodes()) {
									el.removeChild(el.lastChild);
								}
							}
							
							$("#keyword").on("keydown", () => {
								    if (event.keyCode === 13) {
								        event.preventDefault();
								    }
								})
						</script>


						<div class="box-footer">
							<button type="submit" class="btn btn-primary" id="submit">작성완료</button>
						</div>

					</form>
				</table>


			</main>
			<%@ include file="../include/footer.jsp"%>
		</div>
	</div>
	<%@ include file="../include/plugin.jsp"%>
</body>
</html>
