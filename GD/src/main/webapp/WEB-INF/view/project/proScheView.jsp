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
<script>
$(function(){
	//프로젝트 진행 현황
	$('#proBar').css('width','${proBarInfo.RESULT}%');
	$('#proBarPersent').html('${proBarInfo.RESULT}%');
	$('#proBarPersent').css('font-size','15px');
	
	// modal에 select2 사용할때 버그 잡기
	if ($.ui && $.ui.dialog && $.ui.dialog.prototype._allowInteraction) {
	    var ui_dialog_interaction = $.ui.dialog.prototype._allowInteraction;
	    $.ui.dialog.prototype._allowInteraction = function(e) {
	        if ($(e.target).closest('.select2-dropdown').length) return true;
	        return ui_dialog_interaction.apply(this, arguments);
	    };
	}
	
	var date = new Date();
	var d = date.getDate();
	var m = date.getMonth();
	var y = date.getFullYear();
	
	$('#insertSchedule').hide();
	$('#deleteSchedule').hide();
	$('#updateSchedule').hide();
	$('input[name="sche_empInfo"]').hide();
	$('#insertScheDialog-form').hide();
	$('#ScheViewDialog-form').hide();
	
	$(".js-example-basic-single").select2({
		allowClear: true
	});
	
	$.ajax({
		type:"POST",
		url:"${pageContext.request.contextPath}/schedule/loadingSchedule.do",
		data: {"proID" : "${proID }"},
		dataType:"json",
		error: function(request, status, error){
			alert("일정을 읽어오지 못했습니다.\ncode : " + request.status + "\r\nmessage : " + request.reponseText);
		},
		success: function(data){
			// 캘린더 생성
			var calendar = $('#calendar').fullCalendar({
				// 캘린더의 가장 윗부분(header)의 배치
			    header: {
			      // 좌측 배치
			      left: 'prev,next today',
			      // center 배치
			      center: 'title',
			      // 우측 배치
			      right: 'month,agendaWeek,agendaDay'
				},
				// 클릭 및 드래그 이벤트
				selectable: true,
				// 사용자가 드래그를 하는 동안 그 자리를 표시하는가에 대한 이벤트??
				selectHelper: true,
				// select 이벤트 생성(event 시작, event 종료, )
				select: function(start, end, allDay){
					// PL만 생성의 권한을 가지고 있다.
					if(${LOGIN_EMPINFO.emp_num } == ${plID}){
						// prompt로 event의 title을 작성(이부분을 prompt로 입력하지 말고 modal창을 띄우면 추가 방식의 변경도 가능할것)
						$('#insertScheDialog-form').dialog({
							height : 400,
							width : 350,
							modal : true,
							buttons : {
								"생성" : function(){
									if ($('#sche_name').val() == "") {
										alert('스케줄명을 입력하셔야 합니다.');
										return null;
									}
									if ($('#sche_startdate').val() == "") {
										alert('시작일을 등록하셔야 합니다.');
										return null;
									}
									if ($('#sche_enddate').val() == "") {
										alert('종료일을 등록하셔야 합니다.');
										return null;
									}
									$('#insertSche-form').append('<input type="text" name="plID" value="'+${plID}+'">');
									$('#insertSchedule').click();
									$(this).dialog('close');
									$(this).find('form')[0].reset();
								},
								"닫기" : function(){
									$(this).dialog('close');
									$(this).find('form')[0].reset();
								}
							},
							close : function() {
								$(this).find('form')[0].reset();
							}
						});
					}else{
						alert('권한이 없습니다.');
					}
					$('#sche_startdate').val(convertDate(start));
					$('#sche_enddate').val(convertDate(end));
					$('#insertSchedule').click(function(){
						if($('input[id=sche_name]').val()){
							// event 생성 title이라는 변수가 생성되었을 경우 event를 만들어준다.
							calendar.fullCalendar('renderEvent',
								{
									title: $('input[id=sche_name]').val(),
									start: $('input[id=sche_startdate]').val(),
									end: $('input[id=sche_enddate]').val(),
									allDay: allDay
								},
								true
							);
						}
					$('#pro_sche').val('');
						calendar.fullCalendar('unselect');
					});
				},
				// Click에 대한 이벤트
				eventClick: function(calEvent, jsEvent, view) {
					$('#ScheViewDialog-form').dialog({
						height : 400,
						width : 300,
						modal : true,
						buttons : {
							"수정" : function(){
								if(${LOGIN_EMPINFO.emp_num } != ${plID}){
									alert('수정 권한이 없습니다.');
									return null;
								}else{
									if ($('#sche_nameInfo').val() == "") {
										alert('스케줄명을 입력하셔야 합니다.');
										return null;
									}
									if ($('#sche_startdateInfo').val() == "") {
										alert('시작일을 등록하셔야 합니다.');
										return null;
									}
									if ($('#sche_enddateInfo').val() == "") {
										alert('종료일을 등록하셔야 합니다.');
										return null;
									}
									$('#scheView-form').append('<input type="text" name="plID" value="'+${plID}+'">');
									$('#updateSchedule').click();
								}
								$(this).dialog('close');
								$(this).find('form')[0].reset();
							},
							"삭제" : function(){
								if(${LOGIN_EMPINFO.emp_num } != ${plID}){
									alert('삭제 권한이 없습니다.');
									return null;
								}else{
									$('#deleteSche-form').append('<input type="text" name="plID" value="'+${plID}+'">');
									$('#deleteSche_seq').val(calEvent.id);
									$('#deleteSchedule').click();
								    // removeEvents = 이벤트 삭제, calEvent._id = 해당 이벤트의 id 를 가지고 삭제
									$('#calendar').fullCalendar('removeEvents', calEvent.id);
									$('#deleteSchedule').click(function(){
									});
								}
								$(this).dialog('close');
								$(this).find('form')[0].reset();
							},
							"닫기" : function(){
								$(this).dialog('close');
								$(this).find('form')[0].reset();
							}
						},
						close : function() {
							$(this).dialog('close');
							$(this).find('form')[0].reset();
						}
					});
					
					$('#sche_nameInfo').val(calEvent.title);
					$('#sche_startdateInfo').val(convertDate(convertDate(calEvent.start)));
					$('#sche_enddateInfo').val(convertDate(convertDate(calEvent.end)));
					$('#sche_seq').val(calEvent.id);
					$('input[name="sche_empInfo"]').val(calEvent.emp);
					$('#sche_empInfo').val(calEvent.name+"("+calEvent.emp+")");
					$('#sche_contInfo').val(calEvent.cont);
					// PL이 아닌 팀원은 스케줄 편집 불가
					if(${LOGIN_EMPINFO.emp_num } != ${plID}){
						$('#sche_nameInfo').attr('disabled', true);
						$('#sche_startdateInfo').attr('disabled', true);
						$('#sche_enddateInfo').attr('disabled', true);
						$('#sche_contInfo').attr('disabled', true);
						$('td#changeMem>#sche_emp').attr('disabled', true);
					}
			    },
			    // 캘린터의 이벤트 수정 여부를 결정
				editable: true,
				// event들은 json 배열 형식으로 저장한다. (초기값 설정이라고 볼 수 있다.)
				events: data.schedule
				});
			}
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
	
	
	 $('#example1').DataTable({
	      "paging": true,
	      "lengthChange": false,
	      "searching": false,
	      "ordering": false,
	      "info":false,
	      "autoWidth": false
	    });
	
	 $('#example2').DataTable({
	      "paging": true,
	      "lengthChange": false,
	      "searching": false,
	      "ordering": false,
	      "info":false,
	      "autoWidth": false
	    });

	
	
});
</script>
<style>
	.highlight-palette span {
		display: inline-block;
		vertical-align: top;
		margin: 0 0.15em;
		background-color: #eee;
		width: 1em;
		height: 1em;
		border: 1px solid black;
		border-radius: 4px;
		cursor: pointer;
		box-shadow: 0 1px 2px #ccc;
	}
	.memselectbox{
		padding-left: 20px;
		padding-bottom: 10px;
	}
	
		/* 아이콘크기조절  전자결재아이콘 스타일*/
.fa-files-o{
	font-size: 50px;
}

.fa-file-o{
	font-size: 50px;
}

 .fa-file-text{
	font-size: 50px;
}

.fa-clipboard{
	font-size: 50px;
}

.fa-file{
	font-size: 50px;
}


div.box{
	float : left;
}

 span.info-box-icon.bg-green{ 
 	padding-top : 25px;
	width:160px;
	height:120px;
}



 span.info-box-icon.bg-hotpink{ 
 	padding-top : 25px;
	width:160px;
	height:120px;
}



 span.info-box-icon.bg-red{ 
 	padding-top : 25px;
	width:160px;
	height:120px;
}


  div#conteneur3D.col-md-3.col-sm-6.col-xs-12{  
		
 	  margin-left: 5%;
 	
 	
 
	
 } 

/*  div#conteneur3D.col-md-3.col-sm-6.col-xs-12:first-child{  */
		
/*   	margin-right: 50px;  ;   */
	

	
/*  }  */



#conteneur3D {


-webkit-perspective : 600px;
perspective : 600px;
 
}

