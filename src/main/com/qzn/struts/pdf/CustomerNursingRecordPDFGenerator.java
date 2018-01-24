
package com.qzn.struts.pdf;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.Image;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPCellEvent;
import com.lowagie.text.pdf.PdfPTable;
import com.qzn.struts.models.User;

/**
 * 介護記録 PDF
 */

class CustomCell implements PdfPCellEvent {
	public void cellLayout(PdfPCell cell, Rectangle position, PdfContentByte[] canvases) {
		PdfContentByte cb = canvases[PdfPTable.LINECANVAS];
		cb.saveState();
		// cb.setLineCap(PdfContentByte.LINE_CAP_ROUND);
		// cb.setLineDash(0, 1, 1);
		cb.setLineWidth(0.5f);
		cb.setLineDash(new float[] { 1.5f, 1.5f }, 0);
		cb.moveTo(position.getLeft(), position.getBottom());
		cb.lineTo(position.getRight(), position.getBottom());
		cb.stroke();
		cb.restoreState();
	}
}

public class CustomerNursingRecordPDFGenerator extends AbstractPDFGenerator<CustomerNursingRecordPDFData> {

	@Override
	protected void drawPDFPage(Document document, BaseFont baseFont, CustomerNursingRecordPDFData data)
			throws DocumentException {

		float first_wid = 0.16f; // 这是所有数据内容的第一个距离

		Font fontTitle = new Font(baseFont, 9); // 这儿是所有标题的字体大小
		Font fontContent = new Font(baseFont, 10, Font.BOLD); // 这儿所有标题后内容的字体大小
		CustomCell border = new CustomCell(); // 虚线

		// Font font_data = new Font(baseFont,9); // 这儿是所有数据的字体大小
		Paragraph paragraph_null = new Paragraph(" ", new Font(baseFont, 6));
		PdfPCell cellnull = new PdfPCell(paragraph_null); // 空列
		cellnull.setBorderWidth(0f);

		if (data.getUserList().size() == 0) {
			this.appendPageTitle(document, baseFont, data, null, fontTitle, fontContent, border, paragraph_null,
					cellnull);
		} else {
			for (int p = 0; p < data.getUserList().size(); p++) {

				User user = data.getUserList().get(p);
				
				// Modify for Comment - start
				if (data.getDownloadOption() == 2 || data.getDownloadOption() == 0) {
					if (p > 0) {
						document.newPage();
					} 
					this.appendPageTitle(document, baseFont, data, user, fontTitle, fontContent, border, paragraph_null,
							cellnull);

					// ◎基本サービス
					String[] string_jiben = { "◎基本サービス", "サービス準備", "健康チェック", "環境整備", "相談援助", "記録記入", "", "", "", "", "", "",
							"◎身体介護", "", "", "", "", "" };
					string_jiben[12] = "";

					Paragraph paragraph_jiben = new Paragraph(string_jiben[0], fontTitle);
					PdfPCell cell_jiben = new PdfPCell(paragraph_jiben);
					PdfPTable table_jiben = new PdfPTable(6);
					table_jiben.setWidthPercentage(100); // 设置表格占据页面可输入部分的百分比
					float[] wid_jiben = { 0.18f, 0.19f, 0.18f, 0.16f, 0.16f, 0.18f };
					table_jiben.setWidths(wid_jiben);

					for (int u = 0; u < 18; u++) {
						paragraph_jiben = new Paragraph(string_jiben[u], fontTitle);
						cell_jiben = new PdfPCell(paragraph_jiben);
						cell_jiben.setBorderWidth(0f);
						table_jiben.addCell(cell_jiben);
					}
					document.add(table_jiben);
					
					document.add(paragraph_null);
					
					String officeRecord = (user.getAddress() == null ? " " : user.getAddress())
							.replace("\r", "").replace("\n", "").replace("\r\n", "");
					String lineTitle = "用户";
					addMutipleLineContent(document, first_wid, fontTitle, border, officeRecord, lineTitle);
					
				}
				// Modify for Comment - end
			}
		}

	}

