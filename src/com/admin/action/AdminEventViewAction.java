package com.admin.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.EventDAO;
import com.model.EventDTO;
import com.model.StayDAO;
import com.model.StayDTO;


public class AdminEventViewAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 이벤트 상세내역 비지니스 로직.
		int no = Integer.parseInt(request.getParameter("no").trim());
		
        // 상세 정보 조회 메서드
        EventDAO dao = EventDAO.getInstance();
        EventDTO dto = dao.getEventInfo(no);
        request.setAttribute("event", dto);
        
        
        // 등록된 숙소 목록 정보 메서드
        StayDAO sdao = StayDAO.getInstance();
        List<StayDTO> slist = sdao.getBbsViewList(dto.getBbs_stayno());
        request.setAttribute("stayList", slist);
        


        ActionForward forward = new ActionForward();
        forward.setRedirect(false);
        forward.setPath("event/event_view.jsp");

		
		
        return forward;
	}

}
