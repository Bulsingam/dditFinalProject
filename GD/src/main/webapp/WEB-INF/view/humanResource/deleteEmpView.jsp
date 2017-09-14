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
	$("#btnDelete").click(function() {
		var arr=[];
		$("input[name=box]:checked").each(function() {
			arr.push($(this).val());
		});
			var $frm = $('<form action="${pageContext.request.contextPath}/humanResource/deleteEmployee.do" method="post"></form>');
			$frm.append('<input type="hidden" name="empNum" value="'+arr+'"/>');
		    $(document.body).append($frm);
		    $frm.submit();
	});
});
</script>
</head>
<body>

<div class="box">
            <div class="box-header">
              <h3 class="box-title">사원정보</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <div id="example1_wrapper" class="dataTables_wrapper form-inline dt-bootstrap">
              
<div>
<form action="${pageContext.request.contextPath}/humanResource/deleteEmployeeView.do" method="post" class="form-inline pull-right">
		<select class="form-control" name="search_keycode" >
							<option>검색조건</option>
							<option value="TOTAL">전체</option>
							<option value="EMPNUM">사원번호</option>
							<option value="EMPNAME">성명</option>
							<option value="EMPPOS">직위</option>
						</select>
						<input name="search_keyword" id="search_keyword" type="text" placeholder="검색어 입력..." class="form-control" />
					    <button type="submit" class="btn btn-primary form-control">검색</button>
</form>
</div>
              
              <div class="row">
              <div class="col-sm-12">
              <table id="example1" class="table table-bordered table-striped dataTable" role="grid" aria-describedby="example1_info">
                <thead>
                <tr role="row">
                <th class="sorting"></th>
                <th class="sorting">사원번호</th>
                <th class="sorting">이름</th>
                <th class="sorting">직위</th>
                <th class="sorting">직책</th>
                <th class="sorting">이메일</th>
                <th class="sorting">전화번호</th>
                <th class="sorting">상태</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${empList}" var="empList">
	                <tr role="row">
	                  <td><input type="checkbox" name="box" value="${empList.EMP_NUM }"></td>
	                  <td name="del">${empList.EMP_NUM }</td>
	                  <td>${empList.EMP_NAME }</td>
	                  <td>${empList.POS_NAME }</td>
	                  <td>${empList.ROLE_ID }</td>
	                  <td>${empList.EMP_MAIL }</td>
	                  <td>${empList.EMP_TEL }</td>
	                  <c:set var="name" value="${empList.EMP_STA }"></c:set>
	                  <c:if test="${name eq 'Y' }">
	                  	<td>재직중</td>
	                  </c:if>
	                   <c:if test="${name ne 'Y' }">
	                  	<td><span style="color:red;">퇴사</span></td>
	                  </c:if>
	                </tr>
	           	</c:forEach>
                </tbody>
			 </table>
			 </div>
			 </div>
			 <div class="row">
			 	<div class="col-md-2 col-lg-offset-10">
							<button type="button" class="btn btn-primary btn-block btn-flat" id="btnDelete">삭제</button>
				</div>
			 </div>
			 </div>
            </div>
            <!-- /.box-body -->
          </div>
${pagingHtml }

</body>
</html>