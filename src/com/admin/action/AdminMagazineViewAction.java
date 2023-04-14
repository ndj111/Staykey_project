package com.admin.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.MagazineDAO;
import com.model.MagazineDTO;
import com.model.StayDAO;
import com.model.StayDTO;

public class AdminMagazineViewAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int mag_no = Integer.parseInt(request.getParameter("bbs_no"));

        // 상세 정보 조회 메서드
        MagazineDAO dao = MagazineDAO.getInstance();
        MagazineDTO dto = dao.getMagView(mag_no);
        request.setAttribute("magazine", dto);

        // 등록된 숙소 목록 정보 메서드
        StayDAO sdao = StayDAO.getInstance();
        List<StayDTO> slist = sdao.getBbsViewList(dto.getBbs_stayno());
        request.setAttribute("stayList", slist);

        ActionForward forward = new ActionForward();
        forward.setRedirect(false);
        forward.setPath("magazine/magazine_view.jsp");

        return forward;
    }

}
