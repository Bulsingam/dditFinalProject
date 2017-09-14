<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
.ahover {
	
}
</style>
<script type="text/javascript">
$(function() {
	$('.ahover').hover(function() {
		$(this).css('border', '1px solid black');
	}, function() {
		$(this).css('border', '1px solid white');
	})
	
	$("#emp_img_name").on('change', function(){
        readURL(this);
    });
	$("#emp_sign_name").on('change', function(){
        readURL(this);
    });
	
	$('#btnCancle').click(function(){
		location.reload();
	});
	
	$('form').submit(function(){
		var emp_mail = $('input[name=emp_mail1]').val() +"@"+ $('input[name=emp_mail2]').val();  
		var emp_addr = $('input[name=emp_addr1]').val() + $('input[name=emp_addr2]').val();  
		var emp_tel = $('input[name=emp_tel1]').val() +"-"+$('input[name=emp_tel2]').val() +"-"+ $('input[name=emp_tel3]').val();
		
		
		
		$(this).append('<input type="hidden" name="emp_mail" value='+emp_mail+'>');
		$(this).append('<input type="hidden" name="emp_addr" value='+emp_addr+'>');
		$(this).append('<input type="hidden" name="emp_tel" value='+emp_tel+'>');
		return true;
	})
})

function emp_imgURL(input) {
    if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function (e) {
            $('#emp_img').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
}

function emp_signURL(input) {
    if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function (e) {
            $('#emp_sign').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }   
}

function openDaumPostcode() {
	daum.postcode.load(function(){
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
                // 예제를 참고하여 다양한 활용법을 확인해 보세요.
            	 document.getElementById("emp_addr1").value = data.address;
            	 document.getElementById("emp_addr2").focus();
            }
        }).open();
    });
}
</script>
</head>
<body>
	<form action="${pageContext.request.contextPath }/humanResource/insertEmployee.do" method="post" enctype ="multipart/form-data">
	<div class="row">
		<div class="col-md-3">
			<div class="box box-primary " style="padding-bottom:20px;">
				<div class="box-header" style="margin: auto; margin-top: 5px; ">
					<h4>개인사진</h4>
				</div>
				<div style="width: 210px; height: 180px; margin: auto;">
					<img class="ahover" alt="개인사원 이미지" id="emp_img"
						src="#"
						style="width: 200px; height: 180px; margin: auto;">
					<input type="file" class="filestyle" name="files" data-buttonName="btn-primary" onchange="emp_imgURL(this);" id="emp_img_name">
				</div>
				
				<div class="box-header" style="margin: auto; margin-top: 20px;">
					<h4>개인서명</h4>
				</div>
				<div style="width: 210px; height: 180px; margin: auto; margin-bottom:30px;">
					<img class="ahover" alt="개인사원 이미지" id="emp_sign"
						src="#"
						style="width: 200px; height: 180px; margin: auto;">
					<input type="file" class="filestyle" name="files" data-buttonName="btn-primary" onchange="emp_signURL(this);" id="emp_sign_name">	
				</div>
			</div>
		</div>

		<div class="col-lg-8 col-md-8" style="min-width: 500px;  ">
			<div class="box box-info col-lg-12 col-md-12 " style="padding-bottom:10px;">
				<div class="box-header">
					<h2>사원 정보 등록</h2>
				</div>
				<form action="../../index.html" method="post">
					<!-- 										  <label class="col-lg-1 form-group">성명 : </label> -->
					<div class="form-group has-feedback col-lg-11"
						style="margin-top: 5px; display: inlineblock; width: 94%;">
						<input type="password" class="form-control" placeholder="패스워드" name="emp_pass">
						<span class="glyphicon glyphicon-user form-control-feedback "
							style="margin-right: 10px;"></span>
					</div>
					<div class="form-group has-feedback col-lg-11"
						style="margin-top: 5px; display: inlineblock; width: 94%;">
						<input type="text" class="form-control" placeholder="성명" name="emp_name">
						<span class="glyphicon glyphicon-user form-control-feedback "
							style="margin-right: 10px;"></span>
					</div>
					<div class="row" style="margin-left:1px;">
						<div class="form-group">
	                     <div>
	                        <div class="form-group col-lg-5" style="width:46%;">
	                               <select class="form-control select2" name="emp_pos">
	                                 <option value="" disabled selected>직위</option>
	                                 <c:forEach items="${positionList}" var="positionInfo" begin="1">
	                                 	<option value="${positionInfo.pos_id}">${positionInfo.pos_name}</option>
	                                 </c:forEach>
	                               </select>
	                             </div>
	                     </div>
	                     <div>
	                        <div class="form-group col-lg-6" style="width:46%;">
	                               <select class="form-control select2" name="emp_role">
	                                 <option value="" disabled selected>직책</option>
	                                 <c:forEach items="${roleList}" var="roleInfo" begin="1">
	                                 	<option value="${roleInfo.role_id}">${roleInfo.role_id}</option>
	                                 </c:forEach>
	                               </select>
	                             </div>
	                     </div>
	                  </div>
                  </div>

					<div style="display: inline-block; margin-top: 5px;"
						class="form-group col-lg-12 col-md-12 col-xs-12 has-feedback "
						style="">
						<input type="text" name='emp_regnum1'
							class=" col-lg-5  form-control col-md-3  col-xs-3 "
							style="display: inlineblock; width: 45%;"
							placeholder="주민등록번호 앞자리" /> <i
							class="fa  fa-minus col-md-1 col-xs-1"
							style="width: 10px; margin: 10px 10px 0px 10px; padding: 0px;"></i>
						<input type="text" name='emp_regnum2'
							class=" col-lg-5  form-control col-md-3 col-xs-3 "
							style="display: inlineblock; width: 45%;"
							placeholder="주민등록번호 뒷자리" />
					</div>
					<div style="display: inline-block; margin-top: 5px;"
						class="form-group col-lg-12 col-md-12 col-xs-12 has-feedback ">
						<input type="text" name='emp_mail1'
							class=" col-lg-5  form-control col-md-3 col-xs-3 "
							style="display: inlineblock; width: 45%;" placeholder="메일 아이디" />
						<i class="fa fa-at col-md-1 col-xs-1"
							style="width: 10px; margin: 10px 10px 0px 10px; padding: 0px;"></i>
						<input type="text" name='emp_mail2'
							class=" col-lg-5  form-control col-md-3 col-xs-3 "
							style="display: inlineblock; width: 45%;" placeholder="도메인" />
					</div>
					<div style="display: inline-block; margin-top: 5px;"
						class="form-group col-lg-12 col-md-12 col-xs-12">
						<input type="text" name='emp_tel1'
							class=" col-lg-3  form-control  col-md-2  col-xs-2"
							style="display: inlineblock; width: 29%;" placeholder="휴대폰 번호1" />
						<i class="fa  fa-minus col-md-1 col-xs-1"
							style="width: 10px; margin: 10px 10px 0px 10px; padding: 0px;"></i>
						<input type="text" name='emp_tel2'
							class=" col-lg-3  form-control col-md-2  col-xs-2"
							style="display: inlineblock; width: 29%;" placeholder="휴대폰 번호2" />
						<i class="fa  fa-minus col-md-1 col-xs-1"
							style="width: 10px; margin: 10px 10px 0px 10px; padding: 0px;"></i>
						<input type="text" name='emp_tel3'
							class=" col-lg-3  form-control col-md-2  col-xs-2"
							style="display: inlineblock; width: 29%;" placeholder="휴대폰 번호3" />
					</div>

					<div style="display: inline-block; margin-top: 5px;"
						class="form-group col-lg-12 col-md-12 col-xs-12 has-feedback ">
						<input type="text" name='emp_addr1' id="emp_addr1"
							class=" col-lg-4  form-control col-md-3 col-xs-3  "
							style="display: inlineblock; width: 40%;" placeholder="주소" /> 
						<input type="text" name='emp_addr2' id="emp_addr2"
							class=" col-lg-4  form-control col-md-3 col-xs-3 col-sx-offset-1"
							style="display: inlineblock; width: 40%; margin-left:5px;" placeholder="상세주소" />
						<div class="col-md-2">
							<button type="button" class="btn btn-primary btn-block btn-flat" id="serchAddr"
								style="margin-left: 0px; width: 90%" onclick="openDaumPostcode()">주소검색</button>
						</div>
					</div>

					<div class="form-group col-lg-12 col-md-12">
						<div class="input-group date" style="width: 94%;">
							<div class="input-group-addon">
								<i class="fa fa-calendar"></i>
							</div>
							<input type="text" class="form-control pull-right col-lg-11" name="emp_joindate"
								id="datepicker" placeholder="입사일 (입력을 하지 않으면 현재날짜 자동입력)">
						</div>
					</div>
					<div class="col-md-2 col-lg-offset-4">
							<button type="summit" class="btn btn-primary btn-block btn-flat">등록</button>
					</div>
					
					<div class="col-md-2 col-lg-offset-1">
							<button type="button" class="btn btn-primary btn-block btn-flat" id="btnCancle">초기화</button>
					</div>
			</div>
		</div>

	</div>
</from>

	
</body>
</html>