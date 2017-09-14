<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
$(function(){
	$('#btnRevert').click(function(){
		$(location).attr("href","${pageContext.request.contextPath}/humanResource/employeeAttendanceList.do");
	})
});
</script>
</head>
<body>
	<div class="box">
		<div class="box-header">
			<h3 class="box-title">사원출결 관리</h3>
		</div>
		<!-- /.box-header -->
		<div class="box-body">
			<div id="example1_wrapper"
				class="dataTables_wrapper form-inline dt-bootstrap">

				<div>
					<form action="${pageContext.request.contextPath}/humanResource/employeeAttendanceList.do" method="post" class="form-inline pull-right">
						<select class="form-control" name="search_keycode">
							<option>검색조건</option>
							<option value="TOTAL">전체</option>
							<option value="EMPNUM">사원번호</option>
							<option value="POSNAME">직위</option>
							<option value="EMPNAME">이름</option>
							<option value="ATTDATE">출결일자</option>
						</select> <input name="search_keyword" id="search_keyword" type="text"
							placeholder="검색어 입력..." class="form-control" />
						<button type="submit" class="btn btn-primary form-control">검색</button>
					</form>
				</div>

				<div class="row">
					<div class="col-sm-12">
						<table id="example1"
							class="table table-bordered table-striped dataTable" role="grid"
							aria-describedby="example1_info">
							<thead>
								<tr role="row">
									<th class="sorting">사원번호</th>
									<th class="sorting">이름</th>
									<th class="sorting">직위</th>
									<th class="sorting">직책</th>
									<th class="sorting">출결일자</th>
									<th class="sorting">출근시간</th>
									<th class="sorting">퇴근시간</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${attList}" var="attInfo">
									<tr role="row">
										<td><input type="hidden" name="rnum" value="${attInfo.rnum }">${attInfo.EMP_NUM }</td>
										<td>${attInfo.EMP_NAME }</td>
										<td>${attInfo.POS_NAME }</td>
										<td>${attInfo.ROLE_ID }</td>
										<td>${attInfo.ATT_DATE }</td>
										<td>${attInfo.ATT_APPTIME }</td>
										 <c:set var="name" value="${attInfo.ATT_DAPTIME }"></c:set>
						                  <c:if test="${name eq null }">
						                  	<td><span style="color:red;">미퇴근</span></td>
						                  </c:if>
						                   <c:if test="${name ne null }">
						                  	<td>${attInfo.ATT_DAPTIME }</td>
						                  </c:if>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<!-- /.box-body -->
	</div>
${pagingHtml }
</body>
</html>