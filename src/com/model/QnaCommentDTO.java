package com.model;

public class QnaCommentDTO {
    private int comment_no;
    private int comment_qnano;
    private String comment_content;
    private String comment_writer_name;
    private String comment_writer_id;
    private String comment_writer_pw;
    private String comment_date;


    public int getComment_no() {
        return comment_no;
    }
    public void setComment_no(int comment_no) {
        this.comment_no = comment_no;
    }
    public int getComment_qnano() {
		return comment_qnano;
	}
	public void setComment_qnano(int comment_qnano) {
		this.comment_qnano = comment_qnano;
	}
	public String getComment_content() {
        return comment_content;
    }
    public void setComment_content(String comment_content) {
        this.comment_content = comment_content;
    }
    public String getComment_writer_name() {
        return comment_writer_name;
    }
    public void setComment_writer_name(String comment_writer_name) {
        this.comment_writer_name = comment_writer_name;
    }
    public String getComment_writer_id() {
        return comment_writer_id;
    }
    public void setComment_writer_id(String comment_writer_id) {
        this.comment_writer_id = comment_writer_id;
    }
    public String getComment_writer_pw() {
        return comment_writer_pw;
    }
    public void setComment_writer_pw(String comment_writer_pw) {
        this.comment_writer_pw = comment_writer_pw;
    }
    public String getComment_date() {
        return comment_date;
    }
    public void setComment_date(String comment_date) {
        this.comment_date = comment_date;
    }
}
