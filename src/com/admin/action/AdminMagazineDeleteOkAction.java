package com.admin.action;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.MagazineDAO;
import com.model.MagazineDTO;

public class AdminMagazineDeleteOkAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

        MagazineDAO dao = MagazineDAO.getInstance();

        String saveFolder = request.getSession().getServletContext().getRealPath("/");

        int mag_no = Integer.parseInt(request.getParameter("bbs_no"));
        MagazineDTO dto = dao.getMagView(mag_no);

        String bbs_list_img = dto.getBbs_list_img();
        String bbs_top_img = dto.getBbs_top_img();
        String bbs_detail_img1 = dto.getBbs_detail_img1();
        String bbs_detail_img2 = dto.getBbs_detail_img2();

        if (bbs_list_img != null) {
            File del_image = new File(saveFolder + bbs_list_img);
            if (del_image.exists()) {
                del_image.delete();
            }
        }
        if (bbs_top_img != null) {
            File del_image = new File(saveFolder + bbs_top_img);
            if (del_image.exists()) {
                del_image.delete();
            }
        }
        if (bbs_detail_img1 != null) {
            File del_image = new File(saveFolder + bbs_detail_img1);
            if (del_image.exists()) {
                del_image.delete();
            }
        }
        if (bbs_detail_img2 != null) {
            File del_image = new File(saveFolder + bbs_detail_img2);
            if (del_image.exists()) {
                del_image.delete();
            }
        }

        int res = dao.deleteMag(mag_no);

        ActionForward forward = new ActionForward();
        PrintWriter out = response.getWriter();

        if (res > 0) {
            forward.setRedirect(true);
            forward.setPath("magazineList.do");
        } else {
            out.println("<script> alert('삭제 중 에러가 발생했습니다.'); history.back(); </script>");
        }
        return forward;
    }

}