	private void addMutipleLineContent(Document document, float first_wid, Font fontTitle, CustomCell border,
			String nursingRecord, String lineTitle) throws DocumentException {
		int perLineCharNums = 50;
		int lineNums = nursingRecord.length() / perLineCharNums + 1;
		String strings[] = new String[lineNums];
		for (int i = 0; i < lineNums; i++) {
			int maxLength = (i + 1) * (perLineCharNums - 1);
			if (nursingRecord.length() / (perLineCharNums * (i + 1)) == 0) {
				maxLength = nursingRecord.length() % perLineCharNums + perLineCharNums * i;
			}
			strings[i] = nursingRecord.substring(i * (perLineCharNums - 1), maxLength);
		}

		String paintContent[] = new String[lineNums * 2 + 2];
		paintContent[0] = lineTitle;
		paintContent[1] = "";
		for (int i = 0; i < lineNums; i++) {
			paintContent[2 + i * 2] = "";
			paintContent[3 + i * 2] = strings[i];
		}

		PdfPTable table = new PdfPTable(2);
		table.setWidthPercentage(100);
		float widths[] = { first_wid - 0.02f, (1 - first_wid + 0.02f) };
		table.setWidths(widths);

		for (int i = 0; i < paintContent.length; i++) {
			Paragraph paragraph = new Paragraph(paintContent[i], fontTitle);
			PdfPCell cell = new PdfPCell(paragraph);
			cell.setBorderWidth(0f);
			if (i % 2 == 1 && i != 1) {
				cell.setBorder(Rectangle.NO_BORDER);
				cell.setCellEvent(border);
			}
			table.addCell(cell);
		}
		document.add(table);
	}

