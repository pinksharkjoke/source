<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<%@ include file="include/head.jsp"%>
<%@include file="include/regFormScript.jsp" %>

<body class="sb-nav-fixed">

	<%@ include file="include/nav_bar.jsp"%>

	<div id="layoutSidenav">
	
	<%@ include file="include/layoutSidenav.jsp"%>

		<div id="layoutSidenav_content">
			<main>
			    <link href="${contextPath}/resources/bootstrapRegister/sb-admin-2.min.css" rel="stylesheet">
					<body class="bg-gradient-primary" style="background-image: url('${contextPath}/resources/weather/assets/img/skysky.png');">
					
					    <div class="container">
					
					        <div class="card o-hidden border-0 shadow-lg my-5">
					            <div class="card-body p-0">
					                <!-- Nested Row within Card Body -->
					                <div class="row">
					                <!-- 회원가입 사진은 여기. -->
					                    <div class="col-lg-5 d-none d-lg-block bg-register-image"></div> 
					                    <div class="col-lg-7">
					                        <div class="p-5">
					                            <div class="text-center">
					                                <h1 class="h4 text-gray-900 mb-4">회원가입(Create an Account)</h1>
					                                <hr>
					                            </div>
					                            <div id="regForm">
					                                <div class="form-group row">
					                                    <div class="col-sm-6 mb-3 mb-sm-0">
					                                        <span style="padding-left: 20px; font-size: 10pt;">아이디(ID)</span>&nbsp;&nbsp;&nbsp;&nbsp;<button id="due" value="N" onclick="fn_idDueCheck()">중복검사</button>
					                                        <input type="text" class="form-control form-control-user" id="ui_id" name="ui_id" placeholder="ID" pattern="^[a-z0-9]+$" />
					                                    </div>
					                                    <div class="col-sm-6">
					                                    	<span style="padding-left: 20px; font-size: 10pt;">닉네임(ncName)</span>&nbsp;&nbsp;&nbsp;&nbsp;<button id="due1" value="N" onclick="fn_ncDueCheck()">중복검사</button>
					                                        <input type="text" class="form-control form-control-user" name="ui_ncName" id="ui_ncName" placeholder="예 : 오리너구리" />
					                                    </div>
					                                </div>
					                                <div class="form-group row">
					                                    <div class="col-sm-6 mb-3 mb-sm-0">
					                                        <span style="padding-left: 20px; font-size: 10pt;">비밀번호(PW)</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label>보이기<input type="checkbox" id="show1" name="show1" value="hide1" /></label>
					                                        <input type="password" class="form-control form-control-user" id="ui_pw" name="ui_pw" placeholder="Password" pattern="^([0-9a-z]+)([`~!@#$%^&*()-_=+]+)$" />
					                                    </div>
					                                    <div class="col-sm-6">
					                                        <span style="padding-left: 20px; font-size: 10pt;">비밀번호 확인</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label>보이기<input type="checkbox" id="show2" name="show2" value="hide2" /></label> <br>
					                                        <input type="password" class="form-control form-control-user" id="pw_verify" name="pw_verify" placeholder="one more input password" />
								                            <small id="verifyTrue" style="color: green; font-weight: bold;" hidden="true">비밀번호가 일치합니다!!!</small>
								                            <small id="verifyFalse" style="color: red; font-weight: bold;" hidden="true">비밀번호가 일치하지 않습니다. 다시 확인해주세요.</small>
					                                    </div>
					                                </div>
                                                    <div class="form-group row">
					                                    <div class="col-sm-6 mb-3 mb-sm-0">
					                                        <span style="padding-left: 20px; font-size: 10pt;">이름(name)</span>
					                                        <input type="text" class="form-control form-control-user" name="ui_name" id="ui_name" placeholder="예 : 오리너구리" />
					                                    </div>
					                                    <div class="col-sm-6">
					                                        <span style="padding-left: 20px; font-size: 10pt;">생년월일(birth)</span>
					                                        <input type="date" class="form-control form-control-user" id="ui_birth" placeholder="예 : 오리너구리" />
					                                    </div>
					                                </div>
					                                <div class="form-group">
					                                	<span style="padding-left: 20px; font-size: 10pt;">이메일 주소(E-mail)</span>&nbsp;&nbsp;&nbsp;&nbsp;<button id="e_Button">이메일 인증메일 전송</button>
					                                    <input type="email" class="form-control form-control-user" name="ui_email" id="ui_email" placeholder="예 : pitapet213@pap.com" ><p></p>
					                                    <span id="e_certify_span" hidden="true"><label>인증번호 : <input class="form-control form-control-user" id="e_certify" /></label></span>
														<button id="e_certify_B" value="N" hidden="true">이메일 인증번호 인증하기</button>
														<input id="e_certify_h" readonly="readonly" hidden="true" />
					                                </div>
					                                <div class="form-group row">
					                                    <div class="col-sm-6 mb-3 mb-sm-0">
					                                        <span style="padding-left: 20px; font-size: 10pt;">휴대전화 번호(Phone number)</span>
					                                        <input class="form-control form-control-user" type="tel" name="ui_phonenum" id="ui_phonenum" placeholder="숫자만 입력해주세요." pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}" maxlength="13">
					                                    </div>
					                                    <div class="col-sm-6">
					                                    	<span style="padding-left: 20px; font-size: 10pt;">프로필 사진(Profile Picture)</span><br>
					                                        <input id="ui_img" type="file" name="ui_img" />
					                                    </div>
					                                </div>
					                                <div class="form-group">
					                                	<span style="padding-left: 20px; font-size: 10pt;">주소(Address)</span>
					                                    <input type="text" class="form-control form-control-user" name="ui_loc" id="ui_loc" placeholder="시/군/동 까지만 적어주세요." >
					                                    <small style="padding-left:20px; color: red">* 해당 내용은 주변 시설검색 및 지역별 커뮤니티, 중고장터, 나눔에만 사용됩니다.</small>
					                                </div>
					                                <div>
					                                	<span style="padding-left: 20px; font-size: 10pt;">회원등급(Grade)</span>
					                                	<input id="ui_grade" type="text" name="ui_grade" value="평회원" readonly="readonly"><p></p>
					                                </div>
					                                	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						                                <button class="btn btn-success" id="submit">회원가입</button>
														<button class="btn btn-success" id="reset">전체 다시입력</button>
														<button class="cancel btn btn-danger" id="cancel">취소</button>
					                            </div>
					                            <hr>
					                        </div>
					                    </div>
					                </div>
					            </div>
					        </div>
					
					    </div>
					
					</body>
				
			</main>
			<%@ include file="include/footer.jsp"%>
		</div>
	</div>
	<%@ include file="include/plugin.jsp"%>
</body>
</html>