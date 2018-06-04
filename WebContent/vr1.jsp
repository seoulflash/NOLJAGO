<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
game1 { width:20%;}
h2 {
	text-align: center;
	text-decoration: underline;
}

#box {
	display: block;
	width: 70%;
	height: 35px;
	text-align: center;
	border: none;
	background: #4C4C4C;
	color:white;
}
#content { color: #B1B1B1;}
#like { padding-left: 60px; padding-top: 17px; }
.effect:HOVER {
    display: inline-block;
    transform: rotate(5deg);
}
#reserve { background-color: white; border-color: black; }
</style>
<script type="text/javascript">
	function clk(){
		var img1=document.getElementById("img1")
			img1.src="images/like2.png"
	}
	function clk2(){
		var img2=document.getElementById("img2")
			img2.src="images/like2.png"
	}
	function clk3(){
		var img3=document.getElementById("img3")
			img3.src="images/like2.png"
	}
	function clk4(){
		var img4=document.getElementById("img4")
			img4.src="images/like2.png"
	}
	function pop(){
		window.open('review.jsp','리뷰창','width=900,height=500');
	}
</script>
</head>
<body>
	<h2>콘텐츠 안내</h2>
	<div id="game1" style="float:left">
	<div id="box">
        <p id="text"> 울산 바이킹 </p>
    </div><br>
    <img src="images/game1.JPG" class="effect" width="70%" id="main"><p>
    장르 : 액션FPS<br>
  <div id="content">
    	세상에 단 하나 뿐인 신기한 바이킹이 떴다!<br>
    	인원: 1~2인<br>
    	VR 체험 난이도: <img src="images/f_star.png" width="15" height="20">
    	<img src="images/f_star.png" width="15" height="20">
    	<img src="images/e_star.png" width="15" height="20">
    	<img src="images/e_star.png" width="15" height="20">
    	<img src="images/e_star.png" width="15" height="20">
    	<br>
    	스릴감: <img src="images/f_star.png" width="15" height="20">
    	<img src="images/f_star.png" width="15" height="20">
    	<img src="images/f_star.png" width="15" height="20">
    	<img src="images/e_star.png" width="15" height="20">
    	<img src="images/e_star.png" width="15" height="20">
    	<br>
    	공포감: <img src="images/f_star.png" width="15" height="20">
    	<img src="images/f_star.png" width="15" height="20">
    	<img src="images/e_star.png" width="15" height="20">
    	<img src="images/e_star.png" width="15" height="20">
    	<img src="images/e_star.png" width="15" height="20">
    	<br>
    	볼거리: <img src="images/f_star.png" width="15" height="20">
    	<img src="images/e_star.png" width="15" height="20">
    	<img src="images/e_star.png" width="15" height="20">
    	<img src="images/e_star.png" width="15" height="20">
    	<img src="images/e_star.png" width="15" height="20">
    	<br>
    	<div id="like">
    		<button onclick="clk()"><img src="images/like.png" id="img1" width="30" height="40"></button>
    		<img src="images/play_button.png" width="30" height="40">
    		<button id="review" class="review" onclick="pop()"><img src="images/review.png" width="30" height="40"></button>
    		<a href="reserve.jsp"><button id="reserve">예약하기</button></a>
    	</div>
    	<div style="text-align: center"> 좋아요: 0개</div>
  </div>
  </div>
  <div id="game2"  style="float:left">
  <div id="box">
        <p id="text"> 하롱베이 라이드 </p>
    </div><br>
    <img src="images/game2.JPG" class="effect" width="70%"><p>
   	 장르 : 액션FPS<br>
    <div id="content">
    	비행기를 타고 하롱베이를 날아보세요!<br>
    	인원: 1~2인<br>
    	VR 체험 난이도: <img src="images/f_star.png" width="15" height="20">
    	<img src="images/f_star.png" width="15" height="20">
    	<img src="images/f_star.png" width="15" height="20">
    	<img src="images/e_star.png" width="15" height="20">
    	<img src="images/e_star.png" width="15" height="20">
    	<br>
    	스릴감: <img src="images/f_star.png" width="15" height="20">
    	<img src="images/f_star.png" width="15" height="20">
    	<img src="images/f_star.png" width="15" height="20">
    	<img src="images/f_star.png" width="15" height="20">
    	<img src="images/e_star.png" width="15" height="20">
    	<br>
    	공포감: <img src="images/f_star.png" width="15" height="20">
    	<img src="images/e_star.png" width="15" height="20">
    	<img src="images/e_star.png" width="15" height="20">
    	<img src="images/e_star.png" width="15" height="20">
    	<img src="images/e_star.png" width="15" height="20">
    	<br>
    	볼거리: <img src="images/f_star.png" width="15" height="20">
    	<img src="images/f_star.png" width="15" height="20">
    	<img src="images/e_star.png" width="15" height="20">
    	<img src="images/e_star.png" width="15" height="20">
    	<img src="images/e_star.png" width="15" height="20">
    	<br>
    	<div id="like">
    		<button onclick="clk2()"><img src="images/like.png" id="img2" width="30" height="40"></button>
    		<img src="images/play_button.png" width="30" height="40">
    		<img src="images/review.png" width="30" height="40">
    		<button id="reserve">예약하기</button>
    	</div>
    	<div style="text-align: center"> 좋아요: 0개</div>
  </div>
  </div>
  
  <div id="game3"  style="float:left">
  <div id="box">
        <p id="text"> 제주 익스프레스 </p>
    </div><br>
    <img src="images/game3.JPG" class="effect" width="70%"><p>
   	 장르 : 스릴<br>
    <div id="content">
    	성산 일출봉에서 롤러코스터를 타보자!<br>
    	인원: 1~2인<br>
    	VR 체험 난이도: <img src="images/f_star.png" width="15" height="20">
    	<img src="images/f_star.png" width="15" height="20">
    	<img src="images/f_star.png" width="15" height="20">
    	<img src="images/e_star.png" width="15" height="20">
    	<img src="images/e_star.png" width="15" height="20">
    	<br>
    	스릴감: <img src="images/f_star.png" width="15" height="20">
    	<img src="images/f_star.png" width="15" height="20">
    	<img src="images/f_star.png" width="15" height="20">
    	<img src="images/f_star.png" width="15" height="20">
    	<img src="images/e_star.png" width="15" height="20">
    	<br>
    	공포감: <img src="images/f_star.png" width="15" height="20">
    	<img src="images/e_star.png" width="15" height="20">
    	<img src="images/e_star.png" width="15" height="20">
    	<img src="images/e_star.png" width="15" height="20">
    	<img src="images/e_star.png" width="15" height="20">
    	<br>
    	볼거리: <img src="images/f_star.png" width="15" height="20">
    	<img src="images/f_star.png" width="15" height="20">
    	<img src="images/e_star.png" width="15" height="20">
    	<img src="images/e_star.png" width="15" height="20">
    	<img src="images/e_star.png" width="15" height="20">
    	<br>
    	<div id="like">
    		<button onclick="clk3()"><img src="images/like.png" id="img3" width="30" height="40"></button>
    		<img src="images/play_button.png" width="30" height="40">
    		<img src="images/review.png" width="30" height="40">
    		<button id="reserve">예약하기</button>
    	</div>
    	<div style="text-align: center"> 좋아요: 0개</div>
  </div>
  </div>
  
  <div id="game4"  style="float:left">
  <div id="box">
        <p id="text"> 랜드마크 코스터 </p>
    </div><br>
    <img src="images/game4.JPG" class="effect" width="70%"><p>
   	 장르 : 스릴<br>
    <div id="content">
    	다양한 랜드마크를 체험해보자!<br>
    	인원: 1~2인<br>
    	VR 체험 난이도: <img src="images/f_star.png" width="15" height="20">
    	<img src="images/f_star.png" width="15" height="20">
    	<img src="images/f_star.png" width="15" height="20">
    	<img src="images/e_star.png" width="15" height="20">
    	<img src="images/e_star.png" width="15" height="20">
    	<br>
    	스릴감: <img src="images/f_star.png" width="15" height="20">
    	<img src="images/f_star.png" width="15" height="20">
    	<img src="images/f_star.png" width="15" height="20">
    	<img src="images/f_star.png" width="15" height="20">
    	<img src="images/e_star.png" width="15" height="20">
    	<br>
    	공포감: <img src="images/f_star.png" width="15" height="20">
    	<img src="images/e_star.png" width="15" height="20">
    	<img src="images/e_star.png" width="15" height="20">
    	<img src="images/e_star.png" width="15" height="20">
    	<img src="images/e_star.png" width="15" height="20">
    	<br>
    	볼거리: <img src="images/f_star.png" width="15" height="20">
    	<img src="images/f_star.png" width="15" height="20">
    	<img src="images/e_star.png" width="15" height="20">
    	<img src="images/e_star.png" width="15" height="20">
    	<img src="images/e_star.png" width="15" height="20">
    	<br>
    	<div id="like">
    		<button onclick="clk4()"><img src="images/like.png" id="img4" width="30" height="40"></button>
    		<img src="images/play_button.png" width="30" height="40">
    		<img src="images/review.png" width="30" height="40">
    		<button id="reserve">예약하기</button>
    	</div>
    	<div style="text-align: center"> 좋아요: 0개</div>
  </div>
  </div>
</body>
</html>