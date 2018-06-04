<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/noljaBooster.css">
<link rel="stylesheet" href="imageView.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="js/bootstrap.js"></script>
<title>후기 작성 게시판</title>
<style type="text/css">
.search-container button {
	float: right;
	padding: 6px 10px;
	margin-top: 10px;
	margin-right: 16px;
	background: #ddd;
	font-size: 17px;
	border: none;
	cursor: pointer;
}
</style>
<script type="text/javascript">
function btn1() {
	var i1 =document.getElementById("i1");
	if(i1.src.match("images/e_star.png")) i1.src="images/f_star.png";
	else i1.src="images/e_star.png";
	return false;
}
function btn2() {
	var i2 =document.getElementById("i2");
	if(i2.src.match("images/e_star.png")){
	i1.src="images/f_star.png";
	i2.src="images/f_star.png";
	} else{
		i1.src="images/e_star.png";
		i2.src="images/e_star.png";
	}
}
function btn3() {
	var i3 =document.getElementById("i3");
	if(i3.src.match("images/e_star.png")){
	i1.src="images/f_star.png";
	i2.src="images/f_star.png";
	i3.src="images/f_star.png";
	} else{
		i1.src="images/e_star.png";
		i2.src="images/e_star.png";
		i3.src="images/e_star.png";
	}
}
function btn4() {
	var i4 =document.getElementById("i4");
	if(i4.src.match("images/e_star.png")){
	i1.src="images/f_star.png";
	i2.src="images/f_star.png";
	i3.src="images/f_star.png";
	i4.src="images/f_star.png";
	} else{
		i1.src="images/e_star.png";
		i2.src="images/e_star.png";
		i3.src="images/e_star.png";
		i4.src="images/e_star.png";
	}

}
function btn5() {
	var i5 =document.getElementById("i5");
	if(i5.src.match("images/e_star.png")){
	i1.src="images/f_star.png";
	i2.src="images/f_star.png";
	i3.src="images/f_star.png";
	i4.src="images/f_star.png";
	i5.src="images/f_star.png";
	}
	else{
		i1.src="images/e_star.png";
		i2.src="images/e_star.png";
		i3.src="images/e_star.png";
		i4.src="images/e_star.png";
		i5.src="images/e_star.png";
	}
}
</script>
</head>
<body>
	<nav class="navbar navbar-default">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
					aria-expanded="false">
					<span class="sr-only"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span> <span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#">놀자GO!</a>
			</div>
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
					<li><a href="#"><span class="sr-only"></span>내주변</a></li>
					<li><a href="#">장르별</a></li>
					<li><a href="#">지역별</a></li>
					<li><a href="#">함께놀기</a></li>
					<li><a href="#">게시판</a></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">더보기<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="#">공지사항</a></li>
							<li><a href="#">놀자GO! BEST</a></li>
							<li><a href="#">놀자GO! 초이스</a></li>
							<li><a href="#">1:1 문의하기</a></li>
						</ul></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li class="active"><a href="login.do">로그인</a></li>
					<li><a href="#">회원가입</a></li>
				</ul>
			</div>
		</div>
	</nav>


	<form action="roomWriteReviewPro.do">
				<table style="text-align: center; border: 1px solid #dddddd;">
					<thead>
						<tr>
							<th colspan="2">후기 작성 게시판</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th>평가하기</th>
							<td>
								<button name="rate" onclick="btn1()" value="1" style="border: none; background-color: white; margin-left: 100px;"><img src="images/e_star.png" id="i1" width="25" height="30"></button>
								<button name="rate" onclick="btn2()" value="2" style="border: none; background-color: white;"><img src="images/e_star.png" id="i2" width="25" height="30"></button>
								<button name="rate" onclick="btn3()" value="3" style="border: none; background-color: white;"><img src="images/e_star.png" id="i3" width="25" height="30"></button>
								<button name="rate" onclick="btn4()" value="4" style="border: none; background-color: white;"><img src="images/e_star.png" id="i4" width="25" height="30"></button>
								<button name="rate" onclick="btn5()" value="5" style="border: none; background-color: white;"><img src="images/e_star.png" id="i5" width="25" height="30"></button>
							</td>
						</tr>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="2"><textarea class="form-control" placeholder="후기를 작성해주세요.(100자 이내)"
							name="recontent" maxlength="100" style="resize: none; height: 100px; width: 500px;"  required="required"></textarea></td>
						</tr>
					</tfoot>
				</table>

				<input type="reset" class="btn btn-info pull-right" value="다시작성">
			    <input type="submit" class="btn btn-info pull-right" value="완료">

	</form>
</body>
</html>