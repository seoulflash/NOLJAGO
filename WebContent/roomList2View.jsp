<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<link rel="stylesheet" href="css/bootstrap.css">
	<link rel="stylesheet" href="css/noljaBooster.css">
	<title>심심할땐? 놀자GO! : 방탈출</title>
	<style type="text/css">
	#name{font-size: 30px;}
	#t1{
		margin-left: 500px;
		/* margin-top: 150px; */
	    border-spacing: 40px;
	    border-collapse: separate;

	}
	#t2{
		margin-top: 40px;
	}
	
	/* 카페 리스트 출력  */
	#tables{ float: left; display: inline;}
	
	/* 예약 버튼  */
	.button {
	   border: 0px solid #000000;
	   background: #db2c69;
	   background: -webkit-gradient(linear, left top, left bottom, from(#db2c69), to(#db2c69));
	   background: -webkit-linear-gradient(top, #db2c69, #db2c69);
	   background: -moz-linear-gradient(top, #db2c69, #db2c69);
	   background: -ms-linear-gradient(top, #db2c69, #db2c69);
	   background: -o-linear-gradient(top, #db2c69, #db2c69);
	   background-image: -ms-linear-gradient(top, #db2c69 0%, #db2c69 100%);
	   padding: 18px 36px;
	   -webkit-border-radius: 9px;
	   -moz-border-radius: 9px;
	   border-radius: 9px;
	   -webkit-box-shadow: rgba(255,255,255,0.4) 0 0px 0, inset rgba(255,255,255,0.4) 0 0px 0;
	   -moz-box-shadow: rgba(255,255,255,0.4) 0 0px 0, inset rgba(255,255,255,0.4) 0 0px 0;
	   box-shadow: rgba(255,255,255,0.4) 0 0px 0, inset rgba(255,255,255,0.4) 0 0px 0;
	   text-shadow: #ffffff 0 1px 0;
	   color: #ffffff;
	   font-size: 22px;
	   font-family: helvetica, serif;
	   text-decoration: none;
	   vertical-align: middle;
	}
	.button:hover {
	   border: 0px solid #0a3c59;
	   text-shadow: #ffffff 0 1px 0;
	   background: #fc9abc;
	   background: -webkit-gradient(linear, left top, left bottom, from(#fc9abc), to(#fc9abc));
	   background: -webkit-linear-gradient(top, #fc9abc, #fc9abc);
	   background: -moz-linear-gradient(top, #fc9abc, #fc9abc);
	   background: -ms-linear-gradient(top, #fc9abc, #fc9abc);
	   background: -o-linear-gradient(top, #fc9abc, #fc9abc);
	   background-image: -ms-linear-gradient(top, #fc9abc 0%, #fc9abc 100%);
	   color: #ededed;
	   }
	.button:active {
	   text-shadow: #1e4158 0 1px 0;
	   border: 0px solid #db2c69;
	   background: #ffffff;
	   background: -webkit-gradient(linear, left top, left bottom, from(#ffffff), to(#fc9abc));
	   background: -webkit-linear-gradient(top, #ffffff, #ffffff);
	   background: -moz-linear-gradient(top, #ffffff, #ffffff);
	   background: -ms-linear-gradient(top, #ffffff, #ffffff);
	   background: -o-linear-gradient(top, #ffffff, #ffffff);
	   background-image: -ms-linear-gradient(top, #ffffff 0%, #ffffff 100%);
	   color: #db2c69;
	   }
	.table-responsive {
		margin-bottom: 65px;
	}
	
	.res-box {
		margin-top: 50px;
		width: 50%;
	}   
	#resButton {
		border: none;
		color: white;
		font-weight: bold;
		background-color: #db2c69;
	}
	#like_cnt {
		margin-bottom: 0;
	}
	#content {
		font-size: 14px !important;
	}
	textarea {
		font-size: 14px;
	}
	</style>
</head>
<script type="text/javascript">
function like() {
		$.post('vrLike.do?id=${id}&cnum=${cnum}&tnum=${tnum}', function(msg){
			var num = msg.trim();
			var numArr = num.split('-');
			var likeCnt = numArr[0];
			var result = numArr[1];
			if(result == "1") {
				$("#like_cnt").text("좋아요 : "+likeCnt+"개");
				$("#img1").attr("src", "images/like2.png");
			}else if(result=="0"){
				$.post('vrLike2.do?id=${id}&cnum=${cnum}&tnum=${tnum}', function(msg){
					$("#like_cnt").text("좋아요 : "+likeCnt+"개");
					$("#img1").attr("src", "images/like.png");
					location.reload();
				});
			}
		});
}
</script>
<%@include file="menu.jsp" %>
<%------------ B O D Y ------------%>
<body>
<div class="container-fluid">
	<div class="table-responsive">
	<table id="tables">
		<tr>
			<td>
				<table id="t1">
						<tr id="name">
							<td id="tnameM" colspan="2"><b>${theme.tname }</b>
							<span style="color: #707070; font-size: 20px;"> - ${cafe.cname }
							</span>
							</td>
						</tr> 
					<tr>
						<td><img src="images/${theme.timage }" class="effect"
							width="500px" height="500px">
						<p></td>
					</tr>
				</table>
			</td>
			<td>
				<table id="t2">
					<tr>
						<td id="content"><h4>
						<textarea style="resize: none; wrap:hard; background-color: white; border-color: white; line-height: 3em;" rows="8" cols="50" name="contents" readonly="readonly" disabled="disabled">${theme.tcontent}
						</textarea></h4>
					</tr>
					<tr>
						<td id="content" style="font-size: 20px; color: gray;">최대 인원  : ${theme.headcount }</td>
						
					</tr>
					<tr>
						<td id="content" style="font-size: 20px; color: gray;">난이도  : <c:choose>
								<c:when test="${theme.score1 eq 1 }">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/e_star.png" width="25" height="20">
									<img src="images/e_star.png" width="25" height="20">
									<img src="images/e_star.png" width="25" height="20">
									<img src="images/e_star.png" width="25" height="20">
								</c:when>
								<c:when test="${theme.score1 eq 2}">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/e_star.png" width="25" height="20">
									<img src="images/e_star.png" width="25" height="20">
									<img src="images/e_star.png" width="25" height="20">
								</c:when>
								<c:when test="${theme.score1 eq 3}">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/e_star.png" width="25" height="20">
									<img src="images/e_star.png" width="25" height="20">
								</c:when>
								<c:when test="${theme.score1 eq 4}">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/e_star.png" width="25" height="20">
								</c:when>
								<c:when test="${theme.score1 eq 5}">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/f_star.png" width="25" height="20">
								</c:when>
							</c:choose>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	
	
		<div class="res-box center-block text-center form-inline">
			<div class="form-group text-center" style="margin-right: 30px;">
				<c:if test="${good_y==1 }">	<!-- 들어간 테마가 좋아요 클릭한 상태이면 꽉찬 하트 -->
					<a id="btn_like" onclick="like();"><img src="images/like2.png" id="img1" width="40" height="40" style=" background-color: white;"></a>
				</c:if>
				<c:if test="${good_y==0 }">	<!-- 아니면 빈 하트 -->
					<a id="btn_like" onclick="like();"><img src="images/like.png" id="img1" width="40" height="40" style=" background-color: white;"></a>
				</c:if>
				<p id="like_cnt">좋아요 : ${num}개</p>
			</div>
			<div class="form-group text-center">
				<a href="roomReserveForm.do?id=${id }&&cnum=${theme.cnum }&&tnum=${theme.tnum}" class="btn btn-default btn-lg" id="resButton">RESERVE</a>
			</div>
		</div>
	</div>
</div>	
</body>
</html>
<%@include file="footer.jsp" %>
