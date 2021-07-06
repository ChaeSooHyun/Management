package home.sold;

import java.sql.*;
import java.util.*;

public class SoldDAO {
	Connection con;
	PreparedStatement ps;
	ResultSet rs;
	String url, user, pass;
	
	private String searchColumn, searchValue;
	
	public String getSearchColumn() {
		return searchColumn;
	}

	public void setSearchColumn(String searchColumn) {
		this.searchColumn = searchColumn;
	}

	public String getSearchValue() {
		return searchValue;
	}

	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}

	public SoldDAO() {
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			url = "jdbc:mariadb://localhost:3306/bigbot";
			user = "bigbot";
			pass = "qlrqht88588588**";
			con = DriverManager.getConnection(url, user, pass);
		} catch (Exception e) {
			System.out.println("에러 발생");
			if(rs!=null)try {rs.close();} catch (Exception e2) {}
			if(ps!=null)try {ps.close();} catch (Exception e2) {}
			if(con!=null)try {con.close();} catch (Exception e2) {}
		}
	}
	
	public int createSold(SoldDTO dto) throws SQLException {
		int res = 0;
		String sql = "insert into T_Sold (menu_id, volume, sold_date) values (?, ?, ?)";
		
		try {
			ps = con.prepareStatement(sql);
			ps.setInt(1, dto.getMenu_id());
			ps.setInt(2, dto.getVolume());
			ps.setString(3, dto.getSold_date());
			res = ps.executeUpdate();
			return res;
		} finally {
			if (ps != null) ps.close();
			if (con != null) con.close();
		}
	}
	
	public ArrayList<SoldDTO> readSold() throws SQLException {
		String sql = "select * from T_Sold order by sold_date";
		try {
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			
			return makeArrayList(rs);
		} finally {
			if (rs != null) rs.close();
			if (ps != null) ps.close();
			if (con != null) con.close();
		}
	}
	
	public ArrayList<SoldDTO> searchSold() throws SQLException {
		try {
			String sql = "";
			ArrayList<Integer> searchValueArr = new ArrayList<Integer>();
			if(searchColumn.equals("menu_id")) {
				sql = "select id from T_Menu where name like ?";
				ps = con.prepareStatement(sql);
				ps.setString(1, "%" + searchValue + "%");				
				rs = ps.executeQuery();
				while(rs.next()) {
					searchValueArr.add(rs.getInt("id"));
				}
			}
			
			sql = "select * from T_Sold where " + searchColumn;
			
			if (searchColumn.equals("sold_date")) {
				sql += " = ? order by sold_date";
				ps = con.prepareStatement(sql);
				ps.setInt(1, Integer.parseInt(searchValue.replace("-", "")));
			} else if (searchColumn.equals("id")) {
				sql += " = ? order by sold_date";
				ps = con.prepareStatement(sql);
				ps.setInt(1, Integer.parseInt(searchValue));				
			} else if (searchColumn.equals("menu_id")) {
				sql += " = ?";
				sql += new String(new char[searchValueArr.size() - 1]).replace("\0", " or menu_id = ?");
				sql += " order by sold_date";
				ps = con.prepareStatement(sql);
				for(int i = 1 ; i <= searchValueArr.size() ; i++) {
					ps.setInt(i, searchValueArr.get(i - 1));									
				}
			} else {
				sql += " like ? order by sold_date";
				ps = con.prepareStatement(sql);
				ps.setString(1, "%" + searchValue + "%");
			}
			
			rs = ps.executeQuery();
			
			return makeArrayList(rs);
		} finally {
			if (rs != null) rs.close();
			if (ps != null) ps.close();
			if (con != null) con.close();
		}
	}
	
	public int updateSold(SoldDTO dto) throws SQLException {
		try {
			String sql = "update T_Sold set menu_id = ?, volume = ?, sold_date = ? where id = ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, dto.getMenu_id());
			ps.setInt(2, dto.getVolume());
			ps.setString(3, dto.getSold_date());
			ps.setInt(4, dto.getId());
			int res = ps.executeUpdate();
			
			return res;
		} finally {
			if (ps != null) ps.close();
			if (con != null) con.close();
		}
	}
	
	public int deleteSold(int id) throws SQLException {
		int res = 0;
		String sql = "delete from T_Sold where id = ?";
		try {
			ps = con.prepareStatement(sql);
			ps.setInt(1, id);
			res = ps.executeUpdate();
			return res;
		} finally {
			if (ps != null) ps.close();
			if (con != null) con.close();
		}
	}
	
	public ArrayList<SoldDTO> makeArrayList(ResultSet rs) throws SQLException {
		ArrayList<SoldDTO> listSold = new ArrayList<SoldDTO>();
		while (rs.next()) {
			SoldDTO dto = new SoldDTO();
			
			dto.setId(rs.getInt("id"));
			dto.setMenu_id(rs.getInt("menu_id"));
			dto.setVolume(rs.getInt("volume"));
			dto.setSold_date(rs.getString("sold_date"));
			
			listSold.add(dto);
		}
		return listSold;
	}
}

