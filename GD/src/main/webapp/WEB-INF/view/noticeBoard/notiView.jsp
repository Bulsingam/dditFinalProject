<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

</head>
<style>

	
	div #container{
		width : 80%;
		margin : auto;
		
	}
	div div {
		margin : auto;
	}
	
	div #noti_cont{
		width : 100%;
		height : 300px;
		margin : auto;
	}
</style>

<script type="text/javascript">

	$(function(){
		
		$('button[id=update]').click(function(){
				
			if(${notiboardInfo[0].NOTI_WRITER} == ${LOGIN_EMPINFO.getEmp_num()}){
				var noti_postnum = ${notiboardInfo[0].NOTI_POSTNUM};
	    		$(location).attr('href', '${pageContext.request.contextPath}/noticeBoard/updateNotiView.do?noti_postnum=' + noti_postnum);
	    	}else{
	    		alert("자신이 작성한 게시글만 수정가능 합니다.");	
				
			}
		});

		
		$('#download').click(function(){
			var $frm = $('<form action="${pageContext.request.contextPath}/noticeBoard/notiDownload.do" method="post"> </form>');
			$frm.append('<input type="hidden" name="file_seq" value="${notiboardInfo[0].FILE_SEQ}" >');
			$frm.appendTo('body');
			$frm.submit();
		});	
		
		$('button[id=delete]').click(function(){
			
			if(${notiboardInfo[0].NOTI_WRITER} == ${LOGIN_EMPINFO.getEmp_num()}){
				var noti_postnum = ${notiboardInfo[0].NOTI_POSTNUM};
			$(location).attr('href','${pageContext.request.contextPath}/noticeBoard/deleteNotiboardInfo.do?noti_postnum=' + noti_postnum);
				}else{
	    			alert("자신이 작성한 게시글만 삭제가능 합니다.");	
				
			}
		});
		
		$('form').submit(function(){
			$(this).append('<input type="hidden" name="noti_cont" value="'+$('#noti_cont').summernote('code')+'"/>');
			
	    	
		});
		
		$('#cencle').click(function(){
			$(location).attr('href','${pageContext.request.contextPath}/noticeBoard/notiList.do?search_keyword=${param.search_keyword}&search_keycode=${param.search_keycode}'
			+'&currentPage=${param.currentPage}&blockCount=${param.blockCount}');
		});
	});
	
</script>
<body>
 

<div class="box box-info">
			<div class="box-header with-border">
				<h3 class="box-title">공지사항</h3>
			</div>
			<!-- /.box-header -->
			<!-- form start -->
			<form class="form-horizontal">
				<div class="box-body">
				
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label">제목</label>
						<div class="col-sm-10">
							<input type="hidden" value="${notiboardInfo[0].NOTI_POSTNUM}" >
							<input type="text" class="form-control" value="${notiboardInfo[0].NOTI_TITLE}" readonly />
						</div>
					</div>
					
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label"> 작성자</label>
						<div class="col-sm-10">
							<input type="hidden" class="form-control" id="inputEmail3" value="${notiboardInfo[0].NOTI_WRITER}" readonly />
						    <input type="text" class="form-control" id="inputEmail3" value="${notiboardInfo[0].EMP_NAME}" readonly />
						</div>
					</div>
					
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label">등록일</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="inputEmail3" value="${notiboardInfo[0].NOTI_REGDATE }" readonly />
						</div>
					</div>
					
					<div class="form-group">
						<label for="inputEmail3" class= "col-sm-2 control-label">내용</label>
						<div class="col-sm-10">
							<textarea rows="10" cols="50" style="width:100%; resize:none;"  readonly>${notiboardInfo[0].NOTI_CONT}</textarea>
						</div>
					</div>
					
					<c:set var="name" value="${notiboardInfo[0].FILE_NAME }"></c:set>
					<c:if test="${name ne null}">
					<div class="form-group">
						<label class="control-label col-sm-2" for="file">첨부파일</label>
						<div class="col-sm-2">
							<button type="button" class="btn fa fa-save btn-block btn-info" id="download">  ${notiboardInfo[0].FILE_NAME }</button>
						</div>
					</div>
					</c:if>
					
				</div>
				<!-- /.box-body -->
				<div class="box-footer">
					<button type="button" class="btn btn-default pull-right" id="cencle">취소</button>
					<button type="button" class="btn btn-danger pull-right" style="margin : 0px 10px;" id="delete">삭제</button>
					<button type="button" class="btn btn-info pull-right" id="update">수정</button>
			
				</div>
				<!-- /.box-footer -->
			</form>
		</div>
		
</body>
</html>