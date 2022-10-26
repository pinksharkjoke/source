<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<script>
$('document').ready(function(){
	$("#pw").focus();
});

	function pwalert(){
		if($("#pw").val()!=${uv.ui_pw}){
			alert("비밀번호가 틀렸습니다.");
			return "personalPassword";
		}
	}

</script>
<%@ include file="../include/head.jsp"%>

<body class="sb-nav-fixed">

	<%@ include file="../include/nav_bar.jsp"%>

	<div id="layoutSidenav">

		<%@ include file="../include/layoutSidenav.jsp"%>

		<div id="layoutSidenav_content">
			<main>
			
				<link rel="stylesheet" href="${contextPath }/resources/assets/css/loginform.css" />


	<div class="card align-middle" style="width:20rem; border-radius:20px;">
		<div class="card-title" style="margin-top:30px;">
			<h2 class="card-title text-center" style="color:#113366;">비밀번호 확인</h2>
		</div>
		<div class="card-body">
      <form class="form-signin" method="POST">
        <h5 class="form-signin-heading">비밀번호를 입력하세요</h5>
        <label for="inputPassword" class="sr-only">Password</label>
        <input type="password" id="pw" name="ui_pw" class="form-control" placeholder="Password" required>
        <small style="color: green; font-weight: bold;">** google, naver 로 가입해 처음 로그인하신 회원분들의 기본 비밀번호는 1234 입니다.</small>
        <div class="checkbox">
         
        </div>
        <button id="btn-Yes" class="btn btn-lg btn-primary btn-block" type="submit" onclick="pwalert()">확인</button>
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
			<%@ include file="../include/footer.jsp"%>
		</div>
	</div>
	<%@ include file="../include/plugin.jsp"%>
</body>
</html>
