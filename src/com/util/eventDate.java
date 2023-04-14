package com.util;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class eventDate {
    public static String remainDate(String start_date, String end_date) {
        String result = null;

        if(start_date != null && start_date != null) {
            try {

                // 현재 날짜
                Date get_today = new Date();
                DateFormat todayFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

                // String 타입으로 날짜 정리
                String show_today = todayFormat.format(get_today);
                String show_start = start_date;
                String show_end = end_date;

                // Date 타입으로 날짜 정리
                DateFormat chkFormat = new SimpleDateFormat("yyyyMMddHHmmss");
                Date c_today = chkFormat.parse(show_today.replace("-", "").replace(" ", "").replace(":", ""));
                Date c_start = chkFormat.parse(show_start.replace("-", "").replace(" ", "").replace(":", ""));
                Date c_end = chkFormat.parse(show_end.replace("-", "").replace(" ", "").replace(":", ""));


                // 이벤트 시작일 보다 현재시간이 크거나 같고, 현재시간이 이벤트 종료일보다 적거나 같을 때
                if(c_today.compareTo(c_start) > 0 && c_end.compareTo(c_today) > 0){
                    int remain_day = 0;

                    DateFormat calcFormat = new SimpleDateFormat("yyyyMMdd");
                    Date cal_end_date = calcFormat.parse(show_end.substring(0, 10).replace("-", ""));
                    Date cal_today_date = calcFormat.parse(show_today.substring(0, 10).replace("-", ""));
                    remain_day = (int)(((cal_end_date.getTime() - cal_today_date.getTime()) / 1000) / (24*60*60));

                    result = remain_day+"";
                
                }else{
                    result = "N";
                }


            } catch(Exception e) {
                e.printStackTrace();
            }
        }

        return result;
    }
}
