package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import model.*;

import java.util.*;

@WebServlet(value={"/pro/list", "/pro/list.json"})
public class ProductController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    ProductDAO dao=new ProductDAO();
    
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    DecimalFormat df = new DecimalFormat("#,###원");
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter(); //json데이터를 출력하기 위해서 브라우저를 생성"
		RequestDispatcher dis=request.getRequestDispatcher("/home.jsp");
		
		switch(request.getServletPath()) {
		case "/pro/list":
			request.setAttribute("pageName", "/pro/list.jsp");
			dis.forward(request, response);
			break;
		case "/pro/list.json":
			//페이지를 주지 않아도 기본값이 1페이지가 출력되도록해서 오류가 나지 않도록 한 문법
			int page=request.getParameter("page")==null ? 1:
			Integer.parseInt(request.getParameter("page"));
			ArrayList<ProductVO> array = dao.list(page);
			
			//ArrayList -> JSONArray로 변경
			JSONArray jArray=new JSONArray();
			for(ProductVO vo:array) {
				JSONObject obj =new JSONObject();
				obj.put("code", vo.getCode());
				obj.put("name", vo.getName());
				obj.put("price", vo.getPrice());
				obj.put("fprice", df.format(vo.getPrice()));
				obj.put("fdate", sdf.format(vo.getRdate()));
				jArray.add(obj);
			}
			
			JSONObject jObject = new JSONObject();
			jObject.put("total", dao.total());
			jObject.put("items", jArray);
			
			out.println(jObject);
			break;
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}

}
