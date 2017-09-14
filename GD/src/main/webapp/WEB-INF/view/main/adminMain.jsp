<%@page import="kr.or.gd.vo.CompanyBoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 
 
<title>Insert title here</title>
</head>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">

google.load("visualization", "1", {packages:["corechart"]});
google.setOnLoadCallback(drawChart1);
function drawChart1() {
  var data = google.visualization.arrayToDataTable([
    ['분기', '승인', '반려'],
    ['1분기',  100,      400],
    ['2분기',  170,      460],
    ['3분기',  660,       420],
    ['4분기',  300,      540]
   
  ]);

  var options = {
    title: '전자결재 통계 차트',
    hAxis: {title: 'Quarterly', titleTextStyle: {color: 'red'}}
 };

var chart = new google.visualization.ColumnChart(document.getElementById('chart_div1'));
  chart.draw(data, options);
}


$(window).resize(function(){
  drawChart1();

});


// 도넛차트

  google.charts.load("current", {packages:["corechart"]});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['T', 'Hours per Day'],
          ['사내게시판', 6 ],
          ['공지게시판',      2],
          ['익명게시판',  2],
          ['자료실', 2]
        
        ]);

        var options = {
          title: '게시판 이용 현황',
          pieHole: 0.4,
        };

        var chart = new google.visualization.PieChart(document.getElementById('donutchart'));
        chart.draw(data, options);
      }


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
s
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



.chart {
  width: 100%; 
  min-height: 450px;
}

div#leftcont{ 
	margin:auto;

}

div#rightcont{
	float:right;
	margin-right: 100px;
}
</style>
<body>
<div class="row">

<!-- 전자결재 연동 시작 -->
<div class="col-md-7" id="leftcont">
<div class="col-md-12">

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
	
		
<!-- 		</div> -->
		<!-- 전자결재 연동 끝 -->

 	 


<!-- 공지사항 연동 시작 -->
		<div class="col-md-12">
	
		 
		          <div class="box ">
		            <div class="box-header with-border">
		              <h3 class="box-title">공지사항</h3>
		              <div class="box-tools pull-right">
			            <button type="button" class="btn btn-box-tool" value="more"
			             onclick="location.href='${pageContext.request.contextPath }/noticeBoard/notiList.do'">
			            
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
		       
		      
      
		       
		    <div class="col-md-12">     
		          <div class="box ">
		            <div class="box-header with-border">
		              <h3 class="box-title">사내게시판</h3>
		               <div class="box-tools pull-right">
			            <button type="button" class="btn btn-box-tool" value="more" 
				            onclick="location.href='${pageContext.request.contextPath }/companyBoard/comList.do'">
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
		
<!-- 공지사항 연동 끝 -->
</div>


</div>
<div class="col-md-5">

  <div id="chart_div1" class="chart"></div>
   <div id="donutchart" style="width: 667px; height: 350px; margin-right: 60px;"></div>
</div>

</div>
</body>
</html>
