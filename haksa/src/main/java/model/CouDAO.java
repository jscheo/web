package model;

import java.util.*;
import java.sql.*;

public class CouDAO {
	//강좌수
	public int total(String key, String query) {
		int total=0;
		try {
			String 	sql="select count(*) cnt from view_cou ";
					sql+="where " + key + " like ? ";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, "%" + query + "%");
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				total=rs.getInt("cnt");
			}
		}catch(Exception e) {
			System.out.println("강좌수:" + e.toString());
		}
		return total;
	}
	//강좌목록
	public ArrayList<CourseVO> list(int page, String key, String query){
		ArrayList<CourseVO> array = new ArrayList();
		try {
			String 	sql="select * from view_cou ";
					sql+="where " + key + " like ? ";
					sql+="limit ?, 5";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, "%" + query + "%");
			ps.setInt(2, (page-1)*5);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				CourseVO vo= new CourseVO();
				vo.setLcode(rs.getString("lcode"));
				vo.setLname(rs.getString("lname"));
				vo.setHours(rs.getInt("hours"));
				vo.setRoom(rs.getString("room"));
				vo.setInstructor(rs.getString("instructor"));
				vo.setCapacity(rs.getInt("capacity"));
				vo.setPersons(rs.getInt("persons"));
				vo.setPname(rs.getString("pname"));
				array.add(vo);
			}
		}catch(Exception e) {
			System.out.println("강좌목록:" + e.toString());
		}
		return array;
	}
}
