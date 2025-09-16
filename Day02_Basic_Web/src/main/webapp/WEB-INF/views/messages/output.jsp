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
	integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
	crossorigin="anonymous"></script>

</head>
<body>
	<table border="1" align="center">
		<tr>
			<th colspan="3">목록</th>
		</tr>
		<tr>
			<td>Seq</td>
			<td>Sender</td>
			<td>Messages</td>
		</tr>
		<c:forEach var="i" items="${list }">
			<tr>
				<td>${i.seq }</td>
				<td>${i.sender }</td>
				<td>${i.message }</td>
			</tr>
		</c:forEach>
		<tr>
			<td colspan="3">
				<form action="/messages/update" align="center" method="post">
					<input type="text" placeholder="input seq to update" name="seq"><br>
					<input type="text" placeholder="input sender to update"
						name="sender"><br> <input type="text"
						placeholder="input message to update" name="message"><br>
					<button>수정</button>
				</form>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<form action="/messages/delete">
					<input type="text" placeholder="input seq to delete" name="seq">
				</form>
			</td>
			<td align="center">
				<button>삭제</button>
			</td>
		</tr>
		<tr>
			<td colspan="3" align="center"><a href="/">Back</a></td>
		</tr>
	</table>
</body>
</html>