	// 毎ページの先頭複用
	private void appendPageTitle(Document document, BaseFont baseFont, CustomerNursingRecordPDFData data,
			User user, Font fontTitle, Font fontContent, CustomCell border, Paragraph paragraph_null,
			PdfPCell cellnull) throws DocumentException {

		// //A4纸的尺寸大小最大为595*842

		PdfPTable table1 = new PdfPTable(3);
		table1.setWidthPercentage(100); // 设置表格占据页面可输入部分的百分比
		float[] wid1 = { 0.30f, 0.65f, 0.05f };
		table1.setWidths(wid1);
		Font font = new Font(baseFont, 12, Font.BOLD);
		Font font_time = new Font(baseFont, 10);
		String officeName = data.getOfficeName();
		String string = new String("■ 介護記録票"); // 这是左上角标题
		SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd HH:mm");
		Paragraph paragraphtime = new Paragraph(format.format(new Date()), font_time); // 这是右上角时间
		Paragraph paragraph2 = new Paragraph(string, font);
		Paragraph paragraph_officeName = new Paragraph(officeName, font_time); // 事务所名字
		PdfPCell cell01 = new PdfPCell(paragraph2);
		PdfPCell cell02 = new PdfPCell(paragraphtime);
		PdfPCell cell_1 = new PdfPCell(new Paragraph(" ", font_time));
		PdfPCell cell_2 = new PdfPCell(paragraph_officeName);
		cell01.setBorderWidth(0f);
		cell02.setBorderWidth(0f);
		cell02.setHorizontalAlignment(Element.ALIGN_RIGHT); // 文字居右
		cell_1.setBorderWidth(0f);
		cell_2.setBorderWidth(0f);
		cell_2.setHorizontalAlignment(Element.ALIGN_RIGHT); // 文字居右
		table1.addCell(cell_1);
		table1.addCell(cell_2);
		table1.addCell(cell_1);
		table1.addCell(cell01);
		table1.addCell(cell02);
		table1.addCell(cell_1);
		document.add(table1);
		document.add(paragraph_null);

		String name_top_1 = data.getOfficeName();
		String cusnameString = name_top_1 + "　様　" + data.getOfficeName(); // 利用者/利用者番号
		Font fontContent_set = new Font(baseFont, 10, Font.BOLD);
		PdfPTable table_1_top = new PdfPTable(2);
		table_1_top.setWidthPercentage(100); // 设置表格占据页面可输入部分的百分比
		float[] wid_1_top = { 0.22f, 0.78f };
		table_1_top.setWidths(wid_1_top);
		Paragraph paragraph_1_top_title = new Paragraph("◎利用者／利用者番号", fontTitle);
		Paragraph paragraph_2_top_title = new Paragraph(cusnameString, fontContent);
		PdfPCell cell_1_top = new PdfPCell(paragraph_1_top_title);
		PdfPCell cell_2_top = new PdfPCell(paragraph_2_top_title);
		cell_1_top.setBorderWidth(0f);
		cell_2_top.setBorderWidth(0f);
		cell_2_top.setHorizontalAlignment(Element.ALIGN_RIGHT); // 文字居右
		cell_2_top.setBorder(Rectangle.NO_BORDER);
		cell_2_top.setCellEvent(border);
		table_1_top.addCell(cell_1_top);
		table_1_top.addCell(cell_2_top);
		document.add(table_1_top);

		String visitWeekDateString = " ";
		String serviceTime = " ";
		String getUserName = " ";
		String getUserNameFollow = " "; // 職員（同行）
		String[] string_top1 = { "◎訪問年月日", "◎サービス時間", " " };
		if (user.getUserCode() != null) {
			String visitDatesString = user.getUserCode(); // 訪問年月日
			visitDatesString = visitDatesString.substring(0, 4) + "年" + visitDatesString.substring(5, 7) + "月"
					+ visitDatesString.substring(8, 10) + "日";
			visitWeekDateString = visitDatesString + getWeekByDateStr(visitDatesString);
			serviceTime = user.getUserCode() + " ～ " + user.getUserCode(); // サービス時間

			getUserName = user.getUserCode();
			getUserNameFollow = user.getUserCode(); // 職員（同行）
		}
		String[] string_top1_name = { visitWeekDateString, serviceTime, " " };

		String getnameString = data.getServiceUserName();
		String[] string_top2 = { "◎職員（主）", "◎職員（同行）", "◎サービス提供責任者" };
		String[] string_top2_name = { getUserName, getUserNameFollow, getnameString };
		Paragraph paragraph_top1 = new Paragraph(string_top1[0], fontTitle);
		Paragraph paragraph_top1_name = new Paragraph(string_top1_name[0], fontContent);
		Paragraph paragraph_top2 = new Paragraph(string_top2[0], fontTitle);
		Paragraph paragraph_top2_name = new Paragraph(string_top2_name[0], fontContent);
		PdfPCell cell1 = new PdfPCell(paragraph_top1);
		PdfPCell cell2 = new PdfPCell(paragraph_top1_name);
		PdfPCell cell3 = new PdfPCell(paragraph_top2);
		PdfPCell cell4 = new PdfPCell(paragraph_top2_name);
		PdfPTable table_top = new PdfPTable(5);
		table_top.setWidthPercentage(100); // 设置表格占据页面可输入部分的百分比
		float[] wid_top = { 0.22f, 0.31f, 0.05f, 0.21f, 0.21f };
		table_top.setWidths(wid_top);
		for (int q = 0; q < 3; q++) {
			paragraph_top1 = new Paragraph(string_top1[q], fontTitle);
			paragraph_top1_name = new Paragraph(string_top1_name[q], fontContent);
			if (q == 0) {
				paragraph_top1_name = new Paragraph(string_top1_name[q], fontContent_set);
			}
			paragraph_top2 = new Paragraph(string_top2[q], fontTitle);
			paragraph_top2_name = new Paragraph(string_top2_name[q], fontContent);
			cell1 = new PdfPCell(paragraph_top1);
			cell2 = new PdfPCell(paragraph_top1_name);
			cell3 = new PdfPCell(paragraph_top2);
			cell4 = new PdfPCell(paragraph_top2_name);
			cell1.setBorderWidth(0f);
			// cell2.setBorderWidth(0f);
			cell3.setBorderWidth(0f);
			// cell4.setBorderWidth(0f);
			cell2.setBorder(Rectangle.NO_BORDER);
			cell2.setCellEvent(border);
			cell4.setBorder(Rectangle.NO_BORDER);
			cell4.setCellEvent(border);
			cell2.setHorizontalAlignment(Element.ALIGN_RIGHT); // 文字居右
			cell4.setHorizontalAlignment(Element.ALIGN_RIGHT); // 文字居右
			if (q != 2) {
				table_top.addCell(cell1);
				table_top.addCell(cell2);
				table_top.addCell(cellnull);
				table_top.addCell(cell3);
				table_top.addCell(cell4);
			} else {
				table_top.addCell(cellnull);
				table_top.addCell(cellnull);
				table_top.addCell(cellnull);
				table_top.addCell(cell3);
				table_top.addCell(cell4);
			}

		}
		document.add(table_top);
		document.add(paragraph_null); // 空行
		
		String[] string_qufen = { "◎サービス内容", user.getUserCode() == null ? "" : user.getUserCode(), "",
				"（  " + (user.getUserCode() == null ? "0" : user.getUserCode()) + "分）",
				"（  " + (user.getUserCode() == null ? "0" : user.getUserCode()) + "分）", " ", "◎加算",
				user.getUserCode() == null ? "" : (user.getUserCode() == "" ? "初回"
						: (user.getUserCode() == "" ? "緊急時訪問介護" : " ")),
				" ", " ", " ", " " };

		Paragraph paragraph_qufen = new Paragraph(string_qufen[0], fontTitle);
		PdfPCell cellqf = new PdfPCell(paragraph_qufen);
		PdfPTable table_qufen = new PdfPTable(6);
		table_qufen.setWidthPercentage(100); // 设置表格占据页面可输入部分的百分比
		float[] wid_qufen = { 0.16f, 0.72f, 0.03f, 0.13f, 0.13f, 0.03f };
		table_qufen.setWidths(wid_qufen);

		for (int u = 0; u < 12; u++) {
			paragraph_qufen = new Paragraph(string_qufen[u], fontTitle);
			if (u == 1 || u == 7) {
				paragraph_qufen = new Paragraph(string_qufen[u], fontContent);
			}
			cellqf = new PdfPCell(paragraph_qufen);
			cellqf.setBorderWidth(0f);
			if (u == 1 || u == 3 || u == 4 || u == 7) {
				cellqf.setBorder(Rectangle.NO_BORDER);
				cellqf.setCellEvent(border);
			}
			table_qufen.addCell(cellqf);

		}
		document.add(table_qufen);
		document.add(paragraph_null);
	}

