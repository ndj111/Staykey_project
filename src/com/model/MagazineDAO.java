package com.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MagazineDAO {
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = null;

	private static MagazineDAO instance;

	private MagazineDAO() {
	}

	public static MagazineDAO getInstance() {
		if (instance == null) {
			instance = new MagazineDAO();
		}

		return instance;
	}

	// ======================================================
	// DB 연동하는 작업을 진행하는 메서드
	// ======================================================
	public void openConn() {
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/myoracle");
			con = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// ======================================================
	// DB에 연결된 자원 종료하는 메서드
	// ======================================================
	public void closeConn(ResultSet rs, PreparedStatement pstmt, Connection con) {
		try {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void closeConn(PreparedStatement pstmt, Connection con) {
		try {
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// ======================================================
	// DB 전체 데이터 갯수 메서드 + 검색 기능
	// ======================================================
	public int getTotalCount(Map<String, Object> map) {
		int result = 0;

		// 검색용 설정
		String search_sql = " where bbs_no > 0";
		if (map.get("ps_title") != null) {
			search_sql += " and bbs_title like '%" + map.get("ps_title") + "%'";
		}

		try {
			openConn();

			sql = "select count(*) from staykey_magazine" + search_sql;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next())
				result = rs.getInt(1);

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			closeConn(rs, pstmt, con);
		}

		return result;
	}
	
	// ======================================================
	// DB 전체 데이터 갯수 메서드
	// ======================================================
	public int getTotalCount() {
		int result = 0;

		// 검색용 설정
		try {
			openConn();

			sql = "select count(*) from staykey_magazine";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next())
				result = rs.getInt(1);

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			closeConn(rs, pstmt, con);
		}

		return result;
	}

	// ======================================================
	// 매거진 목록 메서드
	// ======================================================
	public List<MagazineDTO> magazineList(int page, int rowsize, Map<String, Object> map) {
		List<MagazineDTO> list = new ArrayList<MagazineDTO>();

		int startNo = (page * rowsize) - (rowsize - 1);
		int endNo = (page * rowsize);

		// 검색용 설정
		String search_sql1 = " where bbs_no > 0";
		String search_sql2 = "";

		if (map.get("mg_title") != "" && map.get("mg_title") != null) {
			search_sql2 += " and bbs_title like '%" + map.get("mg_title") + "%'";
		}
		if (map.get("mg_writer_name") != "" && map.get("mg_writer_name") != null) {
			search_sql2 += " and bbs_writer_name like '%" + map.get("mg_writer_name") + "%'";
		}

		search_sql1 += search_sql2;

		// 정렬용 설정 (기본 설정 날짜 순)
		String order_sql = "bbs_date";

		if (map.get("ps_order").equals("bbs_date_desc")) {
			order_sql = "bbs_date desc";
		} else if (map.get("ps_order").equals("bbs_date_asc")) {
			order_sql = "bbs_date asc";
		} else if (map.get("ps_order").equals("bbs_title_desc")) {
			order_sql = "bbs_title desc";
		} else if (map.get("ps_order").equals("bbs_title_asc")) {
			order_sql = "bbs_title asc";
		} else if (map.get("ps_order").equals("bbs_hit_desc")) {
			order_sql = "bbs_hit desc";
		} else if (map.get("ps_order").equals("bbs_hit_asc")) {
			order_sql = "bbs_hit asc";
		}

		try {
			openConn();

			sql = "select * from (select row_number() over(order by " + order_sql
					+ ") rnum, b.* from staykey_magazine b" + search_sql1 + ") where rnum >= ? and rnum <= ?"
					+ search_sql2;

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startNo);
			pstmt.setInt(2, endNo);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				MagazineDTO dto = new MagazineDTO();

				dto.setBbs_no(rs.getInt("bbs_no"));
				dto.setBbs_title(rs.getString("bbs_title"));
				dto.setBbs_list_img(rs.getString("bbs_list_img"));
				dto.setBbs_top_img(rs.getString("bbs_top_img"));
				dto.setBbs_youtube(rs.getString("bbs_youtube"));
				dto.setBbs_detail_img1(rs.getString("bbs_detail_img1"));
				dto.setBbs_content1(rs.getString("bbs_content1"));
				dto.setBbs_detail_img2(rs.getString("bbs_detail_img2"));
				dto.setBbs_content2(rs.getString("bbs_content2"));
				dto.setBbs_map(rs.getString("bbs_map"));
				dto.setBbs_content3(rs.getString("bbs_content3"));
				dto.setBbs_stayno(rs.getString("bbs_stayno"));
				dto.setBbs_hit(rs.getInt("bbs_hit"));
				dto.setBbs_writer_name(rs.getString("bbs_writer_name"));
				dto.setBbs_writer_id(rs.getString("bbs_writer_id"));
				dto.setBbs_writer_pw(rs.getString("bbs_writer_pw"));
				dto.setBbs_date(rs.getString("bbs_date"));

				list.add(dto);
			}

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			closeConn(rs, pstmt, con);
		}

		return list;
	}

	// ======================================================
	// 매거진 등록 메서드
	// ======================================================
	public int registerMagazine(MagazineDTO dto) {
		int result = 0, count = 0;

		try {
			openConn();

			sql = "select max(bbs_no) from staykey_magazine";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next())
				count = rs.getInt(1) + 1;

			sql = "insert into staykey_magazine values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, sysdate)";
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, count);
			pstmt.setString(2, dto.getBbs_title());
			pstmt.setString(3, dto.getBbs_list_img());
			pstmt.setString(4, dto.getBbs_top_img());
			pstmt.setString(5, dto.getBbs_youtube());
			pstmt.setString(6, dto.getBbs_detail_img1());
			pstmt.setString(7, dto.getBbs_content1());
			pstmt.setString(8, dto.getBbs_detail_img2());
			pstmt.setString(9, dto.getBbs_content2());
			pstmt.setString(10, dto.getBbs_map());
			pstmt.setString(11, dto.getBbs_content3());
			pstmt.setString(12, dto.getBbs_stayno());
			pstmt.setInt(13, dto.getBbs_hit());
			pstmt.setString(14, dto.getBbs_writer_name());
			pstmt.setString(15, dto.getBbs_writer_id());
			pstmt.setString(16, dto.getBbs_writer_pw());

			result = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			closeConn(rs, pstmt, con);
		}

		return result;
	}

	/////////////////////////////////////////////////////////////
	// 매거진 상세 목록 조회
	/////////////////////////////////////////////////////////////
	public MagazineDTO getMagView(int no) {
		MagazineDTO dto = null;

		try {
			openConn();

			sql = "select * from staykey_magazine where bbs_no = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				dto = new MagazineDTO();

				dto.setBbs_no(rs.getInt("bbs_no"));
				dto.setBbs_title(rs.getString("bbs_title"));
				dto.setBbs_list_img(rs.getString("bbs_list_img"));
				dto.setBbs_top_img(rs.getString("bbs_top_img"));
				dto.setBbs_youtube(rs.getString("bbs_youtube"));
				dto.setBbs_detail_img1(rs.getString("bbs_detail_img1"));
				dto.setBbs_content1(rs.getString("bbs_content1"));
				dto.setBbs_detail_img2(rs.getString("bbs_detail_img2"));
				dto.setBbs_content2(rs.getString("bbs_content2"));
				dto.setBbs_map(rs.getString("bbs_map"));
				dto.setBbs_content3(rs.getString("bbs_content3"));
				dto.setBbs_stayno(rs.getString("bbs_stayno"));
				dto.setBbs_hit(rs.getInt("bbs_hit"));
				dto.setBbs_writer_name(rs.getString("bbs_writer_name"));
				dto.setBbs_writer_id(rs.getString("bbs_writer_id"));
				dto.setBbs_writer_pw(rs.getString("bbs_writer_pw"));
				dto.setBbs_date(rs.getString("bbs_date"));

			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}

		return dto;

	}



    // ======================================================
    // 매거진 조회수 늘리기
    // ======================================================
	public void plusMagHit(int bbs_no) {
	    try {
	        openConn();

	        sql = "update staykey_magazine set bbs_hit = bbs_hit + 1 where bbs_no = ?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setInt(1, bbs_no);
	        pstmt.executeUpdate();

        } catch(Exception e) {
            e.printStackTrace();

        } finally {
            closeConn(pstmt, con);
        }
	}




	/////////////////////////////////////////////////////////////
	// 매거진 삭제 메서드 + No 재작업
	/////////////////////////////////////////////////////////////
	public int deleteMag(int no) {
		int result = 0;

		try {
			openConn();

			sql = "delete from staykey_magazine where bbs_no = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			result = pstmt.executeUpdate();

			sql = "update staykey_magazine set bbs_no = bbs_no - 1 where bbs_no > ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			closeConn(rs, pstmt, con);
		}

		return result;
	}

	/////////////////////////////////////////////////////////////
	// 매거진 수정 메서드
	/////////////////////////////////////////////////////////////
		
		public int modifyMagazine(MagazineDTO dto) {

		int result = 0;
		
		openConn();

		try {
			sql = "update staykey_magazine set bbs_title = ?, bbs_list_img = ?, bbs_top_img = ?, bbs_youtube = ?, bbs_detail_img1 = ?,"
					+ "bbs_content1 = ?, bbs_detail_img2 = ?, bbs_content2 = ?, bbs_map = ?, bbs_content3 = ?, bbs_stayno = ?, "
					+ "bbs_writer_name = ?, bbs_writer_id = ?, bbs_writer_pw = ? where bbs_no = ?";

			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, dto.getBbs_title());
			pstmt.setString(2, dto.getBbs_list_img());
			pstmt.setString(3, dto.getBbs_top_img());
			pstmt.setString(4, dto.getBbs_youtube());
			pstmt.setString(5, dto.getBbs_detail_img1());
			pstmt.setString(6, dto.getBbs_content1());
			pstmt.setString(7, dto.getBbs_detail_img2());
			pstmt.setString(8, dto.getBbs_content2());
			pstmt.setString(9, dto.getBbs_map());
			pstmt.setString(10, dto.getBbs_content3());
			pstmt.setString(11, dto.getBbs_stayno());
			pstmt.setString(12, dto.getBbs_writer_name());
			pstmt.setString(13, dto.getBbs_writer_id());
			pstmt.setString(14, dto.getBbs_writer_pw());
			pstmt.setInt(15, dto.getBbs_no());
			
			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		
		finally {
			closeConn(null, pstmt, con);
		}
		
		return result;

	} // modifyMagazine() 종료
		
	// ======================================================
	// 모든 매거진 정보 가져오기 + 페이징 처리(오버로딩)
	// ======================================================
	public List<MagazineDTO> getTotalMagazine(int page, int rowsize) {
		List<MagazineDTO> list = new ArrayList<MagazineDTO>();
		
		int startNo = (page * rowsize) - (rowsize - 1);
		int endNo = (page * rowsize);

		try {
			openConn();

			sql = "select * from (select row_number() over(order by bbs_date desc) rnum, b.* from staykey_magazine b) where rnum >= ? and rnum <= ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startNo);
			pstmt.setInt(2, endNo);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MagazineDTO dto = new MagazineDTO();

				dto.setBbs_no(rs.getInt("bbs_no"));
				dto.setBbs_title(rs.getString("bbs_title"));
				dto.setBbs_list_img(rs.getString("bbs_list_img"));
				dto.setBbs_top_img(rs.getString("bbs_top_img"));
				dto.setBbs_youtube(rs.getString("bbs_youtube"));
				dto.setBbs_detail_img1(rs.getString("bbs_detail_img1"));
				dto.setBbs_content1(rs.getString("bbs_content1"));
				dto.setBbs_detail_img2(rs.getString("bbs_detail_img2"));
				dto.setBbs_content2(rs.getString("bbs_content2"));
				dto.setBbs_map(rs.getString("bbs_map"));
				dto.setBbs_content3(rs.getString("bbs_content3"));
				dto.setBbs_stayno(rs.getString("bbs_stayno"));
				dto.setBbs_hit(rs.getInt("bbs_hit"));
				dto.setBbs_writer_name(rs.getString("bbs_writer_name"));
				dto.setBbs_writer_id(rs.getString("bbs_writer_id"));
				dto.setBbs_writer_pw(rs.getString("bbs_writer_pw"));
				dto.setBbs_date(rs.getString("bbs_date"));

				list.add(dto);
			}
				
		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			closeConn(rs, pstmt, con);
		}
		return list;
	} // getTotalMagazine() 종료	
	
	// ======================================================
	// 모든 매거진 정보 가져오기
	// ======================================================
	public List<MagazineDTO> getTotalMagazine() {
		List<MagazineDTO> list = new ArrayList<MagazineDTO>();

		try {
			openConn();

			sql = "select * from staykey_magazine";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MagazineDTO dto = new MagazineDTO();

				dto.setBbs_no(rs.getInt("bbs_no"));
				dto.setBbs_title(rs.getString("bbs_title"));
				dto.setBbs_list_img(rs.getString("bbs_list_img"));
				dto.setBbs_top_img(rs.getString("bbs_top_img"));
				dto.setBbs_youtube(rs.getString("bbs_youtube"));
				dto.setBbs_detail_img1(rs.getString("bbs_detail_img1"));
				dto.setBbs_content1(rs.getString("bbs_content1"));
				dto.setBbs_detail_img2(rs.getString("bbs_detail_img2"));
				dto.setBbs_content2(rs.getString("bbs_content2"));
				dto.setBbs_map(rs.getString("bbs_map"));
				dto.setBbs_content3(rs.getString("bbs_content3"));
				dto.setBbs_stayno(rs.getString("bbs_stayno"));
				dto.setBbs_hit(rs.getInt("bbs_hit"));
				dto.setBbs_writer_name(rs.getString("bbs_writer_name"));
				dto.setBbs_writer_id(rs.getString("bbs_writer_id"));
				dto.setBbs_writer_pw(rs.getString("bbs_writer_pw"));
				dto.setBbs_date(rs.getString("bbs_date"));

				list.add(dto);
			}
				
		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			closeConn(rs, pstmt, con);
		}
		return list;
	} // getTotalMagazine() 종료	

}
