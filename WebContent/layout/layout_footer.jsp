<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
    </main>
    <!-- #container //END -->




    <!-- footer //START -->
    <footer class="footer">
    	<div class="f-wrap">
			<h3 class="fw-logo"><img src= "<%=request.getContextPath()%>/asset/images/staykey_logo.png" alt="Stay Key" ></h3>

			<div class="fw-cs">
				<h4>고객센터</h4>
				<p>운영시간: 10:00 ~ 18:00<small>(점심시간: 12:30 ~ 13:30)</small></p>
				<ul>
					<li><a href="<%=request.getContextPath()%>/mypageQnaWrite.do">1:1문의</a></li>
					<li><a href="#">입점 문의</a></li>
					<li><a href="#">제휴 문의</a></li>
				</ul>
			</div>

			<div class="fw-info">
				<div class="fwi-txt">
					<span>(주)스테이:키</span>
					<span><strong>KH 3조</strong></span>
					<span>서울특별시 중구 남대문로 120 대일빌딩 2F, 3F</span>
					<span>TEL: 1670-0000</span>
					<span>EMAIL:help@staykey.com</span><br />
					<span>사업자등록번호: 000-00-12345</span>
					<span>통신판매업신고 : 제2022-서울중구-0000호</span>
					<span>관광사업자등록 : 일반여행업 2022-12345호(중구청)</span>
				</div>
				<div class="fwi-copy">Copyright &copy; 2022 All rights reserved.<c:if test="${login_type == 'admin'}"> &nbsp;&nbsp;&nbsp;&nbsp;<a href="<%=request.getContextPath()%>/admin/" target="_blank">관리자</a></c:if></div>
			</div>
		</div>
   </footer>
    <!-- footer //END -->


	<button class="goto-top" onclick="gotoTop();"><i class="fa fa-angle-up"></i></button>
</body>
</html>