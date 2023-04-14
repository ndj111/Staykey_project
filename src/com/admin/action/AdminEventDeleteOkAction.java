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

public class AdminEventDeleteOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
			EventDAO dao = EventDAO.getInstance();

	        String saveFolder = request.getSession().getServletContext().getRealPath("/");

	        // 상세 정보 (view) 불러오기
	        int ev_no = Integer.parseInt(request.getParameter("bbs_no"));
	        
			  EventDTO dto = dao.getEventInfo(ev_no);
			  
			  // 이미지 삭제
			  	String bbs_file1 = dto.getBbs_file1();
			  	String bbs_file2 = dto.getBbs_file2();
			  	String bbs_file3 = dto.getBbs_file3();
			  	String bbs_file4 = dto.getBbs_file4();
			  	String bbs_file5 = dto.getBbs_file5();

		        if (bbs_file1 != null) {
		            File del_image = new File(saveFolder + bbs_file1);
		            if (del_image.exists()) {
		                del_image.delete();
		            }
		        }
		        
		        if (bbs_file2 != null) {
		        	File del_image = new File(saveFolder + bbs_file2);
		        	if (del_image.exists()) {
		        		del_image.delete();
		        	}
		        }
		        
		        if (bbs_file3 != null) {
		        	File del_image = new File(saveFolder + bbs_file3);
		        	if (del_image.exists()) {
		        		del_image.delete();
		        	}
		        }
		        
		        if (bbs_file4 != null) {
		        	File del_image = new File(saveFolder + bbs_file4);
		        	if (del_image.exists()) {
		        		del_image.delete();
		        	}
		        }
		        
		        if (bbs_file5 != null) {
		        	File del_image = new File(saveFolder + bbs_file5);
		        	if (del_image.exists()) {
		        		del_image.delete();
		        	}
		        }


	        // 삭제 후 메서드 결과 받아오기
	        int res = dao.deleteEvent(ev_no);

	        ActionForward forward = new ActionForward();
	        PrintWriter out = response.getWriter();

	        if (res > 0) {
	            forward.setRedirect(true);
	            forward.setPath("eventList.do");
	        } else {
	            out.println("<script> alert('삭제 중 에러가 발생했습니다.'); history.back(); </script>");
	        }
	        return forward;
	    }
}
