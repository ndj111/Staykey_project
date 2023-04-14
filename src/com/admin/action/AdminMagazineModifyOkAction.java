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
import com.model.MagazineDAO;
import com.model.MagazineDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class AdminMagazineModifyOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		// dto, dao 생성
		MagazineDTO dto = new MagazineDTO();
		MagazineDAO dao = MagazineDAO.getInstance();

		// 파일 업로드 설정
		String thisFolder = "/data/magazine/";
		String saveFolder = request.getSession().getServletContext().getRealPath(thisFolder);
		int fileSize = 25 * 1024 * 1024; // 10MB

		// 업로드 폴더 체크 후 없으면 생성
		File dirChk = new File(saveFolder);
		if (!dirChk.exists()) {
			dirChk.mkdir();
		}

		// 파일 업로드 객체 생성
		MultipartRequest multi = new MultipartRequest(request, saveFolder, fileSize, "UTF-8",
				new DefaultFileRenamePolicy());

		// 파라미터 정리
		int mag_no = Integer.parseInt(multi.getParameter("mag_no"));
		String mag_title = multi.getParameter("mag_title");
		String mag_youtube = multi.getParameter("mag_youtube");
		String mag_content1 = multi.getParameter("mag_content1");
		String mag_content2 = multi.getParameter("mag_content2");
		String mag_map = multi.getParameter("mag_map");
		String mag_content3 = multi.getParameter("mag_content3");
		String mag_stayno = multi.getParameter("mag_stayno");
		String mag_writer_name = multi.getParameter("mag_writer_name");
		String mag_writer_id = multi.getParameter("mag_writer_id");
		String mag_writer_pw = multi.getParameter("mag_writer_pw");

		dto.setBbs_no(mag_no);
		dto.setBbs_title(mag_title);
		dto.setBbs_youtube(mag_youtube);
		dto.setBbs_content1(mag_content1);
		dto.setBbs_content2(mag_content2);
		dto.setBbs_map(mag_map);
		dto.setBbs_content3(mag_content3);
		dto.setBbs_stayno(mag_stayno);
		dto.setBbs_writer_name(mag_writer_name);
		dto.setBbs_writer_id(mag_writer_id);
		dto.setBbs_writer_pw(mag_writer_pw);

		// 순서 지정 문제 해결 위함
		// 새로 업로드된 파일
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mag_list_img", multi.getFile("mag_list_img"));
		map.put("mag_top_img", multi.getFile("mag_top_img"));
		map.put("mag_detail_img1", multi.getFile("mag_detail_img1"));
		map.put("mag_detail_img2", multi.getFile("mag_detail_img2"));

		// 기존 파일 정보 가져오기 위함
		MagazineDTO originalDTO = dao.getMagView(mag_no);

		String original_mag_list_img = originalDTO.getBbs_list_img();
		String original_mag_top_img = originalDTO.getBbs_top_img();
		String original_mag_detail_img1 = originalDTO.getBbs_detail_img1();
		String original_mag_detail_img2 = originalDTO.getBbs_detail_img2();

		// delete folder 현재 경로 받아옴
		String delFolder = request.getSession().getServletContext().getRealPath("/");

		Iterator<Map.Entry<String, Object>> iterator = map.entrySet().iterator(); // iterator로 다음 값 가져옴
		String original_file = ""; // 예전 파일 변수로 지정

		while (iterator.hasNext()) {
			Entry<String, Object> e = iterator.next();
			File file = (File) e.getValue(); // map에 저장된 파일 객체의 value 값만 얻어와서 File형으로 casting

			switch (e.getKey()) { // original file 값 할당
			case "mag_list_img":
				original_file = original_mag_list_img;
				break;
			case "mag_top_img":
				original_file = original_mag_top_img;
				break;
			case "mag_detail_img1":
				original_file = original_mag_detail_img1;
				break;
			case "mag_detail_img2":
				original_file = original_mag_detail_img2;
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

		dto.setBbs_list_img(map.get("mag_list_img").toString());
		dto.setBbs_top_img(map.get("mag_top_img").toString());
		dto.setBbs_detail_img1(map.get("mag_detail_img1").toString());
		dto.setBbs_detail_img2(map.get("mag_detail_img2").toString());

		// 수정 업로드 메서드
		int res = dao.modifyMagazine(dto);

		// 포워드 실행
		ActionForward forward = new ActionForward();
		PrintWriter out = response.getWriter();

		if (res > 0) {
			forward.setRedirect(true);
			forward.setPath("magazineList.do");
		} else {
			out.println("<script> alert('매거진 수정 중 에러가 발생했습니다.'); history.back(); </script>");
		}
		return forward;
	}

}
