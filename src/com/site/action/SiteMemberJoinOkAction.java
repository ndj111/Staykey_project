package com.site.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.MemberDAO;
import com.model.MemberDTO;

public class SiteMemberJoinOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		MemberDAO dao = MemberDAO.getInstance();
		MemberDTO dto = new MemberDTO();

		String member_id = request.getParameter("join_id");
		String member_pw = request.getParameter("join_pw");
		String member_name = request.getParameter("join_name");
		String member_email = request.getParameter("join_email");
		String member_phone = request.getParameter("join_phone");

		dto.setMember_id(member_id);
		dto.setMember_pw(member_pw);
		dto.setMember_name(member_name);
		dto.setMember_email(member_email);
		dto.setMember_phone(member_phone);


        PrintWriter out = response.getWriter();

        int res = dao.registerMember(dto);

        if (res > 0) {
            out.println("<script>var webSocket = new WebSocket(\"ws://121.164.91.191:8080/Staykey_project/webSocket\"); "
                    + "webSocket.onopen = function(event) { webSocket.send(\"join|"+member_name+"|"+member_id+"|"+member_name+"님 회원가입|"+member_id+"\"); "
                    + "webSocket.close(); };</script>");
            out.println("<script>setTimeout(function(){ alert('스테이:키의 회원이 되어주셔서 감사합니다 :-)'); location.href='main.do'; }, 500);</script>");

		}else{
            out.println("<script>alert('회원 가입 중 에러가 발생했습니다.'); history.back();</script>");
		}

		return null;

	}

}
