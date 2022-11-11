package com.site.action;

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

public class SiteEventViewAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

        int bbs_no = Integer.parseInt(request.getParameter("bbs_no"));

        // 상세 정보 조회
        EventDAO dao = EventDAO.getInstance();
        EventDTO dto = dao.getEventInfo(bbs_no);
        request.setAttribute("event", dto);

        // 등록된 숙소 목록
        StayDAO sdao = StayDAO.getInstance();
        List<StayDTO> slist = sdao.getBbsViewList(dto.getBbs_stayno());
        request.setAttribute("stayList", slist);

        // 조회수 늘리기
        dao.plusEventCount(bbs_no);

        ActionForward forward = new ActionForward();
        forward.setRedirect(false);
        forward.setPath("event/event_view.jsp");

        return forward;
    }

}
