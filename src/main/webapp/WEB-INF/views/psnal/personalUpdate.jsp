<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!--
=========================================================
 Light Bootstrap Dashboard - v2.0.1
=========================================================

 Product Page: https://www.creative-tim.com/product/light-bootstrap-dashboard
 Copyright 2019 Creative Tim (https://www.creative-tim.com)
 Licensed under MIT (https://github.com/creativetimofficial/light-bootstrap-dashboard/blob/master/LICENSE)

 Coded by Creative Tim

=========================================================

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.  -->
<!DOCTYPE html>
<html lang="en">
<%@ include file="../include/head.jsp"%>
<%@ include file="../include/psnalUpdateScript.jsp" %>
<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=045cf8e3fa0eeb2315c22add32c6aae9&libraries=services"></script>
<script	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
	.textContent{
		text-align: center;
		font-style: oblique;
	}

	.main_bg{
		background-image: url('${contextPath}/resources/images/ddd.jpg');
	}
</style>
<body class="sb-nav-fixed">

	<%@ include file="../include/nav_bar.jsp"%>

	<div id="layoutSidenav">

		<%@ include file="../include/layoutSidenav.jsp"%>

		<div id="layoutSidenav_content">
			<main class="main_bg">
				    <!--업데이트 프로파일 버튼 움직임, 사진 밑 페이스북 트위터 등 로고 없어짐.-->
				    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />
				    <!-- CSS Files 무조건 있어야함. -->
				    <link href="${contextPath }/resources/bootstrapRegister/bootstrap.min.css" rel="stylesheet" />
				    <!--프로파일 사진 관련 css-->
				    <link href="${contextPath }/resources/bootstrapRegister/light-bootstrap-dashboard.css?v=2.0.0 " rel="stylesheet" />
							<div class="textContent">
								<p></p>
								<h2>${user.ui_ncname}님의 프로파일(Account Profile)</h2>
								<hr>
							</div>
				            <div class="content">
				                <div class="container-fluid">
				                    <div class="row">
										<div class="row" id="updateForm">
											<div class="col-md-8">
												<div class="card">
													<div class="card-header">
														<h4 class="card-title">Edit Profile</h4>
													</div>
													<div class="card-body">
															<div class="row">
																<div class="col-md-3">
																	<div class="form-group">
																		<label>이름(Name)</label>
																		<input type="text" class="form-control" id="ui_name" name="ui_name" placeholder="Name" value="${uv.ui_name}">
																	</div>
																</div>
																<div class="col-md-3">
																	<div class="form-group">
																		<label>생년월일(Birth)</label>
																		<input type="date" class="form-control" id="ui_birth" name="ui_birth" value="${uv.ui_birth}">
																	</div>
																</div>
															</div>
															<div class="row">
																<div class="col-md-3 pr-1">
																	<div class="form-group">
																		<label>아이디(ID)</label>
																		<input type="text" class="form-control" id="ui_id" name="ui_id" readonly="readonly" value="${user.ui_id}">
																	</div>
																</div>
																<div class="col-md-3 px-1">
																	<div class="form-group">
																		<label>닉네임(NicName)</label>
																		<input type="text" class="form-control" id="ui_ncName" name="ui_ncName" placeholder="Nicname" value="${uv.ui_ncName}">
																	</div>
																</div>
																<div class="col-md-2">
																	<div class="form-group">
																		<label>중복체크(Duplicate)</label>
																		<button class="btn btn-success" id="dup_button" value="Y" hidden="true">중복체크</button>
																		<input type="text" class="form-control" id="dup_success" placeholder="중복체크 완료" readonly="readonly">
																	</div>
																</div>
															</div>
															<div class="row">
																<div class="col-md-3">
																	<div class="form-group">
																		<label>비밀번호(Password)</label> <label>****보이기 <input type="checkbox" id="show1" name="show1" value="hide1" /></label>
																		<input type="password" class="form-control" id="ui_pw"  name="ui_pw" placeholder="Password" pattern="^([0-9a-z]+)([`~!@#$%^&*()-_=+]+)$" readonly="readonly" value="${uv.ui_pw}">
																	</div>
																</div>
																<div class="col-md-3">
																	<div class="form-group">
																		<label>비밀번호 확인(Verify)</label> <label>****보이기 <input type="checkbox" id="show2" name="show2" value="hide2" /></label>
																		<input type="password" class="form-control" id="pw_verify" name="pw_verify" placeholder="one more input password" >
																		<small id="verifyTrue" style="color: green; font-weight: bold;" hidden="true">비밀번호가 일치합니다!!!</small>
																		<small id="verifyFalse" style="color: red; font-weight: bold;" hidden="true">비밀번호가 일치하지 않습니다. 다시 확인해주세요.</small>
																	</div>
																</div>
																<div class="col-md-3">
																	<div class="form-group">
																		<label>비밀번호 변경하기(change PW)</label>
																		<button class="btn btn-success" id="p_button" value="N">비밀번호 변경</button>
																	</div>
																</div>
															</div>
															<div class="row">
																<div class="col-md-6 pr-1">
																	<div class="form-group">
																		<label>Address(Map)</label>
																		<input type="text" class="form-control" id="ui_loc" name="ui_loc" placeholder="클릭하셔서 검색하세요." value="${uv.ui_loc }">
																	</div>
																</div>
																<div class="col-md-6 pl-1">
																	<div class="form-group">
																		<label>Address(detail)</label>
																		<input type="text" class="form-control" id="ui_loc_d" placeholder="자세한 주소는 직접 입력해주세요." value="">
																	</div>
																</div>
															</div>
															<div class="row">
																<div class="col-md-5">
																	<div class="form-group">
																		<label>이메일(E-mail)</label>
																		<input type="email" class="form-control" id="ui_email" name="ui_email" placeholder="E-mail Address" value="${uv.ui_email}">
																	</div>
																</div>
																<div class="col-md-3">
																	<div class="form-group">
																		<label>이메일 인증(Certify)</label>
																		<button class="btn btn-success" id="e_button" value="Y" hidden="true">E-mail 인증번호 전송</button>
																		<input type="text" class="form-control" id="e_success" placeholder="이메일인증 완료" readonly="readonly">
																		<span id="e_certify_span" hidden="true"><label>인증번호 : <input class="form-control form-control-user" id="e_certify" /></label></span>
																		<button id="e_certify_B" value="N" hidden="true">이메일 인증번호 인증하기</button>
																		<input id="e_certify_h" readonly="readonly" hidden="true" />
																	</div>
																</div>
															</div>
															<div class="row">
																<div class="col-md-4 pr-1">
																	<div class="form-group">
																		<label>핸드폰 번호(Phone Number)</label>
																		<input type="text" class="form-control" id="ui_phonenum" name="ui_phonenum" placeholder="'-' 를 제외한 숫자만 입력하세요." value="${uv.ui_phonenum }" pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}" maxlength="13">
																	</div>
																</div>
																<div class="col-md-3">
																	<div class="form-group">
																		<label>회원등급(Account Grade)</label>
																		<input type="text" class="form-control" id="ui_grade" name="ui_grade" placeholder="${uv.ui_grade}" readonly="readonly" value="${uv.ui_grade}">
																	</div>
																</div>
															</div>
															<button type="button" class="btn btn-info btn-fill pull-right" id="subUpdate">Update Profile</button>
															<button type="button" class="btn btn-danger" id="reset">reset Profile</button>
															<div class="clearfix"></div>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="card card-user">
													<div class="card-image">
														<img src="https://ununsplash.imgix.net/photo-1431578500526-4d9613015464?fit=crop&fm=jpg&h=300&q=75&w=400" alt="...">
													</div>
													<div class="card-body">
														<div class="author">
															<a href="#">
																<img class="avatar border-gray" src="${contextPath }/resources/images/psUpdate/face-0.jpg" alt="${contextPath }/resources/images/psUpdate/face-0.jpg">
																<h5 class="title">${uv.ui_ncName}</h5>
															</a>
														</p>
													</div>
													<hr>
													<div class="col-md-12">
														<div class="form-group">
															<label>프로필 사진(Profile Picture)</label>
															<input type="file" id="ui_img" class="form-control">
														</div>
													</div>
												</div>
											</div>
										</div>
				                    </div>
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
