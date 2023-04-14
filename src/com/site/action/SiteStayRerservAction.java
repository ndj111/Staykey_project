package com.site.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.StayDAO;
import com.model.StayDTO;
import com.model.StayRoomDTO;

public class SiteStayRerservAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

        // 회원 로그인 체크
        HttpSession session = request.getSession();
        if(session.getAttribute("login_id") == "" || session.getAttribute("login_id") == null) {
            PrintWriter out = response.getWriter();
            out.println("<script>alert('회원 로그인 후 예약 할 수 있습니다.'); location.href='memberLogin.do';</script>");
            return null;
        }


        int stayNo = Integer.parseInt(request.getParameter("stay_no"));
        int roomNo = Integer.parseInt(request.getParameter("room_no"));

        StayDAO dao = StayDAO.getInstance();

        // 숙소 정보
        StayDTO stayDTO = dao.getStayView(stayNo);
        request.setAttribute("stayView", stayDTO);


        // Room 정보
        StayRoomDTO roomDTO = dao.getStayRoomView(roomNo, stayNo);
        request.setAttribute("roomView", roomDTO);


        String startDate = request.getParameter("check_in");
        String endDate = request.getParameter("check_out");

        // 숙박일수 계산
        DateFormat calcFormat = new SimpleDateFormat("yyyyMMdd");
        int reserv_daycount = 0;

        try {
            Date d1 = calcFormat.parse(endDate.replace("-", ""));
            Date d2 = calcFormat.parse(startDate.replace("-", ""));
            reserv_daycount = (int)(((d1.getTime() - d2.getTime()) / 1000) / (24*60*60));
        } catch (ParseException e) {
            e.printStackTrace();
        }
        request.setAttribute("daycount", reserv_daycount);


        // 숙박일 정리 (YYYY/MM/DD HH24:MI:SS)
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date reserv_start_date = new Date();
        Date reserv_end_date = new Date();

        SimpleDateFormat stringFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        String reserv_start = null;
        String reserv_end = null;

        try {
            reserv_start_date = dateFormat.parse(startDate + " " + roomDTO.getRoom_checkin() + ":00");
            reserv_end_date = dateFormat.parse(endDate + " " + roomDTO.getRoom_checkout() + ":00");
            reserv_start = stringFormat.format(reserv_start_date);
            reserv_end = stringFormat.format(reserv_end_date);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        request.setAttribute("start_date", startDate.replace("-", ". "));
        request.setAttribute("end_date", endDate.replace("-", ". "));
        request.setAttribute("start_date_full", reserv_start);
        request.setAttribute("end_date_full", reserv_end);


        ActionForward forward = new ActionForward();
        forward.setRedirect(false);
        forward.setPath("reserv/reserv_form.jsp");

        return forward;
    }

}
