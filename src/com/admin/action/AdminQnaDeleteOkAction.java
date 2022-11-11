package com.admin.action;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.QnaCommentDAO;
import com.model.QnaDAO;
import com.model.QnaDTO;

public class AdminQnaDeleteOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 문의 게시글을 삭제하는 비지니스 로직.
		
		int no = Integer.parseInt(request.getParameter("no").trim());
		QnaDAO dao = QnaDAO.getInstance();
		QnaCommentDAO CommentDao = QnaCommentDAO.getInstance();

		
		// 파일 저장 폴더
        String saveFolder = request.getSession().getServletContext().getRealPath("/");

        QnaDTO dto = dao.getQnaInfo(no);
		String bbs_file1 = dto.getBbs_file1();
		String bbs_file2 = dto.getBbs_file2();
		
		
		if(bbs_file1 != null){
		    File del_pimage = new File(saveFolder+bbs_file1);
		    if(del_pimage.exists()){
		        if(del_pimage.delete()) {
		            System.out.println("문의글 파일1 삭제 완료");
		        }else {
		            System.out.println("문의글 파일1 삭제 실패");
		        }
		    }
		}
		if(bbs_file2 != null){
		    File del_pimage = new File(saveFolder+bbs_file2);
		    if(del_pimage.exists()){
		        if(del_pimage.delete()) {
		            System.out.println("문의글 파일2 삭제 완료");
		        }else {
		            System.out.println("문의글 파일2 삭제 실패");
		        }
		    }
		}

		int res = dao.deleteQna(no);
		int yes = CommentDao.deleteQnaComment(no);


		ActionForward forward = new ActionForward();
		PrintWriter out = response.getWriter();

		
        if (res > 0) {
            forward.setRedirect(true);
            forward.setPath("qnaList.do");
        } else {
            out.println("<script>alert('문의 게시글 삭제 중 에러가 발생하였습니다.'); history.back();</script>");
        }

		
		
		return forward;
	}

}
