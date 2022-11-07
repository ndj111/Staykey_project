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
import com.model.EventDAO;
import com.model.EventDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class AdminEventModifyOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
				
		// dto, dao 생성
		EventDTO dto = new EventDTO();
		EventDAO dao = EventDAO.getInstance();

        // 파일 업로드 설정
        String thisFolder = "/data/event/";
        String saveFolder = request.getSession().getServletContext().getRealPath(thisFolder);
        int fileSize = 25 * 1024 * 1024; // 10MB
        
        // 업로드 폴더 체크 후 없으면 생성
        File dirChk = new File(saveFolder);
        if(!dirChk.exists()){
            dirChk.mkdir();
        }

        // 파일 업로드 객체 생성
        MultipartRequest multi = new MultipartRequest(request, saveFolder, fileSize, "UTF-8", new DefaultFileRenamePolicy());

		// 파라미터 정리
		int ev_no = Integer.parseInt(multi.getParameter("ev_no"));
		String ev_title = multi.getParameter("ev_title");
		String ev_content = multi.getParameter("ev_content");
		String ev_stayno = multi.getParameter("ev_stayno");
		String ev_showstart = multi.getParameter("ev_start");
		String ev_showend = multi.getParameter("ev_end");
		String ev_writer_name = multi.getParameter("ev_writer_name");
		String ev_writer_id = multi.getParameter("ev_writer_id");
		String ev_writer_pw = multi.getParameter("ev_writer_pw");
		
		dto.setBbs_no(ev_no);
		dto.setBbs_title(ev_title);
		dto.setBbs_content(ev_content);
		dto.setBbs_stayno(ev_stayno);
		dto.setBbs_showstart(ev_showstart);
		dto.setBbs_showend(ev_showend);
		dto.setBbs_writer_name(ev_writer_name);
		dto.setBbs_writer_id(ev_writer_id);
		dto.setBbs_writer_pw(ev_writer_pw);
		
        
        // 순서 지정 문제 해결 위함
        // 새로 업로드된 파일 (파일 파라미터)
 	    Map<String, Object> map = new HashMap<String, Object>();	 
 	    
 	    map.put("ev_file1", multi.getFile("ev_file1"));
 	    map.put("ev_file2", multi.getFile("ev_file2"));
 	    map.put("ev_file3", multi.getFile("ev_file3"));
 	    map.put("ev_file4", multi.getFile("ev_file4"));
 	    map.put("ev_file5", multi.getFile("ev_file5"));
 	    
 	    // 기존 파일 정보 가져오기 위함
 	    EventDTO originalDTO = dao.getEventInfo(ev_no);
 	    
 	    String original_ev_file1 = originalDTO.getBbs_file1();
 	    String original_ev_file2 = originalDTO.getBbs_file2();
 	    String original_ev_file3 = originalDTO.getBbs_file3();
 	    String original_ev_file4 = originalDTO.getBbs_file4();
 	    String original_ev_file5 = originalDTO.getBbs_file5();
 	    
 	    // delete folder 현재 경로 받아옴
 	    String delFolder = request.getSession().getServletContext().getRealPath("/");

 	    Iterator<Map.Entry<String, Object>> iterator = map.entrySet().iterator(); // iterator로 다음 값 가져옴
 	    String original_file = ""; // 예전 파일 변수로 지정
 		
 	    while (iterator.hasNext()) {
			Entry<String, Object> e = iterator.next();
			File file = (File) e.getValue(); // map에 저장된 파일 객체의 value 값만 얻어와서 File형으로 casting

			switch (e.getKey()) { // original file 값 할당
			case "ev_file1":
				original_file = original_ev_file1;
				break;
			case "ev_file2":
				original_file = original_ev_file2;
				break;
			case "ev_file3":
				original_file = original_ev_file3;
				break;
			case "ev_file4":
				original_file = original_ev_file4;
				break;
			case "ev_file5":
				original_file = original_ev_file5;
				break;
			}

			if (file != null) { // value 값이 null이 아니면(new file 있음)
				File del_image = new File(delFolder + original_file);
				if (del_image.exists()) {
					del_image.delete();
				}
				String fileExt = file.toString().substring(file.toString().lastIndexOf(".") + 1); // 확장자 분리
				String fileRename = e.getKey() + "_modify_" + System.currentTimeMillis() + "." + fileExt; // 파일 rename
				file.renameTo(new File(saveFolder + fileRename)); // file을 인자로 전달된 파일의 경로로 변경
				map.replace(e.getKey(), thisFolder + fileRename); // 현재 key 값에 새로운 value 값을 map에 저장
			} else { // new file 없으면
				if (original_file != null) {// 예전 파일이 null이 아니면
					map.replace(e.getKey(), original_file); // 예전 값 할당
				} else {
					map.replace(e.getKey(), ""); // null 값 처리 위함
				}
			}
		}
 		
 		
 		dto.setBbs_file1(map.get("ev_file1").toString());
 		dto.setBbs_file2(map.get("ev_file2").toString());
 		dto.setBbs_file3(map.get("ev_file3").toString());
 		dto.setBbs_file4(map.get("ev_file4").toString());
 		dto.setBbs_file5(map.get("ev_file5").toString());
 		
 		// 수정 업로드 메서드
        int res = dao.modifyEvent(dto);        

        
        
        // 포워드 실행
        ActionForward forward = new ActionForward();        
        PrintWriter out = response.getWriter();

        if (res > 0) {
            forward.setRedirect(true);
            forward.setPath("eventList.do");
        } else {
            out.println("<script> alert('이벤트 수정 중 에러가 발생했습니다.'); history.back(); </script>");
		        }
		        return forward;
			}
			
	}
	


