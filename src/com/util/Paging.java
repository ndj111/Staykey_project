package com.util;

public class Paging {
    public static String showPage(int allPage, int startBlock, int endBlock, int page, String reqUrl) {
        // allPage = 총 페이지 갯수, startBlock = 시작 블럭, endBlock = 끝 블럭, page = 현재 페이지, reqUrl = 링크 URL

        if(reqUrl.indexOf("?") <= 0) reqUrl = "?";


        String pagingStr = "<div class=\"page-paging\">";

        if(startBlock > 1) {
            pagingStr += "<span><a href=\""+reqUrl+"&page=1\"><i class=\"fa fa-angle-double-left\"></i></a></span>";
        }else{
            pagingStr += "<span class=\"nolink\"><i class=\"fa fa-angle-double-left\"></i></span>";
        }

        if(page > 1){
            pagingStr += "<span><a href=\""+reqUrl+"&page="+(page - 1)+"\"><i class=\"fa fa-angle-left\"></i></a></span>";
        }else{
            pagingStr += "<span class=\"nolink\"><i class=\"fa fa-angle-left\"></i></span>";
        }

        pagingStr += "<ol>";
        for(int i=startBlock; i<=endBlock; i++){
            if(i == page){
                pagingStr += "<li class=\"now\">"+i+"</li>";
            }else{
                pagingStr += "<li><a href=\""+reqUrl+"&page="+i+"\">"+i+"</a></li>";
            }
        }
        pagingStr += "</ol>";

        if(page < allPage){
            pagingStr += "<span><a href=\""+reqUrl+"&page="+(page + 1)+"\"><i class=\"fa fa-angle-right\"></i></a></span>";
        }else{
            pagingStr += "<span class=\"nolink\"><i class=\"fa fa-angle-right\"></i></span>";
        }

        if(endBlock < allPage){
            pagingStr += "<span><a href=\""+reqUrl+"&page="+allPage+"\"><i class=\"fa fa-angle-double-right\"></i></a></span>";
        }else{
            pagingStr += "<span class=\"nolink\"><i class=\"fa fa-angle-double-right\"></i></span>";
        }

        pagingStr += "</div>";

        if(endBlock > 0){
            return pagingStr;
        }else{
            return "";
        }
    }
}