#conteneur3D #carte {
height : 120px;
width : 160px;
-webkit-transform-origin : 50% 50% 30px;
-webkit-transform : rotateY(0);
-webkit-transform-style : preserve-3d;
-webkit-transition : all 1s ease;

  transform-origin : 50% 50% 30px;
  transform : rotateY(0);
  transform-style : preserve-3d;
  transition : all 1s ease;
/* OMBRE */
-webkit-box-shadow : 0 0 15px #333;
  box-shadow : 0 0 15px #333;
  text-align : center;
font-family : Arial;
color : white;

}

#conteneur3D:hover #carte {
-webkit-transform : rotateY(180deg);
transform : rotateY(180deg);
cursor : pointer;
}

#carte div {
position : absolute;

height : 120px;

width : 160px;

background-color : deepskyblue;

-webkit-backface-visibility : hidden;

backface-visibility : hidden;

}


#carte div:first-child {
-webkit-transform : rotateY(180deg);
-moz-transform : rotateY(180deg);
-ms-transform : rotateY(180deg);
transform : rotateY(180deg);

}

span.info-box-number{
	font-size: 30px;
	margin-top: 35px;
}
</style>
</head>
<body>
	<div class="row">
		<div class="col-md-6">
<!-- 캘린더 시작 -->
			<div class="box box-primary">
				<div class="box-body no-padding">
					<div id="calendar" class="fc fc-unthemed fc-ltr"></div>
				</div>
			</div>
