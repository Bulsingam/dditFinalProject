<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/css/select2.min.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/js/select2.min.js"></script>
<title>Insert title here</title>
<script type="text/javascript">
$(function(){
	window.setTimeout(function() {
	    $(".alert").fadeTo(500, 0).slideUp(500, function(){
	        $(this).remove(); 
	    });
	}, 4000);
	if('null'!='${insertStatus}'){
// 		성공여부 alert
		$('#alert').show();
	}
	
	// modal에 select2 사용할때 버그 잡기
	if ($.ui && $.ui.dialog && $.ui.dialog.prototype._allowInteraction) {
	    var ui_dialog_interaction = $.ui.dialog.prototype._allowInteraction;
	    $.ui.dialog.prototype._allowInteraction = function(e) {
	        if ($(e.target).closest('.select2-dropdown').length) return true;
	        return ui_dialog_interaction.apply(this, arguments);
	    };
	}
	$('.plID').hide();
	$('#insertProject').hide();
	$('#deletingProject').hide();
	$('#updatingProject').hide();
	$('#insertProDialog-form').hide();
	$('#updateProDialog-form').hide();
	$('#deleteProDialog-form').hide();
	
	//프로젝트 등록 버튼 모달
	$('#insertPro').click(function(){
		$('#insertProDialog-form').dialog({
			height : 700,
			width : 400,
			modal : true,
			resizable : false,
			buttons : {
				"생성" : function(){
					if ($('#insertProName').val() == "") {
						alert('프로젝트명을 입력하셔야 합니다.');
						return null;
					}
					if ($('#insertProStartDate').val() == "") {
						alert('시작일을 등록하셔야 합니다.');
						return null;
					}
					if ($('#insertProEndDate').val() == "") {
						alert('종료일을 등록하셔야 합니다.');
						return null;
					}
					if($('#mem_role').val() == null || $('#mem_emp').val() == null){
						alert('사원 정보를 입력하세요.');
						return null;
					}
					$('#insertProject').click();
					$(this).dialog('close');
					$(this).find('form')[0].reset();
					$('#result *').remove();
				},
				"닫기" : function(){
					$(this).dialog('close');
					$(this).find('form')[0].reset();
					$('#result *').remove();
				}
			},
			close : function() {
				$(this).find('form')[0].reset();
				$('#result *').remove();
			}
		});
	});
	
	//프로젝트 수정 버튼 모달
	$('button[name="updateProject"]').click(function(){
		var $update = $(this).parent();
		var proUpdate = $update.children('#updateID').val();
		$('#pro_id').val(proUpdate);
		$.ajax({
			type:"POST",
			url:"${pageContext.request.contextPath}/project/loadingMemberList.do",
			data: {"proID": proUpdate},
			dataType: "json",
			error: function(request, status, error){
				alert("팀원정보를 읽어오지 못했습니다.\ncode : " + request.status + "\r\nmessage : " + request.reponseText);
			},
			success: function(data){
				for (var i = 0; i < data.proMember.length; i++) {
					$('#memList').append('<input type="checkbox" id="delete_mem_emp" name="delete_mem_emp" value="'+data.proMember[i].MEM_EMP+'">'+
											 '<strong>'+data.proMember[i].EMP_NAME+'('+data.proMember[i].MEM_ROLE+')</strong><br>');
				}
			}
		});
		proUpdate = $update.children('#updateName').val();
		$('#updateProName').val(proUpdate);
		proUpdate = $update.children('#updateStartDate').val();
		$('#updateProStartDate').val(convertDate(proUpdate));
		proUpdate = $update.children('#updateEndDate').val();
		$('#updateProEndDate').val(convertDate(proUpdate));
		$('#updateProDialog-form').dialog({
			height : 700,
			width : 400,
			modal : true,
			resizable : false,
			buttons : 
				[
					{
					    text: "수정",
					    "class": 'btn btn-info',
					    click: function() {
					    	if ($('#updateProName').val() == "") {
								alert('프로젝트명을 입력하셔야 합니다.');
								return null;
							}
							if ($('#updateStartDate').val() == "") {
								alert('시작일을 등록하셔야 합니다.');
								return null;
							}
							if ($('#updateEndDate').val() == "") {
								alert('종료일을 등록하셔야 합니다.');
								return null;
							}
					    	$('#updatingProject').click();
					    	$(this).dialog('close');
							$(this).find('form')[0].reset();
							$('#memList *').remove();
							$('#updateResult *').remove();
					    }
					},
					{
					    text: "닫기",
					    "class": 'btn btn-default',
					    click: function() {
					    	$(this).dialog('close');
							$(this).find('form')[0].reset();
							$('#memList *').remove();
							$('#updateResult *').remove();
					    }
					}
				],
			close : function() {
				$(this).find('form')[0].reset();
				$('#memList *').remove();
				$('#updateResult *').remove();
			}
		});
	});
	
	//프로젝트 삭제 버튼 모달
	$('button[name="deleteProject"]').click(function(){
		var $delete = $(this).parent();
		var proDelete = $delete.children('#deleteID').val();
		$('#deleteProID').val(proDelete);
		$('#deleteMsg').append("<div>"+proDelete+" 프로젝트를 정말로 삭제하시겠습니까?</div>");
		$('#deleteProDialog-form').dialog({
			height : 200,
			width : 480,
			modal : true,
			resizable : false,
			buttons : 
						[
							{
							    text: "삭제",
							    "class": 'btn btn-danger',
							    click: function() {
							    	$('#deletingProject').click();
							    	$(this).dialog('close');
							    	$('#deleteMsg *').remove();
							    }
							},
							{
							    text: "닫기",
							    "class": 'btn btn-default',
							    click: function() {
							    	$(this).dialog('close');
							    	$('#deleteMsg *').remove();
							    }
							}
						],
			close : function() {
				$('#deleteMsg *').remove();
			}
		});
	});
	
	//멤버 추가
	$('td').delegate('#addMem','click',function(){
		$('#result').append('<div>'+
								'<select class="js-example-basic-single" name="mem_role" id="mem_role" style="width:100px;">'+
									'<option value="position" selected="selected" disabled="disabled">직위</option>'+
									'<option value="PM">PM</option>'+
									'<option value="PL">PL</option>'+
									'<option value="DA">DA</option>'+
									'<option value="AA">AA</option>'+
									'<option value="TA">TA</option>'+
									'<option value="BA">BA</option>'+
									'<option value="IA">IA</option>'+
									'<option value="UA">UA</option>'+
								'</select>&nbsp;&nbsp;'+
								'<select class="js-example-basic-single" name="mem_emp" id="mem_emp" style="width:200px;">'+
									'<option value="emp" selected="selected" disabled="disabled">사원명</option>'+
									'<c:forEach items="${employeeList}" var="employeeList" begin="0">'+
										'<c:if test="${employeeList.EMP_NUM ne '201703000'}">'+
	                                    	'<option value="${employeeList.EMP_NUM}">${employeeList.EMP_NAME}(${employeeList.EMP_NUM})</option>'+
										'</c:if>'+
                                    '</c:forEach>'+
								'</select>'+
								'&nbsp;&nbsp;<button id="deleteLine" type="button">삭제</button><br/><br/>'+
							'</div>');
		$("div>#deleteLine").on("click", function(){
			$(this).parent().remove();
		});

		$(".js-example-basic-single").select2({
			placeholder : "사원명",
			allowClear: true
		});
	});

	//수정 멤버 추가
	$('td').delegate('#addUpdateMem','click',function(){
		$('#updateResult').append('<div>'+
									'<select class="js-example-basic-single" name="mem_role" style="width:100px;">'+
										'<option value="position" selected="selected" disabled="disabled">직위</option>'+
										'<option value="PM">PM</option>'+
										'<option value="PL">PL</option>'+
										'<option value="DA">DA</option>'+
										'<option value="AA">AA</option>'+
										'<option value="TA">TA</option>'+
										'<option value="BA">BA</option>'+
										'<option value="IA">IA</option>'+
										'<option value="UA">UA</option>'+
									'</select>&nbsp;&nbsp;'+
									'<select class="js-example-basic-single" name="mem_emp" style="width:200px;">'+
										'<option value="emp" selected="selected" disabled="disabled">사원명</option>'+
										'<c:forEach items="${employeeList}" var="employeeList" begin="0">'+
											'<c:if test="${employeeList.EMP_NAME ne '관리자'}">'+
		                                    	'<option value="${employeeList.EMP_NUM}">${employeeList.EMP_NAME}(${employeeList.EMP_NUM})</option>'+
											'</c:if>'+
	                                    '</c:forEach>'+
	                                    '</select>'+
	    								'&nbsp;&nbsp;<button id="deleteLine" type="button">삭제</button><br/><br/>'+
	    						   '</div>');
		$("div>#deleteLine").on("click", function(){
			$(this).parent().remove();
		});
		$(".js-example-basic-single").select2({
			placeholder : "사원명",
			allowClear: true
		});
	});
	
	// 프로젝트 상세 정보로 이동
	$('tbody[id = "projectList"] tr td.project').click(function(){
		var $pro = $(this).parent();
		var proID = $pro.children('#projectID').text();
		$('input[name=pickProjectID]').val(proID);
		var $pl = $pro.children('#plID');
		var plID = $pl.children('#pl').val();
		$('input[name=pickProjectPlID]').val(plID);
		$('#projectView').append('<input type="hidden" name="search_keycode" value="${search_keycode}" />');
		$('#projectView').append('<input type="hidden" name="search_keyword" value="${search_keyword}" />');
		$('#projectView').submit();
	});
	
	// 받은 날짜값을 date 형태로 형변환 해주어야 한다.
	function convertDate(date) {
	    var date = new Date(date);
		var convert = date.yyyymmdd();
	    return convert;
	}
	
	// 받은 날짜값을 YYYY-MM-DD 형태로 출력하기위한 함수.
	Date.prototype.yyyymmdd = function() {
	    var yyyy = this.getFullYear().toString();
	    var mm = (this.getMonth() + 1).toString();
	    var dd = this.getDate().toString();
	    return yyyy + "-" + (mm[1] ? mm : "0" + mm[0]) + "-" + (dd[1] ? dd : "0" + dd[0]);
	}
})
</script>
<style type="text/css">
	.project:hover{
		background: #D9E5FF;
		box-shadow: 0px 1px 4px 0px rgba(0, 0, 0, 0.2);
	}
