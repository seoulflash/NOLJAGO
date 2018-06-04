<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<link rel="stylesheet" href="css/bootstrap.css">
	<link rel="stylesheet" href="css/noljaBooster.css">
	<title>심심할땐? 놀자GO! : V R</title>
	
<style type="text/css">
figure.snip1132 {
  font-family: 'Raleway', Arial, sans-serif;
  position: relative;
  float: left;
  overflow: hidden;
  margin: 10px 1%;
  min-width: 500px;
  max-width: 500px;
  max-height: 300px;
  width: 100%;
  background: #000000;
  color: #ffffff;
  text-align: center;
  box-shadow: 0 0 5px rgba(0, 0, 0, 0.15);
}
figure.snip1132:hover img,
figure.snip1132.hover img {
  opacity: 0.35;
  -webkit-transform: scale(1.15);
  transform: scale(1.15);
}
#name{font-size: 30px;}
#t1{
	margin-top: 60px;
	margin-left: 500px;
}
#t2{
	margin-left: 40px;
	margin-top: 100px;
	font-size: 1.5em;
}
#t2 td{height: 35px;}
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
</style>

<script type="text/javascript">
function like() {
		$.post('vrLike.do?id=${id}&cnum=${cnum}&tnum=${tnum}', function(msg){
			var num = msg.trim();	//공백을 없애고 보냄
			var numArr = num.split('-');
			var likeCnt = numArr[0];	//좋아요 개수
			var result = numArr[1];		 //좋아요 누르면 1
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

<script type="text/javascript">
$(".hover").mouseleave(
	    function () {
	      $(this).removeClass("hover");
	    }
	  );
</script>
</head>
<%@include file="menu.jsp" %>
<%------------ B O D Y ------------%>
<body>
<div class="container-fluid">
	<div class="table-responsive">
	<table>
		<tr>
			<td>
				<table id="t1">
					<tr id="name">
						<td><span style="margin-bottom: 30px;">${theme.tname }</span>
						<span style="color: #707070; font-size: 20px; margin-bottom: 30px;">- ${cafe.cname }</span>
						</td>
					</tr>
					<tr>
						<td>
						<img src="images/${theme.timage }" class="effect"
							width="600px" height="400px" style="margin-top: 30px;" >
						<p></td>
					</tr>
				</table>
			</td>
			<td>
				<table id="t2">
					<tr>
						<td id="content"><span style="color:gray;">장르: </span>액션 FPS</td>
					</tr>
					<tr>
						<td id="content"><span style="font-size: 18px;">${theme.tcontent }</span></td>
					</tr>
					<tr>
						<td id="content"><span style="color:gray; font-size: 18px;">최대 인원: </span>${theme.headcount }</td>
					</tr>
					<tr>
						<td id="content"><span style="color:gray; font-size: 18px;">난이도:</span> <c:choose>
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
					<tr>
						<td id="content"><span style="color:gray; font-size: 18px;">스릴감:</span> <c:choose>
								<c:when test="${theme.score2 eq 1 }">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/e_star.png" width="25" height="20">
									<img src="images/e_star.png" width="25" height="20">
									<img src="images/e_star.png" width="25" height="20">
									<img src="images/e_star.png" width="25" height="20">
								</c:when>
								<c:when test="${theme.score2 eq 2}">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/e_star.png" width="25" height="20">
									<img src="images/e_star.png" width="25" height="20">
									<img src="images/e_star.png" width="25" height="20">
								</c:when>
								<c:when test="${theme.score2 eq 3}">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/e_star.png" width="25" height="20">
									<img src="images/e_star.png" width="25" height="20">
								</c:when>
								<c:when test="${theme.score2 eq 4}">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/e_star.png" width="25" height="20">
								</c:when>
								<c:when test="${theme.score2 eq 5}">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/f_star.png" width="25" height="20">
								</c:when>
							</c:choose>
						</td>
					</tr>
					<tr>
						<td id="content"><span style="color:gray; font-size: 18px;">공포감:</span> <c:choose>
								<c:when test="${theme.score3 eq 1 }">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/e_star.png" width="25" height="20">
									<img src="images/e_star.png" width="25" height="20">
									<img src="images/e_star.png" width="25" height="20">
									<img src="images/e_star.png" width="25" height="20">
								</c:when>
								<c:when test="${theme.score3 eq 2}">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/e_star.png" width="25" height="20">
									<img src="images/e_star.png" width="25" height="20">
									<img src="images/e_star.png" width="25" height="20">
								</c:when>
								<c:when test="${theme.score3 eq 3}">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/e_star.png" width="25" height="20">
									<img src="images/e_star.png" width="25" height="20">
								</c:when>
								<c:when test="${theme.score3 eq 4}">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/e_star.png" width="25" height="20">
								</c:when>
								<c:when test="${theme.score3 eq 5}">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/f_star.png" width="25" height="20">
								</c:when>
							</c:choose>
						</td>
					</tr>
					<tr>
						<td id="content"><span style="color:gray; font-size: 18px;">볼거리: </span><c:choose>
							<c:when test="${theme.score4 eq 1 }">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/e_star.png" width="25" height="20">
									<img src="images/e_star.png" width="25" height="20">
									<img src="images/e_star.png" width="25" height="20">
									<img src="images/e_star.png" width="25" height="20">
								</c:when>
								<c:when test="${theme.score4 eq 2}">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/e_star.png" width="25" height="20">
									<img src="images/e_star.png" width="25" height="20">
									<img src="images/e_star.png" width="25" height="20">
								</c:when>
								<c:when test="${theme.score4 eq 3}">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/e_star.png" width="25" height="20">
									<img src="images/e_star.png" width="25" height="20">
								</c:when>
								<c:when test="${theme.score4 eq 4}">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/f_star.png" width="25" height="20">
									<img src="images/e_star.png" width="25" height="20">
								</c:when>
								<c:when test="${theme.score4 eq 5}">
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

	<%-- <a href="vrLike.do?id=${id }&&cnum=${theme.cnum }&&tnum=${theme.tnum }">
		<img src="images/wish.JPG" id="img1" width="40" height="40" style="margin-left: 1200px;">
	</a>  --%>
	
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
				<a href="vrReserveView.do?id=${id }&&cnum=${theme.cnum }&&tnum=${theme.tnum}" class="btn btn-default btn-lg" id="resButton">RESERVE</a>
			</div>
		</div>
	</div>
</div>
</body>
</html>
<%@include file="footer.jsp" %>