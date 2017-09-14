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
    	if( ${anyBoInfo[0].ANY_WRITER} == ${LOGIN_EMPINFO.getEmp_num()}){
    		var any_postnum = ${anyBoInfo[0].ANY_POSTNUM};
    		$(location).attr('href', '${pageContext.request.contextPath}/anonymousBoard/updateAnyBoView.do?any_postnum=' + any_postnum);
    	}else{
    		alert("자신이 작성한 게시글만 수정가능 합니다.");
    	}
    });
    
    $('button[id=reply]').click(function(){
    	var any_title = encodeURI('${anyBoInfo[0].ANY_TITLE }');
     	$(location).attr('href', '${pageContext.request.contextPath}/anonymousBoard/insertReplyAnyBoView.do?rnum=${param.rnum}&any_title='+ any_title +'&any_postgroup=${anyBoInfo[0].ANY_POSTGROUP}&any_postdep=${anyBoInfo[0].ANY_POSTDEP}&any_postseq=${anyBoInfo[0].ANY_POSTSEQ}');
    });
     
    
	$('#download').click(function(){
		var $frm = $('<form action="${pageContext.request.contextPath}/anonymousBoard/anyDownload.do" method="post"> </form>');
		$frm.append('<input type="hidden" name="file_seq" value="${fileInfo.file_seq}" >');
		$frm.appendTo('body');
		$frm.submit();
	});	
    
	$('#delete').click(function(){
		if( ${anyBoInfo[0].ANY_WRITER} == ${LOGIN_EMPINFO.getEmp_num()} || ${LOGIN_EMPINFO.getEmp_num()} == '201703000' ){
    		var any_postnum = ${anyBoInfo[0].ANY_POSTNUM};
    		$(location).attr('href', '${pageContext.request.contextPath}/anonymousBoard/deleteAnyBo.do?any_postnum=' + any_postnum);
		}else{
			alert("자신이 작성한 게시글만 삭제 가능합니다.");
		}
	});
	
	$('#cencle').click(function(){
		$(location).attr('href', '${pageContext.request.contextPath}/anonymousBoard/getAnyBoList.do?search_keycode=${param.search_keycode}&search_keyword=${param.search_keyword}'+
		'&currentPage=${param.currentPage}&blockCount=${param.blockCount}');
	});
    
})
</script>
<body>
	<!-- Horizontal Form -->
	<div class="box box-info">
		<div class="box-header with-border">
			<h3 class="box-title">익명게시판</h3>
		</div>
		<!-- /.box-header -->
		<!-- form start -->
		<form class="form-horizontal">
			<div class="box-body">

				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">제목</label>
					<div class="col-sm-10">
						<input type="hidden" value="${anyBoInfo[0].ANY_POSTNUM}">
						<input type="text" class="form-control" value="${anyBoInfo[0].ANY_TITLE}" readonly />
					</div>
				</div>
				<input type="hidden" class="form-control" id="inputEmail3" value="${anyBoInfo[0].ANY_WRITER}" readonly />

				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">등록일</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="inputEmail3" value="${anyBoInfo[0].ANY_REGDATE }" readonly />
					</div>
				</div>

				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label">내용</label>
					<div class="col-sm-10">
						<textarea rows="10" cols="50" style="width: 100%; resize: none;" readonly>${anyBoInfo[0].ANY_CONT}</textarea>
					</div>
				</div>

				<c:set var="name" value="${fileInfo.file_name }"></c:set>
				<c:if test="${name ne null}">
					<div class="form-group">
						<label class="control-label col-sm-2" for="file">첨부파일</label>
						<div class="col-sm-2">
							<button type="button" class="btn fa fa-save btn-block btn-info" id="download" style="margin-top: 3px;"> ${fileInfo.file_name }</button>
						</div>
					</div>
				</c:if>
				<c:if test="${name eq null}">
					<div class="form-group">
						<label class="control-label col-sm-2" for="file">첨부파일</label>
						<div class="col-sm-2">
							<p style="margin-top: 7px;">첨부파일이 없습니다.</p>
						</div>
					</div>
				</c:if>

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