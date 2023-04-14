package com.site.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.MemberDAO;
import com.model.ReservDAO;
import com.model.ReservDTO;

public class SiteMypageReservListAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

    	HttpSession session = request.getSession();
    	String id = (String)session.getAttribute("login_id");

        // 아이디로 예약 정보 리스트 가져오기
        ReservDAO dao = ReservDAO.getInstance();
    	List<ReservDTO> list = dao.getSiteReservList(id);
        request.setAttribute("reservList", list);

        // 현재 페이지 타입 가져오기
        String nowType = request.getParameter("type");
        if(nowType == "" || nowType == null) nowType = "come";
        request.setAttribute("getType", nowType);

        ActionForward forward = new ActionForward();
        forward.setRedirect(false);
        forward.setPath("mypage/mypage_reserv_list.jsp");

        MemberDAO mdao = MemberDAO.getInstance();
        mdao.reservCount(id);
        return forward;
    }

}
