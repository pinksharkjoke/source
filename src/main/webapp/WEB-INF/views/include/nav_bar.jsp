<%@page import="kr.co.pap.account.LoginVO"%>
<%@ page language="java" pageEncoding="UTF-8"%>

    
<nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="${contextPath }">Pit-A-Pet</a>
            <!-- Sidebar Toggle-->
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
            <!-- Navbar Search-->
            
            <div style="margin-left: 300px; align-items: center;">
            	<img alt="${contextPath }/resources/weather/assets/favicon.ico" src="${contextPath }/resources/weather/assets/img/weathericon.png">
            	<a href="${contextPath }/weather/home">날씨보기</a>
            </div>
            
            <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
                <div class="input-group">
                    <input class="form-control" type="text" placeholder="Search for..." aria-label="Search for..." aria-describedby="btnNavbarSearch" />
                    <button class="btn btn-primary" id="btnNavbarSearch" type="button"><i class="fas fa-search"></i></button>
                </div>
            </form>
            <!-- Navbar-->
            <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                       <%
                       LoginVO user = (LoginVO)session.getAttribute("user");
                       if(user == null || !((user.getUi_grade().equals("관리자"))||user.getUi_grade().equals("매니저"))){ %>
                        <li><a class="dropdown-item" href="${contextPath }/personal/main">개인페이지</a></li>
                        <%} else if(user.getUi_grade().equals("관리자")) {%>
                        <li><a class="dropdown-item" href="${contextPath }/admin">관리자페이지</a></li>
                        <%} else if(user.getUi_grade().equals("매니저")){%>
                        <li><a class="dropdown-item" href="${contextPath }/personal/main">개인페이지</a></li>
                        <li><a class="dropdown-item" href="${contextPath }/admin">관리자페이지</a></li>
                        	
                        	<%
                        }
                        	%>
                        <%if(user == null){ %>
                        <li><a class="dropdown-item" href="${contextPath }/login">Login</a></li>
                        <%} else{ %>
                        <li><a class="dropdown-item" href="${contextPath }/personal/password?ui_id=${user.ui_id}">내 정보</a></li>
                        <li><a class="dropdown-item" href="${contextPath }/logout">Logout</a></li>
                        <%} %>
                    </ul>
                </li>
            </ul>
        </nav>