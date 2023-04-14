package com.admin.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.ReservDAO;
import com.model.ReservDTO;

public class AdminReservViewAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

        String reservSess = request.getParameter("sess");

        ReservDAO dao = ReservDAO.getInstance();
        ReservDTO dto = dao.getReservInfo(reservSess);

        request.setAttribute("reservView", dto);

        ActionForward forward = new ActionForward();
        forward.setRedirect(false);
        forward.setPath("reserv/reserv_view.jsp");

        return forward;
    }

}
