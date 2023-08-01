package model;

import java.util.ArrayList;

public class DAOTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		StuDAO dao= new StuDAO();
		ArrayList<StuVO> array = dao.list(1, "이병렬", "pname");
		for(StuVO vo:array) {
			System.out.println(vo.toString());
		}
		System.out.println("검색수:" + dao.total("4", "year"));
	}

}
