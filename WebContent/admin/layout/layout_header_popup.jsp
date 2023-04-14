<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% long time = System.currentTimeMillis(); %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 모드 :: 스테이키 (StayKey)</title>

    <meta http-equiv="CONTENT-TYPE" content="text/html;charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Content-Script-Type" content="text/javascript">
    <meta http-equiv="Content-Style-Type" content="text/css">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=1200">

    <meta name="robots" content="noindex">

    <link rel="shortcut icon" href="<%=request.getContextPath()%>/asset/images/favicon.ico" type="image/x-icon" />
    <link rel="icon" href="<%=request.getContextPath()%>/asset/images/favicon.ico" type="image/x-icon" />
 
    <link rel="shortcut icon" type="image/x-icon" href="<%=request.getContextPath()%>/asset/images/favicon_72x72.png" />
    <link rel="apple-touch-icon-precomposed" sizes="57x57" href="<%=request.getContextPath()%>/asset/images/favicon_57x57.png" />
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="<%=request.getContextPath()%>/asset/images/favicon_72x72.png" />
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="<%=request.getContextPath()%>/asset/images/favicon_114x114.png" />
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="<%=request.getContextPath()%>/asset/images/favicon_144x144.png" />

    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/admin/asset/css/jquery-ui.min.css" />
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/admin/asset/css/bootstrap-reboot.min.css" />
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/admin/asset/css/bootstrap.min.css" />
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/admin/asset/css/bootstrap-utilities.min.css" />
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/admin/asset/css/bootstrap-grid.min.css" />
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/admin/asset/css/bootstrap-colorpicker.css?<?=$gw_now_time?>" />
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/admin/asset/css/font_awesome.css" />
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/admin/asset/css/simple-line-icons.css" />
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/admin/asset/css/swiper.min.css" />
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/admin/asset/css/bootstrap-tagsinput.css" />
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/admin/asset/css/style.css?<%=time%>" />


    <script language="javascript" src="<%=request.getContextPath()%>/admin/asset/js/jquery-3.5.1.min.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/admin/asset/js/jquery-ui.min.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/admin/asset/js/bootstrap.min.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/admin/asset/js/bootstrap.bundle.min.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/admin/asset/js/bs-custom-file-input.min.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/admin/asset/js/bootstrap-colorpicker.min.js"></script>
    <script src="https://cdn.ckeditor.com/4.16.0/standard-all/ckeditor.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/admin/asset/js/swiper.min.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/admin/asset/js/bootstrap-tagsinput.min.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/admin/asset/js/script.js?<%=time%>"></script>
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



    <!-- #contents // START -->
    <main role="main" class="popup">


