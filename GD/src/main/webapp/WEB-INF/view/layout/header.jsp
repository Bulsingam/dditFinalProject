<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>AdminLTE 2 | Starter</title>
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <!-- CSS 모음 -->
   <!-- Bootstrap 3.3.6 -->
  <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/bootstrap/css/bootstrap.min.css">
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
  <!-- fullCalendar 2.2.5-->
  <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/plugins/fullcalendar/fullcalendar.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/plugins/fullcalendar/fullcalendar.print.css" media="print">
  <!-- Theme style -->
  <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/dist/css/AdminLTE.min.css">
  <!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
  <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/dist/css/skins/_all-skins.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/plugins/datepicker/datepicker3.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/plugins/daterangepicker/daterangepicker.css">
<%--   <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/plugins/datepicker/bootstrap-datepicker.js"> --%>
<%--   <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/plugins/daterangepicker/daterangepicker.js"> --%>
  <!-- summernote 에디터 스타일 파일 시작 -->
  <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.7.1/summernote.css" rel="stylesheet">
  <!-- DataTables -->
  <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/plugins/datatables/dataTables.bootstrap.css">  
</head>
<body class="hold-transition skin-blue sidebar-mini">

<header class="main-header">

    <!-- Logo -->
    <c:set var="name" value="${LOGIN_EMPINFO.emp_num }"></c:set>
    <c:if test="${name ne '201703000'}">
    	<a href="${pageContext.request.contextPath }/join/employeeMain.do" class="logo"/>
    </c:if>
    <c:if test="${name eq '201703000'}">
    	<a href="${pageContext.request.contextPath }/join/adminMain.do" class="logo"/>
    </c:if>
    
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini"><img src="${pageContext.request.contextPath }/image/GD.png" width="50px" height="50px"></span>
      
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg"><img src="${pageContext.request.contextPath }/image/GDL.png" height="50px"></span>
      
    </a>

    <!-- Header Navbar -->
    <nav class="navbar navbar-static-top" role="navigation">
      <!-- Sidebar toggle button-->
      <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
        <span class="sr-only">Toggle navigation</span>
      </a>
      <!-- Navbar Right Menu -->
      <div class="navbar-custom-menu">
        <ul class="nav navbar-nav">
          <!-- Messages: style can be found in dropdown.less-->
          <li class="dropdown messages-menu">
            <!-- Menu toggle button -->
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-envelope-o"></i>
              <span class="label label-success">4</span>
            </a>
            <ul class="dropdown-menu">
              <li class="header">You have 4 messages</li>
              <li>
                <!-- inner menu: contains the messages -->
                <ul class="menu">
                  <li><!-- start message -->
                    <a href="#">
                      <div class="pull-left">
                        <!-- User Image -->
                        <img src="${pageContext.request.contextPath }/2jo/Employee/img/${LOGIN_EMPINFO.emp_img}" 
                        	class="img-circle" alt="User Image" id="userImg">
                      </div>
                      <!-- Message title and timestamp -->
                      <h4>
                        Support Team
                        <small><i class="fa fa-clock-o"></i> 5 mins</small>
                      </h4>
                      <!-- The message -->
                      <p>Why not buy a new awesome theme?</p>
                    </a>
                  </li>
                  <!-- end message -->
                </ul>
                <!-- /.menu -->
              </li>
              <li class="footer"><a href="#">See All Messages</a></li>
            </ul>
          </li>
          <!-- /.messages-menu -->

          <!-- Notifications Menu -->
          <li class="dropdown notifications-menu">
            <!-- Menu toggle button -->
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-bell-o"></i>
              <span class="label label-warning">10</span>
            </a>
            <ul class="dropdown-menu">
              <li class="header">You have 10 notifications</li>
              <li>
                <!-- Inner Menu: contains the notifications -->
                <ul class="menu">
                  <li><!-- start notification -->
                    <a href="#">
                      <i class="fa fa-users text-aqua"></i> 5 new members joined today
                    </a>
                  </li>
                  <!-- end notification -->
                </ul>
              </li>
              <li class="footer"><a href="#">View all</a></li>
            </ul>
          </li>
          <!-- Tasks Menu -->
          <li class="dropdown tasks-menu">
            <!-- Menu Toggle Button -->
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-flag-o"></i>
              <span class="label label-danger">9</span>
            </a>
            <ul class="dropdown-menu">
              <li class="header">You have 9 tasks</li>
              <li>
                <!-- Inner menu: contains the tasks -->
                <ul class="menu">
                  <li><!-- Task item -->
                    <a href="#">
                      <!-- Task title and progress text -->
                      <h3>
                        Design some buttons
                        <small class="pull-right">20%</small>
                      </h3>
                      <!-- The progress bar -->
                      <div class="progress xs">
                        <!-- Change the css width attribute to simulate progress -->
                        <div class="progress-bar progress-bar-aqua" style="width: 20%" role="progressbar" aria-valuenow="20" 
                        	aria-valuemin="0" aria-valuemax="100">
                          <span class="sr-only">20% Complete</span>
                        </div>
                      </div>
                    </a>
                  </li>
                  <!-- end task item -->
                </ul>
              </li>
              <li class="footer">
                <a href="#">View all tasks</a>
              </li>
            </ul>
          </li>
          <!-- User Account Menu -->
          <li class="dropdown user user-menu">
            <!-- Menu Toggle Button -->
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <!-- The user image in the navbar-->
              <img src="${pageContext.request.contextPath }/2jo/Employee/img/${LOGIN_EMPINFO.emp_img}" 
              	class="user-image" alt="User Image" id="userImg">
              <!-- hidden-xs hides the username on small devices so only the image appears. -->
              <span class="hidden-xs" id="userName">${LOGIN_EMPINFO.emp_name }</span>
            </a>
            <ul class="dropdown-menu">
              <!-- The user image in the menu -->
              <li class="user-header">
                <img src="${pageContext.request.contextPath }/2jo/Employee/img/${LOGIN_EMPINFO.emp_img}" 
                	class="img-circle" alt="User Image" id="userImg">
                <p>
                  <span id="userName">${LOGIN_EMPINFO.emp_name } (${LOGIN_EMPINFO.emp_num})</span>
                  <small id="userJoinDate">입사 ${LOGIN_EMPINFO.emp_joindate }</small>
                </p>
              </li>
              <!-- Menu Body -->
              <li class="user-body">
                <div class="row">
                  <div class="col-xs-4 text-center">
                    <a href="#">Followers</a>
                  </div>
                  <div class="col-xs-4 text-center">
                    <a href="#">Sales</a>
                  </div>
                  <div class="col-xs-4 text-center">
                    <a href="#">Friends</a>
                  </div>
                </div>
                <!-- /.row -->
              </li>
              <!-- Menu Footer-->
              <li class="user-footer">
                <div class="col-xs-4">
                  <button type="button"  id="myPage" class="btn btn-default btn-flat">Profile</button>
                </div>
                  <c:set var="name" value="${LOGIN_EMPINFO.emp_num }" ></c:set>
                  <c:if test="${name ne '201703000'}">
			        <div class="col-xs-4">
			          <button type="button" id="btnDap" class="btn btn-default btn-flat">퇴근</button>                  
			        </div>
			      </c:if>
                <div class="col-xs-4">
                  <a href="${pageContext.request.contextPath }/join/logout.do" class="btn btn-default btn-flat">Logout</a>
                </div>
              </li>
            </ul>
          </li>
          <li>
            <a href="#" data-toggle="control-sidebar"><i class="fa fa-gears"></i></a>
          </li>
        </ul>
      </div>
    </nav>
  </header>
 

