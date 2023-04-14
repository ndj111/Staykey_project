package com.admin.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.MagazineDTO;
import com.model.StayDAO;
import com.model.StayDTO;

public class AdminMagazineWriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// write 버튼 누르면 stay 정보가 write로 넘어감.
		MagazineDTO dto = new MagazineDTO();

        StayDAO sdao = StayDAO.getInstance();
        List<StayDTO> slist = sdao.getBbsStayList(dto.getBbs_stayno());
        request.setAttribute("stayList", slist);

        ActionForward forward = new ActionForward();
    	forward.setRedirect(false);
    	forward.setPath("magazine/magazine_write.jsp");

        return forward;		
	}

}
