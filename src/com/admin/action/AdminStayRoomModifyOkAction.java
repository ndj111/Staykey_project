package com.admin.action;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.StayDAO;
import com.model.StayRoomDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class AdminStayRoomModifyOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 방 정보 수정	
			
		StayRoomDTO dto = new StayRoomDTO();
		StayDAO dao = StayDAO.getInstance();

        // 파일 업로드 설정
        String thisFolder = "/data/stayRoom/";
        String saveFolder = request.getSession().getServletContext().getRealPath(thisFolder);
        int fileSize = 25 * 1024 * 1024; // 25MB

        // 업로드 폴더 체크 후 없으면 생성
        File dirChk = new File(saveFolder);
        if (!dirChk.exists()) {
            dirChk.mkdir();
        }

        // 파일 업로드 객체 생성
        MultipartRequest multi = new MultipartRequest(request, saveFolder, fileSize, "UTF-8", new DefaultFileRenamePolicy());

        String features_sum = "";
        String amenities_sum = "";
        String service_sum = "";
        String room_desc = "";
        String room_bed = "";
        String room_tag = "";
        String[] room_file_delete = null;
        List<String> roomList = null;

        // 파라미터 정리
        int room_no = Integer.parseInt(multi.getParameter("room_no"));
        int room_stayno = Integer.parseInt(multi.getParameter("stay_no"));
        String room_name = multi.getParameter("room_name").trim();
        if(multi.getParameter("room_desc") != null) { room_desc = multi.getParameter("room_desc").trim(); }
        String room_type = multi.getParameter("room_type").trim();
        int room_price = Integer.parseInt(multi.getParameter("room_price").trim());
        String room_checkin = multi.getParameter("room_checkin").trim();
        String room_checkout = multi.getParameter("room_checkout").trim();
        int room_people_min = Integer.parseInt(multi.getParameter("room_people_min"));
        int room_people_max = Integer.parseInt(multi.getParameter("room_people_max"));
        int room_size = Integer.parseInt(multi.getParameter("room_size").trim());      
        if(multi.getParameter("room_bed") != null) { room_bed = multi.getParameter("room_bed").trim(); }
        if(multi.getParameter("room_tag") != null) { room_tag = multi.getParameter("room_tag"); }
        
        if(multi.getParameterValues("room_file_delete") != null) {
        	room_file_delete = multi.getParameterValues("room_file_delete");
        	roomList = Arrays.asList(room_file_delete);
        }
        
        // 체크박스 선택 안 한 경우, null 값 처리
        if(multi.getParameterValues("room_features") != null) {
        	String[] room_features = multi.getParameterValues("room_features");
        	for(int i = 0; i < room_features.length; i++) {
        		features_sum += room_features[i] + "/";
        	}
        	features_sum = "/" + features_sum;         	
        } 
        
        if(multi.getParameterValues("room_amenities") != null) {
	        String[] room_amenities = multi.getParameterValues("room_amenities");
        	for(int i = 0; i < room_amenities.length; i++) {
        		amenities_sum += room_amenities[i] + "/";
        	}
	        amenities_sum = "/" + amenities_sum;
        }

        if(multi.getParameterValues("room_service") != null) {
        	String[] room_service = multi.getParameterValues("room_service");
    		for(int i = 0; i < room_service.length; i++) {
    			service_sum += room_service[i] + "/";
    		}
    		service_sum = "/" + service_sum;
    	}
        
        dto.setRoom_no(room_no);
        dto.setRoom_stayno(room_stayno);
        dto.setRoom_name(room_name);
        dto.setRoom_desc(room_desc);
        dto.setRoom_type(room_type);
        dto.setRoom_price(room_price);
        dto.setRoom_checkin(room_checkin);
        dto.setRoom_checkout(room_checkout);
        dto.setRoom_people_min(room_people_min);
        dto.setRoom_people_max(room_people_max);
        dto.setRoom_size(room_size);
        dto.setRoom_bed(room_bed);
        dto.setRoom_features(features_sum); 
        dto.setRoom_amenities(amenities_sum);
        dto.setRoom_service(service_sum);
        dto.setRoom_tag(room_tag);
        
        // 순서 지정 문제 해결 위함
	    Map<String, Object> map = new HashMap<String, Object>();	    
	    map.put("room1", multi.getFile("room_photo1"));
	    map.put("room2", multi.getFile("room_photo2"));
	    map.put("room3", multi.getFile("room_photo3"));
	    map.put("room4", multi.getFile("room_photo4"));
	    map.put("room5", multi.getFile("room_photo5"));
	    
	    // 기존 파일 정보 가져오기 위함
 	    StayRoomDTO viewDTO = dao.getStayRoomView(room_no, room_stayno);
 	    String original_room1 = viewDTO.getRoom_photo1();
 	    String original_room2 = viewDTO.getRoom_photo2();
 	    String original_room3 = viewDTO.getRoom_photo3();
 	    String original_room4 = viewDTO.getRoom_photo4();
 	    String original_room5 = viewDTO.getRoom_photo5();
 	    
 	    // delete folder 현재 경로 받아옴
 	    String delFolder = request.getSession().getServletContext().getRealPath("/");

 	    Iterator<Map.Entry<String, Object>> iterator = map.entrySet().iterator(); // iterator로 다음 값 가져옴
 	    String original_file = ""; // 예전 파일 변수로 지정
 	    File roomFile = null; // stayFile 변수 선언 / delete 용

 		
 		while(iterator.hasNext()) { 
 			Entry<String, Object> e = iterator.next();
 			File file = (File) e.getValue(); // map에 저장된 파일 객체의 value 값만 얻어와서 File형으로 casting
 			
 			// 수정되는 항목 없이 수정 누르는 경우, NullPointerException 방지 위해 수정...
 			switch (e.getKey()) { // original file 값 할당
	 			case "room1": 
	 				original_file = original_room1; 
	 				if(roomList != null) { if(roomList.contains("Y1")) { roomFile = new File(delFolder + original_file); }else { roomFile = null; }}
	 				break;
	 			case "room2": 
	 				original_file = original_room2; 
	 				if(roomList != null) { if(roomList.contains("Y2")) { roomFile = new File(delFolder + original_file); }else { roomFile = null; }}
	 				break;
	 			case "room3": 
	 				original_file = original_room3; 
	 				if(roomList != null) { if(roomList.contains("Y3")) { roomFile = new File(delFolder + original_file); }else { roomFile = null; }}
	 				break;
	 			case "room4": 
	 				original_file = original_room4; 
	 				if(roomList != null) { if(roomList.contains("Y4")) { roomFile = new File(delFolder + original_file); }else { roomFile = null; }}
	 				break;
	 			case "room5": 
	 				original_file = original_room5; 
	 				if(roomList != null) { if(roomList.contains("Y5")) { roomFile = new File(delFolder + original_file); }else { roomFile = null; }}
	 				break;
 			}
 			
 			if(file != null) { // value 값이 null이 아니면(new file 있음)
 	 	    	File del_image = new File(delFolder + original_file);        	
 	 	    	if(del_image.exists()) { del_image.delete(); }
 				String fileExt = file.toString().substring(file.toString().lastIndexOf(".") + 1); // 확장자 분리 
 				String fileRename = e.getKey() + "_modify_" + System.currentTimeMillis() + "." +fileExt; // 파일 rename 
 				file.renameTo(new File(saveFolder + fileRename)); // file을 인자로 전달된 파일의 경로로 변경
 				map.replace(e.getKey(), thisFolder + fileRename); // 현재 key 값에 새로운 value 값을 map에 저장
 			}else { // new file 없으면
 				if(original_file != null) {// 예전 파일이 null이 아니면 					
 					map.replace(e.getKey(), original_file); // 예전 값 할당
 					// 파일 삭제 체크표시
 					if(roomFile != null) {
						if(roomFile.exists()) { 
							roomFile.delete(); 
		 					map.replace(e.getKey(), ""); // null 값 처리
						}else {
		 					map.replace(e.getKey(), ""); // null 값 처리
						}
					}
 				}else {
 					map.replace(e.getKey(), ""); // null 값 처리 위함
 				}
 			}
 		}

		dto.setRoom_photo1(map.get("room1").toString());
		dto.setRoom_photo2(map.get("room2").toString());
		dto.setRoom_photo3(map.get("room3").toString());
		dto.setRoom_photo4(map.get("room4").toString());
		dto.setRoom_photo5(map.get("room5").toString());

        int res = dao.modifyStayRoom(dto);
        PrintWriter out = response.getWriter();

        if (res > 0) {
            out.println("<script>alert('수정되었습니다.'); window.resizeTo(1400,900); location.href='stayRoomView.do?room_no="+room_no+"&stay_no="+room_stayno+"';</script>");
        } else {
            out.println("<script>alert('Room 등록 중 에러가 발생했습니다.'); history.back();</script>");
        }	
		return null;
	}

}
