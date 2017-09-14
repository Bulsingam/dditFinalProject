<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	$(function(){
		var tel1 = "${fn:split(empInfo.EMP_TEL, '-')[0]}";
		var tel2 = "${fn:split(empInfo.EMP_TEL, '-')[1]}";
		var tel3 = "${fn:split(empInfo.EMP_TEL, '-')[2]}";
		
		$('input[name="emp_tel1"]').val(tel1);
		$('input[name="emp_tel2"]').val(tel2);
		$('input[name="emp_tel3"]').val(tel3);
		
		var Mail1 = "${fn:split(empInfo.EMP_MAIL, '@')[0]}";
		var Mail2 = "${fn:split(empInfo.EMP_MAIL, '@')[1]}";
		
		$('input[name="emp_mail1"]').val(Mail1);
		$('input[name="emp_mail2"]').val(Mail2);
		
		$('form[name=updateForm]').submit(function(){
			var emp_mail = $('input[name=emp_mail1]').val()+'@'+$('input[name=emp_mail2]').val();
			var emp_tel = $('input[name=emp_tel1]').val()+'-'+$('input[name=emp_tel2]').val()+'-'+$('input[name=emp_tel3]').val();
			$('input[name=emp_tel]').val(emp_tel);
			$('input[name=emp_mail]').val(emp_mail);
			
			if($('input[name=emp_pass]').val()== ''){
				alert("비밀번호를 입력해주십시오");
				return false;
			}
			if($('input[name=emp_mail1]').val() == '' || !$('input[name=emp_mail]').val().validationMAIL()
				|| $('input[name=emp_mail1]').val()=='' ||$('input[name=emp_mail2]').val()==null
						|| $('input[name=emp_mail2]').val() ==''){
				alert("메일을 정확히 입력해주십시오");
				return false;
			}
			if(!$('input[name=emp_tel]').val().validationHP() || $('input[name=emp_tel1]').val() =='' 
						|| $('input[name=emp_tel2]').val()=='' || $('input[name=emp_tel3]').val() ==''){
				alert("휴대폰 번호를 정확히 입력해주십시오");
				return false;
			}
			if($('input[name=emp_addr]').val() == '' ){
				alert("주소를 입력해주십시오");
				return false;
			}
			
			$(this).attr('action','${pageContext.request.contextPath }/employee/updateEmployee.do');
		});
		
		
		
		 $('#example2').DataTable({
		      "paging": true,
		      "lengthChange": false,
		      "searching": false,
		      "ordering": false,
		      "info":false,
		      "autoWidth": false
		    });
		    $('#example3').DataTable({
		      "paging": true,
		      "lengthChange": false,
		      "searching": false,
		      "ordering": false,
		      "info": false,
		      "autoWidth": false
		    });
		

		    $('#noti').on('click',function(){
		    	
		    })
		    
		    
	})

	
	function openDaumPostcode() {
		daum.postcode.load(function() {
			new daum.Postcode({
				oncomplete : function(data) {
					// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
					// 예제를 참고하여 다양한 활용법을 확인해 보세요.
					document.getElementById("emp_addr").value = data.address;
					document.getElementById("emp_addr").focus();
				}
			}).open();
		});
	}
</script>
<style type="text/css">
/* 아이콘크기조절 */
.fa-files-o{
	font-size: 80px;
}

.fa-file-o{
	font-size: 80px;
}

 .fa-file-text{
	font-size: 80px;
}

.fa-clipboard{
	font-size: 80px;
}

.fa-file{
	font-size: 80px;
}


div.box{
	float : left;
}

 span.info-box-icon.bg-green{ 
 	padding-top : 30px;
	width:200px;
	height:150px;
}

 span.info-box-icon.bg-blue{ 
 	padding-top : 30px;
	width:200px;
	height:150px;
}

 span.info-box-icon.bg-hotpink{ 
 	padding-top : 30px;
	width:200px;
	height:150px;
}

 span.info-box-icon.bg-yellow{ 
 	padding-top : 30px;
	width:200px;
	height:150px;
}

 span.info-box-icon.bg-red{ 
 	padding-top : 30px;
	width:200px;
	height:150px;
}


 div#conteneur3D.col-md-3.col-sm-6.col-xs-12{ 
		
	width:12%; 
	margin-right: 100px ;
	
}

