<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
<%@ include file="../include/head.jsp"%>

<style>
.note-num {
    position: absolute;
    top: 0;
    right: 0;
    z-index: 3;
    height: 20px;
    width: 20px;
    line-height: 20px;
    text-align: center;
    background-color: red;
    border-radius: 15px;
    display: inline-block;
}

#notification {
    position: relative;
}

</style>
<body class="sb-nav-fixed">
	<script>
	
	
	
	$(document).ready(function(){//처음 관리자페이지들어갈때 보여줄 차트
		var url1 = "${contextPath}/admin/joinyear";
		var url2 = "${contextPath}/admin/loginyear";
		var joinchart = document.getElementById("joinstatyear").getContext("2d");
		var loginchart = document.getElementById("loginstatyear").getContext("2d");
		var currentday = new Date();
		var currentyear = currentday.getFullYear();
		var loginchartdatayear = {
				type: "bar",
				
				data: {
					labels:[//x축 데이터
						
					currentyear-9,
					currentyear-8,
					currentyear-7,
					currentyear-6,
					currentyear-5,
					currentyear-4,
					currentyear-3,
					currentyear-2,
					currentyear-1,
					currentyear
					],
				datasets:[
					{
						label: "로그인 회원수",//차트이름?
						backgroundColor: "rgba(54, 162, 235, 0.2)",
						borderColor : 'rgba(54, 162, 235, 1)',
						borderWidth: 1,
						data: [//y축 데이터
							
						]	
					},
				],
				},
				options : {
					onClick: function(point,event){
						if(event.length <= 0)
							{console.log("데이터없음."); return;}
						joinmonth(currentyear-(9-event[0]['_index']));
					}
					
				}
			};
		var joinchartdatayear = {
				type: "bar",
				
				data: {
					labels:[//x축 데이터
						
					currentyear-9,
					currentyear-8,
					currentyear-7,
					currentyear-6,
					currentyear-5,
					currentyear-4,
					currentyear-3,
					currentyear-2,
					currentyear-1,
					currentyear
					],
				datasets:[
					{
						label: "회원가입 횟수",//차트이름?
						backgroundColor: "rgba(54, 162, 235, 0.2)",
						borderColor : 'rgba(54, 162, 235, 1)',
						borderWidth: 1,
						data: [//y축 데이터
							
						]	
					},
				],
				},
				options : {
					onClick: {
						
					}
					
				}
			};
		$.ajax({//연도별회원가입그래프
			url: url1,
			type: 'POST',
			data: {"date": currentday},
			dataType: 'json',
			async:false,
			success: function(result){
				var dataset = joinchartdatayear.data.datasets;
				
				for(var i=0;i<dataset.length;i++){
					
					var data = dataset[i].data;
					for(var j=0; j<10;j++){
						data[j] = result[9-j];
					}
				}
				joinchart = new Chart(joinchart,joinchartdatayear);
				joinchartdatayear.options.onClick = function(point,event){
					if(event.length <= 0)
					{console.log("데이터없음."); return;}
				joinmonth(currentyear-(9-event[0]['_index']),joinchart);
				};
			joinchart.update();
			},
			error: function(result){
				alert('에러');
			}
		});
		$.ajax({//연도별로그인그래프
			url: url2,
			type: 'POST',
			data: {"date": currentday},
			dataType: 'json',
			async:false,
			success: function(result){
				var dataset = loginchartdatayear.data.datasets;
				for(var i=0;i<dataset.length;i++){
					
					var data = dataset[i].data;
					for(var j=0; j<10;j++){
						data[j] = result[9-j];
					}
				}
				loginchart = new Chart(loginchart,loginchartdatayear)
				loginchartdatayear.options.onClick = function(point,event){
					if(event.length <= 0)
					{console.log("데이터없음."); return;}
				loginmonth(currentyear-(9-event[0]['_index']),loginchart);
				};
				loginchart.update();
				
			},
			error: function(result){
				alert('에러');
			}
		});
		
		
		
	});
	function joinmonth (year,joinchart){//월별 회원가입조회
		var url = "${contextPath}/admin/joinmonth";
		
		$.ajax({
			url: url,
			type: 'POST',
			data: {"date": year},
			dataType: 'json',
			async:false,
			success: function(result){
				 joinchart.data.labels = [year+"년 1월", year+"년 2월", year+"년 3월", year+"년 4월", year+"년 5월", year+"년 6월",year+"년 7월",year+"년 8월",year+"년 9월",year+"년 10월",year+"년 11월",year+"년 12월"];
				 joinchart.data.datasets[0].data = [result[0], result[1], result[2], result[3], result[4], result[5],result[6],result[7],result[8],result[9],result[10],result[11]];
				 joinchart.options.onClick = function(point,event){
					 if(event.length <= 0)
						{console.log("데이터없음."); return;}
					 joinday(year,event[0]['_index']+1,joinchart);
					 console.log(event[0]['_index']);
				 };
				 joinchart.update();
			},
			error: function(result){
				alert('에러');
			}
		});
		
		
		
	};
	function loginmonth (year,loginchart){//월별 로그인조회
		var url = "${contextPath}/admin/loginmonth";
		
		$.ajax({
			url: url,
			type: 'POST',
			data: {"date": year},
			dataType: 'json',
			async:false,
			success: function(result){
				 loginchart.data.labels = [year+"년 1월", year+"년 2월", year+"년 3월", year+"년 4월", year+"년 5월", year+"년 6월",year+"년 7월",year+"년 8월",year+"년 9월",year+"년 10월",year+"년 11월",year+"년 12월"];
				 loginchart.data.datasets[0].data = [result[0], result[1], result[2], result[3], result[4], result[5],result[6],result[7],result[8],result[9],result[10],result[11]];
				 loginchart.options.onClick = function(point,event){
					 if(event.length <= 0)
						{console.log("데이터없음."); return;}
					 loginday(year,event[0]['_index']+1,loginchart);
					 console.log(event[0]['_index']);
				 };
				 loginchart.update();
			},
			error: function(result){
				alert('에러');
			}
		});
		
		
		
	};
	function joinday (year,month,joinchart){//일별회원가입조회
		var url = "${contextPath}/admin/joinday";
		var ff;
		if(month<10){
			ff="-0";
		}else{
			ff="-";
		}
		
		
		var date = new Date(year+ff+month);
		$.ajax({
			url: url,
			type: 'POST',
			data: {"date": date},
			dataType: 'json',
			async:false,
			success: function(result){
				if(month == 1||month == 3||month == 5||month == 7||month == 8||month == 10||month == 12){
					
				 joinchart.data.labels = [year+"년"+month+"월 1일",year+"년"+month+"월 2일", year+"년"+month+"월 3일", year+"년"+month+"월 4일", year+"년"+month+"월 5일",
					 year+"년"+month+"월 6일",year+"년"+month+"월 7일",year+"년"+month+"월 8일",year+"년"+month+"월 9일",year+"년"+month+"월 10일",year+"년"+month+"월 11일",year+"년"+month+"월 12일",
					 year+"년"+month+"월 13일",year+"년"+month+"월 14일",year+"년"+month+"월 15일",year+"년"+month+"월 16일",year+"년"+month+"월 17일",year+"년"+month+"월 18일",year+"년"+month+"월 19일",
					 year+"년"+month+"월 20일",year+"년"+month+"월 21일",year+"년"+month+"월 22일",year+"년"+month+"월 23일",year+"년"+month+"월 24일",year+"년"+month+"월 25일",year+"년"+month+"월 26일",
					 year+"년"+month+"월 27일",year+"년"+month+"월 28일",year+"년"+month+"월 29일",year+"년"+month+"월 30일",year+"년"+month+"월 31일"];
				}else if(month == 4||month==6||month==9||month==11){
					 joinchart.data.labels = [year+"년"+month+"월 1일",year+"년"+month+"월 2일", year+"년"+month+"월 3일", year+"년"+month+"월 4일", year+"년"+month+"월 5일",
						 year+"년"+month+"월 6일",year+"년"+month+"월 7일",year+"년"+month+"월 8일",year+"년"+month+"월 9일",year+"년"+month+"월 10일",year+"년"+month+"월 11일",year+"년"+month+"월 12일",
						 year+"년"+month+"월 13일",year+"년"+month+"월 14일",year+"년"+month+"월 15일",year+"년"+month+"월 16일",year+"년"+month+"월 17일",year+"년"+month+"월 18일",year+"년"+month+"월 19일",
						 year+"년"+month+"월 20일",year+"년"+month+"월 21일",year+"년"+month+"월 22일",year+"년"+month+"월 23일",year+"년"+month+"월 24일",year+"년"+month+"월 25일",year+"년"+month+"월 26일",
						 year+"년"+month+"월 27일",year+"년"+month+"월 28일",year+"년"+month+"월 29일",year+"년"+month+"월 30일"];
					
				}
				else if(month==2&&(year%4==0 && year%100!=0 || year%400==0)){
					joinchart.data.labels = [year+"년"+month+"월 1일",year+"년"+month+"월 2일", year+"년"+month+"월 3일", year+"년"+month+"월 4일", year+"년"+month+"월 5일",
						 year+"년"+month+"월 6일",year+"년"+month+"월 7일",year+"년"+month+"월 8일",year+"년"+month+"월 9일",year+"년"+month+"월 10일",year+"년"+month+"월 11일",year+"년"+month+"월 12일",
						 year+"년"+month+"월 13일",year+"년"+month+"월 14일",year+"년"+month+"월 15일",year+"년"+month+"월 16일",year+"년"+month+"월 17일",year+"년"+month+"월 18일",year+"년"+month+"월 19일",
						 year+"년"+month+"월 20일",year+"년"+month+"월 21일",year+"년"+month+"월 22일",year+"년"+month+"월 23일",year+"년"+month+"월 24일",year+"년"+month+"월 25일",year+"년"+month+"월 26일",
						 year+"년"+month+"월 27일",year+"년"+month+"월 28일",year+"년"+month+"월 29일"];
				}
				else if(month==2){
					 joinchart.data.labels = [year+"년"+month+"월 1일",year+"년"+month+"월 2일", year+"년"+month+"월 3일", year+"년"+month+"월 4일", year+"년"+month+"월 5일",
						 year+"년"+month+"월 6일",year+"년"+month+"월 7일",year+"년"+month+"월 8일",year+"년"+month+"월 9일",year+"년"+month+"월 10일",year+"년"+month+"월 11일",year+"년"+month+"월 12일",
						 year+"년"+month+"월 13일",year+"년"+month+"월 14일",year+"년"+month+"월 15일",year+"년"+month+"월 16일",year+"년"+month+"월 17일",year+"년"+month+"월 18일",year+"년"+month+"월 19일",
						 year+"년"+month+"월 20일",year+"년"+month+"월 21일",year+"년"+month+"월 22일",year+"년"+month+"월 23일",year+"년"+month+"월 24일",year+"년"+month+"월 25일",year+"년"+month+"월 26일",
						 year+"년"+month+"월 27일",year+"년"+month+"월 28일"];
					
				}
				 joinchart.data.datasets[0].data = [result[0], result[1], result[2], result[3], result[4], result[5],result[6],result[7],result[8],result[9],result[10],result[11],result[12],result[13],result[14],result[15],result[16],result[17],result[18],result[19],result[20],result[21],result[22],result[23],result[24],result[25],result[26],result[27],result[28],result[29],result[30]];
				 joinchart.options.onClick = function(point,event){
					 if(event.length <= 0)
						{console.log("데이터없음."); return;}
					 joinyear(joinchart);
				 };
				 joinchart.update();
			},
			error: function(result){
				alert('에러');
			}
		});
		
		
		
	};
	function loginday (year,month,loginchart){//일별로그인조회
		var url = "${contextPath}/admin/loginday";
		var ff;
		if(month<10){
			ff="-0";
		}else{
			ff="-";
		}
		
		
		var date = new Date(year+ff+month);
		$.ajax({
			url: url,
			type: 'POST',
			data: {"date": date},
			dataType: 'json',
			async:false,
			success: function(result){
				if(month == 1||month == 3||month == 5||month == 7||month == 8||month == 10||month == 12){
					
				 loginchart.data.labels = [year+"년"+month+"월 1일",year+"년"+month+"월 2일", year+"년"+month+"월 3일", year+"년"+month+"월 4일", year+"년"+month+"월 5일",
					 year+"년"+month+"월 6일",year+"년"+month+"월 7일",year+"년"+month+"월 8일",year+"년"+month+"월 9일",year+"년"+month+"월 10일",year+"년"+month+"월 11일",year+"년"+month+"월 12일",
					 year+"년"+month+"월 13일",year+"년"+month+"월 14일",year+"년"+month+"월 15일",year+"년"+month+"월 16일",year+"년"+month+"월 17일",year+"년"+month+"월 18일",year+"년"+month+"월 19일",
					 year+"년"+month+"월 20일",year+"년"+month+"월 21일",year+"년"+month+"월 22일",year+"년"+month+"월 23일",year+"년"+month+"월 24일",year+"년"+month+"월 25일",year+"년"+month+"월 26일",
					 year+"년"+month+"월 27일",year+"년"+month+"월 28일",year+"년"+month+"월 29일",year+"년"+month+"월 30일",year+"년"+month+"월 31일"];
				}else if(month == 4||month==6||month==9||month==11){
					 loginchart.data.labels = [year+"년"+month+"월 1일",year+"년"+month+"월 2일", year+"년"+month+"월 3일", year+"년"+month+"월 4일", year+"년"+month+"월 5일",
						 year+"년"+month+"월 6일",year+"년"+month+"월 7일",year+"년"+month+"월 8일",year+"년"+month+"월 9일",year+"년"+month+"월 10일",year+"년"+month+"월 11일",year+"년"+month+"월 12일",
						 year+"년"+month+"월 13일",year+"년"+month+"월 14일",year+"년"+month+"월 15일",year+"년"+month+"월 16일",year+"년"+month+"월 17일",year+"년"+month+"월 18일",year+"년"+month+"월 19일",
						 year+"년"+month+"월 20일",year+"년"+month+"월 21일",year+"년"+month+"월 22일",year+"년"+month+"월 23일",year+"년"+month+"월 24일",year+"년"+month+"월 25일",year+"년"+month+"월 26일",
						 year+"년"+month+"월 27일",year+"년"+month+"월 28일",year+"년"+month+"월 29일",year+"년"+month+"월 30일"];
					
				}
				else if(month==2&&(year%4==0 && year%100!=0 || year%400==0)){
					loginchart.data.labels = [year+"년"+month+"월 1일",year+"년"+month+"월 2일", year+"년"+month+"월 3일", year+"년"+month+"월 4일", year+"년"+month+"월 5일",
						 year+"년"+month+"월 6일",year+"년"+month+"월 7일",year+"년"+month+"월 8일",year+"년"+month+"월 9일",year+"년"+month+"월 10일",year+"년"+month+"월 11일",year+"년"+month+"월 12일",
						 year+"년"+month+"월 13일",year+"년"+month+"월 14일",year+"년"+month+"월 15일",year+"년"+month+"월 16일",year+"년"+month+"월 17일",year+"년"+month+"월 18일",year+"년"+month+"월 19일",
						 year+"년"+month+"월 20일",year+"년"+month+"월 21일",year+"년"+month+"월 22일",year+"년"+month+"월 23일",year+"년"+month+"월 24일",year+"년"+month+"월 25일",year+"년"+month+"월 26일",
						 year+"년"+month+"월 27일",year+"년"+month+"월 28일",year+"년"+month+"월 29일"];
				}
				else if(month==2){
					 loginchart.data.labels = [year+"년"+month+"월 1일",year+"년"+month+"월 2일", year+"년"+month+"월 3일", year+"년"+month+"월 4일", year+"년"+month+"월 5일",
						 year+"년"+month+"월 6일",year+"년"+month+"월 7일",year+"년"+month+"월 8일",year+"년"+month+"월 9일",year+"년"+month+"월 10일",year+"년"+month+"월 11일",year+"년"+month+"월 12일",
						 year+"년"+month+"월 13일",year+"년"+month+"월 14일",year+"년"+month+"월 15일",year+"년"+month+"월 16일",year+"년"+month+"월 17일",year+"년"+month+"월 18일",year+"년"+month+"월 19일",
						 year+"년"+month+"월 20일",year+"년"+month+"월 21일",year+"년"+month+"월 22일",year+"년"+month+"월 23일",year+"년"+month+"월 24일",year+"년"+month+"월 25일",year+"년"+month+"월 26일",
						 year+"년"+month+"월 27일",year+"년"+month+"월 28일"];
					
				}
				 loginchart.data.datasets[0].data = [result[0], result[1], result[2], result[3], result[4], result[5],result[6],result[7],result[8],result[9],result[10],result[11],result[12],result[13],result[14],result[15],result[16],result[17],result[18],result[19],result[20],result[21],result[22],result[23],result[24],result[25],result[26],result[27],result[28],result[29],result[30]];
				 loginchart.options.onClick = function(point,event){
					 if(event.length <= 0)
						{console.log("데이터없음."); return;}
					 loginyear(loginchart);
				 };
				 loginchart.update();
			},
			error: function(result){
				alert('에러');
			}
		});
		
		
		
	};
	function loginyear (loginchart){
		var url = "${contextPath}/admin/loginyear";
		var currentday = new Date();
		var currentyear = currentday.getFullYear();
		
		$.ajax({
			url: url,
			type: 'POST',
			data: {"date": currentday},
			dataType: 'json',
			async: false,
			success: function(result){
				loginchart.data.labels = [//x축 데이터
						
					currentyear-9,
					currentyear-8,
					currentyear-7,
					currentyear-6,
					currentyear-5,
					currentyear-4,
					currentyear-3,
					currentyear-2,
					currentyear-1,
					currentyear
					];
				loginchart.data.datasets[0].data = [result[9],result[8],result[7],result[6],result[5],result[4],result[3],result[2],result[1],result[0]];
				 loginchart.options.onClick = function(point,event){
					 if(event.length <= 0)
						{console.log("데이터없음."); return;}
					 loginmonth(currentyear-(9-event[0]['_index']),loginchart);
				 }
				 loginchart.update();
			},
			error: function(result){
				alert('에러')
			}
	});
	}
	function joinyear (joinchart){
		var url = "${contextPath}/admin/joinyear";
		var currentday = new Date();
		var currentyear = currentday.getFullYear();
		
		$.ajax({
			url: url,
			type: 'POST',
			data: {"date": currentday},
			dataType: 'json',
			async: false,
			success: function(result){
				joinchart.data.labels = [//x축 데이터
						
					currentyear-9,
					currentyear-8,
					currentyear-7,
					currentyear-6,
					currentyear-5,
					currentyear-4,
					currentyear-3,
					currentyear-2,
					currentyear-1,
					currentyear
					];
				joinchart.data.datasets[0].data = [result[9],result[8],result[7],result[6],result[5],result[4],result[3],result[2],result[1],result[0]];
				 joinchart.options.onClick = function(point,event){
					 if(event.length <= 0)
						{console.log("데이터없음."); return;}
					 joinmonth(currentyear-(9-event[0]['_index']),joinchart);
				 }
				 joinchart.update();
			},
			error: function(result){
				alert('에러')
			}
			
			
			
			
		});
	}
	
	
	</script>
	<%@ include file="../include/nav_bar.jsp"%>

	<div id="layoutSidenav">

		<%@ include file="../include/layoutSidenav.jsp"%>
	
		<div id="layoutSidenav_content">
			<main>
			 <div class="container-fluid px-4">
                        <h1 class="mt-4">관리자 페이지</h1>
                        <div class="row">
                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-primary text-white mb-4">
                                    <div class="card-body">행사일정 관리</div>
                                    <div class="card-footer d-flex align-items-center justify-content-between">
                                        <a class="small text-white stretched-link" href="${contextPath }/admin/event">바로가기</a>
                                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-warning text-white mb-4">
                                    <div class="card-body">배너관리</div>
                                    <div class="card-footer d-flex align-items-center justify-content-between">
                                        <a class="small text-white stretched-link" href="${contextPath }/admin/banner">바로가기</a>
                                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-success text-white mb-4">
                                    <div id ="notification"><span class = "note-num">${reportcnt }</span></div>
                                    <div class="card-body">신고목록,회원제재</div>
                                    <div class="card-footer d-flex align-items-center justify-content-between">
                                        <a class="small text-white stretched-link" href="${contextPath }/admin/userboardmanage">바로가기</a>
                                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-danger text-white mb-4">
                                  <div id ="notification"><span class = "note-num" style="background-color:red;">${gradeupcnt }</span></div>
                                    <div class="card-body">회원등급 관리</div>
                                    <div class="card-footer d-flex align-items-center justify-content-between">
                                        <a class="small text-white stretched-link" href="${contextPath }/admin/usergrademanage">바로가기</a>
                                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                            <div class="col-xl-6" style ="width:100%;">
                                <div class="card mb-4" style ="width:100%;">
                                    <div class="card-header" style ="width:100%;">
                                        <i class="fas fa-chart-area me-1" ></i>
                                        회원가입 통계
                                  
                                    </div>
                                    <div class="card-body" style ="width:100%;"><canvas class="joinstat" id="joinstatyear" width="100%" height="40"></canvas></div>
                                </div>
                            </div>
                             <div class="col-xl-6" style ="width:100%;">
                                <div class="card mb-4" style ="width:100%;">
                                    <div class="card-header" style ="width:100%;">
                                        <i class="fas fa-chart-area me-1" ></i>
                                        로그인 통계
                                  
                                    </div>
                                    <div class="card-body" style ="width:100%;"><canvas class="loginstat" id="loginstatyear" width="100%" height="40"></canvas></div>
                                </div>
                            </div>
                    </div>
			</main>
			<%@ include file="../include/footer.jsp"%>
		</div>
	</div>

	<%@ include file="../include/plugin.jsp"%>
</body>
</html>
