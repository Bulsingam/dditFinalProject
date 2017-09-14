<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 
	특정 jsp에서 발생된 익셉셥 전담 처리하는 jsp.
	page 디렉티브 isErrorPage false(default)를 true로 변경 설정 후 exception 기본객체를 활용.
 	서버에서 익셉션 발생시 클라이언트에 전송되는 컨텐츠의 사이즈가 513byte 이하이면
 	클라이언트에 전달되는 500 또는 404 등의 상태 코드를 활용해서 클라이언트가 작성하는 에러페이지가 출력.
 -->
에러 메세지 : <%=exception.getMessage() %><br/>
에러 클래스 : <%=exception.getClass().getName() %>
</body>
</html>