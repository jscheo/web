package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.LocalDAO;
import model.LocalVO;


@WebServlet(value={"/local/list", "/local/insert"})
public class LocalController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	LocalDAO dao = new LocalDAO();
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setAttribute("pageName", "/local/list.jsp");
		// 무조건 홈으로 보냄
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		dis.forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		switch(request.getServletPath()) {
		case "/local/insert":
			LocalVO vo=new LocalVO();
			vo.setLid(request.getParameter("lid"));
			vo.setLname(request.getParameter("lname"));
			vo.setLaddress(request.getParameter("laddress"));
			vo.setLphone(request.getParameter("lphone"));
			vo.setLurl(request.getParameter("lurl"));
			vo.setX(request.getParameter("x"));
			vo.setY(request.getParameter("y"));
			dao.insert(vo);
//			System.out.println(vo.toString());
			break;
		}
	}

}
