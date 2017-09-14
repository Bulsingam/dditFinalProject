<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/css/select2.min.css"
	rel="stylesheet" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/js/select2.min.js"></script>
<title>Insert title here</title>
<script>
  $(function () {
	// modal에 select2 사용할때 버그 잡기
	
		if ($.ui && $.ui.dialog && $.ui.dialog.prototype._allowInteraction) {
		    var ui_dialog_interaction = $.ui.dialog.prototype._allowInteraction;
		    $.ui.dialog.prototype._allowInteraction = function(e) {
		        if ($(e.target).closest('.select2-dropdown').length) return true;
		        return ui_dialog_interaction.apply(this, arguments);
		    };
		}
		$(".js-example-basic-single").select2({
			allowClear: true
		});
		
		var date = new Date();
		var d = date.getDate();
		var m = date.getMonth();
		var y = date.getFullYear();
		
		// 일정 등록 수정 삭제를 위한 모달들 
		$('#insertSchedule').hide();
		$('#deleteSchedule').hide();
		$('#updateSchedule').hide();
		$('#insertScheDialog-form').hide();
		$('#ScheViewDialog-form').hide();
		
		// 삭제버튼을 눌렀을때 삭제하는 버튼
		$('#deleteSchedule').click(function(){
			var $frm = $('<form action ="${pageContext.request.contextPath}/personalSchedule/deletePersonalSchedule.do" method="post"></form>');
			var sche_emp = ${LOGIN_EMPINFO.emp_num};
			var sche_num = $('#sche_numInfo').val();
			$frm.append('<input type="hidden" name="sche_emp" value="'+sche_emp+'">');
			$frm.append('<input type="hidden" name="sche_num" value="'+sche_num+'">');
			$('body').append($frm);
			$frm.submit();
		});
		
		
		// 오른쪽 프로젝트 일정을 출력하기 위해 필요한 초기 설정
		$('#calendarParent').hide();
// 		$('#tab_2').hide();
// 		$('#tab_2Click').click(function(){
// 			$('#calendarx').remove();
// 			$('#tab_2').show();
// 		})
		
		
		//사원 일정 등록 수정 삭제를 위해 일정을 출력하고 모달로 등록 수정 삭제를 하는 ajax
		$.ajax({
			type: "POST",
			url : "${pageContext.request.contextPath}/personalSchedule/loadingPersonalSchedule.do",
			data: {"emp_num" : "${LOGIN_EMPINFO.emp_num}"},
			dataType:"json",
			error: function(request, status, error){
				alert("일정을 읽어오지 못했습니다.\ncode : " + request.status + "\r\nmessage : " + request.reponseText);
			},
			success: function(data){
				createList();
				
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
						// prompt로 event의 title을 작성(이부분을 prompt로 입력하지 말고 modal창을 띄우면 추가 방식의 변경도 가능할것)
						$('#insertScheDialog-form').dialog({
							height : 400,
							width : 350,
							modal : true,
							buttons : {
								"생성" : function(){
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
						
						$('#sche_startdate').val(convertDate(start));
						$('#sche_enddate').val(convertDate(end));
						$('#sche_num').val(convertDate(sche_num));
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
									$('#updateSchedule').click();
									$(this).dialog('close');
									$(this).find('form')[0].reset();
								},
								"삭제" : function(){
									$('#deleteSchedule').val(calEvent.id);
									$('#deleteSchedule').click();
								    // removeEvents = 이벤트 삭제, calEvent._id = 해당 이벤트의 id 를 가지고 삭제
									
									$('#calendar').fullCalendar('removeEvents', calEvent.id);
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
						
						$('#sche_numInfo').val(calEvent.id);
						$('#sche_nameInfo').val(calEvent.title);
						$('#sche_startdateInfo').val(convertDate(convertDate(calEvent.start)));
						$('#sche_enddateInfo').val(convertDate(convertDate(calEvent.end)));
						
							
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
	  
		
  });
  
 // createList는 프로젝트 일정들을 list에 뿌리게 하기 위해 필요한 function
 function createList(){
	 $.ajax({
			type: "POST",
			url : "${pageContext.request.contextPath}/personalSchedule/loadingProjectList.do",
			data: {"emp_num" : "${LOGIN_EMPINFO.emp_num}"},
			dataType:"json",
			error: function(request, status, error){
				alert(" 프로젝트 일정을 읽어오지 못했습니다.\ncode : " + request.status + "\r\nmessage : " + request.reponseText);
			},
			success: function(data){
				// 캘린더 생성
				var list="";
				$.each(data.proList,function(i){
					list += "<li role = 'presentation' name = 'proListMenu'><a role='menuitem' tabindex='0' value='"+data.proList[i].MEM_PROID+ "'>"+data.proList[i].PRO_NAME+"</a></li>"
				})
				$('#drop_menu').append(list);
				
				// list를 클릭했을때 projectID 를 가지고 프로젝트 일정을 출력하는 기능
				$('li[name=proListMenu]').bind('click',function(){
					var index = $(this).index();
					var proID = $('li[name=proListMenu]:eq('+index+') a').attr('value');
					 
					  proSche(proID);
				});
			}
		  
	  });
 }
 // ajax를 이용하여 project일정을 출력하는 메서드 
 function proSche(proID){

	 //ajax 중복요청왔을때 계속 ajax success 코드가 실행되는 것을 방지하기 위해 마지막 요청 카운트 저장. 전역변수 //ajax 요청 시작하기 전에. ajax 요청이 들어있는 함수내의 지역변수 
	var ajax_last_num = 0;
	//ajax 중복요청왔을때 계속 ajax success 코드가 실행되는 것을 방지하기 위해 지금 들어온 요청의 카운트 저장
	var current_ajax_num = ajax_last_num; 
	
	$('#calendarParent').show();

	 $.ajax({
			type: "POST",
			url : "${pageContext.request.contextPath}/schedule/loadingSchedule.do",
			data: {"proID" : proID},
			dataType:"json",
			error: function(request, status, error){
				alert(" 프로젝트 일정을 읽어오지 못했습니다.\ncode : " + request.status + "\r\nmessage : " + request.reponseText);
			},
			beforeSend:function(request){ ajax_last_num = ajax_last_num + 1
				 $('#calendarx').remove();
			},//전체 요청의 마지막 count 를 +1 //요청보내기전에 실행되야할 코드 적으면 됨(예를들어 loading...) },

			success: function(data){
				if(current_ajax_num == ajax_last_num - 1){ 
					var calendarx="";
					calendarx += "<div id='calendarx' class='fc fc-unthemed fc-ltr' style='padding:10px;''></div>";
					$('#calendarParent').append(calendarx);
	
				var calendar = $('#calendarx').fullCalendar({
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
					selectable: false,
					// 사용자가 드래그를 하는 동안 그 자리를 표시하는가에 대한 이벤트??
					selectHelper: false,
					// select 이벤트 생성(event 시작, event 종료, )
					events: data.schedule
				});
				}
		  }
	  });
 }
</script>
<style type="text/css">
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

.memselectbox {
	padding-left: 20px;
	padding-bottom: 10px;
}
</style>
</head>
<body >
	<div class="row" style="padding:10px;">
		<div class="col-md-6">
			<div class="box box-primary">
					<ul class="nav nav-tabs " style="width: 98%; padding:4px;">
						 <li><a data-toggle="tab">개인일정</a></li>
					</ul>
<!-- 				<h4 style="text-align:center; padding : 0px;">개인일정</h4> -->
				<div class="box-body no-padding">
					<div id="calendar" class="fc fc-unthemed fc-ltr" style="padding: 10px;"></div>
				</div>
			</div>
		</div>
		<div id="insertScheDialog-form" title="일정 생성">
			<form method="post"
				action="${pageContext.request.contextPath}/personalSchedule/insertPersonalSchedule.do">
				<table>
					<tr>
						<td>일정 제목</td>
						<td><input type="text" id="sche_name" name="sche_name"
							style="margin: 0px 0px 10px 20px;"></td>
					</tr>
					<tr>
						<td>시작일</td>
						<td><input type="date" id="sche_startdate"
							name="sche_startdate" style="margin: 0px 0px 10px 20px;">
						</td>
					</tr>
					<tr>
						<td>종료일</td>
						<td><input type="date" id="sche_enddate" name="sche_enddate"
							style="margin: 0px 0px 10px 20px;"></td>
					</tr>
				</table>
				<input type="hidden" name="sche_emp"
					value="${LOGIN_EMPINFO.emp_num }">
				<div id="result"></div>
				<input id="insertSchedule" type="submit">
			</form>
		</div>

		<!-- ScheView modal -->
		<div id="ScheViewDialog-form" title="일정 정보">
			<form method="post"
				action="${pageContext.request.contextPath}/personalSchedule/updatePersonalSchedule.do">
				<table>
					<tr>
						<td>일정 제목</td>
						<td><input type="text" id="sche_nameInfo" name="sche_name"
							style="margin: 0px 0px 10px 20px;"></td>
					</tr>
					<tr>
						<td>시작일</td>
						<td><input type="date" id="sche_startdateInfo"
							name="sche_startdate" style="margin: 0px 0px 10px 20px;">
						</td>
					</tr>
					<tr>
						<td>종료일</td>
						<td><input type="date" id="sche_enddateInfo"
							name="sche_enddate" style="margin: 0px 0px 10px 20px;"></td>
					</tr>
				</table>
				<div id="result"></div>
				<input type="hidden" id="sche_numInfo" name="sche_num"> <input
					type="hidden" name="sche_emp" value="${LOGIN_EMPINFO.emp_num }">
				<input id="updateSchedule" type="submit"> <input
					id="deleteSchedule" type="button">
			</form>
		</div>

		<!-- /.col -->

		<div class="row">
			<div class="col-md-6">
				<!-- Custom Tabs -->
				<div class="box">
				<div class="box-primary">
					<div class="nav-tabs-custom " style="width: 98%;">
						<ul class="nav nav-tabs " style="width: 98%; padding:4px;">
							<li class="dropdown "><a class="dropdown-toggle"
								data-toggle="dropdown" href="#" aria-expanded="true"> 프로젝트
									일정보기 <span class="caret"></span>
							</a>
								<!-- list가 li로 들어갈 부분  -->
								<ul class="dropdown-menu" id="drop_menu">
								</ul>
							</li>
						</ul>
						<div  id="calendarParent">
							<div id="calendarx" class="fc fc-unthemed fc-ltr"
								style="padding: 10px; margin:5px;"></div>
						</div>
					</div>
				</div>
			</div>
			</div>
		</div>
	</div>
	</div>
</body>
</html>