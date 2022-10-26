
<%@ page language="java" pageEncoding="UTF-8"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                            
                            	<%if(session.getAttribute("user") == null){ %>
                                  <a class="nav-link" href="${contextPath }/login">
                                <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                                Login
                              </a>
                                <%} else{ %>
                                    <a class="nav-link" href="${contextPath }/logout">
                                <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                                Logout
                            </a>
                            <%} %>
                            <div class="sb-sidenav-menu-heading" style="font-size: 10pt;">게시판 영역</div>
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapsePages" aria-expanded="false" aria-controls="collapsePages">
                                <div class="sb-nav-link-icon"><i class="fas fa-book-open"></i></div>
                                <span style="font-size: 12pt;">커뮤니티(Community)</span>
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapsePages" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPages">
                                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#pagesCollapseAuth" aria-expanded="false" aria-controls="pagesCollapseAuth">
                                        지역별
                                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                                    </a>
                                    <div class="collapse" id="pagesCollapseAuth" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordionPages">
                                        <nav class="sb-sidenav-menu-nested nav">
                                            <a class="nav-link" href="${contextPath}/board/list?ca=201&searchType=${scri.searchType}&keyword=${scri.keyword}&sort=bno">서울</a>
                                            <a class="nav-link" href="${contextPath}/board/list?ca=202&searchType=${scri.searchType}&keyword=${scri.keyword}&sort=bno">경기북부</a>
                                            <a class="nav-link" href="${contextPath}/board/list?ca=203&searchType=${scri.searchType}&keyword=${scri.keyword}&sort=bno">경기남부</a>
                                            <a class="nav-link" href="${contextPath}/board/list?ca=204&searchType=${scri.searchType}&keyword=${scri.keyword}&sort=bno">강원</a>
                                            <a class="nav-link" href="${contextPath}/board/list?ca=205&searchType=${scri.searchType}&keyword=${scri.keyword}&sort=bno">충청</a>
                                            <a class="nav-link" href="${contextPath}/board/list?ca=206&searchType=${scri.searchType}&keyword=${scri.keyword}&sort=bno">전라</a>
                                            <a class="nav-link" href="${contextPath}/board/list?ca=207&searchType=${scri.searchType}&keyword=${scri.keyword}&sort=bno">경상</a>
                                            <a class="nav-link" href="${contextPath}/board/list?ca=208&searchType=${scri.searchType}&keyword=${scri.keyword}&sort=bno">제주도</a>
                                        </nav>
                                    </div>
                                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#pagesCollapse" aria-expanded="false" aria-controls="pagesCollapseError">
                                       	펫 자랑(MyPet)
                                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                                    </a>
                                    <div class="collapse" id="pagesCollapse" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordionPages">
                                        <nav class="sb-sidenav-menu-nested nav">
                                            <a class="nav-link" href="${contextPath}/board/listpicpet?ca=101">강아지(Dog)</a>
                                            <a class="nav-link" href="${contextPath}/board/listpicpet?ca=102">고양이(Cat)</a>
                                            <a class="nav-link" href="${contextPath}/board/listpicpet?ca=103">기타(Etc)</a>
                                            
                                        </nav>
                                    </div>
                                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#pagesCollapse2" aria-expanded="false" aria-controls="pagesCollapseError">
                                       	자유게시판
                                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                                    </a>
                                    <div class="collapse" id="pagesCollapse2" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordionPages">
                                        <nav class="sb-sidenav-menu-nested nav">
                                            <a class="nav-link" href="${contextPath}/board/list?ca=1&searchType=${scri.searchType}&keyword=${scri.keyword}&sort=bno">자유게시판</a>
                                            <a class="nav-link" href="${contextPath}/board/list?ca=2&searchType=${scri.searchType}&keyword=${scri.keyword}&sort=bno">질문 Q&A</a>
                                            <a class="nav-link" href="${contextPath}/board/list?ca=3&searchType=${scri.searchType}&keyword=${scri.keyword}&sort=bno">꿀팁 게시판</a>
                                        </nav>
                                    </div>
                                </nav>
                            </div>

                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapsePages3" aria-expanded="false" aria-controls="collapsePages">
                                <div class="sb-nav-link-icon"><i class="fas fa-book-open"></i></div>
                                중고장터
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapsePages3" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPages">
                                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#pagesCollapseAuth" aria-expanded="false" aria-controls="pagesCollapseAuth">
                                        중고장터
                                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                                    </a>
                                    <div class="collapse" id="pagesCollapseAuth" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordionPages">
                                        <nav class="sb-sidenav-menu-nested nav">
                                            <a class="nav-link" href="${contextPath}/board/listpicmarket?ca=301">사료/간식</a>
                                            <a class="nav-link" href="${contextPath}/board/listpicmarket?ca=302">위생/미용용품</a>
                                            <a class="nav-link" href="${contextPath}/board/listpicmarket?ca=303">하우스/실내용품</a>
											<a class="nav-link" href="${contextPath}/board/listpicmarket?ca=304">리드줄/야외용품</a>
											<a class="nav-link" href="${contextPath}/board/listpicmarket?ca=305">장난감/훈련용품</a>
											<a class="nav-link" href="${contextPath}/board/listpicmarket?ca=306">의류/액세서리</a>
											<a class="nav-link" href="${contextPath}/board/listpicmarket?ca=307">급수/급식기 </a>

                                        </nav>
                                    </div>
                                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#pagesCollapseError" aria-expanded="false" aria-controls="pagesCollapseError">
                                       	무료나눔
                                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                                    </a>
                                    <div class="collapse" id="pagesCollapseError" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordionPages">
                                        <nav class="sb-sidenav-menu-nested nav">
                                            <a class="nav-link" href="${contextPath}/board/listpicmarket?ca=308">무료나눔</a>
                                       
                                        </nav>
                                    </div>
                                </nav>
                            </div>
                            <div class="sb-sidenav-menu-heading">그 밖의 기능(Utility)</div>
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts2" aria-expanded="false" aria-controls="collapseLayouts">
                                <div class="sb-nav-link-icon" ><i class="fas fa-columns"></i></div>
                                <span style="font-size: 12pt;">지도</span>
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseLayouts2" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link" href="${contextPath }/map?ui_id=${user.ui_id}">지도</a>
                                </nav>
                            </div>
                            <div class="sb-sidenav-menu-heading">고객센터</div>
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts3" aria-expanded="false" aria-controls="collapseLayouts">
                                <div class="sb-nav-link-icon" ><i class="fas fa-columns"></i></div>
                                <span style="font-size: 12pt;">고객센터</span>
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseLayouts3" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link" href="${contextPath}/board/list?ca=901">건의 및 신고</a>
                                    <a class="nav-link" href="${contextPath}/board/list?ca=902">등업 신청</a>
                                </nav>
                                </div>
                        </div>
                    </div>
                    
                 	
                    
                    <div class="sb-sidenav-footer">
                        <div class="small">${user.ui_ncname }님 환영합니다.</div>
                    </div>
                </nav>
            </div>