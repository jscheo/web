package model;

import java.util.*;

public class DAOTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		ProductDAO dao=new ProductDAO();
		ArrayList<ProductVO> array= dao.list(3);
		System.out.println(dao.total());
		}
	

}
