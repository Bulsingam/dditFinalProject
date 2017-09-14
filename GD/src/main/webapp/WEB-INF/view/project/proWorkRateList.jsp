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
	if(eval('${!empty message}')){
		alert('${message}');
	}
	
	$('tbody tr').click(function(){
		var idx = $(this).index();
		var pro_id = $('tbody tr:eq('+idx+') td:eq(0)').text();
		
		var $frm = $('<form action="${pageContext.request.contextPath}/proWorkRate/insertProWorkRateView.do" method="post"></form>')
		$frm.append('<input type="hidden" name="pro_id" value="'+pro_id+'"></input>');
		
		$(document.body).append($frm);
		
		$frm.submit();
	});
});
</script>
</head>
<body>
<div>
	<div class="box">
            <div class="box-header">
              <h3 class="box-title">프로젝트 리스트</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <div id="example1_wrapper" class="dataTables_wrapper form-inline dt-bootstrap"><div class="row"><div class="col-sm-6"><div class="dataTables_length" id="example1_length"></div></div><div class="col-sm-6"></div></div><div class="row"><div class="col-sm-12"><table id="example1" class="table table-bordered table-striped dataTable" role="grid" aria-describedby="example1_info">
                <thead>
                <tr role="row">
                <th class="sorting">프로젝트ID</th>
                <th class="sorting">프로젝트 명</th>
                <th class="sorting">팀장</th>
                <th class="sorting">투입인원</th>
                <th class="sorting">시작일</th>
                <th class="sorting">종료일</th>
                <th class="sorting">상태</th>
                </tr>
                </thead>
                <tbody>
					<c:forEach items="${plProList }" var="plProInfo">
							<tr>
								<td>${plProInfo.PRO_ID }</td>
								<td>${plProInfo.PRO_NAME }</td>
								<td>${plProInfo.EMP_NAME }</td>
								<td>${plProInfo.COUNT }</td>
								<td>${plProInfo.PRO_STARTDATE }</td>
								<td>${plProInfo.PRO_ENDDATE }</td>
								<td>
									<c:set var="status" value="${plProInfo.PRO_STA}"></c:set>
									<c:if test="${status eq 'Y' }">
										<strong style="color:blue;">진행</strong>
									</c:if>
									<c:if test="${status eq 'N' }">
										<strong style="color:red;">종료</strong>
									</c:if>
								</td>
		                	</tr>
					</c:forEach>
                </tbody>
              </table>
<%-- 	            <form action="${pageContext.request.contextPath}/pro/proList.do" method="post" name="searchForm" style="text-align:right;"> --%>
<!-- 				<select name="search_keycode" > -->
<!-- 					<option>검색조건</option> -->
<!-- 					<option value="ALL">전체</option> -->
<!-- 					<option value="PRONAME">프로젝트명</option> -->
<!-- 					<option value="PROID">프로젝트ID</option> -->
<!-- 					<option value="PM">팀장</option> -->
<!-- 				</select> -->
<!-- 				<input id="search_keyword" name="search_keyword" type="text" placeholder="검색어 입력..."/> -->
<!-- 				  <button type="submit">검색</button> -->
<!-- 				  <button type="button" id="insertPro">등록</button> -->
<!-- 				</form> -->
	            </div>
	          </div>
			</div>
		</div>
	</div>
</div>
</body>
</html>