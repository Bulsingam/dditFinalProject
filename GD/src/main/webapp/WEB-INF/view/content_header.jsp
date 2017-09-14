<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
$(function(){
	// filter를 통해서 가지고 온다 
// 	alert('${menuName}');
// 	alert('${requestPath}');
// 	alert('${requestURISprit}');
// 	alert('${requestURINecessity}');
})



</script>
</head>
<body>

<section class="content-header">
      <h1 id="firstContentHeader">
        ${requestScope.menuName}
        <small>Optional description</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
        <li class="active">Here</li>
      </ol>
    </section>

</body>
</html>