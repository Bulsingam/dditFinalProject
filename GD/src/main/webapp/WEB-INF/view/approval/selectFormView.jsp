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
	var selectId = "";
	//div내 서식 이미지와 서식명 가운데 정렬
	$('#formList div').css({'text-align':'center', 'display':'inline-block'});
	//서식 이미지 규격 설정
	$('img[name="formImage"]').css({'margin':'10px', 'opacity':'0.7', 'width':'170px','height':'250px'});
	//서식 이미지 클릭시 클릭한 이미지는 불투명하게, 그 외 이미지는 투명하게 설정
	$('img[name="formImage"]').click(function(){
		var index = $(this).index();
		$(this).animate({opacity : '1.0'}, 150).css('border','2px solid rgb(194, 216, 252)');
		$('img[name="formImage"]').not(this).animate({opacity : '0.2'}, 200).css('border','2px solid white');
		selectId = $(this).attr('id');
	});
	//문서 수정을 통해 이 페이지에 들어왔을 때 기존 서식을 선택된 상태로 출력
	if('${formerFormNum}'!=''){
		$('img[id="${formerFormNum}"]').click();
	}
	$('#fromFormToDocBtn').bind('click', function(){
		if(selectId==""){
			alertModal('서식을 선택해주세요!');
			return false;
		}
		var $frm = $('<form action="${pageContext.request.contextPath}/approval/writeDocument.do" method="post"></form>');
		if('${formerFormNum}'!=''){
			//문서 수정을 통해 이 페이지에 들어왔을 때 요청 경로 수정
			$frm.attr('action','${pageContext.request.contextPath}/approval/updateDocument.do')
		}
		$frm.append('<input type="hidden" name="form_num" value="'+selectId+'">');
		$frm.appendTo('body');
		$frm.submit();
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
	<div>
		<div class="box box-info">
			<div class="box-header">
				<h4>서식 선택</h4>
				<h6>작성할 문서의 서식을 선택하고 '다음' 버튼을 클릭해 주십시오.</h6>
			</div>
			<div class="box-body">
				<div class="col-sm-1"></div>
				<div id="formList" align="center" class="col-sm-10">
					<c:forEach items="${formList }" var="form">
						<div class="col-sm-3">
							<img src="${pageContext.request.contextPath }/2jo/Form/example/${form.FORM_EXAM}" 
								name="formImage" id="${form.FORM_NUM }"><br>
							<span>${form.FORM_NAME }</span>
						</div>
					</c:forEach>
				</div>
				<div class="col-sm-1"></div>
			</div>
			<div align="right" class="box-footer">
				<button class="btn btn-block btn-primary btn-lg" id="fromFormToDocBtn">다 음</button>
			</div>
		</div>
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