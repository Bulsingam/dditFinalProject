<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
$(function(){
	// FullCalendar
	$(document).ready(function(){
		var date = new Date();
		var d = date.getDate();
		var m = date.getMonth();
		var y = date.getFullYear();
		
		/*
			Event Object 목록(몇가지는 해석이 안되서 ㅈㅅ)
			id					: 문자열/정수를 사용한 고유 id 반복 이벤트의 모든 인스턴스는 모두 동일해야함.
			title				: 이벤트 요소의 텍스트 (필수입력 사항)
			allDay              : true/false 선택 이벤트의 시간이 표시될지에 대한 여부(allDay는 하루종일)
								  default는 기본적으로 지정되어있지 않다.
			start               : 이벤트의 시작 날짜/시간 (필수입력 사항)
			end                 : 이벤트의 종료가 되는 날짜/시간(이벤트의 마지막 하루가 목요일까지인 경우 이벤트의 종료는 금요일 00:00:00)
			url                 : 클릭시에 찾아갈 url 입력
			className           : 문자열/배열 HTML의 태그에 사용되는 class와 같다.
			editable            : 편집 가능/불가능(true/false)
			startEditable       : true/false 단일 이벤트에 대한 eventStartEditable옵션을 대체한다. 
			durationEditable    : true/false 단일 이벤트에 대한 eventDurationEditable 옵션을 대체한다.
			resourceEditable    : true/false 단일 이벤트에 대한 eventResourceEditable 옵션을 대체한다.
			rendering	        : 배경 이벤트와 같은 이벤트의 대체 렌더링을 허용한다.(background가 비어있거나 inverse-background)
			overlap             : true/false 드래그되는 이벤트를 방지 또는 다른 이벤트를 통해 크기를 조정. 이 이벤트를 통하여 다른 이벤트가 드래그/크기조정 되는것을 방지
			constraint          : 
			source              : 이벤트 소스가 자동으로 채워진다.
			color               : 캘린더의 eventColor옵션과 마찬가지로 이벤트의 배경색과 테두리 색상 지정
			backgroundColor     : 달력 전체의 배경색을 설정
			borderColor         : 달력 전체의 테두리 색상을 설정
			textColor           : 달력 전체의 event 텍스트의 색상 설정
			
			left: 'prev,next today'에서 좌, 우 버튼을 클릭했을 경우(참고해서 일자 클릭시에 값을 받아올수도 있다.)
	            왼쪽 버튼을 클릭하였을 경우의 이벤트를 주는 방법
	        $("button.fc-prev-button").click(function() {
	            var date = $("#calendar").fullCalendar("getDate");
	            convertDate(date);
	        });

	            오른쪽 버튼을 클릭하였을 경우의 이벤트를 주는 방법
	        $("button.fc-next-button").click(function() {
	            var date = $("#calendar").fullCalendar("getDate");
	            convertDate(date);
	        });
	            
			받은 날짜값을 date 형태로 형변환 해주어야 한다.
			function convertDate(date) {
			    var date = new Date(date);
			    alert(date.yyyymmdd());
			}
			
			받은 날짜값을 YYYY-MM-DD 형태로 출력하기위한 함수.
			Date.prototype.yyyymmdd = function() {
			    var yyyy = this.getFullYear().toString();
			    var mm = (this.getMonth() + 1).toString();
			    var dd = this.getDate().toString();
			    return yyyy + "-" + (mm[1] ? mm : "0" + mm[0]) + "-" + (dd[1] ? dd : "0" + dd[0]);
			}
		*/
		
		// 캘린더 생성
		var proCalendar = $('#projectID').fullCalendar({
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
				var title = prompt('일정을 입력하세요.');
				if(title){
					// event 생성 title이라는 변수가 생성되었을 경우 event를 만들어준다.
					calendar.fullCalendar('renderEvent',
						{
							title: title,
							start: start,
							end: end,
							allDay: allDay
						},
						true
					);
				}
				calendar.fullCalendar('unselect');
			},
			// Click에 대한 이벤트
			eventClick: function(calEvent, jsEvent, view) {
		        // 이건 단순히 css를 주는 역할
		        $(this).css('border-color', 'red');
		        // removeEvents = 이벤트 삭제, calEvent._id = 해당 이벤트의 id 를 가지고 삭제
		        $('#calendar').fullCalendar('removeEvents', calEvent._id);
		    },
		    // 캘린터의 이벤트 수정 여부를 결정
			editable: true,
			// event들은 json 배열 형식으로 저장한다. (초기값 설정이라고 볼 수 있다.)
			events: [
				{	
					// event의 title
					title: '01 All Day Event',
					// start: new Date(년, 월, 1일)
					// end가 없다면 당일만 event로 지정된다.
					start: new Date(y, m, 1)
				},
				{
					// event의 title
					title: '02 Long Event',
					// event가 시작되는 일자 
					// y = year, m = month, d = today(숫자로만 지정할 경우 그 달의 그 일을 지정)
					// start: new Date(년, 월, today-5일),
					// end: new Date(년, 월, today-2일)
					start: new Date(y, m, d-5),
					end: new Date(y, m, d-2)
				}
			]
		});
			
		var priCalendar = $('#privateCalendar').fullCalendar({
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
				var title = prompt('일정을 입력하세요.');
				if(title){
					// event 생성 title이라는 변수가 생성되었을 경우 event를 만들어준다.
					calendar.fullCalendar('renderEvent',
						{
							title: title,
							start: start,
							end: end,
							allDay: allDay
						},
						true
					);
				}
				calendar.fullCalendar('unselect');
			},
			// Click에 대한 이벤트
			eventClick: function(calEvent, jsEvent, view) {
		        // 이건 단순히 css를 주는 역할
		        $(this).css('border-color', 'red');
		        // removeEvents = 이벤트 삭제, calEvent._id = 해당 이벤트의 id 를 가지고 삭제
		        $('#calendar').fullCalendar('removeEvents', calEvent._id);
		    },
		    // 캘린터의 이벤트 수정 여부를 결정
			editable: true,
			// event들은 json 배열 형식으로 저장한다. (초기값 설정이라고 볼 수 있다.)
			events: [
				{	
					// event의 title
					title: '01 All Day Event',
					// start: new Date(년, 월, 1일)
					// end가 없다면 당일만 event로 지정된다.
					start: new Date(y, m, 1)
				},
				{
					// event의 title
					title: '02 Long Event',
					// event가 시작되는 일자 
					// y = year, m = month, d = today(숫자로만 지정할 경우 그 달의 그 일을 지정)
					// start: new Date(년, 월, today-5일),
					// end: new Date(년, 월, today-2일)
					start: new Date(y, m, d-5),
					end: new Date(y, m, d-2)
				}
			]
		});
		// 월 변경 버튼 클릭시 해당 월/일의 값을 받아오는 event
// 		$("button.fc-prev-button").click(function() {
//             var date = $("#calendar").fullCalendar("getDate");
//             convertDate(date);
//         });
// 		$("button.fc-next-button").click(function() {
//             var date = $("#calendar").fullCalendar("getDate");
//             convertDate(date);
//         });
		
		// 받은 날짜값을 date 형태로 형변환 해주어야 한다.
		function convertDate(date) {
		    var date = new Date(date);
		    alert(date.yyyymmdd());
		}
		
		// 받은 날짜값을 YYYY-MM-DD 형태로 출력하기위한 함수.
		Date.prototype.yyyymmdd = function() {
		    var yyyy = this.getFullYear().toString();
		    var mm = (this.getMonth() + 1).toString();
		    var dd = this.getDate().toString();
		    return yyyy + "-" + (mm[1] ? mm : "0" + mm[0]) + "-" + (dd[1] ? dd : "0" + dd[0]);
		}
		
		
	});
});
</script>
<style type="text/css">
	#privateCalendar{
		width: 650px;
		margin: 0 auto;
	}
	#proList{
		width: 100%;
		margin: auto;
	}
