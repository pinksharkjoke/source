<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<%@ include file="../include/head.jsp"%>
<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=045cf8e3fa0eeb2315c22add32c6aae9&libraries=services"></script>
<script	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">

function getUserLocation(){
	
	if(!navigator.geolocation){
		throw '위치정보가 지원되지 않음.';
	}else{
		navigator.geolocation.getCurrentPosition((position) => {
			success(position.coords.latitude, position.coords.longitude);
		});
	}
}

function success(lat, lon){
	console.log(lat);
	console.log(lon);
	var geocoder = new kakao.maps.services.Geocoder();
	var paldo = "";
	var si = "";
	var dong = "";
	
	
	var callback = function(result, status){
		if(status == kakao.maps.services.Status.OK){
			console.log(result[0].address.address_name);
			paldo = result[0].address.region_1depth_name;
			si = result[0].address.region_2depth_name;
			dong = result[0].address.region_3depth_name;
			
			$("#paldo").val(paldo);
        	$("#si").val(si);
        	$("#dong").val(dong);
        	console.log('검색완료');
        	$("#lat").val(lat);
	        $("#lon").val(lon);
	        console.log('lat, lon 저장완료.');
			$("#geoForm").submit();
		}
	}
	
	geocoder.coord2Address(lon, lat, callback);
	
}

</script>
<body class="sb-nav-fixed">

	<%@ include file="../include/nav_bar.jsp"%>

	<div id="layoutSidenav">

		<%@ include file="../include/layoutSidenav.jsp"%>

		<div id="layoutSidenav_content">
			<main>
				
			<link rel="icon" type="image/x-icon" href="${contextPath }/resources/weather/assets/favicon.ico" />
			<!-- Google fonts-->
			<link href="https://fonts.googleapis.com/css?family=Varela+Round" rel="stylesheet" />
			<!-- Core theme CSS (includes Bootstrap)-->
			<link href="${contextPath }/resources/weather/css/styles.css" rel="stylesheet" />
			
			<div id="page-top">
				<!-- Masthead-->
				<section class="masthead">
					<div class="container px-4 px-lg-5 d-flex h-100 align-items-center justify-content-center">
						<div class="d-flex justify-content-center">
							<div class="text-center">
								<h1 class="mx-auto my-0 text-uppercase">Weather Forecast</h1>
								<h2 class="text-white-50 mx-auto mt-2 mb-5">펫과 함께 할 날. 날씨 꼭 확인하고 가세요!</h2>
								<a class="btn btn-primary" id="myloc">내 주변 날씨<br>검색하러 가기</a>&nbsp;&nbsp;
								<a class="btn btn-primary" id="detailloc" >다른 지역 날씨<br>검색하기</a>&nbsp;&nbsp;
								<a class="btn btn-primary" href="${contextPath }/weather/allLoc">전국 날씨<br>보러 가기</a>
								<form id="geoForm" action="detailProc" method="post">
									<input id="paldo" name="paldo" hidden="true" />
									<input id="si" name="si" hidden="true" />
									<input id="dong" name="dong" hidden="true" />
									<input id="lat" name="lat" hidden="true" />
									<input id="lon" name="lon" hidden="true" />
								</form>
							</div>
						</div>
					</div>
				</section>
				<script type="text/javascript">
				$("#detailloc").click(function(){
					var geocoder = new kakao.maps.services.Geocoder();
					
					var adr = "";
					var paldo = "";
					var si = "";
					var dong = "";
					var lat = 0.0;
					var lon = 0.0;
					
					new daum.Postcode({
				        oncomplete: function(data) {
				            adr = data.address;
				            paldo = data.sido;
					        si = data.sigungu;
					        dong = data.bname;
				        	$("#paldo").val(paldo);
				        	$("#si").val(si);
				        	$("#dong").val(dong);
				        	console.log('검색완료');
							geocoder.addressSearch(adr, callback);
							
				        }
					
				    }).open();
					
					var callback = function(result, status) {
					    if (status === kakao.maps.services.Status.OK) {
					        lat = result[0].y;
					        lon = result[0].x;
					        $("#lat").val(lat);
					        $("#lon").val(lon);
					        console.log('lat, lon 저장완료.');
							$("#geoForm").submit();
					    }
					};
					
					
				});
				
				$("#myloc").click(function(){
					getUserLocation();
				});
				</script>
				<!-- Bootstrap core JS-->
				<script
					src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
				<!-- Core theme JS-->
				<script src="${contextPath }/resources/weather/js/scripts.js"></script>
				<!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
				<!-- * *                               SB Forms JS                               * *-->
				<!-- * * Activate your form at https://startbootstrap.com/solution/contact-forms * *-->
				<!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
				<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
			</div>
			</main>
			<%@ include file="../include/footer.jsp"%>
		</div>
	</div>
	<%@ include file="../include/plugin.jsp"%>
</body>
</html>
