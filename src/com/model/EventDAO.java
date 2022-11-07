package com.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.util.eventDate;

public class EventDAO {
	Connection con = null;
	PreparedStatement pstmt = null;
	PreparedStatement pstmt2 = null;
	ResultSet rs = null;
	ResultSet rs2 = null;
	String sql = null;
	String sql2 = null;

	private static EventDAO instance;

	private EventDAO() {
	}

	public static EventDAO getInstance() {
		if (instance == null) {
			instance = new EventDAO();
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
	// DB 전체 데이터 갯수 메서드
	// ======================================================
	public int getTotalCount(Map<String, Object> map) {
		int result = 0;

		// 검색용 설정
		String search_sql = " where bbs_no > 0";
		
		if (map.get("ps_name") != null) {
			search_sql += " and bbs_writer_name like '%" + map.get("ps_name") + "%'";
		}
		if (map.get("ps_id") != null) {
			search_sql += " and bbs_writer_id like '%" + map.get("ps_id") + "%'";
		}
		if (map.get("ps_title") != null) {
			search_sql += " and bbs_title like '%" + map.get("ps_title") + "%'";
		}
		
        if(!map.get("ps_duse").equals("1")) {
            String sql_start_date = (String)map.get("ps_start");
                   sql_start_date = sql_start_date.replace("-", "");
            String sql_end_date = (String)map.get("ps_end");
                   sql_end_date = sql_end_date.replace("-", "");
            search_sql += " and ( (to_char(bbs_showstart, 'YYYYMMDD') >= " + sql_start_date + " and to_char(bbs_showstart, 'YYYYMMDD') <= " + sql_end_date + ")";
            search_sql += " or (to_char(bbs_showend, 'YYYYMMDD') >= " + sql_start_date + " and to_char(bbs_showend, 'YYYYMMDD') <= " + sql_end_date + ") )";
        }


		try {
			openConn();

			sql = "select count(*) from staykey_event" + search_sql;
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
	// 이벤트 목록 메서드
	// ======================================================

	public List<EventDTO> eventList(int page, int rowsize, Map<String, Object> map) {
		List<EventDTO> list = new ArrayList<EventDTO>();

		int startNo = (page * rowsize) - (rowsize - 1);
		int endNo = (page * rowsize);

		// 검색용 설정
		String search_sql1 = " where bbs_no > 0";
		String search_sql2 = "";

		if (map.get("ps_name") != "" && map.get("ps_name") != null) {
			search_sql2 += " and bbs_writer_name like '%" + map.get("ps_name") + "%'";
		}
		if (map.get("ps_id") != "" && map.get("ps_id") != null) {
			search_sql2 += " and bbs_writer_id like '%" + map.get("ps_id") + "%'";
		}
		if (map.get("ps_title") != "" && map.get("ps_title") != null) {
			search_sql2 += " and bbs_title like '%" + map.get("ps_title") + "%'";
		}
		
        if(!map.get("ps_duse").equals("1")) {
            String sql_start_date = (String)map.get("ps_start");
                   sql_start_date = sql_start_date.replace("-", "");
            String sql_end_date = (String)map.get("ps_end");
                   sql_end_date = sql_end_date.replace("-", "");
            search_sql2 += " and ( (to_char(bbs_showstart, 'YYYYMMDD') >= " + sql_start_date + " and to_char(bbs_showstart, 'YYYYMMDD') <= " + sql_end_date + ")";
            search_sql2 += " or (to_char(bbs_showend, 'YYYYMMDD') >= " + sql_start_date + " and to_char(bbs_showend, 'YYYYMMDD') <= " + sql_end_date + ") )";
        }


		search_sql1 += search_sql2;

		// 정렬용 설정
		String order_sql = "bbs_date";
		if (map.get("ps_order").equals("register_desc")) {
			order_sql = "bbs_date desc";
		} else if (map.get("ps_order").equals("register_asc")) {
			order_sql = "bbs_date asc";
		} else if (map.get("ps_order").equals("title_desc")) {
			order_sql = "bbs_title desc";
		} else if (map.get("ps_order").equals("title_asc")) {
			order_sql = "bbs_title asc";
		} else if (map.get("ps_order").equals("hit_desc")) {
			order_sql = "bbs_hit desc";
		} else if (map.get("ps_order").equals("hit_asc")) {
			order_sql = "bbs_hit asc";
		} else if (map.get("ps_order").equals("show_desc")) {
			order_sql = "bbs_showstart desc";
		} else if (map.get("ps_order").equals("show_asc")) {
			order_sql = "bbs_showstart asc";
		}

		try {
			openConn();

			sql = "select * from " + "(select row_number() over(order by " + order_sql
					+ ") rnum, b.* from staykey_event b " + search_sql1 + ") " + "where rnum >= ? and rnum <= ?"
					+ search_sql2;
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startNo);
			pstmt.setInt(2, endNo);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				EventDTO dto = new EventDTO();

				dto.setBbs_no(rs.getInt("bbs_no"));
				dto.setBbs_title(rs.getString("bbs_title"));
				dto.setBbs_content(rs.getString("bbs_content"));
				dto.setBbs_file1(rs.getString("bbs_file1"));
				dto.setBbs_file2(rs.getString("bbs_file2"));
				dto.setBbs_file3(rs.getString("bbs_file3"));
				dto.setBbs_file4(rs.getString("bbs_file4"));
				dto.setBbs_file5(rs.getString("bbs_file5"));
				dto.setBbs_stayno(rs.getString("bbs_stayno"));
				dto.setBbs_showstart(rs.getString("bbs_showstart"));
				dto.setBbs_showend(rs.getString("bbs_showend"));
				dto.setBbs_hit(rs.getInt("bbs_hit"));
				dto.setBbs_writer_name(rs.getString("bbs_writer_name"));
				dto.setBbs_writer_id(rs.getString("bbs_writer_id"));
				dto.setBbs_writer_pw(rs.getString("bbs_writer_pw"));
				dto.setBbs_date(rs.getString("bbs_date"));

				list.add(dto);
			}

		} catch (SQLException e) {
			e.printStackTrace();

		} finally {
			closeConn(rs, pstmt, con);
		}

		return list;
	}

	// ======================================================
	// 이벤트 등록 메서드
	// ======================================================
	public int registerEvent(EventDTO dto) {

		int result = 0, count = 0;

		try {

			openConn();

			sql = "select max(bbs_no) from staykey_event";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next())
				count = rs.getInt(1) + 1;

			sql = "insert into staykey_event values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, sysdate)";
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, count);
			pstmt.setString(2, dto.getBbs_title());
			pstmt.setString(3, dto.getBbs_content());
			pstmt.setString(4, dto.getBbs_file1());
			pstmt.setString(5, dto.getBbs_file2());
			pstmt.setString(6, dto.getBbs_file3());
			pstmt.setString(7, dto.getBbs_file4());
			pstmt.setString(8, dto.getBbs_file5());
			pstmt.setString(9, dto.getBbs_stayno());
			pstmt.setString(10, dto.getBbs_showstart());
			pstmt.setString(11, dto.getBbs_showend());
			pstmt.setInt(12, dto.getBbs_hit());
			pstmt.setString(13, dto.getBbs_writer_name());
			pstmt.setString(14, dto.getBbs_writer_id());
			pstmt.setString(15, dto.getBbs_writer_pw());

			result = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			closeConn(rs, pstmt, con);
		}

		return result;
	}

