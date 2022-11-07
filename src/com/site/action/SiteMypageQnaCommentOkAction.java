package com.site.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.QnaCommentDAO;
import com.model.QnaCommentDTO;

public class SiteMypageQnaCommentOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

        QnaCommentDAO dao = QnaCommentDAO.getInstance();


        // 파라미터 값 가져오기
        int comment_qnano = Integer.parseInt(request.getParameter("qna_no").trim());
		String comment_content = request.getParameter("comment_content").trim();
		String comment_writer_name = request.getParameter("comment_writer_name").trim();
		String comment_writer_id = request.getParameter("comment_writer_id").trim();
		String comment_writer_pw = request.getParameter("comment_writer_pw").trim();


		// 객체에 저장
        QnaCommentDTO dto = new QnaCommentDTO();
		dto.setComment_qnano(comment_qnano);
		dto.setComment_content(comment_content);
		dto.setComment_writer_name(comment_writer_name);
		dto.setComment_writer_id(comment_writer_id);
		dto.setComment_writer_pw(comment_writer_pw);


        ActionForward forward = new ActionForward();
        PrintWriter out = response.getWriter();
        int result = dao.registerComment(dto);

        if(result > 0){
            forward.setRedirect(false);
            forward.setPath("mypageQnaView.do?no="+comment_qnano);

        }else{
            forward = null;
        	out.println("<script>alert('답변 등록 중 에러가 발생하였습니다.'); history.back();</script>");
        }

        return forward;

	}

}
