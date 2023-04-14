package com.admin.action;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Iterator;
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

public class AdminStayRoomWriteOkAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // StayRoom! 방 등록하기

        StayRoomDTO dto = new StayRoomDTO();

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

        // 파라미터 정리
        int stay_stayNo = Integer.parseInt(multi.getParameter("stayNo"));
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
        
        dto.setRoom_stayno(stay_stayNo);
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
	    
	    Iterator<Map.Entry<String, Object>> iterator = map.entrySet().iterator(); // iterator로 다음 값 가져옴
		
		while(iterator.hasNext()) { 
			Entry<String, Object> e = iterator.next();
			File file = (File) e.getValue(); // map에 저장된 파일 객체의 value 값만 얻어와서 File형으로 casting
			
			if(file != null) { // value 값이 null이 아니면
				String fileExt = file.toString().substring(file.toString().lastIndexOf(".") + 1); // 확장자 분리 
				String fileRename = e.getKey() + "_original_" + System.currentTimeMillis() + "." +fileExt; // 파일 rename 
				file.renameTo(new File(saveFolder + fileRename)); // 파일 경로를 인자로 전달된 경로로 변경
				map.replace(e.getKey(), thisFolder + fileRename); // 현재 key 값에 새로운 value 값을 map에 저장
			}else {
				map.replace(e.getKey(), ""); // null 값 처리 위함
			}
		}
		
		dto.setRoom_photo1(map.get("room1").toString());
		dto.setRoom_photo2(map.get("room2").toString());
		dto.setRoom_photo3(map.get("room3").toString());
		dto.setRoom_photo4(map.get("room4").toString());
		dto.setRoom_photo5(map.get("room5").toString());

        StayDAO dao = StayDAO.getInstance();
        ActionForward forward = new ActionForward();
        PrintWriter out = response.getWriter();
        
        // 방 이름 중복 방지
        int roomCheck = dao.noDuplicateRoomName(room_name, stay_stayNo);
        
        if(roomCheck > 0) {
            out.println("<script>alert('중복된 Room 이름이 있습니다. Room 등록을 실패하였습니다.'); history.back(); </script>");
        }else {
            // res[0] = result, res[1] = count
            int[] res = dao.registerStayRoom(dto);
            if(res[0] > 0) {
               out.println("<script>alert('성공적으로 Room이 등록되었습니다.'); opener.parent.location.href='stayView.do?stay_no="+stay_stayNo+"'; window.close();</script>");
            }else {
               out.println("<script>alert('Room 등록 중 에러가 발생했습니다.'); history.back();</script>");
            }
        }        
        return forward;
    }
}
