<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/css/select2.min.css" rel="stylesheet" />
<script	src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/js/select2.min.js"></script>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="row">
	<div class="col-md-12">
		<section class="content"> <!-- SELECT2 EXAMPLE -->
			<div class="box box-default col-md-6">
				<div class="box-header with-border">
					<h3 class="box-title">메세지 보내기</h3>
					<div class="box-tools pull-right">
						<button type="button" class="btn btn-box-tool"
							data-widget="collapse">
							<i class="fa fa-minus"></i>
						</button>
						<button type="button" class="btn btn-box-tool" data-widget="remove">
							<i class="fa fa-remove"></i>
						</button>
					</div>
				</div>
				<!-- /.box-header -->
				<div class="box-body ">
					<div class="row">
						<div class="col-md-6">
							<div class="form-group ">
								<label>메세지를 보낼 사람을 선택하세요</label> 
								<select	class="form-control select2" multiple="multiple"
									data-placeholder="Select a State" style="width: 100%;"
									id="selectList">
									<option>all</option>
									<c:forEach items="${smsList}" var="smsListInfo">
										<option>${smsListInfo.EMP_NAME }(${smsListInfo.EMP_TEL })</option>
									</c:forEach>
	
								</select>
							</div>
							<div class="form-group">
								<label>보내실 메세지를 입력해주세요</label>
								<textarea class="form-control" rows="3"
									placeholder="보낼 메세지를 입력하세요" id="message"></textarea>
							</div>
						</div>
					</div>
					<div id="toPerson">
						<input type="hidden" name="to">
					</div>
					<button type="button" class="btn btn-box-tool" value="메세지 전송"
						id="send">
						<span style="margin-right: 15px;">send</span> <i class="fa fa-envelope"
							style="text-align: right; size: 15px;"></i>
					</button>
				</div>
			</div>
		</section>
	</div>
</div>
</body>
<script>
$(function () {
	$('.select2').select2();
	$('#send').click(function(){
		var issucess;
		if($('message').val() != null && $('li.select2-selection__choice').text() != null ){
			var emp = [];
			var message = $('#message').val();
			$("li.select2-selection__choice").each(function(){
				var title = $(this).text();
				var nox = title.substring(1);
				if(nox == "all"){
					emp.push(nox);
	    		}else{
					var tel = nox.split('(');
					var telsprit = tel[1].split(')');
					alert(telsprit[0]);
					emp.push(telsprit[0]);
				}
	          
	       });
			var $frm = $('<form action="${pageContext.request.contextPath}/employee/sendMessage.do" method="post"></form>');
			$frm.append('<input type="hidden" name="emp" value="'+emp+'"/>');
			$frm.append('<input type="hidden" name="messageText" value="'+message+'"/>');
			$(document.body).append($frm);
			$frm.submit();
			
		}else{
			alert("메세지를 다시 확인해주세요");
			return false;
		}
    });

})
</script>
</html>