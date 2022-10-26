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
				//FormData 새로운 객체 생성 
				var formData = new FormData();
				var paramData ={
						"bn_num": bn_num,
						"bn_name": bn_name,
						"bn_order": bn_order,
						"bn_url": bn_url,
							"bn_img": bn_img
						
						
				};
				formData.append('file',fileInput.files[0]);
				formData.append('key',new Blob([JSON.stringify(paramData)],{type: "application/json"}));
				var url1 = "${contextPath}/admin/banner/bannerlist";
				$.ajax({
					url: url1,
					type: 'POST',
				    async: false,
					success: function(result){
						if(result.length >= 1){
							$(result).each(function(){
								if(this.bn_order == bn_order){
									orderduplicate(this.bn_order,this.bn_num,bn_order);
									
									
								}
								
								
							});
							
						}
					},
					error: function(result){
						alert("에러");
						}	
					});
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
				
			});
			
			
			
			$(document).on('click','#banneradd',function(){//등록버튼 클릭시
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
				var url = "${contextPath}/admin/banner/bannerlist";
				$.ajax({
					url: url,
					type: 'POST',
				    async: false,
					success: function(result){
						if(result.length >= 1){
							$(result).each(function(){
								if(this.bn_order == bn_order){
									orderduplicate(this.bn_order,this.bn_num,bn_order);
									
									
								}
								
								
							});
							
						}
					},
					error: function(result){
						alert("에러");
						}	
					});
				$.ajax({
					url: url1,
					data: formData,
					contentType: false,               // * 중요 *
				    processData: false,               // * 중요 *
				    enctype : 'multipart/form-data',  // * 중요 *
			
					type:'POST',
					success: function(result){
						alert('등록완');
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
					htmls += '<button id ="updatebanner" onclick="editbanner('+this.bn_num+',\''+this.bn_name+'\', \''+this.bn_order+'\', \''+this.bn_url+'\', \''+this.bn_img+'\')" style = "float:right; font-size: 15px; height: 30px; width: 40px;margin-right: 2px; padding: 0;">수정</button>';
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
	
	
	function editbanner(bn_num,bn_name,bn_order,bn_url,bn_img){//배너수정폼
		var htmls ='';
		var buttonchange = '<button id = "editconfirm" style ="float:right;font-size: 25px; height: 50px; width: 130px; padding: 0;">수정완료</button><button id = "editcancel" style ="float:right; margin-right:3px;font-size: 25px; height: 50px; width: 70px; padding: 0;">취소</button>';
		
		htmls += '<div class="col-4 col-12-medium" id ="bn_num'+bn_num+'" style="overflow: hidden;">';
		htmls += '<section class="box feature">';
		htmls += '<input type ="hidden" value ="'+bn_num+'" id ="bn_num"></input>'
		htmls += '<a class="image featured" style="overflow: hidden; height: 268.66px;"><input style="height:36px;" type="file" id="bn_img" name ="bn_img" onchange="imgthumbnail(this);" ><div style="width:100%;height:100%;"><input id="originalimage" type="hidden" value ="'+bn_img+'"><img id="preview" src ="${contextPath }/resources/images/banner/'+bn_img+'"/></div></a>';
		htmls += '<div class="inner" style="padding-left:5px;padding-right:5px;">';
		htmls += '<header>';
		htmls += '<h4 style ="display:inline">배너제목수정</h4><input type ="text" id="bn_name" value="'+bn_name+'" name="bn_name" style="height:25px; font-size:16px;" required>';
		htmls += '<p style="padding-right:5px;">게시순서:<input type = "number" min="0" value="'+bn_order+'" id="bn_order" name="bn_order" style="height:25px;width:50px" required> 번</p>';
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
				alert("성공");
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
	function orderduplicate(bn_order,bn_num,newbn_order){//게시순서 중복시
		var url = "${contextPath}/admin/banner/bannerlist";
		$.ajax({
			url: url,
			type: 'POST',
		    async: false,
			success: function(result){
				var i = 1;
				$(result).each(function(){
					if(i != newbn_order){
					var url1 = "${contextPath}/admin/banner/reorder";
					var paramData ={
						"bn_num": this.bn_num,
						"bn_order": i
					};
					$.ajax({
						url: url1,
						type: 'POST',
						dataType: 'json',
						data: paramData,
						async: false,
						success: function(result){
							alert("성공");
						},
						error:function(result){
							alert("실패");
							
						}
					});
					i++;
				}else{
					var url1 = "${contextPath}/admin/banner/reorder";
					var dd = Number(newbn_order)+1;
					var paramData ={
						"bn_num": this.bn_num,
						"bn_order": dd
					};
					$.ajax({
						url: url1,
						type: 'POST',
						dataType: 'json',
					    async: false,
						data: paramData,
						success: function(result){
							
						},
						error:function(result){
							
						}
					});
					
					
					i=dd+1;
				}
				});
				
				
			},
			error: function(result){
				alert("게시순서 바꾸기 실패");
			}
		});
	}
	function removeCheck() {//삭제확인

		 if (confirm("정말 삭제하시겠습니까?") == true){    //확인

		     return true;

		 }else{   //취소

		     return false;

		 }

		}
	