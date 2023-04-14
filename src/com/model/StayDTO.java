package com.model;

public class StayDTO {
	                                      
		private int stay_no;				  // 숙소 고유번호
		private String stay_type;             // 숙소 타입
		private String stay_name;             // 숙소명
		private String stay_desc;             // 숙소 간략 설명/description
		private String stay_location;         // 위치
		private String stay_addr;             // 주소
		private String stay_phone;            // 연락처
		private String stay_email;            // 이메일
		private String stay_content1;         // 내용1
		private String stay_content2;         // 내용2
		private String stay_content3;         // 내용3
		private String stay_info1;            // 안내사항1
		private String stay_info2;            // 안내사항2
		private String stay_info3;            // 안내사항3
		private String stay_file1;            // 사진1
		private String stay_file2;            // 사진2
		private String stay_file3;            // 사진3
		private String stay_file4;            // 사진4
		private String stay_file5;            // 사진5
		private String stay_option1_name;     // 결제하기 클릭 시 추가옵션1
		private int stay_option1_price;       // 36개월 이하 유아 인원 추가
		private String stay_option1_desc;     // 
		private String stay_option1_photo;    //
		private String stay_option2_name;     //
		private int stay_option2_price;       // 추가옵션2 - 바베큐
		private String stay_option2_desc;     //
		private String stay_option2_photo;    //
		private String stay_option3_name;     // 추가옵션3 - 조식
		private int stay_option3_price;       // 
		private String stay_option3_desc;     //
		private String stay_option3_photo;    //
		private int stay_hit;                 // 조회수(정렬 위한)
		private int stay_reserv;              // 예약수
		private String stay_date;             // 투숙일자

		private int stay_room_price_min;      // 룸 가격 최저
		private int stay_room_price_max;      // 룸 가격 최고
		private int stay_room_people_min;     // 최소 인원수
		private int stay_room_people_max;     // 최대 인원수

