<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>들어와! 놀자GO!</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<link rel="stylesheet" href="css/bootstrap.css">
	<link rel="stylesheet" href="css/noljaBooster.css">
	<style type="text/css">
		form {
			display: block;
		}
		.form-agree {
			margin: 0 auto;
			padding: 30px;
			padding-bottom: 50px;
			width: 500px;
		}
		.form-agree h2 {
			margin-top: 10px;
			margin-bottom: 30px;
		}
		#agreeImg {
			width: 80px;
			height: 80px;
		}
	    .allCheckBox {
	        margin: 15 0 5 180;
		}
		.scroll-cont {
			margin-bottom: 30px;
		}
		.agree-head {
			padding: 10px;
			border: 1px solid #e4e1e1;
			overflow-y: scroll;
		}
		.agree-cont {
	        font-size: 13px;
			padding: 15px;
			border: 1px solid #e4e1e1;
			border-top: none;
			height: 100px;
			overflow-y: scroll;
		}
	    /* 버튼 라벨 필수 & 선택 부분 */
		em {
			font: small-caption;
			color: red;
		}
	    #notmust {
	        color: #a6a6a6;
	    }
		#nextButton {
	        font-size: 14px;
	        border: none;
	        background: linear-gradient(141deg, #0fb8ad 0%, #1fc8db 51%, #2cb5e8 75%);
	        color: white;
		}
	</style>
	<script type="text/javascript">
	function check() {
		if (allCheck.checked) {
			document.f1.contAgree1.checked = true;
			document.f1.contAgree2.checked = true;
			document.f1.contAgree3.checked = true;
		} else {
			document.f1.contAgree1.checked = false;
			document.f1.contAgree2.checked = false;
			document.f1.contAgree3.checked = false;
		}
	}
	</script>
