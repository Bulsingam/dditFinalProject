<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

</head>
<script type="text/javascript">
$(function(){
    $('#pro_bo_cont').summernote({
			height: 150,
			codemirror: {
			theme: 'monokai'
		}
	});
    
    $('#pro_bo_cont').summernote('code', '${proBoInfo[0].PRO_BO_CONT}');
    
	$('form').submit(function(){
		$(this).append('<input type="hidden" name="pro_bo_cont" value="' + $('#pro_bo_cont').summernote('code') + '"/>');
	});
	
	$('#cencle').click(function(){
		$(location).attr('href', '${pageContext.request.contextPath}/projectBoard/proBoList.do?pro_id=${proBoInfo[0].PRO_BO_PROID}');
	});
})
</script>
<body>
	<!-- Horizontal Form -->
	<div class="box box-info">
		<div class="box-header with-border">
			<h3 class="box-title">자료실</h3>
		</div>
		<!-- /.box-header -->
		<!-- form start -->
		<form class="form-horizontal" action="${pageContext.request.contextPath }/projectBoard/updateProBo.do" method="post" enctype="multipart/form-data">
			<div class="box-body">

				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">제목</label>
					<div class="col-sm-10">
						<input type="hidden" name="pro_bo_num" value="${proBoInfo[0].PRO_BO_NUM}">
						<input type="hidden" name="pro_bo_writer" value="${proBoInfo[0].PRO_BO_WRITER}">
						<input type="hidden" name="pro_bo_proid" value="${proBoInfo[0].PRO_BO_PROID}">
						<input type="text" class="form-control" name="pro_bo_title" value="${proBoInfo[0].PRO_BO_TITLE}" />
					</div>
				</div>

				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">내용</label>
					<div class="col-sm-10">
						<div id="pro_bo_cont"></div>
					</div>
				</div>

			</div>
			<!-- /.box-body -->
			<div class="box-footer">
				<button type="button" class="btn btn-default pull-right" style="margin: 0px 10px;" id="cencle">취소</button>
				<button type="submit" class="btn btn-info pull-right">저장</button>
			</div>
			<!-- /.box-footer -->
		</form>
	</div>
	<!-- /.box -->
</body>
</html>