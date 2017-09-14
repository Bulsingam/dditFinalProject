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
		var doc_title = $('#doc_title').text();
		var doc_send = $('#doc_send').text();
		var doc_recv = $('#doc_recv').text();
		var doc_thru = $('#doc_thru').text();
		var doc_add1 = CKEDITOR.instances.doc_add1.getData();
		var doc_add2 = CKEDITOR.instances.doc_add2.getData();
		var doc_cont = CKEDITOR.instances.doc_cont.getData();
		
		if(doc_cont == ''){
			alertModal('내용을 입력해주세요!');
			return false;
		}
		if(doc_title == ''){
			alertModal('제목을 입력해주세요!');
			return false;
		}
		if(doc_send == ''){
			alertModal('발신처를 입력해주세요!');
			return false;
		}
		if(doc_recv == ''){
			alertModal('수신처를 입력해주세요!');
			return false;
		}
		
		var alertMsg = "다음과 같이 결재문서를 작성합니다.\n\n"
						+ "제목 : " + doc_title +"\n수신 : " + doc_recv +"\n발신 : " + doc_send + "\n경유 : " + doc_thru;
		alert(alertMsg);
		
		var $frm = $('<form action="${pageContext.request.contextPath}/approval/selectApprovalLine.do"></form>');
		$frm.attr('method', 'post');
		if('${formerDocument.DOC_NUM}'!=''){
			$frm.attr('action', '${pageContext.request.contextPath}/approval/updateApprovalLine.do');
			$frm.append('<input type="hidden" name="doc_num" value="${formerDocument.DOC_NUM}">');
			$frm.append('<input type="hidden" name="doc_linenum" value="${formerDocument.DET_LINENUM}">');
		}
		$frm.append('<input type="hidden" name="doc_title" value="'+doc_title+'">');
		$frm.append('<input type="hidden" name="doc_send"  value="'+doc_send+'">');
		$frm.append('<input type="hidden" name="doc_recv"  value="'+doc_recv+'">');
		$frm.append('<input type="hidden" name="doc_thru"  value="'+doc_thru+'">');
		$frm.append('<input type="hidden" name="doc_add1"  value="'+doc_add1+'">');
		$frm.append('<input type="hidden" name="doc_add2"  value="'+doc_add2+'">');
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
<body text="#000000" link="#000000" alink="#000000" vlink="#000000">
	<div id="paper" class="box box-info">
		<div class="box-header">
			<h4>문서 작성</h4>
			<h6>
				작성할 위치에 마우스를 올리면 입력 폼이 표시됩니다. <br>작성을 완료한 뒤 '다음' 버튼을 눌러주십시오.
			</h6>
		</div>
		<div align="center" class="box-body">
			<table class="jrPage" cellpadding="0" cellspacing="0" border="0"
				style="empty-cells: show; width: 100%px; border-collapse: collapse; background-color: white;">
				<tr valign="top" style="height: 0">
					<td style="width: 20px"></td>
					<td style="width: 260px"></td>
					<td style="width: 21px"></td>
					<td style="width: 269px"></td>
					<td style="width: 25px"></td>
				</tr>
				<tr valign="top" style="height: 20px">
					<td colspan="5"></td>
				</tr>
				<tr valign="top" style="height: 60px">
					<td></td>
					<td	style="text-indent: 0px; vertical-align: middle; text-align: center;">
						<span style="font-family: 맑은 고딕; color: #000000; font-size: 25px; line-height: 1; 
							*line-height: normal; font-weight: bold;">
							보 고 서
						</span>
					</td>
					<td></td>
					<td	style="text-indent: 0px; vertical-align: middle; text-align: left;">
						<span style="font-family: 맑은 고딕; color: #000000; 
							font-size: 10px; line-height: 1.2578125;">
							<table border="1">
								<tr><td>결재선이 들어갈 부분</td></tr>
							</table>
						</span>
					</td>
					<td></td>
				</tr>
				<tr valign="top" style="height: 9px">
					<td colspan="5"></td>
				</tr>
				<tr valign="top" style="height: 151px">
					<td></td>
					<td colspan="3">
						<div style="width: 100%; height: 100%; position: relative;">
							<div style="position: absolute; overflow: hidden; width: 100%; height: 100%;">
								<table cellpadding="0" cellspacing="0" border="0"
									style="empty-cells: show; width: 100%; border-collapse: collapse;">
									<tr valign="top" style="height: 0">
										<td style="width: 550px"></td>
									</tr>
									<tr valign="top" style="height: 150px">
										<td	style="pointer-events: auto; background-color: #FFFFFF; 
											border: 2px solid #000000;">
										</td>
									</tr>
								</table>
							</div>
							<div style="position: absolute; overflow: hidden; width: 100%; height: 100%; pointer-events: none;">
								<table cellpadding="0" cellspacing="0" border="0"
									style="empty-cells: show; width: 100%; border-collapse: collapse;">
									<tr valign="top" style="height: 0">
										<td style="width: 90px"></td>
										<td style="width: 1px"></td>
										<td style="width: 459px"></td>
									</tr>
									<tr valign="top" style="height: 150px">
										<td></td>
										<td	style="pointer-events: auto; background-color: #FFFFFF; border-left: 1px solid #000000;">
										</td>
										<td></td>
									</tr>
								</table>
							</div>
							<div style="position: absolute; overflow: hidden; width: 100%; height: 100%; pointer-events: none;">
								<table cellpadding="0" cellspacing="0" border="0"
									style="empty-cells: show; width: 100%; border-collapse: collapse;">
									<tr valign="top" style="height: 0">
										<td style="width: 550px"></td>
									</tr>
									<tr valign="top" style="height: 125px">
										<td></td>
									</tr>
									<tr valign="top" style="height: 1px">
										<td	style="pointer-events: auto; background-color: #FFFFFF; border-top: 1px solid #000000;">
										</td>
									</tr>
								</table>
							</div>
							<div style="position: relative; width: 100%; height: 100%; pointer-events: none;">
								<table cellpadding="0" cellspacing="0" border="0"
									style="empty-cells: show; width: 100%; border-collapse: collapse;">
									<tr valign="top" style="height: 0">
										<td style="width: 540px"></td>
										<td style="width: 10px"></td>
									</tr>
									<tr valign="top" style="height: 151px">
										<td>
											<div style="width: 100%; height: 100%; position: relative;">
												<div style="position: absolute; overflow: hidden; width: 100%; height: 100%;">
													<table cellpadding="0" cellspacing="0" border="0"
														style="empty-cells: show; width: 100%; border-collapse: collapse;">
														<tr valign="top" style="height: 0">
															<td style="width: 90px"></td>
															<td style="width: 190px"></td>
															<td style="width: 1px"></td>
															<td style="width: 49px"></td>
															<td style="width: 1px"></td>
															<td style="width: 209px"></td>
														</tr>
														<tr valign="top" style="height: 25px">
															<td colspan="2"></td>
															<td rowspan="8"	style="pointer-events: auto; background-color: #FFFFFF; 
																border-left: 1px solid #000000;">
															</td>
															<td></td>
															<td rowspan="7" style="pointer-events: auto; background-color: #FFFFFF; 
																border-left: 1px solid #000000;">
															</td>
															<td></td>
														</tr>
														<tr valign="top" style="height: 1px">
															<td colspan="2" style="pointer-events: auto; background-color: #FFFFFF; 
																border-top: 1px solid #000000;">
															</td>
															<td></td>
															<td></td>
														</tr>
														<tr valign="top" style="height: 24px">
															<td colspan="2"></td>
															<td></td>
															<td></td>
														</tr>
														<tr valign="top" style="height: 1px">
															<td colspan="2"	style="pointer-events: auto; background-color: #FFFFFF; 
																border-top: 1px solid #000000;">
															</td>
															<td></td>
															<td></td>
														</tr>
														<tr valign="top" style="height: 24px">
															<td colspan="2"></td>
															<td></td>
															<td></td>
														</tr>
														<tr valign="top" style="height: 1px">
															<td colspan="2"	style="pointer-events: auto; background-color: #FFFFFF; 
																border-top: 1px solid #000000;">
															</td>
															<td></td>
															<td></td>
														</tr>
														<tr valign="top" style="height: 49px">
															<td colspan="2"></td>
															<td></td>
															<td></td>
														</tr>
														<tr valign="top" style="height: 1px">
															<td colspan="2"></td>
															<td colspan="3"></td>
														</tr>
														<tr valign="top" style="height: 25px">
															<td	style="pointer-events: auto; text-indent: 0px; vertical-align: middle; 
																text-align: center;">
																<span style="font-family: '맑은 고딕; 
																	color: #000000; font-size: 14px; line-height: 1; *line-height: normal;">
																	제 목
																</span>
															</td>
															<td colspan="5"></td>
														</tr>
													</table>
												</div>
												<div style="position: relative; width: 100%; height: 100%; pointer-events: none;">
													<table cellpadding="0" cellspacing="0" border="0"
														style="empty-cells: show; width: 100%; border-collapse: collapse;">
														<tr valign="top" style="height: 0">
															<td style="width: 540px"></td>
														</tr>
														<tr valign="top" style="height: 150px">
															<td>
																<div style="width: 100%; height: 100%; position: relative;">
																	<div style="position: absolute; overflow: hidden; width: 100%; height: 100%;">
																		<table cellpadding="0" cellspacing="0" border="0"
																			style="empty-cells: show; width: 100%; border-collapse: collapse;">
																			<tr valign="top" style="height: 0">
																				<td style="width: 280px"></td>
																				<td style="width: 50px"></td>
																				<td style="width: 210px"></td>
																			</tr>
																			<tr valign="top" style="height: 1px">
																				<td colspan="3"></td>
																			</tr>
																			<tr valign="top" style="height: 99px">
																				<td></td>
																				<td rowspan="3"	style="pointer-events: auto; text-indent: 0px; 
																					vertical-align: middle; text-align: center;">
																					<span style="font-family: 맑은 고딕; 
																						color: #000000; font-size: 14px; line-height: 1.2578125;">
																						지 시<br />사 항
																					</span>
																				</td>
																				<td></td>
																			</tr>
																			<tr valign="top" style="height: 1px">
																				<td	style="pointer-events: auto; background-color: #FFFFFF; border-top: 1px solid #000000;">
																				</td>
																				<td></td>
																			</tr>
																			<tr valign="top" style="height: 25px">
																				<td></td>
																				<td></td>
																			</tr>
																		</table>
																	</div>
																	<div style="position: relative; width: 100%; height: 100%; pointer-events: none;">
																		<table cellpadding="0" cellspacing="0" border="0"
																			style="empty-cells: show; width: 100%; border-collapse: collapse;">
																			<tr valign="top" style="height: 0">
																				<td style="width: 91px"></td>
																				<td style="width: 9px"></td>
																				<td style="width: 180px"></td>
																				<td style="width: 60px"></td>
																				<td style="width: 200px"></td>
																			</tr>
																			<tr valign="top" style="height: 1px">
																				<td colspan="3" rowspan="2">
																					<div style="width: 100%; height: 100%; position: relative;">
																						<div style="position: absolute; overflow: hidden; width: 100%; height: 100%;">
																							<table cellpadding="0" cellspacing="0" border="0"
																								style="empty-cells: show; width: 100%; border-collapse: collapse;">
																								<tr valign="top" style="height: 0">
																									<td style="width: 91px"></td>
																									<td style="width: 189px"></td>
																								</tr>
																								<tr valign="top" style="height: 25px">
																									<td	style="pointer-events: auto; text-indent: 0px; 
																										vertical-align: middle; text-align: center;">
																										<span style="font-family: 맑은 고딕; 
																											color: #000000; font-size: 14px; line-height: 1.2578125;">
																											문서번호
																										</span>
																									</td>
																									<td></td>
																								</tr>
																							</table>
																						</div>
																						<div style="position: relative; width: 100%; height: 100%; pointer-events: none;">
																							<table cellpadding="0" cellspacing="0" border="0"
																								style="empty-cells: show; width: 100%; border-collapse: collapse;">
																								<tr valign="top" style="height: 0">
																									<td style="width: 90px"></td>
																									<td style="width: 190px"></td>
																								</tr>
																								<tr valign="top" style="height: 1px">
																									<td colspan="2"></td>
																								</tr>
																								<tr valign="top" style="height: 24px">
																									<td></td>
																									<td style="pointer-events: auto; text-indent: 0px; 
																										vertical-align: middle; text-align: center;">
																										<span style="font-family: 맑은 고딕; color: #000000; 
																											font-size: 10px; line-height: 1.2578125;">
																											문서번호가 들어가는 부분
																										</span>
																									</td>
																								</tr>
																							</table>
																						</div>
																					</div>
																				</td>
																				<td colspan="2"></td>
																			</tr>
																			<tr valign="top" style="height: 24px">
																				<td></td>
																				<td rowspan="6"	style="pointer-events: auto; 
																					text-indent: 0px; text-align: left;">
																					<span style="font-family: 맑은 고딕; 
																						color: #000000; font-size: 10px; line-height: 1.2578125;">
																						<div name="editable" contenteditable="true" id="doc_add1">${formerDocument.DOC_ADD1 }</div>
																					</span>
																				</td>
																			</tr>
																			<tr valign="top" style="height: 1px">
																				<td rowspan="2"	style="pointer-events: auto; text-indent: 0px; vertical-align: middle; text-align: center;">
																					<span style="font-family: 맑은 고딕; 
																						color: #000000; font-size: 14px; line-height: 1.2578125;">
																						작 성 일
																					</span>
																				</td>
																				<td colspan="3"></td>
																			</tr>
																			<tr valign="top" style="height: 24px">
																				<td colspan="2"	style="pointer-events: auto; text-indent: 0px; 
																					vertical-align: middle; text-align: center;">
																					<span style="font-family: 맑은 고딕; color: #000000; 
																						font-size: 10px; line-height: 1.2578125;">
																						작성일자가 들어가는 부분
																					</span>
																				</td>
																				<td></td>
																			</tr>
																			<tr valign="top" style="height: 1px">
																				<td colspan="4"></td>
																			</tr>
																			<tr valign="top" style="height: 49px">
																				<td colspan="3">
																					<div style="width: 100%; height: 100%; position: relative;">
																						<div style="position: absolute; overflow: hidden; width: 100%; height: 100%;">
																							<table cellpadding="0" cellspacing="0" border="0"
																								style="empty-cells: show; width: 100%; border-collapse: collapse;">
																								<tr valign="top" style="height: 0">
																									<td style="width: 91px"></td>
																									<td style="width: 189px"></td>
																								</tr>
																								<tr valign="top" style="height: 25px">
																									<td style="pointer-events: auto; text-indent: 0px; vertical-align: middle; 
																										text-align: center;">
																										<span style="font-family: 맑은 고딕; 
																											color: #000000; font-size: 14px; line-height: 1; *line-height: normal;">
																											수 신
																										</span>
																									</td>
																									<td></td>
																								</tr>
																							</table>
																						</div>
																						<div style="position: relative; width: 100%; height: 100%; pointer-events: none;">
																							<table cellpadding="0" cellspacing="0" border="0"
																								style="empty-cells: show; width: 100%; border-collapse: collapse;">
																								<tr valign="top" style="height: 0">
																									<td style="width: 91px"></td>
																									<td style="width: 189px"></td>
																								</tr>
																								<tr valign="top" style="height: 24px">
																									<td></td>
																									<td style="pointer-events: auto; text-indent: 0px; vertical-align: middle; 
																										text-align: center;">
																										<span style="font-family: 맑은 고딕;
																											color: #000000; font-size: 10px; line-height: 1.2578125;">
																											<div name="editable" contenteditable="true" id="doc_recv">${formerDocument.DOC_RECV }</div>
																										</span>
																									</td>
																								</tr>
																								<tr valign="top" style="height: 25px">
																									<td colspan="2">
																										<div style="width: 100%; height: 100%; position: relative;">
																											<div style="position: absolute; overflow: hidden; width: 100%; height: 100%;">
																												<table cellpadding="0" cellspacing="0" border="0"
																													style="empty-cells: show; width: 100%; border-collapse: collapse;">
																													<tr valign="top" style="height: 0">
																														<td style="width: 91px"></td>
																														<td style="width: 189px"></td>
																													</tr>
																													<tr valign="top" style="height: 1px">
																														<td colspan="2"></td>
																													</tr>
																													<tr valign="top" style="height: 24px">
																														<td	style="pointer-events: auto; text-indent: 0px; 
																															vertical-align: middle; text-align: center;">
																															<span style="font-family: 맑은 고딕; 
																																color: #000000; font-size: 14px; line-height: 1; *line-height: normal;">
																																경 유
																															</span>
																														</td>
																														<td></td>
																													</tr>
																												</table>
																											</div>
																											<div style="position: relative; width: 100%; height: 100%; pointer-events: none;">
																												<table cellpadding="0" cellspacing="0" border="0"
																													style="empty-cells: show; width: 100%; border-collapse: collapse;">
																													<tr valign="top" style="height: 0">
																														<td style="width: 90px"></td>
																														<td style="width: 190px"></td>
																													</tr>
																													<tr valign="top" style="height: 25px">
																														<td></td>
																														<td style="pointer-events: auto; text-indent: 0px; vertical-align: middle; 
																															text-align: center;">
																															<span style="font-family: 맑은 고딕;
																																color: #000000; font-size: 10px; line-height: 1.2578125;">
																																<div name="editable" contenteditable="true" id="doc_thru">${formerDocument.DOC_THRU }</div>
																															</span>
																														</td>
																													</tr>
																												</table>
																											</div>
																										</div>
																									</td>
																								</tr>
																							</table>
																						</div>
																					</div>
																				</td>
																				<td></td>
																			</tr>
																			<tr valign="top" style="height: 24px">
																				<td colspan="3" rowspan="2">
																					<div style="width: 100%; height: 100%; position: relative;">
																						<div style="position: absolute; overflow: hidden; width: 100%; height: 100%;">
																							<table cellpadding="0" cellspacing="0" border="0"
																								style="empty-cells: show; width: 100%; border-collapse: collapse;">
																								<tr valign="top" style="height: 0">
																									<td style="width: 91px"></td>
																									<td style="width: 189px"></td>
																								</tr>
																								<tr valign="top" style="height: 25px">
																									<td style="pointer-events: auto; text-indent: 0px; 
																										vertical-align: middle; text-align: center;">
																										<span style="font-family: 맑은 고딕; 
																											color: #000000; font-size: 14px; line-height: 1; *line-height: normal;">
																											발 신
																										</span>
																									</td>
																									<td></td>
																								</tr>
																							</table>
																						</div>
																						<div style="position: relative; width: 100%; height: 100%; pointer-events: none;">
																							<table cellpadding="0" cellspacing="0" border="0"
																								style="empty-cells: show; width: 100%; border-collapse: collapse;">
																								<tr valign="top" style="height: 0">
																									<td style="width: 90px"></td>
																									<td style="width: 190px"></td>
																								</tr>
																								<tr valign="top" style="height: 24px">
																									<td></td>
																									<td style="pointer-events: auto; text-indent: 0px; 
																										vertical-align: middle; text-align: center;">
																										<span style="font-family: 맑은 고딕;
																											color: #000000; font-size: 10px; line-height: 1.2578125;">
																											<div name="editable" contenteditable="true" id="doc_send">${formerDocument.DOC_SEND }</div>
																										</span>
																									</td>
																								</tr>
																								<tr valign="top" style="height: 1px">
																									<td colspan="2"></td>
																								</tr>
																							</table>
																						</div>
																					</div>
																				</td>
																				<td></td>
																			</tr>
																			<tr valign="top" style="height: 1px">
																				<td colspan="2"></td>
																			</tr>
																			<tr valign="top" style="height: 25px">
																				<td colspan="2"></td>
																				<td colspan="3" style="pointer-events: auto; text-indent: 0px; 
																					vertical-align: middle; text-align: left;">
																					<span style="font-family: 맑은 고딕; color: #000000; 
																						font-size: 10px; line-height: 1.2578125;">
																						<div name="editable" contenteditable="true" id="doc_title">${formerDocument.DOC_TITLE }</div>
																					</span>
																				</td>
																			</tr>
																		</table>
																	</div>
																</div>
															</td>
														</tr>
														<tr valign="top" style="height: 1px">
															<td></td>
														</tr>
													</table>
												</div>
											</div>
										</td>
										<td></td>
									</tr>
								</table>
							</div>
						</div>
					</td>
					<td></td>
				</tr>
				<tr valign="top" style="height: 11px">
					<td colspan="5"></td>
				</tr>
				<tr valign="top" style="height: 370px">
					<td></td>
					<td colspan="3">
						<div style="width: 100%; height: 100%; position: relative;">
							<div style="position: absolute; overflow: hidden; width: 100%; height: 100%;">
								<table cellpadding="0" cellspacing="0" border="0"
									style="empty-cells: show; width: 100%; border-collapse: collapse;">
									<tr valign="top" style="height: 0">
										<td style="width: 550px"></td>
									</tr>
									<tr valign="top" style="height: 370px">
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
										<td style="width: 530px"></td>
										<td style="width: 10px"></td>
									</tr>
									<tr valign="top" style="height: 10px">
										<td colspan="3"></td>
									</tr>
									<tr valign="top" style="height: 350px">
										<td></td>
										<td style="pointer-events: auto; text-indent: 0px; text-align: left;">
											<span style="font-family: 맑은 고딕;
												color: #000000; font-size: 10px; line-height: 1.2578125;">
												<div name="editable" contenteditable="true" id="doc_cont">${formerDocument.DOC_CONT }</div>
											</span>
										</td>
										<td></td>
									</tr>
									<tr valign="top" style="height: 10px">
										<td colspan="3"></td>
									</tr>
								</table>
							</div>
						</div>
					</td>
					<td></td>
				</tr>
				<tr valign="top" style="height: 25px">
					<td colspan="5"></td>
				</tr>
				<tr valign="top" style="height: 167px">
					<td></td>
					<td colspan="3">
						<div style="width: 100%; height: 100%; position: relative;">
							<div style="position: absolute; overflow: hidden; width: 100%; height: 100%;">
								<table cellpadding="0" cellspacing="0" border="0"
									style="empty-cells: show; width: 100%; border-collapse: collapse;">
									<tr valign="top" style="height: 0">
										<td style="width: 550px"></td>
									</tr>
									<tr valign="top" style="height: 167px">
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
										<td style="width: 530px"></td>
										<td style="width: 10px"></td>
									</tr>
									<tr valign="top" style="height: 10px">
										<td colspan="3"></td>
									</tr>
									<tr valign="top" style="height: 147px">
										<td></td>
										<td style="pointer-events: auto; text-indent: 0px; text-align: left;">
											<span style="font-family: 맑은 고딕; 
												color: #000000; font-size: 10px; line-height: 1.2578125;">
												<div name="editable" contenteditable="true" id="doc_add2">${formerDocument.DOC_ADD2 }</div>
											</span>
										</td>
										<td></td>
									</tr>
									<tr valign="top" style="height: 10px">
										<td colspan="3"></td>
									</tr>
								</table>
							</div>
						</div>
					</td>
					<td></td>
				</tr>
				<tr valign="top" style="height: 29px">
					<td colspan="5"></td>
				</tr>
			</table>
			</td>
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