div#conteneur3D.col-md-3.col-sm-6.col-xs-12:first-child{
		
 	margin:  50px 10px 30px 100px; 
	

	
}


#conteneur3D {


-webkit-perspective : 600px;
perspective : 600px;
 
}

#conteneur3D #carte {
height : 150px;
width : 200px;
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

height : 150px;

width : 200px;

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
	font-size: 50px;
	margin-top: 40px;
}

</style>
</head>
<body>
	<div class="row">
		<div class="col-md-3">
			<!-- Profile Image -->
			<div class="box box-primary">
				<div class="box-header with-border">
					<b>프로필 사진</b>
				</div>

				<div class="box-body box-profile">
					<img class="profile-user-img img-responsive img-circle"
						src="/2jo/Employee/img/${empInfo.EMP_IMG}"
						alt="User profile picture"
						style="width: 150px; height: 150px; margin: auto;">

					<!--               <h3 class="profile-username text-center">Great Pack</h3> -->

					<!--               <p class="text-muted text-center">Software Engineer</p> -->
					<ul class="list-group list-group-unbordered">
						<li class="list-group-item"><b>서명</b> <img
							class="profile-user-img img-responsive img-circle"
							src="/2jo/Employee/sign/${empInfo.EMP_SIGN}"
							alt="User profile picture"
							style="width: 150px; height: 150px; margin: auto;"></li>
					</ul>

					<p class="text-muted text-center">Great Pack의 서명이나 도장</p>
				</div>
				<!-- /.box-body -->
			</div>
		</div>

		<div class="col-md-9">
			<div class="box box-primary" style="padding: 10px;">

				<div class="box-header with-border">
					<h3 class="box-title">개인 정보</h3>
				</div>

				<form class="form-horizontal" name="updateForm">
					<input type="hidden" class="form-control" name="emp_tel" placeholder="전화번호" value="" >
					<input type="hidden" class="form-control" name="emp_mail" placeholder="이메일" value="" >
					<div class="box-body">
						<div class="row">
							<div class="form-group">
								<label for="inputEmail3" class="col-md-2 control-label">이름</label>
								<div class="col-md-3">
									<input type="text" class="form-control" name="emp_name"
										placeholder="이름" value="${empInfo.EMP_NAME }" readonly>
								</div>
								<label for="inputEmail3" class="col-md-1 control-label">사원번호</label>
								<div class="col-md-3">
									<input type="text" class="form-control" name="emp_num"
										placeholder="사원번호" value="${empInfo.EMP_NUM }" readonly>
								</div>
							</div>
						</div>
						<div class="form-group ">
							<label for="inputEmail3" class="col-md-2 control-label">패스워드</label>
							<div class="col-md-3">
								<input type="text" class="form-control" name="emp_pass"
									placeholder="패스워드" value="${empInfo.EMP_PASS }">
							</div>

						</div>
						<div class="form-group ">
							<label for="inputEmail3" class="col-md-2 control-label ">직책</label>
							<div class="col-md-3">
								<input type="text" class="form-control" name="pos_name"
									placeholder="대리" value="${empInfo.POS_NAME}" readonly>
							</div>
							<label for="inputEmail3" class="col-md-1 control-label">
								직위 </label>
							<div class="col-md-3">
								<input type="text" class="form-control" name="emp_role"
									placeholder="AA" value="${empInfo.EMP_ROLE}" readonly>
							</div>
						</div>
						<div class="form-group">
							<label for="inputEmail3" class="col-md-2 control-label">주민등록번호</label>

							<div class="col-md-3">
								<input type="text" class="form-control" name="emp_regnum1"
									placeholder="주민등록번호 앞자리" value="${empInfo.EMP_REGNUM1 }" readonly>
							</div>
							<i class="fa fa-minus col-md-2"
								style="width: 10px; margin: 10px 0px 0px 0px; padding: 0px;"></i>
							<div class="col-md-3">
								<input type="text" class="form-control" name="emp_regnum2"
									placeholder="주민등록번호 뒷자리" value="${empInfo.EMP_REGNUM2 }" readonly>
							</div>
						</div>

						<div class="form-group">
							<label for="inputEmail3" class="col-md-2 control-label">Email</label>

							<div class="col-md-3">
								<input type="text" class="form-control " name="emp_mail1"
									placeholder="Email">
							</div>

							<i class="fa fa-at col-md-2"
								style="width: 10px; margin: 10px 0px 0px 0px; padding: 0px;"></i>

							<div class="col-md-3">
								<input type="text" class="form-control" placeholder="naver.com"
									name="emp_mail2">
							</div>
						</div>

						<div class="form-group">
							<label for="inputEmail3" class="col-md-2 control-label">주소</label>

							<div class="col-md-6">
								<input type="text" class="form-control" name="emp_addr"
									id="emp_addr" placeholder="주소를 입력해주세요"
									value="${empInfo.EMP_ADDR }">
							</div>
							<div class="col-md-3">
								<button type="button"
									class="btn btn-primary btn-block btn-flat col-md-1"
									style="margin-left: 0px; padding-left: 0px;"
									onclick="openDaumPostcode()">주소검색</button>
							</div>
						</div>


						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">전화번호</label>

							<div class="col-md-3">
								<input type="text" class="form-control" id="" name="emp_tel1"
									placeholder="전화번호 앞자리">
							</div>

							<i class="fa fa-minus col-md-2"
								style="width: 10px; margin: 10px 0px 0px 0px; padding: 0px;"></i>

							<div class="col-md-3">
								<input type="text" class="form-control" id="" name="emp_tel2"
									placeholder="전화번호 중간자리">
							</div>

							<i class="fa fa-minus col-md-2"
								style="width: 10px; margin: 10px 0px 0px 0px; padding: 0px;"></i>

							<div class="col-md-3">
								<input type="text" class="form-control" id="" name="emp_tel3"
									placeholder="전화번호 뒷자리">
							</div>
						</div>



					</div>
					<div class="box-footer">
						<button type="button" class="btn btn-info pull-right" id="back">뒤로</button>
						<button type="submit" class="btn btn-info pull-right">수정</button>
					</div>
				</form>
			</div>
		</div>
	</div>
