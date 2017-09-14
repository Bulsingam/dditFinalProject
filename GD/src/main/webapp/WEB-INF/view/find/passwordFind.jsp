<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>AdminLTE 2 | Registration Page</title>
<!-- Tell the browser to be responsive to screen width -->
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<!-- Bootstrap 3.3.6 -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/bootstrap/css/bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
<!-- Ionicons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/dist/css/AdminLTE.min.css">
<!-- jQuery 2.2.3 -->
<script src="${pageContext.request.contextPath }/resources/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="${pageContext.request.contextPath }/resources/bootstrap/js/bootstrap.min.js"></script>
<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->
<script>
$(function(){
	
	$('#check').click(function(){
		var emp_num = $('#emp_num').val();
		var emp_name = $('#emp_name').val();
		var emp_mail = $('#emp_mail').val();
	
		$.ajax({
		  	  type : 'POST'
			, url : '${pageContext.request.contextPath}/find/passFind.do'
			, data : 'emp_num='+emp_num+'&emp_name='+emp_name+'&emp_mail='+emp_mail
			, dataType : 'json'
			, error : function(request){
				alert('code : ' + request.status + '\r\nmessage : ' + request.reponseText);
		 	 }
			, success : function(result){
				if(result.empInfo == null){
					var code = ""; 
					code +=	"<p>등록된 사원이 아닙니다.</p>";
					code += "<input type='hidden' id='send_mail' value='' />";
					code += "<input type='hidden' id='ep' value='' />";
					$('#message').html(code);
				}else{
					var code = "";
					code += "<p>체크완료</p>";
					code += "<input type='hidden' id='send_mail' value='" + result.empInfo.emp_mail + "' />";
					code += "<input type='hidden' id='ep' value='" + result.empInfo.emp_pass + "' />";
					$('#message').html(code);
				}
		  	}
		});
	});
	
	
	$('#send').click(function(){
		
		var send_mail = $('#send_mail').val();
		var ep = $('#ep').val();
		
		if(send_mail == "" || ep == "" || send_mail == undefined || ep == undefined){
			alert("체크완료 해주세요.");
		}else{
 			$(location).attr('href', '${pageContext.request.contextPath}/find/passSend.do?emp_mail=' + send_mail +'&ep=' + ep);
 			alert("전송되었습니다");
		}
	});
	
});
</script>
</head>
<body class="hold-transition register-page">
	<div class="register-box">
		<div class="register-logo">
			<a href="${pageContext.request.contextPath }/join/login.do"><b>G</b>D</a>
		</div>
		<div class="register-box-body">
			<p class="login-box-msg">비밀번호 찾기</p>

				<div class="form-group has-feedback">
					<input type="text" class="form-control" id="emp_num" placeholder="사원번호">
					<span class="glyphicon glyphicon-user form-control-feedback"></span>
				</div>
				<div class="form-group has-feedback">
					<input type="text" class="form-control" id="emp_name" placeholder="이름">
					<span class="glyphicon glyphicon-lock form-control-feedback"></span>
				</div>
				<div class="form-group has-feedback">
					<input type="email" class="form-control" id="emp_mail" placeholder="이메일">
					<span class="glyphicon glyphicon-envelope form-control-feedback"></span>
				</div>
				<div class="row">
					<div class="col-xs-4 right">
						<button type="button" class="btn btn-primary btn-block btn-flat" id="check">체크</button>
						<div id="message"></div>
					</div>
					<!-- /.col -->
				</div>
				<div class="social-auth-links text-center">
					<a href="#" class="btn btn-block btn-social btn-facebook btn-flat" id="send"><i class="fa fa-envelope"></i>비밀번호 이메일 전송</a>
				</div>
		</div>
		<!-- /.form-box -->
	</div>
<!-- /.register-box -->
</body>
</html>