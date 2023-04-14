package com.site.action;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.EventDAO;
import com.model.EventDTO;

public class SiteEventListAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

        EventDAO dao = EventDAO.getInstance();

        // 상단 프로모션
        List<EventDTO> list = dao.getBbsEventList();
        request.setAttribute("eList", list);


        // 하단 이벤트 숙소
        List<HashMap<String, String>> stay = dao.getEventStayList();
        request.setAttribute("sList", stay);


        ActionForward forward = new ActionForward();
        forward.setRedirect(false);
        forward.setPath("event/event_list.jsp");

        return forward;
    }

}
