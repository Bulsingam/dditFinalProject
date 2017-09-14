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
	$('#example1 tbody tr td.view').on('click', function(){
		if(parseInt('${LOGIN_EMPINFO.emp_pos}') <= 2 ){
			var $emp = $(this).parent();
			var emp_num = $emp.children("#emp_num").text();
			var emp_sta = $emp.children("td[name=emp_sta]").text();
			if(emp_sta=="재직자"){
				var $frm = $('<form action="${pageContext.request.contextPath}/humanResource/updateEmployeeView.do" method="post"></form>');
				$frm.append('<input type="hidden" name="emp_num" value="'+emp_num+'">');
				$frm.append('<input type="hidden" name="currentPage" value="${currentPage}">');
				$frm.append('<input type="hidden" name="search_keyword" value="${search_keyword}">');
				$frm.append('<input type="hidden" name="search_keycode" value="${search_keycode}">');
				$('body').append($frm);
				$frm.submit();
				
			}
			
		}
		
	})
	$('#search').submit(function(){
		
		return true;
	})
	
	$('#popupModal').click(function(){
		$.ajax({
			type : 'POST'
		  , url : '${pageContext.request.contextPath}/employee/salaryInfo.do'
		  , dataType : 'json'
		  , error : function(request){
				alert("code : " + request.status + "\r\nmessage : " + request.reponseText);
		  }
		  , success : function(result){		
			  
			  var code = "<table id='salary'><thead><tr><th>직위</th><th>직위별 급여현황</th><th>현재인원</th></tr></thead><tbody>";
			  $.each(result.salInfo,function(i){
				  if(i>0){
				  	code += "<input type='hidden' name='pos_id' value='" + result.salInfo[i].POS_ID + "'/><tr><td>" + result.salInfo[i].POS_NAME + "</td><td><input type='text' name='pos_sal' value='" + result.salInfo[i].POS_SAL + "'/> 원</td><td>" + result.salInfo[i].EMP_COUNT +"</td></tr>";
				  }
			  })
			  code += "</tbody></table>";
			  $('#modal-body').html(code);
		  }
		});
	});
	
})
</script>
<style>
	#salary{
		text-align : center;
		width : 100%;
	}
	#salary thead tr th{
		text-align : center;
	}
</style>
</head>
<body>

	<div class="box">
		<div class="box-header">
			<h3 class="box-title">사원정보</h3>
		</div>
		<div class="box-body">
			<div id="example1_wrapper"
				class="dataTables_wrapper form-inline dt-bootstrap">
				<div>
					<form action="${pageContext.request.contextPath}/employee/employeeList.do"
						method="post" class="form-inline pull-right" id="search">
						<select class="form-control" name="search_keycode">
							<option>검색조건</option>
							<option value="TOTAL">전체</option>
							<option value="NUMBER">사원번호</option>
							<option value="NAME">성명</option>
							<option value="POSITION">직위</option>
							<option value="ROLE">직책</option>
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
									<th class="sorting"></th>
									<th class="sorting">사원번호</th>
									<th class="sorting">성명</th>
									<th class="sorting">전화번호</th>
									<th class="sorting">직위</th>
									<th class="sorting">직책</th>
									<th class="sorting">상태</th>
									<th class="sorting">메일</th>
									<th class="sorting">채팅</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${empList}" var="empList" begin="0">
									<tr role="row" class="odd" value="${empList.EMP_NUM }" id="ttr">
										<td style="text-align: center" class="view"><image
												src="/2jo/Employee/img/${empList.EMP_IMG}"
												style="width:30px;height:30px;"></td>
										<td class="view " id="emp_num">${empList.EMP_NUM }</td>
										<td class="view">${empList.EMP_NAME }</td>
										<td class="view">${empList.EMP_TEL }</td>
										<td class="view">${empList.POS_NAME }</td>
										<td class="view">${empList.ROLE_ID }</td>

										<c:set var="name" value="${empList.EMP_STA }" />
										<c:choose>
											<c:when test="${name eq  'Y'}">
												<td name="emp_sta">재직자</td>
											</c:when>
											<c:when test="${name eq  'N'}">
												<td name="emp_sta">퇴사자</td>
											</c:when>
										</c:choose>
										<td><a>${empList.EMP_MAIL }</a></td>
										<td><a>1:1채팅하기</a></td>

									</tr>
								</c:forEach>
							</tbody>

						</table>
					</div>
				</div>
				<div class="row">
					<c:set var="name" value="${LOGIN_EMPINFO.getEmp_num()}" />
						<c:choose>
							<c:when test="${name eq '201703000'}">
								<button class="btn btn-danger btn-lg fa fa-won pull-right" style="margin: 15px 110px 0px 0px;" data-target="#modal" data-toggle="modal" id="popupModal"> 급여수정</button>
							</c:when>
							<c:otherwise>
								<div></div>
							</c:otherwise>
						</c:choose>
					<div class=" col-md-7">${pagingHtml }</div>
				</div>
			</div>
		</div>
	</div>
	
	
	<!-- 급여수정 모달창 -->
<form action="${pageContext.request.contextPath }/employee/updateSalary.do" method="post">
	<div class="modal fade" id="modal">
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- header -->
				<div class="modal-header">
					<!-- 닫기(x) 버튼 -->
					<button type="button" class="close" data-dismiss="modal">×</button>
					<!-- header title -->
					<h4 class="modal-title">사원급여 상태</h4>
				</div>
				<!-- body -->
				<div class="modal-body" id="modal-body">

				</div>
				<!-- Footer -->
				<div class="modal-footer">
					<button type="submit" class="btn btn-info" style="margin-right: 10px" id="updatSal">급여 수정</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</form>
</body>
</html>