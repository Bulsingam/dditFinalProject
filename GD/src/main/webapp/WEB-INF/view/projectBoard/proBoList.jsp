
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">
$(function(){
	$('#insert').click(function(){
		$(location).attr('href', '${pageContext.request.contextPath}/projectBoard/insertProBoView.do?pro_id=${pro_id}');
	});
	
	$('tbody tr').click(function(){
		var idx = $(this).index();
		var pro_bo_num = $('tbody tr:eq('+ idx +') td:eq(0)').find('input').val();
		var rnum = $('tbody tr:eq('+idx+') td:eq(0)').text();
		$(location).attr('href', '${pageContext.request.contextPath}/projectBoard/proBoView.do?pro_bo_num=' + pro_bo_num + '&rnum=' + rnum + '&search_keycode=${search_keycode}&search_keyword=${search_keyword}' + 
		'&currentPage=${param.currentPage}&blockCount=${param.blockCount}');
	});
})
</script>
<style>
	div #container{
		width : 80%;
		margin : auto;
	}
	th{
		text-align : center;
	}
</style>
<body>
<div class="row" id="container"> 
	<div class="col-xs-12">
		<div class="box">
			<div class="box-header with-border">
				<h3 class="box-title">프로젝트 게시판</h3>
			</div>
			<!-- /.box-header -->
				<div class="box-body">
				<table class="table table-bordered">
					<thead>
						<tr>
							<th style="width: 50px">번호</th>
							<th>제목</th>
							<th style="width: 100px">작성자</th>
							<th style="width: 200px">등록일</th>
							<th style="width: 50px">조회</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${proBoList }" var="pBList">
							<tr>
								<td style="text-align: center;"><input type="hidden" name="pro_bo_num" value="${pBList.PRO_BO_NUM }">${pBList.RNUM }</td>
								<td>
									<c:forEach begin="1" end="${pBList.PRO_BO_DEP }" varStatus="stat">
              						&nbsp;&nbsp;
              							<c:if test="${stat.last }">
											<img src="${pageContext.request.contextPath }/image/ico_reply.gif" alt="reply">
										</c:if>
									</c:forEach> ${pBList.PRO_BO_TITLE }
								</td>
								<td style="text-align: center;">${pBList.EMP_NAME }</td>
								<td style="text-align: center;"><fmt:formatDate value="${pBList.PRO_BO_REGDATE }" pattern="yyyy-MM-dd"></fmt:formatDate></td>
								<td style="text-align: center;">${pBList.PRO_BO_VIEWHIT }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				${pagingHtml }
			</div>
			<!-- /.box-body -->
		</div>
	</div>
		<form action="" method="post" class="form-inline pull-right">
			<input id="search_keyword" name="search_keyword" type="text" placeholder="검색어 입력..." class="form-control" style="margin: 1px 1px 0px 0px" />
				<select class="form-control" name="search_keycode">
					<option>검색조건</option>
					<option value="TOTAL">전체</option>
					<option value="TITLE">제목</option>
					<option value="CONTENT">내용</option>
					<option value="WRITER">작성자</option>
				</select>
			<button type="submit" class="btn btn-primary form-control">검색</button>
			<button type="button" class="btn btn-info form-control" id="insert" style="margin-right: 14px;">게시글 등록</button>
		</form>
</div>
</body>
</html>