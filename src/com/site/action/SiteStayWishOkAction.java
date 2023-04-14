package com.site.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.WishDAO;

public class SiteStayWishOkAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html; charset=UTF-8");

        WishDAO dao = WishDAO.getInstance();

        String wish_mode = request.getParameter("wish_mode");
        int stay_no = Integer.parseInt(request.getParameter("stay_no"));
        String member_id = request.getParameter("member_id");

        String result = "";
        if(wish_mode.equals("del")) {
            result = dao.delWish(stay_no, member_id);
        }else{
            result = dao.addWish(stay_no, member_id);
        }

        PrintWriter out = response.getWriter();
        out.println(result);
        System.out.println("찜하기 결과 >> " + result);

        return null;
    }

}
