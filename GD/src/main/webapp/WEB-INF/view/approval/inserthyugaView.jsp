<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- CKEditor -->
<script src="https://cdn.ckeditor.com/4.7.2/standard/ckeditor.js"></script>
<script type="text/javascript">
$(function(){
	$('div[name="editable"]').hover(function(){
		$(this).css('border','1px solid skyblue');
	}, function(){
		$(this).css('border','1px solid white');
	},)
	$('div[name="editable"]').click(function(){
		CKEDITOR.disableAutoInline = true;
		CKEDITOR.inline('editable');
	})
	$('#fromDocToLine').click(function(){
		var doc_title = '휴가원';
		var doc_send = $('#doc_send').text();
		var doc_recv = $('#doc_recv').text();
		var doc_thru = $('#doc_thru').text();
		var doc_add1 = CKEDITOR.instances.doc_add1.getData();
		var doc_add2 = CKEDITOR.instances.doc_add2.getData();
		var doc_add3 = CKEDITOR.instances.doc_add3.getData();
		var doc_add4 = CKEDITOR.instances.doc_add4.getData();
		var doc_cont = CKEDITOR.instances.doc_cont.getData();
		
		if(doc_cont == ''){
			alertModal('내용을 입력해주세요!');
			return false;
		}

		var alertMsg = "다음과 같이 결재문서를 작성합니다.\n\n"
						+ "제목 : " + doc_title +"\n기간 : " + doc_add3 +"\n휴가구분 : " + doc_add4;
		alert(alertMsg);
		
		var $frm = $('<form action="${pageContext.request.contextPath}/approval/selectApprovalLine.do"></form>');
		$frm.attr('method', 'post');
		if('${formerDocument.DOC_NUM}'!=''){
			$frm.attr('action', '${pageContext.request.contextPath}/approval/updateApprovalLine.do');
			$frm.append('<input type="hidden" name="doc_num" value="${formerDocument.DOC_NUM}">');
			$frm.append('<input type="hidden" name="doc_linenum" value="${formerDocument.DET_LINENUM}">');
		}
		$frm.append('<input type="hidden" name="doc_title" value="'+doc_title+'">');
		$frm.append('<input type="hidden" name="doc_send"  value="${LOGIN_EMPINFO.emp_name}">');
		$frm.append('<input type="hidden" name="doc_recv"  value="인사부">');
		$frm.append('<input type="hidden" name="doc_add1"  value="'+doc_add1+'">');
		$frm.append('<input type="hidden" name="doc_add2"  value="'+doc_add2+'">');
		$frm.append('<input type="hidden" name="doc_add3"  value="'+doc_add3+'">');
		$frm.append('<input type="hidden" name="doc_add4"  value="'+doc_add4+'">');
		$frm.append('<input type="hidden" name="doc_cont"  value="'+doc_cont+'">');
		$frm.append('<input type="hidden" name="doc_writer"  value="${LOGIN_EMPINFO.emp_num}">');
		$frm.appendTo('body');
		$frm.submit();
	})
})
function alertModal(context){
	$('.modal-body').text(context);
	var $btn = $('<button type="button" class="btn btn-success pull-right" data-toggle="modal" data-target="#modal-default">');
	$btn.appendTo('body');
	$btn.click();
}
</script>
</head>
<body>
<div id="paper" class="box box-info">
	<div class="box-header">
			<h4>문서 작성</h4>
			<h6>
				작성할 위치에 마우스를 올리면 입력 폼이 표시됩니다. <br>작성을 완료한 뒤 '다음' 버튼을 눌러주십시오.
			</h6>
		</div>
		<div align="center" class="box-body">
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td width="50%">&nbsp;</td>
			<td align="center"><a name="JR_PAGE_ANCHOR_0_1"></a>
				<table class="jrPage" cellpadding="0" cellspacing="0" border="0"
					style="empty-cells: show; width: 595px; border-collapse: collapse; background-color: white;">
					<tr valign="top" style="height: 0">
						<td style="width: 20px"></td>
						<td style="width: 2px"></td>
						<td style="width: 8px"></td>
						<td style="width: 170px"></td>
						<td style="width: 365px"></td>
						<td style="width: 8px"></td>
						<td style="width: 22px"></td>
					</tr>
					<tr valign="top" style="height: 30px">
						<td colspan="7"></td>
					</tr>
					<tr valign="top" style="height: 60px">
						<td colspan="3"></td>
						<td style="text-indent: 0px; vertical-align: middle; text-align: center;">
							<span style="font-family: 맑은 고딕; color: #000000; font-size: 26px; line-height: 1.1484375; 
								font-weight: bold;">휴 가 원</span>
						</td>
						<td colspan="3"></td>
					</tr>
					<tr valign="top" style="height: 14px">
						<td colspan="7"></td>
					</tr>
					<tr valign="top" style="height: 450px">
						<td colspan="2"></td>
						<td colspan="3">
							<div style="width: 100%; height: 100%; position: relative;">
								<div style="position: absolute; overflow: hidden; width: 100%; height: 100%;">
									<table cellpadding="0" cellspacing="0" border="0"
										style="empty-cells: show; width: 100%; border-collapse: collapse;">
										<tr valign="top" style="height: 0">
											<td style="width: 543px"></td>
										</tr>
										<tr valign="top" style="height: 450px">
											<td style="pointer-events: auto; background-color: #FFFFFF; border: 2px solid #000000;">
											</td>
										</tr>
									</table>
								</div>
								<div style="position: relative; width: 100%; height: 100%; pointer-events: none;">
									<table cellpadding="0" cellspacing="0" border="0"
										style="empty-cells: show; width: 100%; border-collapse: collapse;">
										<tr valign="top" style="height: 0">
											<td style="width: 8px"></td>
											<td style="width: 215px"></td>
											<td style="width: 100px"></td>
											<td style="width: 215px"></td>
											<td style="width: 5px"></td>
										</tr>
										<tr valign="top" style="height: 1px">
											<td colspan="5"></td>
										</tr>
										<tr valign="top" style="height: 240px">
											<td colspan="5">
												<div style="width: 100%; height: 100%; position: relative;">
													<div style="position: absolute; overflow: hidden; width: 100%; height: 100%;">
														<table cellpadding="0" cellspacing="0" border="0"
															style="empty-cells: show; width: 100%; border-collapse: collapse;">
															<tr valign="top" style="height: 0">
																<td style="width: 1px"></td>
																<td style="width: 542px"></td>
															</tr>
															<tr valign="top" style="height: 59px">
																<td colspan="2"></td>
															</tr>
															<tr valign="top" style="height: 1px">
																<td></td>
																<td	style="pointer-events: auto; background-color: #FFFFFF; 
																	border-top: 1px solid #000000;">
																</td>
															</tr>
															<tr valign="top" style="height: 59px">
																<td colspan="2"></td>
															</tr>
															<tr valign="top" style="height: 1px">
																<td></td>
																<td	style="pointer-events: auto; background-color: #FFFFFF; 
																	border-top: 1px solid #000000;">
																</td>
															</tr>
															<tr valign="top" style="height: 59px">
																<td colspan="2"></td>
															</tr>
															<tr valign="top" style="height: 1px">
																<td colspan="2"	style="pointer-events: auto; 
																	background-color: #FFFFFF; border-top: 1px solid #000000;">
																</td>
															</tr>
														</table>
													</div>
													<div style="position: relative; width: 100%; height: 100%; pointer-events: none;">
														<table cellpadding="0" cellspacing="0" border="0"
															style="empty-cells: show; width: 100%; border-collapse: collapse;">
															<tr valign="top" style="height: 0">
																<td style="width: 8px"></td>
																<td style="width: 100px"></td>
																<td style="width: 10px"></td>
																<td style="width: 1px"></td>
																<td style="width: 9px"></td>
																<td style="width: 140px"></td>
																<td style="width: 10px"></td>
																<td style="width: 1px"></td>
																<td style="width: 9px"></td>
																<td style="width: 100px"></td>
																<td style="width: 10px"></td>
																<td style="width: 1px"></td>
																<td style="width: 9px"></td>
																<td style="width: 130px"></td>
																<td style="width: 5px"></td>
															</tr>
															<tr valign="top" style="height: 9px">
																<td colspan="3"></td>
																<td rowspan="11" style="pointer-events: auto; 
																	background-color: #FFFFFF; border-left: 1px solid #000000;">
																</td>
																<td colspan="11"></td>
															</tr>
															<tr valign="top" style="height: 40px">
																<td></td>
																<td style="pointer-events: auto; text-indent: 0px; 
																	vertical-align: middle; text-align: center;">
																	<span style="font-family: 맑은 고딕; color: #000000; 
																		font-size: 14px; line-height: 1.1484375;">
																		소&nbsp; &nbsp; &nbsp;속<br />프로젝트
																	</span>
																</td>
																<td></td>
																<td></td>
																<td colspan="9" style="pointer-events: auto; text-indent: 0px; text-align: left;">
																	<span style="font-family: 맑은 고딕; color: #000000; 
																		font-size: 10px; line-height: 1.1484375;">
																		<div name="editable" contenteditable="true" id="doc_add1">소속프로젝트</div>
																	</span>
																</td>
																<td></td>
															</tr>
															<tr valign="top" style="height: 10px">
																<td colspan="3"></td>
																<td colspan="11"></td>
															</tr>
															<tr valign="top" style="height: 10px">
																<td colspan="3"></td>
																<td colspan="3"></td>
																<td rowspan="3" style="pointer-events: auto; 
																	background-color: #FFFFFF; border-left: 1px solid #000000;">
																</td>
																<td colspan="3"></td>
																<td rowspan="3" style="pointer-events: auto; 
																	background-color: #FFFFFF; border-left: 1px solid #000000;">
																</td>
																<td colspan="3"></td>
															</tr>
															<tr valign="top" style="height: 40px">
																<td></td>
																<td style="pointer-events: auto; text-indent: 0px; vertical-align: middle; text-align: center;">
																	<span style="font-family: 맑은 고딕; color: #000000; 
																		font-size: 14px; line-height: 1.1484375;">
																		직&nbsp; &nbsp; &nbsp;급
																	</span>
																</td>
																<td></td>
																<td></td>
																<td style="pointer-events: auto; text-indent: 0px; text-align: left;">
																	<span style="font-family: 맑은 고딕; color: #000000; 
																		font-size: 10px; line-height: 1.1484375;">
																		<div name="editable" contenteditable="true" id="doc_add2">직급</div>
																	</span>
																</td>
																<td></td>
																<td></td>
																<td	style="pointer-events: auto; text-indent: 0px; vertical-align: middle; text-align: center;">
																	<span style="font-family: 맑은 고딕; color: #000000; 
																		font-size: 14px; line-height: 1.1484375;">
																		성&nbsp; &nbsp; &nbsp;명
																	</span>
																</td>
																<td></td>
																<td></td>
																<td style="pointer-events: auto; text-indent: 0px; text-align: left;">
																	<span style="font-family: 맑은 고딕; color: #000000; 
																		font-size: 10px; line-height: 1.1484375;">
																		작성자명
																	</span>
																</td>
																<td></td>
															</tr>
															<tr valign="top" style="height: 10px">
																<td colspan="3"></td>
																<td colspan="3"></td>
																<td colspan="3"></td>
																<td colspan="3"></td>
															</tr>
															<tr valign="top" style="height: 10px">
																<td colspan="3"></td>
																<td colspan="11"></td>
															</tr>
															<tr valign="top" style="height: 40px">
																<td></td>
																<td style="pointer-events: auto; text-indent: 0px; vertical-align: middle; text-align: center;">
																	<span style="font-family: 맑은 고딕; color: #000000; 
																		font-size: 14px; line-height: 1.1484375;">
																		기&nbsp; &nbsp; &nbsp;간
																	</span>
																</td>
																<td></td>
																<td></td>
																<td colspan="9"	style="pointer-events: auto; text-indent: 0px; text-align: left;">
																	<span style="font-family: 맑은 고딕; color: #000000; 
																		font-size: 10px; line-height: 1.1484375;">
																		<div name="editable" contenteditable="true" id="doc_add3">휴가 기간</div>
																	</span>
																</td>
																<td></td>
															</tr>
															<tr valign="top" style="height: 20px">
																<td colspan="3"></td>
																<td colspan="11"></td>
															</tr>
															<tr valign="top" style="height: 40px">
																<td></td>
																<td style="pointer-events: auto; text-indent: 0px; vertical-align: middle; text-align: center;">
																	<span style="font-family: 맑은 고딕; color: #000000; 
																		font-size: 14px; line-height: 1.1484375;">
																		휴가구분
																	</span>
																</td>
																<td></td>
																<td></td>
																<td colspan="9" style="pointer-events: auto; text-indent: 0px; text-align: left;">
																	<span style="font-family: 맑은 고딕; color: #000000; font-size: 10px; 
																		line-height: 1.1484375;">
																		<div name="editable" contenteditable="true" id="doc_add4">휴가 구분</div>
																	</span>
																</td>
																<td></td>
															</tr>
															<tr valign="top" style="height: 11px">
																<td colspan="3"></td>
																<td colspan="11"></td>
															</tr>
														</table>
													</div>
												</div>
											</td>
										</tr>
										<tr valign="top" style="height: 1px">
											<td colspan="5"
												style="pointer-events: auto; background-color: #FFFFFF; border-top: 1px solid #000000;">
											</td>
										</tr>
										<tr valign="top" style="height: 8px">
											<td colspan="5"></td>
										</tr>
										<tr valign="top" style="height: 40px">
											<td colspan="2"></td>
											<td style="pointer-events: auto; text-indent: 0px; vertical-align: middle; text-align: center;">
												<span style="font-family: 맑은 고딕; color: #000000; font-size: 14px; line-height: 1.1484375;">
													사&nbsp; &nbsp; &nbsp;유
												</span>
											</td>
											<td colspan="2"></td>
										</tr>
										<tr valign="top" style="height: 10px">
											<td colspan="5"></td>
										</tr>
										<tr valign="top" style="height: 1px">
											<td colspan="5" style="pointer-events: auto; background-color: #FFFFFF; border-top: 1px solid #000000;">
											</td>
										</tr>
										<tr valign="top" style="height: 9px">
											<td colspan="5"></td>
										</tr>
										<tr valign="top" style="height: 130px">
											<td></td>
											<td colspan="3" style="pointer-events: auto; text-indent: 0px; text-align: left;">
												<span style="font-family: 맑은 고딕; color: #000000; font-size: 10px; line-height: 1.1484375;">
													<div name="editable" contenteditable="true" id="doc_cont">휴가 사유</div>
												</span>
											</td>
											<td></td>
										</tr>
										<tr valign="top" style="height: 10px">
											<td colspan="5"></td>
										</tr>
									</table>
								</div>
							</div>
						</td>
						<td colspan="2"></td>
					</tr>
					<tr valign="top" style="height: 8px">
						<td colspan="7"></td>
					</tr>
					<tr valign="top" style="height: 88px">
						<td colspan="2"></td>
						<td colspan="3">
							<div style="width: 100%; height: 100%; position: relative;">
								<div
									style="position: absolute; overflow: hidden; width: 100%; height: 100%;">
									<table cellpadding="0" cellspacing="0" border="0"
										style="empty-cells: show; width: 100%; border-collapse: collapse;">
										<tr valign="top" style="height: 0">
											<td style="width: 543px"></td>
										</tr>
										<tr valign="top" style="height: 88px">
											<td style="pointer-events: auto; background-color: #FFFFFF; border: 2px solid #000000;">
											</td>
										</tr>
									</table>
								</div>
								<div style="position: relative; width: 100%; height: 100%; pointer-events: none;">
									<table cellpadding="0" cellspacing="0" border="0"
										style="empty-cells: show; width: 100%; border-collapse: collapse;">
										<tr valign="top" style="height: 0">
											<td style="width: 10px"></td>
											<td style="width: 200px"></td>
											<td style="width: 180px"></td>
											<td style="width: 70px"></td>
											<td style="width: 76px"></td>
											<td style="width: 4px"></td>
											<td style="width: 3px"></td>
										</tr>
										<tr valign="top" style="height: 7px">
											<td colspan="7"></td>
										</tr>
										<tr valign="top" style="height: 20px">
											<td></td>
											<td colspan="5" style="pointer-events: auto; text-indent: 0px; text-align: left;">
												<span style="font-family: 맑은 고딕; color: #000000; font-size: 10px; line-height: 1.1484375;">
													위와	같이 휴가원을 제출합니다.
												</span>
											</td>
											<td></td>
										</tr>
										<tr valign="top" style="height: 30px">
											<td colspan="7"></td>
										</tr>
										<tr valign="top" style="height: 1px">
											<td></td>
											<td rowspan="2" style="pointer-events: auto; text-indent: 0px; vertical-align: middle; text-align: center;">
												<span style="font-family: 맑은 고딕; color: #000000; font-size: 10px; line-height: 1.1484375;">
													작성일이 들어갈 곳
												</span>
											</td>
											<td colspan="2"></td>
											<td rowspan="2" style="pointer-events: auto; text-indent: 0px; vertical-align: middle; text-align: center;">
												<span style="font-family: 맑은 고딕; color: #000000; font-size: 10px; line-height: 1.1484375;">
													작성자 직급
												</span>
											</td>
											<td colspan="2"></td>
										</tr>
										<tr valign="top" style="height: 20px">
											<td></td>
											<td></td>
											<td	style="pointer-events: auto; text-indent: 0px; vertical-align: middle; text-align: center;">
												<span style="font-family: 맑은 고딕; color: #000000; font-size: 10px; line-height: 1.1484375;">
													작성자명
												</span>
											</td>
											<td colspan="2"></td>
										</tr>
										<tr valign="top" style="height: 10px">
											<td colspan="7"></td>
										</tr>
									</table>
								</div>
							</div>
						</td>
						<td colspan="2"></td>
					</tr>
					<tr valign="top" style="height: 104px">
						<td colspan="7"></td>
					</tr>
					<tr valign="top" style="height: 10px">
						<td></td>
						<td colspan="5"
							style="background-color: #6E6E6E; border: 1px solid #6E6E6E;">
						</td>
						<td></td>
					</tr>
					<tr valign="top" style="height: 78px">
						<td colspan="7"></td>
					</tr>
				</table></td>
			<td width="50%">&nbsp;</td>
		</tr>
	</table>
	</div>
	<div class="box-footer">
		<button class="btn btn-block btn-primary btn-lg" id="fromDocToLine">다 음</button>
	</div>
</div>
<!-- 에러 모달창 -->
	<div class="modal modal-warning fade in" id="modal-default" style="display: none;">
		<div id="approvalWindow" class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">에러</h4>
				</div>
				<div class="modal-body"></div>
			</div>
		</div>
	</div>
</body>
</html>