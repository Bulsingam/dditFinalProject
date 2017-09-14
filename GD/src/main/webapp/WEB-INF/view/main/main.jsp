<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">

$(function () {
    $('#example2').DataTable({
      "paging": true,
      "lengthChange": false,
      "searching": false,
      "ordering": false,
      "info": false,
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
})

</script>
<style>
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

 span.info-box-icon.bg-green{ 
 	padding-top : 30px;
 	width : 100%;
	height:150px;
}

 span.info-box-icon.bg-blue{ 
 	padding-top : 30px;
 	width : 100%;
	height:150px;
}

 span.info-box-icon.bg-hotpink{ 
 	padding-top : 30px;
 	width : 100%;
	height:150px;
}

 span.info-box-icon.bg-yellow{ 
 	padding-top : 35px;
 	width : 100%;
	height:150px;
}

 span.info-box-icon.bg-red{ 
 	padding-top : 30px;
 	width : 100%;
	height:150px;
}



#conteneur3D #carte {
height : 150px;
width : 100%;
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

width : 100%;

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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div class="row" style="margin-bottom: 20px;">
		<div id="whitediv" class="col-md-offset-1 col-md-2 col-xs-6" onclick="location.href='${pageContext.request.contextPath}/document/sendFolder.do'">
			<div id="conteneur3D">
 				<div id="carte">
		    		<div>
		              <span class="info-box-number">${folder.sendFolder }건</span>
   				    </div>
		  		    <div>
						<span class="info-box-icon bg-blue">
							<i class="fa fa-file-o"><span class="info-box-text">발신</span></i>
						</span>
	   		    	</div>
 		 		</div>
			</div>
		</div>
		<div id="whitediv" class="col-md-2 col-xs-6" onclick="location.href='${pageContext.request.contextPath}/document/receiveFolder.do'">
			<div id="conteneur3D">
				<div id="carte">
					<div>
						<span class="info-box-number">${folder.recvFolder }건</span>
					</div>
					<div>
						<span class="info-box-icon bg-green">
							<i class="fa fa-files-o"><span class="info-box-text">수신</span></i>
						</span>
					</div>
				</div>
			</div>
		</div>
		<div id="whitediv" class="col-md-2 col-xs-12" onclick="location.href='${pageContext.request.contextPath}/document/progressFolder.do'">
			<div id="conteneur3D">
				<div id="carte" >
					<div>
						<span class="info-box-number">${folder.prgFolder }건</span>
					</div>
					<div>
						<span class="info-box-icon bg-yellow">
							<i class="fa fa-file-text"><span class="info-box-text">진행</span></i>
						</span>
					</div>
				</div>
			</div>
		</div>
		<div id="whitediv" class="col-md-2 col-xs-6" onclick="location.href='${pageContext.request.contextPath}/document/confirmFolder.do'">
			<div id="conteneur3D">
				<div id="carte">
					<div>
						<span class="info-box-number">${folder.confFolder }건</span>
					</div>
					<div>
						<span class="info-box-icon bg-hotpink">
							<i class="fa fa-clipboard"><span class="info-box-text">승인</span></i>
						</span>
					</div>
				</div>
			</div>
		</div>
		<div id="whitediv" class="col-md-2 col-xs-6" onclick="location.href='${pageContext.request.contextPath}/document/refuseFolder.do'">
			<div id="conteneur3D">
				<div id="carte">
					<div>
						<span class="info-box-number">${folder.refFolder }건</span>
					</div>
					<div>
						<span class="info-box-icon bg-red">
							<i class="fa fa-file"><span class="info-box-text">반려</span></i>
						</span>
					</div>
				</div>
			</div>
		</div>
	</div>
		
	<div class="row">
		<div class="col-md-6">
		          <div class="box">
		            <div class="box-header with-border">
		              <h3 class="box-title">공지사항</h3>
		              <div class="box-tools pull-right">
			            <button type="button" class="btn btn-box-tool" value="more" 
			            onclick="location.href='${pageContext.request.contextPath }/noticeBoard/notiList.do'">
			            <span style="margin-right:10px;">more</span><i class="fa fa-plus"  style="text-align:right; size:10px;"></i></button>
			          </div>
		            </div>
		            <!-- /.box-header -->
		            <div class="box-body">
		              <table class="table table-bordered">
		                <tbody>
		                <tr>
		                  <th>번호</th>
		                  <th>제목</th>
		                  <th style="width : 100px">작성자</th>
		                  <th style="width : 60px">조회수</th>
		                </tr>
		                <c:forEach items="${notiList}" var ="notiInfo" begin="0" end="5">
		                <tr >
		                  <td>${notiInfo.RNUM}</td>
		                  <td>${notiInfo.NOTI_TITLE}</td>
		                  <td>${notiInfo.NOTI_WRITER }</td>
		                  <td>${notiInfo.NOTI_VIEWHIT}</td>
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
		          <div class="box ">
		            <div class="box-header with-border">
		              <h3 class="box-title">사내게시판</h3>
		               <div class="box-tools pull-right">
			            <button type="button" class="btn btn-box-tool" value="more" 
			            onclick="location.href='${pageContext.request.contextPath }/companyBoard/comList.do'">
			            <span style="margin-right:10px;">more</span><i class="fa fa-plus"  style="text-align:right; size:10px;"></i></button>
			          </div>
		            </div>
		            <!-- /.box-header -->
		            <div class="box-body">
		              <table class="table table-bordered">
		            <tbody>
		                <tr>
		                  <th>번호</th>
		                  <th>제목</th>
		                  <th style="width : 100px">작성자</th>
		                  <th style="width : 60px">조회수</th>
		                </tr>
		                <c:forEach items="${comBoList}" var ="comBoInfo" begin="0" end="5">
				                <tr>
				                  <td>${comBoInfo.RNUM}</td>
				                  <td>${comBoInfo.COM_TITLE}</td>
				                  <td>${comBoInfo.COM_WRITER }</td>
				                  <td>${comBoInfo.COM_VIEWHIT}</td>
				                </tr>
			     	   </c:forEach>
		              </tbody>
		              </table>
		            </div>
		            <!-- /.box-body -->
		          </div>
			</div>
		</div>
	
	    <div class="row">
	<div class="col-md-6" id="downTable">
          <div class="box box-danger" style="padding:5px;">
            <div class="box-header">
               <h3 class="box-title">진행중인 프로젝트</h3>
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
	<div class="col-md-6" id="downTable">
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
	
</body>
</html>
