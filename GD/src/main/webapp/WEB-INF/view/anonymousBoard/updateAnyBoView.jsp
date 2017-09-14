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
    $('#any_cont').summernote({
			height: 150,
			codemirror: {
			theme: 'monokai'
		}
	});
    
    $('#any_cont').summernote('code', '${anyBoInfo[0].ANY_CONT}');
    
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
		<form class="form-horizontal" action="${pageContext.request.contextPath }/anonymousBoard/updateAnyBo.do" method="post" enctype="multipart/form-data">
			<div class="box-body">

				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">제목</label>
					<div class="col-sm-10">
						<input type="hidden" name="any_postnum" value="${anyBoInfo[0].ANY_POSTNUM}">
						<input type="hidden" name="any_writer" value="${anyBoInfo[0].ANY_WRITER}">
						<input type="text" class="form-control" name="any_title" value="${anyBoInfo[0].ANY_TITLE}" />
					</div>
				</div>

				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">내용</label>
					<div class="col-sm-10">
						<div id="any_cont"></div>
					</div>
				</div>

				<div class="form-group">
					<label class="control-label col-sm-2" for="file">파일수정</label>
					<div class="col-sm-10">
						<input type="file" class="filestyle" id="files" name="files" data-buttonName="btn-primary">
					</div>
				</div>

				<div class="form-group">
					<label class="control-label col-sm-2" for="file">첨부파일</label>
					<div class="col-sm-2">
						<button type="button" class="btn fa fa-save btn-block btn-info" disabled>${anyBoInfo[0].FILE_NAME }</button>
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