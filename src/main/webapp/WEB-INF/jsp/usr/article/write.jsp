<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="ARTICLE WRITE" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/toastUiEditorLib.jspf"%>

<script>
	const submitWriteFormDone = false;
	
	function submitWriteForm(form) {
		if(submitWriteFormDone){
			alert('처리 중 입니다');
			return;
		}
		
		form.title.value = form.title.value.trim();

		if (form.title.value == 0) {
			alert('제목을 입력해주세요');
			return;
		}

		const editor = $(form).find('.toast-ui-editor').data(
				'data-toast-editor');
		const markdown = editor.getMarkdown().trim();

		if (markdown.length == 0) {
			alert('내용을 입력해주세요');
			editor.focus();

			return;
		}

		form.body.value = markdown;
		
		form.submit();

		submitWriteFormDone = true;
	}
</script>

<section class="mt-8">
	<div class="container mx-auto px-3">
		<form onsubmit="submitWriteForm(this); return false" class="table-box-type-1" method="POST"
			action="../article/doWrite">
			<input type="hidden" name="body" />
			<table class="table table-zebra w-full">
				<colgroup>
					<col width="200" />
				</colgroup>
				<tbody>
					<tr>
						<th>작성자</th>
						<td>${rq.loginedMember.nickname }</td>
					</tr>
					<tr>
						<th>게시판</th>
						<td>
							<select class="select select-bordered" name="boardId">
								<option disabled>게시판을 선택해주세요</option>
								<option value="1">공지사항</option>
								<option value="2">자유게시판</option>
							</select>
							<!-- 							<label> -->
							<!-- 								공지사항 -->
							<!-- 								<input class="mx-1" type="radio" name="boardId" value="1" /> -->
							<!-- 							</label> -->
							<!-- 							<label> -->
							<!-- 								자유게시판 -->
							<!-- 								<input class="mx-1" type="radio" name="boardId" value="2" /> -->
							<!-- 							</label> -->
						</td>
					</tr>
					<tr>
						<th>제목</th>
						<td>
							<input required="required" class="w-full" type="text" name="title" placeholder="제목을 입력해주세요" />
						</td>
					</tr>
					<tr>
						<th>내용</th>
						<td>
							<div class="toast-ui-editor">
								<script type="text/x-template"></script>
							</div>
						</td>
					</tr>
					<tr>
						<th></th>
						<td>
							<button class="btn btn-ghost" type="submit" value="작성">작성</button>
						</td>

					</tr>
				</tbody>
			</table>
		</form>

		<div class="btns flex justify-end mt-2">
			<button class="btn btn-primary btn-xs" type="button" onclick="history.back();">뒤로가기</button>
		</div>
	</div>
</section>

<%@ include file="../common/foot.jspf"%>