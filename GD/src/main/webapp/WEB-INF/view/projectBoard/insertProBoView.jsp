<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">
$(function() {
	$('#pro_bo_cont').summernote({
		lang : 'ko-KR',
		height : 150,
		codemirror : {
			theme : 'monokai'
		}
	});
	
	$('form').submit(function(){	
		$(this).append('<input type="hidden" name="pro_bo_cont" value="' + $('#pro_bo_cont').summernote('code') + '"/>');
	});
	
	$('#cencle').click(function(){
		$(location).attr('href', '${pageContext.request.contextPath}/projectBoard/proBoList.do?pro_id=${pro_id }');
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
		<form class="form-horizontal" action="${pageContext.request.contextPath }/projectBoard/insertProBo.do" method="post">
			<div class="box-body">
				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">제목</label>

					<div class="col-sm-10">
						<input type="text" class="form-control" id="pro_bo_title" name="pro_bo_title">
						<input type="hidden" class="form-control" id="pro_bo_writer" name="pro_bo_writer" value="${LOGIN_EMPINFO.getEmp_num() }">
						<input type="hidden" class="form-control" id="pro_bo_proid" name="pro_bo_proid" value="${pro_id }">
					</div>
				</div>

				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">내용</label>

					<div class="col-sm-10">
						<div id="pro_bo_cont">내용을 입력해주세요...</div>
					</div>
				</div>

			</div>
			<!-- /.box-body -->
			<div class="box-footer">
				<button type="button" class="btn btn-default pull-right" id="cencle">취소</button>
				<button type="submit" class="btn btn-info pull-right" style="margin: 0px 10px">등록</button>
			</div>
			<!-- /.box-footer -->
		</form>
	</div>
	<!-- /.box -->
</body>
</html>