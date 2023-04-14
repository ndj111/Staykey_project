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
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class AdminMemberModifyOkAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 회원 수정

        MemberDTO dto = new MemberDTO();
        MemberDAO dao = MemberDAO.getInstance();

        // 파일 업로드 설정
        String thisFolder = "/data/profile/";
        String saveFolder = request.getSession().getServletContext().getRealPath(thisFolder);
        int fileSize = 20 * 1024 * 1024; // 10MB

        // 업로드 폴더 체크 후 없으면 생성
        File dirChk = new File(saveFolder);
        if (!dirChk.exists()) {
            dirChk.mkdir();
        }

        // 파일 업로드 객체 생성 여기서 파일 생성
        MultipartRequest multi = new MultipartRequest(request, saveFolder, fileSize, "UTF-8", new DefaultFileRenamePolicy());

        // 파라미터 정리
        String member_type = multi.getParameter("member_type").trim();
        String member_id = multi.getParameter("member_id").trim();
        String member_pw = multi.getParameter("member_pw").trim();
        String member_pw_chg = multi.getParameter("member_pw_chg").trim();
        String member_name = multi.getParameter("member_name").trim();
        String member_email = multi.getParameter("member_email").trim();
        String member_phone = multi.getParameter("member_phone").trim();

        if (member_pw_chg.length() > 0 && member_pw_chg != null) {
            member_pw = member_pw_chg;
        }

        // DB에서 회원 아이디에서 기존에 있던 프사 주소값 가져오기
        MemberDTO pdto = dao.getMemberInfo(member_id);
        String photo = pdto.getMember_photo();
        
        // 첨부파일 이름 변경 처리
        File member_photo = multi.getFile("member_photo");
        if (member_photo != null) { // 변경 될 프사가 있으면 삭제 후 추가
            String delFolder = request.getSession().getServletContext().getRealPath("/");
            File del_pimage = new File(delFolder + photo);
            // del_pimage.delete() 실제로 삭제시키는 메서드
            if (del_pimage.exists()) {
                if (del_pimage.delete()) {
                    System.out.println("프로필 파일 삭제 완료");
                } else {
                    System.out.println("프로필 파일 삭제 실패");
                }
            }

            String fileExt = member_photo.getName().substring(member_photo.getName().lastIndexOf(".") + 1);
            String member_photo_flie_rename = member_id + "_" + System.currentTimeMillis() + "." + fileExt;
            member_photo.renameTo(new File(saveFolder + "/" + member_photo_flie_rename)); // 여기서 이름 변경

            // DB에 저장되는 파일 이름
            // 저장이름 : /data/저장폴더/회원아이디_현재날짜(유닉스타임)
            String fileDBName = thisFolder + member_photo_flie_rename;
            dto.setMember_photo(fileDBName);

        } else { // 기존꺼 주소값 저장
            dto.setMember_photo(photo);
        }

        dto.setMember_type(member_type);
        dto.setMember_id(member_id);
        dto.setMember_pw(member_pw);
        dto.setMember_name(member_name);
        dto.setMember_email(member_email);
        dto.setMember_phone(member_phone);


        int check = dao.memberModify(dto); 
        ActionForward forward = new ActionForward();
        PrintWriter out = response.getWriter();

        if (check > 0) {
            forward.setRedirect(true); forward.setPath("memberList.do");
        } else {
            out.println("<script>alert('회원 정보 수정 중 에러가 발생하였습니다.'); history.back();</script>");
        }



        return forward;

    }

}
