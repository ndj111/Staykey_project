package com.admin.action;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.MagazineDAO;
import com.model.MagazineDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class AdminMagazineWriteOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		MagazineDTO dto = new MagazineDTO();

		// 파일 업로드 설정
		String thisFolder = "/data/magazine/";
		String saveFolder = request.getSession().getServletContext().getRealPath(thisFolder);
		int fileSize = 10 * 1024 * 1024; // 10MB

		// 업로드 폴더 체크 후 없으면 생성
		File dirChk = new File(saveFolder);
		if (!dirChk.exists()) {
			dirChk.mkdir();
		}

		// 파일 업로드 객체 생성
		MultipartRequest multi = new MultipartRequest(request, saveFolder, fileSize, "UTF-8",
				new DefaultFileRenamePolicy());

		// 파라미터 정리
		String mag_title = multi.getParameter("mag_title");
		String mag_youtube = multi.getParameter("mag_youtube");
		String mag_content1 = multi.getParameter("mag_content1");
		String mag_content2 = multi.getParameter("mag_content2");
		String mag_map = multi.getParameter("mag_map");
		String mag_content3 = multi.getParameter("mag_content3");
		String mag_stayno = multi.getParameter("mag_stayno");
		String mag_writer_name = multi.getParameter("mag_writer_name");
		String mag_writer_id = multi.getParameter("mag_writer_id");
		String mag_writer_pw = multi.getParameter("mag_writer_pw");

		// 첨부파일 이름 변경 처리
		File mag_list_img = multi.getFile("mag_list_img");
		if (mag_list_img != null) {
			String fileExt = mag_list_img.getName().substring(mag_list_img.getName().lastIndexOf(".") + 1);
			String mag_flie_rename = "mag_list_img_" + System.currentTimeMillis() + "." + fileExt;
			mag_list_img.renameTo(new File(saveFolder + "/" + mag_flie_rename));

			// DB에 저장되는 파일 이름
			// 저장이름 : /data/저장폴더/회원아이디_현재날짜(유닉스타임)
			String fileDBName = thisFolder + mag_flie_rename;
			dto.setBbs_list_img(fileDBName);
		}

		// 첨부파일 이름 변경 처리
		File mag_top_img = multi.getFile("mag_top_img");
		if (mag_top_img != null) {
			String fileExt = mag_top_img.getName().substring(mag_top_img.getName().lastIndexOf(".") + 1);
			String mag_flie_rename = "mag_top_img_" + System.currentTimeMillis() + "." + fileExt;
			mag_top_img.renameTo(new File(saveFolder + "/" + mag_flie_rename));

			// DB에 저장되는 파일 이름
			// 저장이름 : /data/저장폴더/회원아이디_현재날짜(유닉스타임)
			String fileDBName = thisFolder + mag_flie_rename;
			dto.setBbs_top_img(fileDBName);
		}

		// 첨부파일 이름 변경 처리
		File mag_detail_img1 = multi.getFile("mag_detail_img1");
		if (mag_detail_img1 != null) {
			String fileExt = mag_detail_img1.getName().substring(mag_detail_img1.getName().lastIndexOf(".") + 1);
			String mag_flie_rename = "mag_detail_img1_" + System.currentTimeMillis() + "." + fileExt;
			mag_detail_img1.renameTo(new File(saveFolder + "/" + mag_flie_rename));

			// DB에 저장되는 파일 이름
			// 저장이름 : /data/저장폴더/회원아이디_현재날짜(유닉스타임)
			String fileDBName = thisFolder + mag_flie_rename;
			dto.setBbs_detail_img1(fileDBName);
		}

		// 첨부파일 이름 변경 처리
		File mag_detail_img2 = multi.getFile("mag_detail_img2");
		if (mag_detail_img2 != null) {
			String fileExt = mag_detail_img2.getName().substring(mag_detail_img2.getName().lastIndexOf(".") + 1);
			String mag_flie_rename = "mag_detail_img2_" + System.currentTimeMillis() + "." + fileExt;
			mag_detail_img2.renameTo(new File(saveFolder + "/" + mag_flie_rename));

			// DB에 저장되는 파일 이름
			// 저장이름 : /data/저장폴더/회원아이디_현재날짜(유닉스타임)
			String fileDBName = thisFolder + mag_flie_rename;
			dto.setBbs_detail_img2(fileDBName);
		}
		
		dto.setBbs_title(mag_title);
		dto.setBbs_youtube(mag_youtube);
		dto.setBbs_content1(mag_content1);
		dto.setBbs_content2(mag_content2);
		dto.setBbs_map(mag_map);
		dto.setBbs_content3(mag_content3);
		dto.setBbs_stayno(mag_stayno);
		dto.setBbs_writer_name(mag_writer_name);
		dto.setBbs_writer_id(mag_writer_id);
		dto.setBbs_writer_pw(mag_writer_pw);

		MagazineDAO dao = MagazineDAO.getInstance();
		int res = dao.registerMagazine(dto);
		

		ActionForward forward = new ActionForward();
		PrintWriter out = response.getWriter();
        
		if (res > 0) {
			forward.setRedirect(true);
			forward.setPath("magazineList.do");
		} else {
			out.println("<script>alert('매거진 등록 중 에러가 발생했습니다.'); history.back();</script>");
		}
		return forward;
	}

}
