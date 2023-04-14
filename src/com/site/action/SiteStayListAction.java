package com.site.action;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.StayDAO;
import com.model.StayDTO;
import com.util.Paging;
import com.util.showArray;

public class SiteStayListAction implements Action {
    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

        // 뷰에 전달할 매개변수 저장용 맵 생성
        Map<String, Object> map = new HashMap<String, Object>();
        
        StayDAO dao = StayDAO.getInstance();

        /////////////////////////////////////////////////////////////
        // 검색
        /////////////////////////////////////////////////////////////
        // 검색용 변수 정의
        String ps_stay = "";
        String ps_type = "";
        String[] get_type = null;
        String ps_order = "";
        int ps_people_adult = 0;
        int ps_people_kid = 0;
        int ps_people_baby = 0;
        int ps_price_min = 0;
        int ps_price_max = 100;
        String ps_start = "";
        String ps_end = "";
        String page_write_type = ""; // 버튼에서 값 뜨게 하기 위한 변수
               
        if(request.getParameter("ps_stay") != null) { ps_stay = request.getParameter("ps_stay").trim(); }else { ps_stay = ""; }
        
        if(request.getParameter("ps_start") != null) { ps_start = request.getParameter("ps_start"); }else { ps_start = ""; }
        if(request.getParameter("ps_end") != null) { ps_end = request.getParameter("ps_end"); }else { ps_end = ""; }
        
        if(request.getParameter("ps_people_adult") != null || request.getParameter("ps_people_kid") != null || request.getParameter("ps_people_baby") != null) {
        	if(request.getParameter("ps_people_adult") != null) { ps_people_adult = Integer.parseInt(request.getParameter("ps_people_adult")); }
        	if(request.getParameter("ps_people_kid") != null) { ps_people_kid = Integer.parseInt(request.getParameter("ps_people_kid")); }
        	if(request.getParameter("ps_people_baby") != null) { ps_people_baby = Integer.parseInt(request.getParameter("ps_people_baby")); }
        }
                
        if(request.getParameter("ps_price_min") != null || request.getParameter("ps_price_max") != null) {
        	if(request.getParameter("ps_price_min") != (null)) { 
        		ps_price_min = Integer.parseInt(request.getParameter("ps_price_min"));
        	}
        	if(request.getParameter("ps_price_max") != (null)) { 
        		ps_price_max = Integer.parseInt(request.getParameter("ps_price_max")); 
        	}
        }
        
    	if(request.getParameterValues("ps_type") != null) { 
    		// ps_type value로 all이 넘어올 때, all 지정
			get_type = request.getParameterValues("ps_type");
			if(get_type[0].equals("all")) {
				ps_type = "all";
			}else { // 2번째로 값 들어올 때, 분리 필요
				if(get_type.length == 1) {
					get_type = get_type[0].substring(1).split("/");
					for(int i=0; i<get_type.length; i++) {
						ps_type += "/" + get_type[i];
					}
					if(get_type.length > 1) {
						page_write_type = get_type[0] + " 외 " + (get_type.length - 1) + "건";
					}else{
						page_write_type = get_type[0];
					}
				}else { // 기본
					for(int i=0; i<get_type.length; i++) {
						ps_type += "/" + get_type[i];
					}
					if(get_type.length > 1) {
						page_write_type = get_type[0] + " 외 " + (get_type.length - 1) + "건";
					}else{
						page_write_type = get_type[0];
					}
				}
			}
		}else {
			ps_type = "all";
		}

        if(request.getParameter("ps_order") != null){ ps_order = request.getParameter("ps_order").trim(); }else{ ps_order = "no_desc"; }

        // 뷰에 전달할 매개변수 추가
        map.put("ps_stay", ps_stay);
        map.put("ps_start", ps_start);
        map.put("ps_end", ps_end);
        map.put("ps_people_adult", ps_people_adult);
        map.put("ps_people_kid", ps_people_kid);
        map.put("ps_people_baby", ps_people_baby);
        map.put("ps_price_min", ps_price_min);
        map.put("ps_price_max", ps_price_max);
        map.put("ps_type", ps_type);
        map.put("ps_order", ps_order);


        /////////////////////////////////////////////////////////////
        // 페이징
        /////////////////////////////////////////////////////////////
        // 페이징 변수들 정의
        int rowsize = 12; // 한 페이지당 보여질 게시물의 갯수
        int block = 5; // 아래에 보여질 페이지의 최대 블럭 수

        // 전체 데이터 개수 count 메서드
        int totalRecord = dao.getStaySiteTotalCount(map);
        request.setAttribute("listCount", totalRecord);
        // System.out.println("TotalCount >> " + totalRecord);

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
        String pageUrl = request.getContextPath()+"/stayList.do?ps_stay="+ps_stay+"&ps_start="+ps_start+"&ps_end="+ps_end+"&ps_people_adult="+ps_people_adult+"&ps_people_kid="+ps_people_kid+"&ps_people_baby="+ps_people_baby+"&ps_price_min="+ps_price_min+"&ps_price_max="+ps_price_max+"&ps_type="+ps_type+"&ps_order="+ps_order;

        // 뷰에 전달할 매개변수 추가
        map.put("pagingWrite", Paging.showPage(allPage, startBlock, endBlock, page, pageUrl));
        request.setAttribute("map", map);

        /////////////////////////////////////////////////////////////
        // 목록 조회 메서드 및 변수 넘기기
        /////////////////////////////////////////////////////////////
        // 숙소 전체 목록 조회 메서드 : getStayList + 페이징 처리 + 검색(& 검색 시 페이징 처리) 매개변수 추가
        HttpSession session = request.getSession();
        String login_id = (String) session.getAttribute("login_id");
        List<StayDTO> list = dao.getStaySiteList(page, rowsize, map, login_id);

        request.setAttribute("stayList", list);

        // 숙소 유형 배열 넘겨주기
        showArray getArray = new showArray();
        getArray.getList("stayType");
        List<String> stayType = getArray.listArr;
        request.setAttribute("stayType", stayType);
        request.setAttribute("wType", page_write_type);

        ActionForward forward = new ActionForward();
        forward.setRedirect(false);
        forward.setPath("stay/stay_list.jsp");

        
        return forward;
    }

}
