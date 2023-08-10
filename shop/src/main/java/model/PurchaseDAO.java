package model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

public class PurchaseDAO {
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	//구매목록
	public ArrayList<PurchaseVO> list(String key, String query, int page){
		ArrayList<PurchaseVO> array =new ArrayList<>();
		try {
			String sql="select * from view_purchase where " + key + " like ? order by purDate desc limit ?,5";
			PreparedStatement ps =Database.CON.prepareStatement(sql);
			ps.setString(1, "%" + query + "%");
			ps.setInt(2, (page-1)*5);
			ResultSet rs =ps.executeQuery();
			while(rs.next()) {
				PurchaseVO vo= new PurchaseVO();
				vo.setPid(rs.getString("pid"));
				vo.setUid(rs.getString("uid"));
				vo.setUname(rs.getString("uname"));
				vo.setAddress1(rs.getString("raddress1"));
				vo.setAddress2(rs.getString("raddress2"));
				vo.setUphone(rs.getString("rphone"));
				vo.setPurDate(sdf.format(rs.getTimestamp("purdate")));
				vo.setStatus(rs.getInt("status"));
				vo.setPurSum(rs.getInt("pursum"));
				array.add(vo);
			}
		}catch(Exception e) {
			System.out.println("구매목록:" + e.toString());
		}
		return array;
	}
	//주문상품등록
	public void insert(OrderVO vo) {
		try {
			String sql="insert into orders(pid, gid, price, qnt) values(?,?,?,?)";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getPid());
			ps.setString(2, vo.getGid());
			ps.setInt(3, vo.getPrice());
			ps.setInt(4, vo.getQnt());
			ps.execute();
		}catch(Exception e) {
			System.out.println("주문상품등록:" +e.toString());
		}
	}
	//구매(주문)등록
	public void insert(PurchaseVO vo) {
		try {
			String sql="insert into purchase(pid, uid, raddress1, raddress2, rphone, purSum) values(?,?,?,?,?,?)";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getPid());
			ps.setString(2, vo.getUid());
			ps.setString(3, vo.getAddress1());
			ps.setString(4, vo.getAddress2());
			ps.setString(5, vo.getUphone());
			ps.setInt(6, vo.getPurSum());
			ps.execute();
		}catch(Exception e) {
			System.out.println("구매등록:" +e.toString());
		}
	}
}
