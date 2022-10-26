<%@page import="org.springframework.beans.factory.annotation.Autowired"%>
<%@page import="kr.co.pap.services.PersonalService"%>
<%@page import="kr.co.pap.personal.CalVO"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<%@ include file="../include/head.jsp"%>

<body class="sb-nav-fixed">

	<%@ include file="../include/nav_bar.jsp"%>

	<div id="layoutSidenav">

		<%@ include file="../include/layoutSidenav.jsp"%>

		<div id="layoutSidenav_content">
			<main>
<style>
#calendar {
	max-width: 1300px;
   	min-height: 500px;
   	margin: 0 auto;
}
  
  /*요일*/
  .fc-col-header-cell-cushion {
	color: #fff;
  }
  .fc-col-header-cell-cushion:hover {
	text-decoration: none;
	color:#000;
  }
  /*일자*/
  .fc-daygrid-day-number{
	color: #000;
	font-size:1em;
  }
  
  /*종일제목*/
  .fc-event-title.fc-sticky{
    
  }
  /*more버튼*/ 
  .fc-daygrid-more-link.fc-more-link{
	color: #000;
  }
  /*일정시간*/
  .fc-daygrid-event > .fc-event-time{
	color:#000;
  }
  /*시간제목*/
  .fc-daygrid-dot-event > .fc-event-title{
    color:#000 !important;
  }
  /*month/week/day*/
  .fc-button-active{
	border-color: #ffc107 		!important;
	background-color: #ffc107 	!important;
	color: #000 				!important;
	font-weight: bold 			!important;
  }
  /*등록버튼*/
  .btn-success{
  	font-weight: bold;
  }
  /*모달 푸터*/
  .modal-footer{
  	display:inline-block;
  }
</style>
				<p></p>
				<head>
<meta charset='utf-8' />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- fullcalendar CDN -->
<link
	href='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.css'
	rel='stylesheet' />
<script
	src='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.js'></script>
<!-- fullcalendar 언어 CDN -->
<script
	src='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/locales-all.min.js'></script>
	