</head>
<%@include file="menu.jsp" %>
<%------------ B O D Y ------------%>
<body>
	<!--------------- A G R E E : F O R M ---------------->
	<div class="container">
		<form class="form-horizontal form-agree" name="f1" action="join.do" method="post">
			<div class="row text-center">
				<a><img src="images/agree.svg" id="agreeImg"></a>
			</div>
			<h2 class="form-agree-heading text-center">놀자GO! 이용약관</h2>
            <div class="allCheckBox">
    		    <label for="allCheck">
                    <input class="box" type="checkbox" name="allCheck" id="allCheck" onclick="check();">
                   	 전체동의
                </label>
	        </div>
    		<div class="scroll-cont">
    			<div class="agree-head">
    				<label class="contAgree1">
                        <input type="checkbox" name="contAgree1" id="contAgree1" value="agr1" required="required">
                       	 서비스 이용 약관 동의
    					<em>(필수)</em>
    				</label>
    			</div>
    			<div class="agree-cont" id="service">
    				"제 1장 총 칙"<br>
    				<br>
    				"제 1조 목적"<br />
    				"이 이용약관(이하 '약관'이라 합니다)은 ㈜놀자GO!(이하 '회사'라 합니다)와
    				이용 고객(이하 '회원'이라 합니다.)간에 회사가 제공하는
    				서비스(이하 '서비스'라 합니다)를 	이용함에 있어 회원과
    				회사간의 권리, 의무 및 책임사항, 이용조건 및 절차 등
    				기본적인 사항을 규정함을 목적으로 합니다. <br>
    			</div>
    		</div>
    		<div class="scroll-cont">
    			<div class="agree-head">
    				<label class="contAgree2" for="contAgree2">
                        <input type="checkbox" name="contAgree2" id="contAgree2" value="agr2" required="required">
                       	 개인정보 수집/이용 약관 동의
    					<em>(필수)</em>
    				</label>
    			</div>
    			<div class="agree-cont" id="service">
    				고객님께서는 동의를 거부하실 수 있으며, 동의 거부 시 회원가입이 제한됩니다.<br>
    				<br>
    				"개인정보 수집/이용 약관 동의 내용"<br>
    				<br>
    				1. 회사는 이 약관의 내용과 상호 및 대표자 성명, 영업소 소재지 주소, 전화번호, 전자우편주소, 사업자등록번호 등을 이용자가 쉽게 알 수 있도록 사이트의 초기 서비스 화면에 게시합니다. 다만, 약관의 구체적 내용은 이용자가 연결화면을 통하여 볼 수 있습니다.<p>
                    2. 회사는 『약관의 규제 등에 관한 법률』, 『전자거래 기본법』, 『전자서명법』, 『정보통신망 이용촉진 및 정보보호 등에 관한 법률』(정보통신망법), 『소비자기본법』, 『전자상거래 등에서의 소비자보호에 관한 법률』 등 관련법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.<p>
    				3. 회사가 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행 약관과 함께 사이트의 초기화면에 그 개정약관의 적용일자 7일 전부터 적용일자 전일까지 공지합니다. 다만, 회원에게 불리한 약관의 개정의 경우에는 30일 이상의 사전 유예기간을 두고 공지합니다. <p>
    				4. 본조 제3항에 따라 따라 공지된 적용일자 이후에 회원이 회사의 서비스를 계속 이용하는 경우에는 개정된 약관에 동의하는 것으로 봅니다. 개정된 약관에 동의하지 아니하는 회원은 언제든지 자유롭게 서비스 이용계약을 해지할 수 있습니다.<p>
    			</div>
    		</div>
            <div class="scroll-cont">
                <div class="agree-head">
                    <label class="contAgree3" for="contAgree3">
                        <input type="checkbox" name="contAgree3" id="contAgree3" value="agr3">
                        위치 정보 이용 약관 동의
    					<em id="notmust">(선택)</em>
    				</label>
                </div>
                <div class="agree-cont" id="service">
                    제 1 조 (목적)<br />
                    본 약관은 ㈜놀자GO!(이하 "회사"라 합니다)가 운영, 제공하는 위치기반서비스(이하 “서비스”)를 이용함에 있어 회사와 고객 및 개인위치정보주체의 권리, 의무 및 책임사항에 따른 이용조건 및 절차 등 기본적인 사항을 규정함을 목적으로 합니다. <p>
                    <br /><br />
                    제 2 조 (이용약관의 효력 및 변경)<br />
                    1. 본 약관은 서비스를 신청한 고객 또는 개인위치정보주체가 본 약관에 동의하고 회사가 정한 소정의 절차에 따라 서비스의 이용자로 등록함으로써 효력이 발생합니다. <p>
                    2. 신청자가 모바일 단말기, PC 등에서 약관의 "동의하기" 버튼을 선택하였을 경우 본 약관의 내용을 모두 읽고 이를 충분히 이해하였으며, 그 적용에 동의한 것으로 봅니다. <p>
                    3. 회사는 위치정보의 보호 및 이용 등에 관한 법률, 콘텐츠산업 진흥법, 전자상거래 등에서의 소비자보호에 관한 법률, 소비자 기본법 약관의 규제에 관한 법률 등 관련 법령을 위배하지 않는 범위에서 본 약관을 변경할 수 있습니다. <p>
                    4. 회사가 약관을 변경할 경우에는 변경된 약관과 사유, 적용일자를 명시하여 그 적용일자 10일 전부터 적용일 이후 상당한 기간 동안 공지만을 하고, 개정 내용이 회원에게 불리한 경우에는 그 적용일자 30일 전부터 적용일 이후 상당한 기간 동안 각각 이를 서비스내 게시하거나 회원에게 전자적 형태(전자우편, SMS 등)로 약관 개정 사실을 발송하여 고지합니다. <p>
                    5. 회사가 전항에 따라 회원에게 통지하면서 공지일로부터 적용일 7일 후까지 거부의사를 표시하지 아니하면 개정 약관에 승인한 것으로 간주합니다. 회원이 개정 약관에 동의하지 않을 경우 회원은 이용계약을 해지할 수 있습니다.<p>
    			</div>
            </div>
            <input type="submit" class="form-control input-lg" id="nextButton" value="다&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;음" />
		</form>
	</div>
</body>
</html>
<%@include file="footer.jsp" %>