	@Override
	protected Rectangle getPageSize() {
		Rectangle rect = new Rectangle(PageSize.A4);
		return rect;
	}

	public static String getWeekByDateStr(String strDate) {

		int year = Integer.parseInt(strDate.substring(0, 4));
		int month = Integer.parseInt(strDate.substring(5, 7));
		int day = Integer.parseInt(strDate.substring(8, 10));

		Calendar c = Calendar.getInstance();

		c.set(Calendar.YEAR, year);
		c.set(Calendar.MONTH, month - 1);
		c.set(Calendar.DAY_OF_MONTH, day);

		String week = "";
		int weekIndex = c.get(Calendar.DAY_OF_WEEK);

		switch (weekIndex) {
		case 1:
			week = "（日）";
			break;
		case 2:
			week = "（月）";
			break;
		case 3:
			week = "（火）";
			break;
		case 4:
			week = "（水）";
			break;
		case 5:
			week = "（木）";
			break;
		case 6:
			week = "（金）";
			break;
		case 7:
			week = "（土）";
			break;
		}

		return week;
	}

	public static Image getImage(Document document, int x, int y, int z) {
		Image image = null;
		try {

			if (z == 1) {
				image = Image.getInstance(CustomerNursingRecordPDFGenerator.class.getResource("pdf_v.png"));
				image.scaleAbsolute(11, 13); // 图片大小
			} else {
				image = Image.getInstance(CustomerNursingRecordPDFGenerator.class.getResource("pdf_null.png"));
				image.scaleAbsolute(11, 13); // 图片大小
			}

			image.setAbsolutePosition(x, y); // 图片位置

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("图片错误");
		}
		return image;

	}

}