	/////////////////////////////////////////////////////////////
	// 이벤트 삭제 메서드 + No 재작업
	/////////////////////////////////////////////////////////////

	public int deleteEvent(int no) {

		int result = 0;

		try {
			openConn();

			sql = "delete from staykey_event where bbs_no = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			result = pstmt.executeUpdate();

			sql = "update staykey_event set bbs_no = bbs_no - 1 where bbs_no > ?";
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

	// ======================================================
	// 이벤트정보 가져오기 메서드
	// ======================================================
	public EventDTO getEventInfo(int no) {
		EventDTO dto = null;

		try {
			openConn();

			sql = "select * from staykey_event where bbs_no = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new EventDTO();

				dto.setBbs_no(rs.getInt("bbs_no"));
				dto.setBbs_title(rs.getString("bbs_title"));
				dto.setBbs_content(rs.getString("bbs_content"));
				dto.setBbs_file1(rs.getString("bbs_file1"));
				dto.setBbs_file2(rs.getString("bbs_file2"));
				dto.setBbs_file3(rs.getString("bbs_file3"));
				dto.setBbs_file4(rs.getString("bbs_file4"));
				dto.setBbs_file5(rs.getString("bbs_file5"));
				dto.setBbs_stayno(rs.getString("bbs_stayno"));
				dto.setBbs_showstart(rs.getString("bbs_showstart"));
				dto.setBbs_showend(rs.getString("bbs_showend"));
				dto.setBbs_hit(rs.getInt("bbs_hit"));
				dto.setBbs_writer_name(rs.getString("bbs_writer_name"));
				dto.setBbs_writer_id(rs.getString("bbs_writer_id"));
				dto.setBbs_writer_pw(rs.getString("bbs_writer_pw"));
				dto.setBbs_date(rs.getString("bbs_date"));


                // 등록된 숙소 목록
                if(rs.getString("bbs_stayno") != null){
                    String get_stayno = rs.getString("bbs_stayno").substring(1, rs.getString("bbs_stayno").length() - 1);
                    String[] epd_stayno = get_stayno.split("/");

                    // 쪼갠 숙소 번호로 반복
                    String done_stayname = null;
                    for(int i=0; i<epd_stayno.length; i++){
                        sql2 = "select * from staykey_stay where stay_no = ?";
                        pstmt2 = con.prepareStatement(sql2);
                        pstmt2.setInt(1, Integer.parseInt(epd_stayno[i]));
                        rs2 = pstmt2.executeQuery();

                        if(i < 5 && rs2.next()) {
                            done_stayname += ", " + rs2.getString("stay_name");
                        }
                    }
                    dto.setBbs_stayname(done_stayname.replace("null, ", ""));
                }
			}

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			closeConn(rs, pstmt, con);
		}

		return dto;
	}

	/////////////////////////////////////////////////////////////
	// 이벤트 수정 메서드
	/////////////////////////////////////////////////////////////

	public int modifyEvent(EventDTO dto) {

		int result = 0;

		openConn();
		
		try {
			sql = "update staykey_event set bbs_title = ?, bbs_content = ?, bbs_file1 = ?, bbs_file2 = ?, bbs_file3 = ?, "
					+ "bbs_file4 = ?, bbs_file5 = ?, bbs_stayno = ?, bbs_showstart = ?, bbs_showend = ?, bbs_writer_name = ?, "
					+ "bbs_writer_id = ?, bbs_writer_pw = ? where bbs_no = ? ";

			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, dto.getBbs_title());
			pstmt.setString(2, dto.getBbs_content());
			pstmt.setString(3, dto.getBbs_file1());
			pstmt.setString(4, dto.getBbs_file2());
			pstmt.setString(5, dto.getBbs_file3());
			pstmt.setString(6, dto.getBbs_file4());
			pstmt.setString(7, dto.getBbs_file5());
			pstmt.setString(8, dto.getBbs_stayno());
			pstmt.setString(9, dto.getBbs_showstart());
			pstmt.setString(10, dto.getBbs_showend());
			pstmt.setString(11, dto.getBbs_writer_name());
			pstmt.setString(12, dto.getBbs_writer_id());
			pstmt.setString(13, dto.getBbs_writer_pw());
			pstmt.setInt(14, dto.getBbs_no());

			result = pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}

		finally {
			closeConn(null, pstmt, con);
		}

		return result;

	} // modifyMagazine() 종료
	
	
	// ======================================================
	// 이벤트 bbs_stayno에 따른 숙소 No 추출 메서드
	// ======================================================
	public List<Integer> getStayNum(String bbs_stayno) {
		
		// 변수 선언
		List<Integer> splitsInts = new ArrayList<Integer>();

		String[] splitNums = bbs_stayno.substring(1).split("/");
		for(int i=0; i<splitNums.length; i++) {	
			splitsInts.add(Integer.parseInt(splitNums[i]));			
		}
		return splitsInts;
	} // getStayNum() 종료
	

