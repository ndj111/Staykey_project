package com.admin.action;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.EventDAO;
import com.model.EventDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class AdminEventWriteOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
	
		EventDTO dto = new EventDTO();
		

		// 파일 업로드 설정
		String thisFolder = "/data/event/";
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
		String ev_title = multi.getParameter("ev_title");
		String ev_content = multi.getParameter("ev_content");
		String ev_stayno = multi.getParameter("ev_stayno");
		String ev_start = multi.getParameter("ev_showstart");
		String ev_end = multi.getParameter("ev_showend");
		String ev_writer_name = multi.getParameter("ev_writer_name");
		String ev_writer_id = multi.getParameter("ev_writer_id");
		String ev_writer_pw = multi.getParameter("ev_writer_pw");

		
		// 첨부파일 이름 변경 처리
		File ev_file1 = multi.getFile("ev_file1");
		if (ev_file1 != null) {
			String fileExt = ev_file1.getName().substring(ev_file1.getName().lastIndexOf(".") + 1);
			
			String mag_flie_rename = "ev_file1" + System.currentTimeMillis() + "." + fileExt;
			ev_file1.renameTo(new File(saveFolder + "/" + mag_flie_rename));

			// DB에 저장되는 파일 이름
			// 저장이름 : /data/저장폴더/회원아이디_현재날짜(유닉스타임)
			String fileDBName = thisFolder + mag_flie_rename;
			dto.setBbs_file1(fileDBName);
		}
		
		
		// 첨부파일 이름 변경 처리
		File ev_file2 = multi.getFile("ev_file2");
		if (ev_file2 != null) {
			String fileExt = ev_file2.getName().substring(ev_file2.getName().lastIndexOf(".") + 1);
			
			String mag_flie_rename = "ev_file2" + System.currentTimeMillis() + "." + fileExt;
			ev_file2.renameTo(new File(saveFolder + "/" + mag_flie_rename));
			
			// DB에 저장되는 파일 이름
			// 저장이름 : /data/저장폴더/회원아이디_현재날짜(유닉스타임)
			String fileDBName = thisFolder + mag_flie_rename;
			dto.setBbs_file2(fileDBName);
		}
		
		
		// 첨부파일 이름 변경 처리
		File ev_file3 = multi.getFile("ev_file3");
		if (ev_file3 != null) {
			String fileExt = ev_file3.getName().substring(ev_file3.getName().lastIndexOf(".") + 1);
			
			String mag_flie_rename = "ev_file3" + System.currentTimeMillis() + "." + fileExt;
			ev_file3.renameTo(new File(saveFolder + "/" + mag_flie_rename));
			
			// DB에 저장되는 파일 이름
			// 저장이름 : /data/저장폴더/회원아이디_현재날짜(유닉스타임)
			String fileDBName = thisFolder + mag_flie_rename;
			dto.setBbs_file3(fileDBName);
		}
		
		
		// 첨부파일 이름 변경 처리
		File ev_file4 = multi.getFile("ev_file4");
		if (ev_file4 != null) {
			String fileExt = ev_file4.getName().substring(ev_file4.getName().lastIndexOf(".") + 1);
			
			String mag_flie_rename = "ev_file4" + System.currentTimeMillis() + "." + fileExt;
			ev_file4.renameTo(new File(saveFolder + "/" + mag_flie_rename));
			
			// DB에 저장되는 파일 이름
			// 저장이름 : /data/저장폴더/회원아이디_현재날짜(유닉스타임)
			String fileDBName = thisFolder + mag_flie_rename;
			dto.setBbs_file4(fileDBName);
		}
		
		
		// 첨부파일 이름 변경 처리
		File ev_file5 = multi.getFile("ev_file5");
		if (ev_file5 != null) {
			String fileExt = ev_file5.getName().substring(ev_file5.getName().lastIndexOf(".") + 1);
			
			String mag_flie_rename = "ev_file5" + System.currentTimeMillis() + "." + fileExt;
			ev_file5.renameTo(new File(saveFolder + "/" + mag_flie_rename));
			
			// DB에 저장되는 파일 이름
			// 저장이름 : /data/저장폴더/회원아이디_현재날짜(유닉스타임)
			String fileDBName = thisFolder + mag_flie_rename;
			dto.setBbs_file5(fileDBName);
		}

		
		dto.setBbs_title(ev_title);
		dto.setBbs_content(ev_content);
		dto.setBbs_stayno(ev_stayno);
		dto.setBbs_showstart(ev_start);
		dto.setBbs_showend(ev_end);
		dto.setBbs_writer_name(ev_writer_name);
		dto.setBbs_writer_id(ev_writer_id);
		dto.setBbs_writer_pw(ev_writer_pw);

		
		EventDAO dao = EventDAO.getInstance();
		int res = dao.registerEvent(dto);
		

		ActionForward forward = new ActionForward();
		PrintWriter out = response.getWriter();
        
		if (res > 0) {
			forward.setRedirect(true);
			forward.setPath("eventList.do");
		} else {
			out.println("<script>alert('이벤트 등록 중 에러가 발생했습니다.'); history.back();</script>");
		}
		return forward;
	}


}
