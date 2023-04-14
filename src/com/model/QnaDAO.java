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




public class QnaDAO {
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String sql = null;

    private static QnaDAO instance;

    private QnaDAO() {}

    public static QnaDAO getInstance() {
        if(instance == null) {
            instance = new QnaDAO();
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
        String search_sql = " where bbs_no > 0";
        if (map.get("ps_name") != "" && map.get("ps_name") != null) {
            search_sql += " and bbs_writer_name like '%" + map.get("ps_name") + "%'";
        }
        if (map.get("ps_id") != "" && map.get("ps_id") != null) {
            search_sql += " and bbs_writer_id like '%" + map.get("ps_id") + "%'";
        }
        if (map.get("ps_title") != "" && map.get("ps_title") != null) {
            search_sql += " and bbs_title like '%" + map.get("ps_title") + "%'";
        }


        try {
            openConn();

            sql = "select count(*) from staykey_qna" + search_sql;
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();

            if(rs.next()) result = rs.getInt(1);

        } catch(Exception e) {
            e.printStackTrace();

        } finally {
            closeConn(rs, pstmt, con);
        }

        return result;
    }




    // ======================================================
    // 문의 목록 메서드
    // ======================================================
    public List<QnaDTO> qnaList(int page, int rowsize, Map<String, Object> map) {
        List<QnaDTO> list = new ArrayList<QnaDTO>();

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

        search_sql1 += search_sql2;

        // 정렬용 설정
        String order_sql = "bbs_date";
        if (map.get("ps_order").equals("register_desc")) {
            order_sql = "bbs_date desc";
        } else if (map.get("ps_order").equals("register_asc")) {
            order_sql = "bbs_date asc";
        } else if (map.get("ps_order").equals("id_desc")) {
            order_sql = "bbs_writer_id desc";
        } else if (map.get("ps_order").equals("id_asc")) {
            order_sql = "bbs_writer_id asc";
        } else if (map.get("ps_order").equals("name_desc")) {
            order_sql = "bbs_writer_name desc";
        } else if (map.get("ps_order").equals("name_asc")) {
            order_sql = "bbs_writer_name asc";
        } else if (map.get("ps_order").equals("hit_desc")) {
            order_sql = "bbs_hit desc";
        } else if (map.get("ps_order").equals("hit_asc")) {
            order_sql = "bbs_hit asc";
        }

        try {
        	
            openConn();

            sql = "select * from " + "(select row_number() over(order by " + order_sql
                    + ") rnum, b.* from staykey_qna b " + search_sql1 + ") " + "where rnum >= ? and rnum <= ?"
                    + search_sql2;
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, startNo);
            pstmt.setInt(2, endNo);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                QnaDTO dto = new QnaDTO();

                dto.setBbs_no(rs.getInt("bbs_no"));
                dto.setBbs_status(rs.getString("bbs_status"));
                dto.setBbs_title(rs.getString("bbs_title"));
                dto.setBbs_content(rs.getString("bbs_content"));
                dto.setBbs_file1(rs.getString("bbs_file1"));
                dto.setBbs_file2(rs.getString("bbs_file2"));
                dto.setBbs_hit(rs.getInt("bbs_hit"));
                dto.setBbs_comment(rs.getInt("bbs_comment"));
                dto.setBbs_writer_name(rs.getString("bbs_writer_name"));
                dto.setBbs_writer_id(rs.getString("bbs_writer_id"));
                dto.setBbs_writer_pw(rs.getString("bbs_writer_pw"));
                dto.setBbs_date(rs.getString("bbs_date"));
                
                list.add(dto);
            }
            closeConn(rs, pstmt, con);

        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
		}
        return list;
    }



    // ======================================================
    // 문의글 정보 가져오는 메서드
    // ======================================================
    public QnaDTO getQnaInfo(int no) {
    	QnaDTO dto = null;

        try {
            openConn();

            sql = "select * from staykey_qna where bbs_no = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, no);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                dto = new QnaDTO();

                dto.setBbs_no(rs.getInt("bbs_no"));
                dto.setBbs_status(rs.getString("bbs_status"));
                dto.setBbs_title(rs.getString("bbs_title"));
                dto.setBbs_content(rs.getString("bbs_content"));
                dto.setBbs_file1(rs.getString("bbs_file1"));
                dto.setBbs_file2(rs.getString("bbs_file2"));
                dto.setBbs_hit(rs.getInt("bbs_hit"));
                dto.setBbs_comment(rs.getInt("bbs_comment"));
                dto.setBbs_writer_name(rs.getString("bbs_writer_name"));
                dto.setBbs_writer_id(rs.getString("bbs_writer_id"));
                dto.setBbs_writer_pw(rs.getString("bbs_writer_pw"));
                dto.setBbs_date(rs.getString("bbs_date"));
            }
            closeConn(rs, pstmt, con);

        } catch (Exception e) {
            e.printStackTrace();
        }finally {
        }

        return dto;
    }

    // ======================================================
    // 문의글 삭제하는 메서드 + 글번호 재작업
    // ======================================================
    public int deleteQna(int no) {
        int result = 0;

        try {
            openConn();

            sql = "delete from staykey_qna where bbs_no = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, no);
            result = pstmt.executeUpdate();

            sql = "update staykey_qna set bbs_no = bbs_no - 1 where bbs_no > ?";
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
    // 문의글 상태 수정 메서드
    // ======================================================
    public int statusModify(QnaDTO dto) {
        int result = 0;

        try {
            openConn();
            sql = "update staykey_qna set bbs_status = ? where bbs_no = ?";
            pstmt = con.prepareStatement(sql);

            pstmt.setString(1, dto.getBbs_status());
            pstmt.setInt(2, dto.getBbs_no());

            result = pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConn(pstmt, con);
        }
        return result;
    }
   
    







    // ======================================================
    // 마이페이지 회원 문의글 데이터 갯수 메서드
    // ======================================================
    public int getQnaTotalCount(String member_id) {
        int result = 0;

        try {
            openConn();

            sql = "select count(*) from staykey_qna where bbs_writer_id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, member_id);
            rs = pstmt.executeQuery();

            if(rs.next()) result = rs.getInt(1);

        } catch(Exception e) {
            e.printStackTrace();

        } finally {
            closeConn(rs, pstmt, con);
        }

        return result;
    }



    // ======================================================
    // 마이페이지 회원 문의글 목록 메서드
    // ======================================================
    public List<QnaDTO> getQnaList(int page, int rowsize, String member_id) {
        List<QnaDTO> list = new ArrayList<QnaDTO>();

        int startNo = (page * rowsize) - (rowsize - 1);
        int endNo = (page * rowsize);

        try {
            openConn();

            sql = "select * from (select row_number() over(order by bbs_date desc) rnum, b.* from staykey_qna b where bbs_writer_id = ?) where rnum >= ? and rnum <= ? and bbs_writer_id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, member_id);
            pstmt.setInt(2, startNo);
            pstmt.setInt(3, endNo);
            pstmt.setString(4, member_id);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                QnaDTO dto = new QnaDTO();
                dto.setBbs_no(rs.getInt("bbs_no"));
                dto.setBbs_status(rs.getString("bbs_status"));
                dto.setBbs_title(rs.getString("bbs_title"));
                dto.setBbs_content(rs.getString("bbs_content"));
                dto.setBbs_file1(rs.getString("bbs_file1"));
                dto.setBbs_file2(rs.getString("bbs_file2"));
                dto.setBbs_hit(rs.getInt("bbs_hit"));
                dto.setBbs_comment(rs.getInt("bbs_comment"));
                dto.setBbs_writer_name(rs.getString("bbs_writer_name"));
                dto.setBbs_writer_pw(rs.getString("bbs_writer_pw"));
                dto.setBbs_date(rs.getString("bbs_date"));
                dto.setBbs_writer_id(rs.getString("bbs_writer_id"));

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
    // 문의글 등록 메서드
    // ======================================================
    public String registerQna(QnaDTO dto) {
        String result = null;
        int count = 0;

        try {
            openConn();

            sql = "select max(bbs_no) from staykey_qna";
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1) + 1;
            }
            
            sql = "insert into staykey_qna values(?, default, ?, ?, ?, ?, default, default, ?, ?, ?, sysdate)";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, count);
            pstmt.setString(2, dto.getBbs_title());
            pstmt.setString(3, dto.getBbs_content());
            pstmt.setString(4, dto.getBbs_file1());
            pstmt.setString(5, dto.getBbs_file2());
            pstmt.setString(6, dto.getBbs_writer_name());
            pstmt.setString(7, dto.getBbs_writer_id());
            pstmt.setString(8, dto.getBbs_writer_pw());

            int res = pstmt.executeUpdate();
            result = res + "/" + count;

        } catch (SQLException e) {
            e.printStackTrace();

        } finally {
            closeConn(rs, pstmt, con);
        }

        return result;
    }





    // ======================================================
    // 문의글 수정 메서드
    // ======================================================
    public int modifyQna(QnaDTO dto) {
        int result = 0;

        try {
            openConn();

            sql = "update staykey_qna set bbs_title = ?, bbs_content = ?, bbs_file1 = ?, bbs_file2 = ? where bbs_no = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, dto.getBbs_title());
            pstmt.setString(2, dto.getBbs_content());
            pstmt.setString(3, dto.getBbs_file1());
            pstmt.setString(4, dto.getBbs_file2());
            pstmt.setInt(5, dto.getBbs_no());
            result = pstmt.executeUpdate();

        } catch(Exception e) {
            e.printStackTrace();

        } finally {
            closeConn(pstmt, con);
        }

        return result;
    }
    




    // ======================================================
    // 문의글 조회수 늘리기 메서드
    // ======================================================
    public void plusQnaCount(int bbs_no) {
        try {
            openConn();

            sql = "update staykey_qna set bbs_hit = bbs_hit + 1 where bbs_no = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, bbs_no);
            pstmt.executeUpdate();

        } catch(Exception e) {
            e.printStackTrace();

        } finally {
            closeConn(pstmt, con);
        }
    }





    // ======================================================
    // 문의글에 등록된 댓글 전부 삭제 메서드
    // ======================================================
    public void deleteQnaCommentAll(int bbs_no) {
        try {
            openConn();

            sql = "delete from staykey_qna_comment where comment_qnano = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, bbs_no);
            pstmt.executeUpdate();

        } catch(Exception e) {
            e.printStackTrace();

        } finally {
            closeConn(pstmt, con);
        }
    }


}