<!-- 캘린더 끝 -->

	
			<div id="whitediv">
				<div id="conteneur3D" class="col-md-3 col-sm-6 col-xs-12" >
 					<div id="carte" >
   					   <!-- Back -->
    				 	<div>	 
	             			 <span class="info-box-number">${folder.prgFolder }건</span>
   		    			</div>
   					    <!-- Front -->
  		 		   	    <div>
     			 			 <span class="info-box-icon bg-green"><i class="fa fa-file-text">
     			 			 <span class="info-box-text">진행</span></i></span>
   		    	 	   </div>
 				  </div>
 		 	   </div>
		  </div>
		  
		  	<div id="whitediv">
						<div id="conteneur3D" class="col-md-3 col-sm-6 col-xs-12" >
 							<div id="carte">
 							
   								 <!-- Back -->
    							<div>
	             					 <span class="info-box-number">${folder.confFolder }건</span>
   		   					    </div>
   		   					    
   								 <!-- Front -->
  		    					<div>
     								  <span class="info-box-icon bg-hotpink"><i class="fa fa-clipboard">
     			  				      <span class="info-box-text">승인</span></i></span>
   		   					    </div>
 		 					</div>
 		 			   </div>
				</div>
		
		
			
				<div id="whitediv">
						<div id="conteneur3D" class="col-md-3 col-sm-6 col-xs-12" style="width:10%">
 							<div id="carte">
  			
  							  <!-- Back -->
    							<div>
	             					 <span class="info-box-number">${folder.refFolder }건</span>
   		  					    </div>
    		 
    							 <!-- Front -->
					  		    <div>
					     			  <span class="info-box-icon bg-red"><i class="fa fa-file">
					     			  <span class="info-box-text">반려</span></i></span>
					   		    </div>
 						  </div>
 					 </div>
				</div>
				
		


		</div>
		<div class="col-md-5">
			<div style="display:inlineblock;">
				<div class="box box-solid">
					<div class="box-header with-border">
						<h3 class="box-title">프로젝트 진행 현황</h3>
					</div>
					<!-- /.box-header -->
					<div class="box-body">
						<p>프로젝트: <code>${proName }</code></p>
						<div class="row">
							<div class="col-sm-11" style="padding-right: 0px;">
								<div class="progress progress-sm active" style="margin-top: 5px;">
									<div id="proBar" class="progress-bar progress-bar-success progress-bar-striped" 
										role="progressbar" aria-valuemin="0" aria-valuemax="100"></div>
								</div>
							</div>
							<div class="col-sm-1" style="padding-left: 5px;">
								<span class="badge bg-green"><p id="proBarPersent" style="margin: 0px;"></p></span>
							</div>
						</div>
					</div>
					<!-- /.box-body -->
				</div>
				<!-- /.box -->
			</div>
			<div style="display:inlineblock;">
				<div class="box">
					<div class="box-header">
						<h3 class="box-title">프로젝트 게시판</h3>
						<button type="button" class="btn btn-box-tool pull-right" value="more" id="anony" onclick="location.href='/projectBoard/proBoList.do?pro_id=${proID }'">
			            	<span style="margin-right:10px;">more</span>
			            	<i class="fa fa-plus" style="text-align:right; size:10px;"></i>
			            </button>
					</div>
		            <!-- /.box-header -->
					<div class="box-body">
						<div id="example1_wrapper" class="dataTables_wrapper form-inline dt-bootstrap">
							<div class="row">
								<div class="col-sm-6">
									<div class="dataTables_length" id="example1_length"></div>
								</div>
								<div class="col-sm-6"></div>
							</div>
							<div class="row">
								<div class="col-sm-12">
									<!-- 프로젝트 게시판 테이블 시작 -->								
				              		<table id="example1" class="table table-bordered table-striped dataTable" role="grid" aria-describedby="example1_info">
										<thead>
											<tr role="row">
												<th style="width: 5%;">No</th>
												<th style="width: 25%;">프로젝트명</th>
												<th style="width: 20%;">제목</th>
												<th style="width: 15%;">작성자</th>
												<th style="width: 15%;">등록일</th>
												<th style="width: 15%;">조회수</th>
											</tr>
										</thead>
						                <tbody>
										<c:forEach items="${proBoList }" var="pBList">
											<tr>
												<td>${pBList.RNUM }</td>
												<td>${pBList.PRO_BO_PROID }</td>
												<td>
													<c:forEach begin="1" end="${pBList.PRO_BO_DEP }" varStatus="stat">
              										&nbsp;&nbsp;
              											<c:if test="${stat.last }">
															<img src="${pageContext.request.contextPath }/image/ico_reply.gif" alt="reply">
														</c:if>
													</c:forEach> ${pBList.PRO_BO_TITLE }
												</td>
												<td>${pBList.EMP_NAME }</td>
												<td><fmt:formatDate value="${pBList.PRO_BO_REGDATE }"/></td>
												<td>${pBList.PRO_BO_VIEWHIT }</td>
											</tr>
						                </c:forEach>
						                </tbody>
									</table>
									<!-- 프로젝트 게시판 테이블 끝 -->									
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div style="display:inlineblock;">
				<div class="box">
					<div class="box-header">
						<h3 class="box-title">프로젝트 자료실</h3>
							<button type="button" class="btn btn-box-tool pull-right" value="more" id="anony" onclick="location.href='/projectArchive/proArcList.do?pro_id=${proID }'">
			            	<span style="margin-right:10px;">more</span>
			            	<i class="fa fa-plus" style="text-align:right; size:10px;"></i>
			            </button>
					</div>
					<!-- /.box-header -->
					<div class="box-body">
						<div id="example1_wrapper" class="dataTables_wrapper form-inline dt-bootstrap">
							<div class="row">
								<div class="col-sm-6">
									<div class="dataTables_length" id="example1_length"></div>
								</div>
								<div class="col-sm-6"></div>
							</div>
							<div class="row">
								<div class="col-sm-12">