</style>
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
	                <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Rendering engine: activate to sort column ascending" style="width: 10%;">프로젝트ID</th>
	                <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Browser: activate to sort column ascending" style="width: 30%;">프로젝트명</th>
	                <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Platform(s): activate to sort column ascending" style="width: 10%;">팀장(PL)</th>
	                <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Platform(s): activate to sort column ascending" style="width: 10%;">투입인원</th>
	                <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Engine version: activate to sort column ascending" style="width: 10%;">시작일</th>
	                <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending" style="width: 10%;">종료일</th>
	                <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending" style="width: 10%;">상태</th>
	                <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending" style="width: 5%;">수정</th>
	                <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending" style="width: 5%;">삭제</th>
	                </tr>
	                </thead>
	                <tbody id="projectList">
						<c:forEach items="${projectList }" var="projectList">
							<tr>
								<td class="project" id="projectID"><strong style="color:green;">${projectList.PRO_ID }</strong></td>
								<td class="project">${projectList.PRO_NAME }</td>
								<td class="project" id="plID">
									<input class="plID" id="pl" value="${projectList.EMP_NUM }"/>
									${projectList.EMP_NAME }
								</td>
								<td class="project">${projectList.COUNT }</td>
								<td class="project"><fmt:formatDate value="${projectList.PRO_STARTDATE }" pattern="yyyy-MM-dd"/></td>
								<td class="project"><fmt:formatDate value="${projectList.PRO_ENDDATE }" pattern="yyyy-MM-dd"/></td>
								<td class="project">
									<c:if test="${projectList.PRO_STA eq 'Y' }">
										<strong style="color:blue;">진행</strong>
									</c:if>
									<c:if test="${projectList.PRO_STA eq 'N' }">
										<strong style="color:red;">종료</strong>
									</c:if>
								</td>
								<td>
									<button name="updateProject" class="btn btn-info" type="button">수정</button>
									<input type="hidden" value="${projectList.PRO_ID }" id="updateID"/>
									<input type="hidden" value="${projectList.PRO_NAME }" id="updateName"/>
									<input type="hidden" value="${projectList.PRO_STARTDATE }" id="updateStartDate"/>
									<input type="hidden" value="${projectList.PRO_ENDDATE }" id="updateEndDate"/>
								</td>
								<td>
									<button name="deleteProject" class="btn btn-danger" type="button">삭제</button>
									<input type="hidden" value="${projectList.PRO_ID }" id="deleteID"/>
								</td>
				            </tr>
						</c:forEach>
	                </tbody>
	              </table>
		            <form action="${pageContext.request.contextPath}/project/projectList.do" method="post" name="searchForm" style="text-align:right;">
					<select name="search_keycode" >
						<option>검색조건</option>
						<option value="ALL">전체</option>
						<option value="PRONAME">프로젝트명</option>
						<option value="PROID">프로젝트ID</option>
						<option value="PM">팀장</option>
					</select>
					<input id="search_keyword" name="search_keyword" type="text" placeholder="검색어 입력..."/>
					  <button type="submit">검색</button>
					  <button type="button" id="insertPro">등록</button>
					</form>
		            </div>
		          </div>
				</div>
			</div>
		</div>
	</div>
	${pagingHtml }
	<!-- 프로젝트 생성 modal -->
	<div id="insertProDialog-form" title="프로젝트 생성">
		<form method="post" action="${pageContext.request.contextPath}/project/insertProject.do">
		    <table>
		    	<tr>
		    		<td>프로젝트 이름</td>
		    		<td>
		    			<input type="text" id="insertProName" name="pro_name" style="margin:0px 0px 10px 20px;">
		    		</td>
		    	</tr>
		    	<tr>
		    		<td>시작일</td>
		    		<td>
		    			<input type="date" id="insertProStartDate" name="pro_startdate" style="margin:0px 0px 10px 20px;">
		    		</td>
		    	</tr>
		    	<tr>
		    		<td>종료일</td>
		    		<td>
		    			<input type="date" id="insertProEndDate" name="pro_enddate" style="margin:0px 0px 10px 20px;">
		    		</td>
		    	</tr>
		    	<tr>
		    		<td>팀원</td>
		    		<td>
		    			<a id="proMemList"></a><input type="button" id="addMem" value="추가" style="margin:0px 0px 10px 20px;">
		    		</td>
		    	</tr>
		    </table>
			<div id="result"></div>
			<input id="insertProject" type="submit">
		</form>
	</div>
	<!-- 프로젝트 수정 modal -->
	<div id="updateProDialog-form" title="프로젝트 수정">
		<form method="post" action="${pageContext.request.contextPath}/project/updateProject.do">
		    <table>
		    	<tr>
		    		<td>프로젝트 이름</td>
		    		<td>
		    			<input type="hidden" id="pro_id" name="pro_id">
		    			<input type="text" id="updateProName" name="pro_name" style="margin:0px 0px 10px 20px;">
		    		</td>
		    	</tr>
		    	<tr>
		    		<td>시작일</td>
		    		<td>
		    			<input type="date" id="updateProStartDate" name="pro_startdate" style="margin:0px 0px 10px 20px;">
		    		</td>
		    	</tr>
		    	<tr>
		    		<td>종료일</td>
		    		<td>
		    			<input type="date" id="updateProEndDate" name="pro_enddate" style="margin:0px 0px 10px 20px;">
		    		</td>
		    	</tr>
		    	<tr>
		    		<td>팀원 제외</td>
		    		<td>
						<div id="memList" style="margin:0px 0px 10px 20px;"></div>
		    		</td>
		    	</tr>
		    	<tr>
		    		<td>팀원 추가</td>
		    		<td>
		    			<a id="proMemList"></a><input type="button" id="addUpdateMem" value="추가" style="margin:0px 0px 10px 20px;">
		    		</td>
		    	</tr>
		    </table>
			<div id="updateResult"></div>
			<input id="updatingProject" type="submit">
		</form>
	</div>
	<!-- 프로젝트 삭제 modal -->
	<div id="deleteProDialog-form" title="프로젝트 삭제">
		<form method="post" action="${pageContext.request.contextPath}/project/dropProject.do">
			<input type="hidden" id="deleteProID" name="proID">
		    <strong id="deleteMsg" style="color: red; font-size: 20px; text-align: center;"></strong><br>
			<input id="deletingProject" type="submit" value="삭제">
		</form>
	</div>
	<!-- 프로젝트 세부 정보 출력 페이지 이동을 위한 form -->
	<form id="projectView" method="post" action="${pageContext.request.contextPath }/project/projectScheduleView.do">
		<input name="pickProjectID" type="hidden">
		<input name="pickProjectPlID" type="hidden">
	</form>
</body>
</html>