<!-- 전자결재 연동 시작 -->
		<div class="row">

			<div id="whitediv">
				<div id="conteneur3D" class="col-md-3 col-sm-6 col-xs-12" >
 					<div id="carte">
    <!-- Back -->
	    				<div>
		            	  <span class="info-box-number">${folder.sendFolder }건</span>
	   		   		    </div>
    <!-- Front -->
	  		  		    <div>
	     				 <span class="info-box-icon bg-blue"><i class="fa fa-file-o">
	     			  	 <span class="info-box-text">발신</span></i></span>
	   		  		   </div>
 		 		   </div>
 			   </div>
	     	</div>
		
		
		
		
		<div id="whitediv">
			<div id="conteneur3D" class="col-md-3 col-sm-6 col-xs-12" >		
 				<div id="carte">
    <!-- Back -->
    				<div>
	             	  <span class="info-box-number">${folder.recvFolder }건</span>
   		  		   </div>
    <!-- Front -->
  		    		<div>
     				   <span class="info-box-icon bg-green"><i class="fa fa-files-o">
     			 	   <span class="info-box-text">수신</span></i></span>
   		   		    </div>
 				 </div>
 		 </div>
	</div>
		

		
		
			<div id="whitediv">
					<div id="conteneur3D" class="col-md-3 col-sm-6 col-xs-12" >
 						<div id="carte" >
    <!-- Back -->
    						<div>
	             				 <span class="info-box-number">${folder.prgFolder }건</span>
   		   				    </div>
    <!-- Front -->
  		   					 <div>
				     			  <span class="info-box-icon bg-yellow"><i class="fa fa-file-text">
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
		
		

