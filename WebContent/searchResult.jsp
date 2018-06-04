<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=e0FW3_z6emuYmYUng2py&submodules=geocoder"></script>
	<link rel="stylesheet" href="css/bootstrap.css">
	<link rel="stylesheet" href="css/noljaBooster.css">
	<title>심심할땐? 놀자GO! : 검색결과</title>
	<style type="text/css">

	.placemap-area {	/* gps를 담는 공간 */
    z-index: 1;
    position: fixed;
    top: 55px;
    right: 0;
    height: 100%;
    overflow: hidden;
	}
	
	.left-box {
		float:left;
	}
	
	 .right-box {
		width:800px;
		height:95%;
		position:relative;
		overflow:hidden;
	} 
	
	footer {
		clear:both;
	}
	
	#infoTd {
		width: 63.15%;
		vertical-align: middle;
		padding-top: 20px;
	}
	#table2 {
		width: 90%;
	}
	#table2 td {
		padding: 5px;
		border: none;
	}
	#first-in {
		padding-top: 20px !important;
		font-size: 16px;
		font-weight: bold;
	}
	#weekday {
		font-weight: bold;
		color: #1ca2e3;
	}
	#weekend {
		font-weight: bold;
		color: #dc281e;
	}
	#category {
		font-weight: bold;
	}
	#nosearch {
		margin-top: 25%;
	}
	.btn-line {
		margin-top: 30px;
	}
	#back {
		color: white;
		width: 150px;
		height: 50px;
		font-size: 20px;
		border: none;
		background-color: #005aa7;
	}
	#searchButton {
		border: 1px solid #005aa7;
		color: white;
		background-color: #005aa7;
	}
	.search-title {
		margin-top: 15px;
		margin-left: 20px;
		margin-bottom: 30px;
		width: 60%;
	}
	</style>
	
</head>
<%@include file="menu.jsp" %>
<%------------ B O D Y ------------%>
<body>
<div class="container">
	<!-- 본문  -->
	<c:if test="${fn:length(cslist) == 0}">
		<center id="nosearch">
			<h1> "${keyword}" </h1>
			<h1>검색 결과가 없습니다. 다시 한번 검색해주세요.</h1>
				<div class="row">
					<div class="col-md-8 col-md-offset-2">
						<form name = "search_engine" action="search.do" method="get" onsubmit="return keyword_check()">
						<div class="input-group">
							<input  name="keyword" class="form-control input-lg" type="search" 
							placeholder="주소, 가게명으로 검색: 예)마포 브이알존"/> 
							<span class="input-group-btn">
								<button class="btn btn-default btn-lg" type="submit" id="searchButton">GO!</button>
							</span>
						</div>
						</form>
					</div>
				</div>
				<div class="btn-line">
					<button type="button" class="btn btn-default btn-lg" id="back" onclick="history.back();">돌아가기</button>
				</div>
		</center>
	</c:if>
	
	<c:if test="${fn:length(cslist) != 0}">
	
    <div class = "left-box">
    	<div class="search-title">
			<form name = "search_engine" action="search.do" method="get" onsubmit="return keyword_check()">
				<div class="input-group">
				<input  name="keyword" class="form-control input-lg" id="searchbar" type="search" placeholder="주소, 가게명으로 검색: 예)마포 브이알존"/> 
				<span class="input-group-btn">
					<button class="btn btn-default btn-lg" type="submit" id="searchButton">GO!</button>
				</span>
				</div>
			</form>
		</div>
    <table class="table">
    <c:forEach var = "cafe" items="${cslist }">
   	<tr id="fullRow">
		<th id="mainImg" style="width: 20%;">
			<p id="g1">
			<c:if test="${cafe.type == 'vr'}">
				<a href="vrList1View.do?cnum=${cafe.cnum }&id=${id}">
				<img src="images/${cafe.image1 }" alt="vr 가게" width="250" height="250" style="vertical-align:text-top">
				</a>
			</c:if>
			
			<c:if test="${cafe.type == 'room'}">
				<a href="roomList.do?cnum=${cafe.cnum }&id=${id}">
				<img src="images/${cafe.image1 }" alt="room 가게" width="250" height="250" style="vertical-align:text-top">
				</a>
			</c:if>
			</p>
		</th>
		<td id="infoTd">
			<table class="table" id="table2">
				<tr>
					<td><span id="category">카페종류 :</span> ${cafe.type }</td>
				</tr>
				<tr>
					<td><span id="category">카페이름 :</span> ${cafe.cname }</td>
				</tr>
				<!-- <tr>
					<td><span id="category">카페평점 :</span>  
					<img src="images/f_star.png" alt="평점" width="20" height="20">
					<img src="images/f_star.png" alt="평점" width="20" height="20">
					<img src="images/f_star.png" alt="평점" width="20" height="20">
					<img src="images/f_star.png" alt="평점" width="20" height="20">
					</td>
				</tr> -->
				<tr>
					<td><span id="category">이용시간 :</span> ${cafe.open}:00 ~ ${cafe.close }:00</td>
				</tr>
				<tr>
					<td id="first-in">[1인 기준]</td>
				</tr>
				<tr>
					<td><span id="weekday">평일</span> - <fmt:formatNumber value="${cafe.price }" pattern="#,###"></fmt:formatNumber>원</td>
				</tr>
				<tr>
					<td><span id="weekend">주말</span> - <fmt:formatNumber value="${cafe.redprice }" pattern="#,###"></fmt:formatNumber>원</td>
				</tr>
			</table>
		</td>
	</tr>
	
	
	<script>
      var myaddress = '${cafe.caddress}';// 도로명 주소나 지번 주소만 가능 (건물명 불가!!!!)
      naver.maps.Service.geocode({address: myaddress}, function(status, response) {
          if (status !== naver.maps.Service.Status.OK) {
              return alert(myaddress + '의 검색 결과가 없습니다! 도로명으로 입력해주세요!');
          }
          var result = response.result;
          // 검색 결과 갯수: result.total
          // 첫번째 결과 결과 주소: result.items[0].address
          // 첫번째 검색 결과 좌표: result.items[0].point.y, result.items[0].point.x
          var myaddr = new naver.maps.Point(result.items[0].point.x, result.items[0].point.y);
          map.setCenter(myaddr); // 검색된 좌표로 지도 이동
          map.setZoom(9);
          // 마커 표시
          var marker = new naver.maps.Marker({
            position: myaddr,
            map: map
          });
          // 마커 클릭 이벤트 처리
          naver.maps.Event.addListener(marker, "click", function(e) {
            if (infowindow.getMap()) {
                infowindow.close();
            } else {
                infowindow.open(map, marker);
            }
          });
          // 마크 클릭시 인포윈도우 오픈
          var infowindow = new naver.maps.InfoWindow({
              content: '<h4> ${cafe.cname} </h4><a href=${cafe.curl} target="_blank"><img src="images/${cafe.image1 }" width="100px" height="100px"></a>'
          });
      });
    </script>
	
	</c:forEach>
	</table>
	</div>
	
	
	<%-- ${cslist[0].caddress} --%>
	<!-- 오른쪽에 GPS 뿌려주기  -->
	<section class = "placemap-area">
    <div class = "right-box" id="map">
    	<script>
    	var map = new naver.maps.Map('map');
    	</script>
	</div>
	</section>
	
	</c:if>	<!-- 검색결과 있는지에 대한 if절 -->
</div>	
</body>
</html>