</style>
</head>
<body>
	<div class="col-md-5">
		<label>개인일정</label>
		<div id="privateCalendar"></div>
	</div>
	<div class="col-md-6">
		<label>프로젝트 목록</label>

		
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
				<table id="example1" class="table table-bordered table-striped dataTable" role="grid" aria-describedby="example1_info">
					<thead>
						<tr role="row">
							<th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Rendering engine: activate to sort column ascending" style="width: 5%;">No</th>
							<th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Browser: activate to sort column ascending" style="width: 45%;">프로젝트명</th>
							<th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Platform(s): activate to sort column ascending" style="width: 10%;">팀장</th>
							<th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Platform(s): activate to sort column ascending" style="width: 10%;">투입인원</th>
							<th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Engine version: activate to sort column ascending" style="width: 10%;">시작일</th>
							<th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending" style="width: 10%;">종료일</th>
						</tr>
					</thead>
					<tbody>
					    <tr>
					    	<td class="">0</td>
							<td class="sorting_1">제목</td>
							<td>GD</td>
							<td>5</td>
							<td>2017.08.25</td>
							<td>2017.09.25</td>
					    </tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	
	<!-- 사이드 바 -->
	<aside class="control-sidebar control-sidebar-dark">
    <!-- Create the tabs -->
    <ul class="nav">
      <li><a href="http://localhost/"><span>Home</span></a></li>
		       <li><a href="#sec0"><span>프로젝트 일정</span></a></li>
		       <li><a href="#sec1"><span>전자결재</span></a></li>
		       <li><a href="#sec2"><span>프로젝트 게시판</span></a></li>
		       <li><a href="#sec3"><span>프로젝트 자료실</span></a></li>
		       <li><a href="#sec4"><span>팀원 평가</span></a></li>
    </ul>
    <!-- Tab panes -->
    </div>
  </aside>
	
</body>
</html>