<!-- 프로젝트 자료실 테이블 시작 -->
									<table id="example2" class="table table-bordered table-striped dataTable" role="grid"
										aria-describedby="example1_info">
										<thead>
											<tr role="row">
												<th style="width: 5%;">No</th>
												<th style="width: 25%;">프로젝트명</th>
												<th style="width: 20%;">제목</th>
												<th style="width: 15%;">작성자</th>
												<th style="width: 15%;">등록일</th>
												<th style="width: 15%;">다운로드수</th>
											</tr>
										</thead>
						                <tbody>
										<c:forEach items="${proArcList }" var="pAList">
											<tr>
												<td>${pAList.RNUM }</td>
												<td>${pAList.PRO_ARC_PROID }</td>
												<td>
													<c:forEach begin="1" end="${pAList.PRO_ARC_DEP }" varStatus="stat">
              										&nbsp;&nbsp;
              											<c:if test="${stat.last }">
															<img src="${pageContext.request.contextPath }/image/ico_reply.gif" alt="reply">
														</c:if>
													</c:forEach> ${pAList.PRO_ARC_TITLE }
												</td>
												<td>${pAList.EMP_NAME }</td>
												<td><fmt:formatDate value="${pAList.PRO_ARC_REGDATE }"/></td>
												<td>${pAList.PRO_ARC_DOWNHIT }</td>
											</tr>
						                </c:forEach>
						                </tbody>
									</table>
