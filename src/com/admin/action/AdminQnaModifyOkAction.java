package com.admin.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.QnaDAO;
import com.model.QnaDTO;

public class AdminQnaModifyOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		QnaDTO dto = new QnaDTO();
		QnaDAO dao = QnaDAO.getInstance();

		int no = Integer.parseInt(request.getParameter("no").trim());
		String bbs_status = request.getParameter("bbs_status").trim();


		dto.setBbs_no(no);
		dto.setBbs_status(bbs_status);

        int check = dao.statusModify(dto);
        PrintWriter out = response.getWriter();

        if (check > 0) {
            out.println("<script>opener.parent.location.reload(); location.href='qnaView.do?no="+no+"';</script>");

        }else{
            out.println("<script>alert('문의글 상태 수정 중 에러가 발생하였습니다.'); history.back();</script>");
        }

        return null;
	}

}
