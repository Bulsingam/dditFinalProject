<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">
$(function(){
       
    $('button[id=update]').click(function(){
    	if( ${proBoInfo[0].PRO_BO_WRITER} == ${LOGIN_EMPINFO.getEmp_num()}){
    		var pro_bo_num = ${proBoInfo[0].PRO_BO_NUM};
    		$(location).attr('href', '${pageContext.request.contextPath}/projectBoard/updateProBoView.do?pro_bo_num=' + pro_bo_num);
    	}else{
    		alert("자신이 작성한 게시글만 수정가능 합니다.");
    	}
    });
    
    $('button[id=reply]').click(function(){
    	var pro_bo_title = encodeURI('${proBoInfo[0].PRO_BO_TITLE }');
     	$(location).attr('href', '${pageContext.request.contextPath}/projectBoard/insertReplyProBoView.do?rnum=${param.rnum}&pro_bo_title='+ pro_bo_title +'&pro_bo_group=${proBoInfo[0].PRO_BO_GROUP}&pro_bo_dep=${proBoInfo[0].PRO_BO_DEP}&pro_bo_seq=${proBoInfo[0].PRO_BO_SEQ}&pro_id=${proBoInfo[0].PRO_BO_PROID}');
    });
     
    
	$('#delete').click(function(){
		if( ${proBoInfo[0].PRO_BO_WRITER} == ${LOGIN_EMPINFO.getEmp_num()} ){
    		$(location).attr('href', '${pageContext.request.contextPath}/projectBoard/deleteProBo.do?pro_bo_num=${proBoInfo[0].PRO_BO_NUM}&pro_id=${proBoInfo[0].PRO_BO_PROID}');
		}else{
			alert("자신이 작성한 게시글만 삭제 가능합니다.");
		}
	});
	
	$('#cencle').click(function(){
		$(location).attr('href', '${pageContext.request.contextPath}/projectBoard/proBoList.do?pro_id=${proBoInfo[0].PRO_BO_PROID}&search_keycode=${param.search_keycode}&search_keyword=${param.search_keyword}'+
		'&currentPage=${param.currentPage}&blockCount=${param.blockCount}');
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
		<form class="form-horizontal">
			<div class="box-body">

				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">제목</label>
					<div class="col-sm-10">
						<input type="hidden" value="${proBoInfo[0].PRO_BO_NUM}">
						<input type="text" class="form-control" value="${proBoInfo[0].PRO_BO_TITLE}" readonly />
					</div>
				</div>

				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">
						작성자</label>
					<div class="col-sm-10">
						<input type="hidden" class="form-control" id="inputEmail3" value="${proBoInfo[0].PRO_BO_WRITER}" readonly />
						<input type="text" class="form-control" id="inputEmail3" value="${proBoInfo[0].EMP_NAME}" readonly />
					</div>
				</div>

				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">등록일</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="inputEmail3" value="${proBoInfo[0].PRO_BO_REGDATE }" readonly />
					</div>
				</div>

				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">내용</label>
					<div class="col-sm-10">
						<textarea rows="10" cols="50" style="width: 100%; resize: none;" readonly>${proBoInfo[0].PRO_BO_CONT}</textarea>
					</div>
				</div>

			</div>
			<!-- /.box-body -->
			<div class="box-footer">
				<button type="button" class="btn btn-default pull-right" id="cencle">취소</button>
				<button type="button" class="btn btn-danger pull-right" style="margin: 0px 10px;" id="delete">삭제</button>
				<button type="button" class="btn btn-info pull-right" id="update">수정</button>
				<button type="button" class="btn btn-info pull-right" style="margin: 0px 10px;" id="reply">댓글</button>
			</div>
			<!-- /.box-footer -->
		</form>
	</div>
	<!-- /.box -->
</body>
</html>