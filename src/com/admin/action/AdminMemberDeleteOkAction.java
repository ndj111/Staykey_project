package com.admin.action;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.MemberDAO;
import com.model.MemberDTO;

public class AdminMemberDeleteOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 회원 정보를 삭제하는 비지니스 로직입니다. id 값을 받아온다.
		String member_id = request.getParameter("id");
		
		MemberDAO dao = MemberDAO.getInstance();

		// 파일 저장 폴더
        String saveFolder = request.getSession().getServletContext().getRealPath("/");

        MemberDTO dto = dao.getMemberInfo(member_id);
		String member_photo = dto.getMember_photo();
		int memberNo = dto.getMember_no();
		
		
		if(member_photo != null){
		    File del_pimage = new File(saveFolder+member_photo);
		    if(del_pimage.exists()){
		        if(del_pimage.delete()) {
		            System.out.println("프로필 파일 삭제 완료");
		        }else {
		            System.out.println("프로필 파일 삭제 실패");
		        }
		    }
		}
		
		int res = dao.deleteMember(member_id, memberNo);
		
		ActionForward forward = new ActionForward();
		PrintWriter out = response.getWriter();

		
        if (res > 0) {
            forward.setRedirect(true);
            forward.setPath("memberList.do");
        } else {
            out.println("<script>alert('회원 삭제 중 에러가 발생하였습니다.'); history.back();</script>");
        }
		
		
		
		return forward;
	}

}
