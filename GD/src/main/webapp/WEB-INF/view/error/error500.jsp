<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>500 error</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>AdminLTE 2 | Log in</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <!-- Bootstrap 3.3.7 -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css">
  <!-- Font Awesome -->
<!--   <link rel="stylesheet" href="../../bower_components/font-awesome/css/font-awesome.min.css"> -->
  <!-- Ionicons -->
<!--   <link rel="stylesheet" href="../../bower_components/Ionicons/css/ionicons.min.css"> -->
  <!-- Theme style -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/dist/css/AdminLTE.min.css">
  <!-- iCheck -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/iCheck/square/blue.css">

  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->

  <!-- Google Font -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
<!-- /.login-box -->

<!-- jQuery 3 -->
<script src="${pageContext.request.contextPath }/resources/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="${pageContext.request.contextPath }/resources/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
$(function(){
	$('#btnReturn').click(function(){
		$(location).attr('href','${pageContext.request.contextPath}/join/login.do');
	})
})
</script>
</head>
<body>
<div style="text-align: center;">
	<img id="404error" alt="500에러 화면" src="../image/500error.png" style="width: 1200px; height: 600px;">
</div>
<div class="row">
	<div class="col-md-4" style="text-align: center;"></div>
	<div class="col-md-4" style="text-align: center;">
		<button id="btnReturn" type="button" class="btn btn-block btn-default btn-lg">로그인 페이지로 돌아가기</button>
	</div>
	<div class="col-md-4" style="text-align: center;"></div>
</div>
</body>
</html>