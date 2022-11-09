package com.site.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.MemberDAO;
import com.model.MemberDTO;
import com.model.WishDAO;

public class SiteMemberLoginOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 로그인 시 아이디, 비밀번호, 회원/관리자 구분 대조

		MemberDAO dao = MemberDAO.getInstance();
		WishDAO wdao = WishDAO.getInstance();

		String login_id = request.getParameter("login_id").trim();
		String login_pw = request.getParameter("login_pw").trim();

		int result = dao.idPwTypeCheck(login_id, login_pw);
		MemberDTO dto = dao.getMemberInfo(login_id);
		ActionForward forward = new ActionForward();
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();

		if(result == 0) { // 일치하는 아이디 없음
		    forward = null;
		    out.println("<script>alert('존재하지 않는 아이디입니다.'); location.href='memberLogin.do';</script>");

		}else if(result == -1) { // 비번 오류
		    forward = null;
		    out.println("<script>alert('비밀번호를 다시 확인해주세요.'); location.href='memberLogin.do';</script>");		

		}else if(result == -2) { // admin = -2
			session.setAttribute("login_id", dto.getMember_id());
			session.setAttribute("login_pw", dto.getMember_pw());
			session.setAttribute("login_name", dto.getMember_name());
            session.setAttribute("login_email", dto.getMember_email());
            session.setAttribute("login_phone", dto.getMember_phone());
			session.setAttribute("login_type", "admin");
			session.setAttribute("login_reserv", dao.reservCount(dto.getMember_id()));
			session.setAttribute("login_wish", wdao.getTotalCount(dto.getMember_id()));

			forward.setRedirect(false);
			forward.setPath("admin/");

		}else if(result == -3) { // user = -3
            session.setAttribute("login_id", dto.getMember_id());
            session.setAttribute("login_pw", dto.getMember_pw());
			session.setAttribute("login_name", dto.getMember_name());
            session.setAttribute("login_email", dto.getMember_email());
            session.setAttribute("login_phone", dto.getMember_phone());
			session.setAttribute("login_type", "user");
			session.setAttribute("login_reserv", dao.reservCount(dto.getMember_id()));
			session.setAttribute("login_wish", wdao.getTotalCount(dto.getMember_id()));

			forward = null;
			out.println("<script>alert('"+dto.getMember_name()+"님 안녕하세요 :-)'); location.href='index.jsp';</script>");
		}
		return forward;
	}
}
