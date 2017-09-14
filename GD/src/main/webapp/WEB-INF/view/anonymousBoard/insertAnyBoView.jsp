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
	$('#any_cont').summernote({
		lang : 'ko-KR',
		height : 150,
		codemirror : {
			theme : 'monokai'
		}
	});
	
	$('form').submit(function(){	
		$(this).append('<input type="hidden" name="any_cont" value="' + $('#any_cont').summernote('code') + '"/>');
	});
	
	$('#cencle').click(function(){
		$(location).attr('href', '${pageContext.request.contextPath}/anonymousBoard/getAnyBoList.do');
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
		<form class="form-horizontal" action="${pageContext.request.contextPath }/anonymousBoard/insertAnyBo.do" method="post" enctype="multipart/form-data">
			<div class="box-body">
				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">제목</label>

					<div class="col-sm-10">
						<input type="text" class="form-control" name="any_title">
						<input type="hidden" class="form-control" name="any_writer" value="${LOGIN_EMPINFO.getEmp_num() }">
					</div>
				</div>

				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">내용</label>

					<div class="col-sm-10">
						<div id="any_cont">내용을 입력해주세요...</div>
					</div>
				</div>

				<div class="form-group">
					<label class="control-label col-sm-2" for="file">첨부파일</label>
					<div class="col-sm-10">
						<input type="file" class="filestyle" id="files" name="files" data-buttonName="btn-primary">
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