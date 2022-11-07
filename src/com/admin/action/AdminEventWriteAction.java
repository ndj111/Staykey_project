package com.admin.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.EventDTO;
import com.model.StayDAO;
import com.model.StayDTO;


public class AdminEventWriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		// 수정 버튼 누르면 stay 정보가 수정으로 넘어감.
		EventDTO dto = new EventDTO();
		StayDAO sdao = StayDAO.getInstance();
		List<StayDTO> slist = sdao.getBbsStayList(dto.getBbs_stayno());
		request.setAttribute("stayList", slist);
		
        ActionForward forward = new ActionForward();
    	forward.setRedirect(false);
    	forward.setPath("event/event_write.jsp");
    	System.out.println("slist" + slist);
    	
        return forward;	
        

	}
		

}
