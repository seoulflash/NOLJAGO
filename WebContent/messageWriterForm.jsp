<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>심심할땐? 놀자GO!</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="js/bootstrap.js"></script>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/noljaBooster.css">
</head>
<body>
	<div class="container">
		<div class="row">
			<a href="messageList.do?id=${id}" class="btn btn-info">목록</a>
			<form
				action="messageWriterPro.do?pageNum=${pageNum }&fromid=${fromid}"
				method="post">
				<input type="hidden" name="mnum" value="${mnum }">
				<input type="hidden" name="fromid" value="${fromid }"><br />
				<table class="table table-hover">
					<thead>
						<tr>
							<th style="text-align: center;">쪽지 쓰기</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><c:if test="${toid == null }"><input type="text" name="toid" placeholder="보낼 사람"
								required="required"class="form-control" value="${toid }"></c:if>
								<c:if test="${toid != null }"><input type="text" name="toid" placeholder="보낼 사람"
								required="required"class="form-control" value="${toid }"readonly/></c:if></td>
						</tr>
						<tr>
							<td><textarea rows="4" cols="50" name="mcontent"
									required="required"class="form-control"></textarea></td>
						</tr>
					</tbody>
				</table>
				<input class="btn btn-info" type="submit" value="쪽지쓰기" > <input class="btn btn-info" type="reset"
					value="다시쓰기">
			</form>
		</div>
	</div>
</body>
</html>