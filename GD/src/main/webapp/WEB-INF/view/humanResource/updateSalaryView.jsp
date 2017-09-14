<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	$(function(){
	   if ($.ui && $.ui.dialog && $.ui.dialog.prototype._allowInteraction) {
	       var ui_dialog_interaction = $.ui.dialog.prototype._allowInteraction;
	       $.ui.dialog.prototype._allowInteraction = function(e) {
	           if ($(e.target).closest('.select2-dropdown').length) return true;
	           return ui_dialog_interaction.apply(this, arguments);
	       };
	   }
		$('#parents').hide();
		$('#updateSalery').click(function(){
			$('#updateSalery-form').dialog({
				title : '정보수정',
				height : 300,
				width : 400,
				modal : true,
				buttons : {
					"확인" : function(){
						$(this).dialog('close');
					},
					"닫기" : function(){
						$(this).dialog('close');
					}
				},
				close : function() {
				}
			})
		});
		
		
	})
	
</script>
</head>
<body>

	<div class="col-md-6" style="min-width: 500px;">
		<div class="box box-info " style="padding-bottom: 10px;">
			<div class="box-header ">
				<h2 class="box-title">사원 급여 상태</h2>
			</div>
			<div class="col-md-12 col-lg-12">
				<div class="box-body col-lg-12 ">
					<table id="example1" class="table table-bordered table-striped">
						<thead>
							<tr>
								<th>직위</th>
								<th style="width: auto;">직위별 급여현황</th>
								<th>현재인원</th>
								<!--                   <th>전화번호</th> -->
								<!--                   <th>직위</th> -->
								<!--                   <th>입사일자</th> -->
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>관리자</td>
								<td>박예연</td>
								<td>1</td>
							</tr>
							<tr>
								<td>사장</td>
								<td>박예연</td>
								<td>2</td>
							</tr>
							<tr>
								<td>부사장</td>
								<td>박예연</td>
								<td>3</td>
							</tr>
							<tr>
								<td>상무</td>
								<td>박예연</td>
								<td>10</td>
							</tr>
							<tr>
								<td>부장</td>
								<td>박예연</td>
								<td>10</td>
							</tr>
							<tr>
								<td>차장</td>
								<td>박예연</td>
								<td>10</td>
							</tr>
							<tr>
								<td>과장</td>
								<td>박예연</td>
								<td>10</td>
							</tr>
							<tr>
								<td>대리</td>
								<td>박예연</td>
								<td>20</td>
							</tr>
							<tr>
								<td>사원</td>
								<td>박예연</td>
								<td>20</td>
							</tr>
						</tfoot>
					</table>
				</div>
				<!-- /.box-body -->
			</div>
			<!-- /.box -->
			<div class="row" style="margin-bottom: 20px;">
				<!-- /.col -->
				<div class="col-md-2 col-md-offset-1">
					<button type="button" class="btn btn-primary btn-block btn-flat">뒤로</button>
				</div>
				<div class="col-md-2 ">
					<button type="button" class="btn btn-primary btn-block btn-flat" id="updateSalery">수정</button>
				</div>
				<div class=" col-md-3 ">
					<button type="button" class="btn btn-primary btn-block btn-flat">사원정보로 이동하기</button>
				</div>
				<!-- /.col -->
			</div>
		</div>
	</div>
	<div id="parents" >
		<div id="updateSalery-form">
			<div>
				<select class="form-control select2 " style="width:100px; display:inlineblock;float:left; margin-right:20px;">
	                  <option selected="selected">사장</option>
	                  <option>부사장</option>
	                  <option>상무</option>
	                  <option>부장</option>
	                  <option>차장</option>
	                  <option>과장</option>
	                  <option>대리</option>
	                  <option>사원</option>
	            </select>
		        <input type="text" class="form-control" placeholder="수정할 급여를 입력해주십시오" style="width:200px; margin:10px;">
			</div>
		</div>
	</div>
</body>
</html>