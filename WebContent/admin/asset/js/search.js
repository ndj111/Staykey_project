/**
 * customer 테이블을 이용한 Ajax 실습
 */

$(function() {
	
	
	// 여러 ajax에서 동일하게 사용되는 속성 설정.
	$.ajaxSetup({
		ContentType : "application/x-www-form-urlencoded;charset=UTF-8",
		type : "post"
	});
	
	
	// 모든 데이터를 가져오는 함수
	// customer 테이블에서 전체 데이터를 가져오는 함수
	function getData() {
		$.ajax({
			url : "../com.admin.action/search.do",
			datatype : "xml",   // 결과 데이터 타입
			success : function(data) {
				// 테이블 태그의 첫번째 행(타이틀(제목) 태그)을
				// 제외하고 나머지 모든 행을 제거하라는 명령어.
				$("#listTable tr:gt(0)").remove();
				
				let table = "";
				
				$(data).find("staykey_stay").each(function() {
					table += "<tr>";
					
					table += "<td>"+$(this).find("stay_no").text()+"</td>";
					table += "<td>"+$(this).find("stay_name").text()+"</td>";
					table += "<td></td>";
					
					table += "</tr>";
				});
				
				// 테이블의 첫번째 행의 아래에 table을 추가
				$("#listTable tr:eq(0)").after(table);
			},
			
			error : function() {
				alert("데이터 통신 에러");
			}
		});
		
	}  // getData() 함수 end
	
	


	getData();
	

});
