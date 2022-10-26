<%@ page language="java" pageEncoding="UTF-8"%>
<script type="text/javascript">
	$(document).ready(function(){
		
		console.log("1");
		
		$("#submit").click(function(){
			
			if($("#ui_id").val() == ""){
				alert("아이디를 입력하세요.");
				$("#ui_id").focus();
				return false;
			}
			
			if($("#ui_pw").val() == ""){
				alert("패스워드를 입력하세요.");
				$("#ui_pw").focus();
				return false;
			}
			
			if($("#verifyFalse").attr('hidden') == undefined){
				alert("비밀번호가 일치하지 않습니다. 다시 확인해주세요.");
				$("#pw_verify").focus();
				return false;
			}
			
			if($("#ui_name").val() == ""){
				alert("이름을 입력하세요.");
				$("#ui_name").focus();
				return false;
			}
			
			if($("#ui_ncName").val() == ""){
				alert("닉네임을 입력하세요.");
				$("#ui_ncName").focus();
				return false;
			}
			
			if($("#ui_email").val() == ""){
				alert("이메일을 입력하세요.");
				$("#ui_email").focus();
				return false;
			}

			if($("#e_certify_B").val() == "N"){
				alert('이메일 인증을 진행해주세요.');
				$("#ui_email").focus();
				return false;
			}
			
			if($("#ui_phonenum").val() == ""){
				alert("핸드폰번호를 입력하세요.");
				$("#ui_phonenum").focus();
				return false;
			}
			
			if($("#ui_loc").val() == ""){
				alert("주소를 입력하세요.");
				$("#ui_loc").focus();
				return false;
			}
			
			var idVal = $("#due").val();
			if(idVal == "N"){
				alert("아이디 중복확인을 해주세요.");
				$("#ui_id").focus();
				return false;
			}
			
			var ncVal = $("#due1").val();
			if(ncVal == "N"){
				alert("닉네임 중복확인을 해주세요.");
				$("#ui_ncName").focus();
				return false;
			}else if(ncVal == "Y"){
				alert($("#ui_ncName").val() + "님! 저희 P.A.P 회원가입을 환영합니다!!");
				fn_submitRegForm();
			}
		}) // 회원가입 버튼 클릭시 작동.
		
		$("#reset").click(function(){
			$("#ui_id").val('');
			$("#ui_pw").val('');
			$("#pw_verify").val('');
			$("#ui_name").val('');
			$("#ui_ncName").val('');
			$("#ui_email").val('');
			$("#ui_phonenum").val('');
			$("#ui_loc").val('');
			$("#ui_birth").val('');
			$("#ui_img").val('');
			$("#ui_grade").val('');
			$("#due").val('N');
			$("#due1").val('N');
			$("#due").removeAttr("disabled");
			$("#due1").removeAttr("disabled");
			$("#verifyTrue").attr("hidden", "true");
			$("#verifyFalse").attr("hidden", "true");
		})
		
		$("#ui_id").change(function(){
			$("#due").val('N');
			$("#due").removeAttr("disabled");
			var Id = $("#ui_id").val();
			var regId = new RegExp(/^[a-z0-9]+$/);
			if(!regId.test(Id) || Id.length > 20 || Id.length < 6){
				alert('아이디는 영소문자와 숫자를 조합하여 최소 6 ~ 최대 20글자로 입력하세요.');
				$("#ui_id").focus();
			}
		})
		
		$("#ui_ncName").change(function(){
			$("#due1").val('N');
			$("#due1").removeAttr("disabled");
		})
		
		$("#cencle").click(function(){
			alert('홈페이지로 이동됩니다.');
			location.href='${contextPath}';
		})
		
		$("#show1").click(function(){
			var checked = $('#show1').is(':checked');
			
			
			if(checked){
				$('#show1').val("show1");
				var val = $("#show1").val();
				fn_changeType(val);
			}else{
				$('#show1').val("hide1");
				var val = $("#show1").val();
				fn_changeType(val);
			}
		})
		
		$("#show2").click(function(){
			var checked = $('#show2').is(':checked');
			
			
			if(checked){
				$('#show2').val("show2");
				var val = $("#show2").val();
				fn_changeType(val);
			}else{
				$('#show2').val("hide2");
				var val = $("#show2").val();
				fn_changeType(val);
			}
		})
		
		$("#ui_pw").change(function(){
			var val1 = $("#ui_pw").val();
			var val2 = $("#pw_verify").val();
			
			if(val1 == val2){
				var verify = true;
				fn_pwverify(verify);
			}else{
				var verify = false;
				fn_pwverify(verify);
			}

			var Pw = $("#ui_pw").val();
			var regPw = new RegExp(/^[0-9a-z]+[\`\~\!\@\#\$\%\^\&\*\(\)\_\=\+]+$/);
			if(!regPw.test(Pw) ||Pw.length > 20 || Pw.length < 6){
				alert('비밀번호는 영소문자와 숫자, 특수문자를 조합하여 최소 6 ~ 최대 20글자로 입력하세요.');
				$("#ui_pw").focus();
			}
		})
		
		$("#pw_verify").change(function(){
			var val1 = $("#ui_pw").val();
			var val2 = $("#pw_verify").val();
			
			if(val1 == val2){
				var verify = true;
				fn_pwverify(verify);
			}else{
				var verify = false;
				fn_pwverify(verify);
			}
		})
		
		$("#ui_email").change(function(){
			var email = $("#ui_email").val();
			var regEm = new RegExp(/^[0-9a-zA-Z\_\-]+@[0-9a-zA-Z\.\_\-]+$/);
			if(!regEm.test(email)){
				alert('알맞은 이메일 형식으로 입력하세요.');
				$("#ui_email").focus();
			}
		})
		
		$("#ui_phonenum").keyup(function(event){
			event = event || window.event;
			var _val = this.value.trim();
			this.value = autoHypenTel(_val);
		})
		
		$("#e_Button").click(function(){
			if($("#ui_email") == ""){
				alert('이메일을 입력하세요.');
				$("#ui_email").focus();
				return false;
			}else{
				fn_emaildup();
			}

		})
		
		$("#e_certify_B").click(function(){
			var certify_num = 0;
			var ec = $("#e_certify").val();
			var ec_h = $("#e_certify_h").val();
			console.log(ec_h);
			if(ec == ""){
				alert('인증번호를 입력하세요.');
				$("#e_certify").focus();
				return false;
			}else if(ec != ec_h){
				certify_num += 1;
				alert('인증번호가 다릅니다. ' + certify_num  +
				'회 틀리셨습니다. 총 3번 중 : ' + certify_num + '번 틀림.');
				if(certify_num == 3){
					$("#e_Button").removeAttr("hiiden");
					$("#e_certify_span").attr("hidden", "true");
					$("#e_certify_B").attr("hidden", "true");
					alert('인증번호를 3회 틀려셨으므로 인증번호를 다시 전송받으시기 바랍니다.');
				}
				$("#e_certify").focus();
				return false;
			}else if(ec == ec_h){
				$("#e_certify_B").val('Y');
				$("#e_certify_B").attr("disabled", "disabled");
				alert('인증에 성공했습니다. 회원가입을 계속 진행해주세요.');
			}

		})
		
	});// end of document.ready

	function fn_emaildup(){
		var email = $("#ui_email").val();
		var param = {
				"email": email
		};
		
		$.ajax({
			url: "${contextPath}/account/emduplicate",
			type: "POST",
			data: param,
			headers:{
				"Context-Type":"application/json",
			},
			success: function(result){
				console.log(result);
				if(result == 0){
					fn_emailProc();
				}else{
					alert('이미 인증된 사용자 입니다.');
				}
			},
			error: function(result){
				console.log('이메일 중복 체크 전송실패');
			}
		});
	}
	
	function fn_emailProc(){
		var email = $("#ui_email").val();
		fn_emailSender(email);
		$("#e_Button").attr("hiiden", "true");
		$("#e_certify_span").removeAttr("hidden");
		$("#e_certify_B").removeAttr("hidden");
		alert('입력하신 이메일주소로 인증메일이 전송되었습니다.');
	}

	function fn_emailSender(email){
		var param = {
				"email":email
		};
		
		$.ajax({
			url: "${contextPath}/registerEmail",
			type: "POST",
			data: param,
			headers:{
				"Context-Type":"application/json",
			},
			success: function(result){
				console.log(result);
				$("#e_certify_h").attr("value",result);
			},
			error: function(result){
				console.log('타겟 이메일 전송실패');
			}
		});
		
	} // end of fn_emailSender
	
	
	function fn_idDueCheck(){
		var id = $("#ui_id").val();
		
		var url="${pageContext.request.contextPath}/account/dueplicate"; // ajax url
		var paramData = {
				"id" : id
		} // 추가데이터
		
		$.ajax({
			url : url,
			data : paramData,
			dataType : 'json',
			type : 'POST',
			success : 
				function(data){
				if(data == 0){
					$("ui_id").val(id);
					$("#due").attr("value", "Y");
					dup();
					alert("사용가능한 아이디 입니다!");
					
				}else if(data == 1){
					alert("이미 존재하는 아이디입니다. 다시 입력해주세요.");
				}
			},
			error : function(data){
				alert("id 전송 실패!!");
			}
		})
		
	} // end of idDue
	
	function fn_submitRegForm(){
		
		var id = $("#ui_id").val();
		var pw = $("#ui_pw").val();
		var name = $("#ui_name").val();
		var ncName = $("#ui_ncName").val();
		var email = $("#ui_email").val();
		var phonenum = $("#ui_phonenum").val();
		var loc = $("#ui_loc").val();
		var birth = $("#ui_birth").val();
		var img = $("#ui_img").val();
		var grade = $("#ui_grade").val();
		
		var url = "${pageContext.request.contextPath}/registerProc"
		var paramData = {
				"ui_id" : id,
			    "ui_pw" : pw,
			    "ui_name" : name,
			    "ui_ncName" : ncName,
			    "ui_email" : email,
			    "ui_phonenum" : phonenum,
			    "ui_loc" : loc,
			    "ui_birth" : birth,
			    "ui_img" : img,
			    "ui_grade" : grade
		}
		
		$.ajax({
			url: url,
			data: paramData,
			dataType: 'json',
			type: 'POST',
			success:
				function(data){
				alert('회원가입에 성공하였습니다.');
				location.href='${contextPath}';
				},
			erorr:
				function(data){
				alert("회원가입 실패.");
			}
		})
				
	} // end of fn_submitRegForm()
	
	function dup(){
		const target = document.getElementById('due');
		target.disabled = true;
	} // end of dup()
	
	function dup1(){
		const target = document.getElementById('due1');
		target.disabled = true;
	} // end of dup1()
	
	
	function fn_changeType(val){
		
		if(val == "show1"){
			$("#ui_pw").attr("type", "text");
		}else if(val == "show2"){
			$("#pw_verify").attr("type", "text");
		}else if(val == "hide1"){
			$("#ui_pw").attr("type", "password");
		}else if(val == "hide2"){
			$("#pw_verify").attr("type", "password");
		}else{
			alert('에러입니다. 비밀번호 보이기 코드 확인해주세요.');
		}
	} // end of fn_changeType
	
	function fn_ncDueCheck(){
		var ncName = $("#ui_ncName").val();
		
		var url="${pageContext.request.contextPath}/account/ncdueplicate"; // ajax url
		var paramData = {
				"ncName" : ncName
		} // 추가데이터
		
		$.ajax({
			url : url,
			data : paramData,
			dataType : 'json',
			type : 'POST',
			success : 
				function(data){
				if(data == 0){
					$("ui_ncName").val(ncName);
					$("#due1").attr("value", "Y");
					dup1();
					alert("사용가능한 닉네임 입니다!");
					
				}else if(data == 1){
					alert("이미 존재하는 닉네임입니다. 다시 입력해주세요.");
				}
			},
			error : function(data){
				alert("id 전송 실패!!");
			}
		})
		
	} // end of ncdue
	
	function fn_pwverify(verify){
		if(verify){
			$("#verifyTrue").removeAttr("hidden");
			$("#verifyFalse").attr("hidden", "true");
		}else{
			$("#verifyTrue").attr("hidden", "true");
			$("#verifyFalse").removeAttr("hidden");
		}
	} // end of fn_pwverify()
	
	function autoHypenTel(str){
		str = str.replace(/[^0-9]/g, '');
		var tmp = '';
		
		if(str.substring(0,2) == 02){
			// 서울번호 02 일 경우 10자리까지만 나타내고 나머지는 삭제.
			if(str.length < 3){
				return str;
			}else if(str.length < 6){
				tmp += str.substr(0,2);
				tmp += '-';
				tmp += str.substr(2);
				return tmp;
		    } else if (str.length < 10) {
		      tmp += str.substr(0, 2);
		      tmp += '-';
		      tmp += str.substr(2, 3);
		      tmp += '-';
		      tmp += str.substr(5);
		      return tmp;
		    } else {
		      tmp += str.substr(0, 2);
		      tmp += '-';
		      tmp += str.substr(2, 4);
		      tmp += '-';
		      tmp += str.substr(6, 4);
		      return tmp;
		    }
		  } else {
		    // 핸드폰 및 다른 지역 전화번호 일 경우
		    if (str.length < 4) {
		      return str;
		    } else if (str.length < 7) {
		      tmp += str.substr(0, 3);
		      tmp += '-';
		      tmp += str.substr(3);
		      return tmp;
		    } else if (str.length < 11) {
		      tmp += str.substr(0, 3);
		      tmp += '-';
		      tmp += str.substr(3, 3);
		      tmp += '-';
		      tmp += str.substr(6);
		      return tmp;
		    } else {
		      tmp += str.substr(0, 3);
		      tmp += '-';
		      tmp += str.substr(3, 4);
		      tmp += '-';
		      tmp += str.substr(7);
		      return tmp;
		    }
		  }

		  return str;
		} // end of autoHypenTel()
	
</script>

