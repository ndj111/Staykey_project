<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% long time = System.currentTimeMillis(); %>
<!DOCTYPE html>
<html class="noscroll">
<head>
    <meta charset="UTF-8">
    <title>스테이키 (StayKey)</title>

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Content-Script-Type" content="text/javascript" />
    <meta http-equiv="Content-Style-Type" content="text/css" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <meta name="robots" content="noindex">

    <link rel="shortcut icon" href="<%=request.getContextPath()%>/asset/images/favicon.ico" type="image/x-icon" />
    <link rel="icon" href="<%=request.getContextPath()%>/asset/images/favicon.ico" type="image/x-icon" />
 
    <link rel="shortcut icon" type="image/x-icon" href="<%=request.getContextPath()%>/asset/images/favicon_72x72.png" />
    <link rel="apple-touch-icon-precomposed" sizes="57x57" href="<%=request.getContextPath()%>/asset/images/favicon_57x57.png" />
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="<%=request.getContextPath()%>/asset/images/favicon_72x72.png" />
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="<%=request.getContextPath()%>/asset/images/favicon_114x114.png" />
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="<%=request.getContextPath()%>/asset/images/favicon_144x144.png" />


    <script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />


    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/asset/css/jquery-ui.min.css" />
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/asset/css/bootstrap.min.css" />
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/asset/css/font_awesome.css" />
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/asset/css/simple-line-icons.css" />
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/asset/css/swiper.min.css" />
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/asset/css/style.css?<%=time%>" />

    <script language="javascript" src="<%=request.getContextPath()%>/asset/js/jquery-ui.min.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/asset/js/bootstrap.min.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/asset/js/swiper.min.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/asset/js/script.js?<%=time%>"></script>
</head>
<body>
    <!-- #ajax-loader //START -->
    <div id="ajax-loader">
        <div class="stripes">
            <div class="rect1"></div>
            <div class="rect2"></div>
            <div class="rect3"></div>
            <div class="rect4"></div>
            <div class="rect5"></div>
        </div>
        <div class="bg"></div>
    </div>
    <!-- #ajax-loader //END -->





    <!-- 어디로 갈까요? 검색 Modal // START -->
    <div class="modal search-modal" id="FindLoc" tabindex="-1" aria-labelledby="FindDateLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">어디로 갈까요?</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form name="loc_search" method="post" action="<%=request.getContextPath()%>/stayList.do">
                    <input type="text" name="ps_stay" placeholder="원하는 스테이/지역을 검색해 보세요." />
                    <ul>
                        <li><a href="<%=request.getContextPath()%>/stayList.do">국내전체</a></li>
                        <li><a href="<%=request.getContextPath()%>/stayList.do?ps_stay=제주">제주</a></li>
                        <li><a href="<%=request.getContextPath()%>/stayList.do?ps_stay=서울">서울</a></li>
                        <li><a href="<%=request.getContextPath()%>/stayList.do?ps_stay=강원">강원</a></li>
                        <li><a href="<%=request.getContextPath()%>/stayList.do?ps_stay=부산">부산</a></li>
                        <li><a href="<%=request.getContextPath()%>/stayList.do?ps_stay=경기">경기</a></li>
                        <li><a href="<%=request.getContextPath()%>/stayList.do?ps_stay=충청">충청</a></li>
                        <li><a href="<%=request.getContextPath()%>/stayList.do?ps_stay=경상">경상</a></li>
                        <li><a href="<%=request.getContextPath()%>/stayList.do?ps_stay=전라">전라</a></li>
                        <li><a href="<%=request.getContextPath()%>/stayList.do?ps_stay=인천">인천</a></li>
                        <li><a href="<%=request.getContextPath()%>/stayList.do?ps_stay=광주">광주</a></li>
                        <li><a href="<%=request.getContextPath()%>/stayList.do?ps_stay=대전">대전</a></li>
                        <li><a href="<%=request.getContextPath()%>/stayList.do?ps_stay=대구">대구</a></li>
                        <li><a href="<%=request.getContextPath()%>/stayList.do?ps_stay=울산">울산</a></li>
                    </ul>
                    <button type="submit">SEARCH <i class="icon-arrow-right"></i></button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- 어디로 갈까요? 검색 Modal // END -->


    <!-- 언제 떠날까요? 검색 Modal // START -->
    <div class="modal search-modal" id="FindDate" tabindex="-1" aria-labelledby="FindDateLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">언제 떠날까요?</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form name="date_search" method="post" action="<%=request.getContextPath()%>/stayList.do">
                    <input type="text" id="hidden-btn" />
                    <input type="hidden" name="ps_start" value="${ map.ps_start }" id="h_ps_start" />
                    <input type="hidden" name="ps_end" value="${ map.ps_end }" id="h_ps_end" />
                    <button type="submit">SEARCH <i class="icon-arrow-right"></i></button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- 언제 떠날까요? 검색 Modal // END -->




    <!-- header //START -->
    <header class="header">
        <div class="h-wrap">
            <div class="h-logo flex-grow-1">
                <h2><a href="<%=request.getContextPath()%>"><img src="<%=request.getContextPath()%>/asset/images/staykey_logo.png" alt="StayKey" /></a></h2>
            </div>


            <div class="h-location flex-grow-1">
                <button type="button" data-toggle="modal" data-target="#FindLoc"><i class="icon-location-pin"></i>어디로 갈까요?</button>
                <button type="button" data-toggle="modal" data-target="#FindDate" onclick="$('#hidden-btn').trigger('click');"><i class="icon-calendar"></i>언제 떠날까요?</button>
            </div>


            <div class="h-gnb">
                <div class="h-nav">
                    <ul class="h-menu">
                        <li><a href="<%=request.getContextPath()%>/stayList.do" id="nav-stay">살펴보기</a></li>
                        <li><a href="<%=request.getContextPath()%>/eventList.do" id="nav-event">함께하기</a></li>
                        <li><a href="<%=request.getContextPath()%>/magazineList.do" id="nav-magazine">읽어보기</a></li>
                    </ul>
                </div>

                <div class="menu-etc">
                    <c:choose>
                        <c:when test="${!empty login_id}">
                        <a href="<%=request.getContextPath()%>/mypageReservList.do" class="mypage-link">MyPage</a>
                        <ul class="mypage-menu">
                            <li><a href="<%=request.getContextPath()%>/mypageReservList.do">예약 정보</a></li>
                            <li><a href="<%=request.getContextPath()%>/mypageWish.do">관심 스테이</a></li>
                            <li><a href="<%=request.getContextPath()%>/mypageQnaList.do">1:1 문의</a></li>
                            <li><a href="<%=request.getContextPath()%>/mypageInfo.do">회원정보 수정</a></li>
                        </ul>
                        <a href="<%=request.getContextPath()%>/memberLogout.do" onClick="return confirm('로그아웃 하시겠습니까?');">LogOut</a>
                        </c:when>
                        <c:otherwise>
                        <a href="<%=request.getContextPath()%>/memberLogin.do">Log-in</a>
                        <a href="<%=request.getContextPath()%>/memberJoin.do">Join</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </header>
    <!-- header //END -->



    <!-- #container //START -->
    <main role="main" id="container">


