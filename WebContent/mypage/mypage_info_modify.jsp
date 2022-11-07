<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../layout/layout_header.jsp" />
<jsp:include page="../mypage/mypage_header.jsp" />

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="dto" value="${member}" />

<script type="text/javascript">$("#mymenu-info").addClass("now");</script>

    

<div class="info-modify">

	<h3 class="im-title">회원 정보 수정</h3>


    <form name="modify_form" method="post" enctype="multipart/form-data" action="<%=request.getContextPath()%>/mypageInfoOk.do" onsubmit="return validateForm(this);">
    <fieldset class="im-wrap">
        <legend>회원 정보 수정</legend>

		<div class="im-photo">
			<div class="imp-tit">프로필 사진</div>
			<div class="imp-show"<c:if test="${!empty dto.member_photo}"> style="background-image: url('<%=request.getContextPath()%>${dto.member_photo}');"</c:if>>profile photo</div>
			<input type="file" name="modify_photo" title="프로필 사진" class="imp-file" accept="image/jpeg, image/png, image/gif" />
		</div>



        <div class="im-form">
            <div>
                <label for="join_id">아이디</label>
                <input type="text" name="modify_id" value="${dto.member_id}" readonly="readonly" />
            </div>

            <div>
                <label for="modify_pw">비밀번호 변경</label>
                <input type="password" name="modify_pw" id="modify_pw" placeholder="변경할 비밀번호를 입력하세요." />
                <ul class="checked">
                    <li>영문</li>
                    <li>숫자</li>
                    <li>특수문자</li>
                    <li>8자 이상 20자 이하</li>
                </ul>
            </div>

            <div>
                <input type="password" name="modify_pw_re" placeholder="변경할 비밀번호를 확인해 주세요." />
                <p class="error">비밀번호가 일치하지 않습니다.</p>
            </div>

            <div>
                <label for="modify_name">이름</label>
                <input type="text" name="modify_name" id="modify_name" value="${dto.member_name}" placeholder="이름을 입력하세요." required />
                <p class="error">1자 이상 10자 이하로 입력해 주세요.</p>
            </div>

            <div>
                <label for="modify_email">이메일</label>
                <input type="email" name="modify_email" id="modify_email" value="${dto.member_email}" placeholder="이메일을 입력하세요." required />
                <p class="error">잘못된 이메일 형식입니다.</p>
            </div>

            <div>
                <label for="modify_phone">전화번호</label>
                <input type="text" name="modify_phone" id="modify_phone" value="${dto.member_phone}" placeholder="전화번호를 입력하세요." required />
                <p class="error">잘못된 전화번호 형식입니다.</p>
            </div>

            <div>
                <label for="now_pw">현재 비밀번호</label>
                <input type="password" name="now_pw" id="now_pw" placeholder="현재 비밀번호를 확인해 주세요." required />
            </div>


	        <div class="imf-btn">
	        	<button type="submit" class="submit">저장하기</button>
	        	<button type="button" class="exit" data-toggle="modal" data-target="#member-exit">회원 탈퇴</button>
	        </div>
        </div>
    </fieldset>
    </form>


</div>    



<!-- 회원 탈퇴 Modal // START -->
<div class="modal" id="member-exit" tabindex="-1" aria-labelledby="FindDateLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title"></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body text-center pt-4 pb-5">
            	<p>${dto.member_name} 회원님,</p>
            	<p>&nbsp;</p>
            	<p>회원 탈퇴 시 예약 및 구매 내역을 더 이상 확인 할 수 없으며,</p>
            	<p>멤버십 혜택이 더 이상 제공되지 않습니다.</p>
            	<p>&nbsp;</p>
            	<p>스테이폴리오와 함께 다녀온 스테이 : ${login_reserv} 곳</p>
            	<p>나의 관심 스테이 : ${login_wish} 곳</p>
            </div>
            <div class="modal-footer">
            	<form method="post" action="<%=request.getContextPath()%>/mypageExitOk.do">
            	<input type="hidden" member_id="${dto.member_id}" />
            	<button type="submit" class="exit">탈퇴하기</button>
            	<button type="button" data-dismiss="modal">취소하기</button>
            	</form>
            </div>
        </div>
    </div>
</div>
<!-- 회원 탈퇴 Modal // END -->



<jsp:include page="../mypage/mypage_footer.jsp" />
<jsp:include page="../layout/layout_footer.jsp" />