	// ======================================================
	// 이벤트 번호에 해당하는 숙소번호 가져오기
	// ======================================================
	public String getEventStayNums(int bbs_no) {
		String eventNums = "";
		
		try {
			openConn();
			sql = "select bbs_stayno from staykey_event where bbs_no = ?";			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bbs_no);
			rs = pstmt.executeQuery();			
			if(rs.next()) {
				eventNums = rs.getString("bbs_stayno");
			}
		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			closeConn(rs, pstmt, con);
		}
		return eventNums;
	} // getEventStayNums() 종료






    // ======================================================
    // 이벤트 목록(사이트 게시판 화면) 메서드 @노동진
    // ======================================================
    public List<EventDTO> getBbsEventList() {
        List<EventDTO> list = new ArrayList<EventDTO>();

        try {
            openConn();

            sql = "select * from staykey_event order by bbs_date desc";
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while(rs.next()) {
                EventDTO dto = new EventDTO();

                dto.setBbs_no(rs.getInt("bbs_no"));
                dto.setBbs_title(rs.getString("bbs_title"));
                dto.setBbs_content(rs.getString("bbs_content"));
                dto.setBbs_file1(rs.getString("bbs_file1"));
                dto.setBbs_file2(rs.getString("bbs_file2"));
                dto.setBbs_file3(rs.getString("bbs_file3"));
                dto.setBbs_file4(rs.getString("bbs_file4"));
                dto.setBbs_file5(rs.getString("bbs_file5"));
                dto.setBbs_hit(rs.getInt("bbs_hit"));
                dto.setBbs_writer_name(rs.getString("bbs_writer_name"));
                dto.setBbs_writer_id(rs.getString("bbs_writer_id"));
                dto.setBbs_writer_pw(rs.getString("bbs_writer_pw"));
                dto.setBbs_date(rs.getString("bbs_date"));

                // 등록된 숙소 목록
                if(rs.getString("bbs_stayno") != null){
                    String get_stayno = rs.getString("bbs_stayno").substring(1, rs.getString("bbs_stayno").length() - 1);
                    String[] epd_stayno = get_stayno.split("/");

                    // 쪼갠 숙소 번호로 반복
                    String done_stayname = null;
                    for(int i=0; i<epd_stayno.length; i++){
                        sql2 = "select * from staykey_stay where stay_no = ?";
                        pstmt2 = con.prepareStatement(sql2);
                        pstmt2.setInt(1, Integer.parseInt(epd_stayno[i]));
                        rs2 = pstmt2.executeQuery();

                        if(i < 5 && rs2.next()) {
                            done_stayname += ", " + rs2.getString("stay_name");
                        }
                    }
                    dto.setBbs_stayname(done_stayname.replace("null, ", ""));
                }


                // 오늘(현재) 기준으로 이벤트 남은 날짜
                // eventDate.remainDate(시작일자, 종료일자)
                String remain_date = eventDate.remainDate(rs.getString("bbs_showstart"), rs.getString("bbs_showend"));

                dto.setBbs_showstart(remain_date);
                dto.setBbs_showend(null);

                list.add(dto);
            }

        } catch(Exception e) {
            e.printStackTrace();

        } finally {
            closeConn(rs, pstmt, con);
        }

        return list;
    }






    // ======================================================
    // 이벤트 숙소 목록(사이트 게시판 화면) 메서드 @노동진
    // ======================================================
    public List<HashMap<String, String>> getEventStayList() {
        List<HashMap<String, String>> list = new ArrayList<HashMap<String,String>>();

        try {
            openConn();

            sql = "select * from staykey_event order by bbs_date desc";
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while(rs.next()) {
                String get_stayno = rs.getString("bbs_stayno").substring(1, rs.getString("bbs_stayno").length() - 1);
                String[] epd_stayno = get_stayno.split("/");

                // 쪼갠 숙소 번호로 반복
                for(int i=0; i<epd_stayno.length; i++){
                    sql2 = "select * from staykey_stay where stay_no = ?";
                    pstmt2 = con.prepareStatement(sql2);
                    pstmt2.setInt(1, Integer.parseInt(epd_stayno[i]));
                    rs2 = pstmt2.executeQuery();

                    // 숙소 정보가 있으면 HashMap에 데이터 저장하고, 그 HashMap을 ArrayList에 넣기
                    if(rs2.next()) {
                        HashMap<String, String> data = new HashMap<String, String>();

                        data.put("stay_no", epd_stayno[i]);
                        data.put("stay_name", rs2.getString("stay_name"));
                        data.put("stay_location", rs2.getString("stay_location"));
                        data.put("stay_room_people_min", rs2.getString("stay_room_people_min"));                      
                        data.put("bbs_title", rs.getString("bbs_title"));
                        data.put("bbs_no", rs.getString("bbs_no"));                        
                        data.put("bbs_day", eventDate.remainDate(rs.getString("bbs_showstart"), rs.getString("bbs_showend")));
                        
                        if(rs.getString("bbs_file1") != null) {
                            data.put("bbs_photo", rs.getString("bbs_file1"));
                        }else if(rs.getString("bbs_file2") != null) {
                            data.put("bbs_photo", rs.getString("bbs_file2"));
                        }else if(rs.getString("bbs_file3") != null) {
                            data.put("bbs_photo", rs.getString("bbs_file3"));
                        }else if(rs.getString("bbs_file4") != null) {
                            data.put("bbs_photo", rs.getString("bbs_file4"));
                        }else if(rs.getString("bbs_file5") != null) {
                            data.put("bbs_photo", rs.getString("bbs_file5"));
                        }else{
                            data.put("bbs_photo", null);
                        }
                        
                        if(rs2.getString("stay_file1") != null) {
                            data.put("stay_photo", rs2.getString("stay_file1"));
                        }else if(rs2.getString("stay_file2") != null) {
                            data.put("stay_photo", rs2.getString("stay_file2"));
                        }else if(rs2.getString("stay_file3") != null) {
                            data.put("stay_photo", rs2.getString("stay_file3"));
                        }else if(rs2.getString("stay_file4") != null) {
                            data.put("stay_photo", rs2.getString("stay_file4"));
                        }else if(rs2.getString("stay_file5") != null) {
                            data.put("stay_photo", rs2.getString("stay_file5"));
                        }else{
                            data.put("stay_photo", null);
                        }

                        list.add(data);
                    }
                }
            }


        } catch (Exception e) {
            e.printStackTrace();

        } finally {
            closeConn(rs, pstmt, con);
        }

        System.out.println(list);

        return list;
    }



}
