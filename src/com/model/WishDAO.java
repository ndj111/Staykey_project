package com.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class WishDAO {
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String sql = null;
    
    PreparedStatement pstmt2 = null;
    ResultSet rs2 = null;
    String sql2 = null;
    
    private static WishDAO instance;

    private WishDAO() {
    }

    public static WishDAO getInstance() {
        if (instance == null) {
            instance = new WishDAO();
        }

        return instance;
    }


    // ======================================================
    // DB 연동하는 작업을 진행하는 메서드
    // ======================================================
    public void openConn() {
        try {
            Context ctx = new InitialContext();
            DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/myoracle");
            con = ds.getConnection();
        } catch(Exception e) {
            e.printStackTrace();
        }
    }


    // ======================================================
    // DB에 연결된 자원 종료하는 메서드
    // ======================================================
    public void closeConn(ResultSet rs, PreparedStatement pstmt, Connection con) {
        try {
            if(rs != null) rs.close();
            if(pstmt != null) pstmt.close();
            if(con != null) con.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
    public void closeConn(PreparedStatement pstmt, Connection con) {
        try {
            if(pstmt != null) pstmt.close();
            if(con != null) con.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
    }


    // ======================================================
    // DB 전체 데이터 갯수 메서드
    // ======================================================
    public int getTotalCount(String member_id) {
        int result = 0;

        // 검색용 설정
        try {
            openConn();

            sql = "select count(*) from staykey_member_wish where wish_memid = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, member_id);
            rs = pstmt.executeQuery();

            if (rs.next()) result = rs.getInt(1);

        } catch(Exception e) {
            e.printStackTrace();

        } finally {
            closeConn(rs, pstmt, con);
        }

        return result;
    }




    // ======================================================
    // 숙소 찜하기 추가
    // ======================================================
    public String addWish(int stay_no, String member_id) {
        String result = "add_no";

        try {
            openConn();

            int count = 0;

            sql = "select max(wish_no) from staykey_member_wish";
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if(rs.next()) count = rs.getInt(1) + 1;

            sql = "insert into staykey_member_wish values(?, ?, ?, default)";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, count);
            pstmt.setInt(2, stay_no);
            pstmt.setString(3, member_id);
            int chk = pstmt.executeUpdate();

            if(chk > 0) result = "add_ok";
            
        } catch(Exception e) {
            e.printStackTrace();

        } finally {
            closeConn(rs, pstmt, con);
        }

        return result;
    }




    // ======================================================
    // 숙소 찜하기 삭제
    // ======================================================
    public String delWish(int stay_no, String member_id) {
        String result = "del_no";

        try {
            openConn();

            sql = "delete from staykey_member_wish where wish_stayno = ? and wish_memid = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, stay_no);
            pstmt.setString(2, member_id);
            int chk = pstmt.executeUpdate();

            if(chk > 0) result = "del_ok";
            
        } catch(Exception e) {
            e.printStackTrace();

        } finally {
            closeConn(pstmt, con);
        }

        return result;
    }





    // ======================================================
    // 해당 숙소 찜하기 정보 확인
    // ======================================================
    public String chkStayWish(int stay_no, String member_id) {
        String result = "N";

        try {
            openConn();

            sql = "select * from staykey_member_wish where wish_stayno = ? and wish_memid = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, stay_no);
            pstmt.setString(2, member_id);
            rs = pstmt.executeQuery();

            if(rs.next()) result = "Y";

        } catch(Exception e) {
            e.printStackTrace();

        } finally {
            closeConn(rs, pstmt, con);
        }

        return result;
    }
    
    


    // ======================================================
    // 찜 목록 가져오는 메서드
    // ======================================================
    public List<StayDTO> getWishInfo(int page, int rowsize, String id) {
        List<StayDTO> list = new ArrayList<StayDTO>();

        int startNo = (page * rowsize) - (rowsize - 1);
        int endNo = (page * rowsize);

        try {
            openConn();

            sql = "select * from (select row_number() over(order by wish_date desc) rnum, b.* from staykey_member_wish b where wish_memid = ?) where wish_memid = ? and rnum >= ? and rnum <= ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, id);
            pstmt.setString(2, id);
            pstmt.setInt(3, startNo);
            pstmt.setInt(4, endNo);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                sql2 = "select * from staykey_stay where stay_no = ?";
                pstmt2 = con.prepareStatement(sql2);
                pstmt2.setInt(1, rs.getInt("wish_stayno"));
                rs2 = pstmt2.executeQuery();

                while(rs2.next()) {
                    StayDTO sdto = new StayDTO();

                    sdto.setStay_no(rs2.getInt("stay_no"));
                    sdto.setStay_type(rs2.getString("stay_type"));
                    sdto.setStay_name(rs2.getString("stay_name"));
                    sdto.setStay_desc(rs2.getString("stay_desc"));
                    sdto.setStay_location(rs2.getString("stay_location"));
                    sdto.setStay_addr(rs2.getString("stay_addr"));
                    sdto.setStay_phone(rs2.getString("stay_phone"));
                    sdto.setStay_email(rs2.getString("stay_email"));
                    sdto.setStay_content1(rs2.getString("stay_content1"));
                    sdto.setStay_content2(rs2.getString("stay_content2"));
                    sdto.setStay_content3(rs2.getString("stay_content3"));
                    sdto.setStay_info1(rs2.getString("stay_info1"));
                    sdto.setStay_info2(rs2.getString("stay_info2"));
                    sdto.setStay_info3(rs2.getString("stay_info3"));
                    sdto.setStay_file1(rs2.getString("stay_file1"));
                    sdto.setStay_file2(rs2.getString("stay_file2"));
                    sdto.setStay_file3(rs2.getString("stay_file3"));
                    sdto.setStay_file4(rs2.getString("stay_file4"));
                    sdto.setStay_file5(rs2.getString("stay_file5"));
                    sdto.setStay_option1_name(rs2.getString("stay_option1_name"));
                    sdto.setStay_option1_price(rs2.getInt("stay_option1_price"));
                    sdto.setStay_option1_desc(rs2.getString("stay_option1_desc"));
                    sdto.setStay_option1_photo(rs2.getString("stay_option1_photo"));
                    sdto.setStay_option2_name(rs2.getString("stay_option2_name"));
                    sdto.setStay_option2_price(rs2.getInt("stay_option2_price"));
                    sdto.setStay_option2_desc(rs2.getString("stay_option2_desc"));
                    sdto.setStay_option2_photo(rs2.getString("stay_option2_photo"));
                    sdto.setStay_option3_name(rs2.getString("stay_option3_name"));
                    sdto.setStay_option3_price(rs2.getInt("stay_option3_price"));
                    sdto.setStay_option3_desc(rs2.getString("stay_option3_desc"));
                    sdto.setStay_option3_photo(rs2.getString("stay_option3_photo"));
                    sdto.setStay_hit(rs2.getInt("stay_hit"));
                    sdto.setStay_reserv(rs2.getInt("stay_reserv"));
                    sdto.setStay_date(rs2.getString("stay_date"));
                    sdto.setStay_room_price_min(rs2.getInt("stay_room_price_min"));
                    sdto.setStay_room_price_max(rs2.getInt("stay_room_price_max"));
                    sdto.setStay_room_people_min(rs2.getInt("stay_room_people_min"));
                    sdto.setStay_room_people_max(rs2.getInt("stay_room_people_max"));

                    list.add(sdto);
                }
            }

        } catch(SQLException e) {
            e.printStackTrace();

        } finally {
            closeConn(rs, pstmt, con);
            closeConn(rs2, pstmt2, con);
        }

        return list;
    }
    



}
