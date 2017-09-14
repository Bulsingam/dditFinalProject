<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
$(function(){
	if ($.ui && $.ui.dialog && $.ui.dialog.prototype._allowInteraction) {
	    var ui_dialog_interaction = $.ui.dialog.prototype._allowInteraction;
	    $.ui.dialog.prototype._allowInteraction = function(e) {
	        if ($(e.target).closest('.select2-dropdown').length) return true;
	        return ui_dialog_interaction.apply(this, arguments);
	    };
	}
	
	$('form[name=updateForm]').submit(function(){
		var emp_mail = $('input[name=emp_mail1]').val()+'@'+$('input[name=emp_mail2]').val();
		var emp_tel = $('input[name=emp_tel1]').val()+'-'+$('input[name=emp_tel2]').val()+'-'+$('input[name=emp_tel3]').val();
		var emp_regnum = $('input[name=emp_regnum1]').val()+'-'+$('input[name=emp_regnum2]').val();
		$('input[name=emp_tel]').val(emp_tel);
		$('input[name=emp_mail]').val(emp_mail);
		$('input[name=emp_regnum]').val(emp_regnum);
		
		if($('input[name=emp_pass]').val()== ''){
			alert("비밀번호를 입력해주십시오");
			return false;
		}
		if($('input[name=emp_name]').val()== ''){
			alert("성명을 입력해주십시오");
			return false;
		}
		
		if($('input[name=emp_regnum1]').val() == '' || $('input[name=emp_regnum2]').val()==''  
				|| !$('input[name=emp_regnum]').val().validationREGNO()){
			alert("주민번호를 정확히 입력해주십시오");
			return false;
		}
		if(!$('input[name=emp_tel]').val().validationHP() || $('input[name=emp_tel1]').val() =='' 
					|| $('input[name=emp_tel2]').val()=='' || $('input[name=emp_tel3]').val() ==''){
			alert("휴대폰 번호를 정확히 입력해주십시오");
			return false;
		}
		if($('input[name=emp_mail1]').val() == '' ||   $('input[name=emp_mail2]').val() =='' 
			|| !$('input[name=emp_mail]').val().validationMAIL()){
			alert("메일을 정확히 입력해주십시오");
			return false;
		}
		if($('input[name=emp_addr]').val() == '' ){
			alert("주소를 입력해주십시오");
			return false;
		}
		
		$(this).attr('action','${pageContext.request.contextPath}/humanResource/updateEmployee.do');
	});

	var img = '${CommonConstant.EMPLOYEE_SIGN}';
	$("#emp_img_name").on('change', function(){
        readURL(this);
    });
	$("#emp_sign_name").on('change', function(){
        readURL(this);
    });
	$('#back').on('click',function(){
		var $frm = $('<form action="${pageContext.request.contextPath}/employee/employeeList.do" method="post"></form>');
		$frm.append('<input type="hidden" name="search_keyword" value="${search_keyword}">');
		$frm.append('<input type="hidden" name="search_keycode" value="${search_keycode}">');
		$frm.append('<input type="hidden" name="currentPage" value="${currentPage}">');
		$('body').append($frm);
		$frm.submit();
	})
	
})
function emp_imgURL(input) {
    if (input.files && input.files[0]) {
    var reader = new FileReader();
	
    reader.onload = function (e) {
            $('#emp_img').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
      var img = reader.readAsDataURL(input.files[0]);
      $('input[name="emp_sign"]').val(img);
    }
}

function emp_signURL(input) {
    if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function (e) {
            $('#emp_sign').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
      var sign = reader.readAsDataURL(input.files[0]);
      $('input[name="emp_sign"]').val(sign);
      
    }
}

function openDaumPostcode() {
	daum.postcode.load(function(){
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
                // 예제를 참고하여 다양한 활용법을 확인해 보세요.
            	 document.getElementById("emp_addr").value = data.address;
            	 document.getElementById("emp_addr").focus();
            }
        }).open();
    });
}
</script>
</head>
<body>

	<div class="row">
	<form class="form-horizontal" name="updateForm" action="" 
		method="post" enctype ="multipart/form-data">
		<input type="hidden" class="form-control" name="emp_tel" placeholder="전화번호" value="" >
		<input type="hidden" class="form-control" name="emp_mail" placeholder="이메일" value="" >
		<input type="hidden" class="form-control" name="emp_regnum" placeholder="주민번호" value="" >
		<div class="col-md-3 " style="margin-left:20px;">
			<div class="box box-primary " style="padding:20px;">
				<div class="box-header" style="margin: auto; margin-top: 10px;">
					<h4>개인사진</h4>
				</div>
				<div style="width: 150px; height: 172px; margin: auto;">

					<a href="">
					<img class="ahover"
						alt="개인사원 이미지" name="files" id="emp_img"
						src="/2jo/Employee/img/${empInfo.EMP_IMG}"
						style="width: 150px; height: 150px; margin: auto;"></a>
					<input type="file" class="filestyle" name="files" data-buttonName="btn-primary" onchange="emp_imgURL(this);" id="emp_img_name">
					<input type="hidden" name="emp_img" value="">
					
				</div>
				<div class="box-header" style="margin: auto; margin-top: 20px;">
					<h4>개인서명</h4>
				</div>
				<div style="width: 150px; height: 172px; margin: auto;">
					<a href="">
					<img class="ahover" id="emp_sign"
						alt="개인서명 이미지" name="files"
						src="/2jo/Employee/sign/${empInfo.EMP_SIGN}"
						style="width: 150px; height: 150px; margin: auto;"></a>
					<input type="file" class="filestyle" name="files" data-buttonName="btn-primary" onchange="emp_signURL(this);" id="emp_sign_name">
					<input type="hidden" name="emp_sign" value="">
					
				</div>

			</div>
		</div>

		<div class="col-lg-8 col-md-8" style="min-width: 500px;">
			<!-- 			<div class="box boxinfo "> -->
			<div class="box box-primary col-lg-12 col-md-12">
				<div class="box-header">
					<h2>사원 정보</h2>
				</div>
				<div class="row">
					
						<div class="box-body col-md-12 " style="padding-bottom:-10px;">
							<div class="form-group col-md-6">
								<label class="col-md-3 control-label" style="margin-top: 5px; padding: 0px;">사원번호</label>
								<div class="col-md-8 col-md-offset-1">
									<input type="text" class="form-control  " placeholder="사원번호" name="emp_num" readonly value="${empInfo.EMP_NUM }" > 
									<span class="glyphicon glyphicon-user form-control-feedback "
										style="margin-right: 10px;"></span>
								</div>
							</div>
							<div class="form-group col-md-6">
								<label class="col-md-2 control-label" style="margin-top: 5px; padding: 0px;">패스워드</label>
								<div class="col-md-8 col-md-offset-1">
									<input type="text" class="form-control col-lg-4" placeholder="패스워드" name="emp_pass"  value="${empInfo.EMP_PASS }" > 
									<span class="glyphicon glyphicon-lock form-control-feedback"
										style="margin-right: 10px;"></span>
								</div>
							</div>
						</div>
						<div class="box-body col-md-12 " >
						<div class="form-group col-md-6">
							<label class="col-md-3 control-label" style="margin-top: 5px; padding: 0px;">입사일</label>
							<div class="col-lg-8 col-md-offset-1">
								<div class="input-group date " >
									<div class="input-group-addon">
										<i class="fa fa-calendar"></i>
									</div>
									
									<input type="text" class="form-control pull-right col-lg-11" name="emp_joindate"
										id="datepicker" value="<fmt:formatDate value="${empInfo.EMP_JOINDATE }" pattern="yyyy-MM-dd"/>" readonly>
								</div>
							</div>
						</div>
						</div>
						<hr style="margin:20px;" class="col-lg-12">
						<div class="form-group col-md-6">
							<label class="col-md-3 control-label" style="margin-top: 5px;">성명</label>
							<div class="col-md-8 col-md-offset-1">
								<input type="text" class="form-control" placeholder="성명" name="emp_name" value="${empInfo.EMP_NAME }">
								<span class="glyphicon glyphicon-user form-control-feedback "
									style="margin-right: 10px;"></span>
							</div>

						</div>
					</div>
					<div class="row">	
						<div class="form-group col-md-6">
							<label class="col-md-3 control-label" style="margin-top: 5px;">직위</label>
							<div class="col-lg-8 col-md-offset-1">
									<select class="form-control select2" name="emp_pos">
						                 <c:forEach items="${positionList}" var="positionInfo" >
		                                    <option value="${positionInfo.pos_id}">${positionInfo.pos_name}</option>
		                                 </c:forEach>
                                 	</select>
							</div>
						</div>
						<div class="form-group col-md-6">
							<label class="col-md-2 control-label" style="margin-top: 5px;">직책</label>
							<div class="col-lg-8 col-md-offset-1">
								<div class="form-group col-lg-4" style="width:92%">
									<select class="form-control select2" name="emp_role">
										<c:forEach items="${roleList}" var="roleInfo" >
		                                    <option value="${roleInfo.role_id}">${roleInfo.role_name}</option>
		                                 </c:forEach>
						               
                                 	</select>
					              </div>
							</div>
						</div>
						<div class="form-group col-md-12">
							<label class="col-md-2 control-label" style="margin-top: 5px;">주민등록번호</label>
							<div class="col-md-9 col-md-offset-1" style="margin: 0px;">
								<input type="text" name='emp_regnum1'
									class=" col-lg-4  form-control col-md-4  col-xs-4 "
									style="display: inline; width: 40%;" placeholder="주민등록번호 앞자리" value="${empInfo.EMP_REGNUM1 }"/>
								<i class="fa  fa-minus col-md-1 col-xs-1"
									style="width: 10px; margin: 10px 10px 0px 10px; padding: 0px;"></i>
								<input type="text" name='emp_regnum2'
									class=" col-lg-4  form-control col-md-4 col-xs-4 "
									style="display: inline; width: 45%;" placeholder="주민등록번호 뒷자리" value="${empInfo.EMP_REGNUM2 }"/>
								<!-- 									</div> -->
							</div>
						</div>
						<hr class="form-group col-md-12">
						
						<div class="form-group col-md-12">
							<label class="col-md-2 control-label" style="margin-top: 5px;">
								휴대폰번호 </label>
							<div class="col-md-9 col-lg-offset-1" style="margin: 0px;">
								<input type="text" name='emp_tel1'
									class=" col-lg-3  form-control  col-md-3  col-xs-3"
									style="display: inlineblock; width: 27%;" placeholder="휴대폰 번호1" />
								<i class="fa  fa-minus col-md-1 col-xs-1"
									style="width: 10px; margin: 10px 8px 0px 8px; padding: 0px;"></i>
								<input type="text" name='emp_tel2'
									class=" col-lg-3  form-control col-md-3  col-xs-3"
									style="display: inlineblock; width: 27%;" placeholder="휴대폰 번호2" />
								<i class="fa  fa-minus col-md-1 col-xs-1"
									style="width: 10px; margin: 10px 8px 0px 8px; padding: 0px;"></i>
								<input type="text" name='emp_tel3'
									class=" col-lg-3  form-control col-md-3 col-xs-3"
									style="display: inlineblock; width: 28%;" placeholder="휴대폰 번호3" />
							</div>
						</div>
						<div class="form-group col-md-12">
							<label class="col-md-2 control-label" style="margin-top: 5px;">메일 </label>
							<div class="col-md-9 col-md-offset-1" style="margin: 0px;">
								<input type="text" name='emp_mail1'
									class=" col-lg-4  form-control col-md-4  col-xs-4 "
									style="display: inline; width: 40%;" placeholder="메일 아이디" />
								<i class="fa fa-at col-md-1 col-xs-1"
								style="width: 10px; margin: 10px 10px 0px 10px; padding: 0px;"></i>
								<input type="text" name='emp_mail2'
									class=" col-lg-4  form-control col-md-4 col-xs-4 "
									style="display: inline; width: 45%;" placeholder="도메인" />	
							</div>
						</div>
						<div class="form-group col-md-12">
							<label class="col-md-2 control-label" style="margin-top: 5px;">주소</label>
							<div class="col-md-10">
								<input type="text" name='emp_addr' id="emp_addr"
									class=" col-lg-7  form-control col-md-7 col-xs-3 "
									style="display: inlineblock; width: 80%;" placeholder="주소" value="${empInfo.EMP_ADDR}"/>
								<div class="col-lg-2">
									<button type="button"
										class="btn btn-primary btn-block btn-flat col-lg-3 col-md-2"
										style="margin-left: 0px; padding-left: 0px;" onclick="openDaumPostcode()" >주소검색</button>
								</div>
								<!-- 											</div> -->
							</div>
						</div>
						<!-- 								</div> -->
						<div class="row" style="margin-bottom: 20px;">
							<!-- /.col -->
							<div class="col-md-2 col-lg-offset-4">
								<button type="button" class="btn btn-primary btn-block btn-flat" id="back">뒤로</button>
							</div>
							<div class="col-md-2 ">
								<button type="submit" class="btn btn-primary btn-block btn-flat">수정</button>
							</div>
							<div class="col-md-2 ">
								<button type="button" class="btn btn-primary btn-block btn-flat">취소</button>
							</div>
