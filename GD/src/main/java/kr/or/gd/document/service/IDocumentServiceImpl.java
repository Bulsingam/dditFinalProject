package kr.or.gd.document.service;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import kr.or.gd.approval.service.IApprovalService;
import kr.or.gd.document.dao.IDocumentDao;
import kr.or.gd.global.CommonConstant;
import kr.or.gd.utils.RolePagingUtil;
import kr.or.gd.vo.DocumentVO;
import net.sf.jasperreports.engine.DefaultJasperReportsContext;
import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperPrintManager;
import net.sf.jasperreports.engine.JasperReport;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
public class IDocumentServiceImpl implements IDocumentService {

	@Autowired
	private IDocumentDao dao;
	@Autowired
	private IApprovalService aprService;

	@Override
	public DocumentVO getDoc(String doc_num) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=SQLException.class)
	public boolean insertDoc(DocumentVO document) throws SQLException {	
		//생성이 성공했을 때 문서 번호를 반환
		String result = dao.insertDoc(document);
		return (result!=null)? true : false;
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, readOnly=true)
	public List<Map<String, String>> getPrgFolder(Map<String, String> params) throws SQLException {
		return dao.getPrgFolder(params);
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, readOnly=true)
	public List<Map<String, String>> getSendFolder(Map<String, String> params) throws SQLException {
		return dao.getSendFolder(params);
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, readOnly=true)
	public List<Map<String, String>> getRecvFolder(Map<String, String> params) throws SQLException {
		return dao.getRecvFolder(params);
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, readOnly=true)
	public List<Map<String, String>> getConfFolder(Map<String, String> params) throws SQLException {
		return dao.getConfFolder(params);
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, readOnly=true)
	public List<Map<String, String>> getRefFolder(Map<String, String> params) throws SQLException {
		return dao.getRefFolder(params);
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, readOnly=true)
	public List<Map<String, String>> getDocMap(Map<String, String> params) throws SQLException {
		return dao.getDocMap(params);
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, readOnly=true)
	public List<String> getHtmlFromJasper(List<Map<String, String>> docInfoList, int page) throws Exception {
		List<String> result = new ArrayList<String>();
		//jasperReport에 전달할 매개변수를 담은 맵 생성
		Map<String, Object> params = new HashMap<String, Object>();
		params = fillingParams(docInfoList.get(0));
		//결재선 생성 및 주입
		Map<String, Object> approvalLine = getApprovalLineMap(docInfoList);
		params.putAll(approvalLine);
		//jrxml 파일 로드
		String path = CommonConstant.FORM_DATA + "\\" + docInfoList.get(0).get("FORM_DATA");
		File reportFile = loadFile(path);
		//페이지 수만큼 리포트 파일을 생성하고 경로를 저장
		for (int i = 0; i <= page; i++) {
			String imageFileName = convertJasperToHtml(reportFile, params, i);
			result.add(imageFileName);			
		}
		return result;
	}
	
	/**
	 * jasperReport의 파라메터 맵을 채우는 메서드
	 * @param 	params 파라메터 내용
	 * @return	jasperReport에 넘어갈 파라메터 맵
	 * @author 	박일훈
	 * @since	2017.09.01	최초 작성<br>
	 * 			2017.09.02	getHtmlFromJasper()메서드에서 분리 및 구현
	 */
	private Map<String, Object> fillingParams(Map<String, String> params){
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("DOC_NUM", String.valueOf(params.get("DOC_NUM")));
		result.put("DOC_TITLE", params.get("DOC_TITLE"));
		result.put("DOC_SEND", params.get("DOC_SEND"));
		result.put("DOC_RECV", params.get("DOC_RECV"));
		result.put("DOC_THRU", params.get("DOC_THRU"));
		result.put("DOC_CONT", params.get("DOC_CONT"));
		result.put("DOC_ADD1", params.get("DOC_ADD1"));
		result.put("DOC_ADD2", params.get("DOC_ADD2"));
		result.put("DOC_ADD3", params.get("DOC_ADD3"));
		result.put("DOC_ADD4", params.get("DOC_ADD4"));
		result.put("DOC_ADD5", params.get("DOC_ADD5"));
		result.put("DOC_REGDATE", new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(params.get("DOC_REGDATE")));
		return result;
	}
	
	/**
	 * 파일 로드 메서드
	 * @param 	path 불러올 파일의 경로
	 * @return	로드한 파일 객체
	 * @throws 	Exception 경로에 파일 미존재시
	 * @author 	박일훈
	 * @since	2017.09.01	최초 작성 및 구현
	 */
	private File loadFile(String path) throws Exception{
		File result = new File(path);
		if (result.exists() == false) {
			//주어진 경로가 존재하지 않을때 Exception 발생
			throw new Exception("해당 경로에 jasper 파일이 존재하지 않습니다.");
		}
		return result;
	}

	/**
	 * 결재선 데이터 생성 메서드
	 * @param 	docInfoList 테이블에 포함될 결재선 정보
	 * @return	결재선 데이터가 담긴 Map
	 * @author 	박일훈
	 * @since	2017.09.01	최초 작성 및 구현<br>
	 * 			2017.09.07	메서드 로직 변경
	 */
	private Map<String, Object> getApprovalLineMap(List<Map<String, String>> docInfoList){
		Map<String, Object> result = new HashMap<String, Object>();
		for (Map<String, String> document : docInfoList) {
			int index = docInfoList.indexOf(document) + 1;
			result.put("APR_EMPPOS"+index, document.get("APR_EMPPOS"));
			result.put("APR_EMPNAME"+index, document.get("APR_EMPNAME"));
			String signPath;
			if(document.get("APR_EMPSIGN")!=null){
				signPath = CommonConstant.EMPLOYEE_SIGN + "\\" + document.get("APR_EMPSIGN");				
			} else {
				signPath = null;
			}
			result.put("APR_EMPSIGN"+index, signPath);
		}
		return result;
	}
	
	/**
	 * jasperReport를 이미지 파일로 추출하는 메서드
	 * @param 	reportFile 로드한 jasperReport템플릿 파일(*.jrxml)
	 * @param 	params 리포트에 입력될 내용
	 * @return	이미지 파일로 생성된 리포트의 이름
	 * @throws 	JRException
	 * @throws 	IOException 
	 * @author 	박일훈
	 * @since	2017.09.01	최초 작성 및 구현<br>
	 * 			2017.09.07	반환 값 및 로직 변경
	 */
	private String convertJasperToHtml(File reportFile, Map<String, Object> params, int page) throws JRException, IOException{
		//jrxml 파일을 컴파일
		JasperReport jasperReport = JasperCompileManager.compileReport(reportFile.getPath());
		//리포트에 내용 삽입
		JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, params, new JREmptyDataSource());
		//이미지 파일경로 생성
		String fileName = System.currentTimeMillis() + ".png";
		String htmlFilePath = CommonConstant.FORM_DATA + "\\" + fileName;
		//작성된 리포트를 이미지 파일로 지정된 경로에 내보내기
		File file = new File(htmlFilePath);
		OutputStream os = new FileOutputStream(file);
		
		JasperPrintManager printManager = JasperPrintManager.getInstance(DefaultJasperReportsContext.getInstance());	
		BufferedImage renderedImage = (BufferedImage) printManager.printToImage(jasperPrint, page, 1.6f);
		ImageIO.write(renderedImage, "png", os);
		//생성된 이미지 파일의 이름을 반환
		return fileName;
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=SQLException.class)
	public int deleteDoc(String doc_num) throws SQLException {
		Map<String, String> params = new HashMap<String, String>();
		params.put("doc_num", doc_num);
		List<Map<String, String>> document = getDocMap(params);
		
		int result = -1;
		if(0 < dao.deleteDoc(doc_num)){
			//문서가 삭제되었을 때, 그 문서가 가지고있는 결재선도 삭제
			result = aprService.deleteAprLine(String.valueOf(document.get(0).get("DET_LINENUM")));
		};
		return result;
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=SQLException.class)
	public boolean updateDoc(DocumentVO document) throws SQLException {
		int result = -1;
		result = dao.updateDoc(document);
		return (result>0)? true: false;
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, readOnly=true)
	public int getTotalCount(Map<String, String> params) throws SQLException {
		if(params.get("currentPage")==null){
			params.put("currentPage", "1");
		}
		params.put("sqlStatement", "document."+params.get("folderName")+"TotalCount");
		int totalCount = dao.getTotalCount(params);
		//불필요한 파라메터 제거
		params.remove("sqlStatement");
		params.remove("folderName");
		return totalCount;
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, readOnly=true)
	public Map<String, String> getTotalByFolder(Map<String, String> params)
			throws SQLException {
		//조건에 만족하는 문서의 개수를 각 문서함별로 취득
		params.put("folderName", "sendFolder");
		int sendFolder = getTotalCount(params);
		params.put("folderName", "recvFolder");
		int recvFolder = getTotalCount(params);
		params.put("folderName", "prgFolder");
		int prgFolder = getTotalCount(params);
		params.put("folderName", "confFolder");
		int confFolder = getTotalCount(params);
		params.put("folderName", "refFolder");
		int refFolder = getTotalCount(params);
		//취득한 문서함별 개수를 Map에 저장
		Map<String, String> result = new HashMap<String, String>();
		result.put("sendFolder", String.valueOf(sendFolder));
		result.put("recvFolder", String.valueOf(recvFolder));
		result.put("prgFolder", String.valueOf(prgFolder));
		result.put("confFolder", String.valueOf(confFolder));
		result.put("refFolder", String.valueOf(refFolder));
		//불필요한 파라매터 제거
		params.remove("folderName");
		return result;
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, readOnly=true)
	public String paging(Map<String, String> params, HttpServletRequest request) throws SQLException {
		if(params.get("currentPage")==null){
			//현재 페이지 정보가 없을 때 1페이지로 설정
			params.put("currentPage", "1");
		}
		int totalCount = getTotalCount(params);
		RolePagingUtil pagingUtil = new RolePagingUtil(Integer.parseInt(params.get("currentPage")), totalCount, request);

		//리스트를 불러오는 파라메터 외의 것들을 지움
		params.remove("currentPage");
		
		params.put("startCount", pagingUtil.getStartCount());
		params.put("endCount", pagingUtil.getEndCount());
		//페이징 HTML 소스를 String 형태로 반환
		return pagingUtil.getPageHtml();
	}

}