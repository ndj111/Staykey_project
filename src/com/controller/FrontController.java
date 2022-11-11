package com.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.lang.reflect.Constructor;
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


        // 로그인 세션 가져오기
        HttpSession session = request.getSession();
        String login_name = (String)session.getAttribute("login_name");
        String login_id = (String)session.getAttribute("login_id");


        String uri = request.getRequestURI();
        String command = uri.replace(request.getContextPath()+"/", "");
        System.out.println("\n *** [ " + login_name + "("+login_id+") ] 현재 페이지 =>>> " + command + "\n");


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
