<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<%@ include file="include/head.jsp"%>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>

<script>
$(document).ready(function(){
	if(${user!=null}){
		alert("이미 로그인이 되어있습니다.");
		history.back();
	}
});
Kakao.init('d18eec10f8ebc91e5c2b137591dd8544'); //발급받은 키 중 javascript키를 사용해준다.
console.log(Kakao.isInitialized()); // sdk초기화여부판단
//카카오로그인
function kakaoLogin() {
    Kakao.Auth.login({
      success: function (response) {
        Kakao.API.request({
          url: '/v2/user/me',
          success: function (response) {
        	  location.href = '${contextPath}/login/kakao?id='+response.id+'&email='+response.kakao_account.email;
          },
          fail: function (error) {
            console.log(error)
          },
        })
      },
      fail: function (error) {
        console.log(error)
      },
    })
  }
//카카오로그아웃  
function kakaoLogout() {
    if (Kakao.Auth.getAccessToken()) {
      Kakao.API.request({
        url: '/v1/user/unlink',
        success: function (response) {
        	console.log(response)
        },
        fail: function (error) {
          console.log(error)
        },
      })
      Kakao.Auth.setAccessToken(undefined)
    }
  }  


</script>
<body class="sb-nav-fixed">

	<%@ include file="include/nav_bar.jsp"%>

	<div id="layoutSidenav">

		<%@ include file="include/layoutSidenav.jsp"%>

		<div id="layoutSidenav_content">
			<main>
			
				<link rel="stylesheet" href="resources/assets/css/loginform.css" />


	<div class="card align-middle" style="width:20rem; border-radius:20px;">
		<div class="card-title" style="margin-top:30px;">
			<h2 class="card-title text-center" style="color:#113366;">로그인</h2>
		</div>
		<div class="card-body">
      <form class="form-signin" action="login" method="POST">
        <h5 class="form-signin-heading">로그인 정보를 입력하세요</h5>
        <label for="inputEmail" class="sr-only">Your ID</label>
        <input type="text" name="ui_id" class="form-control" placeholder="Your ID" required autofocus><BR>
        <label for="inputPassword" class="sr-only">Password</label>
        <input type="password" name="ui_pw" class="form-control" placeholder="Password" required><br>

        <div class="checkbox">
         
        </div>
        <button id="btn-Yes" class="btn btn-lg btn-primary btn-block" type="submit" style="margin-left: 90px;">로 그 인</button>
        <ul>
	<li onclick="kakaoLogin();">
      <a href="javascript:void(0)"><img src="${contextPath }/resources/images/login/kakao_login_medium_wide.png" style="margin-left:-45px;"></a>
	</li>
	
	<li>
		<a id="naverIdLogin_loginButton" href="javascript:void(0)">
          <img src = "${contextPath }/resources/images/login/naverlogin.png" style="margin-left:-45px;">
      </a>
      <script>
		//네이버로그인
		var naverLogin = new naver.LoginWithNaverId(
				{
					clientId: "MqOMlfnXKBifId29YYNJ",
					callbackUrl: "http://localhost:8080/pap/login/navertest",
					isPopup: false,
					callbackHandle: true
				}
			);
			
			/* 설정정보를 초기화하고 연동을 준비 */
			naverLogin.init();

			var testPopUp;
			function openPopUp() {
			    testPopUp= window.open("https://nid.naver.com/nidlogin.logout", "_blank", "toolbar=yes,scrollbars=yes,resizable=yes,width=1,height=1");
			}
			function closePopUp(){
			    testPopUp.close();
			}

			function naverLogout() {
				openPopUp();
				setTimeout(function() {
					closePopUp();
					}, 1000);
				
				
			}
		</script>
	
      </li>
      
		
</ul>

        <a href="${contextPath }/register" id="btn-AR" style="margin-right: 15px;float: right;" >회원가입</a>

      </form>
		</div>
	</div>
	<div class="modal">
	</div>
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script> 
			</main>
			<%@ include file="include/footer.jsp"%>
		</div>
	</div>
	<%@ include file="include/plugin.jsp"%>
</body>
</html>
