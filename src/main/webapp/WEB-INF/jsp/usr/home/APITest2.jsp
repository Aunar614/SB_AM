<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="API Test2" />
<%@ include file="../common/head.jspf"%>

<div class="flex justify-center">
	<div id="map" style="width: 1500px; height: 600px;"></div>
</div>
<p class="flex justify-center mt-2">
    <button class="mx-1" onclick="setCenter()">지도 중심좌표 이동시키기</button> 
    <button class="mx-1" onclick="panTo()">지도 중심좌표 부드럽게 이동시키기</button> 
</p>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d21bace87998dd74562d60f54b1a0b69"></script>
<script>
	// 현충원 위치 API
	const API_KEY = 'Lo2yEarv%2FeEYrur4bpBb3TmL5TwdJUuSvCoKd0EPYyAm7STk5qL64zoV%2Brxf%2BjHV7e%2FwvqR%2F0xIArFTlu8Vbew%3D%3D';
	var Lalocation;
	var Lolocation;
	
	// API를 쓰기 위한 기본
	// async와 await를 같이 쓰면 좋다
	async function getData() {
		const url = 'http://apis.data.go.kr/1180000/DaejeonNationalCemetery/Burialinfo042?name=홍길동&pageNo=1&numOfRows=50&serviceKey='
				+ API_KEY;
		const response = await fetch(url);
		const data = await response.json();
		console.log("data", data);
		
		Lalocation = data.body[0].latitude;
		Lolocation = data.body[0].longitude;
		console.log(Lalocation);
		console.log(Lolocation);
	}
	
	getData();

	// 지도 API
	//지도를 담을 영역의 DOM 레퍼런스
	var container = document.getElementById('map');
	
	//지도를 생성할 때 필요한 기본 옵션
	var options = {
		center : new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
		level : 3
	//지도의 레벨(확대, 축소 정도)
	};
	
	//지도 생성 및 객체 리턴
	var map = new kakao.maps.Map(container, options);
	
	function setCenter() {            
	    // 이동할 위도 경도 위치를 생성합니다 
	    var moveLatLon = new kakao.maps.LatLng(33.452613, 126.570888);
	    
	    // 지도 중심을 이동 시킵니다
	    map.setCenter(moveLatLon);
	}
	const lat = 36.3701311788239;
	const lot = 127.298272866466;
	
	function panTo() {
	    // 이동할 위도 경도 위치를 생성합니다 
	    console.log("위도 + " + Lalocation)
	    console.log("경도 + " + Lolocation)
	    var moveLatLon = new kakao.maps.LatLng(lat, lot);
	    
	    // 지도 중심을 부드럽게 이동시킵니다
	    // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
	    map.panTo(moveLatLon);            
	}   

	// 마커가 표시될 위치입니다 
	var markerPosition  = new kakao.maps.LatLng(lat, lot); 

	// 마커를 생성합니다
	var marker = new kakao.maps.Marker({
    position: markerPosition
	});

	// 마커가 지도 위에 표시되도록 설정합니다
	marker.setMap(map);

	// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
	// marker.setMap(null); 
</script>

<%@ include file="../common/foot.jspf"%>