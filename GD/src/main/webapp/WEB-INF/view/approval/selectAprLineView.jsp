<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/css/select2.min.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/js/select2.min.js"></script>
<title>Insert title here</title>
<script type="text/javascript">
	$(document).ready(function() {
	  $(".js-example-basic-single").select2({
		  placeholder : "사원"
		  , allowClear: true
	  });
	});
	
	$(function(){
		$('.box-info').css('padding', '15px');
		$('.box-info img').css({'width':'70px', 'height':'70px'});
		
		$('select[name="emp_num"]').change(function(){
			var select_emp = $(this).val();
			var select_pos = $(this).attr('id');
			var imgPath = "";
			$.ajax({
				url			:	"${pageContext.request.contextPath}/approval/getEmpImg.do"
				, type		:	"post"
				, data		:	{ "emp_num" : select_emp }
				, dataType	:	"json"
				, success	:	function(data){
									var imgName = data.emp_img;
									imgPath = '${pageContext.request.contextPath}/2jo/Employee/img/'+imgName;
									$('#img'+select_pos).attr('src',imgPath);
								}
			})
		})
		
		$('#fromLineToInsertBtn').bind('click', function(){
			var isFull = true;
			var $frm = $('<form action="${pageContext.request.contextPath}/approval/insertApproval.do" method="post"></form>');
			$('select[name="emp_num"]').each(function(i, item){
				var inputValue = $(item).val();
				if(inputValue == 'none'){
					isFull = false;
				} else {
					$frm.append('<input type="hidden" name="emp_num" value="'+inputValue+'">');
				}
			})
			if('${formerAprLine[0].DET_LINENUM}' != ''){
				//수정 상황일때 요청 URI 변경
				$frm.attr('action','${pageContext.request.contextPath}/approval/updateApproval.do');
			}
			$frm.appendTo('body');
			if(isFull){
				$frm.submit();
			} else {
				alertModal('결재선을 모두 선택해주세요');
				return false;
			}
		})
	})
function alertModal(context){
	$('.modal-body').text(context);
	var $btn = $('<button type="button" class="btn btn-success pull-right" data-toggle="modal" data-target="#modal-default">');
	$btn.appendTo('body');
	$btn.click();
}
</script>
</head>
<body>
<div class="box box-info">
	<div class="box-header">
		<h4>결재선 선택</h4>
		<h6>결재선에 포함될 사원을 선택해 주십시오.
			<br>기안자는 당신이며, 자동적으로 당신보다 높은 직급의 결재선만 선택 가능합니다.
			<br>선택 후 '작성'버튼을 눌러주십시오.
		</h6>
	</div>
	<hr class="col-md-12">
	<c:forEach items="${candidates }" var="candidateList">
		<div name="aprList" class="col-md-4" style="display: inline-block;">
			<img id="img${candidateList[0].EMP_POS }" src="${pageContext.request.contextPath }/2jo/Employee/img/noone.png" 
				class="img img-circle">
			<div style="display: inline-block; vertical-align: middle; margin-left: 20px;">
				<h4>${candidateList[0].POS_NAME }</h4>
				<select name="emp_num" id="${candidateList[0].EMP_POS }" class="js-example-basic-single" style="width: 100%">
					<option selected="selected" value="none">사원명</option>
					<c:forEach items="${candidateList}" var="candidate">
						<option value="${candidate.EMP_NUM }">${candidate.EMP_NAME }(${candidate.EMP_NUM })</option>
					</c:forEach>
				</select>
			</div>
		</div>
	</c:forEach>
	<hr class="col-md-12">
	<button class="btn btn-block btn-primary btn-lg" id="fromLineToInsertBtn">다음</button>
</div>


<!-- 에러 모달창 -->
<div class="modal modal-warning fade in" id="modal-default" style="display: none;">
	<div id="approvalWindow" class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
				<h4 class="modal-title">에러</h4>
			</div>
			<div class="modal-body"></div>
		</div>
	</div>
</div>
</body>
</html>