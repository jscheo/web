package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// 서블릿 중복되면 안됨!!
@WebServlet("/")
public class HomeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
// 리퀘스트 디스패치로 dis변수 설정하고 home.jsp라는 주소를 요청하여 dis에 넣어주고 dis.foward로 실행
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dis=request.getRequestDispatcher("home.jsp");
		dis.forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("/ dohost....");
	}

}
