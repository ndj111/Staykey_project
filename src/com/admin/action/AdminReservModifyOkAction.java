package com.admin.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.MemberDAO;
import com.model.ReservDAO;
import com.model.ReservDTO;
import com.model.StayDAO;
import com.model.StayRoomDTO;

public class AdminReservModifyOkAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

        // 폼 값 가져오기
        int reserv_no = Integer.parseInt(request.getParameter("reserv_no"));
        String reserv_sess = request.getParameter("reserv_sess");
        String reserv_status = request.getParameter("reserv_status");
        String reserv_start_get = request.getParameter("reserv_start");
        String reserv_end_get = request.getParameter("reserv_end");
        int reserv_people_adult = Integer.parseInt(request.getParameter("reserv_people_adult"));
        int reserv_people_kid = Integer.parseInt(request.getParameter("reserv_people_kid"));
        int reserv_people_baby = Integer.parseInt(request.getParameter("reserv_people_baby"));
        String reserv_option1_data = request.getParameter("reserv_option1_name");
        String reserv_option1_name = null;
        int reserv_option1_price = 0;
        String reserv_option2_data = request.getParameter("reserv_option2_name");
        String reserv_option2_name = null;
        int reserv_option2_price = 0;
        String reserv_option3_data = request.getParameter("reserv_option3_name");
        String reserv_option3_name = null;
        int reserv_option3_price = 0;
        String reserv_pickup = request.getParameter("reserv_pickup");
        String reserv_request = request.getParameter("reserv_request");


        // 기존 예약정보 불러옴
        ReservDAO dao = ReservDAO.getInstance();
        ReservDTO info = dao.getReservInfo(reserv_sess);



        // 예약 상태 변경시 예약횟수 처리
        StayDAO sdao = StayDAO.getInstance();
        MemberDAO mdao = MemberDAO.getInstance();

        // 취소로 변경시 (감소)
        if(!reserv_status.equals(info.getReserv_status()) && reserv_status.equals("cancel")) {
            sdao.minusStayReservCount(info.getReserv_stayno()); // 숙소정보
            mdao.minusMemReservCount(info.getReserv_memid()); // 회원정보
        }else if(!reserv_status.equals(info.getReserv_status()) && reserv_status.equals("reserv")) {
            sdao.plusStayReservCount(info.getReserv_stayno()); // 숙소정보
            mdao.plusMemReservCount(info.getReserv_memid()); // 회원정보
        }



        // 룸 정보 불러옴
        StayDAO rdao = StayDAO.getInstance();
        StayRoomDTO room = rdao.getRoomInfo(info.getReserv_stayno(), info.getReserv_roomno());


        // 숙박일수 계산
        DateFormat calcFormat = new SimpleDateFormat("yyyyMMdd");
        int reserv_daycount = 0;

        try {
            Date d1 = calcFormat.parse(reserv_end_get.replace("-", ""));
            Date d2 = calcFormat.parse(reserv_start_get.replace("-", ""));
            reserv_daycount = (int)(((d1.getTime() - d2.getTime()) / 1000) / (24*60*60));
        } catch (ParseException e) {
            e.printStackTrace();
        }


        // 숙박일 정리 (YYYY/MM/DD HH24:MI:SS)
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date reserv_start_date = new Date();
        Date reserv_end_date = new Date();

        SimpleDateFormat stringFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        String reserv_start = null;
        String reserv_end = null;

        try {
            reserv_start_date = dateFormat.parse(reserv_start_get + " " + room.getRoom_checkin() + ":00");
            reserv_end_date = dateFormat.parse(reserv_end_get + " " + room.getRoom_checkout() + ":00");
            reserv_start = stringFormat.format(reserv_start_date);
            reserv_end = stringFormat.format(reserv_end_date);
        } catch (ParseException e) {
            e.printStackTrace();
        }


        // 선택옵션 정리
        if(reserv_option1_data != "" && reserv_option1_data != null){
            String[] epd_option1 = reserv_option1_data.split("♣");
            reserv_option1_name = epd_option1[0];
            reserv_option1_price = Integer.parseInt(epd_option1[1]);
        }
        if(reserv_option2_data != "" && reserv_option2_data != null){
            String[] epd_option2 = reserv_option2_data.split("♣");
            reserv_option2_name = epd_option2[0];
            reserv_option2_price = Integer.parseInt(epd_option2[1]);
        }
        if(reserv_option3_data != "" && reserv_option3_data != null){
            String[] epd_option3 = reserv_option3_data.split("♣");
            reserv_option3_name = epd_option3[0];
            reserv_option3_price = Integer.parseInt(epd_option3[1]);
        }

        // 숙박요금
        int reserv_basic_price = room.getRoom_price() * reserv_daycount;
        int reserv_total_price = reserv_basic_price + reserv_option1_price + reserv_option2_price + reserv_option3_price;


        // 데이터 수정입력
        ReservDTO dto = new ReservDTO();
        dto.setReserv_no(reserv_no);
        dto.setReserv_status(reserv_status);
        dto.setReserv_sess(reserv_sess);
        dto.setReserv_start(reserv_start);
        dto.setReserv_end(reserv_end);
        dto.setReserv_daycount(reserv_daycount);
        dto.setReserv_basic_price(reserv_basic_price);
        dto.setReserv_option1_name(reserv_option1_name);
        dto.setReserv_option1_price(reserv_option1_price);
        dto.setReserv_option2_name(reserv_option2_name);
        dto.setReserv_option2_price(reserv_option2_price);
        dto.setReserv_option3_name(reserv_option3_name);
        dto.setReserv_option3_price(reserv_option3_price);
        dto.setReserv_total_price(reserv_total_price);
        dto.setReserv_people_adult(reserv_people_adult);
        dto.setReserv_people_kid(reserv_people_kid);
        dto.setReserv_people_baby(reserv_people_baby);
        dto.setReserv_pickup(reserv_pickup);
        dto.setReserv_request(reserv_request);

        int check = dao.modifyReserv(dto);

        ActionForward forward = new ActionForward();
        PrintWriter out = response.getWriter();

        if(check > 0) {
            forward.setRedirect(true);
            forward.setPath("reservList.do");
        }else {
            out.println("<script>alert('예약 정보 수정 중 에러가 발생하였습니다.'); history.back();</script>");
        }

        return forward;
    }

}
