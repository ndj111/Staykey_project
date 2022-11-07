package com.site.action;

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

public class SiteMypageInfoOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

        MemberDAO dao = MemberDAO.getInstance();
	    PrintWriter out = response.getWriter();


	    // 파일 업로드 설정
		String thisFolder = "/data/profile/";
		String saveFolder = request.getSession().getServletContext().getRealPath(thisFolder);
		int fileSize = 25 * 1024 * 1024; // 10MB

		// 업로드 폴더 체크 후 없으면 생성
		File dirChk = new File(saveFolder);
		if (!dirChk.exists()) {
			dirChk.mkdir();
		}

		// 파일 업로드 객체 생성
		MultipartRequest multi = new MultipartRequest(request, saveFolder, fileSize, "UTF-8", new DefaultFileRenamePolicy());


		// 입력값 정리
		String modify_id = multi.getParameter("modify_id").trim();
		String modify_email = multi.getParameter("modify_email").trim();
		String modify_name = multi.getParameter("modify_name").trim();
		String modify_phone = multi.getParameter("modify_phone").trim();
		String modify_pw = multi.getParameter("modify_pw").trim();
		String now_pw = multi.getParameter("now_pw").trim();


        // 현재 비밀번호 체크
        MemberDTO ndto = new MemberDTO();
        ndto = dao.getMemberInfo(modify_id);
        if(!ndto.getMember_pw().equals(now_pw)){
            out.println("<script>alert('현재 비밀번호가 일치하지 않습니다.\\n다시 확인 후 입력해주세요.'); history.back();</script>");
            return null;
        }


		// 회원정보 객체에 저장
        MemberDTO dto = new MemberDTO();
		dto.setMember_id(modify_id);
		dto.setMember_email(modify_email);
		dto.setMember_name(modify_name);
		dto.setMember_phone(modify_phone);

		if(modify_pw != null && modify_pw.length() > 0){
		    dto.setMember_pw(modify_pw);
		}else{
		    dto.setMember_pw(now_pw);
		}


        // 첨부파일 이름 변경 처리
        File modify_photo = multi.getFile("modify_photo");
        if(modify_photo != null) {
            String fileExt = modify_photo.getName().substring(modify_photo.getName().lastIndexOf(".") + 1);
            String member_photo_flie_rename = modify_id + "_" + System.currentTimeMillis() + "." + fileExt;
            modify_photo.renameTo(new File(saveFolder + "/" + member_photo_flie_rename));

            // DB에 저장되는 파일 이름
            // 저장이름 : /data/저장폴더/회원아이디_현재날짜(유닉스타임)
            String fileDBName = thisFolder + member_photo_flie_rename;
            dto.setMember_photo(fileDBName);
        }


		// 새로운 파일을 등록하고, 기존 파일 있으면 삭제 처리
        if(modify_photo != null && ndto.getMember_photo() != null){
            File del_pimage = new File(saveFolder+ndto.getMember_photo().replace(thisFolder, ""));
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
		int result = dao.infoModifySite(dto);

		if(result > 0){
			forward.setRedirect(true);
			forward.setPath("mypageInfo.do");

		}else{
		    // 에러 중 등록 된 파일 삭제
		    String upload_photo = modify_photo.getName();
	        if(upload_photo != null){
	            File del_pimage = new File(saveFolder+upload_photo);
	            if(del_pimage.exists()){
	                if(del_pimage.delete()) {
	                    System.out.println("에러 중 등록 된 파일 삭제 완료");
	                }else {
	                    System.out.println("에러 중 등록 된 파일 삭제 실패");
	                }
	            }else{
	                System.out.println("에러 중 등록 된 파일 경로를 찾을 수 없습니다.");
	            }
	        }

		    forward = null;
			out.println("<script>alert('회원 정보 수정 중 에러가 발생했습니다.'); history.back();</script>");
		}

		return forward;
	}

}

