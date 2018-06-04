<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Let's! 놀자GO!</title>
	<script src="js/nolja.js"></script>
	<title>놀자GO! : 주소검색</title>
<%
	request.setCharacterEncoding("UTF-8");  //한글깨지면 주석제거
	String inputYn = request.getParameter("inputYn");
	String address = request.getParameter("roadFullAddr");
	System.out.println(address);
%>
	<script type="text/javascript">
		// opener관련 오류가 발생하는 경우 아래 주석을 해지하고, 사용자의 도메인정보를 입력합니다. ("주소입력화면 소스"도 동일하게 적용시켜야 합니다.)
		//document.domain = "abc.go.kr";
		function init(){
			var url = location.href;
			var confmKey = "U01TX0FVVEgyMDE4MDMzMDA5NTcxNTEwNzc4MDU=";
			var resultType = "4"; // 도로명주소 검색결과 화면 출력내용, 1 : 도로명, 2 : 도로명+지번, 3 : 도로명+상세건물명, 4 : 도로명+지번+상세건물명
			var inputYn= "<%=inputYn%>";
			if(inputYn != "Y"){
				document.form.confmKey.value = confmKey;
				document.form.returnUrl.value = url;
				document.form.resultType.value = resultType;
				document.form.action="http://www.juso.go.kr/addrlink/addrLinkUrl.do"; //인터넷망
				//document.form.action="http://www.juso.go.kr/addrlink/addrMobileLinkUrl.do"; //모바일 웹인 경우, 인터넷망
				document.form.submit();
			}else{
				opener.jusoCallBack("<%=address%>");
				window.close();
			}
		}
	</script>

</head>

<body onload="init();">
	<form id="form" name="form" method="post">
		<input type="hidden" id="confmKey" name="confmKey" value=""/>
		<input type="hidden" id="returnUrl" name="returnUrl" value=""/>
		<input type="hidden" id="resultType" name="resultType" value=""/>
	</form>
</body>
</html>
