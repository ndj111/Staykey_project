package com.site.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.MemberDAO;


public class SiteMypageExitOkAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
        MemberDAO dao = MemberDAO.getInstance();

        String member_id = request.getParameter("member_id").trim();

        ActionForward forward = new ActionForward();
        PrintWriter out = response.getWriter();

        int result = dao.exitMember(member_id);

        if(result > 0){
            // 세션 삭제
            HttpSession session = request.getSession();
            session.invalidate();

            forward.setRedirect(false);
            forward.setPath("index.jsp");

        }else{
            forward = null;
            out.println("<script>alert('회원 탈퇴 중 에러가 발생하였습니다.'); history.back();</script>");
        }

        return forward;
    }

}
