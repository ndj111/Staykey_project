<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../layout/layout_header.jsp" />
<jsp:include page="../mypage/mypage_header.jsp" />
<script type="text/javascript">$("#mymenu-qna").addClass("now");</script>



<div class="qna-write">
    <form name="write_form" method="post" enctype="multipart/form-data" action="<%=request.getContextPath() %>/mypageQnaWriteOk.do">
    <table class="table-form">
        <colgroup>
            <col width="16%" />
            <col />
        </colgroup>

        <tr>
            <th>제목</th>
            <td colspan="2">
                <input type="text" name="bbs_title" value="" maxlength="200" class="w-100" required />
            </td>
        </tr>
        <tr>
            <th>내용</th>
            <td colspan="2">
            	<textarea name="bbs_content" cols="80" rows="10" required></textarea>
            </td>
        </tr>

        <tr>
            <td colspan="3" class="space" nowrap="nowrap"></td>
        </tr>

        <tr>
            <th>첨부 파일 #1</th>
            <td colspan="2"><input type="file" name="bbs_file1" /></td>
        </tr>
        <tr>
            <th>첨부 파일 #2</th>
            <td colspan="2"><input type="file" name="bbs_file2" /></td>
        </tr>
    </table>


    <div class="table-btn">
        <button type="button" class="exit" onclick="history.back();">목록보기</button>
        <button type="submit"> 등록하기</button>
    </div>
    </form>

</div>



<jsp:include page="../mypage/mypage_footer.jsp" />
<jsp:include page="../layout/layout_footer.jsp" />