package com.site.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.MemberDAO;
import com.model.ReservDAO;
import com.model.ReservDTO;
import com.model.StayDAO;

public class SiteStayRerservOkAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

        ReservDAO dao = ReservDAO.getInstance();
        ReservDTO dto = new ReservDTO();


        // 파라미터 값 정리
        String reserv_sess = dao.makeReservSess();
        int reserv_stayno = Integer.parseInt(request.getParameter("reserv_stayno"));
        String reserv_stayname = request.getParameter("reserv_stayname");
        int reserv_roomno = Integer.parseInt(request.getParameter("reserv_roomno"));
        String reserv_roomname = request.getParameter("reserv_roomname");
        String reserv_memid = request.getParameter("reserv_memid");
        String reserv_memname = request.getParameter("reserv_memname");
        String reserv_memphone = request.getParameter("reserv_memphone");
        String reserv_mememail = request.getParameter("reserv_mememail");
        String reserv_start = request.getParameter("reserv_start");
        String reserv_end = request.getParameter("reserv_end");
        int reserv_daycount = Integer.parseInt(request.getParameter("reserv_daycount"));
        int reserv_basic_price = Integer.parseInt(request.getParameter("reserv_basic_price"));
        int reserv_people_adult = Integer.parseInt(request.getParameter("reserv_people_adult"));
        int reserv_people_kid = Integer.parseInt(request.getParameter("reserv_people_kid"));
        int reserv_people_baby = Integer.parseInt(request.getParameter("reserv_people_baby"));
        String reserv_pickup = request.getParameter("reserv_pickup");
        String reserv_request = request.getParameter("reserv_request");

        String reserv_option1_name = null;
        int reserv_option1_price = 0;
        if(request.getParameter("stay_option1_select").equals("Y")) {
            reserv_option1_name = request.getParameter("reserv_option1_name");
            reserv_option1_price = Integer.parseInt(request.getParameter("reserv_option1_price"));
        }

        String reserv_option2_name = null;
        int reserv_option2_price = 0;
        if(request.getParameter("stay_option2_select").equals("Y")) {
            reserv_option2_name = request.getParameter("reserv_option2_name");
            reserv_option2_price = Integer.parseInt(request.getParameter("reserv_option2_price"));
        }

        String reserv_option3_name = null;
        int reserv_option3_price = 0;
        if(request.getParameter("stay_option3_select").equals("Y")) {
            reserv_option3_name = request.getParameter("reserv_option3_name");
            reserv_option3_price = Integer.parseInt(request.getParameter("reserv_option3_price"));
        }

        int reserv_total_price = reserv_basic_price + reserv_option1_price + reserv_option2_price + reserv_option3_price;


        // 객체에 저장
        dto.setReserv_sess(reserv_sess);
        dto.setReserv_stayno(reserv_stayno);
        dto.setReserv_stayname(reserv_stayname);
        dto.setReserv_roomno(reserv_roomno);
        dto.setReserv_roomname(reserv_roomname);
        dto.setReserv_memid(reserv_memid);
        dto.setReserv_memname(reserv_memname);
        dto.setReserv_memphone(reserv_memphone);
        dto.setReserv_mememail(reserv_mememail);
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

//        System.out.println("reserv_sess => " + reserv_sess);
//        System.out.println("reserv_stayno => " + reserv_stayno);
//        System.out.println("reserv_stayname => " + reserv_stayname);
//        System.out.println("reserv_roomno => " + reserv_roomno);
//        System.out.println("reserv_roomname => " + reserv_roomname);
//        System.out.println("reserv_memid => " + reserv_memid);
//        System.out.println("reserv_memname => " + reserv_memname);
//        System.out.println("reserv_memphone => " + reserv_memphone);
//        System.out.println("reserv_mememail => " + reserv_mememail);
//        System.out.println("reserv_start => " + reserv_start);
//        System.out.println("reserv_end => " + reserv_end);
//        System.out.println("reserv_daycount => " + reserv_daycount);
//        System.out.println("reserv_basic_price => " + reserv_basic_price);
//        System.out.println("reserv_option1_name => " + reserv_option1_name);
//        System.out.println("reserv_option1_price => " + reserv_option1_price);
//        System.out.println("reserv_option2_name => " + reserv_option2_name);
//        System.out.println("reserv_option2_price => " + reserv_option2_price);
//        System.out.println("reserv_option3_name => " + reserv_option3_name);
//        System.out.println("reserv_option3_price => " + reserv_option3_price);
//        System.out.println("reserv_total_price => " + reserv_total_price);
//        System.out.println("reserv_people_adult => " + reserv_people_adult);
//        System.out.println("reserv_people_kid => " + reserv_people_kid);
//        System.out.println("reserv_people_baby => " + reserv_people_baby);
//        System.out.println("reserv_pickup => " + reserv_pickup);
//        System.out.println("reserv_request => " + reserv_request);

        // 예약 정보 입력
        int res = dao.insertReserv(dto);


        // 숙소 정보에 예약 횟수 늘리기
        StayDAO sdao = StayDAO.getInstance();
        sdao.plusStayReservCount(reserv_stayno);


        // 회원정보에 예약 횟수 늘리기
        MemberDAO mdao = MemberDAO.getInstance();
        mdao.plusMemReservCount(reserv_memid);


        PrintWriter out = response.getWriter();

        if(res > 0) {
            out.println("<script>var webSocket = new WebSocket(\"ws://121.164.91.191:8080/Staykey_project/webSocket\"); "
                    + "webSocket.onopen = function(event) { webSocket.send(\"reserv|"+reserv_memname+"|"+reserv_memid+"|"+reserv_stayname+" ("+reserv_roomname+")<br />"+reserv_start.substring(0,10)+" ~ "+reserv_end.substring(0,10)+" ("+reserv_daycount+"박 "+(reserv_daycount+1)+"일)|"+reserv_sess+"\"); "
                    + "webSocket.close(); };</script>");
            out.println("<script>setTimeout(function(){ alert('예약이 완료되었습니다. :-)'); location.href='mypageReservView.do?reserv_sess="+reserv_sess+"'; }, 500);</script>");

        }else {
            out.println("<script>alert('스테이 예약 중 에러가 발생했습니다.'); history.back();</script>");
        }

        return null;
    }

}
