package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import java.util.*;
import model.*;

@WebServlet(value={"/cou/list", "/cou/total", "/cou/list.json"})
public class CoursesController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    CouDAO dao = new CouDAO();   
  
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		RequestDispatcher dis= request.getRequestDispatcher("/home.jsp");
		
		switch(request.getServletPath()) {
		case "/cou/list":
			request.setAttribute("pageName", "/cou/list.jsp");
			dis.forward(request, response);
			break;
		case "/cou/total": // /cou/total?key=pname&query=이
			String key = request.getParameter("key");
			String query = request.getParameter("query");
			out.print(dao.total(key, query));
			break;
		case "/cou/list.json":// /cou/list.json?key=pname&query=이&page=1
			int page=Integer.parseInt(request.getParameter("page"));
			key = request.getParameter("key");
			query = request.getParameter("query");
			Gson gson=new Gson();
			out.println(gson.toJson(dao.list(page, key, query)));
			break;
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
