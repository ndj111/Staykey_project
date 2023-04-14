package com.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ReservDAO {
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String sql = null;
    
    PreparedStatement pstmt2 = null;
    ResultSet rs2 = null;
    String sql2 = null;
    
    private static ReservDAO instance;

    private ReservDAO() {
    }

    public static ReservDAO getInstance() {
        if (instance == null) {
            instance = new ReservDAO();
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
        String search_sql = " where reserv_no > 0";

        if(map.get("ps_status") != "" && map.get("ps_status").equals("reserv")) {
            search_sql += " and reserv_status = 'reserv'";
        }else if(map.get("ps_status") != "" && map.get("ps_status").equals("cancel")) {
            search_sql += " and reserv_status = 'cancel'";
        }
        if(map.get("ps_sess") != "" && map.get("ps_sess") != null) {
            search_sql += " and reserv_sess like '%" + map.get("ps_sess") + "%'";
        }
        if(map.get("ps_name") != "" && map.get("ps_name") != null) {
            search_sql += " and reserv_memname like '%" + map.get("ps_name") + "%'";
        }
        if(map.get("ps_stay") != "" && map.get("ps_stay") != null) {
            search_sql += " and reserv_stayname like '%" + map.get("ps_stay") + "%'";
        }

        if(!map.get("ps_duse").equals("1")) {
            String sql_start_date = (String)map.get("ps_start");
                   sql_start_date = sql_start_date.replace("-", "");
            String sql_end_date = (String)map.get("ps_end");
                   sql_end_date = sql_end_date.replace("-", "");
            search_sql += " and ( (to_char(reserv_start, 'YYYYMMDD') >= " + sql_start_date + " and to_char(reserv_start, 'YYYYMMDD') <= " + sql_end_date + ")";
            search_sql += " or (to_char(reserv_end, 'YYYYMMDD') >= " + sql_start_date + " and to_char(reserv_end, 'YYYYMMDD') <= " + sql_end_date + ") )";
        }

        try {
            openConn();

            sql = "select count(*) from staykey_reserv" + search_sql;
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
    // 예약목록 메서드
    // ======================================================
    public List<ReservDTO> getReservList(int page, int rowsize, Map<String, Object> map) {
        List<ReservDTO> list = new ArrayList<ReservDTO>();

        int startNo = (page * rowsize) - (rowsize - 1);
        int endNo = (page * rowsize);

        // 검색용 설정
        String search_sql1 = " where reserv_no > 0";
        String search_sql2 = "";


        if(map.get("ps_status") != "" && map.get("ps_status").equals("reserv")) {
            search_sql2 += " and reserv_status = 'reserv'";
        }else if(map.get("ps_status") != "" && map.get("ps_status").equals("cancel")) {
            search_sql2 += " and reserv_status = 'cancel'";
        }
        if(map.get("ps_sess") != "" && map.get("ps_sess") != null) {
            search_sql2 += " and reserv_sess like '%" + map.get("ps_sess") + "%'";
        }
        if(map.get("ps_name") != "" && map.get("ps_name") != null) {
            search_sql2 += " and reserv_memname like '%" + map.get("ps_name") + "%'";
        }
        if(map.get("ps_stay") != "" && map.get("ps_stay") != null) {
            search_sql2 += " and reserv_stayname like '%" + map.get("ps_stay") + "%'";
        }

        if(!map.get("ps_duse").equals("1")) {
            String sql_start_date = (String)map.get("ps_start");
                   sql_start_date = sql_start_date.replace("-", "");
            String sql_end_date = (String)map.get("ps_end");
                   sql_end_date = sql_end_date.replace("-", "");
            search_sql2 += " and ( (to_char(reserv_start, 'YYYYMMDD') >= " + sql_start_date + " and to_char(reserv_start, 'YYYYMMDD') <= " + sql_end_date + ")";
            search_sql2 += " or (to_char(reserv_end, 'YYYYMMDD') >= " + sql_start_date + " and to_char(reserv_end, 'YYYYMMDD') <= " + sql_end_date + ") )";
        }

        search_sql1 += search_sql2;
        // System.out.println(search_sql1);


        // 정렬용 설정
        String order_sql = "register_desc";
        if (map.get("ps_order").equals("register_desc")) {
            order_sql = "reserv_date desc";
        } else if (map.get("ps_order").equals("register_asc")) {
            order_sql = "reserv_date asc";
        } else if (map.get("ps_order").equals("enddate_desc")) {
            order_sql = "reserv_end desc";
        } else if (map.get("ps_order").equals("enddate_asc")) {
            order_sql = "reserv_end asc";
        } else if (map.get("ps_order").equals("name_desc")) {
            order_sql = "reserv_memname desc";
        } else if (map.get("ps_order").equals("name_asc")) {
            order_sql = "reserv_memname asc";
        } else if (map.get("ps_order").equals("price_desc")) {
            order_sql = "reserv_total_price desc";
        } else if (map.get("ps_order").equals("price_asc")) {
            order_sql = "reserv_total_price asc";
        } else if (map.get("ps_order").equals("stay_desc")) {
            order_sql = "reserv_stayname desc";
        } else if (map.get("ps_order").equals("stay_asc")) {
            order_sql = "reserv_stayname asc";
        }

        // System.out.println(search_sql1);

        try {
            openConn();

            sql = "select * from " + "(select row_number() over(order by " + order_sql
                    + ") rnum, b.* from staykey_reserv b " + search_sql1 + ") " + "where rnum >= ? and rnum <= ?"
                    + search_sql2;
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, startNo);
            pstmt.setInt(2, endNo);
            rs = pstmt.executeQuery();

            while(rs.next()){
                ReservDTO dto = new ReservDTO();

                dto.setReserv_no(rs.getInt("reserv_no"));
                dto.setReserv_status(rs.getString("reserv_status"));
                dto.setReserv_sess(rs.getString("reserv_sess"));
                dto.setReserv_stayno(rs.getInt("reserv_stayno"));
                dto.setReserv_stayname(rs.getString("reserv_stayname"));
                dto.setReserv_roomno(rs.getInt("reserv_roomno"));
                dto.setReserv_roomname(rs.getString("reserv_roomname"));
                dto.setReserv_memid(rs.getString("reserv_memid"));
                dto.setReserv_memname(rs.getString("reserv_memname"));
                dto.setReserv_memphone(rs.getString("reserv_memphone"));
                dto.setReserv_mememail(rs.getString("reserv_mememail"));
                dto.setReserv_start(rs.getString("reserv_start"));
                dto.setReserv_end(rs.getString("reserv_end"));
                dto.setReserv_daycount(rs.getInt("reserv_daycount"));
                dto.setReserv_basic_price(rs.getInt("reserv_basic_price"));
                dto.setReserv_option1_name(rs.getString("reserv_option1_name"));
                dto.setReserv_option1_price(rs.getInt("reserv_option1_price"));
                dto.setReserv_option2_name(rs.getString("reserv_option2_name"));
                dto.setReserv_option2_price(rs.getInt("reserv_option2_price"));
                dto.setReserv_option3_name(rs.getString("reserv_option3_name"));
                dto.setReserv_option3_price(rs.getInt("reserv_option3_price"));
                dto.setReserv_total_price(rs.getInt("reserv_total_price"));
                dto.setReserv_people_adult(rs.getInt("reserv_people_adult"));
                dto.setReserv_people_kid(rs.getInt("reserv_people_kid"));
                dto.setReserv_people_baby(rs.getInt("reserv_people_baby"));
                dto.setReserv_pickup(rs.getString("reserv_pickup"));
                dto.setReserv_request(rs.getString("reserv_request"));
                dto.setReserv_date(rs.getString("reserv_date"));

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
    // 예약정보 가져오기 메서드
    // ======================================================
    public ReservDTO getReservInfo(String sess) {
        ReservDTO dto = null;

        try {
            openConn();

            sql = "select * from staykey_reserv where reserv_sess = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, sess);
            rs = pstmt.executeQuery();

            if(rs.next()) {
                dto = new ReservDTO();

                dto.setReserv_no(rs.getInt("reserv_no"));
                dto.setReserv_status(rs.getString("reserv_status"));
                dto.setReserv_sess(rs.getString("reserv_sess"));
                dto.setReserv_stayno(rs.getInt("reserv_stayno"));
                dto.setReserv_stayname(rs.getString("reserv_stayname"));
                dto.setReserv_roomno(rs.getInt("reserv_roomno"));
                dto.setReserv_roomname(rs.getString("reserv_roomname"));
                dto.setReserv_memid(rs.getString("reserv_memid"));
                dto.setReserv_memname(rs.getString("reserv_memname"));
                dto.setReserv_memphone(rs.getString("reserv_memphone"));
                dto.setReserv_mememail(rs.getString("reserv_mememail"));
                dto.setReserv_start(rs.getString("reserv_start"));
                dto.setReserv_end(rs.getString("reserv_end"));
                dto.setReserv_daycount(rs.getInt("reserv_daycount"));
                dto.setReserv_basic_price(rs.getInt("reserv_basic_price"));
                dto.setReserv_option1_name(rs.getString("reserv_option1_name"));
                dto.setReserv_option1_price(rs.getInt("reserv_option1_price"));
                dto.setReserv_option2_name(rs.getString("reserv_option2_name"));
                dto.setReserv_option2_price(rs.getInt("reserv_option2_price"));
                dto.setReserv_option3_name(rs.getString("reserv_option3_name"));
                dto.setReserv_option3_price(rs.getInt("reserv_option3_price"));
                dto.setReserv_total_price(rs.getInt("reserv_total_price"));
                dto.setReserv_people_adult(rs.getInt("reserv_people_adult"));
                dto.setReserv_people_kid(rs.getInt("reserv_people_kid"));
                dto.setReserv_people_baby(rs.getInt("reserv_people_baby"));
                dto.setReserv_pickup(rs.getString("reserv_pickup"));
                dto.setReserv_date(rs.getString("reserv_date"));
                                
                if(rs.getString("reserv_request") != null){
                    dto.setReserv_request(rs.getString("reserv_request").replace("\n", "<br />"));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();

        } finally {
            closeConn(rs, pstmt, con);
        }

        return dto;
    }






    // ======================================================
    // 예약정보 수정 메서드
    // ======================================================
    public int modifyReserv(ReservDTO dto) {
        int result = 0;

        try {
            openConn();

            sql = "update staykey_reserv set reserv_status = ?, reserv_start = TO_DATE(?, 'YYYY/MM/DD HH24:MI:SS'),"
                    + "reserv_end = TO_DATE(?, 'YYYY/MM/DD HH24:MI:SS'), reserv_daycount = ?, reserv_basic_price = ?,"
                    + "reserv_option1_name = ?, reserv_option1_price = ?, reserv_option2_name = ?, reserv_option2_price = ?,"
                    + "reserv_option3_name = ?, reserv_option3_price = ?, reserv_total_price = ?, reserv_people_adult = ?,"
                    + "reserv_people_kid = ?, reserv_people_baby = ?, reserv_pickup = ?, reserv_request = ?"
                    + "where reserv_no = ? and reserv_sess = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, dto.getReserv_status());
            pstmt.setString(2, dto.getReserv_start());
            pstmt.setString(3, dto.getReserv_end());
            pstmt.setInt(4, dto.getReserv_daycount());
            pstmt.setInt(5, dto.getReserv_basic_price());
            pstmt.setString(6, dto.getReserv_option1_name());
            pstmt.setInt(7, dto.getReserv_option1_price());
            pstmt.setString(8, dto.getReserv_option2_name());
            pstmt.setInt(9, dto.getReserv_option2_price());
            pstmt.setString(10, dto.getReserv_option3_name());
            pstmt.setInt(11, dto.getReserv_option3_price());
            pstmt.setInt(12, dto.getReserv_total_price());
            pstmt.setInt(13, dto.getReserv_people_adult());
            pstmt.setInt(14, dto.getReserv_people_kid());
            pstmt.setInt(15, dto.getReserv_people_baby());
            pstmt.setString(16, dto.getReserv_pickup());
            pstmt.setString(17, dto.getReserv_request());
            pstmt.setInt(18, dto.getReserv_no());
            pstmt.setString(19, dto.getReserv_sess());
            result = pstmt.executeUpdate();

        } catch(Exception e) {
            e.printStackTrace();

        } finally {
            closeConn(pstmt, con);
        }

        return result;
    }







    // ======================================================
    // 글자 수 맞춰서 0 붙이기
    // ======================================================
    public String setLength(int val){
        String temp = "";

        for(int i = (int)(Math.log10(val)+1); i<6; i++){
            temp += "0";
        }

        return temp + val;
    }



    // ======================================================
    // 예약번호 만들기
    // ======================================================
    public String makeReservSess() {
        String result = "";


        // 주문번호 앞(날짜) 생성
        SimpleDateFormat nowDateFormat = new SimpleDateFormat("yyMMdd");
        Calendar c1 = Calendar.getInstance();
        String sessHeader = nowDateFormat.format(c1.getTime());


        // 오늘날짜 주문건 체크
        String chkSess = null;

        try {
            openConn();

            sql = "select reserv_sess from staykey_reserv where reserv_sess like '%" + sessHeader + "%' order by reserv_sess desc";
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();

            if(rs.next()) chkSess = rs.getString(1);
            
        } catch(Exception e) {
            e.printStackTrace();

        } finally {
            closeConn(rs, pstmt, con);
        }


        // 주문번호 생성
        if(chkSess != null) {
            String[] epdSess = chkSess.split("-");
            int tmp = Integer.parseInt(epdSess[1]) + 1;
            String sessFooter = setLength(tmp);
            result = sessHeader + "-" + sessFooter; 
        }else{
            result = sessHeader + "-000001"; 
        }

        return result;
    }






    // ======================================================
    // 예약 정보 입력하기
    // ======================================================
    public int insertReserv(ReservDTO dto) {
        int result = 0, count = 0;

        try {
            openConn();

            sql = "select max(reserv_no) from staykey_reserv";
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();

            if(rs.next()) count = rs.getInt(1) + 1;


            sql = "insert into staykey_reserv values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, TO_DATE(?, 'YYYY/MM/DD HH24:MI:SS'), TO_DATE(?, 'YYYY/MM/DD HH24:MI:SS'), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, sysdate)";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, count);
            pstmt.setString(2, "reserv");
            pstmt.setString(3, dto.getReserv_sess());
            pstmt.setInt(4, dto.getReserv_stayno());
            pstmt.setString(5, dto.getReserv_stayname());
            pstmt.setInt(6, dto.getReserv_roomno());
            pstmt.setString(7, dto.getReserv_roomname());
            pstmt.setString(8, dto.getReserv_memid());
            pstmt.setString(9, dto.getReserv_memname());
            pstmt.setString(10, dto.getReserv_memphone());
            pstmt.setString(11, dto.getReserv_mememail());
            pstmt.setString(12, dto.getReserv_start());
            pstmt.setString(13, dto.getReserv_end());
            pstmt.setInt(14, dto.getReserv_daycount());
            pstmt.setInt(15, dto.getReserv_basic_price());
            pstmt.setString(16, dto.getReserv_option1_name());
            pstmt.setInt(17, dto.getReserv_option1_price());
            pstmt.setString(18, dto.getReserv_option2_name());
            pstmt.setInt(19, dto.getReserv_option2_price());
            pstmt.setString(20, dto.getReserv_option3_name());
            pstmt.setInt(21, dto.getReserv_option3_price());
            pstmt.setInt(22, dto.getReserv_total_price());
            pstmt.setInt(23, dto.getReserv_people_adult());
            pstmt.setInt(24, dto.getReserv_people_kid());
            pstmt.setInt(25, dto.getReserv_people_baby());
            pstmt.setString(26, dto.getReserv_pickup());
            pstmt.setString(27, dto.getReserv_request());
            result = pstmt.executeUpdate();

        } catch(Exception e) {
            e.printStackTrace();

        } finally {
            closeConn(rs, pstmt, con);
        }

        return result;
    }

    


    // ======================================================
    // 예약내역 목록 메서드 (사이트)
    // ======================================================
    public List<ReservDTO> getSiteReservList(String id) {
    	List<ReservDTO> list = new ArrayList<ReservDTO>();

        try {
            openConn();

            sql = "select * from staykey_reserv where reserv_memid = ? order by reserv_date desc";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();

            while(rs.next()) {
            	ReservDTO dto = new ReservDTO();

                dto.setReserv_no(rs.getInt("reserv_no"));
                dto.setReserv_status(rs.getString("reserv_status"));
                dto.setReserv_sess(rs.getString("reserv_sess"));
                dto.setReserv_stayno(rs.getInt("reserv_stayno"));
                dto.setReserv_stayname(rs.getString("reserv_stayname"));
                dto.setReserv_roomno(rs.getInt("reserv_roomno"));
                dto.setReserv_roomname(rs.getString("reserv_roomname"));
                dto.setReserv_memid(rs.getString("reserv_memid"));
                dto.setReserv_memname(rs.getString("reserv_memname"));
                dto.setReserv_memphone(rs.getString("reserv_memphone"));
                dto.setReserv_mememail(rs.getString("reserv_mememail"));
                dto.setReserv_start(rs.getString("reserv_start"));
                dto.setReserv_end(rs.getString("reserv_end"));
                dto.setReserv_daycount(rs.getInt("reserv_daycount"));
                dto.setReserv_basic_price(rs.getInt("reserv_basic_price"));
                dto.setReserv_option1_name(rs.getString("reserv_option1_name"));
                dto.setReserv_option1_price(rs.getInt("reserv_option1_price"));
                dto.setReserv_option2_name(rs.getString("reserv_option2_name"));
                dto.setReserv_option2_price(rs.getInt("reserv_option2_price"));
                dto.setReserv_option3_name(rs.getString("reserv_option3_name"));
                dto.setReserv_option3_price(rs.getInt("reserv_option3_price"));
                dto.setReserv_total_price(rs.getInt("reserv_total_price"));
                dto.setReserv_people_adult(rs.getInt("reserv_people_adult"));
                dto.setReserv_people_kid(rs.getInt("reserv_people_kid"));
                dto.setReserv_people_baby(rs.getInt("reserv_people_baby"));
                dto.setReserv_pickup(rs.getString("reserv_pickup"));
                dto.setReserv_date(rs.getString("reserv_date"));

                if(rs.getString("reserv_request") != null){
                    dto.setReserv_request(rs.getString("reserv_request").replace("\n", "<br />"));
                }


                // 현재 상태 설정
                String reservClass = "";
                if(rs.getString("reserv_status").equals("cancel")){
                    reservClass = "cancel";

                }else{
                    // 현재 날짜
                    Date get_today = new Date();
                    DateFormat todayFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

                    // String 타입으로 날짜 정리
                    String show_today = todayFormat.format(get_today);
                    String show_end = rs.getString("reserv_end");

                    // Date 타입으로 날짜 정리
                    DateFormat chkFormat = new SimpleDateFormat("yyyyMMddHHmmss");
                    Date r_today = chkFormat.parse(show_today.replace("-", "").replace(" ", "").replace(":", ""));
                    Date r_end = chkFormat.parse(show_end.replace("-", "").replace(" ", "").replace(":", ""));

                    if(r_today.compareTo(r_end) > 0){ // 완료된 예약
                        reservClass = "done";
                    }else{
                        reservClass = "come"; // 다가오는 예약
                    }
                }
                dto.setReserv_class(reservClass);


                // 스테이 사진
                String reservStayPhoto = null;
                sql2 = "select * from staykey_stay where stay_no = ?";
                pstmt2 = con.prepareStatement(sql2);
                pstmt2.setInt(1, rs.getInt("reserv_stayno"));
                rs2 = pstmt2.executeQuery();

                while(rs2.next()) {
                    if(rs2.getString("stay_file1") != null){
                        reservStayPhoto = rs2.getString("stay_file1");
                    }else if(rs2.getString("stay_file2") != null){
                        reservStayPhoto = rs2.getString("stay_file2");
                    }else if(rs2.getString("stay_file3") != null){
                        reservStayPhoto = rs2.getString("stay_file3");
                    }else if(rs2.getString("stay_file4") != null){
                        reservStayPhoto = rs2.getString("stay_file4");
                    }else if(rs2.getString("stay_file5") != null){
                        reservStayPhoto = rs2.getString("stay_file5");
                    }
                }
                dto.setReserv_stay_photo(reservStayPhoto);


                // 리뷰 작성여부
                String reservReview = "N";
                int reservReviewRoom = 0;
                sql2 = "select count(*) from staykey_review where review_stayno = ? and review_roomno = ? and review_id = ?";
                pstmt2 = con.prepareStatement(sql2);
                pstmt2.setInt(1, rs.getInt("reserv_stayno"));
                pstmt2.setInt(2, rs.getInt("reserv_roomno"));
                pstmt2.setString(3, id);
                rs2 = pstmt2.executeQuery();

                if(rs2.next() && rs2.getInt(1) > 0) {
                    reservReview = "Y";
                    reservReviewRoom = rs.getInt("reserv_roomno");
                }
                dto.setReserv_review(reservReview);
                dto.setReserv_review_roomno(reservReviewRoom);


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
    // 예약 취소하기 메서드 (사이트)
    // ======================================================
    public int cancelReserv(int reserv_no, String reserv_sess, String reserv_pw, String login_pw) {
        int result = 0;

        try {
            openConn();

            // 로그인 비밀번호 체크
            if(reserv_pw.equals(login_pw)){
                sql = "update staykey_reserv set reserv_status = 'cancel' where reserv_no = ? and reserv_sess = ?";
                pstmt = con.prepareStatement(sql);
                pstmt.setInt(1, reserv_no);
                pstmt.setString(2, reserv_sess);
                result = pstmt.executeUpdate();

            }else{
                result = -1;
            }

        } catch(Exception e) {
            e.printStackTrace();

        } finally {
            closeConn(rs, pstmt, con);
        }

        return result;
    }



}
