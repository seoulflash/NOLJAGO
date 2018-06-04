<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
			<a href="messageList.do?pageNum=${pageNum }&id=${id}"
				class="btn btn-info pull-left">목록</a> <a
				href="messageWriterForm.do?id=${id }&fromid=${message.fromid}&pageNum=${pageNum}"
				class="btn btn-info pull-right">답장쓰기</a>
			<table class="table table-hover" style="width: 50%;">
				<thead>
					<tr>
						<th style="width: 70px;">쪽지번호</th>
						<td>${message.mnum }</td>
					</tr>
					<tr>
						<th>보낸사람</th>
						<td>${message.fromid }</td>
					</tr>
					<tr>
						<th>받은사람</th>
						<td>${message.toid }</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th>내용</th>
						<td  style="word-break:break-all;"><pre>${message.mcontent }</pre></td>
					</tr>
					<tr>
						<th>작성일</th>
						<td>${message.mdate }</td>
					</tr>
				</tbody>
			</table>
			<a
				href="messageDeleteForm.do?id=${id }&mnum=${message.mnum}&pageNum=${pageNum}"
				class="btn btn-info pull-right">삭제</a>
		</div>
	</div>
</body>
</html>