<!-- 프로젝트 자료실 테이블 끝 -->
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- ScheInsert modal -->
		<div id="insertScheDialog-form" title="일정 생성">
			<form id="insertSche-form" method="post" action="${pageContext.request.contextPath}/schedule/insertSchedule.do">
			    <table>
			    	<tr>
			    		<td>일정 이름</td>
			    		<td>
			    			<input type="text" id="sche_name" name="sche_name" style="margin:0px 0px 10px 20px;">
			    		</td>
			    	</tr>
			    	<tr>
			    		<td>시작일</td>
			    		<td>
			    			<input type="date" id="sche_startdate" name="sche_startdate" style="margin:0px 0px 10px 20px;">
			    		</td>
			    	</tr>
			    	<tr>
			    		<td>종료일</td>
			    		<td>
			    			<input type="date" id="sche_enddate" name="sche_enddate" style="margin:0px 0px 10px 20px;">
			    		</td>
			    	</tr>
			    	<tr>
			    		<td>팀원</td>
			    		<td class="memselectbox">
			    			<select class="js-example-basic-single" id="sche_emp" name="sche_emp" style="margin:0px 0px 10px 20px;">
								<option value="emp" selected="selected" disabled="disabled">사원명</option>
								<c:forEach items="${proMem}" var="proMem" begin="0">
									<option value="${proMem.MEM_EMP}">${proMem.EMP_NAME}(${proMem.MEM_ROLE})</option>
								</c:forEach>
							</select>
			    		</td>
		    		</tr>
			    	<tr>
			    		<td>일정 내용</td>
			    		<td>
			    			<input type="text" id="sche_cont" name="sche_cont" style="margin:0px 0px 10px 20px;">
			    		</td>
			    	</tr>
			    </table>
				<div id="result"></div>
			    <input type="hidden" id="sche_proid" name="sche_proid" value="${proID }">
				<input id="insertSchedule" type="submit">
			</form>
		</div>
		
		<!-- ScheView modal -->
		<div id="ScheViewDialog-form" title="일정 정보">
			<form id="scheView-form" method="post" action="${pageContext.request.contextPath}/schedule/updateSchedule.do">
			    <table>
			    	<tr>
			    		<td>일정 이름</td>
			    		<td>
			    			<input type="text" id="sche_nameInfo" name="sche_name" style="margin:0px 0px 10px 20px;">
			    		</td>
			    	</tr>
			    	<tr>
			    		<td>시작일</td>
			    		<td>
			    			<input type="date" id="sche_startdateInfo" name="sche_startdate" style="margin:0px 0px 10px 20px;">
			    		</td>
			    	</tr>
			    	<tr>
			    		<td>종료일</td>
			    		<td>
			    			<input type="date" id="sche_enddateInfo" name="sche_enddate" style="margin:0px 0px 10px 20px;">
			    		</td>
			    	</tr>
			    	<tr>
			    		<td>담당팀원</td>
			    		<td class="memselectbox">
			    			<input type="text" id="sche_empInfo" disabled="disabled">
			    			<input type="text" name="sche_empInfo">
			    		</td>
		    		</tr>
			    	<tr>
			    		<td>변경팀원</td>
			    		<td class="memselectbox" id="changeMem">
			    			<select class="js-example-basic-single" id="sche_emp" name="sche_emp" style="margin:0px 0px 10px 20px;">
								<option value="emp" selected="selected" disabled="disabled">사원명</option>
								<c:forEach items="${proMem}" var="proMem" begin="0">
									<option value="${proMem.MEM_EMP}">${proMem.EMP_NAME}(${proMem.MEM_ROLE})</option>
								</c:forEach>
							</select>
			    		</td>
		    		</tr>
			    	<tr>
			    		<td>일정 내용</td>
			    		<td>
			    			<input type="text" id="sche_contInfo" name="sche_cont" style="margin:0px 0px 10px 20px;">
			    		</td>
			    	</tr>
			    </table>
			    <input type="hidden" id="sche_proid" name="sche_proid" value="${proID }">
			    <input type="hidden" id="sche_seq" name="sche_seq">
				<input type="submit" id="updateSchedule" >
			</form>
		</div>
		<!-- 사이드 바 -->
	<aside class="control-sidebar control-sidebar-dark">
    <!-- Create the tabs -->
    <ul class="nav">
		<li><a href="http://localhost/"><span>Home</span></a></li>
		<li><a href="#sec0"><span>프로젝트 일정</span></a></li>
		<li><a href="${pageContext.request.contextPath }/approval/selectForm.do?pro_id=${proID }"><span>전자결재</span></a></li>
		<li><a href="${pageContext.request.contextPath }/projectBoard/proBoList.do?pro_id=${proID }"><span>프로젝트 게시판</span></a></li>
		<li><a href="${pageContext.request.contextPath }/projectArchive/proArcList.do?pro_id=${proID }"><span>프로젝트 자료실</span></a></li>
		<li><a href="${pageContext.request.contextPath }/proWorkRate/proWorkRateList.do?emp_num=${LOGIN_EMPINFO.emp_num}"><span>팀원 평가</span></a></li>
    </ul>
    <!-- Tab panes -->
    </div>

	<form action="${pageContext.request.contextPath }/schedule/deleteSchedule.do" method="post" id="deleteSche-form">
		<input type="hidden" id="deleteSche_seq" name="sche_seq">
		<input type="hidden" id="proID" name="proID" value="${proID }">
		<input id="deleteSchedule" type="submit">
	</form>
</body>
</html>