<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script type="text/javascript">
				if(confirm("삭제하겠습니까?")){
						location.href="boardReplyDeletePro.do?pageNum=${pageNum}&bnum=${bnum}&id=${id}&ref=${ref}&board_bnum=${board_bnum}&board_ref=${board_ref}";
				}else{
					window.history.back();
				}
		</script>
</body>
</html>