package com.admin.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.StayDAO;
import com.model.StayDTO;

public class AdminStaySearchOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("text/html; charset=UTF-8");

		String search_type = request.getParameter("type");
		String search_text = request.getParameter("search");

		StayDAO dao = StayDAO.getInstance();
		List<StayDTO> list = dao.getStaySearchList(search_type, search_text);

		String result = "" + list.size() + "◇";

		for (int i = 0; i < list.size(); i++) {
			StayDTO dto = list.get(i);

			result += "♠";
			result += dto.getStay_no();
			result += "♣";
			result += dto.getStay_type();
			result += "♣";
			result += dto.getStay_name();
			result += "♣";
			result += dto.getStay_desc();
			result += "♣";
			result += dto.getStay_file1();
			result += "♣";
			result += dto.getStay_file2();
			result += "♣";
			result += dto.getStay_file3();
			result += "♣";
			result += dto.getStay_file4();
			result += "♣";
			result += dto.getStay_file5();
		}

		PrintWriter out = response.getWriter();
		out.println(result);

		return null;
	}

}
