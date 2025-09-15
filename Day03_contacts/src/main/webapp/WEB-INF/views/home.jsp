<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- JQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
            integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

</head>
<body>
	<table border="1" align="center">
		<tr>
			<th colspan="2">
				Contact Home
			</th>
		</tr>
		<tr>
			<td>
				<a href="/contacts/input"><button type="button">신규등록</button></a>
			</td>
			<td>
				<a href="/contacts/output"><button type="button">연락처목록</button></a>
			</td>
		</tr>
	</table>
</body>
</html>