<!-- 전자결재 연동 끝 -->
	<div class="row">
	
		<div class="col-md-6 ">
          <div class="box box-danger" style="padding:5px;">
            <div class="box-header">
               <h3 class="box-title">진행중인 프로젝트</h3>
               <input type="hidden" class="pull-right" value="5">
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <table id="example2" class="table table-bordered table-hover">
                  <thead>
                  <tr>
	                  <th>프로젝트 ID</th>
	                  <th style="width : 30%">프로젝트명</th>
	                  <th>팀장</th>
	                  <th style="width : 20%">시작일</th>
	                  <th style="width : 20%">종료일</th>
	                </tr>

                </thead>

                <tbody>
	                <c:forEach items="${projectIngList}" var ="proIngListInfo" begin="0">
			                <tr>
			                  <td>${proIngListInfo.PRO_ID}</td>
			                  <td>${proIngListInfo.PRO_NAME}</td>
			                  <td>${proIngListInfo.EMP_NAME }</td>
			                  <td><fmt:formatDate value="${proIngListInfo.PRO_STARTDATE}" pattern="yyyy-MM-dd"></fmt:formatDate></td>
			                  <td><fmt:formatDate value="${proIngListInfo.PRO_ENDDATE}" pattern="yyyy-MM-dd"></fmt:formatDate></td>
			                </tr>
		     	   </c:forEach>
             </tbody>
              </table>
            </div>
          </div>
        </div>
	<div class="col-md-6">
          <div class="box box-danger" style="padding:5px;">
            <div class="box-header">
               <h3 class="box-title">완료된 프로젝트</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <table id="example3" class="table table-bordered table-hover">
                  <thead>
                 <tr>
                  <th>프로젝트 ID</th>
                  <th style="width : 30%">프로젝트명</th>
                  <th>팀장</th>
                  <th style="width : 20%">시작일</th>
                  <th style="width : 20%">종료일</th>
                </tr>

                </thead>

                <tbody>
	               <c:forEach items="${projectEndList}" var ="proEndListInfo" begin="0">
		                <tr>
		                  <td>${proEndListInfo.PRO_ID}</td>
		                  <td>${proEndListInfo.PRO_NAME}</td>
		                  <td>${proEndListInfo.EMP_NAME }</td>
		                  <td><fmt:formatDate value="${proEndListInfo.PRO_STARTDATE}" pattern="yyyy-MM-dd"/></td>
		                  <td><fmt:formatDate value="${proEndListInfo.PRO_ENDDATE}" pattern="yyyy-MM-dd"/></td>
		                </tr>
	     	  	 </c:forEach>
             </tbody>
              </table>
            </div>
          </div>
        </div>
	</div>


	<div class="row">
		<div class="col-md-6">
			<div class="box" style="height:300px;">
				<div class="box-header with-border">
					<h3 class="box-title">공지사항</h3>
					<div class="box-tools pull-right">
						<button type="button" class="btn btn-box-tool" value="more" id="noti"
							onclick="location.href='${pageContext.request.contextPath }/noticeBoard/notiList.do'">
							<span style="margin-right: 10px;">more</span>
							<i class="fa fa-plus" style="text-align: right; size: 10px;"></i>
						</button>
					</div>
				</div>
				<!-- /.box-header -->
				<div class="box-body">
					<table class="table table-bordered">
						<tbody>
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th style="width: 100px">작성자</th>
								<th style="width: 60px">조회수</th>
							</tr>
							<c:forEach items="${notiList}" var ="notiInfo" begin="0" end="5">
				                <tr >
				                  <td>${notiInfo.RNUM}</td>
				                  <td>${notiInfo.NOTI_TITLE}</td>
				                  <td>${notiInfo.EMP_NAME }</td>
				                  <td>${notiInfo.NOTI_VIEWHIT}</td>
				                </tr>
			                </c:forEach>
						</tbody>
					</table>
				</div>
				<!-- /.box-body -->
			</div>
			<!-- /.box -->

			<div class="box" style="height:300px;">
				<div class="box-header with-border">
					<h3 class="box-title">작성한 사내게시판</h3>
					<div class="box-tools pull-right">
						<button type="button" class="btn btn-box-tool" value="more" id="com"
							onclick="location.href='${pageContext.request.contextPath }/companyBoard/comList.do'">
							<span style="margin-right: 10px;">more</span><i
								class="fa fa-plus" style="text-align: right; size: 10px;"></i>
						</button>
					</div>
				</div>
				<!-- /.box-header -->
				<div class="box-body">
					<table class="table table-bordered">
						<tbody>
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th style="width: 100px">작성자</th>
								<th style="width: 60px">조회수</th>
							</tr>
							<c:forEach items="${comBoList}" var ="comBoInfo" begin="0" end="5">
				                <tr>
				                  <td>${comBoInfo.RNUM}</td>
				                  <td>${comBoInfo.COM_TITLE}</td>
				                  <td>${comBoInfo.EMP_NAME }</td>
				                  <td>${comBoInfo.COM_VIEWHIT}</td>
				                </tr>
			     		   </c:forEach>
						</tbody>
					</table>
				</div>
				<!-- /.box-body -->
			</div>
			<!-- /.box -->
		</div>


		<div class="col-md-6">
			<div class="box" style="height:300px;">
				<div class="box-header with-border">
					<h3 class="box-title">작성한 익명게시판</h3>
					<div class="box-tools pull-right">
			            <button type="button" class="btn btn-box-tool" value="more" id="anony"
							onclick="location.href='${pageContext.request.contextPath }/anonymousBoard/getAnyBoList.do'">
			            	<span style="margin-right:10px;">more</span>
			            	<i class="fa fa-plus"  style="text-align:right; size:10px;"></i>
			            </button>
			        </div>
				</div>
				<!-- /.box-header -->
				<div class="box-body">
					<table class="table table-bordered">
						<tbody>
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th style="width: 100px">작성자</th>
								<th style="width: 60px">조회수</th>
							</tr>
							<c:forEach items="${anonymousBoList}" var="anonymousInfo"
								begin="0" end="5">
								<tr>
									<td>${anonymousInfo.RNUM}</td>
									<td>${anonymousInfo.ANY_TITLE}</td>
									<td>${anonymousInfo.EMP_NAME }</td>
									<td>${anonymousInfo.ANY_VIEWHIT}</td>

								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<!-- /.box-body -->
			</div>
			<!-- /.box -->

			<div class="box" style="height:300px;">
				<div class="box-header with-border">
					<h3 class="box-title">작성한 자료실</h3>
					<div class="box-tools pull-right">
			            <button type="button" class="btn btn-box-tool" value="more" id="archive"
							onclick="location.href='${pageContext.request.contextPath }/archive/getArcList.do'">
			            	<span style="margin-right:10px;">more</span>
			            	<i class="fa fa-plus"  style="text-align:right; size:10px;"></i>
			            </button>
			        </div>
				</div>
				<!-- /.box-header -->
				<div class="box-body">
					<table class="table table-bordered">
						<tbody>
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th style="width: 100px">작성자</th>
								<th style="width: 60px">조회수</th>
							</tr>
							<c:forEach items="${archiveList}" var="archiveInfo" begin="0" end="5">
								<tr>
									<td>${archiveInfo.RNUM}</td>
									<td>${archiveInfo.ARC_TITLE}</td>
									<td>${archiveInfo.EMP_NAME }</td>
									<td>${archiveInfo.ARC_VIEWHIT}</td>

								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>

	</div>

</body>

</html>