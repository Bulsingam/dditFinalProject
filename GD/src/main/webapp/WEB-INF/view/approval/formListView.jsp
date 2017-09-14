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
	$('button[name=formImageBtn]').bind('click', function(){
		var form_num = $(this).attr('value');
		var form_exam;
		<c:forEach items="${formList}" var="form">
			if(form_num == '${form.FORM_NUM}'){
				$('#formImage').attr('src','${pageContext.request.contextPath}/2jo/Form/example/${form.FORM_EXAM}');
			}
		</c:forEach>
	})
	
	$('select[name=proxSelect]').change(function(){
		var form_num = $(this).parent().parent().find('td:eq(0)').text();
		var value = $(this).val();
		$.ajax({
			url			:	"${pageContext.request.contextPath}/approval/updateFormProx.do"
			, data		:	{ "form_prox" : value , "form_num" : form_num }
			, dataType	:	"json"
			, success	:	function(data){
								
							}
		})	
	});
})
</script>
</head>
<body>
	<div>
		<div class="box">
			<div class="box-header with-border">
				<h3 class="box-title">서식 목록</h3>
			</div>
			<!-- /.box-header -->
			<div class="box-body">
				<table class="table table-bordered">
					<tbody>
						<tr>
							<th style="width : 76px">서식 번호</th>
							<th style="text-align : center">서식 제목</th>
							<th style="width : 200px; text-align : center;">파일명</th>
							<th style="width : 200px; text-align : center;">미리보기</th>
							<th style="width : 200px; text-align : center;">전결 관리</th>
						</tr>
						<c:forEach items="${formList}" var="form">
							<tr>
								<td style="text-align : center">${form.FORM_NUM }</td>
								<td style="text-align : center">${form.FORM_NAME }</td>
								<td style="text-align : center">${form.FORM_DATA }</td>
								<td>
									<button name="formImageBtn" type="button" class="btn btn-block btn-info" 
										data-toggle="modal" data-target="#modal-default" value="${form.FORM_NUM }">
										미리보기
									</button>
								</td>
								<td>
									<select class="form-control" name="proxSelect">
										<c:forEach items="${positionList }" var="position">
											<c:if test="${form.FORM_PROX eq position.pos_id }">
	                    						<option value="${position.pos_id }" selected="selected">${position.pos_name }</option>
	                    					</c:if>
											<c:if test="${form.FORM_PROX != position.pos_id }">
	                    						<option value="${position.pos_id }">${position.pos_name }</option>
	                    					</c:if>
	                    				</c:forEach>
	                 				</select>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>

			<!-- /.box-body -->
			<div class="box-footer clearfix">
				<ul class="pagination pagination-sm no-margin pull-left">
					<li><a href="#">«</a></li>
					<li><a href="#">1</a></li>
					<li><a href="#">2</a></li>
					<li><a href="#">3</a></li>
					<li><a href="#">»</a></li>
				</ul>
			</div>
		</div>
	</div>
<div>
</div>


<!-- 결재 모달 창 -->
<div class="modal fade" id="modal-default" style="display: none;">
	<div id="approvalWindow" class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
				<h4 class="modal-title">서식 미리보기</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<img id="formImage" src="" width="100%" height="100%">
                </div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default pull-left" data-dismiss="modal">
					<i class="fa fa-fw fa-close"></i> 닫기
				</button>
			</div>
		</div>
	</div>
</div>

</body>
</html>