<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
	$(function(){
		// leftEmpProList 
		// Left바 사원이 진행하고 있는 프로젝트 리스트 띄우기
		$.ajax({
				url			:	"${pageContext.request.contextPath}/join/employeeProjectList.do"
				, type		:	"post"
				, data		:	{ "emp_num" : ${LOGIN_EMPINFO.emp_num} }
				, dataType	:	"json"
				, success	:	function(result){
									var liList = "";
									$.each(result.empProList,function(i){
										liList += "<li class='proID'><a href='${pageContext.request.contextPath}/project/projectScheduleView.do?pickProjectID="+result.empProList[i].PRO_ID+"&pickProjectPlID="+result.empProList[i].MEM_EMP+"'>" +result.empProList[i].PRO_NAME+ "</a></li>"
									})
									$('#leftEmpProList').append(liList);
								},
								error : function(xhr){
									alert("상태 : " +xhr.status);
								}
		});
		

		//left바 사원이 진행중인 해당 프로젝트 클릭시 프로젝트 상세 화면으로 이동
// 		$('.prodID').on('click',function(){
// 			alert('a');
// 			var pickProjectID = $(this).find('input').val();
// 			var $frm = $('<form action="${pageContext.request.contextPath}/pro/proScheView.do" method="post"></form>');
// 			$frm.append('<input name="pickProjectID" value="'+pickProjectID+'">');
// 			$frm.appendTo('body');
// 			$frm.submit();
// 		})	
		
		
		$('a[name="myPage"]').on('click',function(){
			var $frm = $('<form action="${pageContext.request.contextPath}/employee/updateEmployeeView.do" method="post"></form>');
			$frm.append('<input name="emp_num" value="${LOGIN_EMPINFO.emp_num}">');
			$frm.appendTo('body');
			$frm.submit();
		})	
		$('#personalSchedule').on('click',function(){
			var $frm = $('<form action="${pageContext.request.contextPath}/personalSchedule/personalScheduleView.do" method="post"></form>');
			$frm.append('<input name="emp_num" value="${LOGIN_EMPINFO.emp_num}">');
			$frm.appendTo('body');
			$frm.submit();
		})	
			
		if('${requestURISprit}' == "anonymousBoard"){
			$('#anonymousBoard').attr('class','active');
		}else if('${requestURISprit}' == "approval" || '${requestURISprit}' == "document"){
			$('#approval').attr('class','active');
		}else if('${requestURISprit}'  == "archive"){
			$('#archive').attr('class','active');
		}else if('${requestURISprit}'  == "companyBoard"){
			$('#companyBoard').attr('class','active');
		}else if('${requestURISprit}'  == "employee"){
			if('${requestURINecessity}' == "sms"){
				$('#sms').attr('class','active')
			}else if('${requestURINecessity}' == "updateEmployeeView"){
				$('#myPageLi').attr('class','active')
			}else if('${requestURINecessity}' == "employeeList"){
				$('#proWorkRate').attr('class','active')
			}else{
				$('#employee').attr('class','active')
			}
		}else if('${requestURISprit}'  == "humanResource" || '${requestURISprit}'  == "proWorkRate"){
			$('#proWorkRate').attr('class','active');
		}else if('${requestURISprit}'  == "join"){
			$('#join').attr('class','active');
		}else if('${requestURISprit}'  == "noticeBoard"){
			$('#noticeBoard').attr('class','active');
		}else if('${requestURISprit}'  == "personalSchedule"){
			$('#personalSchedule').attr('class','active');
		}else if('${requestURISprit}'  == "project"){
			$('#project').attr('class','active');
		}else if('${requestURISprit}'  == "projectArchive"){
			$('#projectArchive').attr('class','active');
		}else if('${requestURISprit}'  == "projectBoard"){
			$('#projectBoard').attr('class','active');
		}else if('${requestURISprit}'  == "schedule"){
			$('#schedule').attr('class','active');
		}

		//
		//	DetectRTC
		//
		var recognition = new webkitSpeechRecognition();
		var finalTranscript = '';
		var two_line = /\n\n/g;
		var one_line = /\n/g;
		var first_char = /\S/;
		
		$('#hello').mousedown(function(event){
			recognition.lang = 'ko-KR';
			recognition.start();
			ignoreOnend = false;
	 	        
			recognition.onresult = function(event) {
				console.log('onresult', event);
				
				var interimTranscript = '';

				for (var i = event.resultIndex; i < event.results.length; ++i) {
					if (event.results[i].isFinal) {
						finalTranscript += event.results[i][0].transcript;
					} else {
						interimTranscript += event.results[i][0].transcript;
					}
				}

				finalTranscript = capitalize(finalTranscript);
				command(finalTranscript);
			}
	 	        
			function capitalize(s) {
				return s.replace(first_char, function(m) {
							return m.toUpperCase();
						});
			}
			
			function command(message){
				switch(message){
				case "진행함" : 
					$(location).attr('href', '${pageContext.request.contextPath}/document/progressFolder.do');
					break;		
				case "발신함" : 
					$(location).attr('href', '${pageContext.request.contextPath}/document/sendFolder.do');
					break;
				case "수신함" : 
					$(location).attr('href', '${pageContext.request.contextPath}/document/receiveFolder.do');
					break;
				case "승인함" : 
					$(location).attr('href', '${pageContext.request.contextPath}/document/confirmFolder.do');
					break;
				case "반려함" : 
					$(location).attr('href', '${pageContext.request.contextPath}/document/refuseFolder.do');
					break;
				case "노래 켜" :
					document.getElementById('audio').play();
					break;
				case "노래 꺼" :
					document.getElementById('audio').pause();
					break;
				default : 
					alert(message);
					break;
				}
			}
			
		})
		
		$('#hello').mouseup(function(){
			finalTranscript = '';
			recognition.stop();
		})
		
		// DetectRTC 끝
	})
