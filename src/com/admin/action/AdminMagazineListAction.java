package com.admin.action;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.MagazineDAO;
import com.model.MagazineDTO;
import com.util.Paging;

public class AdminMagazineListAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 매거진 목록 처리 클래스
        MagazineDAO dao = MagazineDAO.getInstance();


        // 뷰에 전달할 매개변수 저장용 맵 생성
        Map<String, Object> map = new HashMap<String, Object>();


        // 검색용 변수들 정의
        String mg_title = "";
        String mg_writer_name = "";
        String ps_order = "";

        if(request.getParameter("mg_title") != null){ mg_title = request.getParameter("mg_title").trim(); }else{ mg_title = ""; }
        if(request.getParameter("mg_writer_name") != null){ mg_writer_name = request.getParameter("mg_writer_name").trim(); }else{ mg_writer_name = ""; }
        if(request.getParameter("ps_order") != null){ ps_order = request.getParameter("ps_order").trim(); }else{ ps_order = "bbs_date_desc"; }


        // 뷰에 전달할 매개변수 추가 (검색용)
        map.put("mg_title", mg_title);
        map.put("mg_writer_name", mg_writer_name);
        map.put("ps_order", ps_order);


        // 페이징 변수들 정의
        int rowsize = 10; // 한 페이지당 보여질 게시물의 갯수
        int block = 5; // 아래에 보여질 페이지의 최대 블럭 수

        // 전체 데이터 갯수
        int totalRecord = dao.getTotalCount(map);
        request.setAttribute("listCount", totalRecord);

        // 전체 페이지 갯수
        int allPage = (int) Math.ceil(totalRecord / (double) rowsize);

        // 현재 페이지 변수
        int page = 0;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page").trim());
        } else {
            page = 1;
        }

        int startBlock = (((page - 1) / block) * block) + 1;
        int endBlock = (((page - 1) / block) * block) + block;

        if (endBlock > allPage) {
            endBlock = allPage;
        }

        // 페이지 이동 URL (검색용)
        String pageUrl = request.getContextPath() + "/admin/magazineList.do?mg_title=" + mg_title + "&mg_writer_name="
                + mg_writer_name + "&mg_title=" + mg_title + "&ps_order="+ps_order;


        // 뷰에 전달할 매개변수 추가
        map.put("pagingWrite", Paging.showPage(allPage, startBlock, endBlock, page, pageUrl));
        request.setAttribute("map", map);


        // 목록 조회 메서드
        List<MagazineDTO> list = dao.magazineList(page, rowsize, map);
        request.setAttribute("List", list);


        ActionForward forward = new ActionForward();
        forward.setRedirect(false);
        forward.setPath("magazine/magazine_list.jsp");

        return forward;
    }

}
