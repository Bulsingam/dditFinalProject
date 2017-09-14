<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/printThis.js"></script>
<script type="text/javascript">
$(function(){
	var doc_num = '${document[0].DOC_NUM}';
	var $frm = $('<form action="" method="post"></form>');
	$frm.append('<input type="hidden" name="doc_num" value="'+doc_num+'">');
	
	$('span[name="title"]').text('${document[0].DOC_TITLE}');
	$('span[name="writer"]').text('${document[0].EMP_NAME} (${document[0].APR_EMPPOS}, ${document[0].DET_APREMP })');
	$('#projectName').text('${document[0].PRO_NAME}');
	$('#buttonGroup').find('button').css({'margin-left':'5px'});
	
	$('#deleteBtn').bind('click', function(){
		if('${document[1].DET_APRSTA}' != ''){
			alertModal('해당 문서를 결재한 사원이 존재해 삭제할 수 없습니다.');
			return false;
		}
		$frm.attr('action','${pageContext.request.contextPath}/document/deleteDocument.do');
		$frm.appendTo('body');
		$frm.submit();
	})
	
	$('#updateBtn').bind('click', function(){
		if('${document[1].DET_APRSTA}' != ''){
			alertModal('해당 문서를 결재한 사원이 존재해 수정할 수 없습니다.');
			return false;
		}
		$frm.attr('action','${pageContext.request.contextPath}/approval/updateForm.do');
		$frm.appendTo('body');
		$frm.submit();	
	})
	
	$('#printBtn').bind('click',function(){
		$('#printArea').printThis();
	})
	
	$('#listBtn').bind('click',function(){
		$(location).attr('href','${pageContext.request.contextPath}${goToList}');
	})
	
	$('#save').bind('click', function(){
		var apr_cont = $('#apr_cont').val();
		var apr_sta = $('#approvalSta').val();
		if(apr_cont == ''){
			alert('결재 사유를 입력해주세요');
			return false;
		}
		$frm.append('<input type="hidden" name="det_linenum" value="${document[0].DET_LINENUM}">');
		$frm.append('<input type="hidden" name="det_apremp" value="${LOGIN_EMPINFO.emp_num}">');
		$frm.append('<input type="hidden" name="det_aprsta" value="'+apr_sta+'">');
		$frm.append('<input type="hidden" name="det_aprcont" value="'+apr_cont+'">');
		$frm.append('<input type="hidden" name="form_prox" value="${document[0].FORM_PROX}">');
		$frm.attr('action','${pageContext.request.contextPath}/approval/signApproval.do');
		$frm.appendTo('body');
		$frm.submit();
		
	})
})
function alertModal(context){
	$('.modal-body').text(context);
	var $btn = $('<button type="button" class="btn btn-success pull-right" data-toggle="modal" data-target="#modal-alert">');
	$btn.appendTo('body');
	$btn.click();
}
</script>
</head>
<body>
<div class="row">
	<div class="col-md-6">
		<div class="box box-info">
			<div class="box-header with-border">
				<i class="fa fa-file-text-o"></i>
				<h3 class="box-title">결재문서 정보</h3>
			</div>
			<!-- /.box-header -->
			<div class="box-body">
				<form class="form-horizontal">
					<div class="box-body">
						<div class="form-group">
							<label for="title" class="col-sm-3">문서제목</label>
							<span name="title"></span>
						</div>
						<div class="form-group">
							<label for="writer" class="col-sm-3">기안자</label>
							<span name="writer"></span>
						</div>
						<div class="form-group">
							<label for="projectName" class="col-sm-3">프로젝트명</label>
							<span id="projectName"></span>
						</div>
						<hr>
						<div class="form-group">
							<label for="aprLine" class="col-sm-3">결재선</label>
						</div>
						<div class="form-group" id="aprLine">
							<c:forEach items="${document }" var="item">
								<div class="col-sm-3" align="center" style="height: 200px">
									<img id="${item.DET_APREMP }" 
										src="${pageContext.request.contextPath }/2jo/Employee/img/${item.APR_EMPIMG }"
										style="height: 60px; width: 60px;" class="img-circle" name="lineImg"><br><br>
									<c:choose>
										<c:when test="${item.DET_APRSTA eq 'Y' }">
											<label for="${item.DET_APREMP }" style="color: blue">
												${item.APR_EMPPOS } ${item.APR_EMPNAME } (${item.DET_APREMP }) 
												<br> ${item.DET_APRDATE}
												<br> ${item.DET_APRCONT}
											</label>
										</c:when>
										<c:when test="${item.DET_APRSTA eq 'N' }">
											<label for="${item.DET_APREMP }" style="color: red">
												${item.APR_EMPPOS } ${item.APR_EMPNAME } (${item.DET_APREMP })
												<br> ${item.DET_APRDATE}
												<br> ${item.DET_APRCONT}
											</label>
										</c:when>
										<c:otherwise>
											<label for="${item.DET_APREMP }">
												${item.APR_EMPPOS } ${item.APR_EMPNAME } (${item.DET_APREMP })
											</label>
										</c:otherwise>
									</c:choose>
								</div>
							</c:forEach> 
						</div>
					</div>
					<div class="box-footer" id="buttonGroup">
						<c:if test="${document[0].DET_APREMP eq LOGIN_EMPINFO.emp_num and document[1].DET_APRSTA eq null}">
							<button type="button" id="deleteBtn" class="btn btn-danger pull-right">
								<i class="fa fa-fw fa-remove"></i>삭제
							</button>
							<button type="button" id="updateBtn" class="btn btn-default pull-right">
								<i class="fa fa-fw fa-i-cursor"></i> 수정
							</button>
						</c:if>
						<button type="button" id="listBtn" class="btn btn-default pull-right">
							<i class="fa fa-fw fa-mail-reply"></i> 목록
						</button>
						<!-- 결재를 하지 않은 사원 중 로그인한 사원과 사원번호가 같은 사람만 결재 버튼이 출력됨 -->
						<c:forEach items="${document }" var="item">
							<c:choose>
								<c:when test="${item.DET_APRSTA eq 'Y' }"></c:when>
								<c:when test="${item.DET_APRSTA eq 'N' }"></c:when>
								<c:otherwise>
									<c:if test="${item.DET_APREMP == sessionScope.LOGIN_EMPINFO.emp_num }">
										<button type="button" id="approvalBtn" class="btn btn-success pull-right" 
											data-toggle="modal" data-target="#modal-default">
											<i class="fa fa-fw fa-pencil"></i> 결재
										</button>
									</c:if>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<button type="button" id="printBtn" class="btn btn-info pull-left">
							<i class="fa fa-fw fa-print"></i> 인쇄
						</button>
					</div>
				</form>
			</div>
		</div> 
	</div>
	<div class="col-md-6">
		<div class="box box-info">
			<div class="box-header with-border">
				<i class="fa fa-clipboard"></i>
				<h3 class="box-title">결재문서</h3>
			</div>
			<div id="printArea" class="box-body">
				<c:forEach items="${imgSource }" var="img">
					<img id="docImg" class="col-md-12 col-sm-12 col-xs-12" src="${pageContext.request.contextPath }/2jo/Form/data/${img}">
				</c:forEach>
			</div>
		</div>
	</div>
