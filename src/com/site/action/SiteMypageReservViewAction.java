package com.site.action;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.ReservDAO;
import com.model.ReservDTO;
import com.model.StayDAO;
import com.model.StayDTO;
import com.model.StayRoomDTO;

public class SiteMypageReservViewAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

        String reserv_sess = request.getParameter("reserv_sess");

        // 예약 정보 가져오기
    	ReservDAO dao = ReservDAO.getInstance();
    	ReservDTO dto = dao.getReservInfo(reserv_sess);
        request.setAttribute("reservView", dto);


        // 숙소 정보 가져오기
        StayDAO sdao = StayDAO.getInstance();
        StayDTO sdto = sdao.getStayView(dto.getReserv_stayno());
        request.setAttribute("stayView", sdto);


        // Room 정보 가져오기
        StayRoomDTO rdto = sdao.getRoomInfo(dto.getReserv_stayno(), dto.getReserv_roomno());
        request.setAttribute("roomView", rdto);


        // 취소가능 상태 설정
        String reserv_cancel = "N";
        try {
            if(dto.getReserv_status().equals("reserv")){
                // 현재 날짜
                Date get_today = new Date();
                DateFormat todayFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    
                // String 타입으로 날짜 정리
                String show_today = todayFormat.format(get_today);
                String show_start = dto.getReserv_start();
    
                // Date 타입으로 날짜 정리
                DateFormat chkFormat = new SimpleDateFormat("yyyyMMddHHmmss");
                Date r_today = chkFormat.parse(show_today.replace("-", "").replace(" ", "").replace(":", ""));
                Date r_start = chkFormat.parse(show_start.replace("-", "").replace(" ", "").replace(":", ""));
    
                if(r_start.compareTo(r_today) > 0){
                    reserv_cancel = "Y";
                }
            }
        } catch(Exception e) {
        }
        request.setAttribute("cancel_ok", reserv_cancel);


        ActionForward forward = new ActionForward();
        forward.setRedirect(false);
        forward.setPath("mypage/mypage_reserv_view.jsp");

        return forward;
    }

}
