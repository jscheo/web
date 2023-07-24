package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
// value로 가져올 jsp 명칭을 제시해준다. 여러개를 할 때에는 ,로 표현 중복되면 안됨
// 가져오는 이름의 시작점과 불러오는 곳의 위치를 동일하게 해야한다.
@WebServlet(value={"/pro/list", "/pro/insert"})
public class ProductController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//두개 같이 쓰기위해 설정해주고 값은 null로 준다.
		RequestDispatcher dis=null;
		switch(request.getServletPath()) {
		case "/pro/list":
			dis=request.getRequestDispatcher("list.jsp");
			break;
		case "/pro/insert":
			dis=request.getRequestDispatcher("insert.jsp");
			break;
		}
		//각 케이스에 걸린 후에 실행되도록 한다.
		dis.forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	
	}

}
