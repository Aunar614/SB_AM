<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="ARTICLE DETAIL" />
<%@ include file="../common/head.jspf"%>

<script>
	const params = {};
	params.id = parseInt('${param.id}');
</script>

<script>
	// 조회수 관련
	function ArticleDetail__increaseHitCount() {
		const localStorageKey = 'article__' + params.id + '__alreadyView';

		if (localStorage.getItem(localStorageKey)) {
			return;
		}

		localStorage.setItem(localStorageKey, true);

		$.get('../article/doIncreaseHitCountRd', {
			id : params.id,
			ajaxMode : 'Y'
		}, function(data) {
			$('.article-detail__hit-count').empty().html(data.data1);
		}, 'json');
	}

	$(function() {
		// 실전 코드
		// ArticleDetail__increaseHitCount();

		// 연습코드
		setTimeout(ArticleDetail__increaseHitCount, 2000);
	})
</script>

<section class="mt-8">
	<div class="container mx-auto px-3">
		<div class="table-box-type-1">
			<table class="table table-zebra w-full">
				<colgroup>
					<col width="200" />
				</colgroup>
				<tbody>
					<tr>
						<th>번호</th>
						<td>
							<span class="badge badge-md">${article.id }</span>
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
							<span class="badge badge-md article-detail__hit-count">${article.hitCount }</span>
						</td>
					</tr>
					<tr>
						<th>작성자</th>
						<td>${article.extra__writerName }</td>
					</tr>
					<tr>
						<th>추천</th>
						<td>
							<c:if test="${actorCanMakeReaction }">
								<a
									href="/usr/reactionPoint/doGoodReaction?relTypeCode=article&relId=${param.id}&replaceUri=${rq.encodedCurrentUri} "
									class="btn btn-outline btn-xs">좋아요 👍</a>
							</c:if>
							<c:if test="${actorCanCancelGoodReaction }">
								<a
									href="/usr/reactionPoint/doCancelGoodReaction?relTypeCode=article&relId=${param.id}&replaceUri=${rq.encodedCurrentUri} "
									class="btn btn-xs btn-primary">좋아요 👍</a>
							</c:if>
							<c:if test="${actorCanCancelBadReaction }">
								<a onclick="alert(this.title); return false;" title="싫어요를 먼저 취소해주세요" href="#" class="btn btn-outline btn-xs">좋아요
									👍</a>
							</c:if>
							<span>&nbsp;</span>

							<span class="badge badge-md">${article.goodReactionPoint }</span>

							<span>&nbsp;</span>
							<c:if test="${actorCanMakeReaction }">
								<a
									href="/usr/reactionPoint/doBadReaction?relTypeCode=article&relId=${param.id}&replaceUri=${rq.encodedCurrentUri} "
									class="btn btn-outline btn-xs">싫어요 👎</a>
							</c:if>
							<c:if test="${actorCanCancelGoodReaction }">
								<a onclick="alert(this.title); return false;" title="먼저 좋아요를 먼저 취소해주세요" href="#" class="btn btn-outline btn-xs">싫어요
									👎</a>
							</c:if>
							<c:if test="${actorCanCancelBadReaction }">
								<a
									href="/usr/reactionPoint/doCancelBadReaction?relTypeCode=article&relId=${param.id}&replaceUri=${rq.encodedCurrentUri} "
									class="btn btn-xs btn-primary">싫어요 👎</a>
							</c:if>
						</td>
					</tr>
					<tr>
						<th>제목</th>
						<td>${article.title }</td>
					</tr>
					<tr>
						<th>내용</th>
						<td>${article.getForPrintBody() }</td>
					</tr>
				</tbody>
			</table>
		</div>

		<div class="btns">
			<div class="mt-2 flex justify-end">
				<button class="btn btn-xs btn-primary ml-2" type="button" onclick="history.back();">뒤로가기</button>
				<c:if test="${article.extra__actorCanModify }">
					<a class="btn btn-xs btn-primary ml-2" href="../article/modify?id=${article.id }">수정</a>
				</c:if>
				<c:if test="${article.extra__actorCanDelete }">
					<a class="btn btn-xs btn-primary ml-2" onclick="if (confirm('정말 삭제하시겠습니까?') == false) return false;"
						href="../article/doDelete?id=${article.id }">삭제</a>
				</c:if>
			</div>
		</div>
	</div>
</section>

<!-- reply section -->

<script>
	// 댓글 관련
	let ReplyWrite__submitFormDone = false;
	function ReplyWrite__submitForm(form) {
		if (ReplyWrite__submitFormDone) {
			return;
		}

		form.body.value = form.body.value.trim();

		if (form.body.value.length == 0) {
			alert('댓글을 입력해주세요');
			form.body.focus();
			return;
		}

		if (form.body.value.length < 2) {
			alert('2글자 이상 입력해주세요');
			form.body.focus();
			return;
		}

		ReplyWrite__submitFormDone = true;
		form.submit();
	}
</script>

<section class="mt-5">
	<div class="container mx-auto px-3">
		<c:if test="${rq.logined }">
			<h2>댓글 작성</h2>
			<form class="table-box-type-1 mt-2" method="POST" action="../reply/doWrite"
				onsubmit="ReplyWrite__submitForm(this); return false;">
				<input type="hidden" name="relTypeCode" value="article" />
				<input type="hidden" name="relId" value="${article.id }" />
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
							<th>내용</th>
							<td>
								<textarea class="textarea textarea-bordered w-full" name="body" placeholder="댓글을 입력해주세요" rows="2"></textarea>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="flex mt-2 justify-end">
					<button class="btn btn-xs btn-primary" type="submit" value="댓글작성">댓글 작성</button>
				</div>
			</form>
		</c:if>
		<c:if test="${rq.notLogined}">
			<h1>
				댓글 작성은 "
				<a class="btn-text-link" href="/usr/member/login">로그인</a>
				" 후 이용해주세요
			</h1>
		</c:if>
	</div>
</section>

<section class="mt-5">
	<div class="container mx-auto px-3">
		<h2>댓글 (${replies.size() })</h2>

		<table class="table w-full mt-2">
			<colgroup>
				<col width="50" />
				<col width="100" />
				<col width="100" />
				<col width="50" />
				<col width="140" />
				<col width="100" />
			</colgroup>
			<thead>
				<tr>
					<th class="text-center">번호</th>
					<th class="text-center">날짜</th>
					<th class="text-center">작성자</th>
					<th class="text-center">추천</th>
					<th class="text-center">내용</th>
					<th class="text-center">비고</th>
				</tr>
			</thead>

			<tbody>
				<c:forEach var="reply" items="${replies }" varStatus="status">
					<tr class="hover">
						<td class="text-center">${status.count }</td>
						<td class="text-center">${reply.forPrintType1RegDate }</td>
						<td class="text-center">${reply.extra__writerName }</td>
						<td class="text-center">${reply.goodReactionPoint }</td>
						<td class="text-left">${reply.getForPrintBody() }</td>
						<td class="text-center">
							<c:if test="${reply.extra__actorCanModify }">
								<a class="btn btn-xs btn-ghost" href="../reply/doModify?id=${reply.id }">수정</a>
								<span> / </span>
							</c:if>
							<c:if test="${reply.extra__actorCanDelete }">
								<a class="btn btn-xs btn-ghost" href="../reply/doDelete?id=${reply.id }"
									onclick="if(comfirm('삭제 하시겠습니까?') == false) return false;">삭제</a>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</section>
<%@ include file="../common/foot.jspf"%>