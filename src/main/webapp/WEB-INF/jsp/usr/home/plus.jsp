<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<link rel="stylesheet" href="/resource/common.css" />

<title>AJax Test</title>
</head>
<style>
.rs {
	border: 6px solid black;
	margin-top: 30px;
	padding: 20px;
	font-size: 3rem;
}

.rs-msg {
	border: 6px solid pink;
	margin-top: 30px;
	padding: 20px;
	font-size: 3rem;
}

.rs-Code {
	border: 6px solid skyblue;
	margin-top: 30px;
	padding: 20px;
	font-size: 3rem;
}
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

<script>
	function callByAjaxV2() {
		var form = document.form1;

		var num1 = form.num1.value;
		var num2 = form.num2.value;
		var action = form.action;

		$.get(action, {
			num1 : num1,
			num2 : num2
		}, function(data) {
			//  $('.rs').empty().append(data);
			$('.rs').text(data);
		}, 'html');

	}

	function callByAjaxV3() {
		var form = document.form1;

		var num1 = form.num1.value;
		var num2 = form.num2.value;
		var action = form.action;

		$.get(action, {
			num1 : num1,
			num2 : num2
		}, function(data) {
			data = data.split('/');
			var rs = data[0];
			var msg = data[1];

			$('.rs').text(rs);
			$('.rs-msg').text(msg);

		}, 'html');

	}

	function callByAjaxV4() {
		var form = document.form1;

		var num1 = form.num1.value;
		var num2 = form.num2.value;
		var action = form.action;

		$.get(action, {
			num1 : num1,
			num2 : num2
		}, function(data) {
			data = data.split('/');
			var rs = data[0];
			var msg = data[1];
			var code = data[2];

			$('.rs').text(rs);
			$('.rs-msg').text(msg);
			$('.rs-Code').text(code);

		}, 'html');

	}
	
	function callByAjaxV5() {
		var form = document.form1;

		var num1 = form.num1.value;
		var num2 = form.num2.value;
		
		var action = './doPlusJson';

		$.get(action, {
			num1 : num1,
			num2 : num2
		}, function(data) {
			var rs = data.rs;
			var msg = data.msg;
			var rsCode = data.code;

			$('.rs').text(rs);
			$('.rs-msg').text(msg);
			$('.rs-Code').text(rsCode);

		}, 'json');

	}
</script>
<body>
	<h1>Ajax ?????????</h1>

	<form name="form1" method="get" action="./doPlus">
		<div>
			<input type="text" name="num1" placeholder="?????? ??????" />
		</div>
		<div>
			<input type="text" name="num2" placeholder="?????? ??????" />
		</div>
		<div>
			<input type="submit" value="?????????" />
			<input onclick="callByAjaxV2();" type="button" value="?????????v2" />
			<input onclick="callByAjaxV3();" type="button" value="?????????v3" />
			<input onclick="callByAjaxV4();" type="button" value="?????????v4" />
			<input onclick="callByAjaxV5();" type="button" value="?????????v5" />
		</div>
	</form>

	<h2>?????? ??????</h2>

	<div class="rs"></div>

	<h2>?????? ?????? ?????????</h2>
	<div class="rs-msg"></div>

	<h2>?????? ?????? ????????? + ??????</h2>
	<div class="rs-Code"></div>
</body>
</html>