		private String stay_wish_check;       // 찜목록 체크

		
		public int getStay_no() {
			return stay_no;
		}
		public String getStay_type() {
            return stay_type;
        }
        public void setStay_type(String stay_type) {
            this.stay_type = stay_type;
        }
        public void setStay_no(int stay_no) {
			this.stay_no = stay_no;
		}
		public String getStay_name() {
			return stay_name;
		}
		public void setStay_name(String stay_name) {
			this.stay_name = stay_name;
		}
		public String getStay_desc() {
			return stay_desc;
		}
		public void setStay_desc(String stay_desc) {
			this.stay_desc = stay_desc;
		}
		public String getStay_location() {
			return stay_location;
		}
		public void setStay_location(String stay_location) {
			this.stay_location = stay_location;
		}
        public String getStay_addr() {
            return stay_addr;
        }
        public void setStay_addr(String stay_addr) {
            this.stay_addr = stay_addr;
        }
        public String getStay_phone() {
            return stay_phone;
        }
        public void setStay_phone(String stay_phone) {
            this.stay_phone = stay_phone;
        }
        public String getStay_email() {
            return stay_email;
        }
        public void setStay_email(String stay_email) {
            this.stay_email = stay_email;
        }
		public String getStay_content1() {
			return stay_content1;
		}
		public void setStay_content1(String stay_content1) {
			this.stay_content1 = stay_content1;
		}
		public String getStay_content2() {
			return stay_content2;
		}
		public void setStay_content2(String stay_content2) {
			this.stay_content2 = stay_content2;
		}
		public String getStay_content3() {
			return stay_content3;
		}
		public void setStay_content3(String stay_content3) {
			this.stay_content3 = stay_content3;
		}
		public String getStay_info1() {
			return stay_info1;
		}
		public void setStay_info1(String stay_info1) {
			this.stay_info1 = stay_info1;
		}
		public String getStay_info2() {
			return stay_info2;
		}
		public void setStay_info2(String stay_info2) {
			this.stay_info2 = stay_info2;
		}
		public String getStay_info3() {
			return stay_info3;
		}
		public void setStay_info3(String stay_info3) {
			this.stay_info3 = stay_info3;
		}
		public String getStay_file1() {
			return stay_file1;
		}
		public void setStay_file1(String stay_file1) {
			this.stay_file1 = stay_file1;
		}
		public String getStay_file2() {
			return stay_file2;
		}
		public void setStay_file2(String stay_file2) {
			this.stay_file2 = stay_file2;
		}
		public String getStay_file3() {
			return stay_file3;
		}
		public void setStay_file3(String stay_file3) {
			this.stay_file3 = stay_file3;
		}
		public String getStay_file4() {
			return stay_file4;
		}
		public void setStay_file4(String stay_file4) {
			this.stay_file4 = stay_file4;
		}
		public String getStay_file5() {
			return stay_file5;
		}
		public void setStay_file5(String stay_file5) {
			this.stay_file5 = stay_file5;
		}
		public String getStay_option1_name() {
			return stay_option1_name;
		}
		public void setStay_option1_name(String stay_option1_name) {
			this.stay_option1_name = stay_option1_name;
		}
		public int getStay_option1_price() {
			return stay_option1_price;
		}
		public void setStay_option1_price(int stay_option1_price) {
			this.stay_option1_price = stay_option1_price;
		}
		public String getStay_option1_desc() {
			return stay_option1_desc;
		}
		public void setStay_option1_desc(String stay_option1_desc) {
			this.stay_option1_desc = stay_option1_desc;
		}
		public String getStay_option1_photo() {
			return stay_option1_photo;
		}
		public void setStay_option1_photo(String stay_option1_photo) {
			this.stay_option1_photo = stay_option1_photo;
		}
		public String getStay_option2_name() {
			return stay_option2_name;
		}
		public void setStay_option2_name(String stay_option2_name) {
			this.stay_option2_name = stay_option2_name;
		}
		public int getStay_option2_price() {
			return stay_option2_price;
		}
		public void setStay_option2_price(int stay_option2_price) {
			this.stay_option2_price = stay_option2_price;
		}
		public String getStay_option2_desc() {
			return stay_option2_desc;
		}
		public void setStay_option2_desc(String stay_option2_desc) {
			this.stay_option2_desc = stay_option2_desc;
		}
		public String getStay_option2_photo() {
			return stay_option2_photo;
		}
		public void setStay_option2_photo(String stay_option2_photo) {
			this.stay_option2_photo = stay_option2_photo;
		}
		public String getStay_option3_name() {
			return stay_option3_name;
		}
		public void setStay_option3_name(String stay_option3_name) {
			this.stay_option3_name = stay_option3_name;
		}
		public int getStay_option3_price() {
			return stay_option3_price;
		}
		public void setStay_option3_price(int stay_option3_price) {
			this.stay_option3_price = stay_option3_price;
		}
		public String getStay_option3_desc() {
			return stay_option3_desc;
		}
		public void setStay_option3_desc(String stay_option3_desc) {
			this.stay_option3_desc = stay_option3_desc;
		}
		public String getStay_option3_photo() {
			return stay_option3_photo;
		}
		public void setStay_option3_photo(String stay_option3_photo) {
			this.stay_option3_photo = stay_option3_photo;
		}
		public int getStay_hit() {
			return stay_hit;
		}
		public void setStay_hit(int stay_hit) {
			this.stay_hit = stay_hit;
		}
		public int getStay_reserv() {
			return stay_reserv;
		}
		public void setStay_reserv(int stay_reserv) {
			this.stay_reserv = stay_reserv;
		}
		public String getStay_date() {
			return stay_date;
		}
		public void setStay_date(String stay_date) {
			this.stay_date = stay_date;
		}

		
		public int getStay_room_price_min() {
            return stay_room_price_min;
        }
        public void setStay_room_price_min(int stay_room_price_min) {
            this.stay_room_price_min = stay_room_price_min;
        }
        public int getStay_room_price_max() {
            return stay_room_price_max;
        }
        public void setStay_room_price_max(int stay_room_price_max) {
            this.stay_room_price_max = stay_room_price_max;
        }
        public int getStay_room_people_min() {
            return stay_room_people_min;
        }
        public void setStay_room_people_min(int stay_room_people_min) {
            this.stay_room_people_min = stay_room_people_min;
        }
        public int getStay_room_people_max() {
            return stay_room_people_max;
        }
        public void setStay_room_people_max(int stay_room_people_max) {
            this.stay_room_people_max = stay_room_people_max;
        }
        public String getStay_wish_check() {
            return stay_wish_check;
        }
        public void setStay_wish_check(String stay_wish_check) {
            this.stay_wish_check = stay_wish_check;
        }

                  
}                                         
