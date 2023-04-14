package com.site.action;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.EventDAO;
import com.model.EventDTO;
import com.model.MagazineDAO;
import com.model.MagazineDTO;
import com.model.StayDAO;
import com.model.StayDTO;

public class SiteMainAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

        StayDAO stayDAO = StayDAO.getInstance();
        EventDAO eventDAO = EventDAO.getInstance();
        MagazineDAO magazineDAO = MagazineDAO.getInstance();



        //////////////////////////////////////////////////////////////////////////////////
        // 메인 비주얼 & 새로운 경험
        //////////////////////////////////////////////////////////////////////////////////    	
        // 배열 total count 생성
        int stayTotal = stayDAO.getStayTotalCount();

        // randomNum 담을 변수
        int randomNum = 0;

        // display : 메인에 표시할 총 개수
        int[] display = new int[5];

        // stayNums : 모든 숙소 번호 추출 / 숙소 번호 다 다르기 때문
        List<Integer> stayNums = stayDAO.getStayNums();

        // 화면에 표시할 개수만큼 random 지정
        for(int i=0; i<display.length; i++) {
            randomNum = (int)(Math.random()*stayTotal);
            display[i] = stayNums.get(randomNum);
        }

        List<StayDTO> randomStay = stayDAO.getStayforMain(display);
        request.setAttribute("randomStay", randomStay);



        //////////////////////////////////////////////////////////////////////////////////
        // 중단 배너
        //////////////////////////////////////////////////////////////////////////////////
        int stayTotal2 = stayDAO.getStayTotalCount();
        List<Integer> stayNums2 = stayDAO.getStayNums();
        int randNum = (int)(Math.random()*stayTotal2);

         StayDTO randomBanner = stayDAO.getStayView(stayNums2.get(randNum));
         request.setAttribute("randomBanner", randomBanner);




        //////////////////////////////////////////////////////////////////////////////////
        // 프로모션 & 이벤트
        ////////////////////////////////////////////////////////////////////////////////// 
        // 상단 프로모션
        List<EventDTO> eList = eventDAO.getBbsEventList();
        request.setAttribute("eList", eList);

        // 하단 이벤트 숙소
        List<HashMap<String, String>> sList = eventDAO.getEventStayList();
        request.setAttribute("sList", sList);



        //////////////////////////////////////////////////////////////////////////////////
        // TRAVEL (매거진)
        //////////////////////////////////////////////////////////////////////////////////  	
        List<MagazineDTO> magazineList = magazineDAO.getTotalMagazine();
        request.setAttribute("magazineList", magazineList);



        ////////////////////////////////////////////////////////////////
        // 지금 바로 떠나는 " "
        // 키워드에 따른 선택된 값만 추출
        ////////////////////////////////////////////////////////////////
        String keyword = "제주";
        List<StayDTO> keywordStay = stayDAO.getSelectedStay(keyword);
        request.setAttribute("keyword", keyword);
        request.setAttribute("keywordStay", keywordStay);



        ActionForward forward = new ActionForward();
        forward.setRedirect(false);
        forward.setPath("main.jsp");

        return forward;
    }

}
