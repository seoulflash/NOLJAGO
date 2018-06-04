<%@page import="dao.MemberDAO"%>
<%@page import="dao.Member"%>
<%@page import="java.util.StringTokenizer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<title>심심할땐? 놀자GO!</title>
	<%
		request.setCharacterEncoding("utf-8");
		int cnum = Integer.parseInt(request.getParameter("cnum"));
		int tnum = Integer.parseInt(request.getParameter("tnum"));
		int count = Integer.parseInt(request.getParameter("count"));
		//System.out.println("count--->" + count);
		String name = request.getParameter("leadername");
		String id = request.getParameter("id");
		System.out.println(id);
		MemberDAO md = MemberDAO.getInstance();
		Member member = new Member();
		member = md.getUserInfo(id);
		int perprice =Integer.parseInt(request.getParameter("perprice")); //인당 가격
		String hopedate = null;
		int hopehour = 0;
		int endtime = 0;
		String keyword = request.getParameter("time");
    	StringTokenizer strToken = new StringTokenizer(keyword, ":");    // : 로 분리
		String first = strToken.nextToken();
		hopedate = request.getParameter("date");
		hopehour = Integer.parseInt(first);
	%>
	<style type="text/css">
		input{
			border: none;
			outline: none;
		}
	</style>
	<script type="text/javascript">
	 	$(function() {
	    });
	 	$(window).on('load', function(){
	 		var count = "<%=count%>";
	 		console.log(count);
	 		document.getElementById(count).selected = true;
	 	});	
		function goMain() {
			alert("메인 화면으로 이동합니다.");
			opener.location.href='main.do';
			self.close();
		}
		function createPCheak() {
			var form = document.partyCreateForm;
			var cnum = "<%=cnum %>";
			var tnum = "<%=tnum %>";
			var hopedate =  "<%=hopedate %>";
			var hopehour =  "<%=hopehour %>";
			var id = "<%=id %>";
			var perprice = "<%=perprice %>";
			var price = Number(perprice);
			var pointstr = "<%=member.getPoint() %>";
			var mempoint = Number(pointstr);
			
			var sendData = "cnum="+cnum+"&tnum="+tnum+"&hopedate="+hopedate+"&hopehour="+hopehour+"&id="+id;
			var sendD = "hopedate="+hopedate+"&hopehour="+hopehour+"&id="+id;
			
			console.log(sendData);
			console.log(sendD)
			$.post('partyCheck.jsp',sendData,function(result) {	 	//같은 카페 같은 테마로 가는 파티가 있을경우
				if(result.trim() == "1") {	//완전 동일하고, 내가 파티장인 파티가 있는경우
					alert("당신은 이미 동일한 파티를 소유한 파티장이에요! 파티페이지를 확인해주세요!");
					return;
				} else {	//테스트 통과. 같은 테마, 같은 카페에 가는 다른 파티가 있는지 확인
					$.post('partyRecommend.jsp', sendData, function(recresult) {
						
						var pnumjson = JSON.parse(recresult);
						if (Object.keys(pnumjson).length == 0) {	//추천할 카페 없음
							
							$.post('resCheck.jsp',sendD,function(res) {
								if (res.trim() == "-1") {
									alert("회원님은 같은 날짜, 같은 시간에 이미 다른예약이 있습니다. 마이페이지를 확인해주세요.")
									return;
								} else { //예약체크 통과
									
									if (confirm("파티 생성시 예약접수를 위해 자동으로 "+price+"포인트가 차감됩니다. 계속하시겠습니까?")) {
										if (price > mempoint)	// 가격이 유저포인트보다 더 비싸면
										{
											if (confirm("회원님의 포인트가 모자른데.. 충전하러 Go?!!")) {
												window.open('addPoint.do?id=${id}', 'AddPoint', 'width=500px,height=500px')
											} else {
												alert("결제 취소 되었다Go!");
												return;
											}
										} else {
											form.submit();	//partycreate.do로 이동
										}
										
									} else {
										alert("파티 생성을 취소합니다.");
										return;
									}
									
								}
							})
							
						} else {	//추천할 카페 있을 때 
							if(confirm("같은 카페, 같은 테마로 가는 다른 파티가 있습니다. 보러 Go?")) {	//추천 질문
								var pnumarray = [];
								for (key in pnumjson) {
									pnumarray.push(pnumjson[key]);
								}
								console.log(pnumarray[0]);
								pnumarray.sort(function(a, b){return b - a});
								console.log(pnumarray[0]);
								
								$("#pnumlist").val(pnumarray);
								window.opener.name = "parentPage"; 		// 부모창의 이름 설정
								form.target = "parentPage";
								form.action = "partyrecommend.do"		//부모 페이지를 추천하는 페이지로 넘김
								form.submit();
								self.close();								
							} else {	//추천 거절 햇을 시에 파티 생성 프로세스
								
								
								//예약 체크 먼저
								$.post('resCheck.jsp',sendD,function(res) {
									if (res.trim() == "-1") {
										alert("회원님은 같은 날짜, 같은 시간에 이미 다른예약이 있습니다. 마이페이지를 확인해주세요.")
										return;
									} else { //예약체크 통과
										
										if (confirm("파티 생성시 예약접수를 위해 자동으로 "+price+"포인트가 차감됩니다. 계속하시겠습니까?")) {
											if (price > mempoint)	// 가격이 유저포인트보다 더 비싸면
											{
												if (confirm("회원님의 포인트가 모자른데.. 충전하러 Go?!!")) {
													window.open('addPoint.do?id=${id}', 'AddPoint', 'width=500px,height=500px')
												} else {
													alert("결제 취소 되었다Go!");
													return;
												}
											} else {
												form.submit();	//partycreate.do로 이동
											}
											
										} else {
											alert("파티 생성을 취소합니다.");
											return;
										}
										
									}
								})
								
							}
							
						}
					})
				}
			})
			
		}
	</script>