</div>

<!-- 결재 모달 창 -->
<div class="modal fade" id="modal-default" style="display: none;">
	<div id="approvalWindow" class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
				<h4 class="modal-title">전자 결재</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
                  <label for="title" class="col-sm-3">문서제목</label>
				  <span name="title"></span>
                </div>
                <div class="form-group">
                  <label for="writer" class="col-sm-3">기안자</label>
                  <span name="writer"></span>
                </div>
				<hr>
				<div class="form-group">
					<span>
						&nbsp;&nbsp;&nbsp;&nbsp;위 문서를 다음과 같은 이유로&nbsp;&nbsp;&nbsp;&nbsp;
						<select id="approvalSta" class="form-control" style="width: 15%; display: inline-block;">
							<option value="Y">승인</option>
							<option value="N">반려</option>
						</select>
						&nbsp;&nbsp;합니다.
					</span>
				</div>
                <div class="form-group">
                  <label for="reason" class="col-sm-3">결재 사유</label>
                  <input type="text" id="apr_cont" name="reason" class="col-sm-7">
                </div>
				<br><br>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default pull-left" data-dismiss="modal">
					<i class="fa fa-fw fa-close"></i> 닫기
				</button>
				<button id="save" type="button" class="btn btn-primary">
					<i class="fa fa-fw fa-check"></i> 저장
				</button>
			</div>
		</div>
	</div>
</div>

<!-- alert 모달창 -->
<div class="modal fade in" id="modal-alert" style="display: none;">
	<div id="approvalWindow" class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
				<h4 class="modal-title">잠깐!</h4>
			</div>
			<div class="modal-body"></div>
		</div>
	</div>
</div>
</body>
</html>