<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<script>
var naverLogin = new naver.LoginWithNaverId(
		{
			clientId: "MqOMlfnXKBifId29YYNJ",
			isPopup: false,
			callbackHandle: true
		}
	);
	
	/* 설정정보를 초기화하고 연동을 준비 */
	naverLogin.init();
window.addEventListener('load', function () {
	naverLogin.getLoginStatus(function (status) {
		if (status) {
			var email = naverLogin.user.getEmail(); // 필수로 설정할것을 받아와 아래처럼 조건문을 줍니다.
    		
			console.log(naverLogin.user);
    		
            if( email == undefined || email == null) {
				alert("이메일은 필수정보입니다. 정보제공을 동의해주세요.");
				naverLogin.reprompt();
				return;
			}
            location.href="${contextPath}/pap/login/naver?id="+naverLogin.user.getId()+"&email="+email+"&phonenum="+naverLogin.user.getMobile();
		} else {
			console.log("callback 처리에 실패하였습니다.");
		}
	});
});


</script>
</body>
</html>