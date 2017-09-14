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
	
	div #com_cont{
		width : 100%;
		height : 300px;
		margin : auto;
	}
</style>

<script type="text/javascript">

	$(function(){
		
		$('button[id=update]').click(function(){
				
			if(${comboardInfo[0].COM_WRITER} == ${LOGIN_EMPINFO.getEmp_num()}){
				var com_postnum = ${comboardInfo[0].COM_POSTNUM};
	    		$(location).attr('href', '${pageContext.request.contextPath}/companyBoard/updateComView.do?com_postnum=' + com_postnum);
	    	}else{
	    		alert("자신이 작성한 게시글만 수정가능 합니다.");	
				
			}
		});

		 $('button[id=reply]').click(function(){
		    	var com_title = encodeURI('${comboardInfo[0].COM_TITLE }');
		     	$(location).attr('href', '${pageContext.request.contextPath}/companyBoard/insertReplyComView.do?rnum=${param.rnum}&com_title='+ com_title +'&com_postgroup=${comboardInfo[0].COM_POSTGROUP}&com_postdep=${comboardInfo[0].COM_POSTDEP}&com_postseq=${comboardInfo[0].COM_POSTSEQ}');
		    });
		
		
		$('button[id=delete]').click(function(){
			if(${comboardInfo[0].COM_WRITER} == ${LOGIN_EMPINFO.getEmp_num()}){
				var com_postnum = ${comboardInfo[0].COM_POSTNUM};
				$(location).attr('href','${pageContext.request.contextPath}/companyBoard/deleteComboardInfo.do?com_postnum=' + com_postnum);
			}else{
				alert("자신이 작성한 게시글만 삭제 가능합니다.");
			}
		});
		
		  
		$('#download').click(function(){
			var $frm = $('<form action="${pageContext.request.contextPath}/companyBoard/comDownload.do" method="post"> </form>');
			$frm.append('<input type="hidden" name="file_seq" value="${comboardInfo[0].FILE_SEQ}" >');
			$frm.appendTo('body');
			$frm.submit();
		});	
		
		$('#cencle').click(function(){
			$(location).attr('href','${pageContext.request.contextPath}/companyBoard/comList.do?search_keyword=${param.search_keyword}&search_keycode=${param.search_keycode}'
					+'&currentPage=${param.currentPage}&blockCount=${param.blockCount}');
		});
		
	})
	
</script>
<body>
 

<div class="box box-info">
			<div class="box-header with-border">
				<h3 class="box-title">사내게시판</h3>
			</div>
			<!-- /.box-header -->
			<!-- form start -->
			<form class="form-horizontal">
				<div class="box-body">
				
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label">제목</label>
						<div class="col-sm-10">
							<input type="hidden" value="${comboardInfo[0].COM_POSTNUM}" >
							<input type="text" class="form-control" value="${comboardInfo[0].COM_TITLE}" readonly />
						</div>
					</div>
					
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label"> 작성자</label>
						<div class="col-sm-10">
							<input type="hidden" class="form-control" id="inputEmail3" value="${comboardInfo[0].COM_WRITER}" readonly />
						    <input type="text" class="form-control" id="inputEmail3" value="${comboardInfo[0].EMP_NAME}" readonly />
						</div>
					</div>
					
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label">등록일</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="inputEmail3" value="${comboardInfo[0].COM_REGDATE }" readonly />
						</div>
					</div>
					
					<div class="form-group">
						<label for="inputEmail3" class= "col-sm-2 control-label">내용</label>
						<div class="col-sm-10">
							<textarea rows="10" cols="50" style="width:100%; resize:none;"  readonly>${comboardInfo[0].COM_CONT}</textarea>
						</div>
					</div>
					
					<c:set var="name" value="${comboardInfo[0].FILE_NAME }"></c:set>
					<c:if test="${name ne null}">
					<div class="form-group">
						<label class="control-label col-sm-2" for="file">첨부파일</label>
						<div class="col-sm-2">
							<button type="button" class="btn fa fa-save btn-block btn-info" id="download">  ${comboardInfo[0].FILE_NAME }</button>
						</div>
					</div>
					</c:if>
					
				</div>
				<!-- /.box-body -->
				<div class="box-footer">
					<button type="button" class="btn btn-default pull-right" id="cencle">취소</button>
					<button type="button" class="btn btn-danger pull-right" style="margin : 0px 10px;" id="delete">삭제</button>
					<button type="button" class="btn btn-info pull-right" id="update">수정</button>
					<button type="button" class="btn btn-info pull-right" style="margin : 0px 10px;" id="reply">댓글</button>
				</div>
				<!-- /.box-footer -->
			</form>
		</div>
		
</body>
</html>