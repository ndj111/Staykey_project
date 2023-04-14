package com.admin.action;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.StayDAO;
import com.model.StayRoomDTO;

public class AdminStayRoomDeleteOkAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 방 삭제 메서드

    	StayDAO dao = StayDAO.getInstance();
		String saveFolder = request.getSession().getServletContext().getRealPath("/");
        
		int room_no = Integer.parseInt(request.getParameter("room_no"));
		int stay_no = Integer.parseInt(request.getParameter("stay_no"));

        StayRoomDTO dto = dao.getStayRoomView(room_no, stay_no);        
		String room_photo1 = dto.getRoom_photo1();
		String room_photo2 = dto.getRoom_photo2();
		String room_photo3 = dto.getRoom_photo3();
		String room_photo4 = dto.getRoom_photo4();
		String room_photo5 = dto.getRoom_photo5();
		
		// 파일 삭제 
		String[] room_file = 
			{ room_photo1, room_photo2, room_photo3, room_photo4, room_photo5 };
		
		for(int i=0; i<room_file.length; i++) {
			if(room_file[i] != null) {
				File del_image = new File(saveFolder + room_file[i]);     
	        	if(del_image.exists()) { del_image.delete(); }
			}
		}

        int res = dao.deleteRoom(room_no);
        PrintWriter out = response.getWriter();
        

        if (res > 0) {
        	// 부모 위치 이동 & 지금 보는 창 꺼짐 기능 / opener 붙여야 작동 됨(parent 빼면 작동 안 됨)
            out.println("<script>alert('등록된 Room이 성공적으로 삭제되었습니다.'); opener.parent.location.href='stayView.do?stay_no="+stay_no+"'; window.close();</script>");
        } else {
            out.println("<script>alert('Room 삭제 중 에러가 발생했습니다.'); history.back();</script>");
        }
		return null;
    }
}
