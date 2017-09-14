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
		$(this).append('<input type="hidden" name="any_cont" value="' + $('#any_cont').summernote('code') + '"/> ');
		$(this).append('<input type="hidden" name="any_postgroup" value="${param.any_postgroup}"/>');
		$(this).append('<input type="hidden" name="any_postdep" value="${param.any_postdep}"/>');
		$(this).append('<input type="hidden" name="any_postseq" value="${param.any_postseq}"/>');
		
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
		<div class="row">
			<div class="col-sm-4">
				<label class="col-sm-3 control-label">No :</label>
				<p class="form-control-static" style="padding: 1px 0px 0px 0px;">${param.rnum }</p>
			</div>
			<div class="col-sm-7">
				<label class="col-sm-2 control-label">제목 :</label>
				<p class="form-control-static" style="padding: 1px 0px 0px 0px;">${param.any_title }</p>
			</div>
		</div>
		<!-- /.box-header -->
		<!-- form start -->
		<form class="form-horizontal" action="${pageContext.request.contextPath }/anonymousBoard/insertReplyAnyBo.do" method="post" enctype="multipart/form-data">
			<div class="box-body">
				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">제목</label>

					<div class="col-sm-10">
						<input type="text" class="form-control" name="any_title">
						<input type="hidden" class="form-control" name="any_writer" value="${LOGIN_EMPINFO.getEmp_num()}">
					</div>
				</div>

				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">내용</label>

					<div class="col-sm-10">
						<div id="any_cont">내용을 입력해주세요...</div>
					</div>
				</div>

			</div>
			<!-- /.box-body -->
			<div class="box-footer">
				<button type="button" class="btn btn-default pull-right" id="cencle">취소</button>
				<button type="submit" class="btn btn-info pull-right" style="margin: 0px 10px 0px 0px;">댓글등록</button>
			</div>
			<!-- /.box-footer -->
		</form>
	</div>
	<!-- /.box -->
</body>
</html>