package model;

import java.util.ArrayList;

public class DAOTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		ProDAO dao=new ProDAO();
//		ProVO vo =new ProVO();
//		vo.setPname("홍길동");
//		vo.setDept("컴정");
//		vo.setTitle("정교수");
//		vo.setHiredate("2023-08-02");
//		dao.insert(vo);
		System.out.println(dao.read("221").toString());
	}

}
