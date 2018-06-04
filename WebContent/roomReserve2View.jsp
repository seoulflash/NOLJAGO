<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>심심할땐? 놀자GO! : 예약하기</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<link rel="stylesheet" href="css/bootstrap.css">
	<link rel="stylesheet" href="css/noljaBooster.css">
	<style type="text/css">

	#reserveList {
		    list-style:none;
		    margin:0;
		    padding:0;
		}
	#reserveList2 {
			 margin: 2px;
			display:block;
			 width:33%;
		    height:40px;
		    background:#bdbdbd;
		    color:white;
		    float: left;
		    font-weight: 200;
		    font-size: 1.5em;
		    text-align: center;
		}


	 table.type04 {
	    border-collapse: separate;
	    border-spacing: 1px;
	    text-align: left;
	    line-height: 1.5;
	    border-top: 1px solid #ccc;
	 	 margin : 20px 10px;
		}
	  table.type04 th {
	    width: 150px;
	    padding: 10px;
	    font-weight: bold;
	    vertical-align: top;
	    border-bottom: 1px solid #ccc;
	  }
   	  table.type04 td {
	    width: 350px;
	    padding: 10px;
	    vertical-align: top;
	    border-bottom: 1px solid #ccc;
	  }
	  
	  
	  
	  /* 파티 버튼 */
	  .PButton {
	   border: 0px solid #fffcfe;
	   background: #b8b8b8;
	   background: -webkit-gradient(linear, left top, left bottom, from(#b8b8b8), to(#b8b8b8));
	   background: -webkit-linear-gradient(top, #b8b8b8, #b8b8b8);
	   background: -moz-linear-gradient(top, #b8b8b8, #b8b8b8);
	   background: -ms-linear-gradient(top, #b8b8b8, #b8b8b8);
	   background: -o-linear-gradient(top, #b8b8b8, #b8b8b8);
	   background-image: -ms-linear-gradient(top, #b8b8b8 0%, #b8b8b8 100%);
	   padding: 12px 24px;
	   -webkit-border-radius: 8px;
	   -moz-border-radius: 8px;
	   border-radius: 8px;
	   -webkit-box-shadow: rgba(255,255,255,0.4) 0 0px 0, inset rgba(255,255,255,0.4) 0 0px 0;
	   -moz-box-shadow: rgba(255,255,255,0.4) 0 0px 0, inset rgba(255,255,255,0.4) 0 0px 0;
	   box-shadow: rgba(255,255,255,0.4) 0 0px 0, inset rgba(255,255,255,0.4) 0 0px 0;
	   text-shadow: #ffffff 0 1px 0;
	   color: #ffffff;
	   font-size: 19px;
	   font-family: Sans-Serif;
	   text-decoration: none;
	   vertical-align: middle;
	   }
	.PButton:hover {
	   border: 0px solid #ffffff;
	   text-shadow: #ffffff 0 1px 0;
	   background: #37ace6;
	   background: -webkit-gradient(linear, left top, left bottom, from(#37ace6), to(#37ace6));
	   background: -webkit-linear-gradient(top, #37ace6, #37ace6);
	   background: -moz-linear-gradient(top, #37ace6, #37ace6);
	   background: -ms-linear-gradient(top, #37ace6, #37ace6);
	   background: -o-linear-gradient(top, #37ace6, #37ace6);
	   background-image: -ms-linear-gradient(top, #37ace6 0%, #37ace6 100%);
	   color: #fff;
	   }
	.PButton:active {
	   text-shadow: #ffffff 0 1px 0;
	   border: 0px solid #ffffff;
	   background: #d90f74;
	   background: -webkit-gradient(linear, left top, left bottom, from(#d90f74), to(#37ace6));
	   background: -webkit-linear-gradient(top, #d90f74, #d90f74);
	   background: -moz-linear-gradient(top, #d90f74, #d90f74);
	   background: -ms-linear-gradient(top, #d90f74, #d90f74);
	   background: -o-linear-gradient(top, #d90f74, #d90f74);
	   background-image: -ms-linear-gradient(top, #d90f74 0%, #d90f74 100%);
	   color: #fff;
	   }
	  
	  
	  
	  /* 예약 버튼 */
	  .button {
	   border: 0px solid #fffcfe;
	   background: #b8b8b8;
	   background: -webkit-gradient(linear, left top, left bottom, from(#b8b8b8), to(#b8b8b8));
	   background: -webkit-linear-gradient(top, #b8b8b8, #b8b8b8);
	   background: -moz-linear-gradient(top, #b8b8b8, #b8b8b8);
	   background: -ms-linear-gradient(top, #b8b8b8, #b8b8b8);
	   background: -o-linear-gradient(top, #b8b8b8, #b8b8b8);
	   background-image: -ms-linear-gradient(top, #b8b8b8 0%, #b8b8b8 100%);
	   padding: 12px 24px;
	   -webkit-border-radius: 8px;
	   -moz-border-radius: 8px;
	   border-radius: 8px;
	   -webkit-box-shadow: rgba(255,255,255,0.4) 0 0px 0, inset rgba(255,255,255,0.4) 0 0px 0;
	   -moz-box-shadow: rgba(255,255,255,0.4) 0 0px 0, inset rgba(255,255,255,0.4) 0 0px 0;
	   box-shadow: rgba(255,255,255,0.4) 0 0px 0, inset rgba(255,255,255,0.4) 0 0px 0;
	   text-shadow: #ffffff 0 1px 0;
	   color: #ffffff;
	   font-size: 19px;
	   font-family: helvetica, serif;
	   text-decoration: none;
	   vertical-align: middle;
	   }
	.button:hover {
	   border: 0px solid #ffffff;
	   text-shadow: #ffffff 0 1px 0;
	   background: #d90f74;
	   background: -webkit-gradient(linear, left top, left bottom, from(#d90f74), to(#d90f74));
	   background: -webkit-linear-gradient(top, #d90f74, #d90f74);
	   background: -moz-linear-gradient(top, #d90f74, #d90f74);
	   background: -ms-linear-gradient(top, #d90f74, #d90f74);
	   background: -o-linear-gradient(top, #d90f74, #d90f74);
	   background-image: -ms-linear-gradient(top, #d90f74 0%, #d90f74 100%);
	   color: #fff;
	   }
	.button:active {
	   text-shadow: #ffffff 0 1px 0;
	   border: 0px solid #ffffff;
	   background: #d90f74;
	   background: -webkit-gradient(linear, left top, left bottom, from(#d90f74), to(#d90f74));
	   background: -webkit-linear-gradient(top, #d90f74, #d90f74);
	   background: -moz-linear-gradient(top, #d90f74, #d90f74);
	   background: -ms-linear-gradient(top, #d90f74, #d90f74);
	   background: -o-linear-gradient(top, #d90f74, #d90f74);
	   background-image: -ms-linear-gradient(top, #d90f74 0%, #d90f74 100%);
	   color: #fff;
	   }
	   
	   
	   
	   

	</style>
	<script type="text/javascript">
		function test1(){
		    var value = $("#sel_test1 option:selected").val();
			return value;
		}
		function partySubmit(){
			if (document.getElementById("agreey").checked) {
				var count = $("#count").val();		//인원수 갖고오기
				if (count == 1) {	//혼자서 파티 생성을 누르면
					alert("혼자서는 파티 생성을 할 수 없어요!!");
					return;
				}
				var fName = document.formName;
				window.open('','infoSelect','width=500px,height=500px');
				fName.target = "infoSelect";
				fName.action = "partyInfoSelectPop.jsp";
				fName.submit();
			} else {
				alert("이용약관에 동의해주셔야 진행이 가능합니다.");
				return;
			}
		}function personSubmit(){
			if (document.getElementById("agreey").checked) {
				var fName = document.formName;
				var price = document.getElementById("totprice").value;
				var mempoint = '${member.point}';
				var point1 = Number(mempoint);		//int로 강제변환. 안하면 에러남
				var date = '${date}';
				var time = '${time}';
				
				var hourstr = time.split(":");
				var hour = hourstr[0];
				
				var id = '${id}';
				var sendData = "hopedate="+date+"&hopehour="+hour+"&id="+id;
				console.log(sendData);
				
				$.post('resCheck.jsp', sendData, function(result) {
					if (result.trim() == "-1") {	//이미 예약있으면 막음
						alert("회원님은 같은 날짜, 같은 시간에 이미 다른예약이 있습니다. 마이페이지를 확인해주세요.");
						return;
					}
					else {	// 예약 없으면 통과
						if (confirm("회원님의 포인트에서 "+price+"만큼 차감됩니다.") ) {
							if (price > point1)	// 가격이 유저포인트보다 더 비싸면
							{
								if (confirm("회원님의 포인트가 모자른데.. 충전하러 Go?!!")) {
									window.open('addPoint.do?id=${id}', 'AddPoint', 'width=500px,height=500px')
								} else {
									alert("결제 취소 되었다Go!");
									return;
								}
							} else {
								fName.action = "roomReserve3.do?price="+price;
								fName.submit();
							}
						} else {
							return;
						}
					}
				})
				
				
			} else {
				alert("이용약관에 동의해주셔야 진행이 가능합니다.");
				return;
			}
			
		}
		
		/* 예약 인원수에 따른 가격 변동을 jQuery로 뿌려주기 */
		function priceChange() {
			var count = $("#count").val();
			var price = '${price}' * count;
			console.log(price);
			document.getElementById("totprice").value = price;
		}
	</script>

</head>
<%@include file="menu.jsp" %>
<%------------ B O D Y ------------%>
<body>
	<div style="margin: auto;">
		<img src="images/${cafe.image2 }" class="img-responsive" alt="Responsive image" style="margin: auto;">

		<div id="top" style="margin-top: 50px; margin-bottom: 30px;">
			<ul id="reserveList">
				<li id="reserveList2">01. 날짜/시간 선택</li>
				<li id="reserveList2" style="background-color: #1ca2e3;">02. 예약 정보 입력</li>
				<li id="reserveList2">03. 예약 완료</li>
			</ul>
		</div>
	</div>
	


	<form action="" name = "formName" method="post" style="margin-bottom: 70px;">
	<input type="hidden" name="cnum" value="${cnum }">
	<input type="hidden" name="tnum" value="${tnum }">
	<input type="hidden" name="id" value="${id }">
	<input type="hidden" name="date" value="${date }">
	<input type="hidden" name="time" value="${time }">
	<input type="hidden" name="leadername" value="${member.name }">
	<input type="hidden" name="mempoint" value="${member.point }">
	<input type="hidden" name="perprice" value="${price}">

	<div style="margin-top: 125px;">
	<table class="type04" style="margin:auto; margin-top: 50px;">
		<tr>
			<th scope="row">테마(Room)</th>
			<td>${theme.tname }</td>
		</tr>
		<tr>
			<th scope="row">예약일시(Date)</th>
			<td>${date}</td>
		</tr>
		<tr>
			<th scope="row">시간</th>
			<td>${time }</td>
		</tr>
		<tr>
			<th scope="row">인원(Players)</th>
			<td><select name="count" id="count" onchange="priceChange()">
		            <option value="1">1</option>
		            <option value="2">2</option>
		            <option value="3">3</option>
		            <option value="4">4</option>
		            <option value="5">5</option>
		            <option value="6">6</option>
		            <option value="7">7</option>
		            <option value="8">8</option>
	            </select> 명</td>
		</tr>
		<tr>
			<th scope="row">예약자</th>
			<td>${member.name }</td>
		</tr>
		<tr>
			<th scope="row">연락처</th>
			<td><input type="text" hidden="tel">${member.tel }</td>
		</tr>
		<tr>
			<th scope="row">이메일</th>
			<td><input type="email" hidden="r_email">${member.email }</td>
		</tr>
		<tr>
			<th scope="row">총이용요금</th>
			<td><input type="text" id="totprice" name="price" value="${price}" disabled="disabled" style="background-color: white; border-style:none; "></td>
		</tr>
	</table>
	</div>
	<p><p>
	<div style="color: red; margin-top: 20px;" align="center">
		※ 게임시작 1시간 전에 예약확인 전화를 드리는데, 통화가 되지 않을 경우 자동 예약취소가 되니 이점 양지하여 주시기 바랍니다.<br>
	</div>
	<div align="center" style="color: red; margin-top: 8px;">※ 게임 시작 시간 10분전까지 매장 내방해주시기 바랍니다.</div>
	<p>
	<div align="center" style="margin-top: 20px;"><textarea style="resize: none; background-color: white; wrap:hard" readonly="readonly" disabled="disabled" rows="5" cols="80" name="contents">
개인정보 수집, 이용 및 제공 등에 관한 고지사항
이용자 본인은 아래의 개인정보가 사실임을 확인하며, 아래와 같이 개인정보를 수집 및 이용하는 것에 동의합니다.
[개인정보의 수집 및 이용목적]
- 비회원 예매서비스 제공
- 예약 정보를 확인 및 관리하고, 필요 시 예약 이행 여부 확인을 위해 예약자에게 연락을 취할 목적 등
[수집하는 개인정보의 항목]
- 필수입력사항 : 이용자의 식별을 위한 정보
- 입력정보 : 이름, 휴대폰번호, 이메일 주소
		</textarea>
	</div>
	<div align="center" style="margin-bottom: 20px; margin-top: 12px;">
	<input type="radio" name="agree" id="agreey" value="agreeY" required = "required"/>개인정보처리방침에 동의함
	<input type="radio" name="agree" id="agreen" value="agreeN" checked="checked"/>개인정보처리방침에 동의하지 않음
	</div><p>
	<div align="center" style="margin-top: 20px;">
		<input type="button" onclick="partySubmit();" value="파티 생성" class="PButton" style="margin-top:20px; margin-right: 30px;">
		<input type="button" onclick="personSubmit();" value="RESERVE" class="button" style="margin-top:20px;">
	</div>
	</form>
	<p>

</body>
</html>
<%@include file="footer.jsp" %>