package com.site.action;

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

public class SiteMypageReservReviewOkAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

        ReviewDAO dao = ReviewDAO.getInstance();
        PrintWriter out = response.getWriter();


        // 파일 업로드 설정
        String thisFolder = "/data/review/";
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
        int review_stayno = Integer.parseInt(multi.getParameter("review_stayno").trim());
        String review_stayname = multi.getParameter("review_stayname").trim();
        int review_roomno = Integer.parseInt(multi.getParameter("review_roomno").trim());
        String review_roomname = multi.getParameter("review_roomname").trim();
        int review_point1 = Integer.parseInt(multi.getParameter("review_point1").trim());
        int review_point2 = Integer.parseInt(multi.getParameter("review_point2").trim());
        int review_point3 = Integer.parseInt(multi.getParameter("review_point3").trim());
        int review_point4 = Integer.parseInt(multi.getParameter("review_point4").trim());
        int review_point5 = Integer.parseInt(multi.getParameter("review_point5").trim());
        int review_point6 = Integer.parseInt(multi.getParameter("review_point6").trim());
        String review_content = multi.getParameter("review_content").trim();
        String review_id = multi.getParameter("review_id").trim();
        String review_pw = multi.getParameter("review_pw").trim();
        String review_name = multi.getParameter("review_name").trim();

        // 후기 평균 값
        double review_point_total = Math.round(((review_point1+review_point2+review_point3+review_point4+review_point5+review_point6)/6.0) * 10)/10.0;


        // 리뷰 객체에 저장
        ReviewDTO dto = new ReviewDTO();
        dto.setReview_stayno(review_stayno);
        dto.setReview_stayname(review_stayname);
        dto.setReview_roomno(review_roomno);
        dto.setReview_roomname(review_roomname);
        dto.setReview_point_total(review_point_total);
        dto.setReview_point1(review_point1);
        dto.setReview_point2(review_point2);
        dto.setReview_point3(review_point3);
        dto.setReview_point4(review_point4);
        dto.setReview_point5(review_point5);
        dto.setReview_point6(review_point6);
        dto.setReview_content(review_content);
        dto.setReview_id(review_id);
        dto.setReview_pw(review_pw);
        dto.setReview_name(review_name);


        File review_file = multi.getFile("review_file");
        if(review_file != null) {
            String fileExt = review_file.getName().substring(review_file.getName().lastIndexOf(".") + 1);
            String review_flie_rename = review_id + "_" + System.currentTimeMillis() + "." + fileExt;
            review_file.renameTo(new File(saveFolder + "/" + review_flie_rename));

            // DB에 저장되는 파일 이름
            // 저장이름 : /data/저장폴더/회원아이디_현재날짜(유닉스타임)
            String fileDBName = thisFolder + review_flie_rename;
            dto.setReview_file(fileDBName);
        }



        String[] result = dao.writeReview(dto).split("/");
        int res = 0;
        int num = 0;

        if(result != null) {
            res = Integer.parseInt(result[0]);
            num = Integer.parseInt(result[1]);
        }

        if (result != null && res > 0) {
            String review_cont = review_content.replaceAll("(\r\n|\r|\n|\n\r)", "<br />");
            if(review_cont.length() > 35) review_cont = review_cont.substring(0, 35) + "...";
            out.println("<script>var webSocket = new WebSocket(\"ws://121.164.91.191:8080/Staykey_project/webSocket\"); "
                    + "webSocket.onopen = function(event) { webSocket.send(\"review|"+review_name+"|"+review_id+"|"+review_cont+"|"+num+"\"); "
                    + "webSocket.close(); };</script>");
            out.println("<script>setTimeout(function(){ location.href='mypageReservList.do?type=done'; }, 500);</script>");

        }else{
            // 에러 중 등록 된 파일 삭제
            if(multi.getFile("review_file") != null){
                String upload_file = review_file.getName();
                if(upload_file != null){
                    File del_pimage = new File(saveFolder+upload_file);
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
            }

            out.println("<script>alert('후기 등록 중 에러가 발생하였습니다.'); history.back();</script>");
        }

        return null;
    }

}
