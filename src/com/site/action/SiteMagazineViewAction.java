package com.site.action;

import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.MagazineDAO;
import com.model.MagazineDTO;
import com.model.StayDAO;
import com.model.StayDTO;

public class SiteMagazineViewAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

        int bbs_no = Integer.parseInt(request.getParameter("bbs_no"));

        // 매거진 정보 가져오기
        MagazineDAO dao = MagazineDAO.getInstance();
        MagazineDTO dto = dao.getMagView(bbs_no);
        request.setAttribute("magazine", dto);


        // 매거진 스테이 이름
        String stayName = null;
        Pattern pattern = Pattern.compile("[<](.*?)[>]");
        Matcher matcher = pattern.matcher(dto.getBbs_title());
        if(matcher.find()){
            stayName = matcher.group(1).trim();
        }
        request.setAttribute("stay_name", stayName);


        // 조회수 늘리기
        dao.plusMagHit(bbs_no);


        // 매거진 숙소 정보 가져오기
        int result_stay_no = 0;
        if(dto.getBbs_stayno() != null) {
            String tmp_stay_no = dto.getBbs_stayno().substring(1, dto.getBbs_stayno().length() - 1);
            if(tmp_stay_no.contains("/")) {
                String[] epd_stay_no = tmp_stay_no.split("/");
                result_stay_no = Integer.parseInt(epd_stay_no[0]);
            }else{
                result_stay_no = Integer.parseInt(tmp_stay_no);
            }
            request.setAttribute("stay_no", result_stay_no);
        }
    
        StayDTO sdto = null;
        if(result_stay_no > 0){
            StayDAO sdao = StayDAO.getInstance();
            sdto = sdao.getStayView(result_stay_no);
        }
        request.setAttribute("sdto", sdto);


        ActionForward forward = new ActionForward();
        forward.setRedirect(false);
        forward.setPath("magazine/magazine_view.jsp");

        return forward;
    }

}
