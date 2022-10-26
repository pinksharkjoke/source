<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<%@ include file="../../include/head.jsp"%>




<body class="sb-nav-fixed">
<script>
	$(document).ready(function(){
			
			bannerlist();
			
			$(document).on('click','#editcancel',function(){
				var buttonchange = '<button id = "banneradd" style ="float:right;font-size: 25px; height: 50px; width: 70px; padding: 0;">등록</button>';
				$("#bn_name").val('');
				$("#bn_order").val('');
				$("#bn_url").val('');
				$("#editcancel").remove();
				$("#editconfirm").replaceWith(buttonchange);
				bannerlist();
				
				
			});
			
			
			$(document).on('click','#editconfirm',function(){
				var fileInput = document.querySelector("#bn_img");
				
				
				var buttonchange = '<button id = "banneradd" style ="float:right;font-size: 25px; height: 50px; width: 70px; padding: 0;">등록</button>';
				var url = '${contextPath}/admin/banner/bannerupdate';
				var bn_order = $("#bn_order").val();
				var bn_url = $("#bn_url").val();
				var bn_name = $("#bn_name").val();
				var bn_num = $("#bn_num").val();
				var bn_img = $("#originalimage").val();
				var bannerlength = $("#bannerlength").val();
				//FormData 새로운 객체 생성 
				var formData = new FormData();
				var paramData ={
						"bn_num": bn_num,
						"bn_name": bn_name,
						"bn_order": bn_order,
						"bn_url": bn_url,
						"bn_img": bn_img,
						
						
				};
				formData.append('file',fileInput.files[0]);
				formData.append('key',new Blob([JSON.stringify(paramData)],{type: "application/json"}));
				if((0<bn_order && bn_order<bannerlength+1)){
					
				$.ajax({
					url: url,
					data: formData,
					contentType: false,               // * 중요 *
				    processData: false,               // * 중요 *
				    enctype : 'multipart/form-data',  // * 중요 *
					type:'POST',
					success: function(result){
						$("#bn_name").val('');
						$("#bn_order").val('');
						$("#bn_url").val('');
						$("#editcancel").remove();
						$("#editconfirm").replaceWith(buttonchange);
						bannerlist();
					},
					error: function(result){
						alert('에러발생');
					}
					
					
					
				});
				}else{
					alert("게시순서는 1에서 "+bannerlength+"까지의 숫자만입력하세요");
				}
			});
			
			
			
			$(document).on('click','#banneradd',function(){//배너등록 폼
				var htmls = '';
				var buttonchange = '<button id = "addconfirm" style ="float:right;font-size: 25px; height: 50px; width: 130px; padding: 0;">등록확인</button><button id = "addcancel" style ="float:right; margin-right:3px;font-size: 25px; height: 50px; width: 70px; padding: 0;">취소</button>';
				
				
				//배너등록폼 html
					htmls += '<div class="col-4 col-12-medium" id ="addbannerform" style="overflow: hidden;">';
					htmls += '<section class="box feature">';
					htmls += '<a class="image featured" style="overflow: hidden; height: 268.66px;"><input style="height:36px;" type="file" id="bn_img" name ="bn_img" onchange="imgthumbnail(this);" ><div style="width:100%;height:100%;"><img id="preview"/></div></a>';
					htmls += '<div class="inner" style="padding-left:5px;padding-right:5px;">';
					htmls += '<header>';
					htmls += '<h4 style ="display:inline">배너제목</h4><input type ="text" id="bn_name" name="bn_name" style="height:25px; font-size:16px;" required>';
					htmls += '<p style="padding-right:5px;">게시순서:<input type = "number" min="0" id="bn_order" name="bn_order" style="height:25px;width:50px" required> 번</p>';
					htmls += '<p style="font-size: 15px;">배너 링크:<input type="text" id="bn_url" name="bn_url" style="height:25px;"/></p>';
					htmls += '</header>';
					htmls += '</div>';
					htmls += '</section>';
					htmls += '</div>';
				
				$("#bannerlist").append(htmls);
				$("#banneradd").replaceWith(buttonchange);
			});//end of $(document).on(banneradd
				$(document).on('click','#addconfirm',function(){//배너등록
				var fileInput = document.querySelector("#bn_img");
				var buttonchange = '<button id = "banneradd" style ="float:right;font-size: 25px; height: 50px; width: 70px; padding: 0;">등록</button>';
				var url1 = '${contextPath}/admin/banner/banneradd';
				var bn_order = $("#bn_order").val();
				var bn_url = $("#bn_url").val();
				var bn_name = $("#bn_name").val();
				//FormData 새로운 객체 생성 
				var formData = new FormData();
				// 넘길 데이터를 담아준다. 
				var paramData ={
						"bn_name": bn_name,
						"bn_order": bn_order,
						"bn_url": bn_url
						
				};
				formData.append('file',fileInput.files[0]);
				formData.append('key',new Blob([JSON.stringify(paramData)],{type: "application/json"}));
			
				$.ajax({
					url: url1,
					data: formData,
					contentType: false,               // * 중요 *
				    processData: false,               // * 중요 *
				    enctype : 'multipart/form-data',  // * 중요 *
			
					type:'POST',
					success: function(result){
						$("#bn_name").val('');
						$("#bn_order").val('');
						$("#bn_url").val('');
						$("#addcancel").remove();
						$("#adding").remove();
						$("#addconfirm").replaceWith(buttonchange);
						bannerlist();
					},
					error: function(result){
						alert('에러발생');
					}
					
					
					
				});
				
				});
				$(document).on('click','#addcancel',function(){//배너등록 취소
					var buttonchange = '<button id = "banneradd" style ="float:right;font-size: 25px; height: 50px; width: 70px; padding: 0;">등록</button>';
					
					$("#bn_name").val('');
					$("#bn_order").val('');
					$("#bn_url").val('');
					$("#bn_img").val('');
					$("#addbannerform").remove();
					$("#addcancel").remove();
					$("#adding").remove();
					$("#addconfirm").replaceWith(buttonchange);
				});
	});//end of document.ready
	
	
	function bannerlist(){
		var url = "${contextPath}/admin/banner/bannerlist";
		$.ajax({
			url: url,
			type: 'POST',
			async:false,
			success: function(result){
				var htmls = "";
				if(result.length < 1){
					htmls += '<h3>배너가 없습니다.</h3>';
				}else{
					$(result).each(function(){
					htmls += '<div class="col-4 col-12-medium" id ="bn_num'+this.bn_num+'" style="overflow: hidden;">';
					htmls += '<section class="box feature">';
					htmls += '<a class="image featured" style="overflow: hidden;height:228.88px;"><img src="${contextPath }/resources/images/banner/'+this.bn_img+'" style="width:100%;height:auto;" /></a>';
					htmls += '<div class="inner" style="padding-left:5px;padding-right:5px;">';
					htmls += '<header>';
					htmls += '<h2>'+this.bn_name+'</h2>';
					htmls += '<button id="delbanner" name="delbanner" onclick="delbanner('+this.bn_num+',\''+this.bn_img+'\')" style = "float:right; font-size: 15px; height: 30px; width: 40px; margin-left:2px; padding: 0;">삭제</button>';
					htmls += '<button id ="updatebanner" onclick="editbanner('+this.bn_num+',\''+this.bn_name+'\', \''+this.bn_order+'\', \''+this.bn_url+'\', \''+this.bn_img+'\', \''+result.length+'\')" style = "float:right; font-size: 15px; height: 30px; width: 40px;margin-right: 2px; padding: 0;">수정</button>';
					htmls += '<p style="padding-right:5px;">게시순서: '+this.bn_order+'번</p>';
					htmls += '<p style="font-size: 15px;">배너 링크'+this.bn_url+'</p>';
					htmls += '</header>';
					htmls += '</div>';
					htmls += '</section>';
					htmls += '</div>';
						
						
					});//$result.eache end
					
				}
				$("#bannerlist").html(htmls);
			},
			error: function(result){
				alert('실패');
			}
			
			
			
		});
		
		
	}//end of bannerlist
	
	function imgthumbnail(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				document.getElementById('preview').src = e.target.result;
			};
			reader.readAsDataURL(input.files[0]);
			
		} else {
			document.getElementById('preview').src = "";
		}
	}
	
	
	function editbanner(bn_num,bn_name,bn_order,bn_url,bn_img,bannerlength){//배너수정폼
		var htmls ='';
		var buttonchange = '<button id = "editconfirm" style ="float:right;font-size: 25px; height: 50px; width: 130px; padding: 0;">수정완료</button><button id = "editcancel" style ="float:right; margin-right:3px;font-size: 25px; height: 50px; width: 70px; padding: 0;">취소</button>';
		
		htmls += '<div class="col-4 col-12-medium" id ="bn_num'+bn_num+'" style="overflow: hidden;">';
		htmls += '<section class="box feature">';
		htmls += '<input type ="hidden" value ="'+bn_num+'" id ="bn_num"></input>'
		htmls += '<a class="image featured" style="overflow: hidden; height: 268.66px;"><input style="height:36px;" type="file" id="bn_img" name ="bn_img" onchange="imgthumbnail(this);" ><div style="width:100%;height:100%;"><input id="originalimage" type="hidden" value ="'+bn_img+'"><img id="preview" src ="${contextPath }/resources/images/banner/'+bn_img+'"/></div></a>';
		htmls += '<div class="inner" style="padding-left:5px;padding-right:5px;">';
		htmls += '<header>';
		htmls += '<h4 style ="display:inline">배너제목수정</h4><input type ="text" id="bn_name" value="'+bn_name+'" name="bn_name" style="height:25px; font-size:16px;" required>';
		htmls += '<input type = "hidden" value = "'+bannerlength+'" id = "bannerlength"></input>';
		htmls += '<input type = "hidden" value = "'+bn_order+'" id = "originbn_order"></input>';
		htmls += '<p style="padding-right:5px;">게시순서:<input type = "number" min="1" max="'+bannerlength+ '" value="'+bn_order+'" id="bn_order" name="bn_order" style="height:25px;width:50px" required> 번</p>';
		htmls += '<p style="font-size: 15px;">배너 링크:<input type="text" id="bn_url" value="'+bn_url+'" name="bn_url" style="height:25px;"/></p>';
		htmls += '</header>';
		htmls += '</div>';
		htmls += '</section>';
		htmls += '</div>';
		
		

		$("#banneradd").replaceWith(buttonchange);
		$('#bn_num'+bn_num).replaceWith(htmls);
	}
	function delbanner(bn_num,bn_img){
		if(removeCheck()==true){
			
		
		var url ="${contextPath}/admin/banner/bannerdelete";
		var paramData={
				"bn_num" : bn_num,
				"bn_img" : bn_img
		};
		$.ajax({
			url: url,
			data: paramData,
			type:'POST',
			dataType: 'json',
			success:function(result){
				bannerlist();
			},
			error:function(result){
				alert("실패");
			}
			
			
		});
		}else{
			alert("삭제취소");
		}
	}
	
		
	function removeCheck() {//삭제확인

		 if (confirm("정말 삭제하시겠습니까?") == true){    //확인

		     return true;

		 }else{   //취소

		     return false;

		 }

		}
	
</script>
	<%@ include file="../../include/nav_bar.jsp"%>

	<div id="layoutSidenav">

		<%@ include file="../../include/layoutSidenav.jsp"%>
	
		<div id="layoutSidenav_content">
			<main>
			<link rel="stylesheet" href="${contextPath }/resources/assets/css/bannerlist.css" />
	<div id="features-wrapper">
					<div class="container">
						<div class="row" id ="bannerlist" >
							
       <!--        <c:forEach var="list" items="${list }" > -->
							
						<!--  	</c:forEach> -->
						</div>
						<button id="banneradd" style ="float:right;font-size: 25px; height: 50px; width: 70px; padding: 0;">등록</button>
					</div>
				</div>
			</main>
			<%@ include file="../../include/footer.jsp"%>
		</div>
	</div>
	<%@ include file="../../include/plugin.jsp"%>
</body>
</html>