<!-- jQuery 2.2.3 -->
<script src="${pageContext.request.contextPath }/resources/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="${pageContext.request.contextPath }/resources/bootstrap/js/bootstrap.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<!-- Slimscroll -->
<script src="${pageContext.request.contextPath }/resources/plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="${pageContext.request.contextPath }/resources/plugins/fastclick/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="${pageContext.request.contextPath }/resources/dist/js/app.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="${pageContext.request.contextPath }/resources/dist/js/demo.js"></script>
<!-- fullCalendar 2.2.5 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.2/moment.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/plugins/fullcalendar/fullcalendar.min.js"></script>
<!-- 사원 리스트 셀렉트 검색 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/js/select2.min.js"></script>
<!-- summernote 에디터 js 파일 시작 -->
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.7.1/summernote.js"></script>
<!-- DataTables -->
<script src="${pageContext.request.contextPath }/resources/plugins/datatables/jquery.dataTables.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/plugins/datatables/dataTables.bootstrap.min.js"></script>
<!-- 다음 주소 API -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js?autoload=false"></script>
<script src="${pageContext.request.contextPath}/js/validation.js"></script>
<!-- DetectRTC -->
<script src="https://cdn.webrtc-experiment.com/DetectRTC.js"></script>
<script type="text/javascript">
$(function(){	
 		$('#myPage').on('click', function(){
 			var emp_num = '${LOGIN_EMPINFO.emp_num}'
 			if('${LOGIN_EMPINFO.emp_name}'=="관리자"){
  			var $frm = $('<form action="${pageContext.request.contextPath}/humanResource/updateEmployeeView.do" method="post"></form>');
  			$frm.append('<input type="hidden" name="emp_num" value="'+emp_num+'">');
 			}else{
  			var $frm = $('<form action="${pageContext.request.contextPath}/employee/updateEmployeeView.do" method="post"></form>');
  			$frm.append('<input type="hidden" name="emp_num" value="'+emp_num+'">');
 			}
 			$('body').append($frm);
 			$frm.submit();
 		})
	
	$('#btnDap').on('click',function(){
  		$.ajax({
			 type : "POST"   
				, url : "${pageContext.request.contextPath}/join/employeeDisappear.do"
				, dataType : "json" 
				, data : "emp_num=" + ${LOGIN_EMPINFO.emp_num}
				, error : function(xhr) {
					alert("status: " + xhr.status);
				}
				, success : function(result) {
					alert(result.status); 
				}
		});
	});
})
</script>
</body>
</html>