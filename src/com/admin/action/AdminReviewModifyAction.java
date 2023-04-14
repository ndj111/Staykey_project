package com.admin.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.ReviewDAO;
import com.model.ReviewDTO;

public class AdminReviewModifyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 후기 목록으로 가는 비지니스 로직
		
        int no = Integer.parseInt(request.getParameter("id").trim());

        ReviewDAO dao = ReviewDAO.getInstance();
        ReviewDTO dto = dao.getReviewInfo(no);

        request.setAttribute("member", dto);

        ActionForward forward = new ActionForward();
        forward.setRedirect(false);
        forward.setPath("review/review_modify.jsp");

		return forward;
	}

}
