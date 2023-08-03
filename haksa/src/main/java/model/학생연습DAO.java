package model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;
public class 학생연습DAO {
	//학생 검색수
	public int total(String key, String query) {
		int total=0;
		try {
			String sql="select count(*) cnt from view_stu where" + key + " like ? ";
		}catch(Exception e) {
			System.out.println("학생검색수:" + e.toString());
		}
		return total;
	}
	
	//학생목록
	public ArrayList<StuVO> list(int page, String key, String query){
		ArrayList<StuVO> array=new ArrayList<StuVO>();
		try {
			String sql="select * from view_stu ";
					sql+=" where " + key + "like ? ";
					sql+=" limit ?,5";
			PreparedStatement ps =Database.CON.prepareStatement(sql);
			ps.setString(1, "%" + query + "%");
			ps.setInt(2, (page-1)*5);
			ResultSet rs =ps.executeQuery();
			while(rs.next()) {
				StuVO vo = new StuVO();
				vo.setScode(rs.getString("scode"));
				vo.setSname(rs.getString("sname"));
				vo.setDept(rs.getString("dept"));
				vo.setYear(rs.getInt("year"));
				vo.setBirthday(rs.getString("birthday"));
				vo.setAdvisor(rs.getString("advisor"));
				array.add(vo);
			}
					
		}catch(Exception e) {
			System.out.println("학생목록:" + e.toString());
		}
		return array;
	}
}
