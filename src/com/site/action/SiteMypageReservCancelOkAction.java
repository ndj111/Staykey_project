package com.site.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.ReservDAO;

public class SiteMypageReservCancelOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

	    int reserv_no = Integer.parseInt(request.getParameter("reserv_no"));
	    String reserv_sess = request.getParameter("reserv_sess");
	    String reserv_pw = request.getParameter("reserv_pw");
	    String login_pw = request.getParameter("login_pw");

	    ReservDAO dao = ReservDAO.getInstance();
	    int result = dao.cancelReserv(reserv_no, reserv_sess, reserv_pw, login_pw);


		ActionForward forward = new ActionForward();
		PrintWriter out = response.getWriter();

		if(result > 0){
	        forward.setRedirect(true);
	        forward.setPath("mypageReservList.do");

		}else if(result == -1){
		    forward = null;
		    out.println("<script>alert('회원 비밀번호가 일치하지 않습니다.'); history.back();</script>");

		}else{
            forward = null;
            out.println("<script>alert('예약취소 중 에러가 발생하였습니다.'); history.back();</script>");

		}

		return forward;
	}

}
