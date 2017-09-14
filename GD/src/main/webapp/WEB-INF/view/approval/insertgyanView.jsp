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
	// 문서 수정을 통해 이 페이지에 들어왔을 때 기존 내용을 채워준다.
	if('${formerDocument.DOC_NUM}'!=''){
		$('#doc_title').text('${formerDocument.DOC_TITLE}');
		$('#doc_send').text('${formerDocument.DOC_SEND}');
		$('#doc_recv').text('${formerDocument.DOC_RECV}');
		$('#doc_thru').text('${formerDocument.DOC_THRU}');
	}
	
	$('#fromDocToLine').click(function(){
		var doc_title = $('#doc_title').text();
		var doc_send = $('#doc_send').text();
		var doc_recv = $('#doc_recv').text();
		var doc_thru = $('#doc_thru').text();
		var doc_add1 = CKEDITOR.instances.doc_add1.getData();
		var doc_add2 = CKEDITOR.instances.doc_add2.getData();
		var doc_add3 = CKEDITOR.instances.doc_add3.getData();
		var doc_add4 = CKEDITOR.instances.doc_add4.getData();
		var doc_add5 = CKEDITOR.instances.doc_add5.getData();
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
			//수정 화면일 때 URI 변경
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
		$frm.append('<input type="hidden" name="doc_add3"  value="'+doc_add3+'">');
		$frm.append('<input type="hidden" name="doc_add4"  value="'+doc_add4+'">');
		$frm.append('<input type="hidden" name="doc_add5"  value="'+doc_add5+'">');
		$frm.append('<input type="hidden" name="doc_writer"  value="${LOGIN_EMPINFO.emp_num}">');
		$frm.append('<input type="hidden" name="doc_cont"  value="'+doc_cont+'">');
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
<div>
	<div id="paper" class="box box-info">
		<div class="box-header">
			<h4>문서 작성</h4>
			<h6>작성할 위치에 마우스를 올리면 입력 폼이 표시됩니다.
				<br>작성을 완료한 뒤 '다음' 버튼을 눌러주십시오.
			</h6>
		</div>
		<div align="center" class="box-body">
			<table width="100%" cellpadding="0" cellspacing="0" border="0" class="col-md-12">
				<tr>
					<td width="50%">&nbsp;</td>
					<td align="center">
						<a name="JR_PAGE_ANCHOR_0_1"></a>
						<table class="jrPage" cellpadding="0" cellspacing="0" border="0"
							style="empty-cells: show; width: 595px; border-collapse: collapse; background-color: white;">
							<tr valign="top" style="height: 0">
								<td style="width: 40px"></td>
								<td style="width: 1px"></td>
								<td style="width: 10px"></td>
								<td style="width: 29px"></td>
								<td style="width: 21px"></td>
								<td style="width: 20px"></td>
								<td style="width: 19px"></td>
								<td style="width: 30px"></td>
								<td style="width: 30px"></td>
								<td style="width: 30px"></td>
								<td style="width: 130px"></td>
								<td style="width: 10px"></td>
								<td style="width: 30px"></td>
								<td style="width: 30px"></td>
								<td style="width: 101px"></td>
								<td style="width: 10px"></td>
								<td style="width: 13px"></td>
								<td style="width: 1px"></td>
								<td style="width: 40px"></td>
							</tr>
							<tr valign="top" style="height: 30px">
								<td colspan="19"></td>
							</tr>
							<tr valign="top" style="height: 60px">
								<td colspan="8"></td>
								<td colspan="6" style="text-indent: 0px; vertical-align: middle; text-align: center;">
									<span style="font-family: 맑은 고딕; color: #000000; font-size: 22px; line-height: 1.3300781; 
										font-weight: bold;">
										기 안 서
									</span>
								</td>
								<td colspan="5"></td>
							</tr>
							<tr valign="top" style="height: 19px">
								<td colspan="19"></td>
							</tr>
							<tr valign="top" style="height: 20px">
								<td colspan="3"></td>
								<td colspan="3"	style="text-indent: 0px; vertical-align: middle; text-align: left;">
									<span style="font-family: 맑은 고딕; color: #000000; font-size: 10px; line-height: 1.3300781;">
										수&nbsp; &nbsp;신
									</span>
								</td>
								<td colspan="10" style="text-indent: 0px; vertical-align: middle; text-align: left;">
									<span style="font-family: 맑은 고딕; color: #000000; font-size: 10px; line-height: 1.3300781;">
										<div name="editable" contenteditable="true" id="doc_recv"></div>
									</span>
								</td>
								<td colspan="3"></td>
							</tr>
							<tr valign="top" style="height: 20px">
								<td colspan="3"></td>
								<td colspan="3" style="text-indent: 0px; vertical-align: middle; text-align: left;">
									<span style="font-family: 맑은 고딕; color: #000000; font-size: 10px; line-height: 1.3300781;">
										(경&nbsp;유)
									</span>
								</td>
								<td colspan="10" style="text-indent: 0px; vertical-align: middle; text-align: left;">
									<span style="font-family: 맑은 고딕; color: #000000; font-size: 10px; line-height: 1.3300781;">
										<div name="editable" contenteditable="true" id="doc_thru"></div>
									</span>
								</td>
								<td colspan="3"></td>
							</tr>
							<tr valign="top" style="height: 20px">
								<td colspan="3"></td>
								<td colspan="3"	style="text-indent: 0px; vertical-align: middle; text-align: left;">
									<span style="font-family: 맑은 고딕; color: #000000; font-size: 10px; line-height: 1.3300781;">
										제&nbsp; &nbsp;목
									</span>
								</td>
								<td colspan="10" style="text-indent: 0px; vertical-align: middle; text-align: left;">
									<span style="font-family: 맑은 고딕; color: #000000; font-size: 10px; line-height: 1.3300781;">
										<div name="editable" contenteditable="true" id="doc_title">제목</div>
									</span>
								</td>
								<td colspan="3"></td>
							</tr>
							<tr valign="top" style="height: 10px">
								<td colspan="19"></td>
							</tr>
							<tr valign="top" style="height: 1px">
								<td colspan="2"></td>
								<td colspan="16" style="border-top: 1px solid #000000;"></td>
								<td></td>
							</tr>
							<tr valign="top" style="height: 6px">
								<td colspan="19"></td>
							</tr>
							<tr valign="top" style="height: 40px">
								<td colspan="5"></td>
								<td style="text-indent: 0px; text-align: left;">
									<span style="font-family: 맑은 고딕; color: #000000; font-size: 10px; line-height: 1.3300781;">
										1.
									</span>
								</td>
								<td colspan="10" style="text-indent: 0px; text-align: left;">
									<span style="font-family: 맑은 고딕; color: #000000; font-size: 10px; line-height: 1.3300781;">
										<div name="editable" contenteditable="true" id="doc_add1">${formerDocument.DOC_ADD1}</div>
									</span>
								</td>
								<td colspan="3"></td>
							</tr>
							<tr valign="top" style="height: 9px">
								<td colspan="19"></td>
							</tr>
							<tr valign="top" style="height: 40px">
								<td colspan="5"></td>
								<td style="text-indent: 0px; text-align: left;">
									<span style="font-family: 맑은 고딕; color: #000000; font-size: 10px; line-height: 1.3300781;">
										2.
									</span>
								</td>
								<td colspan="10" style="text-indent: 0px; text-align: left;">
									<span style="font-family: 맑은 고딕; color: #000000; font-size: 10px; line-height: 1.3300781;">
										<div name="editable" contenteditable="true" id="doc_add2">${formerDocument.DOC_ADD2}</div>
									</span>
								</td>
								<td colspan="3"></td>
							</tr>
							<tr valign="top" style="height: 8px">
								<td colspan="19"></td>
							</tr>
							<tr valign="top" style="height: 40px">
								<td colspan="5"></td>
								<td style="text-indent: 0px; text-align: left;">
									<span style="font-family: 맑은 고딕; color: #000000; font-size: 10px; line-height: 1.3300781;">
										3.
									</span>
								</td>
								<td colspan="10" style="text-indent: 0px; text-align: left;">
									<span style="font-family: 맑은 고딕; color: #000000; font-size: 10px; line-height: 1.3300781;">
										<div name="editable" contenteditable="true" id="doc_add3">${formerDocument.DOC_ADD3}</div>
									</span>
								</td>
								<td colspan="3"></td>
							</tr>
							<tr valign="top" style="height: 7px">
								<td colspan="19"></td>
							</tr>
							<tr valign="top" style="height: 40px">
								<td colspan="5"></td>
								<td style="text-indent: 0px; text-align: left;">
									<span style="font-family: 맑은 고딕; color: #000000; font-size: 10px; line-height: 1.3300781;">
										4.
									</span>
								</td>
								<td colspan="10" style="text-indent: 0px; text-align: left;">
									<span style="font-family: 맑은 고딕; color: #000000; font-size: 10px; line-height: 1.3300781;">
										<div name="editable" contenteditable="true" id="doc_add4">${formerDocument.DOC_ADD4}</div>
									</span>
								</td>
								<td colspan="3"></td>
							</tr>
							<tr valign="top" style="height: 7px">
								<td colspan="19"></td>
							</tr>
							<tr valign="top" style="height: 40px">
								<td colspan="5"></td>
								<td style="text-indent: 0px; text-align: left;">
									<span style="font-family: 맑은 고딕; color: #000000; font-size: 10px; line-height: 1.3300781;">
										5.
									</span>
								</td>
								<td colspan="10" style="text-indent: 0px; text-align: left;">
									<span style="font-family: 맑은 고딕; color: #000000; font-size: 10px; line-height: 1.3300781;">
										<div name="editable" contenteditable="true" id="doc_add5">${formerDocument.DOC_ADD5}</div>
									</span>
								</td>
								<td colspan="3"></td>
							</tr>
							<tr valign="top" style="height: 20px">
								<td colspan="9"></td>
								<td colspan="4" style="text-indent: 0px; vertical-align: middle; text-align: center;">
									<span style="font-family: 맑은 고딕; color: #000000; font-size: 10px; line-height: 1.3300781;">
										- 내 용 -
									</span>
								</td>
								<td colspan="6"></td>
							</tr>
							<tr valign="top" style="height: 10px">
								<td colspan="19"></td>
							</tr>
							<tr valign="top" style="height: 130px">
								<td colspan="2"></td>
								<td colspan="13" style="text-indent: 0px; text-align: left;">
									<span style="font-family: 맑은 고딕; color: #000000; font-size: 10px; line-height: 1.3300781;">
										<div name="editable" contenteditable="true" id="doc_cont">${formerDocument.DOC_CONT}</div>
									</span>
								</td>
								<td colspan="4"></td>
							</tr>
							<tr valign="top" style="height: 48px">
								<td colspan="19"></td>
							</tr>
							<tr valign="top" style="height: 30px">
								<td colspan="9"></td>
								<td colspan="4"
									style="text-indent: 0px; vertical-align: middle; text-align: center;">
									<span style="font-family: 맑은 고딕; color: #000000; font-size: 20px; line-height: 1.3300781;">
										<div name="editable" contenteditable="true" id="doc_send">발신처</div>
									</span>
								</td>
								<td colspan="6"></td>
							</tr>
							<tr valign="top" style="height: 23px">
								<td colspan="19"></td>
							</tr>
							<tr valign="top" style="height: 10px">
								<td></td>
								<td colspan="16" style="background-color: #6E6E6E; border: 1px solid #6E6E6E;">
								</td>
								<td colspan="2"></td>
							</tr>
							<tr valign="top" style="height: 4px">
								<td colspan="19"></td>
							</tr>
							<tr valign="top" style="height: 40px">
								<td></td>
								<td colspan="16" style="text-indent: 0px; text-align: left;">
									<span style="font-family: 맑은 고딕; color: #000000; font-size: 10px; line-height: 1.3300781;">
										<table border="1px" width="100%" height="100%">
											<tr><td>결재선이 들어가는 부분</td></tr>
										</table>
									</span>
								</td>
								<td colspan="2"></td>
							</tr>
							<tr valign="top" style="height: 5px">
								<td colspan="19"></td>
							</tr>
							<tr valign="top" style="height: 20px">
								<td></td>
								<td colspan="3" style="text-indent: 0px; vertical-align: middle; text-align: left;">
									<span style="font-family: 맑은 고딕; color: #000000; font-size: 10px; line-height: 1.3300781;">
										시행
									</span>
								</td>
								<td colspan="5"	style="text-indent: 0px; vertical-align: middle; text-align: left;">
									<span style="font-family: 맑은 고딕; color: #000000; font-size: 10px; line-height: 1.3300781;">
										문서번호가 들어갈곳
									</span>
								</td>
								<td></td>
								<td	style="text-indent: 0px; vertical-align: middle; text-align: left;">
									<span style="font-family: 맑은 고딕; color: #000000; font-size: 10px; line-height: 1.3300781;">
										날짜가 들어갈 곳
									</span>
								</td>
								<td colspan="8"></td>
							</tr>
							<tr valign="top" style="height: 1px">
								<td colspan="19"></td>
							</tr>
							<tr valign="top" style="height: 20px">
								<td></td>
								<td colspan="4"	style="text-indent: 0px; vertical-align: middle; text-align: left;">
									<span style="font-family: 맑은 고딕; color: #000000; font-size: 10px; line-height: 1.3300781;">
										우 34940
									</span>
								</td>
								<td colspan="6"	style="text-indent: 0px; vertical-align: middle; text-align: left;">
									<span style="font-family: 맑은 고딕; color: #000000; font-size: 10px; line-height: 1.3300781;">
										대전광역시 중구 중앙로 76 영민빌딩 2층 대덕인재개발원
									</span>
								</td>
								<td></td>
								<td colspan="5"	style="text-indent: 0px; vertical-align: middle; text-align: left;">
									<span style="font-family: 맑은 고딕; color: #000000; font-size: 10px; line-height: 1.3300781;">
										작성자 이메일이 들어갈곳
									</span>
								</td>
								<td colspan="2"></td>
							</tr>
							<tr valign="top" style="height: 20px">
								<td></td>
								<td colspan="6" style="text-indent: 0px; vertical-align: middle; text-align: left;">
									<span style="font-family: 맑은 고딕; color: #000000; font-size: 10px; line-height: 1.3300781;">
										전화	042-222-8202
									</span>
								</td>
								<td colspan="12"></td>
							</tr>
							<tr valign="top" style="height: 20px">
								<td colspan="9"></td>
								<td colspan="4" style="text-indent: 0px; text-align: center;">
									<span style="font-family: 맑은 고딕; color: #000000; font-size: 8px; line-height: 1.3300781;">
										Me First, 녹색은 생활이다.
									</span>
								</td>
								<td colspan="6"></td>
							</tr>
							<tr valign="top" style="height: 23px">
								<td colspan="19"></td>
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