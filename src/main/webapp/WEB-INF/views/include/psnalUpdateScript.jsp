<%@ page language="java" pageEncoding="UTF-8"%>
<script type="text/javascript">
	$(document).ready(function(){
		
		console.log("1");
		
		$("#subUpdate").click(function(){
			
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
			
			var ncVal = $("#dup_button").val();
			if(ncVal == "N"){
				alert("닉네임 중복확인을 해주세요.");
				$("#ui_ncName").focus();
				return false;
			}else if(ncVal == "Y"){
				console.log('모든 검사 완료');
				fn_submitUpdateForm();
			}
		}) // 회원가입 버튼 클릭시 작동.
		
		$("#reset").click(function(){
			$("#ui_pw").val('');
			$("#pw_verify").val('');
			$("#ui_name").val('${uv.ui_name}');
			$("#ui_ncName").val('${uv.ui_ncName}');
			$("#ui_email").val('${uv.ui_email}');
			$("#ui_phonenum").val('${uv.ui_phonenum}');
			$("#ui_loc").val('${uv.ui_loc}');
			$("#ui_birth").val('${uv.ui_birth}');
			$("#ui_img").val('${uv.ui_img}');
			$("#dup_button").val('N');
			$("#dup_button").attr("hidden", "true");
			$("#dup_success").removeAttr("hidden");
			$("#verifyTrue").attr("hidden", "true");
			$("#verifyFalse").attr("hidden", "true");
			$("#e_button").attr("hidden", "true");
			$("#e_success").removeAttr("hidden");
			$("#e_button").val('Y');
			$("#e_certify_B").attr("hidden", "true");
			$("#e_certify_span").attr("hidden", "true");
			$("#p_button").removeAttr("hidden");
			$("#ui_pw").attr("readonly", "readonly");
		})
		
		$("#ui_ncName").change(function(){
			$("#dup_button").val('N');
			$("#dup_button").removeAttr("hidden");
			$("#dup_success").attr("hidden", "true");
			
		})
		
		$("#dup_button").click(function(){
			fn_ncDupCheck();
		})

		$("#p_button").click(function(){
			$("#ui_pw").removeAttr("readonly");
			$("#pw_verify").removeAttr("readonly");
			$("#p_button").attr("hidden", "true");
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
			$("#e_button").removeAttr("hidden");
			$("#e_success").attr("hidden", "true");
			$("#e_button").val('N');
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
		
		$("#e_button").click(function(){
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
					$("#e_Button").removeAttr("hidden");
					$("#e_certify_span").attr("hidden", "true");
					$("#e_certify_B").attr("hidden", "true");
					alert('인증번호를 3회 틀려셨으므로 인증번호를 다시 전송받으시기 바랍니다.');
				}
				$("#e_certify").focus();
				return false;
			}else if(ec == ec_h){
				$("#e_certify_B").val('Y');
				$("#e_certify_B").attr("disabled", "disabled");
				alert('인증에 성공했습니다.');
			}

		})

		$("#ui_loc").click(function(){
			var geocoder = new kakao.maps.services.Geocoder();
									
			new daum.Postcode({
		        oncomplete: function(data) {
		            var adr = data.address;
					$("#ui_loc").val(adr);
		        	console.log('검색완료');
		        }
			
		    }).open();
			
		});
		
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
		$("#e_button").attr("hidden", "true");
		$("#e_success").removeAttr("hidden");
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
	
	function fn_submitUpdateForm(){
		
		var id = $("#ui_id").val();
		var pw = $("#ui_pw").val();
		var name = $("#ui_name").val();
		var ncName = $("#ui_ncName").val();
		var email = $("#ui_email").val();
		var phonenum = $("#ui_phonenum").val();
		var loc = $("#ui_loc").val() + ' ' + $("#ui_loc_d").val();
		var birth = $("#ui_birth").val();
		var img = $("#ui_img").val();
		var grade = $("#ui_grade").val();
		
		var url = "${pageContext.request.contextPath}/persnal/updateProc"
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
			data: JSON.stringify(paramData),
			type: 'POST',
			headers: {
				"Content-Type":"application/json",
			},
			success:
				function(result){
					if(result >= 0){
						alert('회원정보 변경에 성공하였습니다.');
						location.href='${contextPath}';
					}else{
						console.log('정보 변경실패');
					}
				},
			erorr:
				function(data){
				alert("변경된 회원정보 전송 실패.");
			}
		})
				
	} // end of fn_submitRegForm()
	
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
	
	function fn_ncDupCheck(){
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
					$("#dup_button").attr("value", "Y");
					$("#dup_button").attr("hidden", "true");
					$("#dup_success").removeAttr("hidden");
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

