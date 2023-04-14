package com.admin.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.StayDAO;
import com.model.StayRoomDTO;
import com.util.showArray;

public class AdminStayRoomModifyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// room 수정하기 방 정보 받아오기
		int stayNo = Integer.parseInt(request.getParameter("stay_no"));
		int roomNo = Integer.parseInt(request.getParameter("room_no"));

		StayDAO dao = StayDAO.getInstance();
		StayRoomDTO dto = dao.getStayRoomView(roomNo, stayNo);

		request.setAttribute("stay_no", stayNo);
		request.setAttribute("roomModify", dto);


        // 방 타입 배열 넘겨주기
        showArray getRoomtype = new showArray();
        getRoomtype.getList("roomType");
        List<String> roomType = getRoomtype.listArr;
        request.setAttribute("roomType", roomType);

        // 방 FEATURES 배열 넘겨주기
        showArray getRoomFeat = new showArray();
        getRoomFeat.getList("roomFeat");
        List<String> roomFeat = getRoomFeat.listArr;
        request.setAttribute("roomFeat", roomFeat);

        // 방 AMENITIES 배열 넘겨주기
        showArray getRoomAmeni = new showArray();
        getRoomAmeni.getList("roomAmeni");
        List<String> roomAmeni = getRoomAmeni.listArr;
        request.setAttribute("roomAmeni", roomAmeni);

        // 방 SERVICES 배열 넘겨주기
        showArray getRoomService = new showArray();
        getRoomService.getList("roomService");
        List<String> roomService = getRoomService.listArr;
        request.setAttribute("roomService", roomService);


		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("stay/stay_room_modify.jsp");

		return forward;
	}

}
