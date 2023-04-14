package com.admin.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.ReservDAO;
import com.model.ReservDTO;
import com.model.StayDAO;
import com.model.StayDTO;
import com.model.StayRoomDTO;

public class AdminReservModifyAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

        String reservSess = request.getParameter("sess");

        ReservDAO dao = ReservDAO.getInstance();
        ReservDTO dto = dao.getReservInfo(reservSess);
        request.setAttribute("reservView", dto);

        StayDAO rdao = StayDAO.getInstance();
        StayDTO sdto = rdao.getStayView(dto.getReserv_stayno());
        request.setAttribute("stayCont", sdto);

        StayRoomDTO rdto = rdao.getRoomInfo(dto.getReserv_stayno(), dto.getReserv_roomno());
        request.setAttribute("roomCont", rdto);

        ActionForward forward = new ActionForward();
        forward.setRedirect(false);
        forward.setPath("reserv/reserv_modify.jsp");

        return forward;
    }

}
