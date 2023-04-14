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
import javax.servlet.http.HttpSession;

import com.controller.Action;
import com.controller.ActionForward;
import com.model.StayDAO;
import com.model.StayDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;


public class AdminStayModifyOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 수정된 정보 저장		
		
		StayDTO dto = new StayDTO();
		StayDAO dao = StayDAO.getInstance();
	
        // 파일 업로드 설정
        String thisFolder = "/data/stay/";
        String saveFolder = request.getSession().getServletContext().getRealPath(thisFolder);
        int fileSize = 25 * 1024 * 1024; // 10MB
        
        // 업로드 폴더 체크 후 없으면 생성
        File dirChk = new File(saveFolder);
        if(!dirChk.exists()){ 
            dirChk.mkdir();
        }

        // 파일 업로드 객체 생성
        MultipartRequest multi = new MultipartRequest(request, saveFolder, fileSize, "UTF-8", new DefaultFileRenamePolicy());

        String[] stay_file_delete = null;
        List<String> stayList = null;
        String stay_desc = "";
        String stay_option1_name = "";
        String stay_option1_desc = "";
        String stay_option2_name = "";
        String stay_option2_desc = "";
        String stay_option3_name = "";
        String stay_option3_desc = "";        
        String stay_content1 = "";
        String stay_content2 = "";
        String stay_content3 = "";
        String stay_info1 = "";
        String stay_info2 = "";
        String stay_info3 = "";        
        
        // 파라미터 정리
        // stay_option1~3_price if문... => NumberFormatException 처리 위함
        int stay_no = Integer.parseInt(multi.getParameter("stay_no"));
        String stay_type = multi.getParameter("stay_type");
        String stay_name = multi.getParameter("stay_name").trim();
        if(multi.getParameter("stay_desc") != null) { stay_desc = multi.getParameter("stay_desc").trim(); }
        String stay_location = multi.getParameter("stay_location").trim();
        String stay_addr = multi.getParameter("stay_addr").trim();
        String stay_phone = multi.getParameter("stay_phone").trim();
        String stay_email = multi.getParameter("stay_email").trim();
        
        // name 값 [] 로 받을 시 작동 안 됨...       
        if(multi.getParameterValues("stay_file_delete") != null) {
        	stay_file_delete = multi.getParameterValues("stay_file_delete");
        	stayList = Arrays.asList(stay_file_delete);
        }
        
        if(multi.getParameter("stay_option1_name") != null) { stay_option1_name = multi.getParameter("stay_option1_name").trim(); }
        if(multi.getParameter("stay_option1_price").length() > 0) {
        	int stay_option1_price = Integer.parseInt(multi.getParameter("stay_option1_price").trim());
        	dto.setStay_option1_price(stay_option1_price);
        }
        if(multi.getParameter("stay_option1_desc") != null) { stay_option1_desc = multi.getParameter("stay_option1_desc").trim(); }
        
        if(multi.getParameter("stay_option2_name") != null) { stay_option2_name = multi.getParameter("stay_option2_name").trim(); }
        if(multi.getParameter("stay_option2_price").length() > 0) {
        	int stay_option2_price = Integer.parseInt(multi.getParameter("stay_option2_price").trim());
        	dto.setStay_option2_price(stay_option2_price);
        }
        if(multi.getParameter("stay_option2_desc") != null) { stay_option2_desc = multi.getParameter("stay_option2_desc").trim(); }
        
        if(multi.getParameter("stay_option3_name") != null) { stay_option3_name = multi.getParameter("stay_option3_name").trim(); }
        if(multi.getParameter("stay_option3_price").length() > 0) {
        	int stay_option3_price = Integer.parseInt(multi.getParameter("stay_option3_price").trim());
        	dto.setStay_option3_price(stay_option3_price);
        }
        if(multi.getParameter("stay_option3_desc") != null) { stay_option3_desc = multi.getParameter("stay_option3_desc").trim(); }         
        
        if(multi.getParameter("stay_content1") != null) { stay_content1 = multi.getParameter("stay_content1").trim(); }
        if(multi.getParameter("stay_content2") != null) { stay_content2 = multi.getParameter("stay_content2").trim(); }
        if(multi.getParameter("stay_content3") != null) { stay_content3 = multi.getParameter("stay_content3").trim(); }
        if(multi.getParameter("stay_info1") != null) { stay_info1 = multi.getParameter("stay_info1").trim(); }
        if(multi.getParameter("stay_info2") != null) { stay_info2 = multi.getParameter("stay_info2").trim(); }
        if(multi.getParameter("stay_info3") != null) { stay_info3 = multi.getParameter("stay_info3").trim(); }
        
        dto.setStay_no(stay_no);
        dto.setStay_type(stay_type);
        dto.setStay_name(stay_name);
        dto.setStay_desc(stay_desc);
        dto.setStay_location(stay_location);
        dto.setStay_addr(stay_addr);
        dto.setStay_phone(stay_phone);
        dto.setStay_email(stay_email);
        dto.setStay_content1(stay_content1);
        dto.setStay_content2(stay_content2);
        dto.setStay_content3(stay_content3);
        dto.setStay_info1(stay_info1);
        dto.setStay_info2(stay_info2);
        dto.setStay_info3(stay_info3);
        dto.setStay_option1_name(stay_option1_name);
        dto.setStay_option1_desc(stay_option1_desc);
        dto.setStay_option2_name(stay_option2_name);
        dto.setStay_option2_desc(stay_option2_desc);
        dto.setStay_option3_name(stay_option3_name);
        dto.setStay_option3_desc(stay_option3_desc);
        
        // 순서 지정 문제 해결 위함
        // 새로 업로드된 파일
 	    Map<String, Object> map = new HashMap<String, Object>();	    
 	    map.put("stay_file1", multi.getFile("stay_file1"));
 	    map.put("stay_file2", multi.getFile("stay_file2"));
 	    map.put("stay_file3", multi.getFile("stay_file3"));
 	    map.put("stay_file4", multi.getFile("stay_file4"));
 	    map.put("stay_file5", multi.getFile("stay_file5"));
 	    map.put("stay_option1_photo", multi.getFile("stay_option1_photo"));
 	    map.put("stay_option2_photo", multi.getFile("stay_option2_photo"));
 	    map.put("stay_option3_photo", multi.getFile("stay_option3_photo"));
 	    
 	    // 기존 파일 정보 가져오기 위함
 	    StayDTO viewDTO = dao.getStayView(stay_no);
 	    String original_stay_file1 = viewDTO.getStay_file1();
 	    String original_stay_file2 = viewDTO.getStay_file2();
 	    String original_stay_file3 = viewDTO.getStay_file3();
 	    String original_stay_file4 = viewDTO.getStay_file4();
 	    String original_stay_file5 = viewDTO.getStay_file5();
 	    String original_stay_option1_photo = viewDTO.getStay_option1_photo();
 	    String original_stay_option2_photo = viewDTO.getStay_option2_photo();
 	    String original_stay_option3_photo = viewDTO.getStay_option3_photo();
 	    
 	    // delete folder 현재 경로 받아옴
 	    String delFolder = request.getSession().getServletContext().getRealPath("/");

 	    Iterator<Map.Entry<String, Object>> iterator = map.entrySet().iterator(); // iterator로 다음 값 가져옴
 	    String original_file = ""; // 예전 파일 변수로 지정
 	    File stayFile = null; // stayFile 변수 선언 / delete 용
 		
 		while(iterator.hasNext()) { 
 			Entry<String, Object> e = iterator.next();
 			File file = (File) e.getValue(); // map에 저장된 파일 객체의 value 값만 얻어와서 File형으로 casting 		
 			
 			switch (e.getKey()) { 
 			    // original file 값 할당 & stayFile(delete용 파일 객체 생성)(stayList에 해당 사항 있을 시)
	 			case "stay_file1": 
	 				original_file = original_stay_file1; 
	 				if(stayList != null) { if(stayList.contains("Y1")) { stayFile = new File(delFolder + original_file); }else { stayList = null; }}
	 				break;
	 			case "stay_file2": 
	 				original_file = original_stay_file2; 
	 				if(stayList != null) { if(stayList.contains("Y2")) { stayFile = new File(delFolder + original_file); }else { stayList = null; }}
	 				break;
	 			case "stay_file3": 
	 				original_file = original_stay_file3; 
	 				if(stayList != null) { if(stayList.contains("Y3")) { stayFile = new File(delFolder + original_file); }else { stayList = null; }}
	 				break;
	 			case "stay_file4": 
	 				original_file = original_stay_file4; 
	 				if(stayList != null) { if(stayList.contains("Y4")) { stayFile = new File(delFolder + original_file); }else { stayList = null; }}
	 				break;
	 			case "stay_file5": 
	 				original_file = original_stay_file5; 
	 				if(stayList != null) { if(stayList.contains("Y5")) { stayFile = new File(delFolder + original_file); }else { stayList = null; }}
	 				break;
	 			case "stay_option1_photo": 
	 				original_file = original_stay_option1_photo; 
	 				if(stayList != null) { if(stayList.contains("Y6")) { stayFile = new File(delFolder + original_file); }else { stayList = null; }}
	 				break;
	 			case "stay_option2_photo": 
	 				original_file = original_stay_option2_photo; 
	 				if(stayList != null) { if(stayList.contains("Y7")) { stayFile = new File(delFolder + original_file); }else { stayList = null; }}
	 				break;
	 			case "stay_option3_photo": 
	 				original_file = original_stay_option3_photo; 
	 				if(stayList != null) { if(stayList.contains("Y8")) { stayFile = new File(delFolder + original_file); }else { stayList = null; }}
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
 				if(original_file != null) {// 기존 값이 있으면 			
 					map.replace(e.getKey(), original_file); // 예전 값 할당
 					// 파일 삭제 체크표시
 					if(stayFile != null) { // 단독 exists() 사용 시 nullpointer 에러 발생...
						if(stayFile.exists()) { 
							stayFile.delete(); 
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
 		
 		dto.setStay_file1(map.get("stay_file1").toString());
 		dto.setStay_file2(map.get("stay_file2").toString());
 		dto.setStay_file3(map.get("stay_file3").toString());
 		dto.setStay_file4(map.get("stay_file4").toString());
 		dto.setStay_file5(map.get("stay_file5").toString());
 		dto.setStay_option1_photo(map.get("stay_option1_photo").toString());
 		dto.setStay_option2_photo(map.get("stay_option2_photo").toString());
 		dto.setStay_option3_photo(map.get("stay_option3_photo").toString());

        int res = dao.modifyStay(dto);        

        ActionForward forward = new ActionForward();        
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();

        if (res > 0) {
        	session.setAttribute("msg", "<script> alert('성공적으로 수정되었습니다.'); </script>");
            forward.setRedirect(true);
            forward.setPath("stayView.do?stay_no="+stay_no);
        }else {
            out.println("<script> alert('숙소 수정 중 에러가 발생했습니다.'); history.back(); </script>");
        }
        return forward;
	}
}
