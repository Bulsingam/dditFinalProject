<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
$(function(){
	
	$('button[id=delete]').click(function(){
		
		if( ${proArcList[0].PRO_ARC_WRITER} == ${LOGIN_EMPINFO.getEmp_num()} || ${LOGIN_EMPINFO.getEmp_num()} == '201703000' ){
			var idx = $(this).index('button[id=delete]');
			var pro_arc_num = $('tbody tr:eq(' + idx + ') td:eq(0)').find('input').val();
			$(location).attr('href', '${pageContext.request.contextPath}/projectArchive/deleteProjectArchive.do?pro_id=${pro_id}&pro_arc_num=' + pro_arc_num);
		}else{
			alert("자신이 등록한 게시글만 삭제 가능합니다.");
		}
	});
	
	$('button[id=modaludt]').click(function(){
		if( ${proArcList[0].PRO_ARC_WRITER} != ${LOGIN_EMPINFO.getEmp_num()} ){
			alert("자신이 등록한 게시글만 수정 가능합니다.");
		}else{
		$('#updateModal').modal();
			var idx = $(this).index('button[id=modaludt]');
			var pro_arc_num = $('tbody tr:eq(' + idx + ') td:eq(0)').find('input').val();
			$.ajax({
			  	type : 'POST'
				, url : "${pageContext.request.contextPath}/projectArchive/getProArc.do"
				, data : 'pro_arc_num='+pro_arc_num
				, dataType : 'json'
				, error : function(request){
					alert("code : " + request.status + "\r\nmessage : " + request.reponseText);
			 	 }
				, success : function(result){
					$('input[id=num]').val(result.proArcInfo.pro_arc_num);
					$('input[id=title]').val(result.proArcInfo.pro_arc_title);
					$('input[id=filename]').val(result.proArcInfo.pro_arc_filename);
			  	}
			});	
		}
	});
	
	$('a[id=download]').click(function(){
		var idx = $(this).index('a[id=download]');
		var pro_arc_num = $('tbody tr:eq(' + idx + ') td:eq(0)').find('input').val();
		$(location).attr('href', '${pageContext.request.contextPath}/projectArchive/downloadProArc.do?pro_arc_num=' + pro_arc_num);
	});


	
})
</script>
<style>
	div #container{
		width:80%;
		margin :auto;
	}
</style>
</head>
<body>
<div class="row" id="container">
	<div class="col-xs-12">
	<div class="box">
		<div class="box-header with-border">
			<h3 class="box-title">프로젝트 자료실</h3>
		</div>
		<!-- /.box-header -->
		<div class="box-body">
			<table class="table table-bordered table-hover">
				<thead>
					<tr>
						<th style="width: 50px">번호</th>
						<th>제목</th>
						<th>작성일</th>
						<th>작성자</th>
						<th>다운로드</th>
						<th>다운로드수</th>
						<th style="width: 100px"></th>
						<th style="width: 100px"></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${proArcList }" var="pArcList" varStatus="stat">
						<tr>
							<td><input type="hidden" name="pro_arc_num" value="${pArcList.PRO_ARC_NUM }">${pArcList.RNUM }</td>
							<td>${pArcList.PRO_ARC_TITLE }</td>
							<td><fmt:formatDate value="${pArcList.PRO_ARC_REGDATE }" pattern="yyyy-MM-dd"></fmt:formatDate></td>
							<td>${pArcList.EMP_NAME }</td>
							<td><a id="download">${pArcList.PRO_ARC_FILENAME }</a></td>
							<td>${pArcList.PRO_ARC_DOWNHIT }</td>
							<td>
								<button id="modaludt" type="button" class="btn btn-info btn-md" value="${stat.index }">수정</button>
							</td>
							<td>
								<button type="button" class="btn btn-info btn-md" id="delete" value="${stat.index }">삭제</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			${pagingHtml }
		</div>
		</div>
	</div>
		<form action="" method="post" class="form-inline pull-right">
			<input id="search_keyword" name="search_keyword" type="text" placeholder="검색어 입력..." class="form-control" />
				<select class="form-control" name="search_keycode">
					<option>검색조건</option>
					<option value="TOTAL">전체</option>
					<option value="TITLE">제목</option>
					<option value="WRITER">작성자</option>
				</select>

			<button type="submit" id="search" class="btn btn-primary form-control">검색</button>
			<button type="button" class="btn btn-info" data-toggle="modal" data-target="#modal-default" style="margin-right: 14px;">게시글등록</button>
		</form>
</div>
	<!-- 검색 -->

	<!-- 수정 모달 창 -->

	<div id="updateModal" class="modal fade" id="myModal">
		<form action="${pageContext.request.contextPath }/projectArchive/updateProArc.do" method="post" enctype="multipart/form-data">
			<div class="modal-dialog">
				<!-- 			Modal content -->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">수정</h4>
					</div>
					<div class="modal-body">
						<input class="form-control input-md" id="num" type="hidden" name="pro_arc_num">
						<input type="hidden" name="pro_id" value="${pro_id }"> 
						<label>제목</label>
						<input class="form-control input-md" id="title" name="pro_arc_title" type="text"> <br>

						<div class="form-group">
							<label class="control-label col-sm-2">첨부 파일</label> <input
								type="text" id="filename" readonly>
						</div>

						<div class="form-group">
							<label class="control-label col-sm-2" for="file">파일수정</label>
							<div class="col-sm-10">
								<input type="file" class="filestyle" id="files" name="files" data-buttonName="btn-primary">
							</div>
						</div>

						<div class="modal-footer">
							<button type="button" class="btn btn-default pull-right" data-dismiss="modal">닫기</button>
							<button type="submit" class="btn btn-info pull-right" style="margin-right: 5px;">수정</button>
						</div>

					</div>
				</div>
			</div>
		</form>
	</div>


	<!-- 등록 모달창 -->
	<form action="${pageContext.request.contextPath }/projectArchive/insertProjectArchive.do" method="post" enctype="multipart/form-data">
		<div class="modal fade" id="modal-default">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title">자료 등록</h4>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label for="exampleInputFile">제목</label>
							<input class="form-control input-md" id="iv" type="text" name="pro_arc_title">
							<input type="hidden" name="pro_arc_writer" value="${LOGIN_EMPINFO.getEmp_num() }">
							<input type="hidden" name="pro_arc_proid" value="${pro_id }">
						</div>
						<div class="form-group">
							<label for="exampleInputFile">파일 첨부</label> <input type="file" id="files" name="files">
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default pull-right" data-dismiss="modal">닫기</button>
						<button type="submit" id="insert" class="btn btn-primary">저장</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>
		<!-- /.modal -->
	</form>
</body>
</html>