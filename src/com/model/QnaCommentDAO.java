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




public class QnaCommentDAO {
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String sql = null;

    private static QnaCommentDAO instance;

    private QnaCommentDAO() {}

    public static QnaCommentDAO getInstance() {
        if(instance == null) {
            instance = new QnaCommentDAO();
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

        try {
            openConn();

            sql = "select count(*) from staykey_qna_comment";
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
    // 문의글 댓글 정보 가져오는 메서드
    // ======================================================
    public List<QnaCommentDTO> getQnaCommentInfo(int no) {
    	List<QnaCommentDTO> list = new ArrayList<QnaCommentDTO>();

        try {
            openConn();

            sql = "select * from staykey_qna_comment where comment_qnano = ? order by comment_date asc";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, no);
            rs = pstmt.executeQuery();
            

            while (rs.next()) {
            	QnaCommentDTO commemtDto = new QnaCommentDTO();
            	
            	commemtDto.setComment_no(rs.getInt("comment_no"));
            	commemtDto.setComment_qnano(rs.getInt("comment_qnano"));
            	commemtDto.setComment_content(rs.getString("comment_content").replace("\n", "<br />"));
            	commemtDto.setComment_writer_name(rs.getString("comment_writer_name"));
            	commemtDto.setComment_writer_id(rs.getString("comment_writer_id"));
            	commemtDto.setComment_writer_pw(rs.getString("comment_writer_pw"));
                commemtDto.setComment_date(rs.getString("comment_date"));
                
                list.add(commemtDto);
            }

        } catch (SQLException e) {
            e.printStackTrace();

        } finally {
            closeConn(rs, pstmt, con);
        }

        return list;
    }

    // ======================================================
    // 답변 등록 메서드
    // ======================================================
    public int registerComment(QnaCommentDTO dto) {
        int result = 0, count = 0;

        try {
            openConn();

            sql = "select max(comment_no) from staykey_qna_comment";
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1) + 1;
            }
            sql = "insert into staykey_qna_comment values(?, ?, ?, ?, ?, ?, sysdate)";
            pstmt = con.prepareStatement(sql);

            pstmt.setInt(1, count);
            pstmt.setInt(2, dto.getComment_qnano());
            pstmt.setString(3, dto.getComment_content());
            pstmt.setString(4, dto.getComment_writer_name());
            pstmt.setString(5, dto.getComment_writer_id());
            pstmt.setString(6, dto.getComment_writer_pw());

            result = pstmt.executeUpdate();


            sql = "update staykey_qna set bbs_comment = bbs_comment + 1 where bbs_no = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, dto.getComment_qnano());
            pstmt.executeUpdate();


        } catch (SQLException e) {
            e.printStackTrace();

        } finally {
            closeConn(rs, pstmt, con);
        }

        return result;
    }


    // ======================================================
    // 답변 삭제 + 글번호 재작업 메서드
    // ======================================================

    public int deleteComment(int qna_no, int comment_no) {
        int result = 0;

        try {
            openConn();

            sql = "delete from staykey_qna_comment where comment_no = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, comment_no);
            result = pstmt.executeUpdate();

            sql = "update staykey_qna_comment set comment_no = comment_no - 1 where comment_no > ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, comment_no);
            pstmt.executeUpdate();

            sql = "update staykey_qna set bbs_comment = bbs_comment - 1 where bbs_no = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, qna_no);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();

        } finally {
            closeConn(rs, pstmt, con);
        }

        return result;
    }

    


    // ======================================================
    // 댓글 정보 가져오는 메서드
    // ======================================================
    public QnaCommentDTO getCommentInfo(int no) {
    	QnaCommentDTO dto = null;

        try {
            openConn();

            sql = "select * from staykey_qna_comment where comment_no = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, no);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                dto = new QnaCommentDTO();
                
                dto.setComment_no(rs.getInt("comment_no"));
                dto.setComment_qnano(rs.getInt("comment_qnano"));
                dto.setComment_content(rs.getString("comment_content"));
                dto.setComment_writer_name(rs.getString("comment_writer_name"));
                dto.setComment_writer_id(rs.getString("comment_writer_pw"));
                dto.setComment_date(rs.getString("comment_date"));
                
            }

        } catch (SQLException e) {
            e.printStackTrace();

        } finally {
            closeConn(rs, pstmt, con);
        }

        return dto;
    }

    

    // ======================================================
    // 댓글을 업데이트 하는 메서드
    // ======================================================
    public int commentModify(QnaCommentDTO dto) {
        int result = 0;

        try {
            openConn();
            sql = "update staykey_qna_comment set comment_content = ? where comment_no = ?";
            pstmt = con.prepareStatement(sql);

            pstmt.setString(1, dto.getComment_content());
            pstmt.setInt(2, dto.getComment_no());

            result = pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConn(pstmt, con);
        }
        return result;
    }
    
   

}
