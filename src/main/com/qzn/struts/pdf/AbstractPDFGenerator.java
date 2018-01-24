package com.qzn.struts.pdf;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.PageSize;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfWriter;

public abstract class AbstractPDFGenerator<T> {

	protected final Log log = LogFactory.getLog(AbstractPDFGenerator.class);

	private String tempFileFolder;

	public void setTempFileFolder(String tempFileFolder) {
		this.tempFileFolder = tempFileFolder;
	}

	public void removeTempPDF(File file) {
		if (file != null && file.exists()) {
			file.delete();
		}
	}

	public boolean downloadPDF(HttpServletResponse response, String fileName, T data) {
		List<T> datas = new ArrayList<T>();
		datas.add(data);
		return this.downloadPDF(response, fileName, datas);
	}

	public boolean downloadPDF(HttpServletResponse response, String fileName, List<T> datas) {

		boolean result = false;

		File file = this.generatePDF(datas);

		if (file != null) {

			FileInputStream fis = null;
			BufferedInputStream bis = null;
			OutputStream os = null;
			BufferedOutputStream bos = null;

			try {
				fis = new FileInputStream(file);
				bis = new BufferedInputStream(fis);

				os = response.getOutputStream();
				bos = new BufferedOutputStream(os);
				
				FileGeneratorHelper.setResponseHeader(response, fileName, bis.available());
				
				int bytesRead = 0;

				byte[] buffer = new byte[1024];

				while ((bytesRead = bis.read(buffer)) != -1) {

					bos.write(buffer, 0, bytesRead);
				}

				bos.flush();
				bos.close();
				bos = null;
				bis.close();
				bis = null;
				os.close();
				os = null;
				fis.close();
				fis = null;

				this.removeTempPDF(file);
				result = true;

			} catch (FileNotFoundException e) {
				log.error(e);
			} catch (IOException e) {
				log.error(e);
			} finally {
				if (bos != null)
					try {
						bos.close();
					} catch (IOException e) {
					}
				if (bis != null)
					try {
						bis.close();
					} catch (IOException e) {
					}
				if (os != null)
					try {
						os.close();
					} catch (IOException e) {
					}
				if (fis != null)
					try {
						fis.close();
					} catch (IOException e) {
					}
			}
		}

		return result;
	}

	public File generatePDF(T data) {
		List<T> datas = new ArrayList<T>();
		datas.add(data);
		return this.generatePDF(datas);
	}

	public File generatePDF(List<T> datas) {

		File result = null;

		Document document = null;
		PdfWriter pdfWriter = null;

		try {

			Rectangle rect = this.getPageSize();
			document = new Document(rect);

			File folder = new File(this.tempFileFolder);
			if (folder == null || !folder.exists() || !folder.isDirectory()) {
				folder.mkdir();
			}

			String FileName = this.tempFileFolder + "/" + UUID.randomUUID().toString();
			log.info("temp pdf file name: " + FileName);
			BaseFont baseFont = BaseFont.createFont("HeiseiMin-W3", "UniJIS-UCS2-HW-H", false);
			pdfWriter = PdfWriter.getInstance(document, new FileOutputStream(FileName));

			// 添加页码
			this.setFooter(pdfWriter);
			pdfWriter.setFullCompression();
			pdfWriter.setPdfVersion(PdfWriter.VERSION_1_4);
			document.open();
			for (int i = 0; i < datas.size(); i++) {
				if (i > 0) {
					document.newPage();
				}
				this.drawPDFPage(document, baseFont, datas.get(i));
				pdfWriter.setPageEmpty(false); // 如果是空pdf，不加这句会什么都不显示
			}

			document.close();
			document = null;
			pdfWriter.close();
			pdfWriter = null;

			result = new File(FileName);

		} catch (FileNotFoundException e) {
			log.error(e);
		} catch (DocumentException e) {
			log.error(e);
		} catch (IOException e) {
			log.error(e);
		} finally {
			if (document != null)
				document.close();
			if (pdfWriter != null)
				pdfWriter.close();
		}

		return result;
	}

	protected abstract void drawPDFPage(Document document, BaseFont baseFont, T data) throws DocumentException;

	protected abstract Rectangle getPageSize();

	private void setFooter(PdfWriter writer) throws DocumentException, IOException {
		// HeaderFooter headerFooter = new HeaderFooter(this);
		// 更改事件，瞬间变身 第几页/共几页 模式。
		PdfReportM1HeaderFooter headerFooter = new PdfReportM1HeaderFooter();// 页码类
		writer.setBoxSize("art", PageSize.A4);
		writer.setPageEvent(headerFooter);
	}
}
