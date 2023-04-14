package com.admin.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.StayDAO;
import com.model.StayDTO;
import com.util.showArray;

public class AdminStayModifyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 숙소 수정 -> View 값 받아와서 넘김
		
		int stayNo = Integer.parseInt(request.getParameter("stay_no"));
		
		StayDAO dao = StayDAO.getInstance();
		StayDTO dto = dao.getStayView(stayNo);
		request.setAttribute("stayModify", dto);

		// 숙소 유형 배열 넘겨주기
        showArray getArray = new showArray();
        getArray.getList("stayType");
        List<String> stayType = getArray.listArr;
        request.setAttribute("stayType", stayType);

		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("stay/stay_modify.jsp");
	
		return forward;
	}

}
