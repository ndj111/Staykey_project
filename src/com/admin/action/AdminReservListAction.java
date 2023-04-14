package com.admin.action;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.ReservDAO;
import com.model.ReservDTO;
import com.util.Paging;

public class AdminReservListAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

        // 현재 날짜
        LocalDate startNowDate = LocalDate.now().minusDays(30L); // 오늘로부터 30일전 부터
        String startDate = startNowDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        LocalDate endNowDate = LocalDate.now().plusDays(30L); // 오늘로부터 30일후 까지
        String endDate = endNowDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));


        ReservDAO dao = ReservDAO.getInstance();

        // 뷰에 전달할 매개변수 저장용 맵 생성
        Map<String, Object> map = new HashMap<String, Object>();


        // 검색용 변수들 정의
        String ps_status = "";
        String ps_start = "";
        String ps_end = "";
        String ps_sess = "";
        String ps_name = "";
        String ps_stay = "";
        String ps_duse = "";
        String ps_order = "";
        if(request.getParameter("ps_status") != null){ ps_status = request.getParameter("ps_status").trim(); }else{ ps_status = "all"; }
        if(request.getParameter("ps_start") != null){ ps_start = request.getParameter("ps_start").trim(); }else{ ps_start = startDate; }
        if(request.getParameter("ps_end") != null){ ps_end = request.getParameter("ps_end").trim(); }else{ ps_end = endDate; }
        if(request.getParameter("ps_sess") != null){ ps_sess = request.getParameter("ps_sess").trim(); }else{ ps_sess = ""; }
        if(request.getParameter("ps_name") != null){ ps_name = request.getParameter("ps_name").trim(); }else{ ps_name = ""; }
        if(request.getParameter("ps_stay") != null){ ps_stay = request.getParameter("ps_stay").trim(); }else{ ps_stay = ""; }
        if(request.getParameter("ps_duse") != null){ ps_duse = request.getParameter("ps_duse").trim(); }else{ ps_duse = ""; }
        if(request.getParameter("ps_order") != null){ ps_order = request.getParameter("ps_order").trim(); }else{ ps_order = "register_desc"; }


        // 뷰에 전달할 매개변수 추가
        map.put("ps_status", ps_status);
        map.put("ps_start", ps_start);
        map.put("ps_end", ps_end);
        map.put("ps_sess", ps_sess);
        map.put("ps_name", ps_name);
        map.put("ps_stay", ps_stay);
        map.put("ps_duse", ps_duse);
        map.put("ps_order", ps_order);



        // 페이징 변수들 정의
        int rowsize = 10; // 한 페이지당 보여질 게시물의 갯수
        int block = 5; // 아래에 보여질 페이지의 최대 블럭 수

        // 전체 데이터 갯수
        int totalRecord = dao.getTotalCount(map);
        request.setAttribute("listCount", totalRecord);

        // 전체 페이지 갯수
        int allPage = (int)Math.ceil(totalRecord / (double)rowsize);

        // 현재 페이지 변수
        int page = 0;
        if(request.getParameter("page") != null){
            page = Integer.parseInt(request.getParameter("page").trim());
        }else{
            page = 1;
        }


        int startBlock = (((page - 1) / block) * block) + 1;
        int endBlock = (((page - 1) / block) * block) + block;

        if(endBlock > allPage){
            endBlock = allPage;
        }


        // 페이지 이동 URL
        String pageUrl = request.getContextPath()+"/admin/reservList.do?ps_status="+ps_status+"&ps_start="+ps_start+"&ps_end="+ps_end+"&ps_sess="+ps_sess+"&ps_name="+ps_name+"&ps_stay="+ps_stay+"&ps_duse="+ps_duse+"&ps_order="+ps_order;


        // 뷰에 전달할 매개변수 추가
        map.put("pagingWrite", Paging.showPage(allPage, startBlock, endBlock, page, pageUrl));
        request.setAttribute("map", map);


        // 목록 조회 메서드
        List<ReservDTO> list = dao.getReservList(page, rowsize, map);
        request.setAttribute("List", list);


        ActionForward forward = new ActionForward();
        forward.setRedirect(false);
        forward.setPath("reserv/reserv_list.jsp");

        return forward;
    }

}
