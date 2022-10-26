<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<%@ include file="../include/head.jsp"%>

<body class="sb-nav-fixed" style="padding-top: 5rem;">

	<%@ include file="../include/nav_bar.jsp"%>

	<div id="layoutSidenav">

		<%@ include file="../include/layoutSidenav.jsp"%>

		<div id="layoutSidenav_content">
			<main>
				<!-- include libraries(jQuery, bootstrap) -->
				<link
					href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"
					rel="stylesheet">
				<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
				<script
					src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

				<!-- include summernote css/js -->
				<link
					href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css"
					rel="stylesheet">
				<script
					src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>

				<!-- summer노트 사진업로드 -->
				<script>
					$(document)
							.ready(
									function() {

										var toolbar = [
												// 글꼴 설정
												[ 'fontname', [ 'fontname' ] ],
												// 글자 크기 설정
												[ 'fontsize', [ 'fontsize' ] ],
												// 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
												[
														'style',
														[
																'bold',
																'italic',
																'underline',
																'strikethrough',
																'clear' ] ],
												// 글자색
												[
														'color',
														[ 'forecolor', 'color' ] ],
												// 표만들기
												[ 'table', [ 'table' ] ],
												// 글머리 기호, 번호매기기, 문단정렬
												[
														'para',
														[ 'ul', 'ol',
																'paragraph' ] ],
												// 줄간격
												[ 'height', [ 'height' ] ],
												// 그림첨부, 링크만들기, 동영상첨부
												[
														'insert',
														[ 'picture', 'link',
																'video' ] ],
												// 코드보기, 확대해서보기, 도움말
												[
														'view',
														[ 'codeview',
																'fullscreen',
																'help' ] ] ];

										var setting = {
											height : 400,
											minHeight : null,
											maxHeight : null,
											focus : true,
											lang : 'ko-KR',
											toolbar : toolbar,
											//콜백 함수
											callbacks : {
												onImageUpload : function(files,
														editor, welEditable) {
													// 파일 업로드(다중업로드를 위해 반복문 사용)
													for (var i = files.length - 1; i >= 0; i--) {
														uploadSummernoteImageFile(
																files[i], this);
													}
												}
											}
										};
										$('#summernote').summernote(setting);

										function uploadSummernoteImageFile(
												file, el) {

											data = new FormData();
											data.append("file", file);

											$
													.ajax({
														data : data,
														type : "POST",
														url : "uploadSummernoteImageFile",
														contentType : false,
														enctype : 'multipart/form-data',
														processData : false,
														success : function(data) {
															console.log(data);

															$(el)
																	.summernote(
																			'editor.insertImage',
																			data.photo);

															var bo_photo = data.photo;

															
															$(
																	'input[name=bo_photo]')
																	.attr(
																			'value',
																			bo_photo);

														}
													});
										}

									});
				</script>

				<!--  summernote 끝 -->





				<!-- 글수정 폼 -->
				<table>
					<form name="form" method="POST">
						<input type="hidden" id="ui_id" name="ui_id"
							value="${board.ui_id}" /> <input type="hidden" id="bo_num"
							name="bo_num" value="${board.bo_num	}" /> <input type="hidden"
							id="bo_num" name="bo_photo" value="${board.bo_photo	}" />
								<input type="hidden" id="bo_photo" name="bo_photo" />
						<div class="form-group">
							<label>제목</label> <input type="text" name='bo_title'
								class="form-control" value="${board.bo_title }">
						</div>
						<c:if
							test="${board.ca_num > 100 && board.ca_num < 110 && board.ca_num !=901 && board.ca_num !=902}">
							<div class="form-group">
								<label>카테고리</label> <select name="ca_num" id="ca_num"
									value="${board.ca_num }">
									<option value=101>강아지</option>
									<option value=102>고양이</option>
									<option value=103>기타</option>
								</select>
							</div>
						</c:if>
						<c:if
							test="${board.ca_num > 200 && board.ca_num < 210 && board.ca_num !=901 && board.ca_num !=902}">
							<div class="form-group">
								<label>카테고리</label> <select name="ca_num" id="ca_num"
									value="${board.ca_num }">
									<option value=201>서울</option>
									<option value=202>경기북부</option>
									<option value=203>경기남부</option>
									<option value=204>강원</option>
									<option value=205>충청</option>
									<option value=206>전라</option>
									<option value=207>경상</option>
									<option value=208>제주도</option>

								</select>
							</div>
						</c:if>
						<c:if
							test="${board.ca_num > 300 && board.ca_num < 310 && board.ca_num !=901 && board.ca_num !=902}">
							<div class="form-group">
								<label>카테고리</label> <select name="ca_num" id="ca_num"
									value="${board.ca_num }">
									<option value=301>사료/간식</option>
									<option value=302>위생/미용용품</option>
									<option value=303>하우스/실내용품</option>
									<option value=304>리드줄/야외용품</option>
									<option value=305>장난감/훈련용품</option>
									<option value=306>의류/액세서리</option>
									<option value=307>급수/급식기</option>
									<option value=308>무료나눔</option>

								</select>
							</div>
						</c:if>
						<c:if
							test="${board.ca_num > 0 && board.ca_num < 5 && board.ca_num !=901 && board.ca_num !=902}">
							<div class="form-group">
								<label>카테고리</label> <select name="ca_num" id="ca_num"
									value="${board.ca_num }">
									<option value=1>자유게시판</option>
									<option value=2>질문 Q&A</option>
									<option value=3>꿀팁 게시판</option>
								</select>
							</div>
						</c:if>
						<div class="form-group">
							<label>내용</label>
							<textarea class="form-control" id="summernote" name="bo_content"
								rows="3">${board.bo_content }</textarea>
						</div>


						<div class="form-group">
							<label>작성자</label> <input type="text" name="bo_name"
								class="form-control" value="${ncName}" readonly>
						</div>


						<c:if
							test="${board.ca_num > 300 && board.ca_num !=901 && board.ca_num !=902}">
							<div class="form-group">
								<label>제품상태</label> <select name="bo_pstatus" id="bo_pstatus"
									value="${board.bo_pstatus }">
									<option value="판매중">판매중</option>
									<option value="예약중">예약중</option>
									<option value="판매완료">판매완료</option>
								</select>
							</div>
						</c:if>

						<!-- 마켓 상태 -->


						<div class="box-footer">
							<button type="submit" class="btn btn-primary">작성완료</button>
						</div>


					</form>
				</table>



			</main>
			<%@ include file="../include/footer.jsp"%>
		</div>
	</div>
	<%@ include file="../include/plugin.jsp"%>
</body>
</html>
