package com.site.action;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.MemberDAO;
import com.model.MemberDTO;


public class SiteMypageExitOkAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
        MemberDAO dao = MemberDAO.getInstance();

        String member_id = request.getParameter("member_id").trim();

        MemberDTO dto = dao.getMemberInfo(member_id);        

        // 프로필 사진 삭제
        if(dto.getMember_photo() != null){
            String thisFolder = "/data/profile/";
            String saveFolder = request.getSession().getServletContext().getRealPath(thisFolder);
            File del_pimage = new File(saveFolder+dto.getMember_photo().replace(thisFolder, ""));
            if(del_pimage.exists()){
                if(del_pimage.delete()) {
                    System.out.println("프로필 파일 삭제 완료");
                }else {
                    System.out.println("프로필 파일 삭제 실패");
                }
            }else{
                System.out.println("파일 경로를 찾을 수 없습니다.");
            }
        }


        ActionForward forward = new ActionForward();
        PrintWriter out = response.getWriter();

        int result = dao.exitMember(member_id);

        if(result > 0){
            // 세션 삭제
            HttpSession session = request.getSession();
            session.invalidate();

            forward.setRedirect(false);
            forward.setPath("index.jsp");

        }else{
            forward = null;
            out.println("<script>alert('회원 탈퇴 중 에러가 발생하였습니다.'); history.back();</script>");
        }

        return forward;
    }

}
