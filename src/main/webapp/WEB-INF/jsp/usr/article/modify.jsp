<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="ARTICLE MODIFY" />
<%@ include file="../common/head.jspf"%>

<section class="mt-8">
	<div class="container mx-auto px-3">
		<form class="table-box-type-1" method="POST" action="../article/doModify">
			<input type="hidden" name="id" value="${article.id }" />
			<table class="table table-zebra w-full">
				<colgroup>
					<col width="200" />
				</colgroup>
				<tbody>
					<tr>
						<th>번호</th>
						<td>
							<span class="badge">${article.id }</span>
						</td>
					</tr>
					<tr>
						<th>작성날짜</th>
						<td>${article.regDate }</td>
					</tr>
					<tr>
						<th>수정날짜</th>
						<td>${article.updateDate }</td>
					</tr>
					<tr>
						<th>조회수</th>
						<td>
							<span class="badge article-detail__hit-count">${article.hitCount }</span>
						</td>
					</tr>
					<tr>
						<th>작성자</th>
						<td>${article.extra__writerName }</td>
					</tr>
					<tr>
						<th>추천</th>
						<td>
							<span class="badge">${article.goodReactionPoint }</span>
						</td>
					</tr>
					<tr>
						<th>제목</th>
						<td>
							<input class="w-full" type="text" name="title" placeholder="제목을 입력해주세요" value="${article.title }" />
						</td>
					</tr>
					<tr>
						<th>내용</th>
						<td>
							<textarea class="w-full" type="text" name="body" placeholder="내용을 입력해주세요">${article.body }</textarea>
						</td>
					</tr>
					<tr>
						<th></th>
						<td>
							<button class="btn btn-ghost" type="submit" value="수정">수정</button>
						</td>

					</tr>
				</tbody>
			</table>
		</form>

		<div class="btns">
			<button class="btn-text-link" type="button" onclick="history.back();">뒤로가기</button>
		</div>
	</div>
</section>

<%@ include file="../common/foot.jspf"%>