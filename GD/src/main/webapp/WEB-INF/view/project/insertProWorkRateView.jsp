<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
$(function(){
	$('form').submit(function(){
		$(this).append('<input type="hidden" name="wrt_rater" value="${LOGIN_EMPINFO.emp_num}"></input>');
		$(this).append('<input type="hidden" name="emp_num" value="${LOGIN_EMPINFO.emp_num }"></input>');
		return true;
	});
});
</script>
</head>
<body>
<form action="${pageContext.request.contextPath }/proWorkRate/insertProWorkRate.do" method="post">
	<div class="box">
		<div class="box-header">
			<h3 class="box-title">사원 평가</h3>
		</div>
		<!-- /.box-header -->
		
		<c:forEach items="${workRateList }" var="workRateInfo" varStatus="status">
		<div class="box-body">
			<div id="example2_wrapper"
				class="dataTables_wrapper form-inline dt-bootstrap">
				<div class="row">
					<div class="col-sm-2"><label style="margin-left: 20px;">직위</label><lable style="margin-left: 20px;" >${workRateInfo.MEM_ROLE }</lable><br/>
										  <label style="margin-left: 20px;">이름</label><label style="margin-left: 20px;" >${workRateInfo.EMP_NAME }</label>
										  <input type="hidden" name="wrt_tar" value="${workRateInfo.EMP_NUM }">
										  <input type="hidden" name="wrt_proid" value="${workRateInfo.PRO_ID }"><br/>
										  <label style="margin-left: 20px;">등급</label>
										  <select name="wrt_lev" style="margin-left: 20px;">
										  	<option value="A">A</option>
										  	<option value="B">B</option>
										  	<option value="C">C</option>
										  	<option value="D">D</option>
										  	<option value="E">E</option>
										  	<option value="F">F</option>
										  </select>
					</div>
					<div class="col-sm-10">
						<textarea name="wrt_cont" style="width:400px; height: 100px;"></textarea>
					</div>
				</div>
			</div>
		</div>
		</c:forEach>
		<div class="row">
			 	<div class="col-md-2 col-lg-offset-4">
							<button type="submit" class="btn btn-primary btn-block btn-flat" id="btnInsert">등록</button>
				</div>
			 </div>
	</div>
</form>	
</body>
</html>