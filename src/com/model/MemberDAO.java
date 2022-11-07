package com.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String sql = null;

    private static MemberDAO instance;

    private MemberDAO() {
    }

    public static MemberDAO getInstance() {
        if (instance == null) {
            instance = new MemberDAO();
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
        String search_sql = " where member_no > 0";
        if (map.get("ps_type").equals("user")) {
            search_sql += " and member_type = 'user'";
        } else if (map.get("ps_type").equals("admin")) {
            search_sql += " and member_type = 'admin'";
        }
        if (map.get("ps_name") != null) {
            search_sql += " and member_name like '%" + map.get("ps_name") + "%'";
        }
        if (map.get("ps_id") != null) {
            search_sql += " and member_id like '%" + map.get("ps_id") + "%'";
        }
        if (map.get("ps_email") != null) {
            search_sql += " and member_email like '%" + map.get("ps_email") + "%'";
        }

        try {
            openConn();

            sql = "select count(*) from staykey_member" + search_sql;
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
    // 회원 목록 메서드
    // ======================================================

    public List<MemberDTO> memberList(int page, int rowsize, Map<String, Object> map) {
        List<MemberDTO> list = new ArrayList<MemberDTO>();

        int startNo = (page * rowsize) - (rowsize - 1);
        int endNo = (page * rowsize);

        // 검색용 설정
        String search_sql1 = " where member_no > 0";
        String search_sql2 = "";

        if (map.get("ps_type") != "" && map.get("ps_type").equals("user")) {
            search_sql2 += " and member_type = 'user'";
        } else if (map.get("ps_type") != "" && map.get("ps_type").equals("admin")) {
            search_sql2 += " and member_type = 'admin'";
        }
        if (map.get("ps_name") != "" && map.get("ps_name") != null) {
            search_sql2 += " and member_name like '%" + map.get("ps_name") + "%'";
        }
        if (map.get("ps_id") != "" && map.get("ps_id") != null) {
            search_sql2 += " and member_id like '%" + map.get("ps_id") + "%'";
        }
        if (map.get("ps_email") != "" && map.get("ps_email") != null) {
            search_sql2 += " and member_email like '%" + map.get("ps_email") + "%'";
        }

        search_sql1 += search_sql2;

        // 정렬용 설정
        String order_sql = "member_joindate";
        if (map.get("ps_order").equals("register_desc")) {
            order_sql = "member_joindate desc";
        } else if (map.get("ps_order").equals("register_asc")) {
            order_sql = "member_joindate asc";
        } else if (map.get("ps_order").equals("id_desc")) {
            order_sql = "member_id desc";
        } else if (map.get("ps_order").equals("id_asc")) {
            order_sql = "member_id asc";
        } else if (map.get("ps_order").equals("name_desc")) {
            order_sql = "member_name desc";
        } else if (map.get("ps_order").equals("name_asc")) {
            order_sql = "member_name asc";
        } else if (map.get("ps_order").equals("count_desc")) {
            order_sql = "member_reserv desc";
        } else if (map.get("ps_order").equals("count_asc")) {
            order_sql = "member_reserv asc";
        }

        try {
            openConn();

            sql = "select * from " + "(select row_number() over(order by " + order_sql
                    + ") rnum, b.* from staykey_member b " + search_sql1 + ") " + "where rnum >= ? and rnum <= ?"
                    + search_sql2;
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, startNo);
            pstmt.setInt(2, endNo);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                MemberDTO dto = new MemberDTO();

                dto.setMember_no(rs.getInt("member_no"));
                dto.setMember_type(rs.getString("member_type"));
                dto.setMember_id(rs.getString("member_id"));
                dto.setMember_pw(rs.getString("member_pw"));
                dto.setMember_name(rs.getString("member_name"));
                dto.setMember_email(rs.getString("member_email"));
                dto.setMember_phone(rs.getString("member_phone"));
                dto.setMember_reserv(rs.getInt("member_reserv"));
                dto.setMember_photo(rs.getString("member_photo"));
                dto.setMember_joindate(rs.getString("member_joindate"));

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
    // 회원 아이디 체크 메서드
    // ======================================================
    public int idCheck(String member_id) {
        int result = 0;

        try {
            openConn();

            sql = "select * from staykey_member where member_id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, member_id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                result = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();

        } finally {
            closeConn(rs, pstmt, con);
        }
        return result;
    }

    // ======================================================
    // 회원 등록 메서드
    // ======================================================
    public int registerMember(MemberDTO dto) {
        int result = 0, count = 0;

        try {
            openConn();

            sql = "select max(member_no) from staykey_member";
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1) + 1;
            }
            
            sql = "insert into staykey_member values(?, default, ?, ?, ?, ?, ?, default, ?, sysdate)";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, count);
            pstmt.setString(2, dto.getMember_id());
            pstmt.setString(3, dto.getMember_pw());
            pstmt.setString(4, dto.getMember_name());
            pstmt.setString(5, dto.getMember_email());
            pstmt.setString(6, dto.getMember_phone());
            pstmt.setString(7, dto.getMember_photo());

            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConn(rs, pstmt, con);
        }
        return result;
    }

    // ======================================================
    // 회원 정보 가져오는 메서드
    // ======================================================
    public MemberDTO getMemberInfo(String member_id) {
        MemberDTO dto = null;

        try {
            openConn();

            sql = "select * from staykey_member where member_id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, member_id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                dto = new MemberDTO();

                dto.setMember_no(rs.getInt("member_no"));
                dto.setMember_type(rs.getString("member_type"));
                dto.setMember_id(rs.getString("member_id"));
                dto.setMember_pw(rs.getString("member_pw"));
                dto.setMember_name(rs.getString("member_name"));
                dto.setMember_email(rs.getString("member_email"));
                dto.setMember_phone(rs.getString("member_phone"));
                dto.setMember_reserv(rs.getInt("member_reserv"));
                dto.setMember_photo(rs.getString("member_photo"));
                dto.setMember_joindate(rs.getString("member_joindate"));
            }

        } catch (SQLException e) {
            e.printStackTrace();

        } finally {
            closeConn(rs, pstmt, con);
        }

        return dto;
    }

    // ======================================================
    // 회원정보 삭제하는 메서드 + 회원번호 재작업
    // ======================================================
    public int deleteMember(String memberId, int no) {
        int result = 0;

        try {
            openConn();

            sql = "delete from staykey_member where member_id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, memberId);
            result = pstmt.executeUpdate();

            
            sql = "update staykey_member set member_no = member_no - 1 where member_no > ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, no);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConn(rs, pstmt, con);
        }
        return result;
    } // deleteMember() 종료

    // ======================================================
    // 회원정보를 업데이트 하는 메서드
    // ======================================================
    public int memberModify(MemberDTO dto) {
        int result = 0;

        try {
            openConn();
            sql = "update staykey_member set member_type = ?, member_pw = ?, member_name = ?, member_email = ?, member_phone = ?, member_photo = ? where member_id = ?";
            pstmt = con.prepareStatement(sql);

            pstmt.setString(1, dto.getMember_type());
            pstmt.setString(2, dto.getMember_pw());
            pstmt.setString(3, dto.getMember_name());
            pstmt.setString(4, dto.getMember_email());
            pstmt.setString(5, dto.getMember_phone());
            pstmt.setString(6, dto.getMember_photo());
            pstmt.setString(7, dto.getMember_id());

            result = pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConn(pstmt, con);
        }
        return result;
    }
    
    // ======================================================
    // 회원 아이디 + 비밀번호 체크 메서드 // 멤버 타입 반환 필요
    // ======================================================
    public int idPwTypeCheck(String member_id, String member_pw) {
        int result = 0;

        try {
            openConn();

            sql = "select member_pw, member_type from staykey_member where member_id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, member_id);
            rs = pstmt.executeQuery();

            if(rs.next()) { // 
               if(rs.getString("member_pw").equals(member_pw)) { // 비번 일치
            	   if(rs.getString("member_type").equals("admin")) { 
            		   result = -2; // admin = -2;
            	   }else { // 아니면 user
            		   result = -3; // user = -3;
            	   }
               }else { // 비번 틀림
            	   result = -1;
               }
            }
            // 0 return 시 일치하는 아이디 없음
        } catch (Exception e) {
            e.printStackTrace();

        } finally {
            closeConn(rs, pstmt, con);
        }
        return result;
    }
    
    // ======================================================
    // 아이디 찾기
    // ======================================================
    public String idFind(String member_email, String member_name) {
    	String member_id = "";

        try {
            openConn();

            sql = "select member_name from staykey_member where member_email = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, member_email);
            rs = pstmt.executeQuery();
            if(rs.next()) { // 이메일 존재할 때
                sql = "select member_id from staykey_member where member_email = ? and member_name = ?";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, member_email);
                pstmt.setString(2, member_name);
                rs = pstmt.executeQuery();
                if(rs.next()) { // 둘 다 일치
                	member_id = rs.getString("member_id");          
                }else { // 이름 없을 때
                	member_id = "noName";
                }
            }else { // 이메일 없을 때
            	member_id = "noEmail";
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConn(rs, pstmt, con);
        }
        return member_id;
    }
    
    // ======================================================
    // 비밀번호 찾기
    // ======================================================
    public String pwdFind(String member_email, String member_id) {
    	String member_pwd = "";

        try {
            openConn();

            sql = "select member_id from staykey_member where member_email = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, member_email);
            rs = pstmt.executeQuery();
            if(rs.next()) { // 이메일 존재할 때
                sql = "select member_pw from staykey_member where member_email = ? and member_id = ?";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, member_email);
                pstmt.setString(2, member_id);
                rs = pstmt.executeQuery();
                if(rs.next()) { // 둘 다 일치
                	member_pwd = rs.getString("member_pw");          
                }else { // 아이디 없을 때
                	member_pwd = "noId";
                }
            }else { // 이메일 없을 때
            	member_pwd = "noEmail";
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConn(rs, pstmt, con);
        }
        return member_pwd;
    }



    // ======================================================
    // 예약 횟수 세기 (이용완료된 내역만 카운트)
    // ======================================================
    public int reservCount(String member_id) {
        int count = 0;

        try {
            openConn();

            // 현재 날짜
            Date get_today = new Date();
            DateFormat todayFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
            String show_today = todayFormat.format(get_today);

            sql = "select count(*) from staykey_reserv where reserv_status = 'reserv' and reserv_memid = ? and reserv_end < TO_DATE(?, 'YYYY/MM/DD HH24:MI:SS')";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, member_id);
            pstmt.setString(2, show_today);
            rs = pstmt.executeQuery();

            rs.next();
            count = rs.getInt(1);

        } catch(Exception e) {
            e.printStackTrace();

        } finally {
            closeConn(rs, pstmt, con);
        }

        return count;
    }





    // ======================================================
    // 회원정보를 수정하는 메서드 (사이트)
    // ======================================================
    public int infoModifySite(MemberDTO dto) {
        int result = 0;

        try {
            openConn();

            sql = "update staykey_member set member_pw = ?, member_name = ?, member_email = ?, member_phone = ?, member_photo = ? where member_id = ?";
            pstmt = con.prepareStatement(sql);

            pstmt.setString(1, dto.getMember_pw());
            pstmt.setString(2, dto.getMember_name());
            pstmt.setString(3, dto.getMember_email());
            pstmt.setString(4, dto.getMember_phone());
            pstmt.setString(5, dto.getMember_photo());
            pstmt.setString(6, dto.getMember_id());

            result = pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();

        } finally {
            closeConn(pstmt, con);
        }

        return result;
    }
    


    // ======================================================
    // 회원 탈퇴 처리 메서드 (사이트)
    // ======================================================
    public int exitMember(String member_id) {
        int result = 0;

        try {
            openConn();

            sql = "update staykey_member set member_type = ?, member_pw = ?, member_name = ?, member_email = ?, member_phone = ?, member_reserv = default, member_photo = default where member_id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, "exit");
            pstmt.setString(2, "1234wqer5678!!");
            pstmt.setString(3, "탈퇴회원");
            pstmt.setString(4, "exit@exit.com");
            pstmt.setString(5, "010-0000-0000");
            pstmt.setString(6, member_id);
            result = pstmt.executeUpdate();

        } catch(Exception e) {
            e.printStackTrace();

        } finally {
            closeConn(pstmt, con);
        }

        return result;
    }





    // ======================================================
    // 회원 예약 횟수 증가
    // ======================================================
    public void plusMemReservCount(String member_id) {
        try {
            openConn();

            sql = "update staykey_member set member_reserv = member_reserv + 1 where member_id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, member_id);
            pstmt.executeUpdate();

        } catch(Exception e) {
            e.printStackTrace();

        } finally {
            closeConn(pstmt, con);
        }
    }



    // ======================================================
    // 회원 예약 횟수 감소
    // ======================================================
    public void minusMemReservCount(String member_id) {
        try {
            openConn();

            sql = "update staykey_member set member_reserv = member_reserv - 1 where member_id = ? and member_reserv > 0";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, member_id);
            pstmt.executeUpdate();

        } catch(Exception e) {
            e.printStackTrace();

        } finally {
            closeConn(pstmt, con);
        }
    }


}
