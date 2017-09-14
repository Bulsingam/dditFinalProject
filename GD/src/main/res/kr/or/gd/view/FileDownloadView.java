package kr.or.gd.view;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.AbstractView;

@Component("downloadView")
public class FileDownloadView extends AbstractView {

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		File downloadFile = (File) model.get("downloadFile");
		
		response.setHeader("Content-Disposition", "attachment;fileName="+downloadFile.getName());
		response.setContentType("application/octet-steam");
		response.setContentLength((int)downloadFile.length());
		
		byte[] buffer = new byte[(int)downloadFile.length()];
		
		BufferedInputStream bi = new BufferedInputStream(new FileInputStream(downloadFile));
		BufferedOutputStream bo = new BufferedOutputStream(response.getOutputStream());
		int read = 0;
		while((read = bi.read(buffer)) != -1){
			bo.write(buffer, 0, read);
		}
		bi.close();
		bo.close();
	}

}
