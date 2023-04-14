package com.site.action;

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

public class SiteMagazineListAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

    	MagazineDAO magazineDAO = MagazineDAO.getInstance();

        // 뷰에 전달할 매개변수 저장용 맵 생성
        Map<String, Object> map = new HashMap<String, Object>();

        /////////////////////////////////////////////////////////////
        // 페이징
        /////////////////////////////////////////////////////////////
        // 페이징 변수들 정의
        int rowsize = 4; // 한 페이지당 보여질 게시물의 갯수
        int block = 5; // 아래에 보여질 페이지의 최대 블럭 수

        // 전체 데이터 개수 count 메서드
        int totalRecord = magazineDAO.getTotalCount();
        request.setAttribute("magazineCount", totalRecord);

        // 전체 페이지 갯수
        int allPage = (int)Math.ceil(totalRecord/(double)rowsize);

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
        String pageUrl = request.getContextPath()+"/magazineList.do";

        // 뷰에 전달할 매개변수 추가
        map.put("pagingWrite", Paging.showPage(allPage, startBlock, endBlock, page, pageUrl));
        request.setAttribute("map", map);
        
        //////////////////////////////////////////////////////////////////////////////////
        // magazine : 매거진
        //////////////////////////////////////////////////////////////////////////////////    	        
        List<MagazineDTO> magazineList = magazineDAO.getTotalMagazine(page, rowsize);
        request.setAttribute("magazineList", magazineList);  
        
        ActionForward forward = new ActionForward();
        forward.setRedirect(false);
        forward.setPath("magazine/magazine_list.jsp");

        return forward;
    }

}

