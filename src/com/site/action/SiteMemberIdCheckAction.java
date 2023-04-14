package com.site.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.MemberDAO;

public class SiteMemberIdCheckAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html; charset=UTF-8");

        String member_id = request.getParameter("paramId");
        
        MemberDAO dao = MemberDAO.getInstance();
        int result = dao.idCheck(member_id);

        PrintWriter out = response.getWriter();
        out.println(result);

        return null;
    }

}
