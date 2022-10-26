<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ page session="true" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<style type="text/css">
li {
	list-style: none;
	float: left;
	padding: 6px;
}
</style>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=045cf8e3fa0eeb2315c22add32c6aae9&libraries=services,clusterer,drawing"></script>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<link rel="stylesheet" href="${contextPath}/resources/test/css/main.css" />
<%@ include file="../include/head.jsp"%>
<link rel="stylesheet" href="${contextPath}/resources/map/map.css" />



<body class="sb-nav-fixed">

	<%@ include file="../include/nav_bar.jsp"%>

	<div id="layoutSidenav">

		<%@ include file="../include/layoutSidenav.jsp"%>

		<div id="layoutSidenav_content">




			<main>
				<!-- ======= Breadcrumbs ======= -->
				<div class="breadcrumbs d-flex align-items-center"
					style="background-image: url('${contextPath}/resources/test/img/restaurant.jpg'); background-size:cover;">
					<div
						class="container position-relative d-flex flex-column align-items-center">



						<h2>Restaurant</h2>


					</div>
				</div>



				<div class="map_wrap">
					<div id="map"
						style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>

					<div id="menu_wrap" class="bg_white">
						<div class="option">
							<div>
								<form onsubmit="searchPlaces(); return false;">
									키워드 : <input type="text" id="keyword" size="15">
									<button type="submit">검색하기</button>
								</form>
							</div>
						</div>
						<hr>
						<ul id="placesList"></ul>
						<div id="pagination"></div>
					</div>
				</div>




				<script>
					$(document).ready(function() {
						$('#add').on('click', function() {
							$.ajax({
								url : "map/insert",
								type : "POST",
								data : $('#frm').serialize(),
								success : function(data) {
									location.href = "map";
									alert("장소가 추가 되었습니다.");
								},
								error : function() {
									alert("장소 추가에 실패하였습니다.");
								}
							});
						});
					});
				</script>


				<c:if test="${user.ui_id!=null}">
					<form method="POST" id="frm" style="margin: 5px">
						<label>장소명:</label> <input type="text" name="pl_name" id="pl_name"
							size="30"> <label>위도:</label> <input type="text"
							name="pl_lat" id="pl_lat"> <label>경도:</label> <input
							type="text" name="pl_lon" id="pl_lon"> <label>카테고리</label>
						<select name="pl_category" id="pl_category">
							<option value="병원">병원</option>
							<option value="카페">카페</option>
							<option value="마트">마트</option>
							<option value="식당">식당</option>
							<option value="놀이터">놀이터</option>
							<option value="기타">기타</option>
						</select> <label>전화번호:</label><input type="text" name="pl_phnum" size="8">
						<label>링크 : </label><input type="text" name="pl_url"> <input
							type="button" id="add" value="장소 추가"> <label>등록자</label><input
							type="text" name="ui_id" value="${user.ui_id }"
							readonly="readonly">
					</form>
				</c:if>




				<p id="result"></p>

				<!-- 구 카테고리 -->
				<div id="cateBtn" style="margin: 5px">
					<a href="${contextPath }/map?ui_id=${user.ui_id}">
						<button class="ca_1 cateBtn on" id="all" value="전체">전체</button>
					</a> <a href="${contextPath }/maphospital?ui_id=${user.ui_id}">
						<button class="ca_2 cateBtn" id="hospital" value="병원">병원</button>
					</a> <a href="${contextPath }/mapcafe?ui_id=${user.ui_id}">
						<button class="ca_3 cateBtn" id="cafe" value="카페">카페</button>
					</a> <a href="${contextPath }/mapmart?ui_id=${user.ui_id}">
						<button class="ca_4 cateBtn" id="mart" value="마트">마트</button>
					</a> <a href="${contextPath }/maprestaurant?ui_id=${user.ui_id}">
						<button class="ca_5 cateBtn" id="restaurant" value="식당">식당</button>
					</a><a href="${contextPath }/mapplayground?ui_id=${user.ui_id}">
						<button class="ca_6 cateBtn" id="playground" value="놀이터">놀이터</button>
					</a> <a href="${contextPath }/mapetc?ui_id=${user.ui_id}">
						<button class="ca_7 cateBtn" id="etc" value="기타">기타</button>
					</a>


				</div>
				<!-- /구 카테고리-->

				<!-- 테이블 -->
				<form action="" id="setRows" name="myHiddenForm">
					<input type="hidden" name="rowPerPage" value="10">
				</form>
				<table class="table table-hover" id="products">
					<thead>
						<tr>
							<th>카테고리</th>
							<th>이름</th>
							<th>전화번호</th>
							<th>링크</th>
							<th>*</th>
							<c:if
								test="${user.ui_grade=='관리자' or user.ui_grade=='매니저' or user.ui_grade=='평회원'}">
								<th>수정</th>
								<th>삭제</th>
							</c:if>
						</tr>

						<c:forEach var="list" items="${list }">
							<tr>

								<td>${list.pl_category}</td>
								<td>${list.pl_name}</td>
								<td>${list.pl_phnum}</td>
								<td><a href="${list.pl_url}">${list.pl_url}</a></td>
								<td><a
									href="${contextPath }/map/relatedPost?pl_name=${list.pl_name}">관련
										글 보기</a></td>
								<c:if
									test="${user.ui_grade=='관리자' or user.ui_grade=='매니저' or user.ui_grade=='평회원'}">
									<td><a href="updatemap?pl_name=${list.pl_name}">수정</a></td>
									<td><a href="deletemap?pl_name=${list.pl_name}">삭제</a></td>
								</c:if>



							</tr>
						</c:forEach>


					</thead>
					<tbody id="valInfo">
					</tbody>
				</table>
				<!-- /테이블 -->
			

				<script>
					// 마커를 담을 배열입니다
					var markers = [];
					var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
					mapOption = {
						center : new kakao.maps.LatLng(37.26605926890435,
								126.99984498409006),
						level : 4
					// 지도의 확대 레벨 
					};
					var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
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
						var keyword = document.getElementById('keyword').value;
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
						var listEl = document.getElementById('placesList'), menuEl = document
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
									placePosition, i), itemEl = getListItem(i,
									places[i]); // 검색 결과 항목 Element를 생성합니다
							// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
							// LatLngBounds 객체에 좌표를 추가합니다
							bounds.extend(placePosition);
							// 마커와 검색결과 항목에 mouseover 했을때
							// 해당 장소에 인포윈도우에 장소명을 표시합니다
							// mouseout 했을 때는 인포윈도우를 닫습니다
							(function(marker, title) {
								kakao.maps.event.addListener(marker,
										'mouseover', function() {
											displayInfowindow(marker, title);
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

								kakao.maps.event.addListener(marker, 'click',
										(function(placePosition) {
											displayInfowindow(marker, title);
											return function() {
												// 좌표정보를 파싱하기 위해 hidden input에 값 지정
												$("#pl_lat").val(
														placePosition.Ma);
												$("#pl_lon").val(
														placePosition.La);
												$("#pl_name").val(title);

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
							itemStr += '    <span>' + places.road_address_name
									+ '</span>'
									+ '   <span class="jibun gray">'
									+ places.address_name + '</span>';
						} else {
							itemStr += '    <span>' + places.address_name
									+ '</span>';
						}
						itemStr += '  <span class="tel">' + places.phone
								+ '</span>' + '</div>';
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
						}, markerImage = new kakao.maps.MarkerImage(imageSrc,
								imageSize, imgOptions), marker = new kakao.maps.Marker(
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
							paginationEl.removeChild(paginationEl.lastChild);
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
					// 주소-좌표 변환 객체를 생성합니다
					var geocoder = new kakao.maps.services.Geocoder();
					var marker = new kakao.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
					infowindow = new kakao.maps.InfoWindow({
						zindex : 1
					}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다
					// 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
					searchAddrFromCoords(map.getCenter(), displayCenterInfo);
					// 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
					kakao.maps.event
							.addListener(
									map,
									'click',
									function(mouseEvent) {
										searchDetailAddrFromCoords(
												mouseEvent.latLng,
												function(result, status) {
													if (status === kakao.maps.services.Status.OK) {
														var detailAddr = !!result[0].road_address ? '<div>도로명주소 : '
																+ result[0].road_address.address_name
																+ '</div>'
																: '';
														detailAddr += '<div>지번 주소 : '
																+ result[0].address.address_name
																+ '</div>';
														var content = '<div class="bAddr">'
																+ '<span class="title">주소정보</span>'
																+ detailAddr
																+ '</div>';
														// 마커를 클릭한 위치에 표시합니다 
														marker
																.setPosition(mouseEvent.latLng);
														marker.setMap(map);
														// 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
														infowindow
																.setContent(content);
														infowindow.open(map,
																marker);

													}
												});
									});
					// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
					kakao.maps.event.addListener(map, 'idle',
							function() {
								searchAddrFromCoords(map.getCenter(),
										displayCenterInfo);
							});
					function searchAddrFromCoords(coords, callback) {
						// 좌표로 행정동 주소 정보를 요청합니다
						geocoder.coord2RegionCode(coords.getLng(), coords
								.getLat(), callback);
					}
					function searchDetailAddrFromCoords(coords, callback) {
						// 좌표로 법정동 상세 주소 정보를 요청합니다
						geocoder.coord2Address(coords.getLng(),
								coords.getLat(), callback);
					}
					// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
					function displayCenterInfo(result, status) {
						if (status === kakao.maps.services.Status.OK) {
							var infoDiv = document.getElementById('centerAddr');
							for (var i = 0; i < result.length; i++) {
								// 행정동의 region_type 값은 'H' 이므로
								if (result[i].region_type === 'H') {
									//infoDiv.innerHTML = result[i].address_name;
									break;
								}
							}
						}
					}

					//db마커 출력

					var obj = JSON.parse('${json}');
					var arr = new Array();
					for (var i = 0; i < obj.length; i++) {
						arr[i] = [ obj[i].pl_name, obj[i].pl_lat, obj[i].pl_lon ];
					}
					// 마커 이미지의 이미지 주소입니다
					var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
					for (var i = 0; i < arr.length; ++i) {
						// 마커 이미지의 이미지 크기 입니다
						var imageSize = new kakao.maps.Size(24, 35);
						// 마커 이미지를 생성합니다    
						var markerImage = new kakao.maps.MarkerImage(imageSrc,
								imageSize);

						var markers = new kakao.maps.Marker({
							map : map, // 마커를 표시할 지도
							position : new kakao.maps.LatLng(arr[i][1],
									arr[i][2]), // 마커를 표시할 위치
							title : arr[i][0], // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
							image : markerImage
						// 마커 이미지 
						});
					}
					//클릭 이벤트
					kakao.maps.event.addListener(map, 'click', function(
							mouseEvent) {
						// 클릭한 위도, 경도 정보를 가져옵니다 
						var latlng = mouseEvent.latLng;
						var latt = latlng.getLat();
						console.log(latt);
						var lonn = latlng.getLng();
						console.log(lonn);
						var message = '';
						var resultDiv = document.getElementById('result');
						resultDiv.innerHTML = message;
						$('input[name=pl_lat]').attr('value', latt);
						$('input[name=pl_lon]').attr('value', lonn);
					});
				</script>
			</main>
			<%@ include file="../include/footer.jsp"%>
		</div>
	</div>
	<%@ include file="../include/plugin.jsp"%>
</body>
</html>