package com.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.lang.reflect.Constructor;
import java.net.URLDecoder;
import java.util.Enumeration;
import java.util.Properties;
import java.util.StringTokenizer;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class FrontController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // 한글 인코딩 처리
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");


        String uri = request.getRequestURI();
        String command = uri.replace(request.getContextPath()+"/", "");


        // 콘솔 표시 정보
        String show_page = command;
        String show_user = null;
        Enumeration getFormData = request.getParameterNames(); // 폼 데이터


        // 로그인 세션 가져오기
        HttpSession session = request.getSession();
        String login_name = (String)session.getAttribute("login_name");
        String login_id = (String)session.getAttribute("login_id");

        if(login_id != null){
            show_user = login_name + " ( "+login_id+" )";
        }else{
            show_user = "Guest";
        }


        // 페이지 정리
        if(command.contains("admin/")){
            show_page = command.replace("admin/", "관리자 ( ") + " )";
        }else{
            show_page = "사이트 ( " + command + " )";
        }


        System.out.println("| ----------------------------------------------------------------------------- |");
        System.out.println("| * 접속자 =>>> " + show_user);
        System.out.println("| * 페이지 =>>> " + show_page);
        if(getFormData != null && !command.equals("memberLoginOk.do") && !command.equals("memberFindIdPwOk.do") && !command.equals("memberJoinOk.do")) {
            while(getFormData.hasMoreElements()){
                String formKey = (String) getFormData.nextElement();
                String[] formValues = request.getParameterValues(formKey);     
                for(String formValue : formValues){
                    if(formValue.length() > 0 && formValue != null){
                        System.out.println("|          =>>> " + formKey + " : " + formValue);
                    }
                }   
            }
        }
        System.out.println("| ----------------------------------------------------------------------------- |\n");



        Action action = null;
        ActionForward forward = null;

        Properties pro = new Properties();

        String properties_file = request.getSession().getServletContext().getRealPath("/").replace("WebContent", "src") + "com/controller/mapping.properties";
        // String properties_file = request.getSession().getServletContext().getRealPath("/").replace("WebContent", "src") + "WEB-INF/classes/com/controller/mapping.properties";
        FileInputStream fis = new FileInputStream(properties_file);
        pro.load(fis);


        String value = pro.getProperty(command);

        if(value.substring(0,7).equals("execute")){
            StringTokenizer st = new StringTokenizer(value, "|");
            String url_1 = st.nextToken(); // "execute"
            String url_2 = st.nextToken(); // "패키지명.클래스명"

            try {
                Class<?> url = Class.forName(url_2);

                Constructor<?> constructor = url.getConstructor();
                action = (Action)constructor.newInstance();
                forward = action.execute(request, response);

            } catch(Exception e) {
                e.printStackTrace();
            }

        // value 값이 "execute"가 아닌 경우
        }else{
            forward = new ActionForward();
            forward.setRedirect(false);
            forward.setPath(value);
        }


        if(forward != null) {
            if(forward.isRedirect()) { // true인 경우
                response.sendRedirect(forward.getPath());
            }else{ // false인 경우
                request.getRequestDispatcher(forward.getPath()).forward(request, response);
            }
        }

    }
}
