<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Map"%>
<%@ page import="kr.or.gd.utils.RSAGenerateKey"%>    
<%
	RSAGenerateKey generateKey = new RSAGenerateKey();
	Map<String,String> keyMap = generateKey.getGeneratePairKey(session);
%>
<!DOCTYPE html>
<style>
video {
	width:100%;
	position : absolute;
	top : 0px; 
	left : 0px;
	min-width : 100 %;
	min-height : 100 %;
/* 	width : auto; */
/* 	height : auto; */
	z-index : -1;
}
body{
	background : url ('${pageContext.request.contextPath}/image/intro.mp4') center center fixed no-repeat;
}
</style>
<html>
<head>
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
<!-- iCheck -->
<%-- <script src="${pageContext.request.contextPath }/resources/plugins/iCheck/icheck.min.js"></script> --%>
<!-- 암호화 -->
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jsbn.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/rsa.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/prng4.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/rng.js"></script>
<script>
$(function(){
	if(eval('${!empty message}')){
		alert('${message}');
	}
	
	//쿠키
// 	if(Get_Cookie('save_id')){
// 		$('input[name=emp_num]').val(Get_Cookie('save_id'));
// 		$('input[name=save_id]').attr('checked',true);
// 	}
	
// 	$('#btnlogin').click(function(){
// 		if($('input[name=save_id]').is(':checked')){
// 			Set_Cookie('save_id',$('input[name=emp_num]').val(),1,"/");
// 		}else{
// 			if(Get_Cookie('save_id')){
// 				Delete_Cookie('save_id','/');
// 			}
// 		}
// 	});
	//암호화
	$('form').submit(function(){
		if($('input[name=emp_num]').val==''){
			return false;
		}
		if($('input[name=emp_pass]').val==''){
			return false;
		}
		
		var rsa = new RSAKey();
		rsa.setPublic('<%=keyMap.get("modulus")%>','<%=keyMap.get("exponent")%>');
		
		$('input[name=emp_num]').val(rsa.encrypt($('input[name=emp_num]').val()));
		$('input[name=emp_pass]').val(rsa.encrypt($('input[name=emp_pass]').val()));
		return true;
	});
	
/////////////////////아이디 저장////////////////////////////

    // 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
    var userInputId = getCookie("userInputId");
    $("input[name=emp_num]").val(userInputId); 
     
    if($("input[name=emp_num]").val() != ""){ // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
        $("#idSaveCheck").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
    }
     
    $("#idSaveCheck").change(function(){ // 체크박스에 변화가 있다면,
        if($("#idSaveCheck").is(":checked")){ // ID 저장하기 체크했을 때,
            var userInputId = $("input[name=emp_num]").val();
            setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
        }else{ // ID 저장하기 체크 해제 시,
            deleteCookie("userInputId");
        }
    });
     
    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
    $("input[name=emp_num]").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
        if($("#idSaveCheck").is(":checked")){ // ID 저장하기를 체크한 상태라면,
            var userInputId = $("input[name=emp_num]").val();
            setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
        }
    });



});

// 쿠키이름과 값, 그리고 유효날짜를 파라미터로 받아서 쿠키를 설정
function setCookie(cookieName, value, exdays){
	   var exdate = new Date();
	   exdate.setDate(exdate.getDate() + exdays);
	   var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
	   document.cookie = cookieName + "=" + cookieValue;
}
// 쿠키이름만 받아서 그 쿠키의 유효기간을 이용하여 유효하지 않게 만들어서 삭제
function deleteCookie(cookieName){
	   var expireDate = new Date();
	   expireDate.setDate(expireDate.getDate() - 1);
	   document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
}
// 쿠키이름을 받아서 그 쿠키에 들어있는 값을 반환
function getCookie(cookieName) {
	   cookieName = cookieName + '=';
	   var cookieData = document.cookie;
	   var start = cookieData.indexOf(cookieName);
	   var cookieValue = '';
	   if(start != -1){
	      start += cookieName.length;
	      var end = cookieData.indexOf(';', start);
	      if(end == -1)end = cookieData.length;
	      cookieValue = cookieData.substring(start, end);
	   }
	   return unescape(cookieValue);
}
</script>
</head>
<%-- poster = "${pageContext.request.contextPath}/image/GD.png" style="background-color:white;"--%>
<body class="hold-transition login-page" background-image="">
	<video autoplay="true" preload="auto" loop="loop">
		<source src="${pageContext.request.contextPath}/image/intro3.mp4" type="video/mp4">
	</video>
	<div class="login-box box box-primary" style="background: white; width: 360px; height: 600px; padding: 2%; border: 1px solid #00c0ef; border-radius: 15px;">
		<div class="login-logo">
			<a href="../../index2.html"><img src="${pageContext.request.contextPath}/image/LoginLogo.png" alt="GreatDeveloper Logo"/></a>
		</div>
		<!-- /.login-logo -->
		<div class="login-box-body">
			<p class="login-box-msg">Sign in to start your session</p>
		
			<form action="/join/loginCheck.do" method="post">
				<br> <br>
				<div class="form-group has-feedback">
					<input type="text" class="form-control" placeholder="사원번호입력" name="emp_num" id="emp_num"> <span
						class="glyphicon glyphicon-user form-control-feedback fa-user"></span>
				</div>
				<div class="form-group has-feedback">
					<input type="password" class="form-control" placeholder="패스워드를 입력해주세요" name="emp_pass" id="emp_pass">
					<span class="glyphicon glyphicon-lock form-control-feedback"></span>
				</div>
				<br>
				<div class="row">
					<div class="col-offset-2 col-xs-8">
						<div class="checkbox icheck">
							<label style="margin-left:20px"><input type="checkbox" id="idSaveCheck">아이디 저장</label>
						</div>
					</div>
					<!-- /.col -->
					<div class="col-xs-4">
						<button type="submit" class="btn btn-primary btn-block btn-flat" id="btnlogin">로그인</button>
					</div>
					<!-- /.col -->
				</div>
			</form>
		
			<div class="form-group">
				<a href="${pageContext.request.contextPath }/find/employeeNumberFind.do">사원번호 </a>/ 
				<a href="${pageContext.request.contextPath }/find/passwordFind.do"> 비밀번호찾기</a>
			</div>
		</div>
		<!-- /.login-box-body -->
	</div>
</body>
</html>
