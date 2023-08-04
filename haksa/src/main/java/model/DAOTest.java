package model;

import java.util.ArrayList;

public class DAOTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		StuDAO dao= new StuDAO();
		ArrayList<EnrollVO> array= dao.list("92514023");
		for(EnrollVO vo:array) {
			System.out.println(vo.toString());
		}
	}

}
