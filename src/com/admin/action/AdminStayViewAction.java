package com.admin.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.StayDAO;
import com.model.StayDTO;
import com.model.StayRoomDTO;

public class AdminStayViewAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 전체 목록 클릭 시 -> 상세 정보 보기 + Room 정보 보기
		
		int stayNo = Integer.parseInt(request.getParameter("stay_no"));
		StayDAO dao = StayDAO.getInstance();
		
		// getStayView() : 상세 정보 조회 메서드
		StayDTO dto = dao.getStayView(stayNo);
		
		// getStayRoomList() : 전체 room 정보 목록 조회 메서드
		List<StayRoomDTO> list = dao.getStayRoomList(stayNo);
		request.setAttribute("roomList", list);
		request.setAttribute("stayView", dto);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("stay/stay_view.jsp");
		
		return forward;
	}

}