<!-- 모달 CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>				
				</head>
				<body>
				<div id='calendar'></div>
				
				<!-- insertModal -->
				  <div class="modal fade insertModal" id="myModal">
				    <div class="modal-dialog">
				      <div class="modal-content">
				      
				        <!-- Modal Header -->
				        <div class="modal-header">
				          <h4 class="modal-title">일정 등록</h4>
				          <button type="button" class="close" onclick="initModal('insertModal', g_arg)">&times;</button>
				        </div>
				        
				        <!-- Modal body -->
				        <div class="modal-body">
		  				   <div class="form-group">
							<input type="text" class="form-control" id="ui_id" value="${user.ui_id }" hidden>
		  				   </div>
				          <div class="form-group">
							<label for="title">일정내용:</label>
							<input type="text" class="form-control" id="title">
						  </div>
						  <br>
						  <div class="form-group">
							<label for="start">시작시간:</label>
							<select class="form-control" id="start">
								<option value="09:00">09:00</option>
								<option value="09:30">09:30</option>
								<option value="10:00">10:00</option>
								<option value="10:30">10:30</option>
								<option value="11:00">11:00</option>
								<option value="11:30">11:30</option>
								<option value="12:00">12:00</option>
								<option value="12:30">12:30</option>
								<option value="13:00">13:00</option>
								<option value="13:30">13:30</option>
								<option value="14:00">14:00</option>
								<option value="14:30">14:30</option>
								<option value="15:00">15:00</option>
								<option value="15:30">15:30</option>
								<option value="16:00">16:00</option>
								<option value="16:30">16:30</option>
								<option value="17:00">17:00</option>
								<option value="17:30">17:30</option>
								<option value="18:00">18:00</option>
								<option value="18:30">18:30</option>
								<option value="19:00">19:00</option>
								<option value="19:30">19:30</option>
								<option value="20:00">20:00</option>
								<option value="20:30">20:30</option>
								<option value="21:00">21:00</option>
								<option value="21:30">21:30</option>
								<option value="22:00">22:00</option>
								<option value="22:30">22:30</option>
							</select>
						  </div>
						   <div class="form-group">
							<label for="end">종료시간:</label>
							<select class="form-control" id="end">
								<option value="09:30">09:30</option>
								<option value="10:00">10:00</option>
								<option value="10:30">10:30</option>
								<option value="11:00">11:00</option>
								<option value="11:30">11:30</option>
								<option value="12:00">12:00</option>
								<option value="12:30">12:30</option>
								<option value="13:00">13:00</option>
								<option value="13:30">13:30</option>
								<option value="14:00">14:00</option>
								<option value="14:30">14:30</option>
								<option value="15:00">15:00</option>
								<option value="15:30">15:30</option>
								<option value="16:00">16:00</option>
								<option value="16:30">16:30</option>
								<option value="17:00">17:00</option>
								<option value="17:30">17:30</option>
								<option value="18:00">18:00</option>
								<option value="18:30">18:30</option>
								<option value="19:00">19:00</option>
								<option value="19:30">19:30</option>
								<option value="20:00">20:00</option>
								<option value="20:30">20:30</option>
								<option value="21:00">21:00</option>
								<option value="21:30">21:30</option>
								<option value="22:00">22:00</option>
								<option value="22:30">22:30</option>
								<option value="23:00">23:00</option>
							</select>
						  </div>
		  				  <div class="form-group">
			  				<label for="allDay">종일여부:</label>
			  			  <div class="form-check">
							<label class="form-check-label">
					      <input type="radio" class="form-check-input" value="true" name="allDay">예
							</label>
			  			  </div>
			  			  <div class="form-check">
							<label class="form-check-label">
								<input type="radio" checked="checked" class="form-check-input" value="false" name="allDay">아니오
							</label>
						  </div>
						</div>
			        </div>
        <!-- Modal footer -->
        <div class="modal-footer">
		  <button type="button" class="btn btn-success insertBtn" onclick="insertMod('insertModal', g_arg)">등록</button>
        </div>
        
      </div>
    </div>
  </div>
					<script>
			      document.addEventListener('DOMContentLoaded', function() {
			    	  
			    	  $(function () {
			                var request = $.ajax({
			                    url: "${contextPath}/cal/main2?ui_id=${user.ui_id}", // 변경하기
			                    method: "GET",
			                    dataType: "json"
			                });
			     request.done(function (data) {
			    	 console.log(data);
			        var calendarEl = document.getElementById('calendar');
			        var calendar = new FullCalendar.Calendar(calendarEl, {
			          initialView: 'dayGridMonth',
			          navLinks: true,
			          locale:'ko',
			          timeZone: 'Asia/Seoul',
			          titleFormat : 'YYYY-MM-DD',
			          selectable: true,
			          selectMirror: true,
			          
			          headerToolbar: {
                          left: 'prev,next today',
                          center: 'title',
                          right: 'dayGridMonth,dayGridWeek'
                      },
                    editable: true,
                    dayMaxEvents: true,
                      titleFormat : function(date) { // title 설정
                    	  return date.date.year +"년 "+(date.date.month +1)+"월"; 
                   	},
                   	select: function(arg) {
                   		insertModalOpen(arg);
                   		calendar.refetchEvents();
                   },
                      
                      eventClick: function(arg) {
                    	  console.log(arg.event.id);
                        if (confirm("'" + arg.event.title + "' 일정을 삭제하시겠습니까?'")) {
                        	if(confirm("복구할 수 없습니다. 진행하시겠습니까?")){
                        		
                         $.ajax({
	                      	url:'${contextPath}/cal/delete',
	                        method:"GET",
	                        dataType:'json',
	                        data: {
	                        	"cd_id": arg.event.id
	                        },
	                        success:function(res){
	                        	alert('삭제되었습니다');
                          		arg.event.remove()
	                        },
	                        error:function(res){
	                        	alert('서버 오류로 삭제 실패. 다시 시도하세요');
	                  		}
                      	})
                       }
                     }
                  },
	                  eventChange: function(arg){
	                    if(arg.event.end == null){
	                    	var end = new Date();
	                    		end.setDate(arg.event.start.getDate()+1);
	                    		arg.event.setEnd(end);	
	                    	}
	                    },
	                    eventDrop: function(arg){
	              		  insertModalOpen(arg);
	              		  calendar.refetchEvents();//옮길때
	              	  },
	              	  eventResize: function(arg){
	              		  insertModalOpen(arg);	
	              		  calendar.refetchEvents();//일정사이즈 조절할때
	              	  },
                   
                      events: data,
                      editable: true,
                      dayMaxEvents: true,
                      
			      });
			        calendar.render();
			    });
			     
			});			     
		});	
			    
			   //month 한자릿수면 앞에 0추가
			    function stringFormat(p_val){
			    	if(p_val < 10)
			    		return p_val = '0'+p_val;
			    	else
			    		return p_val;
			    }
			   //모달초기화
			     function initModal(modal, arg){
			   		$('.'+modal+' #title').val('');
			   		$('.'+modal+' #start').val('');
			   		$('.'+modal+' #end').val('');
				   	$('.'+modal+' #allDay').val('0');
				   	$('.'+modal+' input[name="allDay"]').val(['false']);
				   	$('.'+modal).modal('hide');
			   		arge = null;
			     }
			     
			   //모달창
			     function insertModalOpen(arg){
			    	 g_arg = arg;
			    		//값이 있는경우 세팅
			    		if(g_arg.event != undefined){
			    			$('.insertModal #ui_id').val(g_arg.event.extendedProps.ui_id);
			    			$('.insertModal #title').val(g_arg.event.title);
			    			$('.insertModal #start').val(stringFormat(g_arg.event.start.getHours())+':'+stringFormat(g_arg.event.start.getMinutes()));
			    			$('.insertModal #end').val(stringFormat(g_arg.event.end.getHours())+':'+stringFormat(g_arg.event.end.getMinutes()));
			    			$('.insertModal input[name="allDay"]').val([g_arg.event.allDay]);
			    			
			    			//month 외 week, day는 시간 값까지 받아와서 값 바인딩 ex)09:00
			    			if(g_arg.startStr.length > 10){
			    				$('.insertModal #start').val(g_arg.startStr.substr(11, 5));
			    				$('.insertModal #end').val(g_arg.endStr.substr(11, 5));
			    			}
			    		}
			    		
			    		//모달창 show
			    		$('.insertModal').modal('show');
			    		console.log(g_arg);
			    		$('.insertModal #title').focus();
			    	  }
			    	 
			   //일정추가
			   	 function insertMod(modal, arg){
			   
			 		var paramData;
			 		
			 		if($('.'+modal+' #title').val()==''){
			 			alert("일정 내용을 입력하세요");
			 			$('.'+modal+' #title').focus();
			 			return;
			 		}else if($('.'+modal+' #title').val().length > 50){
			 			alert("일정 내용은 50자 이내로 입력하세요");
			 			$('.'+modal+' #title').focus();
			 			return;
			 		}
			 		
			 		//구간이벤트면
			 		if($('.insertModal input[name="allDay"]:checked').val()!='true'){
			 			console.log($('.'+modal+'#ui_id').val());
			 			var m_start = new Date(arg.startStr.substr(0, 4), arg.startStr.substr(5, 2)-1, arg.startStr.substr(8, 2));
			 			var m_end = new Date(arg.endStr.substr(0, 4), arg.endStr.substr(5, 2)-1, arg.endStr.substr(8, 2));
			 			var m_month = m_end.getMonth()+1;
			 			//week나 day에서 추가할때(시간 존재)
			 			if(arg.endStr.length > 10){
			 				m_end.setDate(m_end.getDate());
			 				//month에선 2021.09.30 클릭 시 endstr이 2021.10.01로 잡히기 떄문에 일-1
			 			}else{
			 				m_end.setDate(m_end.getDate()-1);	
			 			}
			 			
			 			//말일에 대한 로직
			 			var m_end_com = new Date(arg.endStr.substr(0, 4), arg.endStr.substr(5, 2)-1, arg.endStr.substr(8, 2));
			 			var m_first = new Date(m_end.getFullYear(),  m_end.getMonth()+1, 1);
			 			if(m_end_com.getFullYear()+''+stringFormat(m_end_com.getMonth())+''+stringFormat(m_end_com.getDate())
			 					== m_first.getFullYear()+''+stringFormat(m_first.getMonth())+''+stringFormat(m_first.getDate())){
			 				m_month = m_end.getMonth()+1;
			 			}
			 							
			 			var m_date = m_end.getDate();
			 			arg.endStr = m_end.getFullYear() + '-' + stringFormat(m_month) + '-' + stringFormat(m_date);
			 			
			 			if(arg.startStr.length > 10){
			 				//일자만 추출
			 				arg.startStr = arg.startStr.substr(0, 10);
			 			}
			 			
			 			paramData = { 
			 			  		ui_id : $('.'+modal+' #ui_id').val(),
			 			  		cd_title : $('.'+modal+' #title').val(),
			 			  		cd_start : arg.startStr+'T'+$('.'+modal+' #start').val(),
			 			  		cd_end : arg.endStr+'T'+$('.'+modal+' #end').val(),
			 			  		cd_allday : $('.'+modal+' input[name="allDay"]:checked').val()				  		
			 			  	}
			 			
			 			if($('.insertModal input[name="allDay"]:checked').val()!='true'){
				 			  if(arg.startStr.substring(0, 10) == arg.endStr.substring(0, 10)){
				 				  if($('.insertModal #end').val() <= $('.insertModal #start').val()){
				 					  alert('종료시간을 시작시간보다 크게 선택해주세요');
				 					  $('.insertModal #end').focus();
				 					  return;
				 				  }
				 		  		}
				 			}
			 			//종일이벤트면
			 		}else{
			 			console.log($('.'+modal+'#ui_id').val());
			 			if(arg.startStr.length > 10){
			 				//일자만 추출
			 				arg.startStr = arg.startStr.substr(0, 10);
			 			}
			 			if(arg.endStr.length > 10){
			 				var m_end = new Date(arg.endStr.substr(0, 4), arg.endStr.substr(5, 2)-1, arg.endStr.substr(8, 2));
			 				//종일이기에 일+1 (시간은 어차피 00:00)
			 				m_end.setDate(m_end.getDate()+1);
			 				arg.endStr = m_end.getFullYear()+'-'+ stringFormat(m_end.getMonth()+1)+'-'+ stringFormat(m_end.getDate());
			 			}
			 			
			 			paramData = {
			 					ui_id : $('.'+modal+'#ui_id').val(),
			 			  		cd_title : $('.'+modal+' #title').val(),
			 			  		cd_start : arg.startStr+'T00:00',
			 			  		cd_end : arg.endStr+'T00:00',
			 			  		cd_allday : $('.'+modal+' input[name="allDay"]:checked').val()			  		
			 			  	}
			 		}
			 		//DB 삽입	
			 		$.ajax({
			 		  url: "insert",
			 		  type: "POST",
			 		  data: paramData,
			 		  dataType: 'json',
			 		  success : function(data,status,xhr){
			 			 	alert("일정 등록 성공")
						 	initModal(modal, arg);
			 			 	location.href="main?ui_id=${user.ui_id}";
			 		  },
			 		  error : function(xhr, status, error){
			 			    //alert(xhr.responseText);
			 			  alert('서버 오류로 등록 실패! 새로고침 후 재시도 해주세요');
			 		  }
			 		});
			 		//
			 	}
			   
			    </script>

</body>
</main>
			<%@ include file="../include/footer.jsp"%>
		</div>
	</div>
	<%@ include file="../include/plugin.jsp"%>
</html>