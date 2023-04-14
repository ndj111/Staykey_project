package com.model;

public class StayRoomDTO {
                                            
		private int room_no;                // 방 번호
		private int room_stayno;            // 숙소번호(Stay와 연결)
		private String room_name;           // 방이름
		private String room_desc;           // description
		private String room_type;           // 방 타입
		private int room_price;             // 숙박비
		private String room_checkin;        // 체크인 시간
		private String room_checkout;       // 체크아웃 시간
		private int room_people_min;        // 투숙 최소 인원
		private int room_people_max;        // 최대 인원
		private int room_size;              // 소수점 없는 방사이즈
		private String room_bed;            // 침대 정보
		private String room_features;       // 특징1~5('/'로 tokenizing)
		private String room_amenities;      // 어메니티1~(위와 동일)
		private String room_service;        // 서비스1~(위와 동일)
		private String room_photo1;         // 룸사진1
		private String room_photo2;         // 룸사진2
		private String room_photo3;         // 룸사진3
		private String room_photo4;         // 룸사진4
		private String room_photo5;         // 룸사진5
		private String room_tag;            // 룸 태그
		
		public int getRoom_no() {
			return room_no;
		}
		public void setRoom_no(int room_no) {
			this.room_no = room_no;
		}
		public int getRoom_stayno() {
			return room_stayno;
		}
		public void setRoom_stayno(int room_stayno) {
			this.room_stayno = room_stayno;
		}
		public String getRoom_type() {
            return room_type;
        }
        public void setRoom_type(String room_type) {
            this.room_type = room_type;
        }
        public int getRoom_price() {
            return room_price;
        }
        public void setRoom_price(int room_price) {
            this.room_price = room_price;
        }
        public String getRoom_bed() {
            return room_bed;
        }
        public void setRoom_bed(String room_bed) {
            this.room_bed = room_bed;
        }
        public String getRoom_tag() {
            return room_tag;
        }
        public void setRoom_tag(String room_tag) {
            this.room_tag = room_tag;
        }
        public String getRoom_name() {
			return room_name;
		}
		public void setRoom_name(String room_name) {
			this.room_name = room_name;
		}
		public String getRoom_desc() {
			return room_desc;
		}
		public void setRoom_desc(String room_desc) {
			this.room_desc = room_desc;
		}
		public String getRoom_checkin() {
			return room_checkin;
		}
		public void setRoom_checkin(String room_checkin) {
			this.room_checkin = room_checkin;
		}
		public String getRoom_checkout() {
			return room_checkout;
		}
		public void setRoom_checkout(String room_checkout) {
			this.room_checkout = room_checkout;
		}
		public int getRoom_people_min() {
			return room_people_min;
		}
		public void setRoom_people_min(int room_people_min) {
			this.room_people_min = room_people_min;
		}
		public int getRoom_people_max() {
			return room_people_max;
		}
		public void setRoom_people_max(int room_people_max) {
			this.room_people_max = room_people_max;
		}
		public int getRoom_size() {
			return room_size;
		}
		public void setRoom_size(int room_size) {
			this.room_size = room_size;
		}
		public String getRoom_features() {
			return room_features;
		}
		public void setRoom_features(String room_features) {
			this.room_features = room_features;
		}
		public String getRoom_amenities() {
			return room_amenities;
		}
		public void setRoom_amenities(String room_amenities) {
			this.room_amenities = room_amenities;
		}
		public String getRoom_service() {
			return room_service;
		}
		public void setRoom_service(String room_service) {
			this.room_service = room_service;
		}
		public String getRoom_photo1() {
			return room_photo1;
		}
		public void setRoom_photo1(String room_photo1) {
			this.room_photo1 = room_photo1;
		}
		public String getRoom_photo2() {
			return room_photo2;
		}
		public void setRoom_photo2(String room_photo2) {
			this.room_photo2 = room_photo2;
		}
		public String getRoom_photo3() {
			return room_photo3;
		}
		public void setRoom_photo3(String room_photo3) {
			this.room_photo3 = room_photo3;
		}
		public String getRoom_photo4() {
			return room_photo4;
		}
		public void setRoom_photo4(String room_photo4) {
			this.room_photo4 = room_photo4;
		}
		public String getRoom_photo5() {
			return room_photo5;
		}
		public void setRoom_photo5(String room_photo5) {
			this.room_photo5 = room_photo5;
		}
		                                    
}