</head>

<body>
	<form action="partyCreate.do" method="post" name="partyCreateForm">
		<input type="hidden" value="<%=id %>" name="id">
		<input type="hidden" value="<%=cnum %>" name="cnum">
		<input type="hidden" value="<%=tnum %>" name="tnum">
		<input type="hidden" value="<%=hopedate %>" name="hopedate">
		<input type="hidden" value="<%=hopehour %>" name="hopehour">
		<input type="hidden" value="<%=perprice %>" name="perprice">
		<input type="hidden" id="pnumlist" name="pnumlist" >
		<div style="margin-top: 50px; margin-left: 100px;">
		<label><span style="font-size: 20px; color: gray;"> 파티장   :</span></label>
		<span ><%=name %>님</span><br>
		<label><span style="font-size: 20px; color: gray; line-height:40px; margin-top: 50px;">희망 날짜 :</span></label>
		<%=hopedate %><br>
		<label><span style="font-size: 20px; color: gray;">희망 시간 :</span></label>
		<%=hopehour %>시<br>
		<label><span style="font-size: 20px; color: gray; line-height:40px;">파티 인원 :</span></label>
		<select name="max" id="max">
			<c:forEach var="i" begin="2" end="8">
				<option id="${i}" value="${i}" >${i} 명</option>
			</c:forEach>
		</select><br>
		<label><span style="font-size: 20px; color: gray;">차감 포인트 :</span></label>
		<%=perprice %> P<br>
		<label><span style="font-size: 20px; color: gray; line-height:40px;">추가 내용 :</span></label><br>
		<textarea rows="5" cols="30" name="pcontent"></textarea><br>
		<input type="button" value="파티 생성"  style="background-color:#005aa7; color:white; margin-left: 10px; padding: 8px; margin-top: 17px; font-size: 15px;" onclick="javascript:createPCheak();">
		<input type="button" value="메인 화면으로" style="background-color:#005aa7; color:white; padding: 8px; font-size: 15px; margin-left: 5px;" onclick="goMain();">
		</div>
	</form>
</body>
</html>