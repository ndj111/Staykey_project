package com.admin.action;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.ReviewDAO;
import com.model.ReviewDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class AdminReviewModifyOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 리뷰 수정을 하는 비지니스 로직.
		
		ReviewDTO dto = new ReviewDTO();
		ReviewDAO dao = ReviewDAO.getInstance();
		
        // 파일 업로드 설정
        String thisFolder = "/data/review/";
        String saveFolder = request.getSession().getServletContext().getRealPath(thisFolder);
        int fileSize = 10 * 1024 * 1024; // 10MB

        // 업로드 폴더 체크 후 없으면 생성
        File dirChk = new File(saveFolder);
        if (!dirChk.exists()) {
            dirChk.mkdir();
        }

        // 파일 업로드 객체 생성 여기서 파일 생성
        MultipartRequest multi = new MultipartRequest(request, saveFolder, fileSize, "UTF-8", new DefaultFileRenamePolicy());

        // 파라미터 정리
		String review_stayname = multi.getParameter("review_stayname").trim();
		String review_roomname = multi.getParameter("review_roomname").trim();
		String review_id = multi.getParameter("review_id").trim();
		String review_name = multi.getParameter("review_name").trim();
		String review_content = multi.getParameter("review_content").trim();
		int point1 = Integer.parseInt(multi.getParameter("review_point1").trim());
		int point2 = Integer.parseInt(multi.getParameter("review_point2").trim());
		int point3 = Integer.parseInt(multi.getParameter("review_point3").trim());
		int point4 = Integer.parseInt(multi.getParameter("review_point4").trim());
		int point5 = Integer.parseInt(multi.getParameter("review_point5").trim());
		int point6 = Integer.parseInt(multi.getParameter("review_point6").trim());
		
		// 히든 값으로 넘어온 후기 글번호
		int review_no = Integer.parseInt(multi.getParameter("review_no").trim());
		
		// 포인트 평균 값
		double review_point_total = Math.round(((point1+point2+point3+point4+point5+point6)/6.0) * 10)/10.0;
        
        // DB에서 후기 번호에서 기존에 있던 후기파일 주소값 가져오기
        dto = dao.getReviewInfo(review_no);
        String file = dto.getReview_file();
        
        // 첨부파일 이름 변경 처리
        File review_file = multi.getFile("review_file");
        if (review_file != null) { // 변경 될 후기파일이 있으면 삭제 후 추가
            String delFolder = request.getSession().getServletContext().getRealPath("/");
            File del_pimage = new File(delFolder + file);
            // del_pimage.delete() 실제로 삭제시키는 메서드
            if (del_pimage.exists()) {
                if (del_pimage.delete()) {
                    System.out.println("후기 파일 삭제 완료");
                } else {
                    System.out.println("후기 파일 삭제 실패");
                }
            }

            String fileExt = review_file.getName().substring(review_file.getName().lastIndexOf(".") + 1);
            String review_file_flie_rename = review_id + "_" + System.currentTimeMillis() + "." + fileExt;
            review_file.renameTo(new File(saveFolder + "/" + review_file_flie_rename)); // 여기서 이름 변경

            // DB에 저장되는 파일 이름
            // 저장이름 : /data/저장폴더/회원아이디_현재날짜(유닉스타임)
            String fileDBName = thisFolder + review_file_flie_rename;
            dto.setReview_file(fileDBName);

        } else { // 기존꺼 주소값 저장
            dto.setReview_file(file);
        }
        
        dto.setReview_stayname(review_stayname);
        dto.setReview_roomname(review_roomname);
        dto.setReview_id(review_id);
        dto.setReview_name(review_name);
        dto.setReview_point1(point1);
        dto.setReview_point2(point2);
        dto.setReview_point3(point3);
        dto.setReview_point4(point4);
        dto.setReview_point5(point5);
        dto.setReview_point6(point6);
        dto.setReview_content(review_content);
        dto.setReview_no(review_no);
        dto.setReview_point_total(review_point_total);
        
        int check = dao.reviewModify(dto); 
        ActionForward forward = new ActionForward();
        PrintWriter out = response.getWriter();

        if (check > 0) {
            forward.setRedirect(true); forward.setPath("reviewList.do");
        } else {
            out.println("<script>alert('후기 정보 수정 중 에러가 발생하였습니다.'); history.back();</script>");
        }

        return forward;
	}

}
