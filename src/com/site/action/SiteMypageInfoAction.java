package com.site.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.MemberDAO;
import com.model.MemberDTO;

public class SiteMypageInfoAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

    	
    	MemberDAO dao = MemberDAO.getInstance();
    			
    	HttpSession session = request.getSession();
    	String id = (String)session.getAttribute("login_id");
    	
        MemberDTO dto = dao.getMemberInfo(id);
        request.setAttribute("member", dto);
    	
    	
        ActionForward forward = new ActionForward();
        forward.setRedirect(false);
        forward.setPath("mypage/mypage_info_modify.jsp");

        return forward;
    }

}
