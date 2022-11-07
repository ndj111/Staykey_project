package com.site.action;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.QnaDAO;
import com.model.QnaDTO;

public class SiteMypageQnaDeleteOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

        int qna_no = Integer.parseInt(request.getParameter("qna_no").trim());


        PrintWriter out = response.getWriter();
		ActionForward forward = new ActionForward();


		QnaDAO dao = QnaDAO.getInstance();
        QnaDTO dto = dao.getQnaInfo(qna_no);


        if(!dto.getBbs_status().equals("send")){
            out.println("<script>alert('처리중 & 답변완료 문의글은 삭제 할 수 없습니다.'); history.back();</script>");
            return null;
        }


        // 첨부파일 삭제
        String thisFolder = "/data/qna/";
        String saveFolder = request.getSession().getServletContext().getRealPath(thisFolder);
        if(dto.getBbs_file1() != null){
            File del_pimage = new File(saveFolder+dto.getBbs_file1().replace(thisFolder, ""));
            if(del_pimage.exists()){
                if(del_pimage.delete()) {
                    System.out.println("첨부파일 1 삭제 완료");
                }else {
                    System.out.println("첨부파일 1 삭제 실패");
                }
            }else{
                System.out.println("첨부파일 1 경로를 찾을 수 없습니다.");
            }
        }

        if(dto.getBbs_file2() != null){
            File del_pimage = new File(saveFolder+dto.getBbs_file2().replace(thisFolder, ""));
            if(del_pimage.exists()){
                if(del_pimage.delete()) {
                    System.out.println("첨부파일 2 삭제 완료");
                }else {
                    System.out.println("첨부파일 2 삭제 실패");
                }
            }else{
                System.out.println("첨부파일 2 경로를 찾을 수 없습니다.");
            }
        }

        // 문의글 삭제
        int result = dao.deleteQna(qna_no);


        // 댓글 삭제
        dao.deleteQnaCommentAll(qna_no);


        if(result > 0){
            forward.setRedirect(true);
            forward.setPath("mypageQnaList.do");

        }else{
            out.println("<script>alert('문의글 삭제 중 에러가 발생하였습니다.'); history.back();</script>");
            forward = null;
        }

		return forward;

	}

}
