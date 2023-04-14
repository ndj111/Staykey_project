package com.admin.action;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.StayDAO;
import com.model.StayDTO;
import com.util.Paging;

public class AdminStayListAction implements Action {
    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
    	// 숙소(방 아님)에 대한 전체 목록 정보
    	
    	StayDAO dao = StayDAO.getInstance();
 
    	/////////////////////////////////////////////////////////////
    	// 검색
    	/////////////////////////////////////////////////////////////
    	// 뷰에 전달할 매개변수 저장용 맵 생성
    	Map<String, Object> map = new HashMap<String, Object>();
    	
    	// 검색용 변수 정의
    	String ps_type = "";
    	String[] get_type = null;
    	String ps_name = "";
    	String ps_location = "";
    	String ps_location_sub = "";
    	String ps_phone = "";
    	String ps_order = "";
    	
    	if(request.getParameterValues("ps_type") != null) { 
    		// ps_type value로 all이 넘어올 때, all 지정
			get_type = request.getParameterValues("ps_type");
			if(get_type[0].equals("all")) {
				ps_type = "all";
			}else {
				for(int i = 0; i<get_type.length; i++) {
					ps_type += "/" + get_type[i];
				}
			}
		}else {
			ps_type = "all";
		}
    	
    	if(request.getParameter("ps_name") != null){ ps_name = request.getParameter("ps_name").trim(); }else{ ps_name = ""; }
    	
    	// 주소값 지역 + 구체적 주소
    	if(request.getParameter("ps_location") != null){ 
    		ps_location = request.getParameter("ps_location"); 
    		if(ps_location.equals("전체")) {
    			ps_location = "";
    			if(request.getParameter("ps_location_sub") != null) { // 전체 / 검색값 유
    				ps_location_sub = request.getParameter("ps_location_sub").trim();
    			}else { // 전체 / 검색값 무
    				ps_location_sub = "";
    			}
    		}else { // 전체 아님 / 검색값 유
    			if(request.getParameter("ps_location_sub") != null) {
    				ps_location_sub = request.getParameter("ps_location_sub").trim();
    			}else { // 전체 아님 / 검색값 무
    				ps_location_sub = "";
    			}
    		}
    	}else { 
    		ps_location = ""; 
    	}    	
    	if(request.getParameter("ps_phone") != null){ ps_phone = request.getParameter("ps_phone").trim(); }else{ ps_phone = ""; }
    	if(request.getParameter("ps_order") != null){ ps_order = request.getParameter("ps_order").trim(); }else{ ps_order = "no_desc"; }
    	
    	// 뷰에 전달할 매개변수 추가
    	map.put("ps_type", ps_type);
    	map.put("ps_name", ps_name);
    	map.put("ps_location", ps_location);
    	map.put("ps_location_sub", ps_location_sub);
    	map.put("ps_phone", ps_phone);
    	map.put("ps_order", ps_order);
    	
    	/////////////////////////////////////////////////////////////
    	// 페이징
    	/////////////////////////////////////////////////////////////
    	// 페이징 변수들 정의
    	int rowsize = 7; // 한 페이지당 보여질 게시물의 갯수
    	int block = 5; // 아래에 보여질 페이지의 최대 블럭 수
    	
    	// 전체 데이터 개수 count 메서드
    	int totalRecord = dao.getStayTotalCount(map);
    	request.setAttribute("listCount", totalRecord);
    	
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
        String pageUrl = request.getContextPath()+"/admin/stayList.do?ps_type="+ps_type+"&ps_name="+ps_name+"&ps_location="+ps_location+"&ps_location_sub="+ps_location_sub+"&ps_phone="+ps_phone+"&ps_order="+ps_order;

        // 뷰에 전달할 매개변수 추가
        map.put("pagingWrite", Paging.showPage(allPage, startBlock, endBlock, page, pageUrl));
        request.setAttribute("map", map);
    	
    	/////////////////////////////////////////////////////////////
    	// 목록 조회 메서드 및 변수 넘기기
    	/////////////////////////////////////////////////////////////    	
	    // 숙소 전체 목록 조회 메서드 : getStayList + 페이징 처리 + 검색(& 검색 시 페이징 처리) 매개변수 추가
	    List<StayDTO> list = dao.getStayList(page, rowsize, map); 
	    
    	request.setAttribute("stayList", list);
    	
    	ActionForward forward = new ActionForward();
    	forward.setRedirect(false);
    	forward.setPath("stay/stay_list.jsp");

        return forward;
    }
}
