package com.admin.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.MemberDAO;
import com.model.MemberDTO;

public class AdminMemberViewAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

        String member_id = request.getParameter("id");

        MemberDAO dao = MemberDAO.getInstance();
        MemberDTO dto = dao.getMemberInfo(member_id);
        request.setAttribute("member", dto);

        ActionForward forward = new ActionForward();
        forward.setRedirect(false);
        forward.setPath("member/member_view.jsp");

        return forward;
    }

}
