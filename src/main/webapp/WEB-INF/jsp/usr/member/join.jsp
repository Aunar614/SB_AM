<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="JOIN" />
<%@ include file="../common/head.jspf"%>

<!-- lodash debounce -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js" referrerpolicy="no-referrer"></script>

<script>
	let submitJoinFormDone = false;
	let validLoginId = "";

	function submitJoinForm(form) {
		if (submitJoinFormDone) {
			alert('처리중입니다');
			return;
		}

		form.loginId.value = form.loginId.value.trim();
		if (form.loginId.value == 0) {
			alert('아이디를 입력해주세요');
			form.loginId.focus();
			return;
		}

		if (form.loginId.value != validLoginId) {
			alert('사용할 수 없는 아이디입니다');
			form.loginId.focus();
			return;
		}

		form.loginPw.value = form.loginPw.value.trim();
		if (form.loginPw.value == 0) {
			alert('비밀번호를 입력해주세요');
			form.loginPw.focus();
			return;
		}

		form.loginPwConfirm.value = form.loginPwConfirm.value.trim();
		if (form.loginPwConfirm.value == 0) {
			alert('비밀번호 확인을 입력해주세요');
			form.loginPwConfirm.focus();
			return;
		}

		if (form.loginPwConfirm.value != form.loginPw.value) {
			alert('비밀번호가 일치하지 않습니다');
			form.loginPw.focus();
			return;
		}

		form.name.value = form.name.value.trim();
		if (form.name.value == 0) {
			alert('이름을 입력해주세요');
			form.name.focus();
			return;
		}

		form.nickname.value = form.nickname.value.trim();
		if (form.nickname.value == 0) {
			alert('닉네임을 입력해주세요');
			form.nickname.focus();
			return;
		}

		form.email.value = form.email.value.trim();
		if (form.email.value == 0) {
			alert('이메일을 입력해주세요');
			form.email.focus();
			return;
		}

		form.cellphoneNum.value = form.cellphoneNum.value.trim();
		if (form.cellphoneNum.value == 0) {
			alert('전화번호를 입력해주세요');
			form.cellphoneNum.focus();
			return;
		}

		submitJoinFormDone = true;
		form.submit();
	}

	// 아이디 중복 체크
	function checkLoginIdDup(el) {
		$('.loginId-msg').html('<div class="mt-3"> checking </div>')
		const form = $(el).closest('form').get(0);

		if (form.loginId.value.length == 0) {
			validLoginId = '';
			return;
		}

		if (validLoginId == form.loginId.value) {
			return;
		}

		$.get('../member/getLoginIdDup', {
			isAjax : 'Y',
			loginId : form.loginId.value
		}, function(data) {
			$('.loginId-msg').html('<div class="mt-3">' + data.msg + '</div>')
			if (data.success) {
				validLoginId = data.data1;
			} else {
				validLoginId = '';
			}

			if (data.resultCode == 'F-B') {
				alert(data.msg);
				location.replace('/');
			}
		}, 'json');
	}

	const checkLoginIdDupDebounced = _.debounce(checkLoginIdDup, 500);
</script>

<section class="mt-8">
	<div class="container mx-auto px-3">
		<form class="table-box-type-1" method="POST" enctype="multipart/form-data" action="../member/doJoin"
			onsubmit="submitJoinForm(this); return false;">
			<input type="hidden" name="afterLoginUri" value="${param.afterLoginUri}" />
			<table class="table table-zebra w-full">
				<colgroup>
					<col width="200" />
				</colgroup>

				<tbody>
					<tr>
						<th>아이디</th>
						<td>
							<input name="loginId" class="w-full input input-bordered  max-w-xs" placeholder="아이디를 입력해주세요"
								onkeyup="checkLoginIdDupDebounced(this);" autocomplete="off" />
							<div class="loginId-msg"></div>
						</td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td>
							<input class="input input-bordered w-full max-w-xs" type="password" name="loginPw" placeholder="비밀번호를 입력해주세요" />
						</td>
					</tr>
					<tr>
						<th>비밀번호 확인</th>
						<td>
							<input name="loginPwConfirm" class="w-full input input-bordered  max-w-xs" type="password"
								placeholder="비밀번호 확인을 입력해주세요" />
						</td>
					</tr>
					<tr>
						<th>이름</th>
						<td>
							<input name="name" class="w-full input input-bordered  max-w-xs" placeholder="이름을 입력해주세요" />
						</td>
					</tr>
					<tr>
						<th>닉네임</th>
						<td>
							<input name="nickname" class="w-full input input-bordered  max-w-xs" placeholder="닉네임을 입력해주세요" />
						</td>
					</tr>
					<tr>
						<th>프로필 이미지</th>
						<td>
							<input type="file" name="profileImg" placeholder="프로필 이미지를 선택해주세요" />
						</td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td>
							<input name="cellphoneNum" class="w-full input input-bordered  max-w-xs" placeholder="전화번호를 입력해주세요" />
						</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td>
							<input name="email" class="w-full input input-bordered  max-w-xs" placeholder="이메일을 입력해주세요" />
						</td>
					</tr>
					<tr>
						<th></th>
						<td>
							<button type="submit">회원가입</button>
						</td>
					</tr>
				</tbody>

			</table>
		</form>
		<div class="flex justify-end mt-2">
			<button class="btn btn-xs btn-primary" type="button" onclick="history.back();">뒤로가기</button>
		</div>
	</div>

</section>
<%@ include file="../common/foot.jspf"%>