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


public class ReviewDAO {
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String sql = null;

    private static ReviewDAO instance;

    private ReviewDAO() {}

    public static ReviewDAO getInstance() {
        if(instance == null) {
            instance = new ReviewDAO();
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
    public int getTotalCount(Map<String, Object> map) {
        int result = 0;

        // 검색용 설정
        String search_sql = " where review_no > 0";
        if (map.get("ps_name") != "" && map.get("ps_name") != null) {
            search_sql += " and review_name like '%" + map.get("ps_name") + "%'";
        }
        if (map.get("ps_id") != "" && map.get("ps_id") != null) {
            search_sql += " and review_id like '%" + map.get("ps_id") + "%'";
        }
        if (map.get("ps_stayname") != "" && map.get("ps_stayname") != null) {
            search_sql += " and review_stayname like '%" + map.get("ps_stayname") + "%'";
        }

        try {
            openConn();

            sql = "select count(*) from staykey_review" + search_sql;
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
    //  후기 전체 리스트 메서드
    // ======================================================
    public List<ReviewDTO> reviewList(int page, int rowsize, Map<String, Object> map) {
        List<ReviewDTO> list = new ArrayList<ReviewDTO>();
        
        int startNo = (page * rowsize) - (rowsize - 1);
        int endNo = (page * rowsize);

        // 검색용 설정
        String search_sql1 = " where review_no > 0";
        String search_sql2 = "";

        if (map.get("ps_name") != "" && map.get("ps_name") != null) {
            search_sql2 += " and review_name like '%" + map.get("ps_name") + "%'";
        }
        if (map.get("ps_id") != "" && map.get("ps_id") != null) {
            search_sql2 += " and review_id like '%" + map.get("ps_id") + "%'";
        }
        if (map.get("ps_stayname") != "" && map.get("ps_stayname") != null) {
            search_sql2 += " and review_stayname like '%" + map.get("ps_stayname") + "%'";
        }
        search_sql1 += search_sql2;

        // 정렬용 설정
        String order_sql = "review_date";
        if (map.get("ps_order").equals("date_desc")) {
            order_sql = "review_date desc";
        } else if (map.get("ps_order").equals("date_asc")) {
            order_sql = "review_date asc";
        }else if (map.get("ps_order").equals("name_desc")) {
            order_sql = "review_stayname desc";
        } else if (map.get("ps_order").equals("name_asc")) {
            order_sql = "review_stayname asc";
        } else if (map.get("ps_order").equals("point_desc")) {
            order_sql = "review_point_total desc";
        } else if (map.get("ps_order").equals("point_asc")) {
            order_sql = "review_point_total asc";
        }else {
            order_sql = "review_date desc";
        }

        try {
            openConn();
            
               sql = "select * from " + "(select row_number() over(order by " + order_sql
                        + ") rnum, b.* from staykey_review b " + search_sql1 + ") " + "where rnum >= ? and rnum <= ?"
                        + search_sql2;
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, startNo);
            pstmt.setInt(2, endNo);
            rs = pstmt.executeQuery();
            
            while(rs.next()) {
                
                ReviewDTO dto = new ReviewDTO();
                
                dto.setReview_no(rs.getInt("review_no"));
                dto.setReview_stayno(rs.getInt("review_stayno"));
                dto.setReview_stayname(rs.getString("review_stayname"));
                dto.setReview_roomno(rs.getInt("review_roomno"));
                dto.setReview_roomname(rs.getString("review_roomname"));
                dto.setReview_point_total(rs.getDouble("review_point_total"));
                dto.setReview_point1(rs.getInt("review_point1"));
                dto.setReview_point2(rs.getInt("review_point2"));
                dto.setReview_point3(rs.getInt("review_point3"));
                dto.setReview_point4(rs.getInt("review_point4"));
                dto.setReview_point5(rs.getInt("review_point5"));
                dto.setReview_point6(rs.getInt("review_point6"));    
                String reviewContent = rs.getString("review_content");      
                if(reviewContent.contains("시발") || reviewContent.contains("미친") || reviewContent.contains("새끼") || reviewContent.contains("시팔")|| reviewContent.contains("미쳤나")) {
                	reviewContent = reviewContent.replace("시발", "***");
                	reviewContent = reviewContent.replace("미친", "***");
                	reviewContent = reviewContent.replace("새끼", "***");
                	reviewContent = reviewContent.replace("시팔", "***");
                	reviewContent = reviewContent.replace("미쳤나", "***");
                }              
                dto.setReview_content(reviewContent);
                dto.setReview_file(rs.getString("review_file"));
                dto.setReview_id(rs.getString("review_id"));
                dto.setReview_pw(rs.getString("review_pw"));
                dto.setReview_name(rs.getString("review_name"));
                dto.setReview_date(rs.getString("review_date"));
                
                list.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeConn(rs, pstmt, con);
        }
        return list;
    }

    
    // ======================================================
    // 리뷰 정보 가져오는 메서드
    // ======================================================
    public ReviewDTO getReviewInfo(int no) {
        ReviewDTO dto = null;
        
        try {
            openConn();
            
            sql = "select * from staykey_review where review_no = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, no);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                dto = new ReviewDTO();
                
                dto.setReview_no(rs.getInt("review_no"));
                dto.setReview_stayno(rs.getInt("review_stayno"));
                dto.setReview_stayname(rs.getString("review_stayname"));
                dto.setReview_roomno(rs.getInt("review_roomno"));
                dto.setReview_roomname(rs.getString("review_roomname"));
                dto.setReview_point_total(rs.getDouble("review_point_total"));
                dto.setReview_point1(rs.getInt("review_point1"));
                dto.setReview_point2(rs.getInt("review_point2"));
                dto.setReview_point3(rs.getInt("review_point3"));
                dto.setReview_point4(rs.getInt("review_point4"));
                dto.setReview_point5(rs.getInt("review_point5"));
                dto.setReview_point6(rs.getInt("review_point6"));
                String reviewContent = rs.getString("review_content").replace("\n", "<br />");      
                if(reviewContent.contains("시발") || reviewContent.contains("미친") || reviewContent.contains("새끼") || reviewContent.contains("시팔")|| reviewContent.contains("미쳤나")) {
                	reviewContent = reviewContent.replace("시발", "***");
                	reviewContent = reviewContent.replace("미친", "***");
                	reviewContent = reviewContent.replace("새끼", "***");
                	reviewContent = reviewContent.replace("시팔", "***");
                	reviewContent = reviewContent.replace("미쳤나", "***");
                }       
                dto.setReview_content(reviewContent);
                dto.setReview_file(rs.getString("review_file"));
                dto.setReview_id(rs.getString("review_id"));
                dto.setReview_pw(rs.getString("review_pw"));
                dto.setReview_name(rs.getString("review_name"));
                dto.setReview_date(rs.getString("review_date"));
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeConn(rs, pstmt, con);
        }
        return dto;
    }
    
    
    

    
    // ======================================================
    // 리뷰 삭제하는 메서드 + 글번호 재정리
    // ======================================================
    public int deleteReview(int no) {
        int result = 0;

        try {
            openConn();

            sql = "delete from staykey_review where review_no = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, no);
            result = pstmt.executeUpdate();

            sql = "update staykey_review set review_no = review_no - 1 where review_no > ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, no);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConn(rs, pstmt, con);
        }
        return result;
    }

    
    // ======================================================
    // 후기를 수정하는 메서드
    // ======================================================
    public int reviewModify(ReviewDTO dto) {
        int result = 0;

        try {
            openConn();
            sql = "update staykey_review set review_stayname = ?, review_roomname = ?, review_point_total = ?, review_point1 = ?, review_point2 = ?, review_point3 = ?, review_point4 = ?, review_point5 = ?, review_point6 = ?, review_content = ?, review_file = ?, review_id = ?, review_name = ? where review_no = ?";
            pstmt = con.prepareStatement(sql);
            
            pstmt.setString(1, dto.getReview_stayname());
            pstmt.setString(2, dto.getReview_roomname());
            pstmt.setDouble(3, dto.getReview_point_total());
            pstmt.setInt(4, dto.getReview_point1());
            pstmt.setInt(5, dto.getReview_point2());
            pstmt.setInt(6, dto.getReview_point3());
            pstmt.setInt(7, dto.getReview_point4());
            pstmt.setInt(8, dto.getReview_point5());
            pstmt.setInt(9, dto.getReview_point6());
            pstmt.setString(10, dto.getReview_content());
            pstmt.setString(11, dto.getReview_file());
            pstmt.setString(12, dto.getReview_id());
            pstmt.setString(13, dto.getReview_name());
            pstmt.setInt(14, dto.getReview_no());
            result = pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConn(pstmt, con);
        }
        return result;
    }




    // ======================================================
    // 숙소 리뷰 목록 가져오기 (사이트)
    // ======================================================
    public List<ReviewDTO> getReviewList(int stay_no) {
        List<ReviewDTO> list = new ArrayList<ReviewDTO>();

        try {
            openConn();

            sql = "select * from staykey_review where review_stayno = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, stay_no);
            rs = pstmt.executeQuery();

            while(rs.next()) {
                ReviewDTO dto = new ReviewDTO();

                dto.setReview_no(rs.getInt("review_no"));
                dto.setReview_stayno(rs.getInt("review_stayno"));
                dto.setReview_stayname(rs.getString("review_stayname"));
                dto.setReview_roomno(rs.getInt("review_roomno"));
                dto.setReview_roomname(rs.getString("review_roomname"));
                dto.setReview_point_total(rs.getDouble("review_point_total"));
                dto.setReview_point1(rs.getInt("review_point1"));
                dto.setReview_point2(rs.getInt("review_point2"));
                dto.setReview_point3(rs.getInt("review_point3"));
                dto.setReview_point4(rs.getInt("review_point4"));
                dto.setReview_point5(rs.getInt("review_point5"));
                dto.setReview_point6(rs.getInt("review_point6"));
                String reviewContent = rs.getString("review_content").replace("\n", "<br />");      
                if(reviewContent.contains("시발") || reviewContent.contains("미친") || reviewContent.contains("새끼") || reviewContent.contains("시팔")|| reviewContent.contains("미쳤나")) {
                	reviewContent = reviewContent.replace("시발", "***");
                	reviewContent = reviewContent.replace("미친", "***");
                	reviewContent = reviewContent.replace("새끼", "***");
                	reviewContent = reviewContent.replace("시팔", "***");
                	reviewContent = reviewContent.replace("미쳤나", "***");
                }      
                dto.setReview_content(reviewContent);
                dto.setReview_file(rs.getString("review_file"));
                dto.setReview_id(rs.getString("review_id"));
                dto.setReview_pw(rs.getString("review_pw"));
                dto.setReview_name(rs.getString("review_name"));
                dto.setReview_date(rs.getString("review_date"));

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
    // 숙소 리뷰 전체 갯수 (사이트)
    // ======================================================
    public int getReviewTotal(int stay_no) {
        int result = 0;

        try {
            openConn();

            sql = "select count(*) from staykey_review where review_stayno = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, stay_no);
            rs = pstmt.executeQuery();

            if (rs.next()) result = rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();

        } finally {
            closeConn(rs, pstmt, con);
        }

        return result;
    }



    // ======================================================
    // 숙소 리뷰 전체 합계평점 (사이트)
    // ======================================================
    public double getReviewTotalPoint(int stay_no) {
        double result = 0;

        try {
            openConn();

            sql = "select count(*) as total_count, sum(review_point_total) as total_sum from staykey_review where review_stayno = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, stay_no);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                result = rs.getDouble("total_sum") / rs.getInt("total_count");
            }

        } catch (Exception e) {
            e.printStackTrace();

        } finally {
            closeConn(rs, pstmt, con);
        }

        return result;
    }



    // ======================================================
    // 숙소 리뷰 전체 개별평점 (사이트)
    // ======================================================
    public double getReviewEachPoint(int stay_no, int point) {
        double result = 0;

        try {
            openConn();

            sql = "select count(*) as total_count, sum(review_point" + point + ") as sum_point" + point + " from staykey_review where review_stayno = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, stay_no);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                result = rs.getDouble("sum_point"+point) / rs.getInt("total_count");
            }

        } catch (Exception e) {
            e.printStackTrace();

        } finally {
            closeConn(rs, pstmt, con);
        }

        return result;
    }
    




    // ======================================================
    // 후기 등록 하는 메서드
    // ======================================================
    public String writeReview(ReviewDTO dto) {
        String result = null;
        int count = 0;

        try {
            openConn();

            sql = "select max(review_no) from staykey_review";
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();

            if(rs.next()) count = rs.getInt(1) + 1;

            sql = "insert into staykey_review values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, sysdate)";
            pstmt = con.prepareStatement(sql);

            pstmt.setInt(1, count);
            pstmt.setInt(2, dto.getReview_stayno());
            pstmt.setString(3, dto.getReview_stayname());
            pstmt.setInt(4, dto.getReview_roomno());
            pstmt.setString(5, dto.getReview_roomname());
            pstmt.setDouble(6, dto.getReview_point_total());
            pstmt.setInt(7, dto.getReview_point1());
            pstmt.setInt(8, dto.getReview_point2());
            pstmt.setInt(9, dto.getReview_point3());
            pstmt.setInt(10, dto.getReview_point4());
            pstmt.setInt(11, dto.getReview_point5());
            pstmt.setInt(12, dto.getReview_point6());
            pstmt.setString(13, dto.getReview_content());
            pstmt.setString(14, dto.getReview_file());
            pstmt.setString(15, dto.getReview_id());
            pstmt.setString(16, dto.getReview_pw());
            pstmt.setString(17, dto.getReview_name());

            int res = pstmt.executeUpdate();
            result = res + "/" + count;

        } catch (Exception e) {
            e.printStackTrace();

        } finally {
            closeConn(rs, pstmt, con);
        }

        return result;
    }


    
}