<!-- 							<div class=" col-md-2 "> -->
<!-- 								<button type="button" class="btn btn-primary btn-block btn-flat">삭제</button> -->
<!-- 							</div> -->
							<!-- /.col -->
						</div>
				</div>
			</div>
		</div>
					</form>
	</div>
	<!-- 	///////////////////////////////////////////////////////////////////////////////////////// -->
		<div class="box box-primary ">
			<div class="row">
				<form action="" class="form-horizontal">
						<div class="box-body ">
							<div class="form-group" style="margin-left:20px;">
								<label class="col-md-2"control-label" style="padding:10px;">경력사항</label>
								<div class="col-md-7">
									<div class="box-body">
										<table id="example1"
											class="table table-bordered table-striped">
											<thead>
												<tr>
													<th>프로젝트명</th>
													<th>역할</th>
													<th>프로젝트 시작일</th>
													<th>프로젝트 종료일</th>
												</tr>
											</thead>
											<tbody>
											<c:forEach items="${endList}" var="endInfo">
												<tr>
													<td>${endInfo.PRO_NAME }</td>
													<td>${endInfo.MEM_ROLE }</td>
													<td><fmt:formatDate value="${endInfo.PRO_STARTDATE}" pattern="yyyy-MM-dd"/></td>
													<td><fmt:formatDate value="${endInfo.PRO_ENDDATE }" pattern="yyyy-MM-dd"/></td>
												</tr>
											</c:forEach>	
											</tbody>
										</table>
									</div>
								</div>
							</div>
							<div class="form-group" style="margin-left:20px;">
								<label class="col-md-2"control-label" style="padding-left:10px;">근무평가</label>
								<div class="col-md-7">
									<div class="box-body">
										<table id="example1"
											class="table table-bordered table-striped">
											<thead>
												<tr>
													<th>프로젝트ID</th>
													<th>내용</th>
													<th>역할</th>
													<th>등급</th>
													<th>작성자</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach items="${empWorkRateList }" var="workRateInfo">
												<tr>
													<td>${workRateInfo.PRO_NAME }</td>
													<td>${workRateInfo.WRT_CONT }</td>
													<td>${workRateInfo.MEM_ROLE }</td>
													<td>${workRateInfo.WRT_LEV }</td>
													<td>${workRateInfo.WRT_RATER }</td>
												</tr>
												</c:forEach>
											</tbody>
										</table>
									</div>
								</div>
							</div>
					</div>
				</form>
			</div>
	</div>

</body>

<script>
$(function(){
	
	var tel1 = "${fn:split(empInfo.EMP_TEL, '-')[0]}";
	var tel2 = "${fn:split(empInfo.EMP_TEL, '-')[1]}";
	var tel3 = "${fn:split(empInfo.EMP_TEL, '-')[2]}";
	
	$('input[name="emp_tel1"]').val(tel1);
	$('input[name="emp_tel2"]').val(tel2);
	$('input[name="emp_tel3"]').val(tel3);
	
	var Mail1 = "${fn:split(empInfo.EMP_MAIL, '@')[0]}";
	var Mail2 = "${fn:split(empInfo.EMP_MAIL, '@')[1]}";
	
	$('input[name="emp_mail1"]').val(Mail1);
	$('input[name="emp_mail2"]').val(Mail2);
	
	$('select[name=emp_pos] option[value=${empInfo.POS_ID}]').attr('selected', true);
	$('select[name=emp_role] option[value=${empInfo.EMP_ROLE}]').attr('selected', true);
	
// 	$('input[name="emp_img"]').val('${empInfo.EMP_IMG}');
// 	$('input[name="emp_sign"]').val('${empInfo.EMP_SIGN}');
	
})
</script>
</html>