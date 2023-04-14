package com.admin.action;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.ReviewDAO;
import com.model.ReviewDTO;

public class AdminReviewDeleteOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 리뷰 정보를 삭제하는 비지니스 로직입니다.
		int reviewNo = Integer.parseInt(request.getParameter("id").trim());

		ReviewDAO dao = ReviewDAO.getInstance();

		// 파일 저장 폴더
		String saveFolder = request.getSession().getServletContext().getRealPath("/");

		ReviewDTO dto = dao.getReviewInfo(reviewNo);
		String review_file = dto.getReview_file();

		if (review_file != null) {
			File del_pimage = new File(saveFolder + review_file);
			if (del_pimage.exists()) {
				if (del_pimage.delete()) {
					System.out.println("리뷰 사진 파일 삭제 완료");
				} else {
					System.out.println("리뷰 사진 파일 삭제 실패");
				}
			}
		}

		int res = dao.deleteReview(reviewNo);

		ActionForward forward = new ActionForward();
		PrintWriter out = response.getWriter();

		if (res > 0) {
			forward.setRedirect(true);
			forward.setPath("reviewList.do");
		} else {
			out.println("<script>alert('후기 삭제 중 에러가 발생하였습니다.'); history.back();</script>");
		}

		return forward;
	}

}
