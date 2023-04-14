package com.admin.action;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.StayDAO;
import com.model.StayDTO;
import com.model.StayRoomDTO;

public class AdminStayDeleteOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 숙소 삭제 + 방 삭제
		
		StayDAO dao = StayDAO.getInstance();
		String saveFolder = request.getSession().getServletContext().getRealPath("/");
		
		int stayNo = Integer.parseInt(request.getParameter("stay_no"));
		
		StayDTO dto = dao.getStayView(stayNo);
		String stay_file1 = dto.getStay_file1();
		String stay_file2 = dto.getStay_file2();
		String stay_file3 = dto.getStay_file3();
		String stay_file4 = dto.getStay_file4();
		String stay_file5 = dto.getStay_file5();
		String stay_option1_photo = dto.getStay_option1_photo();
		String stay_option2_photo = dto.getStay_option2_photo();
		String stay_option3_photo = dto.getStay_option3_photo();
		
		// room 삭제
		List<Integer> selectedRoom = dao.getSelectedRoom(stayNo);
		int[] roomNums = new int[selectedRoom.size()];
		
		for (int i = 0; i < selectedRoom.size(); i++) {
			roomNums[i] = selectedRoom.get(i).intValue();
			StayRoomDTO roomDTO = dao.getStayRoomView(roomNums[i], stayNo);
			String room_photo1 = roomDTO.getRoom_photo1();
			String room_photo2 = roomDTO.getRoom_photo2();
			String room_photo3 = roomDTO.getRoom_photo3();
			String room_photo4 = roomDTO.getRoom_photo4();
			String room_photo5 = roomDTO.getRoom_photo5();
			
			String[] room_file = 
				{ room_photo1, room_photo2, room_photo3, room_photo4, room_photo5 };
			
			for(int j = 0; j < room_file.length; j++) {
				if(room_file[j] != null) {
					File del_image = new File(saveFolder + room_file[j]);     
		        	if(del_image.exists()) { del_image.delete(); }
				}
			}
			
	        dao.deleteRoom(roomNums[i]);
		}
		
		// 파일 삭제 refactoring...
		String[] stay_file = 
			{ stay_file1, stay_file2, stay_file3, stay_file4, stay_file5, stay_option1_photo, stay_option2_photo, stay_option3_photo };
		
		for(int i=0; i<stay_file.length; i++) {
			if(stay_file[i] != null) {
				File del_image = new File(saveFolder + stay_file[i]);     
	        	if(del_image.exists()) { del_image.delete(); }
			}
		}
                
		int res = dao.deleteStay(stayNo);
		
		ActionForward forward = new ActionForward();
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        
		if(res > 0) {
			session.setAttribute("msg", "<script> alert('성공적으로 삭제되었습니다.'); </script>");
			forward.setRedirect(true);
			forward.setPath("stayList.do");
		}else {
            out.println("<script> alert('숙소 삭제 중 에러가 발생했습니다.'); history.back(); </script>");
		}		
		return forward;
	}

}
