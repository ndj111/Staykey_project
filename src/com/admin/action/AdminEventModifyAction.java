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

public class AdminEventModifyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		// 수정 버튼 누르면 stay 정보가 수정으로 넘어감.
		EventDTO dto = new EventDTO();
        StayDAO sdao = StayDAO.getInstance();
        List<StayDTO> slist = sdao.getBbsStayList(dto.getBbs_stayno());
        request.setAttribute("stayList", slist);

		// 클릭 시 주소로 받아옴.
		int bbs_no = Integer.parseInt(request.getParameter("bbs_no"));

		// dao 연결
		EventDAO dao = EventDAO.getInstance();

		// 상세 목록 조회 메서드
		dto = dao.getEventInfo(bbs_no);

		// 메서드로 조회해온 값 dto로 넘겨 주기
		request.setAttribute("eventModify", dto);

		// forward 실행
		ActionForward forward = new ActionForward();

		forward.setRedirect(false);
		forward.setPath("event/event_modify.jsp");

		return forward;
	}

}
