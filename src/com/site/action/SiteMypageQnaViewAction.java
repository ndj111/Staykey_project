package com.site.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.QnaCommentDAO;
import com.model.QnaCommentDTO;
import com.model.QnaDAO;
import com.model.QnaDTO;

public class SiteMypageQnaViewAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
    	int no = Integer.parseInt(request.getParameter("no").trim());

        QnaDAO dao = QnaDAO.getInstance();

        // 문의글 내용
        QnaDTO dto = dao.getQnaInfo(no);
        request.setAttribute("qna", dto);

        // 댓글 목록
        QnaCommentDAO commentDao = QnaCommentDAO.getInstance();
        List<QnaCommentDTO> commentDto = commentDao.getQnaCommentInfo(no);
        request.setAttribute("List", commentDto);

        // 첨부파일 확장자
        if(dto.getBbs_file1() != null){
            String ext1 = dto.getBbs_file1().substring(dto.getBbs_file1().lastIndexOf(".") + 1);
            request.setAttribute("ext1", ext1);
        }
        if(dto.getBbs_file2() != null){
            String ext2 = dto.getBbs_file2().substring(dto.getBbs_file2().lastIndexOf(".") + 1);
            request.setAttribute("ext2", ext2);
        }

        ActionForward forward = new ActionForward();
        forward.setRedirect(false);
        forward.setPath("mypage/mypage_qna_view.jsp");

        return forward;
    }

}
