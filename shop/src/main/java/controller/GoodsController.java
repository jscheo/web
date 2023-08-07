package controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.URL;
import java.util.UUID;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import model.GoodsDAO;
import model.GoodsVO;
import model.NaverAPI;


@WebServlet(value={"/goods/search","/goods/search.json","/goods/append", "/goods/list.json", "/goods/total", "/goods/list", "/goods/delete"})
public class GoodsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    GoodsDAO gdao=new GoodsDAO(); 
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		RequestDispatcher dis=request.getRequestDispatcher("/home.jsp");
		
		switch(request.getServletPath()) {
		case "/goods/search":
			request.setAttribute("pageName", "/goods/search.jsp");
			dis.forward(request, response);
			break;
		case "/goods/search.json": //실행: /goods/search.json?page=1&query=한빛미디어
			int page=Integer.parseInt(request.getParameter("page"));
			String query=request.getParameter("query");
			String result=NaverAPI.search(page, query);
			out.println(result);
			break;
		case "/goods/list.json":// /goods/list.json?page=1&query=
			page = Integer.parseInt(request.getParameter("page"));
			query = request.getParameter("query");
			Gson gson = new Gson();
			out.print(gson.toJson(gdao.list(page, query)));
			break;
		case "/goods/total":
			query =request.getParameter("query");
			out.print(gdao.total(query));
			break;
		case "/goods/list":
			request.setAttribute("pageName", "/goods/list.jsp");
			dis.forward(request, response);
			break;
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String path="/upload/goods/";
		switch(request.getServletPath()) {
		case "/goods/append":
			InputStream is=null;
			FileOutputStream fos=null;
			try {
				URL url=new URL(request.getParameter("image"));
				is=url.openStream();
				
				UUID uuid=UUID.randomUUID();
				String gid=uuid.toString().substring(0,8);
				String fileName = gid + ".jpg";
				fos=new FileOutputStream("c:/" + path + fileName);
				int data=0;
				while((data=is.read()) != -1) {
					fos.write(data);
				}
				
				GoodsVO vo=new GoodsVO();
				vo.setGid(gid);
				vo.setTitle(request.getParameter("title"));
				vo.setMaker(request.getParameter("maker"));
				vo.setPrice(Integer.parseInt(request.getParameter("lprice")));
				vo.setImage(path + fileName);
				//System.out.println(vo.toString());
				gdao.insert(vo);
			}catch(Exception e) {
				System.out.println("상품이미지저장:" + e.toString());
			}
			break;
		case "/goods/delete":
			try {
				String gid =request.getParameter("gid");
				String image =request.getParameter("image");
				File file=new File("c:/" + image);
				file.delete(); //이미지파일삭제
				gdao.delete(gid); //데이터삭제
			}catch(Exception e) {
				System.out.println("삭제오류:" +e.toString());
			}
			break;
		}
	}

}