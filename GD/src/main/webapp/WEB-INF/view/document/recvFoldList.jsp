<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
$(function(){
	$('#documentList tr').bind('click', function(){
		var index = $(this).index();
		var value = $('#documentList tr:eq('+index+') td:eq(0)').text();
		var $frm = $('<form action="${pageContext.request.contextPath}/document/documentView.do" method="post"></form>');
		$frm.append('<input type="hidden" name="goToList" value="${goToList}">');
		$frm.append('<input type="hidden" name="doc_num" value="'+value+'">');
		$frm.appendTo('body');
		$frm.submit();
	})
	$('tbody tr').hover(function(){
		$(this).css('background-color','rgb(194, 216, 252)')
	}, function(){
		$(this).css('background-color','white')
	})
})
</script>
</head>
<body>
<div>
	<div class="box">
		<div class="box-header with-border">
			<h3 class="box-title">수신 문서함</h3>
		</div>
		<div class="box-body">
			<table class="table table-bordered">
				<thead>
					<tr>
						<th width="10%">문서 번호</th>
						<th width="30%">제목</th>
						<th width="15%">기안자</th>
						<th width="15%">프로젝트</th>
						<th width="15%">수신처</th>
						<th width="10%">기안일</th>
					</tr>
				</thead>
				<tbody id="documentList">
					<c:forEach items="${folder }" var="document">
						<tr>
							<td>${document.DOC_NUM }</td>
							<td>${document.DOC_TITLE }</td>
							<td>${document.EMP_NAME } (${document.DOC_WRITER })</td>
							<td>${document.PRO_NAME }</td>
							<td>${document.DOC_RECV }</td>
							<td>${document.DOC_REGDATE }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
<!-- 페이징 -->		
		<div class="box-footer clearfix">
			<div class="pull-left">${pagingHtml }</div>
			<div class="pull-right">
				<form action="${pageContext.request.contextPath }/document/receiveFolder.do" method="post" class="form-inline pull-right">
					<input name="search_keyword" id="search_keyword" type="text" placeholder="검색어 입력..." class="form-control" />
					<select class="form-control" name="search_keycode" >
						<option>검색조건</option>
						<option value="TOTAL">전체</option>
						<option value="TITLE">제목</option>
						<option value="RECV">수신처</option>
						<option value="SEND">발신처</option>
						<option value="THRU">경유처</option>
						<option value="PRONAME">프로젝트명</option>
					</select>
					<button type="submit" class="btn btn-primary form-control">검색</button>
				</form>
			</div>
		</div>
	</div>
</div>
</body>
</html>