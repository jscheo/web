package model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

public class ProductDAO {
	//상품total 수 출력
	public int total() {
		int total=0;
		try {
			String sql ="select count(*) cnt from products";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				total=rs.getInt("cnt");
			}
		}catch(Exception e) {
			System.out.println("토탈:" + e.toString());
		}
		return total;
	}
	//상품 목록 출력
	public ArrayList<ProductVO> list(int page){
		ArrayList<ProductVO> array =new ArrayList<ProductVO>();
		try {
			String sql ="select * from products order by code desc limit ?, 5";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setInt(1, (page-1)*5);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				ProductVO vo = new ProductVO();
				vo.setCode(rs.getInt("code"));
				vo.setName(rs.getString("name"));
				vo.setPrice(rs.getInt("price"));
				vo.setRdate(rs.getTimestamp("rdate"));
				array.add(vo);
			}
		}catch(Exception e) {
			System.out.println("상품목록:" + e.toString());
		}
		return array;
	}
}