</script>
</head>
<body>
	<!-- 관리자 사이드바 -->
	<c:set var="name" value="${LOGIN_EMPINFO.emp_num }" />
	<c:if test="${name eq '201703000'}">
		<div class="user-panel">
			<div class="pull-left image">
				<img id="userImg" src="${pageContext.request.contextPath }/2jo/Employee/img/${LOGIN_EMPINFO.emp_img}" class="img-circle">
			</div>
			<div class="pull-left info">
				<p>
					<span id="userName">${LOGIN_EMPINFO.emp_name}</span>
				</p>
				<!-- Status -->
				<a href="#"><i class="fa fa-circle text-success"></i> Online</a>
			</div>
		</div>		
		<!-- DetectRTC -->
		<button class="btn btn-block btn-primary" id="hello"><i class="fa fa-fw fa-microphone"></i></button>
		<!-- DetectRTC -->
		<ul class="sidebar-menu">
			<li class="header">관리자 메뉴</li>

			<li id="noticeBoard"><a href="${pageContext.request.contextPath }/noticeBoard/notiList.do">
					<i class="fa fa-list"></i> <span>공지사항</span>
			</a></li>

			<li id="companyBoard"><a href="${pageContext.request.contextPath }/companyBoard/comList.do">
					<i class="fa fa-list"></i> <span>사내게시판</span>
			</a></li>

			<li id="anonymousBoard"><a href="${pageContext.request.contextPath }/anonymousBoard/getAnyBoList.do">
					<i class="fa fa-list"></i> <span>익명게시판</span>
			</a></li>

			<li id="archive"><a href="${pageContext.request.contextPath }/archive/getArcList.do">
					<i class="fa fa-save"></i> <span>자료실</span>
			</a></li>

			<li id="project" class="treeview "><a href="#"><i class="fa fa-book"></i>
					<span>프로젝트</span> <span class="pull-right-container"> <i
						class="fa fa-angle-left pull-right"></i>
				</span> </a>
				<ul class="treeview-menu">
					<li><a href="${pageContext.request.contextPath }/project/projectList.do">프로젝트
							리스트</a></li>
					<li id="projectBoard"><a href="#">프로젝트 게시판</a></li>
					<li id="projectArchive"><a href="#">프로젝트 자료실</a></li>
				</ul></li>

			<li id="proWorkRate" class="treeview ">
				<a href="#"><i class="fa fa-users"></i>
					<span>인사/근태관리</span> <span class="pull-right-container"> <i class="fa fa-angle-left pull-right"></i>
					</span> 
				</a>
				<ul class="treeview-menu">
					<li><a href="${pageContext.request.contextPath }/humanResource/employeeAttendanceList.do">사원
							근태조회</a></li>
					<li class="treeview"><a href="#"><i class="fa fa-users"></i>
							<span>사원관리</span> <span class="pull-right-container"> <i class="fa fa-angle-left pull-right"></i>
						</span> </a>
						<ul class="treeview-menu">
							<li><a href="${pageContext.request.contextPath }/humanResource/insertEmployeeView.do">사원 등록</a></li>
							<li><a href="${pageContext.request.contextPath }/humanResource/deleteEmployeeView.do">사원삭제</a></li>
							<li><a href="${pageContext.request.contextPath}/employee/employeeList.do"><span>사원 조회 및 수정</span></a></li>
						</ul></li>
				</ul></li>

			<li class="treeview"  id="approval"><a href="#"><i class="fa fa-file-text-o"></i> <span>전자결재</span> 
					<span class="pull-right-container">
					<i class="fa fa-angle-left pull-right"></i>
				</span> </a>
				<ul class="treeview-menu">
					<li><a href="${pageContext.request.contextPath }/document/progressFolder.do">진행함</a></li>
            		<li><a href="${pageContext.request.contextPath }/document/confirmFolder.do">승인함</a></li>
           			<li><a href="${pageContext.request.contextPath }/document/refuseFolder.do">반려함</a></li>
            		<li><a href="${pageContext.request.contextPath }/approval/formList.do">서식열람</a></li>
				</ul>
			</li>
		</ul>
	</c:if>
	
	
	<!--  사원의 사이드바  -->

	<c:if test="${name ne '201703000'}">
		<div class="user-panel">
			<div class="pull-left image">
				<img id="userImg" src="${pageContext.request.contextPath }/2jo/Employee/img/${LOGIN_EMPINFO.emp_img}" class="img-circle">
			</div>
			<div class="pull-left info">
				<p>
					<span id="userName">${LOGIN_EMPINFO.emp_name}</span>
				</p>
				<!-- Status -->
				<a href="#"><i class="fa fa-circle text-success"></i> Online</a>
			</div>
		</div>
		<!-- DetectRTC -->
		<button class="btn btn-block btn-primary" id="hello"><i class="fa fa-fw fa-microphone"></i></button>
		<!-- DetectRTC -->
		<!-- Sidebar Menu -->
		<ul class="sidebar-menu">
			<li class="header">메뉴</li>
			<!-- Optionally, you can add icons to the links -->

			<li id="myPageLi"><a name="myPage"> <i class="fa fa-user"></i> <span>MyPage</span></a></li>

			<li id="employee"><a href="${pageContext.request.contextPath}/employee/employeeList.do"> <i class="fa fa-users"></i> 
					<span>사원정보</span> 
				</a>
			</li>

			<li id="personalSchedule"><a href="#"> <i class="fa fa-calendar"></i>
				<span>개인일정</span>
				</a>
			</li>

			<li id="noticeBoard"><a href="${pageContext.request.contextPath }/noticeBoard/notiList.do">
				<i class="fa fa-list"></i> <span>공지사항</span>
				</a>
			</li>

			<li id="humanResource"><a href="${pageContext.request.contextPath }/companyBoard/comList.do">
				<i class="fa fa-list"></i> <span>사내게시판</span>
				</a>
			</li>

			<li id="anonymousBoard"><a href="${pageContext.request.contextPath }/anonymousBoard/getAnyBoList.do">
				<i class="fa fa-list"></i> <span>익명게시판</span>
				</a>
			</li>

			<li id="archive"><a href="${pageContext.request.contextPath }/archive/getArcList.do">
					<i class="fa fa-save"></i> <span>자료실</span>
				</a>
			</li>

			<li  id="humanResource" class="treeview"><a href="#"><i class="fa fa-book"></i>
				<span>프로젝트</span> <span class="pull-right-container"> 
				<i class="fa fa-angle-left pull-right"></i>
				</span> </a>
				<ul class="treeview-menu" id="leftEmpProList">
					<li ><a href="${pageContext.request.contextPath }/proWorkRate/proWorkRateList.do?emp_num=${LOGIN_EMPINFO.emp_num}">
						<i class="fa fa-pencil-square-o"></i> <span>팀원평가</span></a>
					</li>
				</ul>
			</li>

			<li  id="approval" class="treeview"><a href="#"><i
					class="fa fa-file-text-o"></i> <span>전자결재</span> <span
					class="pull-right-container"> <i
						class="fa fa-angle-left pull-right"></i>
				</span> </a>
				<ul class="treeview-menu">
					<li><a href="${pageContext.request.contextPath }/approval/selectForm.do">전자결재신청</a></li>
					<li><a href="${pageContext.request.contextPath }/document/sendFolder.do">발신함</a></li>
					<li><a href="${pageContext.request.contextPath }/document/receiveFolder.do">수신함</a></li>
					<li><a href="${pageContext.request.contextPath }/document/progressFolder.do">진행함</a></li>
					<li><a href="${pageContext.request.contextPath }/document/confirmFolder.do">승인함</a></li>
					<li><a href="${pageContext.request.contextPath }/document/refuseFolder.do">반려함</a></li>
				</ul>
			</li>

		</ul>
	</c:if>
	<ul class="sidebar-menu">
		<li id="sms"><a href="${pageContext.request.contextPath}/employee/sms.do">
				<i class="fa fa-commenting-o"></i> <span>문자메세지 보내기</span>
		</a></li>
	</ul>
	<!-- DetectRTC -->
	<audio id="audio" src="${pageContext.request.contextPath }/2jo/Music/GiveItUp.mp3" preload="auto" type="audio/mp3"></audio>
	<!-- DetectRTC -->
</body>
</html>