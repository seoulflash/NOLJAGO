<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
   <meta charset="utf-8">
   <meta name="viewport" content="width=device-width, initial-scale=1">
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
   <script src="js/bootstrap.js"></script>
   <link rel="stylesheet" href="css/bootstrap.css">
   <link rel="stylesheet" href="css/noljaBooster.css">
   <title>심심할땐? 놀자GO! : 예약하기</title>
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



   .buttonN {
      border: 2px solid #969696;
      background: #969696;
      background: -webkit-gradient(linear, left top, left bottom, from(#969696), to(#969696));
      background: -webkit-linear-gradient(top, #969696, #969696);
      background: -moz-linear-gradient(top, #969696, #969696);
      background: -ms-linear-gradient(top, #969696, #969696);
      background: -o-linear-gradient(top, #969696, #969696);
      background-image: -ms-linear-gradient(top, #969696 0%, #969696 100%);
      padding: 20px 40px;
      -webkit-border-radius: 0px;
      -moz-border-radius: 0px;
      border-radius: 0px;
      -webkit-box-shadow: rgba(255,255,255,0.4) 0 0px 0, inset rgba(255,255,255,0.4) 0 0px 0;
      -moz-box-shadow: rgba(255,255,255,0.4) 0 0px 0, inset rgba(255,255,255,0.4) 0 0px 0;
      box-shadow: rgba(255,255,255,0.4) 0 0px 0, inset rgba(255,255,255,0.4) 0 0px 0;
      text-shadow: #787878 0 1px 0;
      color: #ffffff;
      font-size: 16px;
      font-family: helvetica, serif;
      text-decoration: none;
      vertical-align: middle;
      margin-bottom:15px;
      width: 130px;
      height: 81px;
      white-space: normal;
      }


   .buttonN:active {
      text-shadow: #080808 0 1px 0;
      border: 2px solid #969696;
      background: #969696;
      background: -webkit-gradient(linear, left top, left bottom, from(#969696), to(#969696));
      background: -webkit-linear-gradient(top, #969696, #969696);
      background: -moz-linear-gradient(top, #969696, #969696);
      background: -ms-linear-gradient(top, #969696, #969696);
      background: -o-linear-gradient(top, #969696, #969696);
      background-image: -ms-linear-gradient(top, #969696 0%, #969696 100%);
      color: #ffffff;
      }



   .buttonY {
      border: 2px solid #e3e3e3;
      background: #e3e3e3;
      background: -webkit-gradient(linear, left top, left bottom, from(#e3e3e3), to(#e3e3e3));
      background: -webkit-linear-gradient(top, #e3e3e3, #e3e3e3);
      background: -moz-linear-gradient(top, #e3e3e3, #e3e3e3);
      background: -ms-linear-gradient(top, #e3e3e3, #e3e3e3);
      background: -o-linear-gradient(top, #e3e3e3, #e3e3e3);
      background-image: -ms-linear-gradient(top, #e3e3e3 0%, #e3e3e3 100%);
  	  padding: 12.5px 25px;      
      -moz-border-radius: 0px;
      border-radius: 0px;
      -webkit-box-shadow: rgba(255,255,255,0.4) 0 0px 0, inset rgba(255,255,255,0.4) 0 0px 0;
      -moz-box-shadow: rgba(255,255,255,0.4) 0 0px 0, inset rgba(255,255,255,0.4) 0 0px 0;
      box-shadow: rgba(255,255,255,0.4) 0 0px 0, inset rgba(255,255,255,0.4) 0 0px 0;
      text-shadow: #dbdbdb 0 1px 0;
      color: #616161;
      font-size: 16px;
      font-family: helvetica, serif;
      text-decoration: none;
      vertical-align: middle;
      margin-bottom:15px;
      width: 130px;
      height: 81px;
      white-space: normal;
      }

    /* .buttonY:hover {
      border: 2px solid #828282;
      text-shadow: #dbdbdb 0 1px 0;
      background: #e3e3e3;
      background: -webkit-gradient(linear, left top, left bottom, from(#e3e3e3), to(#e3e3e3));
      background: -webkit-linear-gradient(top, #e3e3e3, #e3e3e3);
      background: -moz-linear-gradient(top, #e3e3e3, #e3e3e3);
      background: -ms-linear-gradient(top, #e3e3e3, #e3e3e3);
      background: -o-linear-gradient(top, #e3e3e3, #e3e3e3);
      background-image: -ms-linear-gradient(top, #e3e3e3 0%, #e3e3e3 100%);
      color: #616161;
      }  */

    .buttonY:active {
      text-shadow: #080808 0 1px 0;
      border: 2px solid #969696;
      background: #969696;
      background: -webkit-gradient(linear, left top, left bottom, from(#969696), to(#e3e3e3));
      background: -webkit-linear-gradient(top, #969696, #969696);
      background: -moz-linear-gradient(top, #969696, #969696);
      background: -ms-linear-gradient(top, #969696, #969696);
      background: -o-linear-gradient(top, #969696, #969696);
      background-image: -ms-linear-gradient(top, #969696 0%, #969696 100%);
      color: #ffffff;
      }


   .button {
       background-color: #4CAF50;   /* Green */
       border: none;
       color: white;
      padding: 15px 25px;
      text-align: center;
       text-decoration: none;
       display: inline-block;
       font-size: 20px;
       margin: 10px 10px;
       cursor: pointer;
   }

   .button4 {  /* 회색 테두리 버튼   -  예약불가 버튼  */
       background-color: #e3e3e3;
       color: black;
       border: 1px solid #e7e7e7;
       margin-right: 20px;
       margin-bottom: 20px;
       font-size: 20px;
       font-family: helvetica, serif;
   }


   .button5 { /* 검은색 테두리 버튼  -  예약가능 버튼  */
       background-color: white;
       margin-right: 20px;
       margin-bottom: 20px;
       color: black;
       border: 1px solid #e3e3e3;
       font-size: 20px;
       font-family: helvetica, serif;
   }

 /*   #t{
      text-align: center;
      float: center;
      margin-left: 800px;
   } */

  	 #tableCenter{
     	text-align: center;
   	}
	.block {
		margin-left: auto;
		margin-right: auto;
		margin-bottom: 65px;
	}
   </style>


   <!--  달력     -->
   <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
   <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
   <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
   <script>


    $(function() {
    });
    $(window).load( function() {   //맨처음 날짜 초기화
      var date =  $("#datepicker").val();
      var cnum = '${cnum}';
      var tnum = '${tnum}';

      var sendData = "date=" +date+ "&cnum=" +cnum+ "&tnum="+tnum;
      console.log(sendData);
      $.post('reserveConfirmEmpty.jsp', sendData, function(msg) {

         var buttons = document.querySelectorAll('.buttonN');   //buttonN인 버튼들 초기화

         for (var i=0; i<buttons.length; i++) {

         	buttons[i].value = buttons[i].id + ":00";
            buttons[i].className = "buttonY";
            buttons[i].disabled = false;
			
         }

         var strlist = JSON.parse(msg);      // 예약 자리가 있는 시간들 JSON 배열로 갖고옴

         for(key in strlist) {

             document.getElementById(strlist[key]).className = "buttonN";
             document.getElementById(strlist[key]).disabled = true;
             document.getElementById(strlist[key]).value = strlist[key]+ ":00 매진";
         }

      })

    });


    $(function() {
         $( "#datepicker" ).datepicker({
            dateFormat: "yy/mm/dd",
            altField  : '#Day',		// 평일 주말 가격을 나누기위한 요일
       	 	altFormat : 'DD',
            showMonthAfterYear: true,
         	showButtonPanel: true,
            currentText: '오늘',
           	closeText: '닫기',
         	changeMonth: true,
	        dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
	        dayNamesMin: [ '일', '월', '화', '수', '목', '금', '토'],
	        monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	        minDate: 1,
         });
         $("#datepicker").datepicker("setDate", '1');   //내일 날짜로 init
     });

    function getDate() {
       var date =  $("#datepicker").val();
       var cnum = '${cnum}';
       var tnum = '${tnum}';

       var sendData = "date=" +date+ "&cnum=" +cnum+ "&tnum="+tnum;
       console.log(sendData);

       $.post('reserveConfirmEmpty.jsp', sendData, function(msg) {

         var buttons = document.querySelectorAll('.buttonN');

         for (var i=0; i<buttons.length; i++) {

            buttons[i].value = buttons[i].id + ":00";
            buttons[i].className = "buttonY";
            buttons[i].disabled = false;
         }

         var strlist = JSON.parse(msg);

         for(key in strlist) {

             document.getElementById(strlist[key]).className = "buttonN";
             document.getElementById(strlist[key]).disabled = true;
             document.getElementById(strlist[key]).value = strlist[key]+ ":00 매진";
             
         }

      })

    }
    </script>
</head>
<%@include file="menu.jsp" %>
<%------------ B O D Y ------------%>
<body>
<div class="container-fluid">
   <img src="images/${cafe.image2 }" class="img-responsive" alt="Responsive image" style="margin: auto;">


   <div id="top" style="margin-top: 50px">
      <ul id="reserveList">
         <li id="reserveList2" style="background-color: #1ca2e3;">01. 날짜/시간 선택</li>
         <li id="reserveList2">02. 예약 정보 입력</li>
         <li id="reserveList2">03. 예약 완료</li>
      </ul>
   </div>


   <form action="roomReserve2.do">
   <input type="hidden" name="id" value="${id }">
   <input type="hidden" name="cnum" value="${cnum }">
   <input type="hidden" name="tnum" value="${tnum }">
   <div id="tableCenter">
   <div style="margin-left: 50px; margin-top: 150px">
   예약날짜 : <input type="text" name="datepicker" id="datepicker"  onchange="getDate()" style="margin-right: 30px">
  <input type="hidden" id="Day" name="day">
   예약가능  <img src="images/r_e.PNG" width="30" height="30" style="margin-right: 20px">
   예약불가 <img src="images/r_f.PNG" width="30" height="30" style="margin-right: 20px">
   </div><br><br>

   <h2 style="margin-left: 50px;"><b>${theme.tname}</b></h2>
   </div>
   <hr>
   <div class="table-responsive">
   <table class="block" id="t">
      <tr>
         <td rowspan="5"><img alt="" src="images/${theme.timage }" width="280" height="280" style="margin-right: 50px; "></td>
      </tr>

      <tr>

         <c:forEach var="i" begin="${open }" end="${open+3 }">

            <td><input type="submit" value="${i}:00" name="time" id="${i}" class='buttonY' style="margin-left: 5px;"></td>

         </c:forEach>
         </tr>
         <tr>
         <c:forEach var="i" begin="${open+4 }" end="${open+7 }">

                  <td><input type="submit" value="${i}:00" name="time" id="${i}" class='buttonY' style="margin-left: 5px;"></td>

         </c:forEach>
         </tr>
         <tr>
         <c:if test="${hours <= 12}">
            <c:forEach var="i" begin="${open+8 }" end="${close-1 }">

                     <td><input type="submit" value="${i}:00" name="time" id="${i}" class='buttonY' style="margin-left: 5px;"></td>

            </c:forEach>
         </c:if>

         <c:if test="${hours > 12}">
            <c:forEach var="i" begin="${open+8 }" end="${open+11 }">

                     <td><input type="submit" value="${i}:00" name="time" id="${i}" class='buttonY' style="margin-left: 5px;"></td>

            </c:forEach>
         </c:if>
         </tr>
 
        <tr>
         <c:if test="${hours > 12}">
            <c:forEach var="i" begin="${open+12 }" end="${close-1 }">

                     <td><input type="submit" value="${i}:00" name="time" id="${i}" class='buttonY' style="margin-left: 5px;"></td>

            </c:forEach>
         </c:if>
         </tr>

     

    </table>
    </div>
    </form>
</div>
</body>
</html>
<%@include file="footer.jsp" %>