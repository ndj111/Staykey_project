package com.admin.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.QnaCommentDAO;
import com.model.QnaCommentDTO;

public class AdminQnaCommentOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 문의글 답변추가 비지니스 로직.
		QnaCommentDTO dto = new QnaCommentDTO();
		QnaCommentDAO dao= QnaCommentDAO.getInstance();
		

        ActionForward forward = new ActionForward();
        PrintWriter out = response.getWriter();
        
        int no = Integer.parseInt(request.getParameter("no").trim());
		String comment_content = request.getParameter("comment_content").trim();
		
		
		if(comment_content.length() <= 0) {
        	out.println("<script>alert('답변 내용을 입력해주세요.'); history.back();</script>");
            forward.setRedirect(true);
            forward.setPath("qnaView.do?no="+no);
            return forward;

		}
		
		// 히든값으로 넘어옴.
		String comment_writer_name = request.getParameter("comment_writer_name").trim();
		String comment_writer_id = request.getParameter("comment_writer_id").trim();
		String comment_writer_pw = request.getParameter("comment_writer_pw").trim();
		
		
		dto.setComment_qnano(no);
		dto.setComment_content(comment_content);
		dto.setComment_writer_name(comment_writer_name);
		dto.setComment_writer_id(comment_writer_id);
		dto.setComment_writer_pw(comment_writer_pw);
		
        int res = dao.registerComment(dto);



        if (res > 0) {
            forward.setRedirect(true);
            forward.setPath("qnaView.do?no="+no);
        }else {
        	out.println("<script>alert('답변 등록 중 에러가 발생하였습니다.'); history.back();</script>");
        }

        return forward;
	}

}
