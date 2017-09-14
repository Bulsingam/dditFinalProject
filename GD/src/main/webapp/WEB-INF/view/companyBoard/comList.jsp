<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">
$(function(){
	
	$('button[id=insert]').click(function(){
		$(location).attr('href','${pageContext.request.contextPath}/companyBoard/insertComView.do');
	});
	
	$('tbody tr').click(function(){
		var idx = $(this).index();
		var com_postnum = $('tbody tr:eq(' + idx + ') td:eq(0)').find('input').val();
		var rnum = $('tbody tr:eq(' + idx + ') td:eq(0)').text();
		$(location).attr('href', '${pageContext.request.contextPath}/companyBoard/comView.do?com_postnum=' + com_postnum +'&rnum='+rnum+'&search_keyword=${search_keyword}&search_keycode=${search_keycode}'
				 +'&currentPage=${param.currentPage}&blockCount=${param.blockCount}');
	});
	
});

</script>
<style>
	 	th{  
  		text-align : center;  
  	}  
</style>
<body>

       <div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-header">
              <h3 class="box-title">사내게시판</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <table id="example2" class="table table-bordered table-hover">
                <thead>
                <tr>
                  <th>번호</th>
                  <th>제목</th>
                  <th>작성자</th>
                  <th>등록일</th>
                  <th>조회수</th>
                </tr>
                </thead>
                <tbody>
				<c:forEach items="${comboardList}" var="comList">
				<tr>
					<td style="text-align : center;"><input type="hidden" name="com_postnum" value="${comList.COM_POSTNUM }" >${comList.RNUM }</td>
					<td>
						<c:forEach begin="1" end="${comList.COM_POSTDEP }" varStatus="stat">
							&nbsp;&nbsp;
							<c:if test="${stat.last }">
								<img src="${pageContext.request.contextPath }/image/ico_reply.gif" alt="reply">
							</c:if>
						</c:forEach>
						${comList.COM_TITLE }
					</td>
					<td style="text-align : center;"><input type="hidden" name="com_writer" value="${comList.COM_WRITER }">${comList.EMP_NAME }</td>
					<td style="text-align : center;"><fmt:formatDate value="${comList.COM_REGDATE }" pattern = "yyyy-MM-dd"/></td>
					<td style="text-align : center;">${comList.COM_VIEWHIT }</td>
				</tr>
				</c:forEach>
                </tbody>
              </table>
            ${pagingHtml }
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
          <!-- /.box -->
        </div>
        <!-- /.col -->
      </div>
    	<form action="${pageContext.request.contextPath }/companyBoard/comList.do" method="post" class="form-inline pull-right">
			<input id="search_keyword" name="search_keyword" type="text" placeholder="검색어 입력..." class="form-control" style="margin : 1px 1px 0px 0px "/> 
				<select class="form-control" name="search_keycode">
				<option>검색조건</option>
				<option value="TOTAL">전체</option>
				<option value="TITLE">제목</option>
				<option value="CONTENT">내용</option>
				<option value="WRITER">작성자</option>
			</select>
			<button type="submit" class="btn btn-primary form-control">검색</button>
			<button type="button" class="btn btn-info form-control" id="insert">게시글등록</button>
		</form>
      <!-- /.row -->
<!--     </section> -->
<!--     /.content -->
<!--   </div> -->
<!--   <!-- /.content-wrapper --> -->
      
         

</body>
</html>